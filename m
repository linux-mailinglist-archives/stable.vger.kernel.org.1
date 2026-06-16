Return-Path: <stable+bounces-266130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AxXHEFiYMWr3ngUAu9opvQ
	(envelope-from <stable+bounces-266130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:39:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C064D6944D8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:39:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XI9T7UYE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266130-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266130-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79CB831F3411
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099143D4E8;
	Tue, 16 Jun 2026 18:33:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBF3D8902;
	Tue, 16 Jun 2026 18:33:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634820; cv=none; b=jUciY1AJhQwD2u32wB62HRvZPJo8seAwT/P93tUCfx6QoYj9IePN1xjWixYoGcjThklYkJQtaxO8CxU9skJH42DSJJ5kGnsv/C+fMVw3CZd5uRf1DZbt/Q1thYWR06/Nov3Epv8wi4BgFvdJe4wOye5zrU6J29lWSDT2UFSNQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634820; c=relaxed/simple;
	bh=dN0breCfDOVhXFMQZfTraM/m2nRmgWjMrVHudGhbWWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxoF946/RxK1DO5ezFRwwI0gtHvZKIo+BdThEZu0BSeHHiQsyDDmGvfIqypEkvNgjtdPk/qWNJ5aWfR96xOdua3MKyqbQvrJ8qgMUoYnqpgsV6cHtlrZafOj3I1p8nuPApVoQ7f46eXGtJAHgEZr1xPJZxaMyvJzIxs1GiLlqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XI9T7UYE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906561F000E9;
	Tue, 16 Jun 2026 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634819;
	bh=P51RblIe5Ruh4fDKAMGYQw56hHbwpvOeO9CVgxTeHdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XI9T7UYE7CRpW2UcqsMkMSRcBwgWFj0snmzJei2hsaywtzAmC2zGPNjnxPF01DAe2
	 6ZRun42ksmJsNEB+LJK+X/15g00tGVU/CwMCkhEqlqozzm2ZAE4CLYQ57Z+KhdeiJ9
	 pgec4Q9zanYQoFgno0WGV6QPphtc7/SgBo8XIf0A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 338/411] smb: client: require net admin for CIFS SWN netlink
Date: Tue, 16 Jun 2026 20:29:36 +0530
Message-ID: <20260616145119.167158381@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266130-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:stfrench@microsoft.com,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microsoft.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C064D6944D8

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/netlink.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/cifs/netlink.c
+++ b/fs/cifs/netlink.c
@@ -33,13 +33,17 @@ static const struct nla_policy cifs_genl
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



