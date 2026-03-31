Return-Path: <stable+bounces-231741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM+NFO35y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:44:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BE36D0F9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FEC83055C34
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D1423A7C;
	Tue, 31 Mar 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o7Tth3RA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0F423A70;
	Tue, 31 Mar 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974946; cv=none; b=qDIZn98+0+DAnxVz3zG9u0YueyQrln/77aV4dbgUc13wfB4QxofFmhc0if5dyYEh3r/cUYApNMdE0W/Z9cMZ7+Ld1RGgywrnM+M8FBDOiALuY4Few20o5X4FlewkVDHMY5URAb3iDaguF8atg4nzh1/vt91BL2Lq4e2A3jzTldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974946; c=relaxed/simple;
	bh=vgcDsJCQltuTQNtiWiPLrgQmFR7zSbACHXKGKB/Dr1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIlHp9iKzgsmvATpd42sIbffBcvjeTBkopyNI+We7XyJIgoyayVJECc346sUA8RE29myV5AJnwmCVdxk/WvjrsZOLUA574RzyCTMmITCTalSCxI516QsBAcfOAlipuJbIKkxq7n6jCVrUg9CJX0tWBn+vCATt2vCg3in3TG0fAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o7Tth3RA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1595C19423;
	Tue, 31 Mar 2026 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974946;
	bh=vgcDsJCQltuTQNtiWiPLrgQmFR7zSbACHXKGKB/Dr1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7Tth3RAUQsOU3B1G0bRoRf6EDXBnajrfceSTprY88AJgDbjbHtsaVIfhCikj14qQ
	 VKa4tFbOf4QDVjtmeCZCM8P0Z/8adpvzThX4eXbqHLtw/riRp8ekBSUEJpjnK7p/bi
	 fdUDMNzg/xSL7pxzVKe1f4Cr8PWYpgjimNsiB3Fs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 106/342] rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
Date: Tue, 31 Mar 2026 18:18:59 +0200
Message-ID: <20260331161802.916102236@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231741-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,queasysnail.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D20BE36D0F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 52501989c76206462d9b11a8485beef40ef41821 ]

Commit 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
added those attributes to rtnl_fill_ifinfo, but forgot to extend
if_nlmsg_size.

Fixes: 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/0b849da95562af45487080528d60f578636aba5c.1773919462.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b1ed55141d8a7..63cbba9e46b93 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1267,6 +1267,21 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 	return size;
 }
 
+static size_t rtnl_dev_parent_size(const struct net_device *dev)
+{
+	size_t size = 0;
+
+	/* IFLA_PARENT_DEV_NAME */
+	if (dev->dev.parent)
+		size += nla_total_size(strlen(dev_name(dev->dev.parent)) + 1);
+
+	/* IFLA_PARENT_DEV_BUS_NAME */
+	if (dev->dev.parent && dev->dev.parent->bus)
+		size += nla_total_size(strlen(dev->dev.parent->bus->name) + 1);
+
+	return size;
+}
+
 static noinline size_t if_nlmsg_size(const struct net_device *dev,
 				     u32 ext_filter_mask)
 {
@@ -1328,6 +1343,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
+	       + rtnl_dev_parent_size(dev)
 	       + 0;
 
 	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))
-- 
2.51.0




