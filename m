Return-Path: <stable+bounces-92555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EE9C5504
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B523289907
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAB2332BA;
	Tue, 12 Nov 2024 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjTxI1HN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13C2332B2;
	Tue, 12 Nov 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407879; cv=none; b=iDSozJ51OVydIS3C3V2ljKwkd5ustk3gBWJV7JQBbHZz+oe+w8W+mZG8fVs2gCfWc0Ckad7adAnTJTDsLTcXwQATTSzrx/jJTH/cBzKl4fgr1RxgLLjwOkmeekYWJOaS7KDDzwhf8i5og92F429KZrx1sG0IcGr0Cr+k/9Rha9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407879; c=relaxed/simple;
	bh=LiQ12F5R1GqYjuk7X375S1/5n3F8xOsLGwoE1RiT1V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOz2cC9kI8yszfqECKARaEbqq4o/YldntZz0XrMrebEAN7RzIOQ9B4LUxW1SsMjN6708LS7c5S+PzLfqWk9dXr3DJXEkPXRDTp2q5F1pWmRCYgee5pBnZ4lujHMyiGHXQgz6loE1Abn3La6P0Y+FEBGspJAU9SDcsNAavwTZb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjTxI1HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEADDC4CED7;
	Tue, 12 Nov 2024 10:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407879;
	bh=LiQ12F5R1GqYjuk7X375S1/5n3F8xOsLGwoE1RiT1V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjTxI1HNoQRi9hBYKP8OQf1Ev7+PJRHsMrDoLv2fWLivlX2KhEAr1KzEt2P9Y94r2
	 YhbELZIFsqivPoAPOM7vdApDyzKxGhekJK0uMMnlff4YZWWPMu3EfDdOWDElySBlJ2
	 6B21uR9cGXhOPoGdy3DmMQt8T9mi6Eg2BZQjR8CGRxatDwvrp03+FcvCjAu4BDRDTe
	 zCts9HmuShwKlEvCksNsROPzrHFiINOYU3Feyhz+ml+1r1KbkORDSTCntEvntqTmTz
	 b9IAF7SEo1AJFVjm94LyttceZsbPfrqdqSQxXj9GE9ZK5nDEHfH00UmrLNOvUUJsuu
	 zosUfDABllMCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 7/8] ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()
Date: Tue, 12 Nov 2024 05:37:41 -0500
Message-ID: <20241112103745.1653994-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103745.1653994-1-sashal@kernel.org>
References: <20241112103745.1653994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.171
Content-Transfer-Encoding: 8bit

From: Luo Yifan <luoyifan@cmss.chinamobile.com>

[ Upstream commit 23569c8b314925bdb70dd1a7b63cfe6100868315 ]

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20241107015936.211902-1-luoyifan@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index aa9cdd93b5778..d71b4aecd269f 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -319,7 +319,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 	int div;
 
 	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
-	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+	if (div > SAI_XCR1_MCKDIV_MAX(version) || div <= 0) {
 		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
 		return -EINVAL;
 	}
-- 
2.43.0


