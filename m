Return-Path: <stable+bounces-250041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NamJRsMDmpZ5wUAu9opvQ
	(envelope-from <stable+bounces-250041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:31:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B8598638
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB303236C28
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07973A5E78;
	Wed, 20 May 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ANVh6kcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D836405A;
	Wed, 20 May 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294388; cv=none; b=m699jPXVafWcneeEhg1F2RDoduct2DLpPf9j9ZZzBxw1TkvoKKOnwFQdbKMRkZBzpsfJ1Vg2OhNrBuN0YE9yHMGofzVCV4A/slIgdN7gFh0nbcZgqFK8WychjqtXkLCCGhSswoB6CyTBhx5epZstsXotDSM4yCg6584BnVB4z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294388; c=relaxed/simple;
	bh=EC2olcZ9oZT3bsHpUV49uhzEf6MUA8aZayVO4Zx4w8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBItpLc31oChEn6zz3Er7eWAUnnLCnkEwsyyAioj7ZdzmZnBc8VGlY1QuQq3HL/JPfC6YL2E+UwOnFLyPCUNg1jKMRspIJ4mY2gOR9MH6x+tQ0o38vuaHJwpchO1x5BIThwzEaMaBYxnGIUyZLgBpduzXg7t5n5sng9FZMMCJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ANVh6kcW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767FD1F000E9;
	Wed, 20 May 2026 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294387;
	bh=tydZZzxgknKEnhdIjZHTXHM1M/0wYW4G6J79TzjQfBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANVh6kcWf0zDBFzP3FOa2yrvCif4KDeF6hNFpu1kvpwU+zMoCZmSLctDOaZsTwjOd
	 vkR7EkFCQg+KRc1TlP47d5Q7IrBq40msQjN1aob3SL+qukyyk3qmgDia9TEC8+ZSPh
	 pesFCogqGH5LAzxafwI9ef26AAi3kfLXe/hsFlKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0020/1146] md: wake raid456 reshape waiters before suspend
Date: Wed, 20 May 2026 18:04:30 +0200
Message-ID: <20260520162148.844582839@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250041-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A78B8598638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai@fnnas.com>

[ Upstream commit cf86bb53b9c92354904a328e947a05ffbfdd1840 ]

During raid456 reshape, direct IO across the reshape position can sleep
in raid5_make_request() waiting for reshape progress while still
holding an active_io reference. If userspace then freezes reshape and
writes md/suspend_lo or md/suspend_hi, mddev_suspend() kills active_io
and waits for all in-flight IO to drain.

This can deadlock: the IO needs reshape progress to continue, but the
reshape thread is already frozen, so the active_io reference is never
dropped and suspend never completes.

raid5_prepare_suspend() already wakes wait_for_reshape for dm-raid. Do
the same for normal md suspend when reshape is already interrupted, so
waiting raid456 IO can abort, drop its reference, and let suspend
finish.

The mdadm test tests/25raid456-reshape-deadlock reproduces the hang.

Fixes: 714d20150ed8 ("md: add new helpers to suspend/resume array")
Link: https://lore.kernel.org/linux-raid/20260327140729.2030564-1-yukuai@fnnas.com/
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 159af8d7ccf0b..9c552904a5ddc 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -488,6 +488,17 @@ int mddev_suspend(struct mddev *mddev, bool interruptible)
 	}
 
 	percpu_ref_kill(&mddev->active_io);
+
+	/*
+	 * RAID456 IO can sleep in wait_for_reshape while still holding an
+	 * active_io reference. If reshape is already interrupted or frozen,
+	 * wake those waiters so they can abort and drop the reference instead
+	 * of deadlocking suspend.
+	 */
+	if (mddev->pers && mddev->pers->prepare_suspend &&
+	    reshape_interrupted(mddev))
+		mddev->pers->prepare_suspend(mddev);
+
 	if (interruptible)
 		err = wait_event_interruptible(mddev->sb_wait,
 				percpu_ref_is_zero(&mddev->active_io));
-- 
2.53.0




