Return-Path: <stable+bounces-235915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO/SNJCQ3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883953E7DE4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C02301450B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59A38AC72;
	Mon, 13 Apr 2026 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="juHa+W7m"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341A3921C8
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062593; cv=none; b=Yxm+7jwiE2fAyPrcujelmFl6Ty9HN16ZUWX4c6kDM3GpPu6kR5/EuIWtOLWEAsubcsCOGf7DicOh0oEVtAq5RVNl0R1sBEG862SNeHDKybXHb7aJyFtMmZU6Ke7h9qlbiWiEmdVv6BOKvrnoYkyFJmByZZq3wL5cCtCF5eaZ37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062593; c=relaxed/simple;
	bh=CN5OEon8ZWCJmp8kfyVHjQug3m3ysegadoWfYwsRVo0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwHZimVCbxM6WqcV0qEKEZ9luJ412C9+dcwl+ENGzs0L8SZFvoMik/38aU3m6FSIlL4BwyTW9tN0dMkmjoIW6zpBRh5m0mnj2+XdH1HdiiCQPO+bGX5zn/5xw7KQWei7hhcVe4iarFAa/NwPUUJd3NXwL8yL0IO6XlDTSTIOHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=juHa+W7m; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74D263F20E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062585;
	bh=qm3XmClj7Dlc5ctwN7E2dz5uPpQJDdr23Jv8JIG2B88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=juHa+W7mKKv3wln09UTmxi4vv+a3nR+SFdrjzKBwd6hdhs6kBYU/SdO0QPMtzRW0B
	 7hgI9jnoC9XGWGDQUR4BndrKKQcwurhOzwPlkWAUIoBT6b59bgjjv/CnZ2017vBjsn
	 ItYdrO+8fsnQOaVwuuxAzkKaBb6TSp9gFTi+YPBbtnpFGAxIKqNFlaKt3IrbdFsEFv
	 SEcr2pbXAnlkGTJ99ILcBpL9AiMdgJDNfdQrHsqmPQEbqAiWu6CfvMZAAGQzBoaXQX
	 j80f1BL9zhPIauFOps1r6RgBWUeTnLc9IxrzccK1y1ga+vnQg913VXEPkNHOGa92MJ
	 pKXD7DeDZcR+uK9IaMZXHqfT1WP4EISX5/5QnZbJFYXAbvoBApF/9ihFX4RZIQhYcC
	 NCDmgubcuXDy7WeJ4mmOt4Sk4F+tfJamFM/ZXZkTPewiz6N/WJNX8BqNGDsA24yzbM
	 dWY34OOgIlX/kQ3ouKhfxizgCO/6KEFrdqZk8ptVs4/PPUIHxnRl2DhSuKMa6Cimq6
	 BVBOm6dRqT+vC+u+n4P1pPGCREAA2ARcdDP1XGlW5UJzKvxDo9fqBnlgHLG1aDcAfj
	 0b6kv+kMjYZxub7g/kzlEoa9Rfk/TVuyGJCMjTpFt3oWVc57HKTpRPVALuVIWW6Mn0
	 H5Xmj/Eiuctn9h3eXbvPL0zE=
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso2126161a12.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062584; x=1776667384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm3XmClj7Dlc5ctwN7E2dz5uPpQJDdr23Jv8JIG2B88=;
        b=WLQzuK887ElbOwExd9CCqDz8NK3KWfeqRCK+XbwEKjpBpn0dku1V6ztFiK38gjgmGV
         dL/zycOwzU0vesm3G3er6/Cb+DMsSIz+hy85TOHlQ1n6Gxhf5mYf0CRuysMIOvFUAnTR
         YIr8sEUZAhmzY6875pKbyi9Txs75Prue2DI5yLGVsMcEsvLBOpE6HmwapVjFG/RkaNBd
         yeqYSBb0nJbSckezzQwsBLmMxVZwHFEJFaTtJWWGEuGwQpPM47Q+GcvWhuGCXIlWyciS
         0Rj/Dk7Iofb8FB7CugPv85jFOfBLZCCgqS9MEVxbUoPM/WeUL0WfW1lR3Z2q5HXe3B9b
         zaiQ==
X-Gm-Message-State: AOJu0YyKFRzuN25tflhXX1gN7G0xpLQXBqlc5ANTWViaXtgMUyIeNfaA
	wSSfYUTsPdcpg3/GtY+leyMzrOXY9ZngrRSX4Q9bDxEWW7BXK19ap5vxQ8QKzTkpFE4JCrtsUzE
	Kmw13Acs1sClAyCEBsPZtV0GulitsrozrgCJY16xlhFPIEL4W2RZVqFXcBnvqLVmrv6zMGWW2/m
	PX00uc8w==
X-Gm-Gg: AeBDievmp0uPkDcCgHDHBunaDWx12eFnBQnvwOcsCmO0DQnxDOwvUDyc13DUwNrrmNZ
	JGra31QcV+VViMO1Lw3IhvxdYeTC0WQB5rvZiFAijBjPkia1XmNTrAdBmfvNoqyM3zWOa+yPApU
	x6fBgPJnP5eXdLi6Lh7Jt/TyN0OTI2ZIHdTLevmdOLl6zy51dJbdyw4O1hnfa1WtmY3f3161Cy/
	6TvcLVspDfYsiZuvjGdZV0A2tvFOo/xmTisuzGcJZlO6BFkB0alFxAwKKY8pf+uWcLpI3DzsRGT
	OSCofaEKtTbjwEzLCnX0bFCZI+HTsMOfmV7rYYF3GLYUMahclBLUVT9Jp5kO4oLk6za0GFl7zY6
	gKdYiyjonHs11mP432AGofJ7J00Y=
X-Received: by 2002:a05:6a00:14c7:b0:82c:6b1b:7ad4 with SMTP id d2e1a72fcca58-82f0c250a1dmr12459775b3a.3.1776062583994;
        Sun, 12 Apr 2026 23:43:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:14c7:b0:82c:6b1b:7ad4 with SMTP id d2e1a72fcca58-82f0c250a1dmr12459751b3a.3.1776062583546;
        Sun, 12 Apr 2026 23:43:03 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-82f0c4b62c2sm10386453b3a.38.2026.04.12.23.43.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:03 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 03/11] apparmor: replace recursive profile removal with iterative approach
Date: Sun, 12 Apr 2026 23:39:12 -0700
Message-ID: <20260413064256.1578919-4-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235915-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 883953E7DE4
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
index 4ee5a450d118..a4406a7f753c 100644
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


