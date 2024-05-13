Return-Path: <stable+bounces-43637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C58C41C1
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461B228259A
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB046152185;
	Mon, 13 May 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PobVgbW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1A15217E
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606565; cv=none; b=pmIl+KEMpMwJwPalu002QQON+GRsld3RJ2dIzb3DO2QCy1LrP1LDl2NTF1eDG/OzMzhlTNUOa1Bwrao4TDNhVaKEdT65lLYaw1WQZCk29hoNhDxl6v9augv6751Tr3ChKufULzL83ntvR/l+LHQ5850l5QVxGYlOnAPLbWAhcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606565; c=relaxed/simple;
	bh=FS1VylANIgXftEly3m6vZuUYRn7ddwo4CroLft9IC3I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ie+yt9/7R4CraSUnMqDJjDTUFErsygT0AVgnzATscUBn3wSOviB0l2LY9eOWzGRW7GBlwq4lXg3/OeEEoFxWvhn/aigyUFbhZEHm8IuvleNBieyVQ27Lj0BWrCHJ+1EVJwYMIyDHl7OOHF/BUbr7apnN40bQ9ifcwFoWgVmEEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PobVgbW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96056C32781;
	Mon, 13 May 2024 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715606565;
	bh=FS1VylANIgXftEly3m6vZuUYRn7ddwo4CroLft9IC3I=;
	h=Subject:To:Cc:From:Date:From;
	b=PobVgbW1itAYE7JjgBS+ZlW3RyvMRMRmOt+iifTlmWJa0jiIfmt/Hv/Y3ZE1If/LJ
	 IDZ+y22UQXp9ebLY2CvsKutSjglsf2UACyc9zbSSwAxy3emlcbIgYiwnI2CubPai5m
	 m3oa4pU8ug5tBoqyjftjAtGjpJQCqwznBq4UDAys=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: clear pd_event queue in PORT_RESET" failed to apply to 5.15-stable tree
To: rdbabiera@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:22:36 +0200
Message-ID: <2024051335-augmented-overblown-4920@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bf20c69cf3cf9c6445c4925dd9a8a6ca1b78bfdf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051335-augmented-overblown-4920@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

bf20c69cf3cf ("usb: typec: tcpm: clear pd_event queue in PORT_RESET")
197331b27ac8 ("usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices")
1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf20c69cf3cf9c6445c4925dd9a8a6ca1b78bfdf Mon Sep 17 00:00:00 2001
From: RD Babiera <rdbabiera@google.com>
Date: Tue, 23 Apr 2024 20:27:16 +0000
Subject: [PATCH] usb: typec: tcpm: clear pd_event queue in PORT_RESET

When a Fast Role Swap control message attempt results in a transition
to ERROR_RECOVERY, the TCPC can still queue a TCPM_SOURCING_VBUS event.

If the event is queued but processed after the tcpm_reset_port() call
in the PORT_RESET state, then the following occurs:
1. tcpm_reset_port() calls tcpm_init_vbus() to reset the vbus sourcing and
sinking state
2. tcpm_pd_event_handler() turns VBUS on before the port is in the default
state.
3. The port resolves as a sink. In the SNK_DISCOVERY state,
tcpm_set_charge() cannot set vbus to charge.

Clear pd events within PORT_RESET to get rid of non-applicable events.

Fixes: b17dd57118fe ("staging: typec: tcpm: Improve role swap with non PD capable partners")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240423202715.3375827-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 99a039374f9c..a0e0ffd5a64b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5605,6 +5605,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
+		port->pd_events = 0;
 		if (port->self_powered)
 			tcpm_set_cc(port, TYPEC_CC_OPEN);
 		else


