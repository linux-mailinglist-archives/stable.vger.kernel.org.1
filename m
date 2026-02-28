Return-Path: <stable+bounces-221148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDmxJ6NIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A71C79FD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEEA83651EB4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92189373126;
	Sat, 28 Feb 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNAOLULx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A5372255;
	Sat, 28 Feb 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301502; cv=none; b=b6rYAiTGLu2FHccvYMFQ+jHrQTiYnQQXg2xYeBlNlUty/rez1oiKlbSZ55mSl3Y6llaZVRGXXgt2YcBhlHAjinUkFYxZoyXTKo241Y18LUAm6qImv+gBmxCWbpRDTBty0Iy4KwJLFhwQhe/kJi+HRih6ErBOYuVxpZvFyLR72hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301502; c=relaxed/simple;
	bh=LelZWKh7o+l0tdFfERkHKbBg/0WmIA0wNOavyMzkqBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4gFd3UCkDHVJnKSlDQZwZskmQTkssILJu3nmnZJqAxkc+b8sEpw7dq5sYy9zI3ojDlA/CgoxQKTT6Unl2OUhy7DOHYlYvj12KPVkBe7Yz1kvfbTVkinUqPgZy02e+1NEBSYri42d2DWKxuRtW4ol/VFbuv8FxVWgiTy6d003CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNAOLULx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED0C19423;
	Sat, 28 Feb 2026 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301502;
	bh=LelZWKh7o+l0tdFfERkHKbBg/0WmIA0wNOavyMzkqBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNAOLULxptmcRVuXoVBHDQdX+lwPTgym1h4wvle/Phepf//0gCsubhdvSG9HkHesl
	 F2AnHH5qQuDXaZQ26K4k93ktpiGjCSDn2rlUF/xtYA9m0AbFOxgzr6Vlu+mN6BkMHu
	 hadDz2HQubEwCp+yFuTUZgcLdEwT0sIjnp1zAl4Cgz3QL5NP0xvHJXIWsvxP1OJlnZ
	 Iqvpa4z5zYmO3w83TN0yPa4lqgKxmqCBVXg4BqCHrEZsNWN3ImHzmWVJ4iyPEFmmjk
	 +/TnsKAIpm+9e1DRvAORDlFz9LzDOl4NtrXaj0CJopOe0CWk/7aYfAjGUv9Wp09zA3
	 01OK1h/tBtWJA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Harry Yoo <harry.yoo@oracle.com>,
	stable@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 686/752] mm/slab: do not access current->mems_allowed_seq if !allow_spin
Date: Sat, 28 Feb 2026 12:46:37 -0500
Message-ID: <20260228174750.1542406-686-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221148-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 053A71C79FD
X-Rspamd-Action: no action

From: Harry Yoo <harry.yoo@oracle.com>

[ Upstream commit 144080a5823b2dbd635acb6decf7ab23182664f3 ]

Lockdep complains when get_from_any_partial() is called in an NMI
context, because current->mems_allowed_seq is seqcount_spinlock_t and
not NMI-safe:

  ================================
  WARNING: inconsistent lock state
  6.19.0-rc5-kfree-rcu+ #315 Tainted: G                 N
  --------------------------------
  inconsistent {INITIAL USE} -> {IN-NMI} usage.
  kunit_try_catch/9989 [HC1[1]:SC0[0]:HE0:SE1] takes:
  ffff889085799820 (&____s->seqcount#3){.-.-}-{0:0}, at: ___slab_alloc+0x58f/0xc00
  {INITIAL USE} state was registered at:
    lock_acquire+0x185/0x320
    kernel_init_freeable+0x391/0x1150
    kernel_init+0x1f/0x220
    ret_from_fork+0x736/0x8f0
    ret_from_fork_asm+0x1a/0x30
  irq event stamp: 56
  hardirqs last  enabled at (55): [<ffffffff850a68d7>] _raw_spin_unlock_irq+0x27/0x70
  hardirqs last disabled at (56): [<ffffffff850858ca>] __schedule+0x2a8a/0x6630
  softirqs last  enabled at (0): [<ffffffff81536711>] copy_process+0x1dc1/0x6a10
  softirqs last disabled at (0): [<0000000000000000>] 0x0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&____s->seqcount#3);
    <Interrupt>
      lock(&____s->seqcount#3);

   *** DEADLOCK ***

According to Documentation/locking/seqlock.rst, seqcount_t is not
NMI-safe and seqcount_latch_t should be used when read path can interrupt
the write-side critical section. In this case, do not access
current->mems_allowed_seq and avoid retry.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Link: https://patch.msgid.link/20260210081900.329447-2-harry.yoo@oracle.com
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bc6156801e8e6..4e2a3f7656099 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3594,6 +3594,7 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
 	struct slab *slab;
 	unsigned int cpuset_mems_cookie;
+	bool allow_spin = gfpflags_allow_spinning(pc->flags);
 
 	/*
 	 * The defrag ratio allows a configuration of the tradeoffs between
@@ -3618,7 +3619,15 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 		return NULL;
 
 	do {
-		cpuset_mems_cookie = read_mems_allowed_begin();
+		/*
+		 * read_mems_allowed_begin() accesses current->mems_allowed_seq,
+		 * a seqcount_spinlock_t that is not NMI-safe. Do not access
+		 * current->mems_allowed_seq and avoid retry when GFP flags
+		 * indicate spinning is not allowed.
+		 */
+		if (allow_spin)
+			cpuset_mems_cookie = read_mems_allowed_begin();
+
 		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
 		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
@@ -3640,7 +3649,7 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 				}
 			}
 		}
-	} while (read_mems_allowed_retry(cpuset_mems_cookie));
+	} while (allow_spin && read_mems_allowed_retry(cpuset_mems_cookie));
 #endif	/* CONFIG_NUMA */
 	return NULL;
 }
-- 
2.51.0


