Return-Path: <stable+bounces-75696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61306973F91
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942531C20E87
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512131BBBFC;
	Tue, 10 Sep 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtVm2Lye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF71BBBE2;
	Tue, 10 Sep 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988997; cv=none; b=Juhm2xZKliZ1rddWqqS1QpTRFyNllU0OkkG/Fq+NrKlqu4yetwyuy9Hseato/wscEaFV96oDxnAxgCbyIRO6w9Ad4Sic2ov7UCxpyWglLfub/SnTlKcObzwcWLemYWgAs64EQ02h0ApiM3CI9o32ef/eL8fafo6xg6VeJxvLxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988997; c=relaxed/simple;
	bh=iMGgSxIC3F1XzM8wiBcUZYnqVIyuNBVNIdMKabXag9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mypsZO+SMa0cfcm2NM5tf1t2we4sxZONoJOSFtUYnKrMQsn5eOLvwlMleGZIYwlJ1RkgUf7UtTPWFoANo4APF0IbasdD3TshQAp6N8yjxBshUaYBCLJvLx0e+2s+hQr935HRrl87/2LGtyGU6IBlhOsjVI99l/n27nIDwOxC/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtVm2Lye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F70C4CEC3;
	Tue, 10 Sep 2024 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988996;
	bh=iMGgSxIC3F1XzM8wiBcUZYnqVIyuNBVNIdMKabXag9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtVm2LyeiCcMiD4YR45gidFRTUVMflaVvWViPer0qybJFBOPmPccpYssndp6qyapF
	 mAsfRjdN/U36fxx/m5cfz+ut4RN0sXex0rA8+E/HnR1qwAx4s6Lh/ZJ1FalE8fnV8D
	 bQ1nJelxT0174+H18SGthWuAT1Z30H8oCEomk4Eqco5BnDihFLq7jFWL8zv42Nvjtu
	 hU6E6sWKWjNgLfQQa22IQUIZQ4slyPXi8FjAIj0i63tsF+PsJZUBb/ToSiZO3HcU0C
	 rT04eg6EU06liJ5TuLvok32U7cq/O988mz4oY9ppEYmBy3Xn3KTKa+9uEcPawkpZNX
	 Y48DG4N5wHWcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/12] ASoC: fix module autoloading
Date: Tue, 10 Sep 2024 13:22:48 -0400
Message-ID: <20240910172301.2415973-6-sashal@kernel.org>
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

[ Upstream commit 6ba20539ac6b12ea757b3bfe11adf8de1672d7b8 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-5-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/chv3-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/chv3-codec.c b/sound/soc/codecs/chv3-codec.c
index ab99effa6874..40020500b1fe 100644
--- a/sound/soc/codecs/chv3-codec.c
+++ b/sound/soc/codecs/chv3-codec.c
@@ -26,6 +26,7 @@ static const struct of_device_id chv3_codec_of_match[] = {
 	{ .compatible = "google,chv3-codec", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, chv3_codec_of_match);
 
 static struct platform_driver chv3_codec_platform_driver = {
 	.driver = {
-- 
2.43.0


