Return-Path: <stable+bounces-185909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C432BE23FD
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB00634AFBA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DDD30C617;
	Thu, 16 Oct 2025 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sq0N/eCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859F2E62AD
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605081; cv=none; b=AbYu+BtEOgGwb2VxiB0gdw5q8fG4IcCV0a37AfcJkXz//lWz/9HIdYkwR14zf+4w5j0gVuyOO/tet93fXgMBsPW6EgTYikU/8QVairVMJAND/tZErPpGRoUVz4YF8uzLwc0l2ECIjrD/9AqGobYsxu5p+TNiROCzCzBF8I/GBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605081; c=relaxed/simple;
	bh=Qbk94x6C8r3PUOr9iq/xKCNYdp613MVQFEyVJ69LPKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uz0ieEtsKgTXRG0gWJi9RhjnDVq/Wt9ZTcdP6d2ITBg/xLW5O9mtNUcGB2izTq838r1NJTadWj017bChLkavRw5VNNmUewFil8Pgb5ttvvPvYTzgnumCSjAOi20+J27pTRLiMCoXOeCJbn1IS2yLM2jDTh+xXOjGw/dkTz2jBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sq0N/eCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BDEC4CEF1;
	Thu, 16 Oct 2025 08:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605080;
	bh=Qbk94x6C8r3PUOr9iq/xKCNYdp613MVQFEyVJ69LPKw=;
	h=Subject:To:Cc:From:Date:From;
	b=Sq0N/eCbWGb4KEoQq7jJxuG2zBwrUnhUfrxAeCCtL5xZ94TmOVFOrCG5UiJmDAalC
	 H16OLp2HajwcxLzhuqIym3MZD8YEN0/EVSaqc+JVxRmPxBnknSCrObatPy0/jOH6a9
	 A+ZF+0XEsd/dKzh2WoJl5doQN3rfZYDQkZYs3zpc=
Subject: FAILED: patch "[PATCH] xen/events: Return -EEXIST for bound VIRQs" failed to apply to 5.4-stable tree
To: jason.andryuk@amd.com,jgross@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:57:57 +0200
Message-ID: <2025101657-dragonish-scarcity-3be3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 07ce121d93a5e5fb2440a24da3dbf408fcee978e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101657-dragonish-scarcity-3be3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07ce121d93a5e5fb2440a24da3dbf408fcee978e Mon Sep 17 00:00:00 2001
From: Jason Andryuk <jason.andryuk@amd.com>
Date: Wed, 27 Aug 2025 20:36:02 -0400
Subject: [PATCH] xen/events: Return -EEXIST for bound VIRQs

Change find_virq() to return -EEXIST when a VIRQ is bound to a
different CPU than the one passed in.  With that, remove the BUG_ON()
from bind_virq_to_irq() to propogate the error upwards.

Some VIRQs are per-cpu, but others are per-domain or global.  Those must
be bound to CPU0 and can then migrate elsewhere.  The lookup for
per-domain and global will probably fail when migrated off CPU 0,
especially when the current CPU is tracked.  This now returns -EEXIST
instead of BUG_ON().

A second call to bind a per-domain or global VIRQ is not expected, but
make it non-fatal to avoid trying to look up the irq, since we don't
know which per_cpu(virq_to_irq) it will be in.

Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250828003604.8949-3-jason.andryuk@amd.com>

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 374231d84e4f..b060b5a95f45 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1314,10 +1314,12 @@ int bind_interdomain_evtchn_to_irq_lateeoi(struct xenbus_device *dev,
 }
 EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq_lateeoi);
 
-static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
+static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn,
+		     bool percpu)
 {
 	struct evtchn_status status;
 	evtchn_port_t port;
+	bool exists = false;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
@@ -1330,12 +1332,16 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 			continue;
 		if (status.status != EVTCHNSTAT_virq)
 			continue;
-		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
+		if (status.u.virq != virq)
+			continue;
+		if (status.vcpu == xen_vcpu_nr(cpu)) {
 			*evtchn = port;
 			return 0;
+		} else if (!percpu) {
+			exists = true;
 		}
 	}
-	return -ENOENT;
+	return exists ? -EEXIST : -ENOENT;
 }
 
 /**
@@ -1382,8 +1388,11 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 			evtchn = bind_virq.port;
 		else {
 			if (ret == -EEXIST)
-				ret = find_virq(virq, cpu, &evtchn);
-			BUG_ON(ret < 0);
+				ret = find_virq(virq, cpu, &evtchn, percpu);
+			if (ret) {
+				__unbind_from_irq(info, info->irq);
+				goto out;
+			}
 		}
 
 		ret = xen_irq_info_virq_setup(info, cpu, evtchn, virq);


