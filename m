Return-Path: <stable+bounces-225189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJmYHW4is2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:30:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80532279306
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D648A3037D90
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CD3B0AD5;
	Thu, 12 Mar 2026 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dbodpXxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D317396B6A;
	Thu, 12 Mar 2026 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347294; cv=none; b=kGMNsCJRwKpgQPBtm9XMCiltJO2q2LOsl6b3iGBqx0/aZqhRRitsnhuRHZ0kuezcaHDvhpebIrQcNO2VPgXV2PmH7fniYzqsH/UmqoB3WtkoD8Qj1eyhiC5bQprF0ZiNg0XKzlHKobM6CGyWy3RLJuF+6Dbp/ZJme46aRtcfAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347294; c=relaxed/simple;
	bh=vW2DHIsuDiXo0FiA1vrfi6wQn/Ra84seVYMxGIc5Nek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNS2lhH+7CI0FedKTJZlV6LD8EIAgz0YxKLNnnlewFSnF0G+9gvX4UtCe4jx9XIdLYw3ZWxdRGRG1zzemLINksWIVJom4va8KQE08BxZBEiOUy+JbkYUn5tmHgbRKDJV41/0c9zGqJugSqqJOP9+WRPFVYwvqF4FsZxMBvkY240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dbodpXxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B1EC2BC86;
	Thu, 12 Mar 2026 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347293;
	bh=vW2DHIsuDiXo0FiA1vrfi6wQn/Ra84seVYMxGIc5Nek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dbodpXxhAD6Btw4vH+SHa4CQ3VrA6/GAE1N60j9xXRawr4ljQ1Iw2tO3wCG2l0Dtv
	 HhA++fLs63Ai4OcyUJc22yeIXRhh9EP7DP3AYPlQHjMXNxVtkJYHOEBs8zSlCrPJaB
	 itS5vEHfLzOG8eSryFSlYe0viLSQXWTXAG+oRbHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Ryan Lee <ryan.lee@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.12 253/265] apparmor: fix: limit the number of levels of policy namespaces
Date: Thu, 12 Mar 2026 21:10:40 +0100
Message-ID: <20260312201027.480763995@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225189-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualys.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,canonical.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80532279306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 306039414932c80f8420695a24d4fe10c84ccfb2 upstream.

Currently the number of policy namespaces is not bounded relying on
the user namespace limit. However policy namespaces aren't strictly
tied to user namespaces and it is possible to create them and nest
them arbitrarily deep which can be used to exhaust system resource.

Hard cap policy namespaces to the same depth as user namespaces.

Fixes: c88d4c7b049e8 ("AppArmor: core policy routines")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/include/policy_ns.h |    2 ++
 security/apparmor/policy_ns.c         |    2 ++
 2 files changed, 4 insertions(+)

--- a/security/apparmor/include/policy_ns.h
+++ b/security/apparmor/include/policy_ns.h
@@ -18,6 +18,8 @@
 #include "label.h"
 #include "policy.h"
 
+/* Match max depth of user namespaces */
+#define MAX_NS_DEPTH 32
 
 /* struct aa_ns_acct - accounting of profiles in namespace
  * @max_size: maximum space allowed for all profiles in namespace
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -223,6 +223,8 @@ static struct aa_ns *__aa_create_ns(stru
 	AA_BUG(!name);
 	AA_BUG(!mutex_is_locked(&parent->lock));
 
+	if (parent->level > MAX_NS_DEPTH)
+		return ERR_PTR(-ENOSPC);
 	ns = alloc_ns(parent->base.hname, name);
 	if (!ns)
 		return ERR_PTR(-ENOMEM);



