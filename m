Return-Path: <stable+bounces-61132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD093A702
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0FF7B211F0
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230F1586C8;
	Tue, 23 Jul 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ah7AfSOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437513D600;
	Tue, 23 Jul 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760068; cv=none; b=fpHfQwl5SyjX8Olfw0NIOYz8U7KYiAqNyy3gkdTo6WdFYZ4r0movPP3Z1M/3UWZFT2tHP/+BClIOQan7vr0NzvviygEPx72z9XLf7zb79C9qQ8d+9zq85n9Dpf+rjvZ9DtIZPY8gAV84iTjqV6r9sQde6NT+x6Z/i2P9OZL2+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760068; c=relaxed/simple;
	bh=5MAnPfaHtzHAwZquw8Ylzm1ntrEtUrUTe6LWO+RBQVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVkkj35cVrkfVDZtSncVw8j7sNdu5IjOS/dpRGu+oLngjj5wJLxnnm4AiaqYx7VTUdbBADdpZo9L/BC930WXhlayYCTL2ak1X0EmkLEgJlbAcSuON8pD7gEMAuYXLpUkgg/TRNMl6S+SaNEMelXURtjLWgTSAvkWd7+3iPe3EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ah7AfSOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CA3C4AF0A;
	Tue, 23 Jul 2024 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721760068;
	bh=5MAnPfaHtzHAwZquw8Ylzm1ntrEtUrUTe6LWO+RBQVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ah7AfSOFZErLO57isANWBxQi0KM5VkaiZgT3273VT53oKak2v2KrFqk8ifc8A/WyW
	 Sfz9nYL1ioieT3mvmU/zEnjmOW13AYmrir0fHnEC0Soq6K3rsTX6vsknuZvXeF3QUD
	 tqz/bUEgzgMQcj2ORF/kVQXYAbWcaWfCEBJihpVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Montleon <jmontleo@redhat.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 092/163] ASoC: topology: Fix references to freed memory
Date: Tue, 23 Jul 2024 20:23:41 +0200
Message-ID: <20240723180147.031663771@linuxfoundation.org>
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

[ Upstream commit 97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1 ]

Most users after parsing a topology file, release memory used by it, so
having pointer references directly into topology file contents is wrong.
Use devm_kmemdup(), to allocate memory as needed.

Reported-by: Jason Montleon <jmontleo@redhat.com>
Link: https://github.com/thesofproject/avs-topology-xml/issues/22#issuecomment-2127892605
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240603102818.36165-2-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ba4890991f0d7..7add1dbf1d214 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1060,15 +1060,32 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		route->source = elem->source;
-		route->sink = elem->sink;
+		route->source = devm_kmemdup(tplg->dev, elem->source,
+					     min(strlen(elem->source),
+						 SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					     GFP_KERNEL);
+		route->sink = devm_kmemdup(tplg->dev, elem->sink,
+					   min(strlen(elem->sink), SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					   GFP_KERNEL);
+		if (!route->source || !route->sink) {
+			ret = -ENOMEM;
+			break;
+		}
 
 		/* set to NULL atm for tplg users */
 		route->connected = NULL;
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0)
+		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0) {
 			route->control = NULL;
-		else
-			route->control = elem->control;
+		} else {
+			route->control = devm_kmemdup(tplg->dev, elem->control,
+						      min(strlen(elem->control),
+							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+						      GFP_KERNEL);
+			if (!route->control) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
 
 		/* add route dobj to dobj_list */
 		route->dobj.type = SND_SOC_DOBJ_GRAPH;
-- 
2.43.0




