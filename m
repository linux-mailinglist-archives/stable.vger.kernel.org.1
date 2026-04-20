Return-Path: <stable+bounces-239956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH04F2Ry5mlgwgEAu9opvQ
	(envelope-from <stable+bounces-239956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:37:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE75432F2D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3E93058573
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C51E7C12;
	Mon, 20 Apr 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SENfbOtz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910A34BA20
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705466; cv=none; b=LI7NY6EhICs8PtBaD/jl6zH6f+r5Z6ZvQ2PdsnbQVAJfvdegaTN/i0PmUA+3ZguQKgVKQdOENVlFWu+q8JsSCh6Y8CPL/Mtmy8mVjF9IaKwpU5fp532SSvlF0vQG+kiI3A/zzXctReXQYQi1N1MlghfKZhh+MTsK2MpZwuaoyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705466; c=relaxed/simple;
	bh=H3gckyagfx76Msdf4J3ZzYvnV9is4ckmlpXn43Bjoaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj30i/azzbI8fHKCUCQzweDD3bB6mDpUl8B2PLPAUfW4GRSNruhdxQ0TjV0KufqyTczWmibAAFYlRWWNBh7n13xhYvLRUIzPd/I/0DGrWlI1FUN8NdGWPynHVy2ZDeET/0/Q3BQmXTsuQ0daLCIlFSGswz8shmDI444NAc9SDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SENfbOtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AE5C19425;
	Mon, 20 Apr 2026 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776705466;
	bh=H3gckyagfx76Msdf4J3ZzYvnV9is4ckmlpXn43Bjoaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SENfbOtz+AtmaCz9IdWQHoroEgp0tWegHf76MJ75P2v+XICKYsa3zi64772c2jD5h
	 9z6CHWgfIbJHMtJpL5jT/m2CkWXq0EHv1rjKFuldV5tUYB0eDRCokbau4pSD0JLAaM
	 pSFBt3VBNkcRO89fYP6cii6i/eWQoQ2jJCsVHwwVxIFOUWw/s01GbXTNqB1KIIKDw+
	 nXIsp/taoeXJuV/1Bp+J/HMtGgxeYcOAahG4igSNYZplafqI9zNfQ5LXANi4M2zSin
	 NjOf9/HtegLk6mn44xVCVRBfqbInY5Tyzp0polupN2COahWZv6KITmNY1/wMg/uJhc
	 pXCkmaSPt9fEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Li <set_pte_at@outlook.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] soc: qcom: apr: make remove callback of apr driver void returned
Date: Mon, 20 Apr 2026 13:17:42 -0400
Message-ID: <20260420171743.1388144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042044-spied-poster-f99b@gregkh>
References: <2026042044-spied-poster-f99b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[outlook.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239956-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDE75432F2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit 33ae3d0955943ac5bacfcb6911cf7cb74822bf8c ]

Since commit fc7a6209d571 ("bus: Make remove callback return void")
forces bus_type::remove be void-returned, it doesn't make much sense
for any bus based driver implementing remove callbalk to return
non-void to its caller.

As such, change the remove function for apr bus based drivers to
return void.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/TYCP286MB23232B7968D34DB8323B0F16CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
Stable-dep-of: 6ec1235fc941 ("ASoC: qcom: q6apm: move component registration to unmanaged version")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/soc/qcom/apr.h  | 2 +-
 sound/soc/qcom/qdsp6/q6core.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
index 23c5b30f35114..be98aebcb3e19 100644
--- a/include/linux/soc/qcom/apr.h
+++ b/include/linux/soc/qcom/apr.h
@@ -153,7 +153,7 @@ typedef struct apr_device gpr_device_t;
 
 struct apr_driver {
 	int	(*probe)(struct apr_device *sl);
-	int	(*remove)(struct apr_device *sl);
+	void	(*remove)(struct apr_device *sl);
 	int	(*callback)(struct apr_device *a,
 			    struct apr_resp_pkt *d);
 	int	(*gpr_callback)(struct gpr_resp_pkt *d, void *data, int op);
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index 5358fefd4210b..49cfb32cd2091 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -339,7 +339,7 @@ static int q6core_probe(struct apr_device *adev)
 	return 0;
 }
 
-static int q6core_exit(struct apr_device *adev)
+static void q6core_exit(struct apr_device *adev)
 {
 	struct q6core *core = dev_get_drvdata(&adev->dev);
 
@@ -350,8 +350,6 @@ static int q6core_exit(struct apr_device *adev)
 
 	g_core = NULL;
 	kfree(core);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
-- 
2.53.0


