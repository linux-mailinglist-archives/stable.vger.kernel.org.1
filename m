Return-Path: <stable+bounces-80970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5E990D5F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26331C20D5D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4AB209694;
	Fri,  4 Oct 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQiCRbsz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC152209690;
	Fri,  4 Oct 2024 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066383; cv=none; b=RSJxx8xPZ7B+GZXp7MHLawrUCR9/nuSQtQODyCPhfqEUP+JOJmHVq3eQytH4kl/G6dYpBDzQ6uiD6jJ2I5+pMnGWHn5ClBJz0vHz5jOYSjLjeS55eTOwJOm6AgFKMaSXlYV0W1RWHczKmJg+er24OBtBJcFWM+PInDW/Ptc3Z4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066383; c=relaxed/simple;
	bh=FEr6mMq7J4msZ4yB+YFTNrkNfNp+VgGlsUzxwil8hDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCCKpGtUxlU52lz9/roUUdDO2xKkunosFepyyaQQZeJ/6TC2Ddkt9l9XAU7wxaOPjN1e6IoVeYMQ/n5BPwiOmizBobHyvvrfDMRAguzEWUgmAW4RLRmLPqmkJf1gz/L4jdoCThY/qg4eAmq8agLmMFQELaQe7rH9iUB75pSsczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQiCRbsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D83C4CECC;
	Fri,  4 Oct 2024 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066383;
	bh=FEr6mMq7J4msZ4yB+YFTNrkNfNp+VgGlsUzxwil8hDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQiCRbszizI2ZNsN4lo3dV9jzZh44YhDT+UjFRZW+NPJHGp2pEU+PeJ6FlPNdehyA
	 SG07vq4ImttIWIhkTL1vzQ83g7WsbhdMu6tglqljiSZAYfmmEB6DWyuUXWVYaT0yvM
	 XxYGWoh9/0InmaIvw/FfxprS5K62i/GV0ic+TKlkzGUskEp+8N7eYM5L473TThCl9q
	 9maX0o2ygwfzuCABbpyH6r2AkF+KdFdIzdpgIqXBIwaYi0gOPdG/wm6o69BXYVrfN9
	 WHYFUMeRz+qssnm8RytWQndC1JdMLmlSpJykESdjx5xiGdkzJJG3p0IcrwXErJzt5G
	 i2x982KgekO/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Subject: [PATCH AUTOSEL 6.6 44/58] comedi: ni_routing: tools: Check when the file could not be opened
Date: Fri,  4 Oct 2024 14:24:17 -0400
Message-ID: <20241004182503.3672477-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>

[ Upstream commit 5baeb157b341b1d26a5815aeaa4d3bb9e0444fda ]

- After fopen check NULL before using the file pointer use

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
Link: https://lore.kernel.org/r/20240906203025.89588-1-RuffaloLavoisier@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb2..892a66b2cea66 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -140,6 +140,11 @@ int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
 
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
+
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
 	for (int i = 0; ni_all_route_values[i]; ++i)
-- 
2.43.0


