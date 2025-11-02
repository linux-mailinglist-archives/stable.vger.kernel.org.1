Return-Path: <stable+bounces-192022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA8BC28F7D
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3558A4E1D06
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855470824;
	Sun,  2 Nov 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XUlV0tor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E49A48
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090535; cv=none; b=Ev4eqzqO1+prTOQ6VXEMPsfpnA3ZgaKSpiz1+GiLwUyzYserAsVlIRUrsh5eoAHFTAk2jSBr7o1m4kdPpkfrIp8dq0zUv5s5UbFDZ8NBubXyzuSoTAejNBJSdlbmWVpMUhs6D1V5KYjvHmmmodveOtmA9SgGkTAc/DPT+Oiccl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090535; c=relaxed/simple;
	bh=IjbQqMvW3N5pWnRnL5HfxmzK2tw4+kZZZt9t/m42qX8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GriWhvWNuBW+Iu7Eg3BriJ+H+HVorqZqQ15NFUsEDyeQ2BSpj/RCGWsGDuJMIQS1OgF5ldTQJwbrhwpx2b3K2ooskrHIJRHN6hCGV7lN1v2eRs+W2KeDXfVQ52Zr15OvxO2MsJ9ZoYvwA+/M/tZ8AYIAUgDSSYhUG0CHTUg0Vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XUlV0tor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CC2C4CEF7;
	Sun,  2 Nov 2025 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090534;
	bh=IjbQqMvW3N5pWnRnL5HfxmzK2tw4+kZZZt9t/m42qX8=;
	h=Subject:To:Cc:From:Date:From;
	b=XUlV0torsBaeDN+xXJYV3mhgCpi9OjCGTkzJjJmWasX9iF2fcpwFYfkw/7bMb7yR6
	 dlh7IsUEFZGyRGH8L+XpsT6Os7FsS3C8YjjoNpOVIbyAGAGphV0d15Pqdz951JUWE0
	 h9UE/aP0bhsuizPShGJDtgSgM/+ZuHtVc5/MWduQ=
Subject: FAILED: patch "[PATCH] sched_ext: Mark scx_bpf_dsq_move_set_[slice|vtime]() with" failed to apply to 6.12-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:35:32 +0900
Message-ID: <2025110231-exposable-prelude-6f67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 54e96258a6930909b690fd7e8889749231ba8085
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110231-exposable-prelude-6f67@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54e96258a6930909b690fd7e8889749231ba8085 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 6 Oct 2025 15:35:36 -1000
Subject: [PATCH] sched_ext: Mark scx_bpf_dsq_move_set_[slice|vtime]() with
 KF_RCU

scx_bpf_dsq_move_set_slice() and scx_bpf_dsq_move_set_vtime() take a DSQ
iterator argument which has to be valid. Mark them with KF_RCU.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Cc: stable@vger.kernel.org # v6.12+
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..fc353b8d69f7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5688,8 +5688,8 @@ BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
@@ -5820,8 +5820,8 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)


