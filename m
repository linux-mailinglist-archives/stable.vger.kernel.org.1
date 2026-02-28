Return-Path: <stable+bounces-220124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCsII7Iqo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A27C71C51FF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF6FC30C00E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A3480DE6;
	Sat, 28 Feb 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0hA44KW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CA480DE0;
	Sat, 28 Feb 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300034; cv=none; b=CLm7N3MsO698H3JwJfrf4+HB8/2lA5gcCLoGexUvtu/yfnktkdAzIJX8B/vsWh5iHhO1JnJXhvwng+vySJfGMNtholNsRKj6X9ZHXlYvp6gEwP9gZ+Vqiyj/uMlg0zaP37pusuPuEzJFmraF0WWelolimUEy6+98OI65/6hqDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300034; c=relaxed/simple;
	bh=S8OInPU44O8H08ja7d4spf82h8LMrpkcMHwGprFpQ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH9J6P8aMaGuI2rjx+qee0m4+gE9jrqmZHbYcrGtiAMzENy34HLsOOShP0G676REQSHdLO5p4pOxYy2oqHPzOYDqcwU3f99eoC6+IWnMqqWP7MWEBivC+c2J7OmK8DE5n7uupR3FBjwwIO5cYIZa/0AkYNxidyTBtDfPQQh4MD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0hA44KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08B0C116D0;
	Sat, 28 Feb 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300034;
	bh=S8OInPU44O8H08ja7d4spf82h8LMrpkcMHwGprFpQ4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0hA44KW+XS/JXgiHvPshwIMGx4GBBUAgGG4Vxic/l09LtGdy/LNJSTk2j3+kMRk1
	 /+IAoSQtMeHXeqAaFp9v5QLWV+wmZCGc21Om5k4m29U0iiYk2Np7pP59RAsz87b4P3
	 OUK/oSWCZuZPGClQfle8dpa/mqnsg1WtFePG/+/UCj2804Ml8ifTZau2T5r1GGtUY4
	 OH86lNH/+7PYT75MYL7CXJpBQWUpPd4nRtVcOMCnn7L2y+5MYk/6h++ajdR2L2N69+
	 +eY+FUd36+5rrNN/lBpHUNmmaV26mTM2tusLi+yPqPYcaJ8x/c5iFd/0WoFErtrJAl
	 LboekIr4dtAyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 046/844] dlm: fix recovery pending middle conversion
Date: Sat, 28 Feb 2026 12:19:19 -0500
Message-ID: <20260228173244.1509663-47-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220124-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A27C71C51FF
X-Rspamd-Action: no action

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 1416bd508c78bdfdb9ae0b4511369e5581f348ea ]

During a workload involving conversions between lock modes PR and CW,
lock recovery can create a "conversion deadlock" state between locks
that have been recovered.  When this occurs, kernel warning messages
are logged, e.g.

  "dlm: WARN: pending deadlock 1e node 0 2 1bf21"

  "dlm: receive_rcom_lock_args 2e middle convert gr 3 rq 2 remote 2 1e"

After this occurs, the deadlocked conversions both appear on the convert
queue of the resource being locked, and the conversion requests do not
complete.

Outside of recovery, conversions that would produce a deadlock are
resolved immediately, and return -EDEADLK.  The locks are not placed
on the convert queue in the deadlocked state.

To fix this problem, an lkb under conversion between PR/CW is rebuilt
during recovery on a new master's granted queue, with the currently
granted mode, rather than being rebuilt on the new master's convert
queue, with the currently granted mode and the newly requested mode.
The in-progress convert is then resent to the new master after
recovery, so the conversion deadlock will be processed outside of
the recovery context and handled as described above.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lock.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index be938fdf17d96..c01a291db401b 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5014,25 +5014,8 @@ void dlm_receive_buffer(const union dlm_packet *p, int nodeid)
 static void recover_convert_waiter(struct dlm_ls *ls, struct dlm_lkb *lkb,
 				   struct dlm_message *ms_local)
 {
-	if (middle_conversion(lkb)) {
-		log_rinfo(ls, "%s %x middle convert in progress", __func__,
-			 lkb->lkb_id);
-
-		/* We sent this lock to the new master. The new master will
-		 * tell us when it's granted.  We no longer need a reply, so
-		 * use a fake reply to put the lkb into the right state.
-		 */
-		hold_lkb(lkb);
-		memset(ms_local, 0, sizeof(struct dlm_message));
-		ms_local->m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
-		ms_local->m_result = cpu_to_le32(to_dlm_errno(-EINPROGRESS));
-		ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
-		_receive_convert_reply(lkb, ms_local, true);
-		unhold_lkb(lkb);
-
-	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
+	if (middle_conversion(lkb) || lkb->lkb_rqmode >= lkb->lkb_grmode)
 		set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
-	}
 
 	/* lkb->lkb_rqmode < lkb->lkb_grmode shouldn't happen since down
 	   conversions are async; there's no reply from the remote master */
-- 
2.51.0


