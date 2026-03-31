Return-Path: <stable+bounces-232479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ5/AkUIzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:45:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBDB36F450
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137DC3068F30
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D24330AD00;
	Tue, 31 Mar 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMkMA4K8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3E303A07;
	Tue, 31 Mar 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976854; cv=none; b=pKOzvnKoPpNkpOSXTKMdZxCNvhqQHbxxr/Prx1bvkuQ8157cJTygr6xfMSTqYQWOI31wfnCqgoDcaPhv3hooJHaoX/G54Z4IBh6JmxIaVuB0GwDnxU9wzHR9VGjq6Wi671ccq3My7e4bnwWjMT47S5NT+2CyfnGVGm4JyGeixGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976854; c=relaxed/simple;
	bh=vjjQHZMDGkxhKkb3z+auWZtXu7X8c6IDMgt0dVo7S4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANwLdmcbiqURxAsU9ewGAZjM+jY1h+tF3Gw5aQCKMaCwcZCSvc8ailV5zngSbaf68kNpt2RC4UaBuKrDhTSum3Rkc9c+RzWea9pxa6h4xNyQB0KITZX5y49r2t7AuhmiuHeUrDSPLx5/DPlIT3T89HqQXVD21ov9DITm8gHOyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMkMA4K8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A20C19423;
	Tue, 31 Mar 2026 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976854;
	bh=vjjQHZMDGkxhKkb3z+auWZtXu7X8c6IDMgt0dVo7S4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMkMA4K8kAV4Jm1KQaATunmjqiK8gZiq8022pWzwLd2lVg64/6DKlVhY9kuWWv55w
	 vdkUnX3CSoAzL5bYFtOavr6Cd8PNuxEcoOlouDQlprTsmmbCLwUA3IIaXnmI4TMtS1
	 NypyfpkIkbv58npZkBHfkKGZ/mk/zwDbQv4DF0KE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.18 236/309] drm/i915: Order OP vs. timeout correctly in __wait_for()
Date: Tue, 31 Mar 2026 18:22:19 +0200
Message-ID: <20260331161802.264432535@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232479-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7BBDB36F450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 6ad2a661ff0d3d94884947d2a593311ba46d34c2 upstream.

Put the barrier() before the OP so that anything we read out in
OP and check in COND will actually be read out after the timeout
has been evaluated.

Currently the only place where we use OP is __intel_wait_for_register(),
but the use there is precisely susceptible to this reordering, assuming
the ktime_*() stuff itself doesn't act as a sufficient barrier:

__intel_wait_for_register(...)
{
	...
	ret = __wait_for(reg_value = intel_uncore_read_notrace(...),
 			 (reg_value & mask) == value, ...);
	...
}

Cc: stable@vger.kernel.org
Fixes: 1c3c1dc66a96 ("drm/i915: Add compiler barrier to wait_for")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260313110740.24620-1-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit a464bace0482aa9a83e9aa7beefbaf44cd58e6cf)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_wait_util.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_wait_util.h
+++ b/drivers/gpu/drm/i915/i915_wait_util.h
@@ -25,9 +25,9 @@
 	might_sleep();							\
 	for (;;) {							\
 		const bool expired__ = ktime_after(ktime_get_raw(), end__); \
-		OP;							\
 		/* Guarantee COND check prior to timeout */		\
 		barrier();						\
+		OP;							\
 		if (COND) {						\
 			ret__ = 0;					\
 			break;						\



