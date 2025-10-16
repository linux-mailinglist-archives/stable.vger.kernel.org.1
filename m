Return-Path: <stable+bounces-185907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF624BE23F7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989363AB9FB
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88BB2E62AD;
	Thu, 16 Oct 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nn9vR11f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C842DF6E9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605049; cv=none; b=YSeTptPL826mWJN796u2z92tYk5sLbFTaO6fpU9Tvz+7k6VX6oEqwAZ0zxCBUdPciui5jmOUT97X1dZFtHUKSpoGWiZSTGu/jnfM956gA+sMR8MCqo5IPqP6HzVwoxRYDf5bt+5iB6N6CcWOONlXHXiGJ6Mm6Qj9FOdnYJI4U0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605049; c=relaxed/simple;
	bh=3UL7ryWh2VNPn2/jUoVEYQhvF6aljtCPLGMqB+HXCdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=erGdmj/VxUqoEVgf8OTY6xQ4l1qSL5i/tnTpLPRszbz8E/y569uVA07fcxywlvAHuOj3wMQFvhdLPdPsZIElFpGvayAqNryUCei6Y0WAkm26Z+HOa9vQ38Sbv1gcUlAbtqLEdpjDyG2UnL0h7Te52wpeesGQ9Xyhx9K47cf5zrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nn9vR11f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7891C4CEF1;
	Thu, 16 Oct 2025 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605049;
	bh=3UL7ryWh2VNPn2/jUoVEYQhvF6aljtCPLGMqB+HXCdM=;
	h=Subject:To:Cc:From:Date:From;
	b=nn9vR11fjcJB4oND6fK+jakYLhLgXb1XDNGVkd+/prWmzvhf4dt2cruDwpoFk5mPR
	 DUC+NOJi77mUdkVJmnSiUyw0aEPbEXJVYa8F2rC4FA+tSJWuELAk6EivNFhgsJzPqm
	 +Vm/iXhrYgFsFD3HLrFJy4OH4+VDqiZ8z52goq+o=
Subject: FAILED: patch "[PATCH] xen/events: Cleanup find_virq() return codes" failed to apply to 5.4-stable tree
To: jason.andryuk@amd.com,jbeulich@suse.com,jgross@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:57:26 +0200
Message-ID: <2025101626-colony-unbend-f00e@gregkh>
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
git cherry-pick -x 08df2d7dd4ab2db8a172d824cda7872d5eca460a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101626-colony-unbend-f00e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08df2d7dd4ab2db8a172d824cda7872d5eca460a Mon Sep 17 00:00:00 2001
From: Jason Andryuk <jason.andryuk@amd.com>
Date: Wed, 27 Aug 2025 20:36:01 -0400
Subject: [PATCH] xen/events: Cleanup find_virq() return codes

rc is overwritten by the evtchn_status hypercall in each iteration, so
the return value will be whatever the last iteration is.  This could
incorrectly return success even if the event channel was not found.
Change to an explicit -ENOENT for an un-found virq and return 0 on a
successful match.

Fixes: 62cc5fc7b2e0 ("xen/pv-on-hvm kexec: rebind virqs to existing eventchannel ports")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250828003604.8949-2-jason.andryuk@amd.com>

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 41309d38f78c..374231d84e4f 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1318,10 +1318,11 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 {
 	struct evtchn_status status;
 	evtchn_port_t port;
-	int rc = -ENOENT;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
+		int rc;
+
 		status.dom = DOMID_SELF;
 		status.port = port;
 		rc = HYPERVISOR_event_channel_op(EVTCHNOP_status, &status);
@@ -1331,10 +1332,10 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 			continue;
 		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
 			*evtchn = port;
-			break;
+			return 0;
 		}
 	}
-	return rc;
+	return -ENOENT;
 }
 
 /**


