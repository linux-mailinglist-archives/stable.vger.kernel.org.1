Return-Path: <stable+bounces-245462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGkvMjoeA2r10gEAu9opvQ
	(envelope-from <stable+bounces-245462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:34:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459F52038B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE3DD30AC2B9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6074C043B;
	Tue, 12 May 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GVfqMb0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03A3672AC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588851; cv=none; b=IbSgVrHQ7C9oFTYCKrZawH+yOxaJQjtgENea4QD9Cx5onsYr7ExQY6z/kz6kIOiewW/7ZoKad7ZqqOurbL2rc9dKbp6V1QMTFxC2Hidhwr9PC2s6O14dRr+vhFjrN4c23uV7GT+RULdxa6WtxWf5gfXZteOtUyCQQySvMb9kX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588851; c=relaxed/simple;
	bh=98nlmGbHshaxxUFwBLboxPQ5/tWJoLIZAeHT0CGLjlg=;
	h=Subject:To:Cc:From:Date:Message-ID; b=ZiD9KlOzYsWRkiVl1U3HLqpCJvXiZtKWxWqNrxR2yuNnFRlvDW/AMAlLMS9HR6/L5KJWtKxfKHBBrWHtfOO3t0wk2FwBCuR8CkSWYV45jjnmGlZ1+i+VFZA3WzHJvv9Q+pm34DdMk3+XvYMPCG1k8MHxp4MwtQ8BMm2vg/c3LeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GVfqMb0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD5C2BCB0;
	Tue, 12 May 2026 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778588850;
	bh=98nlmGbHshaxxUFwBLboxPQ5/tWJoLIZAeHT0CGLjlg=;
	h=Subject:To:Cc:From:Date:From;
	b=GVfqMb0ZDQtqTcgfvbOUMGntktmJ9ImpsPWDZOpGniuCm/DZ+tWSbaW/dEbjxvQJ8
	 7j55wDTR6Nyh1LYtfFSbth56dPZv+YNojvEbdXMMa/eKDahHTc+njkQgpO/b/KUaNl
	 l/3LF+uOflJkp86RmniuoPZAjAEY8GLiUeiKr7g4=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: reset internal port states on soft reset" failed to apply to 5.10-stable tree
To: amitsd@google.com,badhri@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:27:14 +0200
Message-ID: <2026051214-rash-rehydrate-d416@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3459F52038B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245462-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:email,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2909f0d4994fb4306bf116df5ccee797791fce2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051214-rash-rehydrate-d416@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2909f0d4994fb4306bf116df5ccee797791fce2c Mon Sep 17 00:00:00 2001
From: Amit Sunil Dhamne <amitsd@google.com>
Date: Tue, 14 Apr 2026 00:58:32 +0000
Subject: [PATCH] usb: typec: tcpm: reset internal port states on soft reset
 AMS

Reset internal port states (such as vdm_sm_running and
explicit_contract) on soft reset AMS as the port needs to negotiate a
new contract. The consequence of leaving the states in as-is cond are as
follows:
  * port is in SRC power role and an explicit contract is negotiated
    with the port partner (in sink role)
  * port partner sends a Soft Reset AMS while VDM State Machine is
    running
  * port accepts the Soft Reset request and the port advertises src caps
  * port partner sends a Request message but since the explicit_contract
    and vdm_sm_running are true from previous negotiation, the port ends
    up sending Soft Reset instead of Accept msg.

Stub Log:
[  203.653942] AMS DISCOVER_IDENTITY start
[  203.653947] PD TX, header: 0x176f
[  203.655901] PD TX complete, status: 0
[  203.657470] PD RX, header: 0x124f [1]
[  203.657477] Rx VDM cmd 0xff008081 type 2 cmd 1 len 1
[  203.657482] AMS DISCOVER_IDENTITY finished
[  203.657484] cc:=4
[  204.155698] PD RX, header: 0x144f [1]
[  204.155718] Rx VDM cmd 0xeeee8001 type 0 cmd 1 len 1
[  204.155741] PD TX, header: 0x196f
[  204.157622] PD TX complete, status: 0
[  204.160060] PD RX, header: 0x4d [1]
[  204.160066] state change SRC_READY -> SOFT_RESET [rev2 SOFT_RESET_AMS]
[  204.160076] PD TX, header: 0x163
[  204.162486] PD TX complete, status: 0
[  204.162832] AMS SOFT_RESET_AMS finished
[  204.162840] cc:=4
[  204.162891] AMS POWER_NEGOTIATION start
[  204.162896] state change SOFT_RESET -> AMS_START [rev2 POWER_NEGOTIATION]
[  204.162908] state change AMS_START -> SRC_SEND_CAPABILITIES [rev2 POWER_NEGOTIATION]
[  204.162913] PD TX, header: 0x1361
[  204.165529] PD TX complete, status: 0
[  204.165571] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES_TIMEOUT @ 60 ms [rev2 POWER_NEGOTIATION]
[  204.166996] PD RX, header: 0x1242 [1]
[  204.167009] state change SRC_SEND_CAPABILITIES -> SRC_SOFT_RESET_WAIT_SNK_TX [rev2 POWER_NEGOTIATION]
[  204.167019] AMS POWER_NEGOTIATION finished
[  204.167020] cc:=4
[  204.167083] AMS SOFT_RESET_AMS start
[  204.167086] state change SRC_SOFT_RESET_WAIT_SNK_TX -> SOFT_RESET_SEND [rev2 SOFT_RESET_AMS]
[  204.167092] PD TX, header: 0x16d
[  204.168824] PD TX complete, status: 0
[  204.168854] pending state change SOFT_RESET_SEND -> HARD_RESET_SEND @ 60 ms [rev2 SOFT_RESET_AMS]
[  204.171876] PD RX, header: 0x43 [1]
[  204.171879] AMS SOFT_RESET_AMS finished

This causes COMMON.PROC.PD.11.2 check failure for
TEST.PD.VDM.SRC.2_Rev2Src test on the PD compliance tester.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Fixes: 8d3a0578ad1a ("usb: typec: tcpm: Respond Wait if VDM state machine is running")
Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable <stable@kernel.org>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260414-fix-soft-reset-v1-1-01d7cb9764e2@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index dfbb94ddc98a..cd5560d6f19e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5935,6 +5935,8 @@ static void run_state_machine(struct tcpm_port *port)
 		/* remove existing capabilities */
 		tcpm_partner_source_caps_reset(port);
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
+		port->vdm_sm_running = false;
+		port->explicit_contract = false;
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;


