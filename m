Return-Path: <stable+bounces-237524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IdLDp0n3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:27:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70253F16FB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B013183883
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2F0345CD0;
	Mon, 13 Apr 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eamiW5ib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC733C536;
	Mon, 13 Apr 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099679; cv=none; b=oDhQe08YNkAGCdzcJc6ZY4Ii1JjSpBKxHO8fFzVB3KpMeeA7MyhPYXVB64CHLyksBRO+O1nOBanP46IMQbhwUM/53TFqmtdBkFzZ6PeddQ0pSXNL3rMjwLFYyYjVQPJOZYLCTOT16UhB4FnSt4SZXF96JijybD+EMGHedwU7Qqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099679; c=relaxed/simple;
	bh=G0SdyRhGxKPfV9hIt9y7c9TX471Of8masXoY3zNSwHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN34CKeV969k2ooQHJbaGSARG1I4cIZRX6JJvt6h9C0UQEuKBcEAe685WKityX7RXLjZSANDoJe39I/bGPV5VnQdDiuA9F+U3A5qsxpx2eIwy/w37xw4dOfoyE7HDrU3RyWW8LRCTRGT9RacXS7HdQm1FYP1zzXnBjmZCaW2tqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eamiW5ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CDAC2BCB0;
	Mon, 13 Apr 2026 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099679;
	bh=G0SdyRhGxKPfV9hIt9y7c9TX471Of8masXoY3zNSwHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eamiW5ib8VeGtJjoE60ddkgG/bJubP8TVy1lYo9JcRnss4tXpBtpAnBpbrlwNKcNO
	 6wwb2Nsv1a0jTOiA56ITPTs271G6P7fNxmi5Xi+6xp8/xxHxJ0uMJefmdUV9yTCijY
	 3pVXZkYbi41c5D6uCR8IIj9/mIlEyGMYi8Y+CvGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Ryan Lee <ryan.lee@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 5.10 433/491] apparmor: fix: limit the number of levels of policy namespaces
Date: Mon, 13 Apr 2026 18:01:18 +0200
Message-ID: <20260413155835.239306457@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237524-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B70253F16FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -249,6 +249,8 @@ static struct aa_ns *__aa_create_ns(stru
 	AA_BUG(!name);
 	AA_BUG(!mutex_is_locked(&parent->lock));
 
+	if (parent->level > MAX_NS_DEPTH)
+		return ERR_PTR(-ENOSPC);
 	ns = alloc_ns(parent->base.hname, name);
 	if (!ns)
 		return ERR_PTR(-ENOMEM);



