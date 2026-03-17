Return-Path: <stable+bounces-225787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NJIAn4euWmbrQEAu9opvQ
	(envelope-from <stable+bounces-225787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:27:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7425E2A6AA1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C1C930900A3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0C35E93F;
	Tue, 17 Mar 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nkT1IMpj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9035E931
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739278; cv=none; b=UwLIUPQXgJM9LfRAxxWt9jrHkpBoRqP8ee6yYsP2UAG5DB2GuWu61botfybmz5Gi4B9OaPi1PBbpBMxW2CG5oN7UUzgXNH8A0wfIlv30EDcvGAMoZq/Cir85BeZTW6E6kQ6cB3Pm4LntjfVLoG4MCgtGcQkL5ag/cQsh60CTKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739278; c=relaxed/simple;
	bh=oOWfpGTYw8ksmikRnFwJIYrNnKOCh1GdrT05o7SUuWI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fgy1lYmB7nWEI0R8Z4/hCAjE67nuSJgDZkK9aq6rn2SfHFmfIS3afcZFfJXSecYGv8i8L9XaE+QVkm0dLcJdibpqgiZtBF7rUvYtGlYRnnT3EakGrknBUQXeqrdpuySmjpgv4twXM9zeAPx4rRmqoVnInf/4e14OX8eKITGRNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nkT1IMpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EF8C2BCAF;
	Tue, 17 Mar 2026 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773739277;
	bh=oOWfpGTYw8ksmikRnFwJIYrNnKOCh1GdrT05o7SUuWI=;
	h=Subject:To:Cc:From:Date:From;
	b=nkT1IMpjzET3UUwP+x3HEvt7mnmg/tWS6jTxt2MWnQFn8GgpHLoguEXsPzUb9QKfq
	 8SAggtsf6nAZXahor4JB34imup3oO7SoLWYAyVh+B1uwNbwSBnrccjS7sAT+WRZrpQ
	 LmCgUWf8184Qp9jflXfuWH6bJNrsZSewwLgTS2iY=
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow non-power of two min_region_sz" failed to apply to 6.19-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org,yanquanmin1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 10:21:14 +0100
Message-ID: <2026031714-concept-seventh-df3c@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225787-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7425E2A6AA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x c80f46ac228b48403866d65391ad09bdf0e8562a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031714-concept-seventh-df3c@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c80f46ac228b48403866d65391ad09bdf0e8562a Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 14 Feb 2026 13:41:21 -0800
Subject: [PATCH] mm/damon/core: disallow non-power of two min_region_sz

DAMON core uses min_region_sz parameter value as the DAMON region
alignment.  The alignment is made using ALIGN() and ALIGN_DOWN(), which
support only the power of two alignments.  But DAMON core API callers can
set min_region_sz to an arbitrary number.  Users can also set it
indirectly, using addr_unit.

When the alignment is not properly set, DAMON behavior becomes difficult
to expect and understand, makes it effectively broken.  It doesn't cause a
kernel crash-like significant issue, though.

Fix the issue by disallowing min_region_sz input that is not a power of
two.  Add the check to damon_commit_ctx(), as all DAMON API callers who
set min_region_sz uses the function.

This can be a sort of behavioral change, but it does not break users, for
the following reasons.  As the symptom is making DAMON effectively broken,
it is not reasonable to believe there are real use cases of non-power of
two min_region_sz.  There is no known use case or issue reports from the
setup, either.

In future, if we find real use cases of non-power of two alignments and we
can support it with low enough overhead, we can consider moving the
restriction.  But, for now, simply disallowing the corner case should be
good enough as a hot fix.

Link: https://lkml.kernel.org/r/20260214214124.87689-1-sj@kernel.org
Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>
Cc: <stable@vger.kernel.org>	[6.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 01eba1a547d4..adfc52fee9dc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1252,6 +1252,9 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
 
+	if (!is_power_of_2(src->min_region_sz))
+		return -EINVAL;
+
 	err = damon_commit_schemes(dst, src);
 	if (err)
 		return err;


