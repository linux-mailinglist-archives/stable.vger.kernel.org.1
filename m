Return-Path: <stable+bounces-255812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPhYL9imGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 409925F9011
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444A53153746
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BCE33F5BE;
	Thu, 28 May 2026 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0oW4WsVK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3D254B1F;
	Thu, 28 May 2026 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999949; cv=none; b=kB5trrOZO4uR2EtVxJOw6gWUonci09Cbk4KxGyvizymY4xu/v/FaTjeGPH3/OtTiIT4Twg9E5tD/jIVfYqBzirv/cRyw94zeo4+bwnHGs1jBWpvGe25OzwjX+fXw09w/O6aqrXTggL2uKzU3rrpti+DC+p4LxKROI5pl0g1kzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999949; c=relaxed/simple;
	bh=qa3tyGT31UgcuszDjWliat8w9rZ4nB0W/yzglsq3buw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci0QSB6LQWwjuwvY7vSbvZLpKcMbc5KQWBVp0ifJdgL47GKfeuTWIAIeT4gr8ESpL5gecu4k+4S8JVGf8npokFSccxL9gtqCSBkhG+QqHdo1KsNsJPunQt6KPtedkjpSCmzeKm7t1nPCIB4zUEdqd0CNiRzqP+sm+0O9+fVH5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0oW4WsVK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFF01F000E9;
	Thu, 28 May 2026 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999947;
	bh=Y94UQT5006FhmnHXd+eaqhPKdJ0zWVvtdQa2t0Lt2a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0oW4WsVKGKQrvPEMhfv5cnBSu5G1pVFHuOOJPYokPCjiRgA41hwWvBOHPLnE+4lhi
	 cgAIWsmCp5m7dFxTTNBXMjF22cWqrHKgYjev53B37x/Sc8Lr91xkGlL+Az4IYlDZNP
	 T3CZzDSmca8AtgVBwJ+blR2sQ4bx6eE60F4cr3PE=
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
Subject: [PATCH 6.18 231/377] powerpc: 82xx: fix uninitialized pointers with free attribute
Date: Thu, 28 May 2026 21:47:49 +0200
Message-ID: <20260528194645.079075696@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255812-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 409925F9011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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




