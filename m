Return-Path: <stable+bounces-92481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333BB9C5456
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02897282323
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695E217F32;
	Tue, 12 Nov 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFzzo/wS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2F21791B;
	Tue, 12 Nov 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407778; cv=none; b=uiTe1m7D07oZYHqE6/+N1MY7HUB22fCAVrMudemIRORegxyqcOSlN1+AeHStfxauIdpwYnF3CJi/4psPZEvzAWQhO4h1cG9qD43CTjhTfjBayyWtiFEyiKsm7q1jYsKxx8DMoj7sbhVw6yg4leUcXgdSvXppADGSF1BfnI5ZOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407778; c=relaxed/simple;
	bh=BC7wOFqWZnXwYcda92nB+EZQpcEXp76VVZnE60kBLEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYpnhDToNcNMXx+f8ZHjTuEAsZrO7eim5y0+JjVYkEUGMEdGPrxShZL6P3RKGDA5JWdY5eB+RwRjKqdGKqxJw+UFm1dyMv29SmK6JvRG7k3h4w80ajI0HDESVyMH2pH5D14FR+rD1aotu/h/aAe86ZGtKP5VyTxP/Qe14D9mXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFzzo/wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22CFC4CED6;
	Tue, 12 Nov 2024 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407778;
	bh=BC7wOFqWZnXwYcda92nB+EZQpcEXp76VVZnE60kBLEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFzzo/wSTFD9VKYuMLlRxPbyyZmHQU8O6OhnD6VsIyCczWLAvL75uVD3pTfg4qKKg
	 DJ0S1qiNaReSCFgBHUdnciTinpWP0MQSwNvNM6TfBN1jcgt11C/Iu33sqBrx7WheUJ
	 KrPMyCQL2kRPohThVp0ybsyyIT6dz0ZIZKhzF5z3IU3EJQHKBpO2VULbkrHdpFtqRA
	 89wen45aA3mpaH/erPqNNMSgetdxl7ohGApLcxsbNIgumXJ/Tzz1zEgr5W2MeGUcz1
	 jIXhfhjdWQ0QS4sOL4TuuGYDnRJcSQOJGnMNzETfqf9qmip9EesqMvhKkQaF4Ctbls
	 n13jWl64OCDGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 07/16] ASoC: tas2781: Add new driver version for tas2563 & tas2781 qfn chip
Date: Tue, 12 Nov 2024 05:35:49 -0500
Message-ID: <20241112103605.1652910-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit

From: Shenghao Ding <shenghao-ding@ti.com>

[ Upstream commit fe09de2db2365eed8b44b572cff7d421eaf1754a ]

Add new driver version to support tas2563 & tas2781 qfn chip

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
Link: https://patch.msgid.link/20241104100055.48-1-shenghao-ding@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2781-fmwlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index f3a7605f07104..6474cc551d551 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1992,6 +1992,7 @@ static int tasdevice_dspfw_ready(const struct firmware *fmw,
 		break;
 	case 0x202:
 	case 0x400:
+	case 0x401:
 		tas_priv->fw_parse_variable_header =
 			fw_parse_variable_header_git;
 		tas_priv->fw_parse_program_data =
-- 
2.43.0


