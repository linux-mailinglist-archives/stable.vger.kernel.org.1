Return-Path: <stable+bounces-75694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A736973F8B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB09B20D70
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B4D1BA88A;
	Tue, 10 Sep 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP8h3BWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F71BA87A;
	Tue, 10 Sep 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988992; cv=none; b=ZfTqNnyuIi618QkJ6eBL9YbJpQLu4XdXlYFRoGgOcU5vQYC2SRNWLQgY4St3vA/wd7vF/9/o6zsPt3kRfp8RdEN8FQ4fanl05LMnci/mYyZsGXaLFRSainEnLMGYNgIEpyvpkghuIHuQ7zeXqK6wnD6ijCED+N+KhJmdZFYOuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988992; c=relaxed/simple;
	bh=gnkIvDChFKCcFwAkMtS3UU0Q/EcMDiyHtjp8ZQ9OC9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm1oCulAQudHrdD49sRaY8frSeqxzUFiZxtfogxu90b2diLEwtodYLvIvJAp4FOX7xQ7+IW5fKHZyQOvIDzQLOPwSorkBlMw2qAzoGfbUIBgBgR5W5sjCGqm//oVQD32TNEX4F/wNHxO1On8ZLpNcbl80lId+Ez4l0UnJiMvmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP8h3BWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA85C4CECD;
	Tue, 10 Sep 2024 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988992;
	bh=gnkIvDChFKCcFwAkMtS3UU0Q/EcMDiyHtjp8ZQ9OC9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GP8h3BWOglczvKuKx7v8O7JPmlEqGK/Ov9CjrxIHV2ts4V7qtNnJleF0YAz8Jx/4u
	 4XSEAz9AtURlZP/p1eNuxV4pfTI4ltoHAOhQ6r7c6pKW5bSPK/kntuHClwwlTeil1D
	 ntUD7QUeSe1pOWmYYqPq6qn3NG0rmn1WMXb9nKVq4okfk1WMItv8oOl8Ing6x9j8EZ
	 Wj9FsUTepagEWErVf3Ewm14ZxJYpmD23Ec4bnLCfHKWJdAPr7H2StJG9mu747vi+00
	 y/fjIV7YyVOVJb863uA697olTGrSAp5gaqW6CJsa2UFMO5TXvJDIFmPtvLPGf1RxFf
	 exFiQO0JX9ACQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/12] ASoC: google: fix module autoloading
Date: Tue, 10 Sep 2024 13:22:46 -0400
Message-ID: <20240910172301.2415973-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 8e1bb4a41aa78d6105e59186af3dcd545fc66e70 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-3-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/google/chv3-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/google/chv3-i2s.c b/sound/soc/google/chv3-i2s.c
index 0f6513444906..462e970b954f 100644
--- a/sound/soc/google/chv3-i2s.c
+++ b/sound/soc/google/chv3-i2s.c
@@ -322,6 +322,7 @@ static const struct of_device_id chv3_i2s_of_match[] = {
 	{ .compatible = "google,chv3-i2s" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, chv3_i2s_of_match);
 
 static struct platform_driver chv3_i2s_driver = {
 	.probe = chv3_i2s_probe,
-- 
2.43.0


