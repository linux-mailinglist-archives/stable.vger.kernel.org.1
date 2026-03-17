Return-Path: <stable+bounces-226318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLJWOZWIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:00:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE82AEC4E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE55311AA09
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDB3EAC6F;
	Tue, 17 Mar 2026 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2V9GrW+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4B2E62B7;
	Tue, 17 Mar 2026 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766181; cv=none; b=ueXc6GDu+DaxBYpAD6/il9hthct/xme0SijtspJ6mZl1WuOYGQ/4bE8XlzXYkIzAAao182luyAwIFC63I4EWCA+h6lCyR7PMfDMwAyubilqasvQKrqqvN/wkD7lmn9UFHZEvKpx8ZA3qGIDTsaGtezEc6KoMxaBSsAZvC95bCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766181; c=relaxed/simple;
	bh=mVgR5mWFb048iZnlTf3frKl9HQrKoAJ76BLx7cK3dmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG+7ySwcvWq2pkribju1pgUrHVmInzPsQFQgsdLkL+mlKxMbqttMBr+qXrJ8PoGvJBrM5r8HRdMM+ubyHvpUQoffw+iOx1f0nB5FTNrCZJan/x6QA1ezY7aPhDWQ600V7Rn6DDchEVH48ENF2LXbdrDpY9y9h8eHSXRZdaM6hdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2V9GrW+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BCFC4CEF7;
	Tue, 17 Mar 2026 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766181;
	bh=mVgR5mWFb048iZnlTf3frKl9HQrKoAJ76BLx7cK3dmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2V9GrW+H8wtnvbRIXybhf9tdc7NFrwtxcDA2rzSeIQEMGBEnMgIpGZPgKBxT3IsCg
	 Hwb3+XReP7DoVJPhr9TRiN9jDruGI/jUReEii1fllnsdS7MhPm/MefiKSiu+rUIT31
	 rSrQTSI0g0AtTpNZBq8jmtqhGgBf+EHtVSsSXv4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 187/378] sched/mmcid: Remove pointless preempt guard
Date: Tue, 17 Mar 2026 17:32:24 +0100
Message-ID: <20260317163013.886179410@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-226318-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CBE82AEC4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 7574ac6e49789ddee1b1be9b2afb42b4a1b4b1f4 ]

This is a leftover from the early versions of this function where it could
be invoked without mm::mm_cid::lock held.

Remove it and add lockdep asserts instead.

Fixes: 653fda7ae73d ("sched/mmcid: Switch over to the new mechanism")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260310202526.116363613@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 24d607c78f119..c80076fcd78f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10632,6 +10632,8 @@ static void mm_cid_fixup_tasks_to_cpus(void)
 
 static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *mm)
 {
+	lockdep_assert_held(&mm->mm_cid.lock);
+
 	t->mm_cid.active = 1;
 	mm->mm_cid.users++;
 	return mm_update_max_cids(mm);
@@ -10684,12 +10686,12 @@ static void sched_mm_cid_fork(struct task_struct *t)
 
 static bool sched_mm_cid_remove_user(struct task_struct *t)
 {
+	lockdep_assert_held(&t->mm->mm_cid.lock);
+
 	t->mm_cid.active = 0;
-	scoped_guard(preempt) {
-		/* Clear the transition bit */
-		t->mm_cid.cid = cid_from_transit_cid(t->mm_cid.cid);
-		mm_unset_cid_on_task(t);
-	}
+	/* Clear the transition bit */
+	t->mm_cid.cid = cid_from_transit_cid(t->mm_cid.cid);
+	mm_unset_cid_on_task(t);
 	t->mm->mm_cid.users--;
 	return mm_update_max_cids(t->mm);
 }
-- 
2.51.0




