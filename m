Return-Path: <stable+bounces-77980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13A98847F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5674B21CE2
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149D18BC0D;
	Fri, 27 Sep 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iIbUc1yD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADC17B515;
	Fri, 27 Sep 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440089; cv=none; b=B9sgcOmKAWwt40NQuajI4sfEvUb2mTtZCDg9gX6AWQnGcGZ4Q8/R3GStxvnXv3YpCtQ60KlyCx4XSwS4m3mYzM33BpfSXkeHROYTaZJWpW9vrn/WavSlCbsc1IEt37Chs7wpZ2JqMajtRaAhtLWMQA9sVDWjxQSls1f0WDElvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440089; c=relaxed/simple;
	bh=IVzuxtCt0gRg0HM80+dkp99AlJ6OOvj8gXD6BO+zDEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY3kZyaFye6pRuWOxYbzLAhG14q19k//H+7gcOlIAJ74c2p9A8VACModGLV61T8uGyOQC6s/vHk/rO2pZcSp7PJnMmKhh0vGrDI60qAi2m9nJKXWjGX/j9Rg11pepURoUqQAhwmasAxMBDmBnYLwNVGgwRPjjrBVzCCGHCtq1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iIbUc1yD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D356C4CEC4;
	Fri, 27 Sep 2024 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440089;
	bh=IVzuxtCt0gRg0HM80+dkp99AlJ6OOvj8gXD6BO+zDEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIbUc1yD5h+xZQubaaXIePM/Z0xXagmdTfYZz6HnmTrrE5NYGDeznjCbaEXDC89+O
	 BakLWbFOctHzlJ218U6Z05JIS+//P1Y3MKSw3C2LdHvb+VYYvfvPRFeVQpbeMnuznP
	 4ZMpXp6GFmSB3DNVEk4QLU8uZeCsv3Z1CCp9LObk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 29/58] ASoC: fix module autoloading
Date: Fri, 27 Sep 2024 14:23:31 +0200
Message-ID: <20240927121719.977038367@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ab99effa68748..40020500b1fe8 100644
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




