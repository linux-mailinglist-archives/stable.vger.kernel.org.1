Return-Path: <stable+bounces-235924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBPfAoSR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 708483E7E57
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D21D30099B3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E63644D0;
	Mon, 13 Apr 2026 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="PeiBWhF5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036B1E7660
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062846; cv=none; b=ArFgL/E+2RjspGwr/YyMu9dHnPSKxL6BLuCDUUCW1fp9+0XDDqzNbz+vj6/E5xCnXkzo66olCeymtaqu3/jVTnOO/DVo6fFd1oTKHotaBt6XKGVY1OBbc3H4XqGJr4ezMU62Ra7+KOfTpM9PGdqLnSQDW15MzZLHQr96tcWeqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062846; c=relaxed/simple;
	bh=iSwAHWMQHzq3HzqOTGgLXBLomUTP36wTyGFD/68uQHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6LeC6lQSilWdssZ08TGE/JRvyAf2pW69HQ+UDp43uzLO4nGajRy2zAFQFdyg1b6TQWCwxQmzm+lNcsdF7xio5fHDOLF4kPK/H3m+7Ig3UY/2uIs+PceDtAcazwOq41Mq47fYyG9jinsoPbJQfPltfMbkHj/pPAAoX+je/2oBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=PeiBWhF5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F41B73F1DA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062843;
	bh=cvaakyxmw2iFWa/Oz32lFQKfrDSf5bugrXx1RWDcmTw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=PeiBWhF5/OGRDqd/8+yYR+JfJw8In/MglYs/6aVlxmV0wFPbvrEPu36vW06IvyzZw
	 MxjoilZJO7svORlNRVMGOIeutROYN0lq3ztx4PXJeLdQdXzNZzS6UtrCPgqXdBULxN
	 p2q1A3CWZpFm9MR1+N7EFNpEnBB4nXI1OspCzHfBFsazy4Xx2rYCx8lGgeKw8fgmmy
	 +IUS3cUd1b/I5BJqBu++EDg5lSzdk3VHFgmCiQJIyRvJi6QRdFqT1gzx2II6yzjaok
	 4I6VhmXejSDXKrkrlBxTpEiQ+tadwgciYh2Kn/47DfumxAr25YIwlo/lYmWC6RW9az
	 PFGIj0G4tLuwGfNZ4WhvkdHSOI8IviOC3FRiqQeE8ZubEHEjMEM5p3rZ7HsiGAQWFB
	 UAVX5iEI56vmQi43AgZt56Lz90gtBSAORsw/Tj/UzMXbcfdPWN1U9C8Jldi4qvN5t9
	 3T1e+nbWyUub+PV1KPDRexsbT5a5FA1Fo/v0tu4SVc2dJVEiIAuHeRPcbCky5HEJ/U
	 5MCuNmqyDpcIiyDHhUoR3Eb2dRuYMS8OWXR4FfOPUDv2Whgg3hCDkcLllooPgGqgwS
	 eIIzCXDUilnEca4C+i0bdQdgPRfRrlToeozV6wajV3ztUn8WFsQbgPUYnKy49I2J4U
	 n4Uo15pkExNuPrRzrAOuJNso=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c44bf176so3940122a91.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062841; x=1776667641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cvaakyxmw2iFWa/Oz32lFQKfrDSf5bugrXx1RWDcmTw=;
        b=PmcOFED5fUcnU5iqczZz5J4aXVgDPFcSTdx2QLbyRQUW0Qz5YMlDTHmz/hcs9GziGb
         YTsMaV1tx5F8IS0sGU12hz8LJRuuJU9VZIaz8qOoGlS9rt/1YJgnyHVDrvGltB1a38Ql
         JEDysshwA5FhPyQnNotGS5lkrnTDSpnQHblCCBB9OtAFdtMRWPOZ7mplXJO9rkKsqk+R
         FqmVlFxkcl7eKdBSY6oiGYdUDXNLw0H5U3cPPhsbgVSynhEreZYT+ka1/acin68ppd3c
         zDLkWTPckTLsPfp0kZnAxkeJI9JniqfhDKx1DfPVgD6sAHE58U68WwwFQ8ZCjc96uKw/
         zESA==
X-Gm-Message-State: AOJu0YzJV3iexu3awNGhAW3sV8m3xYq3PGcaFWH7Dz03pUW8ceITc2fn
	bHbdvbC4SLYCwjRLUpssNE0cqFExQyCAFmK/OLdYQmh0a73bF/k4z4r302ejTAGNxs4h5h8jXR1
	lS5pDD3e/QjuaG4btjvD1jCM1xU7aXW1ua/GKW/1Abbfp+oKhbGJINcUjwusiqpkVMNHxI1a2X+
	ZdK2VkGw==
X-Gm-Gg: AeBDietnbFvdwXUmMUu0dxBvYzMXD4tljjWWreeM6pX9VADo0RddG6sk0s7rg1HGKy4
	1xuzRYmTKOzG3bQhFAobpUEmlT93WrCqA3BIQhSzUEKEpvZPr4Y2UbcPo7DZpU8VqA4nC7qNrYY
	sXiCvUsCMTBYBMQEv9hSOz/jSRGIFvmGQijqk94MA31xqCiMPdRPKjtK80nQjw50odydozW/N7Z
	x5EumPd3gN774Hs8cWTpJBwdQQSWHaJMoJE3XC4Q6XBfgU/VjWc0Rs7GURD4qZ9u/iXKM27o+fr
	02Y9e8EqCJutX08Qk9rAKJ9nAkqOGJwI39gF3cGw+vmm18o9C3ErtmKAXmQLrdHnD3uCn7KMnM3
	XcHW2xz3NUlJnR8nMpIbOIcPBAtw=
X-Received: by 2002:a17:90b:4c4e:b0:35d:a2d3:5c31 with SMTP id 98e67ed59e1d1-35e42858252mr13483546a91.29.1776062841283;
        Sun, 12 Apr 2026 23:47:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4e:b0:35d:a2d3:5c31 with SMTP id 98e67ed59e1d1-35e42858252mr13483537a91.29.1776062840962;
        Sun, 12 Apr 2026 23:47:20 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 98e67ed59e1d1-35fb2f077d3sm1475619a91.5.2026.04.12.23.47.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:20 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 03/11] apparmor: replace recursive profile removal with iterative approach
Date: Sun, 12 Apr 2026 23:46:28 -0700
Message-ID: <20260413064712.1581137-4-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235924-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: 708483E7E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 security/apparmor/policy.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index e59bdb750ef0..6130811edb94 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -146,19 +146,43 @@ static void __list_remove_profile(struct aa_profile *profile)
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
-- 
2.51.0


