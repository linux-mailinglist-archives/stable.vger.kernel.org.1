Return-Path: <stable+bounces-255512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBuBEtuhGGqvlggAu9opvQ
	(envelope-from <stable+bounces-255512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CF5F8179
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86DBF303A0AB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4B33CE8A;
	Thu, 28 May 2026 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uaLTiv1Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5E33F5B4;
	Thu, 28 May 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999119; cv=none; b=clZIBxvkSTmhG8riWTalOGYkaKWz/bbfR7aejvC5vh33hAq9eFaKFqbQOzD/De9F1eND6ouVOQoKTgfeD6SHSM192a1LLTcj/SFnPmXlqyG52tXFl1eF0DlpVF8V0nlaAfok4nKynpwDdv+OHKTczQYByYSQxGlgwZgYhVDFibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999119; c=relaxed/simple;
	bh=HxTMK8KhZAcENmx1nT4PrR4qE+VC2o9gnYHkBGZr4X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djzUgUPwoeyeA5poQODd9cFy1JuKHNbp8wMTgWY1U39QRGTLL2kTNvoEub1VInOICd4So7FoCzE8A9kc8Y5PXOlBiqwGKjv4aJ5j1tc7A+BG3khYiKUDAKp3ak+GKBYfqqhtMqjdq+MNtIAIxEGe8txidQYhRxQ+KV0ZHMfNCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uaLTiv1Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557731F000E9;
	Thu, 28 May 2026 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999118;
	bh=qTiJ1lkwg9n/NN46fA8aEha86jn9NTLfuB3W6TTc67Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uaLTiv1QA3o+Kb5M6LzOGiv3MS3mIOcnD5dOG7/z9+usyNiUuioK/QZW23T2YvHsS
	 NHsr09Rl8lJ/KkNGF6XrbOO9CVwrKo98ow6OmbpOzU2/NXBU+MVoCn9zrxImu1211D
	 lFVNCGIQRIzHuCvdhjSBJF0OOPU4onpEKcCxbqsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 415/461] wifi: wilc1000: fix dma_buffer leak on bus acquire failure
Date: Thu, 28 May 2026 21:49:04 +0200
Message-ID: <20260528194659.507868366@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255512-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,cambiumnetworks.com:email]
X-Rspamd-Queue-Id: 6D6CF5F8179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>

[ Upstream commit dd7b6a8671939708cc4b7a46786d8c11297e8f69 ]

wilc_wlan_firmware_download() allocates dma_buffer with kmalloc() at
the top of the function and uses a 'fail:' label to free it via
kfree(dma_buffer) on error.

All later error paths correctly use 'goto fail' to route through this
cleanup. However, the early failure path after the first acquire_bus()
call uses a bare 'return ret;', which leaks dma_buffer whenever the bus
acquire fails.

Replace the early return with goto fail so the existing cleanup path
runs.

Found via a custom Coccinelle semantic patch hunting for kmalloc'd
locals leaked on early-return error paths in driver firmware-download
code.

Fixes: 1241c5650ff7 ("wifi: wilc1000: Fill in missing error handling")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260511042732.998311-1-shitalkumar.gandhi@cambiumnetworks.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 3fa8592eb2503..4b116fe6f9ea9 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1265,7 +1265,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	if (ret)
-		return ret;
+		goto fail;
 
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	reg &= ~BIT(10);
-- 
2.53.0




