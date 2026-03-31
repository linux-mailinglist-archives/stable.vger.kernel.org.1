Return-Path: <stable+bounces-232354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK2cDhIGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E636EFB8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6117F319763F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752702D595D;
	Tue, 31 Mar 2026 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFb1qakC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E32FD681;
	Tue, 31 Mar 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976534; cv=none; b=GylB21d9tln8Zu++fjemto/dHje8aH/cO+VV905kBIleya8L1g+wlXxx0hzjlR7I+/GMW8zxxcNYEoDIIrShNMZA5seamIhybtkv3FLL6pFDq1Vsdqn8e+3T+JGN82/MPWm1tEH9JLL2YxFHyh0ytsOnDWNcG8Yb3QLXkBErlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976534; c=relaxed/simple;
	bh=O1UO3+hwJwR0uZTq2juVgiCg9mEO+uRpirHOgK72yvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoUmPQjrD6WUElNPeSUdPfyFoJnSWjxcILXKCxVjXgGcne30sLXzofW9/uuilMq18YldC4HLdajirx8kr6jVqru/2+nlyxGPU6cUKj0gV7k6PbT3BhNM83YJS8EcWjM6EnEMjypzysAg7MoJjoZTe38kN984PyuxUNujT//9aRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFb1qakC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EBDC19423;
	Tue, 31 Mar 2026 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976533;
	bh=O1UO3+hwJwR0uZTq2juVgiCg9mEO+uRpirHOgK72yvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFb1qakCqAKeK2POkaOk2OIIFs7TjrNh1PkANXALtPnJCpsqpRUYv4PzRN6h3sReg
	 zy2d+jR5rRdvCgVkA6ldJolHoLrbRVeWFsj+pHmKp9bVHJ6J3BIbkY8OSwanfX7Daq
	 KoVKhBgXix4rWYHa3V8rW2xHVMn6AmgHrIabiYmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Pirko <jiri@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 096/309] rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size
Date: Tue, 31 Mar 2026 18:19:59 +0200
Message-ID: <20260331161757.022815883@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232354-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,queasysnail.net:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B6E636EFB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit ee00a12593ffb69db4dd1a1c00ecb0253376874a ]

rtnl_link_get_slave_info_data_size counts IFLA_INFO_SLAVE_DATA, but
rtnl_link_slave_info_fill adds both IFLA_INFO_SLAVE_DATA and
IFLA_INFO_SLAVE_KIND.

Fixes: ba7d49b1f0f8 ("rtnetlink: provide api for getting and setting slave info")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/049843b532e23cde7ddba263c0bbe35ba6f0d26d.1773919462.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1960b59961cb8..b389210d518ef 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -707,11 +707,14 @@ static size_t rtnl_link_get_slave_info_data_size(const struct net_device *dev)
 		goto out;
 
 	ops = master_dev->rtnl_link_ops;
-	if (!ops || !ops->get_slave_size)
+	if (!ops)
+		goto out;
+	size += nla_total_size(strlen(ops->kind) + 1);  /* IFLA_INFO_SLAVE_KIND */
+	if (!ops->get_slave_size)
 		goto out;
 	/* IFLA_INFO_SLAVE_DATA + nested data */
-	size = nla_total_size(sizeof(struct nlattr)) +
-	       ops->get_slave_size(master_dev, dev);
+	size += nla_total_size(sizeof(struct nlattr)) +
+		ops->get_slave_size(master_dev, dev);
 
 out:
 	rcu_read_unlock();
-- 
2.51.0




