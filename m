Return-Path: <stable+bounces-246841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKYcOUt3BGqpKAIAu9opvQ
	(envelope-from <stable+bounces-246841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:06:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0153394C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D26CF3108242
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B03D423A7C;
	Wed, 13 May 2026 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URwHVnaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5E423A66
	for <stable@vger.kernel.org>; Wed, 13 May 2026 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676509; cv=none; b=PDKyUGkZ5hzsFRDwMUrCQ7Mi6uvo8Q57diDK1a+vJrHK6xH41qtFdcJ4bbeUkaXpXvEjx6hJqAekXQgFHPk0+P8ewDf0y7A9ZVkt3WQDT5Ch6g8ibww2rUuiGaAEs51qA3AEgJBVLuwiva604tp2P+CJwJO3Ggs2EktRiSa6FVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676509; c=relaxed/simple;
	bh=X5gUelo3bCkwRhBEPpTyD+19NDKnVPBSLxNEGqVhhVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4zWUrZyNtU6nL8II0znw47TJnWB1eOGoaQXgurK2Rg8U1lzSmF4k5XB3Kc2lviBB+tCLQaSwy1Vjfrn5fIiIsfXRAk0l5Zyz1qhFbDMhjjx2LXbzMt0gyLuUBOYcOVHRgMFoiqC11yveiFPqCm45YkZOebR3nhcNswl+tGSQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URwHVnaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D70C2BCB7;
	Wed, 13 May 2026 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778676508;
	bh=X5gUelo3bCkwRhBEPpTyD+19NDKnVPBSLxNEGqVhhVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URwHVnaqMJnP4vtL55654MuVW7P4LBdb9iq7mCAD+k9NmGYq6wFVHghfb2Q+DxgK5
	 x0NsGYrj+xPnpnYgeiHdSSqlyxkCtwB9JnTcHwfdXGBVhwD9d3wQAQVDptNS29Nm2f
	 ctMCuIPBqnw5LQWxrwUDlH2TDi7vPbym66La8Eg7hMOXf6mOerNSrFfBZvbq5Ny0qH
	 /jEEDLlhg6qi8aU4qXJUgiXcY37niGeUObc/khffbGt7sKVYHBLI4fuX0HkZ9xYo/Y
	 tysR2+nzwI52wXElEZZTJWDCKNnMb8+fwf1m4Ha3dBvJc3iYiYwsSqWkQKbNIQi58m
	 /d4G7GwGyjOlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amit Sunil Dhamne <amitsd@google.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: tcpm: reset internal port states on soft reset AMS
Date: Wed, 13 May 2026 08:48:25 -0400
Message-ID: <20260513124826.3711905-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051213-dad-armed-619f@gregkh>
References: <2026051213-dad-armed-619f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62F0153394C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246841-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Action: no action

From: Amit Sunil Dhamne <amitsd@google.com>

[ Upstream commit 2909f0d4994fb4306bf116df5ccee797791fce2c ]

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
[ kept `tcpm_pd_send_control(port, PD_CTRL_ACCEPT)` call unchanged ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d70813c89fff9..f8ef556a795d6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4576,6 +4576,8 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		port->vdm_sm_running = false;
+		port->explicit_contract = false;
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
-- 
2.53.0


