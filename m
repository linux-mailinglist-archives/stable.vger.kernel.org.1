Return-Path: <stable+bounces-265171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQQfKyOEMWqUlQUAu9opvQ
	(envelope-from <stable+bounces-265171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDD692DEB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=mPeXiyay;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265171-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265171-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 599D3304D2B8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5781A6803;
	Tue, 16 Jun 2026 17:10:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B4449EA8;
	Tue, 16 Jun 2026 17:10:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629836; cv=none; b=LbMqVNW85Xs3hDaPDLm1QFLgS5LwWwRwa5H8o+YNF1LKkOzRAZ3DgXxN6gXrTNlE0xMVtvdZo6gqId3p06bVGc2p0Q9h25dfstIv32gWLiCtH78cO+u4SmJ4Zfgxd5fnrzK7lO8ii/xQkN62gbGVgvgRn66c5xMfA5zNtCrxwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629836; c=relaxed/simple;
	bh=I1GaJPvLEgQsnF9SvLEyYYCrohM11LDDEh6wl49S33Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF4T7Eb5J8Q93XHjK6KY6wAqCsNjK7IX278vIannBz44pvwFtoPRDpmgZx5zzFj6WfJZY1LFw8pRlFI6tkP+zOIQ/hfoiE0mUXqXqYTjD24hZgdBQ2Uq4kPJ0abNz4148mm24/u5/8UYFq6TsHuqgozNQUF7FuTn4VR51cjZ1vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mPeXiyay; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D441F000E9;
	Tue, 16 Jun 2026 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629834;
	bh=UpOSn6McfM/UEfTNPoDnQ5gSWi0CbXR6Xg1LmhCi6/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mPeXiyayL+2vGNH9G0+IdIiL2nHN303C2RiWsnLw6tWy167jEszR/E0FcvQiF0JnL
	 Aoedjz53WyTGiV5aol7/8R5KENDR+zS/uKpLTfWyvQZFfNjeht/q3Gx5/7qWsaocHU
	 TyvrhEwDEyxV5lW8fJgHNgElBjv6ptHNTY+H8RM4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Bilal <meatuni001@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 361/452] drm/amdkfd: fix NULL dereference in get_queue_ids()
Date: Tue, 16 Jun 2026 20:29:48 +0530
Message-ID: <20260616145136.070804094@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265171-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:meatuni001@gmail.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40DDD692DEB

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2787,7 +2787,7 @@ static void copy_context_work_handler (s
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
 	if (!usr_queue_id_array)
-		return NULL;
+		return num_queues ? ERR_PTR(-EINVAL) : NULL;
 
 	if (num_queues > KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
 		return ERR_PTR(-EINVAL);



