Return-Path: <stable+bounces-185935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB0BE24F6
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982FD541530
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216C3148CA;
	Thu, 16 Oct 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i3aPFQrY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62565314A71
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605880; cv=none; b=gVwUmdiYmB5uLXPZlemow117BMW2Txc7D5n7qCr9hPy/MmVOQHK/qsf2QRMf0AhFBJHvFgJucEunk19MWsjXMbFFHWtfmxU65FrqXrXMdaG8GQt2CTyDQJmDbumuHh7Wkrhl5I0Z38Yff848o+RJEDEwU8sglbi4rUHqixwRwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605880; c=relaxed/simple;
	bh=lTqe4qpEcNsb+VSw4s0RzTY9ymjpwe3Ge76fEBmHU44=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZoDV3Y+RADOG+r6k4Zcq5+KBEE2ePcVOBBUZ5qoZ7uMKjFYDJiIgQFy8I9El209/QXzPnA5Yo5O7eqZwd97ddGtlGkRwx2erjtCcjHieNGVUjwaRZZuhudyY4n3qnQDjC7Rqn5euBxd27GyKTbXerorbi15Gik/g35a0y5xMAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i3aPFQrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC86C4CEF1;
	Thu, 16 Oct 2025 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605879;
	bh=lTqe4qpEcNsb+VSw4s0RzTY9ymjpwe3Ge76fEBmHU44=;
	h=Subject:To:Cc:From:Date:From;
	b=i3aPFQrYDQi9T4LoTkyvitJjPW8R6boumN7DoXxdyt3j5/ocQ7mN9kUwR/wJYD/og
	 LKYVXGCm4y3Qg63MYwW62jhYh8GsnpMH2ZIvx68ZTGiZLbjh47Rz7gjM1OBUm2afjL
	 IiKc8D8v2zLt/b4Ex8Od6iXRcctWuB0yrGqYdM4s=
Subject: FAILED: patch "[PATCH] xen/events: Return -EEXIST for bound VIRQs" failed to apply to 5.10-stable tree
To: jason.andryuk@amd.com,jgross@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:10:24 +0200
Message-ID: <2025101624-yield-grime-5287@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 07ce121d93a5e5fb2440a24da3dbf408fcee978e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101624-yield-grime-5287@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


