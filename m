Return-Path: <stable+bounces-256671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NF0KuzUGWqFzQgAu9opvQ
	(envelope-from <stable+bounces-256671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:03:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB8606FDA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31E4D32D3CF3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1742380FE7;
	Fri, 29 May 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0EN5Fp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F03264D8;
	Fri, 29 May 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075431; cv=none; b=kYSl5BxXHbsIKWDsoRHxObgnKHgH84wbSnaonaaAaSrJ/RYMj800o7IjN2Nm6jPutenW9nTHY0AXx/Ekk+FzBYW/ADyVSxsbXl0CChGW4i74nymCx68USg4nnE0thN4akrrqRU+J5eln175WwnEYWaZegBaaK674ZiywZpR+ws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075431; c=relaxed/simple;
	bh=ABzuEml0mCVNKmxYCKN7v2NAXbUNo7uCb+UM5KYetKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvWTeGHbnh9fcSGzi3rGugV7BUyjSlfzFk1p3detiK0rWYU+inMRhpKqzc5ZXmfjuHBcTW00bA0GrV8KiHtzkxXmeOYStg7jURNkialzpZqxJPzPVtXi2jB9e23HkuMKO7Asf0xTZfk+eWkWSDTuCFa7MDooLfqRVPzh0W2ZjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0EN5Fp1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351D21F00898;
	Fri, 29 May 2026 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075430;
	bh=NIA7ICYvGFCKjBA05z3aKIhDosxqa3wRNXTiub6kjQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m0EN5Fp1wgMMtKKVDrC6Hk80Fy4Ycw0Ru/G7OLjPkCluucgOffteXI04vIgtNpRNa
	 O4XSvqAj/V84SCyTcTtoFj9+r8RPRVSuhdPSoLHmeU36Xd6TILQRt8zA5AFOTNQvWI
	 W6FuS+Cly53kO7blhb+MSR6agxLIg40CqtxrP2t6NOhx16l7BzQDNQ8tSEcCsj/m01
	 sKdMCUcdQ4fPweWiBkMPqhcT+ZfrtKl5imLYRv0XkVUGkmuxmvyguACCAmINzK5vjM
	 Ro74tA7TYcm3jVJnekRpbm/5PTmPoffPROuivaFGwFiR2RY+J+kuiw+E7c5XG2ysZ3
	 VXeWl46mOXxJw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 91168F4006D;
	Fri, 29 May 2026 13:23:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 29 May 2026 13:23:49 -0400
X-ME-Sender: <xms:pcsZaiU-iIZSc6BLadX9lwODnMcMYhP6DRsbla5photh-XBZcYGARg>
    <xme:pcsZalK9mSX49H7RBv7m1btwCy7dhdO-woAGvZ_ujW8wcc2mu572kJl2x_rCqTWap
    bhTVARxwiVbemWyCC1_ZhTme7rrID5o6h7eP-WYDwEAaL4oxC49AwU>
X-ME-Received: <xmr:pcsZaoGlCNsPhs8QNWANe1lkb6XH8CEC_yy3UTTk-uLbkyBikoX5GTygxDqzIw>
X-ME-Proxy-Cause: dmFkZTEZfpMr5/eRRE28w8SXJrP2dhbWJDto6huRdd/cnfVbAAhK4j6L5mXvQtvbZW1Tgn
    qdHjS1xVDGkdt7hr1SYRochmR7yuP2KsuqbhH6HkebbwRdIZkVYqIRv2TfGI9SaQtUiic8
    G8SBlRV6/L2Xtb05bm6QmOQTKoj3b/RGprk0F6woL4YfqntUvh+0D5sL6ruauatQhdAfx4
    sxg873kOfAaKAVmot+PkxhAMe2YWyy/aSlFAam2C/bHdTY9DLsPBVhceLLRJtCvIR2Q+zM
    kaoJA5O2aRPotfcyz8zPVtzBiOjMLe5Pw3NzV/bo4OKaUt+lobJ5eojHQXZMuqCslD6AI+
    BM13zq6jVvyTjG84RmS69Gp7SlyBSnqMSsWkjT2xuM0NzyUJK9KfpZb9fp9Tb4IMDIwXk7
    CW9rEHFz3n7rqGfGkRLBuDVxWgAiEytI7zge31faM1twZ4SThN2MqD4Jq6x7NArlBmmcZ1
    1jmGcq+7qkHVGuGRgmeWzw2ya9tZ+i2vtU1PD2oGlxweR0ChEX5h0JNoIroqVDNTWlqbkW
    6Ov950KZCVmBG5Y+O/oz6+M8rCJ1tOtvD92ut1C6kj8aOcYhnOiEpacbmRsCZSAmmtOgCa
    pJ4i4UFvDKOfwsz6uUiLA9nxWUx2WzdSYxWfEtsXCpVkkYp6atlK6KqqwDPQ
X-ME-Proxy: <xmx:pcsZaiywOyoNUzBQVWDc7dlar2tGfgnphXcNaUpoFBcdyBGxURtkGw>
    <xmx:pcsZatjC91BYrbAz2VwYqoF0Sdqa2Ctedqud51Jd0B4kVGw2IbhTQQ>
    <xmx:pcsZanL6Chz9uBj8kLyC5UoLYfUpEnZ4FPPk-5LL6dxCdVYWi2c_aw>
    <xmx:pcsZagDmmAd3V5hD-KTyOhr0A2l6FYB68884jeE5kvfy6zsmCEyLLA>
    <xmx:pcsZaoQ2CtZ8nPGVwaRPzY36FcCxymJbsDkYZhCoWVBATOKLKc1Nvc1N>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:23:48 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race
Date: Fri, 29 May 2026 18:23:25 +0100
Message-ID: <20260529172331.356655-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529172331.356655-1-kas@kernel.org>
References: <20260529172331.356655-1-kas@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256671-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 21FB8606FDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

make_uffd_wp_huge_pte() arms the UFFD_WP bit on a present HugeTLB PTE by
calling huge_ptep_modify_prot_commit() with a ptent snapshot that was
fetched without the corresponding huge_ptep_modify_prot_start(). The
start helper is what atomically clears the entry so the kernel-owned
snapshot stays consistent until the commit; without it, the hardware
may set Dirty or Accessed in the live PTE between the original read
and the commit, and huge_ptep_modify_prot_commit() (whose generic
implementation just calls set_huge_pte_at()) then writes the stale
snapshot back over the live hardware bits, losing the update.

The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
ptep_modify_prot_start() / ptep_modify_prot_commit(). Mirror that
pattern for the present-PTE branch. The migration case stays as-is --
migration entries are non-present, so there's no hardware update to
race against.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 fs/proc/task_mmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1e3a15bf46f4..e21a38ac745b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2610,12 +2610,16 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 	if (softleaf_is_hwpoison(entry) || softleaf_is_marker(entry))
 		return;
 
-	if (softleaf_is_migration(entry))
+	if (softleaf_is_migration(entry)) {
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				pte_swp_mkuffd_wp(ptent), psize);
-	else
-		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
-					     huge_pte_mkuffd_wp(ptent));
+	} else {
+		pte_t old_pte, new_pte;
+
+		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
+		new_pte = huge_pte_mkuffd_wp(old_pte);
+		huge_ptep_modify_prot_commit(vma, addr, ptep, old_pte, new_pte);
+	}
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
-- 
2.54.0


