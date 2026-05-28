Return-Path: <stable+bounces-255343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPcJFjqhGGqnlggAu9opvQ
	(envelope-from <stable+bounces-255343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B43A65F7FBA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F073159A8E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF932ABC0;
	Thu, 28 May 2026 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WaI2CmKA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B672F260C;
	Thu, 28 May 2026 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998644; cv=none; b=rpypB70AeucxW7xzlEnzAE/0J5pPHmiXx2dSTkKazKes4gC1ZPGa6LjcFS0uE/sqAag9zU3UTnNGjOr274qd2lmFRnUL+XsAOpg3U3k9hNvwkp2DahPV2C7lvAXnQHzGBxbqhH5Hogrwbh6OOyvErluhJWQghmJTy0jf1Rh9XcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998644; c=relaxed/simple;
	bh=MWNI4FFWIKP9T+VVMv19L5Iol7BS/5I75NsXTd5P7aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAUpekX8Ujy/X5D2vSpWoJUfxjwaNzR69dRop+DaAH+QAVP+O1qtsFvsgS0ii17jtC1RHsYK2atF6XoyEXxcc7TK3geg0Ps0IUN9IBFN895Bb0BC3lwyPJUQCMuiXErZ/LfqDlmQm9JjZoEMKOHUAQKVdziG812H5TGMs7uForQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WaI2CmKA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D41F000E9;
	Thu, 28 May 2026 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998643;
	bh=1F1fKUPI7uWaVxzM7ujjsR6X7Jm1lDd+/0V/DZEDYU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WaI2CmKAqkTzFpNPta0A4g4u8C2YFMgRDVAof/c09+ah+PV2jjEHEiRrH108Vb5Wf
	 +ypaTjrArm3f4fAnmRxQU+xgsCXhXpeXGav4TPypSce2zi1KI3OsacCNCxteS0UbLu
	 Y2rW/NBG4I1m/VhQH4x+IA/tOvWImXyQO0ooPSvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ally Heev <allyheev@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 247/461] powerpc: 82xx: fix uninitialized pointers with free attribute
Date: Thu, 28 May 2026 21:46:16 +0200
Message-ID: <20260528194654.298114860@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linaro.org,gmail.com,kernel.org,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-255343-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: B43A65F7FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ally Heev <allyheev@gmail.com>

[ Upstream commit acd1e47db03d4b528fd5efb8565dd0de1c79f62a ]

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory allocated to the pointer is freed automatically
when the pointer goes out of scope.

powerpc/km82xx doesn't have any bugs related to this as of now, but,
it is better to initialize and assign pointers with `__free` attribute
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
Fixes: 4aa5cc1e0012 ("powerpc-km82xx.c: replace of_node_put() with __free")
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20251116-aheev-uninitialized-free-attr-km82xx-v2-1-4307e2b5300d@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/82xx/km82xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 99f0f0f418767..4ad223525e893 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -27,8 +27,8 @@
 
 static void __init km82xx_pic_init(void)
 {
-	struct device_node *np __free(device_node);
-	np = of_find_compatible_node(NULL, NULL, "fsl,pq2-pic");
+	struct device_node *np __free(device_node) = of_find_compatible_node(NULL,
+		NULL, "fsl,pq2-pic");
 
 	if (!np) {
 		pr_err("PIC init: can not find cpm-pic node\n");
-- 
2.53.0




