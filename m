Return-Path: <stable+bounces-43645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA58C41D9
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE141F22E73
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E515218F;
	Mon, 13 May 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLmaE9eO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA1152171
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606740; cv=none; b=hjvxKHqSvaqHDVgmDsxp3rweTq8n6ph8vhWYrz5e1U74gs9Gweq3q48qsYa1r3PqLH+aNcvD+kLgHHEnR14SZndVxQhP4Lik4aSrac+pFhOAxdhDFPIuC2qwUFFQEdqzlyzPeiRaZNleayKxDSnRYOhgUCoZWrN0VZ65+zrkW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606740; c=relaxed/simple;
	bh=sk40VDwYK29ePhIh2i/SOEUW5lG5I6sUhYrquObHnHM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EO8WrMitxo07jS2luGO+OkKCeopywYSH+2uVwhdZtsjuDTv9a7EnFC2iJu0jqdMru2FLMTh7+dLWhBkKXW1ifQiVmNZ5mFtW1n0pquqT8+CUvMABymkhMzccKn9wsL4wPMRAdTn6VMQx2GcTz7W5p1Hf8BM199XGL39uWBc8HsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLmaE9eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A98C113CC;
	Mon, 13 May 2024 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715606739;
	bh=sk40VDwYK29ePhIh2i/SOEUW5lG5I6sUhYrquObHnHM=;
	h=Subject:To:Cc:From:Date:From;
	b=gLmaE9eOC8AETiUrg/GfhncHudVgyx+cOErdN0rfJsqMJrJOcELsKXgBiFQbFh5Jc
	 K9OIMi73rmejKzNxBUkTq40mnWimBXtK+5g0dsEPbxiLuERPERcahpVpiXSix7+IoI
	 624p9QnbQ26SeKt0WrFxUWTKnzfgzhwprTBC7B2s=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: enforce ready state when queueing alt mode" failed to apply to 5.10-stable tree
To: rdbabiera@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:25:27 +0200
Message-ID: <2024051326-travesty-kindle-cdeb@gregkh>
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
git cherry-pick -x cdc9946ea6377e8e214b135ccc308c5e514ba25f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051326-travesty-kindle-cdeb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

cdc9946ea637 ("usb: typec: tcpm: enforce ready state when queueing alt mode vdm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cdc9946ea6377e8e214b135ccc308c5e514ba25f Mon Sep 17 00:00:00 2001
From: RD Babiera <rdbabiera@google.com>
Date: Tue, 23 Apr 2024 20:23:57 +0000
Subject: [PATCH] usb: typec: tcpm: enforce ready state when queueing alt mode
 vdm

Before sending Enter Mode for an Alt Mode, there is a gap between Discover
Modes and the Alt Mode driver queueing the Enter Mode VDM for the port
partner to send a message to the port.

If this message results in unregistering Alt Modes such as in a DR_SWAP,
then the following deadlock can occur with respect to the DisplayPort Alt
Mode driver:
1. The DR_SWAP state holds port->lock. Unregistering the Alt Mode driver
results in a cancel_work_sync() that waits for the current dp_altmode_work
to finish.
2. dp_altmode_work makes a call to tcpm_altmode_enter. The deadlock occurs
because tcpm_queue_vdm_unlock attempts to hold port->lock.

Before attempting to grab the lock, ensure that the port is in a state
vdm_run_state_machine can run in. Alt Mode unregistration will not occur
in these states.

Fixes: 03eafcfb60c0 ("usb: typec: tcpm: Add tcpm_queue_vdm_unlocked() helper")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240423202356.3372314-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 77e632ea6872..53c1f308ebd7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1564,6 +1564,10 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
 				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
 {
+	if (port->state != SRC_READY && port->state != SNK_READY &&
+	    port->state != SRC_VDM_IDENTITY_REQUEST)
+		return;
+
 	mutex_lock(&port->lock);
 	tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
 	mutex_unlock(&port->lock);


