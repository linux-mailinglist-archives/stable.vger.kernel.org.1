Return-Path: <stable+bounces-266135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xkGtGB+XMWqHngUAu9opvQ
	(envelope-from <stable+bounces-266135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:34:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D736943F9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:34:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="EF/3ZJqq";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266135-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266135-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCF96307275D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A44418D7;
	Tue, 16 Jun 2026 18:34:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F60169AD2;
	Tue, 16 Jun 2026 18:34:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634845; cv=none; b=gD7VGQfr88r+KA47A1SX5LIHVTuIprSVqrJ4hUQfMKmBm8jbErwN/kFTZihvn60fjNCgZGB84P8XhZaRAGq//+cY+2duXH4DR/HPEz1pOwk5f3QtOe7kE1Kons0HOy21pu2Vem8TMUVqV2ogz0bIqrWfba8kRvEjk9Tet0VVdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634845; c=relaxed/simple;
	bh=X+kDlXRuy+5xFMauwEakLaLtSnEUAr6IpLRU4ZtMK34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mky8Gh0ORAaCp3UwcixxEuKD3/7cxATOPctwgZjvqKSJblN8NyyZ+IDzlNg0V0+9Klmy+FdZkVP81Sfk1AupYkTXxf5lwpaQj1Wvsp4nTChBXBI+w9L+0RTgng1Z/wlA1az7mcLptpbme27SApGYuXSilMeFpNe1U+2t5WpQamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EF/3ZJqq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602951F000E9;
	Tue, 16 Jun 2026 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634844;
	bh=iYfcNt5Z19oNMWSaQLbVVZvaw1DXoz0RH84IWOwUHzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EF/3ZJqqu5xbbg5uB74+ssiRwCoCOkYxh9cppShNPtfqIGCpgwvGv+xb6oKB+f+B6
	 juLDXkWmRsQzphvyJSroXb70Nq35q0vHSVLWIP6MdLEPsRdk3mWMAqDnQuXeAxPO6z
	 B/eWDlMCQ1qldci1ET3W5meo/ATEfVU9Z6a2oFSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 343/411] qed: Use the bitmap API to simplify some functions
Date: Tue, 16 Jun 2026 20:29:41 +0530
Message-ID: <20260616145119.479837855@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-266135-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:christophe.jaillet@wanadoo.fr,m:davem@davemloft.net,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wanadoo.fr,davemloft.net,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1D736943F9

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 5e6c7ccd3ea4b25dd6b4b0363859913f315deacb ]

'cid_map' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Also change some 'memset()' into 'bitmap_zero()' to keep consistency. This
is also much less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 2bccfb8476ca ("qed: fix double free in qed_cxt_tables_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1037,12 +1037,12 @@ static void qed_cid_map_free(struct qed_
 	u32 type, vf;
 
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
-		kfree(p_mngr->acquired[type].cid_map);
+		bitmap_free(p_mngr->acquired[type].cid_map);
 		p_mngr->acquired[type].max_count = 0;
 		p_mngr->acquired[type].start_cid = 0;
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
-			kfree(p_mngr->acquired_vf[type][vf].cid_map);
+			bitmap_free(p_mngr->acquired_vf[type][vf].cid_map);
 			p_mngr->acquired_vf[type][vf].max_count = 0;
 			p_mngr->acquired_vf[type][vf].start_cid = 0;
 		}
@@ -1055,15 +1055,10 @@ qed_cid_map_alloc_single(struct qed_hwfn
 			 u32 cid_start,
 			 u32 cid_count, struct qed_cid_acquired_map *p_map)
 {
-	u32 size;
-
 	if (!cid_count)
 		return 0;
 
-	size = DIV_ROUND_UP(cid_count,
-			    sizeof(unsigned long) * BITS_PER_BYTE) *
-	       sizeof(unsigned long);
-	p_map->cid_map = kzalloc(size, GFP_KERNEL);
+	p_map->cid_map = bitmap_zalloc(cid_count, GFP_KERNEL);
 	if (!p_map->cid_map)
 		return -ENOMEM;
 
@@ -1217,7 +1212,6 @@ void qed_cxt_mngr_setup(struct qed_hwfn
 	struct qed_cid_acquired_map *p_map;
 	struct qed_conn_type_cfg *p_cfg;
 	int type;
-	u32 len;
 
 	/* Reset acquired cids */
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
@@ -1226,11 +1220,7 @@ void qed_cxt_mngr_setup(struct qed_hwfn
 		p_cfg = &p_mngr->conn_cfg[type];
 		if (p_cfg->cid_count) {
 			p_map = &p_mngr->acquired[type];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   sizeof(unsigned long) *
-					   BITS_PER_BYTE) *
-			      sizeof(unsigned long);
-			memset(p_map->cid_map, 0, len);
+			bitmap_zero(p_map->cid_map, p_map->max_count);
 		}
 
 		if (!p_cfg->cids_per_vf)
@@ -1238,11 +1228,7 @@ void qed_cxt_mngr_setup(struct qed_hwfn
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
 			p_map = &p_mngr->acquired_vf[type][vf];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   sizeof(unsigned long) *
-					   BITS_PER_BYTE) *
-			      sizeof(unsigned long);
-			memset(p_map->cid_map, 0, len);
+			bitmap_zero(p_map->cid_map, p_map->max_count);
 		}
 	}
 }



