Return-Path: <stable+bounces-261320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M+twLwlIJWrBFwIAu9opvQ
	(envelope-from <stable+bounces-261320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4EF64FB32
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2Og4bzZw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261320-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261320-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CA903026228
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E0327C13;
	Sun,  7 Jun 2026 10:28:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F550313E2B;
	Sun,  7 Jun 2026 10:28:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828099; cv=none; b=Gq0NN/vit9vUetfzRbL4yJyRQLHIl7PGd7p3KT5bi1ELTssy3PuBR9EEz0f95E6vCHfmsXFmfh+fROKUtRhoKidFJEguqhyAABLua0t0inXqaWlaINLyhbJww39IaYggmSbVDQzhPSvz7MmWpqNlIxXDcldM53whqy6ubgQ7lII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828099; c=relaxed/simple;
	bh=BO9gxp7iJ3GVSm5Z2VVKf02OElASduTMCXs8wj6UQnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDuTanhwHYjOgNpNdIYNKrTEE3fEdqao8wtWidNvvK0eUeTSUnMDIAjbKaOQKmGHyaxhxCtx9xIVJOd/r/8LwnXFpPDcb7jMj6kBAdFGcQp8X7maSRgW8V6iKZBHkQncHDoTuifTYvaxFoGp3soVgLu5Pq9V65TmUIXOOVdR0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Og4bzZw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E561F00893;
	Sun,  7 Jun 2026 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828098;
	bh=XjcZNSjcnxECox0Yme9ZDVdMom/yL5S5ZuzODDfO+Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2Og4bzZwu7ErOr+ibDHyG+3ziH2hZyIZTmyEFnfBXMXXDn+loGQF593QkNCkmt85m
	 JsFEDbZ8UH0SAYYYz5ek6DYn5QrK9iPb85uWpuMkK3EHVgb93q+GONpSnVLVmU6Dws
	 EoiM9qxbTecB/QrAJmwRo5zATeDmLKFux2KuxZC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavitra Jha <jhapavitra98@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 7.0 151/332] Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()
Date: Sun,  7 Jun 2026 11:58:40 +0200
Message-ID: <20260607095733.634634957@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261320-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jhapavitra98@gmail.com,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
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
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B4EF64FB32

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavitra Jha <jhapavitra98@gmail.com>

commit bfa9d28960ed677d556bdf097073bc3129686229 upstream.

hci_le_big_terminate() allocates iso_list_data via kzalloc_obj but
returns 0 without freeing it when neither pa_sync_term nor big_sync_term
flags are set after evaluating the PA and BIG sync connection state.

This early-return path was introduced when hci_le_big_terminate() was
refactored to take struct hci_conn instead of raw u8 parameters, adding
PA/BIG flag evaluation logic. The existing kfree() on hci_cmd_sync_queue
failure does not cover this path.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_conn.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -803,8 +803,10 @@ static int hci_le_big_terminate(struct h
 			d->big_sync_term = true;
 	}
 
-	if (!d->pa_sync_term && !d->big_sync_term)
+	if (!d->pa_sync_term && !d->big_sync_term) {
+		kfree(d);
 		return 0;
+	}
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);



