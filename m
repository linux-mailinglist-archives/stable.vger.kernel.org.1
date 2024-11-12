Return-Path: <stable+bounces-92252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2129C54F3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3ACEB26C6A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550021314D;
	Tue, 12 Nov 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jy+MIrlk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293D19E992;
	Tue, 12 Nov 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407048; cv=none; b=H5iTPtqU4IMEtkWtxNmdHRvjuDsRw0/euxVP7SIqN+JqsYOaxa5Qpk7ciKpIE9htzEa3kh7o42jFw2RvXoa+BI0PWVjJdTLqhpc622W5GmRrt/zyPPwF9hHd10CoHBm0WYyRkL3bNGez70sWcTnd2wwL4LAraGnhc2J17bdoRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407048; c=relaxed/simple;
	bh=j41aaste0jWHZxPhnKqGnsTe3ZPTvAi1LaIE2s8xIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8gI/i9XxosmofzsIrHRmrbxNymmPdv5Cp15izCtu3JH1lo28LndGKKNEk/zpuT0zQ9F0/cShCNAYMIdV7lSpN2Dr8PQB/MDMkjdK3htj/h039bd+28Eq7mjGS5aX1yKIRs0aolo+Kl5JfJp8sXekphsoo6fxZcDvzcHxZtALvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jy+MIrlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F98C4CECD;
	Tue, 12 Nov 2024 10:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407048;
	bh=j41aaste0jWHZxPhnKqGnsTe3ZPTvAi1LaIE2s8xIUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jy+MIrlkq911kQe5mfU2N37tWi88FAl7ELkWbB/fMm+gQ5kwCGJG8VMtQoyWPUF23
	 sMho7PXWon64n35//rqu1y/fAu/R4Ofd1ibPpBujNKGgJgTBzIxwkvDsbj7s72yHa1
	 suSw3XVNOh9+PhlzuT1WOxS8XAZDaXUjdaswFmTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.15 35/76] media: pulse8-cec: fix data timestamp at pulse8_setup()
Date: Tue, 12 Nov 2024 11:21:00 +0100
Message-ID: <20241112101841.123786382@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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



