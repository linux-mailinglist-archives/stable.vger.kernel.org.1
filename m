Return-Path: <stable+bounces-226383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACyjMCuJuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:02:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220982AED4A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28DAE30523C9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24E3F23AA;
	Tue, 17 Mar 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OUiQ+Bm8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389F3EAC6F;
	Tue, 17 Mar 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766458; cv=none; b=Ba2Pu1o1EnbsqmRjO//EfJnt+raPvEc7HAj80XSYvKrR8sE30DtDlMUWlI7tl0neBwkmzKPrpKtQwnkdOqg+ZHwaWfs7BvFxNfLzltKTBgNSBs64cuABoH5nv+K6tCZp79OU18zFgfDFisqy8gluS8sJnzTcFGSEA/JPKhOAAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766458; c=relaxed/simple;
	bh=9BgEFwl7QdL9mLHHGqJqDU4PpPHEGX0pmN8yHK62ZIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjthKGpBhLQnWOWmgxjDSl7d6qoBTGJlvg+AHky7GZhFffEgZuvJ+f9aY54DTsfJ0jxQTbZKabG3r1YGL8ahe91cllQ04sAdtBWihmmLZTI4jGwTyzP/+OElZzXKTD/MDi9j/KV4woXF9Ro0l3vsDHgvhuFpEtDGtylJ5O2TiKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OUiQ+Bm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABB7C4CEF7;
	Tue, 17 Mar 2026 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766458;
	bh=9BgEFwl7QdL9mLHHGqJqDU4PpPHEGX0pmN8yHK62ZIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUiQ+Bm8bzhEm3RtR7vWBEd3nzKyqJ8uP05VIFX7sumVdlk7vwMeCxJuKIXhdnjSA
	 EfLmZ8e++fsH6Ud1bD8PUd6/6OlBczvlCQINK2q3GBxBhX71T2o6JicFKsFniTYm44
	 pc7k4VZ1OPDsVno+szESv8AZBRWTWxC07OTjjUgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.19 251/378] mm/damon/core: clear walk_control on inactive context in damos_walk()
Date: Tue, 17 Mar 2026 17:33:28 +0100
Message-ID: <20260317163016.254629637@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226383-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,kernel.org,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 220982AED4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>

commit d210fdcac9c0d1380eab448aebc93f602c1cd4e6 upstream.

damos_walk() sets ctx->walk_control to the caller-provided control
structure before checking whether the context is running.  If the context
is inactive (damon_is_running() returns false), the function returns
-EINVAL without clearing ctx->walk_control.  This leaves a dangling
pointer to a stack-allocated structure that will be freed when the caller
returns.

This is structurally identical to the bug fixed in commit f9132fbc2e83
("mm/damon/core: remove call_control in inactive contexts") for
damon_call(), which had the same pattern of linking a control object and
returning an error without unlinking it.

The dangling walk_control pointer can cause:
1. Use-after-free if the context is later started and kdamond
   dereferences ctx->walk_control (e.g., in damos_walk_cancel()
   which writes to control->canceled and calls complete())
2. Permanent -EBUSY from subsequent damos_walk() calls, since the
   stale pointer is non-NULL

Nonetheless, the real user impact is quite restrictive.  The
use-after-free is impossible because there is no damos_walk() callers who
starts the context later.  The permanent -EBUSY can actually confuse
users, as DAMON is not running.  But the symptom is kept only while the
context is turned off.  Turning it on again will make DAMON internally
uses a newly generated damon_ctx object that doesn't have the invalid
damos_walk_control pointer, so everything will work fine again.

Fix this by clearing ctx->walk_control under walk_control_lock before
returning -EINVAL, mirroring the fix pattern from f9132fbc2e83.

Link: https://lkml.kernel.org/r/20260224011102.56033-1-sj@kernel.org
Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Reported-by: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>
Closes: https://lore.kernel.org/CPUPR80MB8171025468965E583EF2490F956CA@CPUPR80MB8171.lamprd80.prod.outlook.com
Signed-off-by: Raul Pazemecxas De Andrade <raul_pazemecxas@hotmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.14+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1531,8 +1531,13 @@ int damos_walk(struct damon_ctx *ctx, st
 	}
 	ctx->walk_control = control;
 	mutex_unlock(&ctx->walk_control_lock);
-	if (!damon_is_running(ctx))
+	if (!damon_is_running(ctx)) {
+		mutex_lock(&ctx->walk_control_lock);
+		if (ctx->walk_control == control)
+			ctx->walk_control = NULL;
+		mutex_unlock(&ctx->walk_control_lock);
 		return -EINVAL;
+	}
 	wait_for_completion(&control->completion);
 	if (control->canceled)
 		return -ECANCELED;



