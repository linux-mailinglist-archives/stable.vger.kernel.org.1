Return-Path: <stable+bounces-237523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI4DEsYm3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C72543F1547
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F983180F7E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C571833F5AA;
	Mon, 13 Apr 2026 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="potycCkV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2E33C536;
	Mon, 13 Apr 2026 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099676; cv=none; b=Vh0HpoXKAKxmgVnB2Q5tPeoQVfZ0FaLXkEqqeB3LBAy+P9GE1IUGPlflh7Em5WEZt/WH04r2YDBY/F4fGzA7uFVmR4QxgIVK8r/Z2xMHksMPGJQ/WuIwB+VfqjcTtB3k5/IqErC0ziOeUMNH0u+OUviDIG+CsPFmEZXsIg8LSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099676; c=relaxed/simple;
	bh=fpn/GW668OgqBtuowBzu+x23ykD/FZtaTrnP4EaBJ1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAIY+QbQZPnebFTORzIHt4Iw26BOyJRVlN/UfI8lLF+23ZF8u1KBGEfKX544JzGMotlJVY1fC41vbGem8z5PUDVkkbmBL5JRTIdP46HIo+pQW8Pn2Lbi2iVBeD94g0nfM5ZwZMPGJW3EHJ8U5DMVblV29tkHV++fkcCpO+rWr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=potycCkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B325C2BCAF;
	Mon, 13 Apr 2026 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099676;
	bh=fpn/GW668OgqBtuowBzu+x23ykD/FZtaTrnP4EaBJ1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=potycCkVeDPa96q3XAeCVXESDEV6TeZYqRX7IFsxfx+DEu6xVNVRRYglW9qBtY1uc
	 1sp3bmfq0WtiLkn6ZEVUa/388xZbxS3rIahw8pC/MRBkPTOY9kiv4ltyvoJLq5pcuV
	 D/TP8f6gQh7MrLiVjrpvBPEf8dMr/o+1Opy06A/E=
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
Subject: [PATCH 5.10 432/491] apparmor: replace recursive profile removal with iterative approach
Date: Mon, 13 Apr 2026 18:01:17 +0200
Message-ID: <20260413155835.202098862@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237523-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: C72543F1547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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



