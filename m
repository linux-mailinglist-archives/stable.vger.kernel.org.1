Return-Path: <stable+bounces-250229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBNTB6PkDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:43:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BF9592514
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92DD330640B8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F236404E;
	Wed, 20 May 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nr9HJqTg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F62C15AB;
	Wed, 20 May 2026 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294867; cv=none; b=VUqbHN9MVMnOlg6PmXAhSgKeFYqRLy1NzsyJO8lglXMwgqgsdOmNyoUK6mf1w3YWi4Ac9DzBpehSeWVuRLMJYbicoeSkuFTHZpmh4+FVauukuxQnC0V+lX6fI7/tVkNazxvBDEauRYkbYNxEA31ZKb3pLDmDLqtTh3SoIbbIGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294867; c=relaxed/simple;
	bh=F3iqUIieut8wG6A+2R/0CMxMH1MiBa5bDVj7xh+aRyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNCSve1mX7FIECIjo1Wvm0C6JBqEgt0BibbF3uhVM1QyUNk/k/KhIbo4V9d68K79ASmUilk+F6hh8re9NZ5PHdn5wImFNoryt8DKsfFnHWKFOzoqNJJ2f+ElNaYliVET7A/u5llnHio4EewACVaqpKAiXd72Lzdea4nfNmXeUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nr9HJqTg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B903B1F000E9;
	Wed, 20 May 2026 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294866;
	bh=aELGuLXj1VTC/Qg7W+J0tXnwg8ijLT6c/B9yW6Zat0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nr9HJqTgA5njWfG+JPnzqjlvvSrQCxKYnQt9Npt4RplruHcUZqjJxBlxV+8VWdX6t
	 577z2+2AcJTV5K4x7wCDMd6XascunlRiEqQTMmbngFAMCCaBMaB7Xdejb8BpbswjPS
	 cRvEl6MJEeSDelzlG9Y6H/3ekbhieoZvTOhXDXLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taegu Ha <hataegu0826@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0201/1146] ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
Date: Wed, 20 May 2026 18:07:31 +0200
Message-ID: <20260520162152.819993752@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250229-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B6BF9592514
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taegu Ha <hataegu0826@gmail.com>

[ Upstream commit 2bb6379416fd19f44c3423a00bfd8626259f6067 ]

/dev/ppp open is currently authorized against file->f_cred->user_ns,
while unattached administrative ioctls operate on current->nsproxy->net_ns.

As a result, a local unprivileged user can create a new user namespace
with CLONE_NEWUSER, gain CAP_NET_ADMIN only in that new user namespace,
and still issue PPPIOCNEWUNIT, PPPIOCATTACH, or PPPIOCATTCHAN against
an inherited network namespace.

Require CAP_NET_ADMIN in the user namespace that owns the target network
namespace before handling unattached PPP administrative ioctls.

This preserves normal pppd operation in the network namespace it is
actually privileged in, while rejecting the userns-only inherited-netns
case.

Fixes: 273ec51dd7ce ("net: ppp_generic - introduce net-namespace functionality v2")
Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
Link: https://patch.msgid.link/20260409071117.4354-1-hataegu0826@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index e9b41777be809..c2024684b10d5 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1057,6 +1057,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 	struct ppp_net *pn;
 	int __user *p = (int __user *)arg;
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case PPPIOCNEWUNIT:
 		/* Create a new ppp unit */
-- 
2.53.0




