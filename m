Return-Path: <stable+bounces-251181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFBsAjzwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C6593E7F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B7033074024
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C403F54DB;
	Wed, 20 May 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4qkW4KX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6543EF0D7;
	Wed, 20 May 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297310; cv=none; b=VU4pMRqU+CIAl8ekqr3/LLkXpqTScoJBw64/6o5JmOxr3xoWfAYZ3KCdDEuIad6r0L1uJV/VAJ4/2HJKgiFMwauND490vKbbv16qF8W8KQadugSPQK4241Xq80Z1/fr7F2H0mNwDl65HsRM7PJqeBeBZRe88HdgedKmDOQzBVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297310; c=relaxed/simple;
	bh=iAF9K/iuJfGkw6l1QuE9lt8+seLWSw95GO3PmNYFiRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ele5zKluiY5ZONTmbJyGi7OZoR4Q0SW9+kZBDb/+eJZ4thBLdeGYVnjKEhls0jY25qsizQ3qsUXskGrMOcPFi8ltNycPbbtYfLYBD3VLWvxBQkqKEyAuDjDyHkKxWwbAZiJtTKjCS/9g62T/UDLmjIZcg5eIWssqUb3uyNwQB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4qkW4KX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1E71F00893;
	Wed, 20 May 2026 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297309;
	bh=outF5B6ST84TYQz6FRVbS0CoCwEZcFhf62jFbtasy7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4qkW4KXACZLBtOiPXbRw0BBVUhlfxG74cTc9L8TwZhUFT440FdArkCQXwthtXhle
	 kPI3HT3exLX/Qrd22H/ByVP/EljtxduWsYSaTpO3DdNnA/SIG6EZgrxqQuBHAwTdp9
	 f+k8f73xh/IK1bLhHfkBI2FN21diahfkLpUK9+5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 7.0 1128/1146] drm/i915: skip __i915_request_skip() for already signaled requests
Date: Wed, 20 May 2026 18:22:58 +0200
Message-ID: <20260520162213.774560734@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251181-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 712C6593E7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

commit 4cfe4c0efbdcde742a47813180cc69b132d7598e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gt/intel_reset.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -132,7 +132,8 @@ void __i915_request_reset(struct i915_re
 	rcu_read_lock(); /* protect the GEM context */
 	if (guilty) {
 		i915_request_set_error_once(rq, -EIO);
-		__i915_request_skip(rq);
+		if (!i915_request_signaled(rq))
+			__i915_request_skip(rq);
 		banned = mark_guilty(rq);
 	} else {
 		i915_request_set_error_once(rq, -EAGAIN);



