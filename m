Return-Path: <stable+bounces-43635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0A68C41BF
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC5C1C22FE2
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE127152182;
	Mon, 13 May 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6sDhMm3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0B1514E5
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606558; cv=none; b=JFo2+7odWYqE0tyNodcd915ckvLPyPwQCYLCHzHKxw2zxBOP8NQ0sLlIf8u5kT4Mt6TNo7lynS1/XIQC75YH6HUfInsB27FQ7iPCKaXofoo/NHLb82QQTjmQp3E/KpWgOKVhZxC0J2+TxKoTJqPg3cqRTXtT/vn8UADP9YrCHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606558; c=relaxed/simple;
	bh=99dNyAddehW/RniWg7v+BgtZc8IY4YbDkwu07ZP1CGc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Na2+fbvXaWK9UjQvwMmnRGz5qkNr+NqIieywIDvJksv5JPrp3VVteEECYMQ7YFXw1yqEn4YVcMDygzzHHsSy6dkneiD3Ka36tr171QCQW0njAy/9BNOwvgK8hWqqqpqpACusRZyMIc5vRrYm5otmLU6+DhNcB3WuVAk5lDo3u00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6sDhMm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9386C32781;
	Mon, 13 May 2024 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715606558;
	bh=99dNyAddehW/RniWg7v+BgtZc8IY4YbDkwu07ZP1CGc=;
	h=Subject:To:Cc:From:Date:From;
	b=u6sDhMm3z7rRogJQT2Kyw/64C7vVSi7j4Prv3odqkiUn52p0wjY0iET8eHvWLkLyF
	 Snp2pyiqZ0FrKw+KMtwPSzW6KATwYIAR/nL+GRoDx1tU2jYCob4Y6/E5mWFpgsHDIK
	 hvZxiB3FRo4vLb1nPSW3N9lsul4JiByEuduVZx04=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: clear pd_event queue in PORT_RESET" failed to apply to 6.1-stable tree
To: rdbabiera@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:22:35 +0200
Message-ID: <2024051335-reacquire-salvaging-9c43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bf20c69cf3cf9c6445c4925dd9a8a6ca1b78bfdf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051335-reacquire-salvaging-9c43@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


