Return-Path: <stable+bounces-229145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HdlCqRewWmHSgQAu9opvQ
	(envelope-from <stable+bounces-229145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:39:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 628FC2F6A64
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2F03300BCBA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0A23C4F2;
	Mon, 23 Mar 2026 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Wp0k6gs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F263B6370;
	Mon, 23 Mar 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278204; cv=none; b=r1l3/oH/9HRBnbSVwkn6ZqnvGK/gzU4NfqAv3KZciKIZXprGi7Q8uO+EQYENDE5NFRoOFRBMywW23expu9BEWSg7ocqcUwlAUADdc9ZmxfREdoa9bpQPFDvTv37WhBNaH6CNk+ChomfQZH1EXbJoRfsEWc4H6dMpdnZdbBSKmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278204; c=relaxed/simple;
	bh=+/Bdhsfnc2p5m0vzli10FdOgVxChApS/Si+THwUm8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNPYoZ6Zo2zg1oYocOBCo+fnww1bdtIeWwl0fBS9nDy/JeZXTxpgfnYB8FpKSiDgzuQhrtnlMqxiCuFlDqZqblEDJUVyZa1tmDxDBdoAhCI99V+/mlILq0uaLVhH3j4FUCnQKk2BNmw0wawGtQcNbr/D+0tbsDq7LAIJE0/ytWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Wp0k6gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1F1C4CEF7;
	Mon, 23 Mar 2026 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278203;
	bh=+/Bdhsfnc2p5m0vzli10FdOgVxChApS/Si+THwUm8pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Wp0k6gs5RSwgOTnUHXHecJoUltHN1f7+ByG3c9mX1j22oy8lcG6f3yHCPxJ7NApF
	 Al19MZhI8ZZ+WvJurNQxXQ9K++gQl92pc9xhnPWD9n/y66e4FLBH2XU/mafbo0pH8Q
	 gCFLhRC6SjR/I2u3/vgXG86NczjZf53oPhoNNiJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Ryan Lee <ryan.lee@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.6 190/567] apparmor: fix: limit the number of levels of policy namespaces
Date: Mon, 23 Mar 2026 14:41:50 +0100
Message-ID: <20260323134538.554189184@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229145-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 628FC2F6A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -260,6 +260,8 @@ static struct aa_ns *__aa_create_ns(stru
 	AA_BUG(!name);
 	AA_BUG(!mutex_is_locked(&parent->lock));
 
+	if (parent->level > MAX_NS_DEPTH)
+		return ERR_PTR(-ENOSPC);
 	ns = alloc_ns(parent->base.hname, name);
 	if (!ns)
 		return ERR_PTR(-ENOMEM);



