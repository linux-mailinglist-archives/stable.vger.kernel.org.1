Return-Path: <stable+bounces-249990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MyRDfTLDWqq3QUAu9opvQ
	(envelope-from <stable+bounces-249990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6155904E1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE644304EFC1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC07306B08;
	Wed, 20 May 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pt2Kivh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88E30567F
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288443; cv=none; b=RNhB40L/gLyYnssm3gKIEF1L2gqZLlCJDDWVq5Zpt4Ibwx9aao7zkzkHjWFZfu4uXMCdt86QTc/h9qNYPJyhfIjAA2/O8eFlBuq0dFBZqzN+7YheGWKs/2uY5by754mAIDc/tifDkBQIlbtYnMVw29Rj8g7pqaENQobMuSUQRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288443; c=relaxed/simple;
	bh=HCU+9G0lPduCdQ9E0RDe8e5zV5ZLCvcMlbf14pqKo5U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GzERq3M9rU0R1dYBbXh1vxklCxYXGziqbb07rul9jxBgy/hFj8qDsf93oimWgGNpoL3F0+WfEx6TD0CLsL6fa4r3d/x5IvmosnuGTXMuk6Y7Mz0+UTjtrPWv0svJ1zelwE2jj94TtmJiwu39FFNRzSItGB7OEGrsmYHlPV3k6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pt2Kivh1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87A51F000E9;
	Wed, 20 May 2026 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288441;
	bh=Bd+Wsjp5hY4iG1zot2qHhcxIQvZpq1jqMmI5hIPVo8w=;
	h=Subject:To:Cc:From:Date;
	b=Pt2Kivh1PXy4Xtf3uS6FFntyOKh0T8+VZjmTDSQJPoXG0Nt2z9LAB7jQahB2FQ3eY
	 alnQgjdhQG+Ce0GCbXaRkUS41xUTYTci2Gzcr2lTOzVp6/veLDVB9jHcvxUxUvnVvs
	 UGozJlfWWPxBkpLNAMeBheW5x4jjSkgAQfZJ8EEk=
Subject: FAILED: patch "[PATCH] drm/i915: skip __i915_request_skip() for already signaled" failed to apply to 5.10-stable tree
To: sebastian.brzezinka@intel.com,andi.shyti@linux.intel.com,krzysztof.karas@intel.com,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:47:24 +0200
Message-ID: <2026052024-heap-encore-72be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249990-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gitlab.freedesktop.org:url,gregkh:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 4D6155904E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4cfe4c0efbdcde742a47813180cc69b132d7598e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052024-heap-encore-72be@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4cfe4c0efbdcde742a47813180cc69b132d7598e Mon Sep 17 00:00:00 2001
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Date: Thu, 16 Apr 2026 13:31:18 +0200
Subject: [PATCH] drm/i915: skip __i915_request_skip() for already signaled
 requests

After a GPU reset the HWSP is zeroed, so previously completed
requests appear incomplete. If such a request is picked up during
reset_rewind() and marked guilty, i915_request_set_error_once()
returns early (fence already signaled), leaving fence.error without
a fatal error code. The subsequent __i915_request_skip() then hits:
```
GEM_BUG_ON(!fatal_error(rq->fence.error))
```

Fixes a kernel BUG observed on Sandy Bridge (Gen6) during
heartbeat-triggered engine resets.
```
kernel BUG at drivers/gpu/drm/i915/i915_request.c:556!
RIP: __i915_request_skip+0x15e/0x1d0 [i915]
...
__i915_request_reset+0x212/0xa70 [i915]
reset_rewind+0xe4/0x280 [i915]
intel_gt_reset+0x30d/0x5b0 [i915]
heartbeat+0x516/0x530 [i915]
```

Guard __i915_request_skip() with i915_request_signaled(), if the
fence is already signaled, the ring content is committed and there
is nothing left to skip.

Fixes: 36e191f0644b ("drm/i915: Apply i915_request_skip() on submission")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13729
Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Cc: stable@vger.kernel.org # v5.7+
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/fe76921d35b6ae85aa651822726d0d9815aa5362.1776339012.git.sebastian.brzezinka@intel.com
(cherry picked from commit 5ba54393dcd7adf75a9f39f5a933b1538349cad5)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index 984d0056c01c..adff482a6c9c 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -132,7 +132,8 @@ void __i915_request_reset(struct i915_request *rq, bool guilty)
 	rcu_read_lock(); /* protect the GEM context */
 	if (guilty) {
 		i915_request_set_error_once(rq, -EIO);
-		__i915_request_skip(rq);
+		if (!i915_request_signaled(rq))
+			__i915_request_skip(rq);
 		banned = mark_guilty(rq);
 	} else {
 		i915_request_set_error_once(rq, -EAGAIN);


