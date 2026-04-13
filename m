Return-Path: <stable+bounces-237033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPfdCnUc3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-237033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:40:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0846A3EF7BF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53AFE3012BF1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F4307AC7;
	Mon, 13 Apr 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wtZ+rEq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B01A680C;
	Mon, 13 Apr 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098416; cv=none; b=b2XFy+Gmc1X9DFi0MVWdk9xDtF4gtOdJftwU/yLdekGQjdN+lfvqdArFR1FTx6SA0JcDSa7twqfjT+dZ6XPOajHBtnzS5jImqmCsbr6oJPhoUZqxUhsvrQzIMH4jJ+Eg4v7l/6haoemPMi3Nv45K0jQaHXWfEub3EohojzlxVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098416; c=relaxed/simple;
	bh=FJPiK8BzCml1qKcxVn32mRXT7NHjXbl942DZ1633VEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdQGFg85F44PF6lstdK+P7sHc3VreHH6AzctX3j3K2dVAKeFtLBuQaUpjgbi52L/qEAAa72iEIPGimBv3CuqNL5LaqLvep2iRp+TZiorRum2Q0VgmMex058BJGLXife4BNghk2HvRbLAQpTfZ9VauVIF9SVNCXRMV2Wxab8LzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wtZ+rEq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BE2C2BCAF;
	Mon, 13 Apr 2026 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098416;
	bh=FJPiK8BzCml1qKcxVn32mRXT7NHjXbl942DZ1633VEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wtZ+rEq1HWFp4AHZOtj03+skTgJOswW5inEB0P8jumOp80jGDEF/JZnV+wg/RG02t
	 kVyw85RlRJ05vwaF+Px1GeKMI37+XsEEe0TDBNsF+t3M38fZgksDP5PjUlIrBJ8pav
	 fwVdXRQ4fd3dHl1zyJZnxqgzrQa4OIgVylgg88jE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 5.15 517/570] apparmor: replace recursive profile removal with iterative approach
Date: Mon, 13 Apr 2026 18:00:48 +0200
Message-ID: <20260413155849.815716119@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237033-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,canonical.com:email]
X-Rspamd-Queue-Id: 0846A3EF7BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit ab09264660f9de5d05d1ef4e225aa447c63a8747 upstream.

The profile removal code uses recursion when removing nested profiles,
which can lead to kernel stack exhaustion and system crashes.

Reproducer:
  $ pf='a'; for ((i=0; i<1024; i++)); do
      echo -e "profile $pf { \n }" | apparmor_parser -K -a;
      pf="$pf//x";
  done
  $ echo -n a > /sys/kernel/security/apparmor/.remove

Replace the recursive __aa_profile_list_release() approach with an
iterative approach in __remove_profile(). The function repeatedly
finds and removes leaf profiles until the entire subtree is removed,
maintaining the same removal semantic without recursion.

Fixes: c88d4c7b049e ("AppArmor: core policy routines")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -146,19 +146,43 @@ static void __list_remove_profile(struct
 }
 
 /**
- * __remove_profile - remove old profile, and children
- * @profile: profile to be replaced  (NOT NULL)
+ * __remove_profile - remove profile, and children
+ * @profile: profile to be removed  (NOT NULL)
  *
  * Requires: namespace list lock be held, or list not be shared
  */
 static void __remove_profile(struct aa_profile *profile)
 {
+	struct aa_profile *curr, *to_remove;
+
 	AA_BUG(!profile);
 	AA_BUG(!profile->ns);
 	AA_BUG(!mutex_is_locked(&profile->ns->lock));
 
 	/* release any children lists first */
-	__aa_profile_list_release(&profile->base.profiles);
+	if (!list_empty(&profile->base.profiles)) {
+		curr = list_first_entry(&profile->base.profiles, struct aa_profile, base.list);
+
+		while (curr != profile) {
+
+			while (!list_empty(&curr->base.profiles))
+				curr = list_first_entry(&curr->base.profiles,
+							struct aa_profile, base.list);
+
+			to_remove = curr;
+			if (!list_is_last(&to_remove->base.list,
+					  &aa_deref_parent(curr)->base.profiles))
+				curr = list_next_entry(to_remove, base.list);
+			else
+				curr = aa_deref_parent(curr);
+
+			/* released by free_profile */
+			aa_label_remove(&to_remove->label);
+			__aafs_profile_rmdir(to_remove);
+			__list_remove_profile(to_remove);
+		}
+	}
+
 	/* released by free_profile */
 	aa_label_remove(&profile->label);
 	__aafs_profile_rmdir(profile);



