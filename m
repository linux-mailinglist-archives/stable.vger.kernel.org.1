Return-Path: <stable+bounces-72858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7850696A8A3
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD5A1C23217
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983461DB53D;
	Tue,  3 Sep 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5ylSTtY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE81DB526;
	Tue,  3 Sep 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396131; cv=none; b=CNZ03wfoELapk4utfICDCgM9G+vsKc+HC6z3du3PMPn1KMa35n6JvK5HHk8tzTUuc7GmKQCEoIiEchdc/r/JGrTk/hP4g7bFZlmIDVE2qGll/Xf9V4HAq0+Xo+EcARju8LS7WGNXcHUx0nUmCvtX/9cOQ54ogE0zlTNa8V8GmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396131; c=relaxed/simple;
	bh=uryOFNpZ/vesOocpDLOmDplPF/eXwt5EPHDAqjAN6h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsathVYKCQ1Eh3LBUrRKA/Txf2uQ4IRiWpbr82lVUf6HVAk0Sl6mpjs8fC0WkuzF/8s+HpjqADDTDimpLvSwejPFY9hE4uKuh5mGkXNmkKHon3/HZ43tjcOeBwgceVOVmekhMF+TY9hhW/phdw4t4Bw6U4mjV/B+4JRncwjJhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5ylSTtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBF8C4AF09;
	Tue,  3 Sep 2024 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396129;
	bh=uryOFNpZ/vesOocpDLOmDplPF/eXwt5EPHDAqjAN6h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5ylSTtYG47Eu+gig6T2gBjzqxmsZjLnNZXH11ROTO9/YDujKTJVaCZFnwmaGV/C/
	 /+DBJ2S8+eJTWv6YytjwelI48wAMIQMytc9TxCn268A7CIN0ILBLHSlqGERllZCYAX
	 CK1rFKifG97wTg0gh9x7EkWu3v489JTqHdDlESmyoKdZDatvx1XsfnWnCbRdTpp9iK
	 sE/uNs0WOJuST0eVMf9zXMuCEbTBWxHEARC5y1RWItTCR1668IikiFE4CAlYikL/hY
	 eHrDj33V5t1LKK/OilxymcCRxVZZ04bll5f4q+s1YYZ033jSLnnG5n72ybNaSU7fc+
	 0zNwrkt9z06Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	emil.velikov@collabora.com,
	cristian.ciocaltea@collabora.com,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 04/22] ASoC: allow module autoloading for table board_ids
Date: Tue,  3 Sep 2024 15:21:51 -0400
Message-ID: <20240903192243.1107016-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 5f7c98b7519a3a847d9182bd99d57ea250032ca1 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-3-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-sof-mach.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index fc59ea34e687a..b3a702dcd9911 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -158,6 +158,8 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
+
 static struct platform_driver acp_asoc_audio = {
 	.driver = {
 		.name = "sof_mach",
-- 
2.43.0


