Return-Path: <stable+bounces-256669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SviPH9TUGWqFzQgAu9opvQ
	(envelope-from <stable+bounces-256669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:03:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E5606FBB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6AE31CC3B6
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D768380FDF;
	Fri, 29 May 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBlEKY3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E98375ABE
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075318; cv=none; b=oSHHtT9GVrWYWAvsXvl20O7dDYcZrRy3vmUn0k5zqhQsiwdY3/XmU/ma1ScaPSlEuGeylkIExhC4wUuiemP/3lvJmWYyPvDC36KudZ/L+YVHuZ5rG1qb5UAInVSKzsa2WV+AkhkwXQbjfsy2MMgJ0gxUqJniCeuPmM0830r0zPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075318; c=relaxed/simple;
	bh=SP87wxiXhEyrwlmofz9M/Xv3p/f91QTgQKgmTEjPm+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKJAzPsOdTHuNxhD3xft+Z+YlJMwtfwkxtzOfuwKBLGV9l4cjGGtSZvKkWLaW8Q3b9QKS0jkT+bc+dD0HNvZiAZmBhUqV0LuTW6sUulK5P2I/Kekkth97ns0VlZKEKoU99ewJu7+66vGdgnizD/cMhUPXhckWIWKc1pCdDZWAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBlEKY3L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0C81F00898;
	Fri, 29 May 2026 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075317;
	bh=3d3lBp257oFUXUslfBUX5if6YtFxnOPS2Ui473MuB/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBlEKY3L47Po+EU9Y77wJk1sOxLul5qU8Kox6kQK2tp+KmNipyfZ5kxrYYXaeArV6
	 LQ0J3e27fMvyCyqKMDeP9GWsPuBsscOzs1nXcdiGHdK63t9c/6nGp6KEZX5bzxDlFu
	 9ksV//M4TyN4SnzaBzSN+yhyYxJSq80SGxgOnZf9+LGHq8jcIibccjil657b0pPfmN
	 nXiYlJ2S8rfkeNCBy8MFsO66FZbL3/3cOCkWi8Suk+X781IXXCVdVLcWjYHC4WnMCc
	 Ymvj1vTlP+ormm+wsh5lrOeuDyLAUG8fOgsilBBpIq6MK2BDSUhbVMM+n8ibUVoNNC
	 ifjwjmxDLl5IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] smb: client: require net admin for CIFS SWN netlink
Date: Fri, 29 May 2026 13:21:53 -0400
Message-ID: <20260529172153.1318415-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529172153.1318415-1-sashal@kernel.org>
References: <2026052852-envelope-curly-7d36@gregkh>
 <20260529172153.1318415-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256669-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C34E5606FBB
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
 fs/cifs/netlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/netlink.c b/fs/cifs/netlink.c
index 291cb606f1496..ab055f98e1720 100644
--- a/fs/cifs/netlink.c
+++ b/fs/cifs/netlink.c
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


