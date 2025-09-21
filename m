Return-Path: <stable+bounces-180759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97CB8DAA4
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821E8178704
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6591A9F97;
	Sun, 21 Sep 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syE9ezpg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE234BA52
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457096; cv=none; b=gBUHyGwp7NELNO5YWsqXdhMYx1jkR84Eq48UC8CPVV2ZNxRLjdxcHBfOKNf/Ich0vbtgeVdPWmpCkSX3/YgFu7hJavRdNr4L+Fp5w2fRD5NSdWZgdJyIUFWL8ya+jZmFuz+bp7m33UuRDEG0MmOvj9KexLCD1qfSrdf78u/9yJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457096; c=relaxed/simple;
	bh=5iY+NseRVXfUByTYGGVcEgu3PcyMCCftozEZ1CWcTWc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EOEJV4Ntv02eWNtKs5tb0XcJ2yr2GNFZ7mO/r9YAyye6Y7rvfKIAuN6qkeMBte7QSTGzHnmBr+UcbKf1iG1c2/HGjVejdQ5e3Gi+LM4Z34crRYsvMJwSEcuvFLUvKR7PFEtOun3RTcGByWQXYwOpKgqMUzlqAaazN4pwrFb2+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syE9ezpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B5CC4CEE7;
	Sun, 21 Sep 2025 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457094;
	bh=5iY+NseRVXfUByTYGGVcEgu3PcyMCCftozEZ1CWcTWc=;
	h=Subject:To:Cc:From:Date:From;
	b=syE9ezpg6Dzdaxoryc7GKFLbc57ruDrjchI4bTlfUWC80KOcdnuJC/ijfl5IY7woV
	 WTAMF6bvz/n+K+txE7r1SKQvDPhTkijHcBnef2k1gzFl0XfEdWx4KBAET3zWpwZfrR
	 i8bFRG4EK3IEwFElxAN3z1vpRsOibyxNL2XQy3ao=
Subject: FAILED: patch "[PATCH] samples/damon/wsse: avoid starting DAMON before" failed to apply to 6.16-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:18:12 +0200
Message-ID: <2025092111-specked-enviably-906d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x f826edeb888c5a8bd1b6e95ae6a50b0db2b21902
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092111-specked-enviably-906d@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f826edeb888c5a8bd1b6e95ae6a50b0db2b21902 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 8 Sep 2025 19:22:36 -0700
Subject: [PATCH] samples/damon/wsse: avoid starting DAMON before
 initialization

Patch series "samples/damon: fix boot time enable handling fixup merge
mistakes".

First three patches of the patch series "mm/damon: fix misc bugs in DAMON
modules" [1] were trying to fix boot time DAMON sample modules enabling
issues.  The issues are the modules can crash if those are enabled before
DAMON is enabled, like using boot time parameter options.  The three
patches were fixing the issues by avoiding starting DAMON before the
module initialization phase.

However, probably by a mistake during a merge, only half of the change is
merged, and the part for avoiding the starting of DAMON before the module
initialized is missed.  So the problem is not solved and thus the modules
can still crash if enabled before DAMON is initialized.  Fix those by
applying the unmerged parts again.

Note that the broken commits are merged into 6.17-rc1, but also backported
to relevant stable kernels.  So this series also needs to be merged into
the stable kernels.  Hence Cc-ing stable@.


This patch (of 3):

Commit 0ed1165c3727 ("samples/damon/wsse: fix boot time enable handling")
is somehow incompletely applying the origin patch [2].  It is missing the
part that avoids starting DAMON before module initialization.  Probably a
mistake during a merge has happened.  Fix it by applying the missed part
again.

Link: https://lkml.kernel.org/r/20250909022238.2989-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20250909022238.2989-2-sj@kernel.org
Link: https://lkml.kernel.org/r/20250706193207.39810-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20250706193207.39810-2-sj@kernel.org [2]
Fixes: 0ed1165c3727 ("samples/damon/wsse: fix boot time enable handling")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index da052023b099..21eaf15f987d 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -118,6 +118,9 @@ static int damon_sample_wsse_enable_store(
 		return 0;
 
 	if (enabled) {
+		if (!init_called)
+			return 0;
+
 		err = damon_sample_wsse_start();
 		if (err)
 			enabled = false;


