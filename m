Return-Path: <stable+bounces-221832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFeTDVSao2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:45:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0426C1CB9C4
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5819308B074
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569FF2EE5FD;
	Sun,  1 Mar 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhAQgWSG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEA1CD2C
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329247; cv=none; b=n8Vt9uV0zcP4XfODDQakHZYN5dUqRRVj+51afWBnzq2Mzzg80iLDJAoZu2KoXFIBT8vg9WxU3WOaSOgK36IjV1dnBrIcTAEm/JGlm6WlFJuMR4aaQt5+4mKnfqqOQmVkYV868XUzRuLVIQTia2y87qWz6EYcy5hQXgjB1o8maZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329247; c=relaxed/simple;
	bh=wRIuBqJa1mjTxbWlqcsQlvZamXHhr9wqwEByIjHA7Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zlhl7PSYR/72G66wX4v80vdAjgxbwDuef/Y9FY3hDfZG8Ss5v0Aav1rFas82eX8lnhmR0GF9gCwUliPDL5ksnVmOtimZKucyABfeRq7az9n18Spg4scvPgxOzA9yLhB5WwJDTVEhnldTRr8XbPCW7KTBkMqBnOdWDJXYp5peRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhAQgWSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675FFC19421;
	Sun,  1 Mar 2026 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329247;
	bh=wRIuBqJa1mjTxbWlqcsQlvZamXHhr9wqwEByIjHA7Ds=;
	h=From:To:Cc:Subject:Date:From;
	b=OhAQgWSGtic9IU7X7ZS9/NuolwgI/jWjHDOe5Jbnw+5/0Vrw6Cs60oC2MYc0Ng7R8
	 Thw9y5jlz9Qv78mojBnHZJHg9ibHl0n2S7+7cny93++4N7hL3Q7+gGQDpMuTA4jZMh
	 okRjDYYdQ0LvJfwK50mgqmSYobMyyS0XSXnwNoXH2OjKWQsStr82KUqpS4h46GQdJ0
	 xiqES7d0/iVAooOMRbgJfubtNL3j5AtTkIUNeXkwsD4ARjwq+q/+rDLkQhO1xxcgmD
	 xBYwN0Xf/YY/TwodblKBr7Gz8qZvrYxm8SIS5gYN7Td8PdEQePo0hFrhmI2cMO/09Q
	 PUqpaiTGJztEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	leitao@debian.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "arm64: Disable branch profiling for all arm64 code" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:40:45 -0500
Message-ID: <20260301014045.1702128-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221832-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0426C1CB9C4
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





