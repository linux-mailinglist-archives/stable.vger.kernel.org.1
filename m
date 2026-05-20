Return-Path: <stable+bounces-252182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fg2FPT/DWp+5QUAu9opvQ
	(envelope-from <stable+bounces-252182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:39:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C27596EE9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F3938DBB16
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A732861F;
	Wed, 20 May 2026 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/t6dfN/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82E3F9F25;
	Wed, 20 May 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300006; cv=none; b=QA+vigZmcvl6ikobjsuSlyYj9t6QTy/6B2yLm/jygTYCci9EMcGqyPld4UAQk2zo4RNVK2aZ1vwJB1wcQmzokzDhWrA0n/aXecfQm7eWHLfyHIU835lOMAZTCSPTpQ/OEHapmuiCTkMctdwCDaZw2XpZj+SAkLZUMjHUwWDge5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300006; c=relaxed/simple;
	bh=LQlhjatZQvZ+QipyFZc9wptTRpSGrzHodWBo1CRGvLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktI8WpGOPjZ45W70deAbTcMn1QHLI6U6reGdb6SQArLd+RXu5B/YQrNU+ITrLwppnlGDbs3dxD9G6YUpjIpgmHRKlizRRxcKPci86VThwITU/RSLJEY+NUu/daTBgpL4kJBVUZsEdsr4a1CNK6K7WRhNnjiMePbT21j+6peT9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/t6dfN/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55921F000E9;
	Wed, 20 May 2026 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300005;
	bh=Xu20gpCwVxvLUGQwkSxPboau0Cf8jBxmxpgHSMmgLgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x/t6dfN/zELwM375RgfvKEzQ91Fj3y7SXP4NcKdKBrSekeQENnxSDor0yWqF58k6E
	 vZI8S6wUiOAK26O1A8h4Kxlzjk1mv+uji1cJVwRPqN/CQXUGMtZO2/bF3JJaKx7e/Y
	 Ce09Qqwn27k9yGJy1ovtmcBvKKprSDpfbquWUM2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 012/666] md: wake raid456 reshape waiters before suspend
Date: Wed, 20 May 2026 18:13:43 +0200
Message-ID: <20260520162111.497957151@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252182-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,fnnas.com:email]
X-Rspamd-Queue-Id: E5C27596EE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 526390acd39e0..1aff3e541ceb5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -470,6 +470,17 @@ int mddev_suspend(struct mddev *mddev, bool interruptible)
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




