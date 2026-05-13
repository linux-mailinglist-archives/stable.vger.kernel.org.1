Return-Path: <stable+bounces-246751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG2TIUANBGqLCwIAu9opvQ
	(envelope-from <stable+bounces-246751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:33:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4652D946
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35444306CB23
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F13A543B;
	Wed, 13 May 2026 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLSAH4cI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2630FC27
	for <stable@vger.kernel.org>; Wed, 13 May 2026 05:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650427; cv=none; b=U+JIm4mOH4MdT7voyIP+n4Ey4Z0sB3ufP5Rr/X+muUNymlmFZKiwtZjBCMayVCRLVZIc9ctHh7jQNpKtshExG2rMQbBhwbYnPUZollHBaktnXUOSV3GI0axcNYXEdxXVfPDxE8OtUg9Kqvkt5uFzYcpnv+MqnSFTXtTrvCIlEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650427; c=relaxed/simple;
	bh=ywHjxzNY3uTJw/A4IRbRbj7/TeQCHfR+qStLFB0xjdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SOy1MQHTbHuaX/lZO7KRKfVlvRXUnGZL8oH51hdtVUt9gUNCOkomGTCSZ8jDAiLA5MYzrug4H41LML6AeRx7JEWeX9iETuV+tc/cmg/ML9kbMy0PWWBSicKyhwzgEvmgztcstbPXBar1fQCFPTFwf7BVls0LWVF1kMPEwvtM9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLSAH4cI; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f485961555so15554228eec.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778650425; x=1779255225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yD4uczaoBtE4wv2HzhlD+gXzbPGjt6KufsjG+4Ch3Kg=;
        b=PLSAH4cId/WyYB2EgTCeCMUYvzSpeelYCFQGwJIfdYh14uGsAmyIy9opuHMvwtZyWG
         nFwh0qF0SYC07ozqGSRdLSzjVHY7+PEH0RmnAAIh+BkEcJasPa32KcSGq73Ky/fxVNsW
         eQm69rw+ZXISpN6csbp1UeTKwVUvFU0QIUj7VIN1Z0Du0S7bT+5ZSR+IVbYonWXYWWK9
         J1/Y+nkA4jNpt0CjGNett5M3FnKiKxnoTgw99Zog9oHwG0WGg6VlN3oNlhio+jyqRyuW
         20u0ReGFYB4C8uRpwGvs/9049/mlAqJ3mMxfry6Xqc9CUKX3NxExpxiO6MUPOBZvsxxf
         VW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778650425; x=1779255225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yD4uczaoBtE4wv2HzhlD+gXzbPGjt6KufsjG+4Ch3Kg=;
        b=GKJJ7HGUll9JhdH+wiCciLQJzzT0Gec8HAIdjIRr/en4KtWzTXk6bs1zLMcZh+Ze8+
         7VqAg3AtLpFVrYcurjULQoR9fjkHQ85Qng0+lAocuRA23vDpO82dIdYFPAcuA+3ny5ox
         VqvbJNXoDG8PrnXmN4ITTy2NBtAc3+CpE5SFZ7ImcDXq94zYaT9dwgW0CzyEBnWvydiX
         9eWcDXVvJ+IWKXPjt33iII2bjVSD2dthkmH8NFZbTLI9WkyIzE/2yw3RSb4P3/n1d7sW
         z0w7QYeKayfJ/21I757fWMie79u/KWJbpyCiiLXgDHudWwr+sbnxwAih5Xmx4+ZtUuvL
         Pe4g==
X-Gm-Message-State: AOJu0YzkU8u20aVTustDeyjW1X8XngmeH8odDINtbHiTaiY5G6oCpxDg
	zYxe/sTv+79NQSoWz1aD8Qgj/uYLkfCtIGQ58DoPfUPDUpmSkEJXcK8Zi66H1ZFz4U7iS8VyZmE
	TySaIIc3LpYNeC5gqM+dn42GFlBvCRwOc24eE7hbnEOKkYtZAo0zOUJKLFFeltgVSLbnNj1Q66j
	zQWx8EnsZlubM86oixQ3BXD/SJlnbmpn5IAPa1
X-Received: from dycqv12.prod.google.com ([2002:a05:7300:df4c:b0:2f9:af7:503f])
 (user=amitsd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5415:b0:2ed:e17:d50e
 with SMTP id 5a478bee46e88-3011ac4350amr1206554eec.33.1778650424526; Tue, 12
 May 2026 22:33:44 -0700 (PDT)
Date: Wed, 13 May 2026 05:33:36 +0000
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512173940.117428952@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513053336.3789575-1-amitsd@google.com>
Subject: [PATCH 7.0.y] usb: typec: tcpm: reset internal port states on soft
 reset AMS
From: Amit Sunil Dhamne <amitsd@google.com>
To: stable@vger.kernel.org
Cc: Amit Sunil Dhamne <amitsd@google.com>, stable <stable@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E6D4652D946
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246751-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

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
(cherry picked from commit 2909f0d4994fb4306bf116df5ccee797791fce2c)
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8e0e14a2704e..c73e5daafcf1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5534,6 +5534,8 @@ static void run_state_machine(struct tcpm_port *port)
 		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
 		port->partner_source_caps = NULL;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
+		port->vdm_sm_running = false;
+		port->explicit_contract = false;
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
-- 
2.54.0.563.g4f69b47b94-goog


