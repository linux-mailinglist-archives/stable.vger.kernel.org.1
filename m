Return-Path: <stable+bounces-257425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uML0MJ0bG2pk/QgAu9opvQ
	(envelope-from <stable+bounces-257425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:17:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62660F504
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0ECD30F5D68
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B8481DD;
	Sat, 30 May 2026 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KznRchGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16FC3AFCFB;
	Sat, 30 May 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160953; cv=none; b=RZAXhDGL8vphx4ilA3igkYyVS7gA2ZsKLC+qA13zMbKPAwKNdN46WvloxEwktWe5f5CjK5Bt5uUtr1lNJu29NEbD15U8Vex7cqyv69NWvRLDy8OL5RJBXjTU1/lpVMPlRD7RBwbRiQZBeXtradyTu6RsPR5Tv0q+Ja6XAk4OoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160953; c=relaxed/simple;
	bh=mUvOx+MaaLjZ5LmLNlRMGEQs5liWWgKLwBalP8ZFaBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIx0F1sS28PnO/VDfY2H8RH2mq5Ubo3klgxXlOUuQ2sxQMVeH3tGk3OIr8XXIbM+kuUuQJ69Ual916TwZ0OIf8mAeZWR/tkWkZqu/sdqp2GS14DwGXm06Jrhsy05FGSSaK4P8G7+EwMLjEi05EQ6ufPf7oTVxukUKtJgmJo6Ifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KznRchGQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED52A1F00893;
	Sat, 30 May 2026 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160952;
	bh=rUC46mSl69a5od/KAs/WqW9k+ZXdtrLJo78WGUkRGRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KznRchGQedW6uBe+SZ1sEtG8y2oe1A+qe8GtYjiI2LFlQX4Z+cPEqf5I+Jp0aChUO
	 KR+VDMMsse9OeYfDbaLxvOuFMCNzS24gwBehxvtWNwaAHR7DTNZs6orU3gS0buJCDX
	 J4HWyo8vB86k+sCAhrRKZNql0E5uFGd2IBzSSOJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taegu Ha <hataegu0826@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 483/969] ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
Date: Sat, 30 May 2026 18:00:07 +0200
Message-ID: <20260530160313.641061670@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257425-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5F62660F504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index f184368d5c5e7..89973d0959a68 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1062,6 +1062,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
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




