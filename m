Return-Path: <stable+bounces-264533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WI1rD2h5MWoOkQUAu9opvQ
	(envelope-from <stable+bounces-264533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECAC692168
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BU4vHcQu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264533-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264533-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31B3031BC0A7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CBF466B70;
	Tue, 16 Jun 2026 16:13:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7244508F2;
	Tue, 16 Jun 2026 16:13:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626428; cv=none; b=FGDYIf5RW/4zQ7IGv9nkFm/ldeEXdUShp+j0hpDmxYzafz93uqCfpjvu4YnyMhRykbo+WLfxPuu/LjSJjBjZPd1nZ9H7G+K1PfrGERjRli1yUQ3eJgnvf71y2g0kvj3E7LTCInQrcXdT1EqH2auN1elqTgDtLccd6CiKngjS+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626428; c=relaxed/simple;
	bh=mrX8ZOkDF6jFWbaGqwY4pdUdikAQmMI1LKwyoQZhtxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iquD+t04k2/RQHqKZJQFvGJLAXugQKiWAjETTmnn9KNgJLOZhHNvK33kitjkP1zDRxzJwbKQHbYRCEtfTVY0jP0GhHM+XTZHbAE6qnbT0z9cToXCePqExaDppANwdzwxlh28ZSD8GvYfSmp0U8ZpOr3ERd+iYS/2yMhdJIyx8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BU4vHcQu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6971F000E9;
	Tue, 16 Jun 2026 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626427;
	bh=WNobPzyWDdEETFgjhL5VNXzAzwAw/zJ9rjtoWe58rbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BU4vHcQuHFKDWzzkKgxI/2nPt61GG507E/qeU5cFmInl++gUUqxGXVcvpX5z2s647
	 Rb4CCNaVYqQOHSmfxXtT1x9aY1neyYZjUuWHnknnlyQWIBpQQHDf1SOvfhzkkBLlwh
	 vuOZLIuBKx9BgmSZKUC+EmG2JKAq7KhrozMFeR/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.18 286/325] drm/xe: Clear pending_disable before signaling suspend fence
Date: Tue, 16 Jun 2026 20:31:22 +0530
Message-ID: <20260616145113.012080502@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264533-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:tilak.tirumalesh.tangudu@intel.com,m:thomas.hellstrom@linux.intel.com,m:daniele.ceraolospurio@intel.com,m:rodrigo.vivi@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ECAC692168

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>

commit 54f2a0442a30fe7a0f6bc8345e81f8b2db8effbd upstream.

In the schedule-disable done path for suspend, we
signal the suspend fence before clearing pending_disable.

That wakeup can let suspend_wait complete and resume be queued
immediately. The resume path may then reach enable_scheduling()
while pending_disable is still set and hit the
!exec_queue_pending_disable(q) assertion.

Fix this by clearing pending_disable before signaling
the suspend fence, so any resumed transition observes a
consistent state.

Fixes: 87651f31ae4e ("drm/xe/guc_submit: fix race around suspend_pending")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>
Reviewed-by: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Link: https://patch.msgid.link/20260603065217.3131066-3-tilak.tirumalesh.tangudu@intel.com
(cherry picked from commit 4b1ae138b0e103d753773956a84eebc2edbf62c4)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_guc_submit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2179,8 +2179,8 @@ static void handle_sched_done(struct xe_
 		xe_gt_assert(guc_to_gt(guc), exec_queue_pending_disable(q));
 
 		if (q->guc->suspend_pending) {
-			suspend_fence_signal(q);
 			clear_exec_queue_pending_disable(q);
+			suspend_fence_signal(q);
 		} else {
 			if (exec_queue_banned(q) || check_timeout) {
 				smp_wmb();



