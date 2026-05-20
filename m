Return-Path: <stable+bounces-250701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAtYBKb2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:00:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F62B595131
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F88355F370
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E493A3E9C;
	Wed, 20 May 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KqW9MKxM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD742F0C62;
	Wed, 20 May 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296091; cv=none; b=PeD9SI4SL/0JL273sKA7fb4Z6b+1o11T+GJbOez6C2YWCMXyE0/eMsJvNc4zAxXP5lBaTH9nxVstfoVbpl4wzWhq6KGacpd3sNaLARY4MPWBNJ6tcgdbopxfOXKARbr+DiGPnl2SAPY3D6ox5mHxD7t9VAPDriJ7hG13xkL/U9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296091; c=relaxed/simple;
	bh=XxL82LllRdXqgNWAkz36o1bYXtnu02TzqLHfeZufFTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db/SNrQhIz560QwrV8R/4V0Dwjujkv+6ocZivDybaEyTFUF2RvvZKCKZP+Cfh3ckwaJaE8/wgGwXcv3VvXJMuV2GwsVFuiQFPu6KVbUsuvnv0sgx65PhYE5Y5Xo9CRLRt6grE5hDngx97DTF37tUAznwzkb4dmVYLOv4xgBRBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KqW9MKxM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8C51F000E9;
	Wed, 20 May 2026 16:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296089;
	bh=OO0hDA9uhcqMtz85knmNfzj7eO3RS8r2SNOieZmG/o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KqW9MKxM+zVL6QtzYu/g8GMF1gH72J/bnKQ0aeXji40VHBUAEOJky0g7WUIDmNwkk
	 CUz5a8KL/NU5AiEFLZf9igwhirUzhcxvsBgGpWcZJwxwX97Yv+ijqf7IzKX02R7U94
	 G+hIjIMXNoLSrA+Ye75AXvakWWOw5juQ55G90+No=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0667/1146] usb: typec: Fix error pointer dereference
Date: Wed, 20 May 2026 18:15:17 +0200
Message-ID: <20260520162203.283066978@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250701-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 6F62B595131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit f2529d08fcb429ea01bb87c326342f41483f8b2f ]

The variable tps->partner is checked for an error pointer and then if it
is, it sends an error message but does not return and then immediately
dereferenced a few lines below:

tps->partner = typec_register_partner(tps->port, &desc);
if (IS_ERR(tps->partner))
	dev_warn(tps->dev, "%s: failed to register partnet\n", __func__);

if (desc.identity) {
	typec_partner_set_identity(tps->partner);
	cd321x->cur_partner_identity = st.partner_identity;
}

Add early return and fix spelling mistake in error message.

Detected by Smatch:
drivers/usb/typec/tipd/core.c:827 cd321x_update_work() error:
'tps->partner' dereferencing possible ERR_PTR()

Fixes: 82432bbfb9e83 ("usb: typec: tipd: Handle mode transitions for CD321x")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260218214621.38154-1-ethantidmore06@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index e2b26af2b84a8..43faec794b95a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -820,8 +820,10 @@ static void cd321x_update_work(struct work_struct *work)
 			desc.identity = &st.partner_identity;
 
 		tps->partner = typec_register_partner(tps->port, &desc);
-		if (IS_ERR(tps->partner))
-			dev_warn(tps->dev, "%s: failed to register partnet\n", __func__);
+		if (IS_ERR(tps->partner)) {
+			dev_warn(tps->dev, "%s: failed to register partner\n", __func__);
+			return;
+		}
 
 		if (desc.identity) {
 			typec_partner_set_identity(tps->partner);
-- 
2.53.0




