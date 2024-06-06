Return-Path: <stable+bounces-48297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339F8FE72F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A3328361D
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D11195B0D;
	Thu,  6 Jun 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="unBYZXu6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DE153821
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679365; cv=none; b=o/rUyackqI+Iv3Y9HDMflP1JLP5FvyEpO1xDyJGe+WO2g3RjBY4+vnOHKhRyuecwFzNdOPqITLl7ybComCtCNZsOvjW4Vl57xNax8LDXOdOgdxTbO7bV4o6TMRApJATG+40se7IltVtwBve/y2KZALmOegi6dxBCJaa3Pz0I64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679365; c=relaxed/simple;
	bh=erSn7Zm+WuhZb8LLd9MaR567X04aaDMFNDAVsDyfA1M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d+j06K1fgm5haCviFTSTh/nFy2+SPu0WcTfVsqHy1emQMtPKlTRHoZluwA1Jh2F5wL7bg7t9KjZ0gnkCdq4UzSIlR6Osjt/u9zkFCHN9QFZB1HBaDw/1UxJV/k6HxsPoLtCn6LBEMHhii20hjsmbZAKxiGQ0c4zZExk1aO1fcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=unBYZXu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FC1C2BD10;
	Thu,  6 Jun 2024 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717679365;
	bh=erSn7Zm+WuhZb8LLd9MaR567X04aaDMFNDAVsDyfA1M=;
	h=Subject:To:Cc:From:Date:From;
	b=unBYZXu6BfcurstLE6iTtjDFn8ieatR1oHOjv2SHWAguOwWGwO6nqPQczOHC3Lc6o
	 A679Igz+i2wW4vGZSUrSoJJfG4gxopIF+3r9tO/O7IPRoNZJqX8mCl5UjaTAR4MgXs
	 TENcwDekm6+pkbL2HD1UuZmVlwVDTD227AVMU09I=
Subject: FAILED: patch "[PATCH] x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only" failed to apply to 6.9-stable tree
To: tglx@linutronix.de,bp@alien8.de,christian@heusel.eu,teichmanntim@outlook.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 06 Jun 2024 15:09:24 +0200
Message-ID: <2024060624-platinum-ladies-9214@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 34bf6bae3286a58762711cfbce2cf74ecd42e1b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024060624-platinum-ladies-9214@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

34bf6bae3286 ("x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on family 0x17 and greater")
21f546a43a91 ("Merge branch 'x86/urgent' into x86/cpu, to resolve conflict")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 34bf6bae3286a58762711cfbce2cf74ecd42e1b5 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 28 May 2024 22:21:31 +0200
Subject: [PATCH] x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only
 on family 0x17 and greater

The new AMD/HYGON topology parser evaluates the SMT information in CPUID leaf
0x8000001e unconditionally while the original code restricted it to CPUs with
family 0x17 and greater.

This breaks family 0x15 CPUs which advertise that leaf and have a non-zero
value in the SMT section. The machine boots, but the scheduler complains loudly
about the mismatch of the core IDs:

  WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:6482 sched_cpu_starting+0x183/0x250
  WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2408 build_sched_domains+0x76b/0x12b0

Add the condition back to cure it.

  [ bp: Make it actually build because grandpa is not concerned with
    trivial stuff. :-P ]

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/56
Reported-by: Tim Teichmann <teichmanntim@outlook.de>
Reported-by: Christian Heusel <christian@heusel.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tim Teichmann <teichmanntim@outlook.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index d419deed6a48..7d476fa697ca 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -84,9 +84,9 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 
 	/*
 	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here.
+	 * already and nothing to do here. Only valid for family >= 0x17.
 	 */
-	if (!has_topoext) {
+	if (!has_topoext && tscan->c->x86 >= 0x17) {
 		/*
 		 * Leaf 0x80000008 set the CORE domain shift already.
 		 * Update the SMT domain, but do not propagate it.


