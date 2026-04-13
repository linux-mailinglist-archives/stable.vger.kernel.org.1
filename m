Return-Path: <stable+bounces-235935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJdFFESS3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D883E7EF5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D349302A2CA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E81FC101;
	Mon, 13 Apr 2026 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jrvujN16"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE136492D
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062952; cv=none; b=ni7GRdVGdzZuL7WkweVkhKeRrnhV53hR4aAhM1cnqqSjvWed/RA5ilkJ1gUA+WRgchDNYTkVXkbPUgmRYWi2JbHNOcyh/qsG4+VUj8eE/rJZi3FSE8pM2jKCqxhyx3/wIAOGC5gsOPJuwmQ4V+GLsri07CiSz9/1Hm25BZRD0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062952; c=relaxed/simple;
	bh=Km9JTBPA40hb4kZfxNQWTtk9ko06OoIlJv04IUeLiUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPRWLVkHNwR4FDIOpkYTakphmq6W4YuQo2zYyZUSwNpryyDZo7UR6pvq671Mxu7hOvX1TE6HiHdKpykDh2KRhJDq5e3EVViV7un+rg+tkgpRFpC8OvKPAS5r9knaIhcyIEvWVWBtilZW1v5HLBEkdRKRKYqkjb/pje5/4Ok2zNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jrvujN16; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E97D23F0B8
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062582;
	bh=eY2FH+AHVuofMennDfpcnOCUcmR1GMwVnz1De/MM8SI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=jrvujN16i2sF1K4NhCv5e8xuVZHoB7TIj19urJI/zZr8LH4nYlxN+v7ZiXT7uOYAX
	 LefKdRBCEqTxbVE10ETqY4R8QXAnHRhBCCbmCOaBkOKjs5cJCUWUFrnhbtgJng/UDq
	 rZmS/Vn3oyluXmqGkjesPU8E31fcLDZcYJh8d5uXd1rRcSXndlFAV3JZw9qX4h0IfI
	 QSHpQ8sfwRAR5M512/bheKNYXf4qrnDLMmhFOKSfUzcNKB9RPNMrISwNPwgwH+1IXu
	 I4KvSoh1jtyw8GINzY2uOW0T70/B74qrOcrAraUNHtwldwDq0jgKgOiHVXe0m/TPzx
	 b3KQBrRR47MImo0vx5o57wgRqfhQouuwEXqqxw8nqVBduDvzHqwiVfQF7nwNesu1eV
	 RQ9RZpjxEc6quOKfcBPuMkUEiJFOepw4gVK39VwrxfVhBv48nT8e9t1S/2iQZxNG86
	 4Cz7P4cldfxqU1kyS8TeZr92B+NAaCLESmqpfmCuuv0ViorxO25lyKG/PSCcxjiZSV
	 rgks6ycl2KwAxXS6FdCspE+nr7aIhryBLMtYYhTtHyv+lWbSlpuuoNZuimiidxu+4L
	 C2EIDElYswPOPCvr6mbpjfD9xr9EEFX3cjEfuebe9+EsvxhR0xiJfXq323GukzmW2o
	 MQPp/nbxlMe646Yzi9LOpVVw=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2e6ee9444so12487055ad.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062581; x=1776667381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eY2FH+AHVuofMennDfpcnOCUcmR1GMwVnz1De/MM8SI=;
        b=rYKclGZpOmmoSKGrp7rgrBsTRvr5wXbWZdE2afBHrqAOVI/MYqqli9qFSGyCnFiSYI
         VYlh5QN226i6C2dTrOPvMpb675eyrmLdFOYHoCtpf4kyto0UJzgc5zKulUbkRGjd0e7Q
         CNhmCCVY47emfT8w9RZvKPZl/XAu1Jq7ZK4/IyhgL8g6ncm8oskHnlhUaiBn3/iyujYw
         TJ9IhXXJe8ZGq2Y3b4QhPgN6EAw9+Xh9PxNNoUgF1Of4Xfq+Q8JfpKmWLRmsz1nCpy+G
         SFvaxSOSyZt4GWR6xqOi2cPv6TU9Ndg+8xszsqbbPUBEqLCFvh3iukG+fbU/GPCKBbzC
         rgxw==
