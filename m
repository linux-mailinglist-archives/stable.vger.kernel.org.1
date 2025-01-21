Return-Path: <stable+bounces-109972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D1A18504
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F287A695C
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C71F7919;
	Tue, 21 Jan 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TPzmVLEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6371F76D8;
	Tue, 21 Jan 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482971; cv=none; b=jfigdcEwxbLeAG7QzTWMCOFbHf8ax/1kBHgzh+txKby11AuXP9tzm2RAV7ENuDUZa90KGbLjR+7GHMvrjlE6rtptMHeZyVaKFC7ochuufUbprzBU798f/yfkzzB/3B3J/KaK12GL4LORL0bfvocJGMQcVG3glZqTBC5UheOgSow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482971; c=relaxed/simple;
	bh=DMgKNrFEiihWmEivZOdGcM/5Wy17FKsqMA4WpTs8AsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaazaKIqNdXk/87CzbgFOUVxgXr1piHNrnz+uZweryy/PLNYBlwVDS21Ov0Rm6THsESWHb7wTBLzSBFT7W8Ddji3FaKhOwLqiw+6vgf11cdDSwrLxJ8isUurlXR1N3sy0JhKU5LwgXocwe1e9RddgqdEyzrmR4zpFN+R1r+QI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TPzmVLEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F3C4CEDF;
	Tue, 21 Jan 2025 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482970;
	bh=DMgKNrFEiihWmEivZOdGcM/5Wy17FKsqMA4WpTs8AsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPzmVLEwQXZ/bCZOh6lSBbhknwTdINqe0cD4YQK4bsfqxPBSBFHAX/zYNhg4Gx7Dc
	 mcT6DgHVaEqLOkPmDT777/y/9emF1CRA1wchDErjLMyQY6/ZwTTGB4jjLek52RhyRV
	 XAFM85qcQA4l4wVbjQrmxyVK3kwrTQa8FBSysfVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zicheng Qu <quzicheng@huawei.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 041/127] staging: iio: ad9834: Correct phase range check
Date: Tue, 21 Jan 2025 18:51:53 +0100
Message-ID: <20250121174531.261321301@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Zicheng Qu <quzicheng@huawei.com>

commit c0599762f0c7e260b99c6b7bceb8eae69b804c94 upstream.

User Perspective:
When a user sets the phase value, the ad9834_write_phase() is called.
The phase register has a 12-bit resolution, so the valid range is 0 to
4095. If the phase offset value of 4096 is input, it effectively exactly
equals 0 in the lower 12 bits, meaning no offset.

Reasons for the Change:
1) Original Condition (phase > BIT(AD9834_PHASE_BITS)):
This condition allows a phase value equal to 2^12, which is 4096.
However, this value exceeds the valid 12-bit range, as the maximum valid
phase value should be 4095.
2) Modified Condition (phase >= BIT(AD9834_PHASE_BITS)):
Ensures that the phase value is within the valid range, preventing
invalid datafrom being written.

Impact on Subsequent Logic: st->data = cpu_to_be16(addr | phase):
If the phase value is 2^12, i.e., 4096 (0001 0000 0000 0000), and addr
is AD9834_REG_PHASE0 (1100 0000 0000 0000), then addr | phase results in
1101 0000 0000 0000, occupying DB12. According to the section of WRITING
TO A PHASE REGISTER in the datasheet, the MSB 12 PHASE0 bits should be
DB11. The original condition leads to incorrect DB12 usage, which
contradicts the datasheet and could pose potential issues for future
updates if DB12 is used in such related cases.

Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20241107011015.2472600-2-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/iio/frequency/ad9834.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -131,7 +131,7 @@ static int ad9834_write_frequency(struct
 static int ad9834_write_phase(struct ad9834_state *st,
 			      unsigned long addr, unsigned long phase)
 {
-	if (phase > BIT(AD9834_PHASE_BITS))
+	if (phase >= BIT(AD9834_PHASE_BITS))
 		return -EINVAL;
 	st->data = cpu_to_be16(addr | phase);
 



