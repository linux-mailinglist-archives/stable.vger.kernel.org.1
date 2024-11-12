Return-Path: <stable+bounces-92660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBD9C5593
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F8C1F21178
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E82185AD;
	Tue, 12 Nov 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tHh/5umg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30D212F1D;
	Tue, 12 Nov 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408170; cv=none; b=p4sQqArBqkwgbkMzJQZRfn0GE5QRRPdxDmgqMbx/4Aj85eGgvNjPFYn5BFyAZFKZgptyl4SiEMviUXy1WuyaqMsWEPE0Fva2DL22sZJSCNHIjpVsb0PFXqmR1wwu8uxGuguqt9cVwZKviQZeWdcn71dNZhIpL75UoYpVvFh022I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408170; c=relaxed/simple;
	bh=CnP/KTIy+tX7exKRa9EVxOA6SdCvuff4Wk/kfq4sYoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8AxKsduOu7hPRuLWkX0LT+lT+sgM2NnXlD8cXG9Vc5SdUEQozr1eZSbkiin6S/mcGliiUJv1bSKbtp/RbHzP47MO4GT/KwZunx6np1R0GedcIqjmf0YCh4ObL5j1FU+nrQ79jYezMJy2erH9MxUOLB9R+qLO2fKqvadh1rcCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tHh/5umg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF160C4CECD;
	Tue, 12 Nov 2024 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408170;
	bh=CnP/KTIy+tX7exKRa9EVxOA6SdCvuff4Wk/kfq4sYoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHh/5umghYR2EmRQKzzWcxjXHxYzcSq0BxWXJfkJotPHbWGwUXQieUKLla8PgFU2h
	 yhY6sgMZoKMt8IUvdTXGqEpfhksNhETql7WnXPh6v72xoXhXfpZJaTGJOPU3BdX4K3
	 6o57SiveigldS8ojn/W0a/I9L0xQWwxAVScUacGs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.11 081/184] media: pulse8-cec: fix data timestamp at pulse8_setup()
Date: Tue, 12 Nov 2024 11:20:39 +0100
Message-ID: <20241112101903.968684081@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit ba9cf6b430433e57bfc8072364e944b7c0eca2a4 upstream.

As pointed by Coverity, there is a hidden overflow condition there.
As date is signed and u8 is unsigned, doing:

	date = (data[0] << 24)

With a value bigger than 07f will make all upper bits of date
0xffffffff. This can be demonstrated with this small code:

<code>
typedef int64_t time64_t;
typedef uint8_t u8;

int main(void)
{
	u8 data[] = { 0xde ,0xad , 0xbe, 0xef };
	time64_t date;

	date = (data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
	printf("Invalid data = 0x%08lx\n", date);

	date = ((unsigned)data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
	printf("Expected data = 0x%08lx\n", date);

	return 0;
}
</code>

Fix it by converting the upper bit calculation to unsigned.

Fixes: cea28e7a55e7 ("media: pulse8-cec: reorganize function order")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/cec/usb/pulse8/pulse8-cec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/cec/usb/pulse8/pulse8-cec.c
+++ b/drivers/media/cec/usb/pulse8/pulse8-cec.c
@@ -685,7 +685,7 @@ static int pulse8_setup(struct pulse8 *p
 	err = pulse8_send_and_wait(pulse8, cmd, 1, cmd[0], 4);
 	if (err)
 		return err;
-	date = (data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
+	date = ((unsigned)data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
 	dev_info(pulse8->dev, "Firmware build date %ptT\n", &date);
 
 	dev_dbg(pulse8->dev, "Persistent config:\n");



