Return-Path: <stable+bounces-264514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WzxdGO94MWrkkAUAu9opvQ
	(envelope-from <stable+bounces-264514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:25:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A566920E3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=mQpUT9oN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264514-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264514-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6202631264A2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E645BD4B;
	Tue, 16 Jun 2026 16:11:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720B44BCB8;
	Tue, 16 Jun 2026 16:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626309; cv=none; b=aSLThwO5LP9dM7tw/ewAw2UzcI5MJ9zpRZ5JhFoOgWXEqXmYFMEoHnK+9ycf/xKYDI7UNJXETC+Z8Wl2jqYhhf0GpH7TIyLqx1v4u3D5U2vDggGo0lJa7TPN3hpWm0jcBw24USLsrKyA1k/7aSGrDioIWNXmcuThYhw1yCJCJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626309; c=relaxed/simple;
	bh=kWN1MhWVhJKeKbTpPx3pNs3wb+QOC1cDy8DLsZ6+jIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+Q9T1O9p8ztfrZOzlyzGuvCTBMqfeY1nmuSdIowmMflndrfFCHNcOgJPn8K4OV51+TITehDlZs2rXqmyppmnetLjiw7MZK5ONtRpQy7bMUxTngvUTvgWBVzAXUYHuHIWui34nhym0h7yNNV+X0teY7m9rbuxzJjzRG8hXjYJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQpUT9oN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B761F000E9;
	Tue, 16 Jun 2026 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626308;
	bh=+Bhn9Vqrp1cDd10VYeJxqH/g0UsI3e1AscW1bpwOe1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mQpUT9oNDRLTrXa88ITLol4cqxMZaayAP5toRdVRvyshSqzYmTMr3gEdbbzR7cfxe
	 Lmn3/nroL0HR6T5AZtCQPHWNk4n1+IdnjjJ3VJ0ijllwqolfNS0gRCPxnvusbGfXpJ
	 LUzSdAqW1TBKzvjJrQl1PMXWiJXNQ1AtxOihrMRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Bilal <meatuni001@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 283/325] drm/amdkfd: fix NULL dereference in get_queue_ids()
Date: Tue, 16 Jun 2026 20:31:19 +0530
Message-ID: <20260616145112.839229553@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264514-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:meatuni001@gmail.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2A566920E3

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Bilal <meatuni001@gmail.com>

commit 2bd550b547deabef98bd3b017ff743b7c34d3a6d upstream.

When usr_queue_id_array is NULL and num_queues is non-zero,
get_queue_ids() returns NULL. The callers check only IS_ERR() on the
return value; since IS_ERR(NULL) == false the check passes, and
suspend_queues() calls q_array_invalidate() which immediately
dereferences NULL while iterating num_queues times.

Userspace can trigger this via kfd_ioctl_set_debug_trap() by supplying
num_queues > 0 with a zero queue_array_ptr, causing a kernel panic.

A NULL usr_queue_id_array with num_queues == 0 is a legitimate no-op
(q_array_invalidate never executes, and resume_queues already guards
all queue_ids dereferences behind a NULL check). Return ERR_PTR(-EINVAL)
only when num_queues is non-zero and the pointer is absent; both callers
already propagate IS_ERR() returns correctly to userspace.

Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process queues operation")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f165a82cdf503884bb1797771c61b2fcc72113d4)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3293,7 +3293,7 @@ static void copy_context_work_handler(st
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
 	if (!usr_queue_id_array)
-		return NULL;
+		return num_queues ? ERR_PTR(-EINVAL) : NULL;
 
 	if (num_queues > KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
 		return ERR_PTR(-EINVAL);



