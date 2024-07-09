Return-Path: <stable+bounces-58839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A992C099
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976C01F235E9
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA1B200125;
	Tue,  9 Jul 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5UYlQLu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4C1A2543;
	Tue,  9 Jul 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542250; cv=none; b=dDa41y1INANxHc4cmZL725wsBxtBscu49kgg/gpoXieYy5ft3B8Wtu4rDm06Ozdv9UAJCr4RDo3hg6kCDfTJhxkMfqwAgACyOJT62U1bw9XH+bH5xL60bYqh8frlGfUGQBAb9NGJxQHtWuEyCkvcvcFjV0rrZpGDOgiJ88sGY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542250; c=relaxed/simple;
	bh=qtveD35XHhf/wSAOhGJADRp9wH/R8AVt8DlbLx/DNno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlffTk4IHKHrgqodQZM0k6P+1LanEWNU6+jOnsqsXcn5LMs0bw+DfDXGKRamhwg5RyxziR6BzHinRmZkTb9feJxPiaPo8fI6UhVxYDLT4qzEEdm+qNxsGvULSkYOFuctlHPH2bjIP0NOivvnqDu9ggKTzuCPv5YrO3OoLbRE+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5UYlQLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E057FC4AF0A;
	Tue,  9 Jul 2024 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542250;
	bh=qtveD35XHhf/wSAOhGJADRp9wH/R8AVt8DlbLx/DNno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5UYlQLucBAT+i/4AZIhWQ+8LLFHR1DuMGG0Xr6qprP0IZSONBlA/43Rx7YXXUq7N
	 Zhrte/DWMrM7lYhYNrb3rQDcLQyXwLAexhdtcnr20Zk2JWZiHrUs+yvEzkXdHIbgH9
	 kGBzWjIv2sGXPHDHCIEuFHHoRs/jvwGXD6t6LveElTqk6C8G+dEDq9IUYIUH2gIqoe
	 IE9bp+rzKR/CBDIUKAdJrxYyZdq9aIe6rREbaqnffb8TM8Ihj3b3IrUl46CXExobQJ
	 WjGE3Tv/mFCwBIy3p1XCL2y5gFZCd8xUeooUKgnQ6YNbxKwj5A3RdaAaKuI358C0FA
	 hImHUvk7o5wMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/27] ASoC: topology: Do not assign fields that are already set
Date: Tue,  9 Jul 2024 12:23:18 -0400
Message-ID: <20240709162401.31946-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit

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
index b07083bae65ed..d3cbfa6a704f9 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1113,11 +1113,7 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
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


