Return-Path: <stable+bounces-61134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845793A704
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985251C21B6B
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8030158873;
	Tue, 23 Jul 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxOG6KOB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FB13D896;
	Tue, 23 Jul 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760074; cv=none; b=mJKAxDEsA+wMVrs+wFvoRmqTrfAyf/G/tYSql9YbPl9dKTYagl2nBNDEwul7nLBioFy21kggRMT22xUwCesfgK38az7gvfAFgcjG/i/uxLOxK6szJHwjs1NuAUV2YilMa87CyaMyktl9dPans8/mOs65YbJGZkIsEZfDDA2s6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760074; c=relaxed/simple;
	bh=R0npayD2raiKeQr618mWdTKWiizv5nYHTLzx4GerW+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6JI0VtLD/xwiQQJdfwyPmdaGK5S26OfYUjkH4DrD1kA/FTjhQS5SxU3XjKfOaSANrgT7HXaQqZ52UZlMUsSHASKf/GpmrbUW0PpkjG62d6WHTzDe8axJAzs7wGVfZLJdPZLtDgUSwDcm+iQlgPxp0wzyqHzsfrwP19ERTAI2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxOG6KOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE48C4AF09;
	Tue, 23 Jul 2024 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721760074;
	bh=R0npayD2raiKeQr618mWdTKWiizv5nYHTLzx4GerW+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxOG6KOBUn2s8f51/dQtW1LdzvhfaUe0t9cipDs7O30K2ECct1RVUAGkcR3ET7P3T
	 jyy/gVg+6TZ+LKQLgy3SCMncHUU0Zqoao6+njtpa7A5FfSlKEi5NEgJin/PdaPM4jJ
	 vYZzMVr7YDfbbrcmqRbxhNyZK8n3VLSguaeQAoIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 094/163] ASoC: topology: Do not assign fields that are already set
Date: Tue, 23 Jul 2024 20:23:43 +0200
Message-ID: <20240723180147.110056932@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit daf0b99d4720c9f05bdb81c73b2efdb43fa9def3 ]

The routes are allocated with kzalloc(), so all fields are zeroed by
default, skip unnecessary assignments.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240603102818.36165-4-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 7add1dbf1d214..ce22613bf9690 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1072,11 +1072,7 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		/* set to NULL atm for tplg users */
-		route->connected = NULL;
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0) {
-			route->control = NULL;
-		} else {
+		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) != 0) {
 			route->control = devm_kmemdup(tplg->dev, elem->control,
 						      min(strlen(elem->control),
 							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
-- 
2.43.0