X-Gm-Message-State: AOJu0YzI+Q1ZfCyFZKgoJ/AAtY2bK70ocU5sSYhJ4ayX5DipDNh39rIH
	V/BCRzh8H/GnHavnoD/TKwQEhnKvRaRYbgGlxUX/n68noFCzkaPinCUFQeJ55bVVREcOAify607
	Zxj3J+fCs+huMzvRglY+kZWJKBBSCD/TRvEP+7g4QUAvX2MXI/adJmIE/WMugl52rWAB3IHkyb+
	QPASbYMg==
X-Gm-Gg: AeBDieseyPG7YNDoea/zvrAfG3NpN8HwUlTCZ4HccF2huJ9iMEo3qetVbkj3zedl1dh
	pUM53OV7hcH979JyvxqYqSV9OpZVnU1upIDvVPw638F0sgfqQ0voENT9Cglo1m8Uzw0R1I2tpnW
	wBbINMju/Y33bcjnoqewCEbgFhjkv7tpYiZv7w+EjWt/+/06N3wnoj2igfqmA3oN+RQd/XXb8Sr
	d3u1xXmEBFxMfxfpho4ggN/Hrg0jczbEoNOQCAUnb6Riw37qVwceJQrhx6lkLQRm1G9XocAicsJ
	d0r4Ga0CFufBpRuDi2C34jNf4liQ/O85z80nxKTkCLpA4Pz9x1rMZB8Xi5VsDme2WtPxrqza3As
	6CxalnbCZTZ6SXIudC62fdcdQb0Y=
X-Received: by 2002:a17:903:3d49:b0:24b:1585:6350 with SMTP id d9443c01a7336-2b2d5d105c7mr71580555ad.11.1776062581617;
        Sun, 12 Apr 2026 23:43:01 -0700 (PDT)
X-Received: by 2002:a17:903:3d49:b0:24b:1585:6350 with SMTP id d9443c01a7336-2b2d5d105c7mr71580395ad.11.1776062581212;
        Sun, 12 Apr 2026 23:43:01 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b2d4f08d1bsm108068555ad.54.2026.04.12.23.43.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:00 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 01/11] apparmor: validate DFA start states are in bounds in unpack_pdb
Date: Sun, 12 Apr 2026 23:39:10 -0700
Message-ID: <20260413064256.1578919-2-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235935-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualys.com:email]
X-Rspamd-Queue-Id: A4D883E7EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit 9063d7e2615f4a7ab321de6b520e23d370e58816 upstream.

Backport for conflicts caused by
ad596ea74e74 ("apparmor: group dfa policydb unpacking") which rearrange
and consolidated the unpack.

Start states are read from untrusted data and used as indexes into the
DFA state tables. The aa_dfa_next() function call in unpack_pdb() will
access dfa->tables[YYTD_ID_BASE][start], and if the start state exceeds
the number of states in the DFA, this results in an out-of-bound read.

==================================================================
 BUG: KASAN: slab-out-of-bounds in aa_dfa_next+0x2a1/0x360
 Read of size 4 at addr ffff88811956fb90 by task su/1097
 ...

Reject policies with out-of-bounds start states during unpacking
to prevent the issue.

Fixes: ad5ff3db53c6 ("AppArmor: Add ability to load extended policy")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy_unpack.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 17601235ff98..1f8628a418da 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -824,9 +824,18 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 			error = -EPROTO;
 			goto fail;
 		}
-		if (!aa_unpack_u32(e, &profile->policy.start[0], "start"))
+		if (!aa_unpack_u32(e, &profile->policy.start[0], "start")) {
 			/* default start state */
 			profile->policy.start[0] = DFA_START;
+		} else {
+			size_t state_count = profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+			if (profile->policy.start[0] >= state_count) {
+				info = "invalid dfa start state";
+				goto fail;
+			}
+		}
+
 		/* setup class index */
 		for (i = AA_CLASS_FILE; i <= AA_CLASS_LAST; i++) {
 			profile->policy.start[i] =
@@ -847,9 +856,17 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 		info = "failed to unpack profile file rules";
 		goto fail;
 	} else if (profile->file.dfa) {
-		if (!aa_unpack_u32(e, &profile->file.start, "dfa_start"))
+		if (!aa_unpack_u32(e, &profile->file.start, "dfa_start")) {
 			/* default start state */
 			profile->file.start = DFA_START;
+		} else {
+			size_t state_count = profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+			if (profile->file.start >= state_count) {
+				info = "invalid dfa start state";
+				goto fail;
+			}
+		}
 	} else if (profile->policy.dfa &&
 		   profile->policy.start[AA_CLASS_FILE]) {
 		profile->file.dfa = aa_get_dfa(profile->policy.dfa);
-- 
2.51.0


