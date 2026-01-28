Return-Path: <stable+bounces-212161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFbgJLM1eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:13:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D72A549C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A60B316E129
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D32D660E;
	Wed, 28 Jan 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPaFx3AQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D32D5408;
	Wed, 28 Jan 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614595; cv=none; b=nq8rTxUauNIVRqjl4njTw4TUtCNvjrURc/UxANdH2uFAFJAqLiN+B3z74ugHP13Q0eXtHecDMVi2K5VGr6L3OIzwyPLNyTdwIEVnBbvx+2ezwZ0f8TJWetwf/qjk+7ketiu2ngLIiyJETWvsWYpFZSIiOe5FyEVJtqPL6rkcR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614595; c=relaxed/simple;
	bh=HY6xEEuiRdS81MA3W95h6iSCGN/6SsojlPoSzUq65XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwNsUN7dx6/NZpzEFbQE3nfZaKxj6ehN8tTwQmp7bX+HPQN0H+pT92zs7a4TrC4VbHnydEExNDy2JYc3TxK3lPJXG6TstZwZEig14Qm1s7zqsScRkNBS1uV6UbmVV7by78wI1MDTjaXow4HqaWTrBefmvtAykiKN/lIo8XzntQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPaFx3AQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7934C16AAE;
	Wed, 28 Jan 2026 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614595;
	bh=HY6xEEuiRdS81MA3W95h6iSCGN/6SsojlPoSzUq65XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPaFx3AQymfSCelty0g8TgPH5uIoMod9uFtGvut3SnVaeBMnSEKDobo7V2QE0nwDp
	 NlJrsLun3eDx8VrZdjKCfUbmAofoEPI8jtkrVwtuCBqJPdF1ezQQhJWdK2hF50+vHX
	 KipiJRTJ+EmeZ5pUtkpz1VZajg15Rgmj0SbLxsnw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weigang He <geoffreyhe2@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.6 185/254] of: fix reference count leak in of_alias_scan()
Date: Wed, 28 Jan 2026 16:22:41 +0100
Message-ID: <20260128145351.460107004@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212161-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A0D72A549C
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weigang He <geoffreyhe2@gmail.com>

commit 81122fba08fa3ccafab6ed272a5c6f2203923a7e upstream.

of_find_node_by_path() returns a device_node with its refcount
incremented. When kstrtoint() fails or dt_alloc() fails, the function
continues to the next iteration without calling of_node_put(), causing
a reference count leak.

Add of_node_put(np) before continue on both error paths to properly
release the device_node reference.

Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
Link: https://patch.msgid.link/20260117091238.481243-1-geoffreyhe2@gmail.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/base.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1788,13 +1788,17 @@ void of_alias_scan(void * (*dt_alloc)(u6
 			end--;
 		len = end - start;
 
-		if (kstrtoint(end, 10, &id) < 0)
+		if (kstrtoint(end, 10, &id) < 0) {
+			of_node_put(np);
 			continue;
+		}
 
 		/* Allocate an alias_prop with enough space for the stem */
 		ap = dt_alloc(sizeof(*ap) + len + 1, __alignof__(*ap));
-		if (!ap)
+		if (!ap) {
+			of_node_put(np);
 			continue;
+		}
 		memset(ap, 0, sizeof(*ap) + len + 1);
 		ap->alias = start;
 		of_alias_add(ap, np, id, start, len);



