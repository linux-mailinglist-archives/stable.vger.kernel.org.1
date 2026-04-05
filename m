Return-Path: <stable+bounces-233337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLijIquc0mnGZAcAu9opvQ
	(envelope-from <stable+bounces-233337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 19:32:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89239F313
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DEF83001FA5
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A33329E117;
	Sun,  5 Apr 2026 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVH9bUZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60F21146C;
	Sun,  5 Apr 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775410340; cv=none; b=AcRYcPeb6VFlN9mPjiQwS11yUaDnbj3N6Nb+eZQuU/nOdfl5P/QG2Rp3KzBA4KNHjkLV3m17d3B6WavBYU9RIWewy1LmMG7ClKGmq875lCcPYafkEL5uLklNJxN/eeI6gAYanWCsFLp97VPRMInLQEAIzsArCvmIgRzFVpQik00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775410340; c=relaxed/simple;
	bh=hE0++g8JcoiwrL8/f2IPMZtOVIcn+kjT6TZDvQVjTIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CcYxf33D81lWN9KSFf/0dLIEQ5xmr+/Aan7RgF+VF40wlF1GH770CzwnZ35rPL714t6QkfsRVsDCQ0SWP0i5fzwYgEqj1GvsNsgZfzXDRF++bv1u1mDXtL2uZGAR36k8Ad9ttYr/CtCvuBkMWXWhQmyIlYuu9Drn/CXrSelmnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVH9bUZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC365C116C6;
	Sun,  5 Apr 2026 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775410339;
	bh=hE0++g8JcoiwrL8/f2IPMZtOVIcn+kjT6TZDvQVjTIo=;
	h=From:Date:Subject:To:Cc:From;
	b=YVH9bUZzgQhgwBDmijSeTEqbYI829zBALIAZkbk7xl38CSfc8LKjoLrIFjUl7ga/0
	 6ju1ol6v5PiE3Hj0VsgQ89z1hjG5rciEnUDh9fFnU8QNmmOWjy+BkbmIL9ghwfEUZM
	 JGZn31nuN/jol26kDc5akrcguw6BmfCxqkjonmfdO1j5Vfge4uAM0TwlfBk4epawFO
	 KfvRQiCC+0lnNvIAPJuG5wF1zCx8FKCddpsXE+ZJhv6u4YOEgvDIgrpzSmY+kUQppl
	 iQVWuJQh8aXeKI71E8OliNo5bS+KJFSk+fdJBVpN0eA3DDHPsFr4pg97gAbNifeK6Y
	 4dqrZMm2FLSnw==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sun, 05 Apr 2026 13:31:50 -0400
Subject: [PATCH] printf: mark errptr() noinline
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMPQ6DMAxA4asgz1gK4WfoVSoG6jjUCAUUp1Wli
 LsT6PgN72VQjsIKjypD5K+obKGgqSug9xRmRnHFYI0dTGd63KOE5DGxJtxWhzMR+qb1TG4aett
 BKffIXn739Tn+rZ/XwpSuFRzHCUrcAgZ3AAAA
X-Change-ID: 20260405-printf-test-old-gcc-f13fecda6524
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; i=tamird@kernel.org;
 h=from:subject:message-id; bh=hE0++g8JcoiwrL8/f2IPMZtOVIcn+kjT6TZDvQVjTIo=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJmX5ixqFxdt/NixkWX538OaIWdO8/4QvhWXJ/rwwPr93
 cdf/DCK65jIwiDGxWAppsiSKHpob3rq7T2yme+Ow8xhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6BjrGDFycAjDVdrMYGdpfn6i7lPCj8rx6pJZE76/q6ct/Lv6yr8tUcr+K8PeJsyUZ/ldf/be
 o3OhonPayNw/dN8T+tHj36FNSUcTpgJidrI0Sl7gB
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-233337-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6C89239F313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Old GCC can miscompile printf_kunit's errptr() test when branch
profiling is enabled. BUILD_BUG_ON(IS_ERR(PTR)) is a constant false
expression, but CONFIG_TRACE_BRANCH_PROFILING and
CONFIG_PROFILE_ALL_BRANCHES make the IS_ERR() path side-effectful.
GCC's IPA splitter can then outline the cold assert arm into
errptr.part.* and leave that clone with an unconditional
__compiletime_assert_*() call, causing a false build failure.

This started showing up after test_hashed() became a macro and moved its
local buffer into errptr(), which changed GCC's inlining and splitting
decisions enough to expose the compiler bug.

Mark errptr() noinline to keep it out of that buggy IPA path while
preserving the BUILD_BUG_ON(IS_ERR(PTR)) check and the macro-based
printf argument checking.

Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@intel.com/
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 lib/tests/printf_kunit.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
index f6f21b445ece..a8087e8ac826 100644
--- a/lib/tests/printf_kunit.c
+++ b/lib/tests/printf_kunit.c
@@ -749,7 +749,23 @@ static void fourcc_pointer(struct kunit *kunittest)
 	fourcc_pointer_test(kunittest, try_cb, ARRAY_SIZE(try_cb), "%p4cb");
 }
 
-static void
+/*
+ * GCC < 12.1 can miscompile this test when branch profiling is enabled.
+ *
+ * BUILD_BUG_ON(IS_ERR(PTR)) is a constant false expression, but old GCC can
+ * still trip over it after CONFIG_TRACE_BRANCH_PROFILING and
+ * CONFIG_PROFILE_ALL_BRANCHES rewrite the IS_ERR() unlikely() path into
+ * side-effectful branch counter updates. IPA splitting then outlines the cold
+ * assert arm into errptr.part.* and leaves that clone with an unconditional
+ * __compiletime_assert_*() call, so the build fails even though PTR is not an
+ * ERR_PTR.
+ *
+ * Keep this test out of that buggy IPA path so the BUILD_BUG_ON() can stay in
+ * place without open-coding IS_ERR(). This can be removed once the minimum GCC
+ * includes commit 76fe49423047 ("Fix tree-optimization/101941: IPA splitting
+ * out function with error attribute"), which first shipped in GCC 12.1.
+ */
+static noinline void
 errptr(struct kunit *kunittest)
 {
 	test("-1234", "%pe", ERR_PTR(-1234));

---
base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
change-id: 20260405-printf-test-old-gcc-f13fecda6524

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


