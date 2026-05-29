Return-Path: <stable+bounces-256668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ59B4vHGWoIzAgAu9opvQ
	(envelope-from <stable+bounces-256668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:06:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B54CC60619B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1143300CE93
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FEF379987;
	Fri, 29 May 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/5MGLc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C64337A487
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074375; cv=none; b=pYjLdJy/TZsR+czrnUcLQoJ2KU3xKECOQ6kRpL/kV5Nywx5rSmpohHwaE+UAGOTBuQcWJ4L4t5tEJPcQCZdvUmbTDnn8WNXU/CQYyjgvOYxX6rAdcV1eTYHM5ASGHvK5Rm2xGBlY88cZnTO7udF1WNP0c7V+v/r9EuOrbMQ7aRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074375; c=relaxed/simple;
	bh=GiPyT9f2NMmxbvAhqSpovWWi2uHYD+HH6LcBF4D2WFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR/bAbmSgtIJOrZtLp1Ww5Ula0Mp4/4Nli07TnbASusMm4rtXXqQ9b/4YrFSx8F/u98m9ZLAOZR02k1yh2WhwlJmOuMoBEWOpDVLFXCSe9okOQK+HrjloDEtu9Un85GUu3dH8Jd4ajRshHuhCb8EqZWlvR2tn16Q2Pn6JLYgCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/5MGLc7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732451F00898;
	Fri, 29 May 2026 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780074372;
	bh=OTPSHFPhMgSqE7vcfKdXmi9O0JsjkByREZBd+1A9fUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/5MGLc7D+8rbXYa8u0bipB/GemV89nAHzz4g9E6HeYPWZrW6B6IgA6FfzkxRRx+X
	 CbiuVFFw1altzS0CMhV6erFuvSwveO/yPOHS+jIzQHmeOi8RIshHFFx/doE9AXlK6D
	 cZn5gM/AOAThPWZGtdKgsE1Uq4bL+sxG+O7i22lx8UFp7AYXAdDJM9v4BhT5VWbb9C
	 LpdkiSP1y71vBPI57zSDqrMer3JNLQ36XffBswQ6kqhlwN9wR5JLEZ+hvHE3upZGaW
	 9+esbo5PsBIARuqAmP6swamN9B3ZUgPvNCJ9Q7HgvEGIb9iXacF3cgSftnEWG0NZQB
	 HE6eKafunKnwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] smb: client: require net admin for CIFS SWN netlink
Date: Fri, 29 May 2026 13:06:10 -0400
Message-ID: <20260529170610.1279657-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529170610.1279657-1-sashal@kernel.org>
References: <2026052830-undefined-astronomy-bd6a@gregkh>
 <20260529170610.1279657-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256668-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B54CC60619B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit d1ebfce2c1d161186a82e77590bf7da2ea1bce91 ]

CIFS_GENL_CMD_SWN_NOTIFY is the userspace witness-notify command.  The
intended sender is the cifs.witness helper, but the generic-netlink
operation currently has no capability flag, so any local process can send
RESOURCE_CHANGE or CLIENT_MOVE notifications to the in-kernel witness
handler.

The same family exposes CIFS_GENL_MCGRP_SWN without multicast-group
capability flags.  Register messages sent to that group include the witness
registration id and, for NTLM-authenticated mounts, the username, domain,
and password attributes copied from the CIFS session.  An unprivileged
local process should not be able to join that group and receive those
messages.

Require CAP_NET_ADMIN for incoming SWN_NOTIFY commands with
GENL_ADMIN_PERM, and require CAP_NET_ADMIN over the network namespace for
joining the SWN multicast group with GENL_MCAST_CAP_NET_ADMIN.  The
cifs.witness service runs with the privileges needed for both operations.

Fixes: fed979a7e082 ("cifs: Set witness notification handler for messages from userspace daemon")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/netlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/netlink.c b/fs/smb/client/netlink.c
index 147d9409252cd..0dd10913c37a0 100644
--- a/fs/smb/client/netlink.c
+++ b/fs/smb/client/netlink.c
@@ -33,13 +33,17 @@ static const struct nla_policy cifs_genl_policy[CIFS_GENL_ATTR_MAX + 1] = {
 static const struct genl_ops cifs_genl_ops[] = {
 	{
 		.cmd = CIFS_GENL_CMD_SWN_NOTIFY,
+		.flags = GENL_ADMIN_PERM,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = cifs_swn_notify,
 	},
 };
 
 static const struct genl_multicast_group cifs_genl_mcgrps[] = {
-	[CIFS_GENL_MCGRP_SWN] = { .name = CIFS_GENL_MCGRP_SWN_NAME },
+	[CIFS_GENL_MCGRP_SWN] = {
+		.name = CIFS_GENL_MCGRP_SWN_NAME,
+		.flags = GENL_MCAST_CAP_NET_ADMIN,
+	},
 };
 
 struct genl_family cifs_genl_family = {
-- 
2.53.0


