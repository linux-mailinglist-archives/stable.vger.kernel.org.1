Return-Path: <stable+bounces-265010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gvitG2yDMWo/lQUAu9opvQ
	(envelope-from <stable+bounces-265010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:10:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9597692CD8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:10:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=T2GXNwcR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265010-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265010-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBF0314F132
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D68477995;
	Tue, 16 Jun 2026 16:57:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C543E9FE;
	Tue, 16 Jun 2026 16:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629022; cv=none; b=LiAvbo//et+1K8YDRmmClCmKAoZd47ywImceEJF6PUjFP99uRREPytSesFyGGd1khN3D7t1DC5rS4Ek3yq6fYpLGoYE/RqNN8MuayGJAXNma3nQ2I5sNU1faU57mGdcH4rhQua4vZBI1HyWIQKcrUfVXfbgKwNnj7Uqj17rNrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629022; c=relaxed/simple;
	bh=wB6po9p16KxM5zAx+PaWpQjx4mXDBNxpLLeodgqP8/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9gadOgK2YnPk2Z2XqVdn8mRK5pQChxzuVX+1KK8VSzQN8rSwC6XR2dz2QSYbw859ZPWncTASzaCm9UQoogmvRkZKzfbx3BeM7UwJwSxzIVbzVH8DGqIa8UsKDpc0PROwce4gGbfHHeng6GQzFkKeU3R4XRR28phEJHQlEB13I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2GXNwcR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163C41F000E9;
	Tue, 16 Jun 2026 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629021;
	bh=bbpFkB/lb7qG+tc36SWqj28Qwcpr+RHe4+/1MdPzeGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2GXNwcRxyW9sbf0a+0iZqM5IgkY17LVvgH/0IrjTAAqDNC0klxNDL4sgVrrmYa4/
	 cZjS45j6aVqLd/fZrzhdMKi1/dK5HcWnmE8+MTKqaS/r5c00CAte1w60Eztrd9CE9m
	 DamgpDev/Lfn4lw4mOKZ9bwfG2jJLAXHeli8m9ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 206/452] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
Date: Tue, 16 Jun 2026 20:27:13 +0530
Message-ID: <20260616145128.628067797@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,iki.fi,intel.com,foxmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-265010-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pav@iki.fi,m:luiz.von.dentz@intel.com,m:alvalan9@foxmail.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9597692CD8

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit a2639a7f0f5bf7d73f337f8f077c19415c62ed2c ]

hci_conn lookup and field access must be covered by hdev lock in
set_cig_params_sync, otherwise it's possible it is freed concurrently.

Take hdev lock to prevent hci_conn from being deleted or modified
concurrently.  Just RCU lock is not suitable here, as we also want to
avoid "tearing" in the configuration.

Fixes: a091289218202 ("Bluetooth: hci_conn: Fix hci_le_set_cig_params")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f51c530a3c4583..ab86cc4a5e3fc8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1734,9 +1734,13 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	struct iso_cig_params pdu;
 	u8 cis_id;
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
-	if (!conn)
+	if (!conn) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
 
 	memset(&pdu, 0, sizeof(pdu));
 
@@ -1776,6 +1780,8 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 		cis->p_rtn  = qos->ucast.in.rtn;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (!pdu.cp.num_cis)
 		return 0;
 
-- 
2.53.0




