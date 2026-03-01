Return-Path: <stable+bounces-222041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ0sE7Ggo2noIgUAu9opvQ
	(envelope-from <stable+bounces-222041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:13:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A150A1CD483
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81E4033E40DD
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A630B517;
	Sun,  1 Mar 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKqwxiQg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B62F0C7E
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329758; cv=none; b=QrX4/rCpqX7WABg7aB0qIIohJEwhhaQiwUEYu9xhsim954IMKbRKjZeMuRx1ch7vpxMzj5uMqzv0c5MAO7SfM3n1invUwFV/JXwlzvh99Jf68Lt1doALUsNyyoFSSqP8swBO3QoI/rNnfiWmJXSzzwjP+vLz8gclOuZcV3lewkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329758; c=relaxed/simple;
	bh=2f/4LlmLaQdv+rQoNNgthrk/pCl5uvXoFWD9PYlqA7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgFC8b7fzCS1LRYOYPcrNUadl727b85OvjOzy9PrhZj4ZxAK1IWsiUP1iEf2BbWuPIWTGFAy/xLW5udtGqmS4lh9nxHdJERJr9GTf8bg8+s01OGJk6UYkpur8kaAnoRm/BW6sFNuUS/Sx3OmtIhd7qfk3zMwP7EVKDs6ohZ4SsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKqwxiQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF25C19421;
	Sun,  1 Mar 2026 01:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329758;
	bh=2f/4LlmLaQdv+rQoNNgthrk/pCl5uvXoFWD9PYlqA7o=;
	h=From:To:Cc:Subject:Date:From;
	b=KKqwxiQgwcNiWNWjNOKAWiv4oC3v+zNIhPqc0toix+VUe1ES7G7JEpMb7ueGA6WOa
	 dFB18fiKLHukcXw+67if/36+WrD3iELhqlsKuTPUHe+O9fxqsD4NV//M1SWWVHJsyj
	 9RjRtOsoHDmlnbmC3naJUr0xXvoNCzlGu2MbYA4CjS1E3qYKevQjTb4TZ+k5YsK1/h
	 3J6+gkluXolBo5PY8PqoSN9ja62C8AUfaWRRfG4uX1CRk7ZAQTZyZtrtxx0DeJCkB7
	 fmOhy0RW6rSgbhaHAiYOROBxClpLXF565ld176lWD0OX6YsbU9RbC573/lQQxacZ5S
	 +u2VvgQQNfsJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	leitao@debian.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "arm64: Disable branch profiling for all arm64 code" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:49:16 -0500
Message-ID: <20260301014916.1713684-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222041-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: A150A1CD483
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f22c81bebf8bda6e54dc132df0ed54f6bf8756f9 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Tue, 6 Jan 2026 02:16:35 -0800
Subject: [PATCH] arm64: Disable branch profiling for all arm64 code

The arm64 kernel doesn't boot with annotated branches
(PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.

Bisecting it, I found that disabling branch profiling in arch/arm64/mm
solved the problem. Narrowing down a bit further, I found that
physaddr.c is the file that needs to have branch profiling disabled to
get the machine to boot.

I suspect that it might invoke some ftrace helper very early in the boot
process and ftrace is still not enabled(!?).

Rather than playing whack-a-mole with individual files, disable branch
profiling for the entire arch/arm64 tree, similar to what x86 already
does in arch/x86/Kbuild.

Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Kbuild | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 5bfbf7d79c99b..d876bc0e54211 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# Branch profiling isn't noinstr-safe
+subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y			+= kernel/ mm/ net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
-- 
2.51.0





