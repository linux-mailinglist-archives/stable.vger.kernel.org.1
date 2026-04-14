Return-Path: <stable+bounces-237691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL33DqKR3WkLfwkAu9opvQ
	(envelope-from <stable+bounces-237691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:00:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427FB3F4B32
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3FE9300F796
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E124E4C3;
	Tue, 14 Apr 2026 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJepyMiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A423A9BD;
	Tue, 14 Apr 2026 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128318; cv=none; b=KBKm9qoFrmdD4f381SzI1ZtNQbXXCGKuQuTg3MVZwjPTWnCLVePTjPCcdys9yp02TTZx+HHVGoOJPBca9V1ilCI5BScA90urY0wSSVNYMKjiExz5OCsuy+6us8o/Aa5Y6iNmVxDcmKVggDGy4k3PqtZyYuTERm/3ut8EPNpzHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128318; c=relaxed/simple;
	bh=EhlDXWWFWBQauZ8tAGQwPzKqjMsudNfavuhsO/FbfYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OfBjV1AWjHo1YP++DHmNtWsi3mN7GISRWQWkJJAQHSz6QC1j1YbDsdcqjtfCj/CDriXafNeGCOUM+kK3Z+FTdFkdsdrje4pNOCX4iDOYKfS/QxC1zw9ZdG4npp1UrefN6Uv95fDSjVofC/6TXI63EL7YTs1lkro9ueeyvXCCSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJepyMiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D59DC2BCB5;
	Tue, 14 Apr 2026 00:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776128317;
	bh=EhlDXWWFWBQauZ8tAGQwPzKqjMsudNfavuhsO/FbfYk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZJepyMiE6yyEVV/naeEWlF9+63AdNCuR9pYNLXNuG9YNCYrhIXXY7NNgoIX9dx9LI
	 hY6iOuPVdxBQZrfhDnKThEw81EfYNmtdeDjdC/RpXbVK0k5mj1W2V5iLCNNbbxvRci
	 qXWYf3l40EhVdKXYh+H4XqmTWonIJo8tk3pFlH3lls5H0WoL+nzpj4ZTlDmydWM8uJ
	 PFNVHssM40txcyNZK1Zkop/wH5WHVRhbGwr+trXUsEQ1DehkguDnDvZq53DDqgFA6s
	 YcuEg09IIP9S68ARbjG8Jtj6NuyErt/wLTIwAb1JVTFtGTjKcYZkgUVwJxB9wpwts/
	 HMmKLG2ypZy+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB4F531C6;
	Tue, 14 Apr 2026 00:58:37 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 14 Apr 2026 00:58:32 +0000
Subject: [PATCH] usb: typec: tcpm: reset internal port states on soft reset
 AMS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-soft-reset-v1-1-01d7cb9764e2@google.com>
X-B4-Tracking: v=1; b=H4sIADeR3WkC/x2MSwqAMBDFriKzdqD+WvUq4kL0VWej0hERine3u
 AwkiaQIAqU+ixRwi8qxJyjyjOZt2lewLImpNKU1tXHs5WE9/MUBiovRNs77Bt1SWUrRGZCMfzi
 M7/sB9IS4XWAAAAA=
X-Change-ID: 20260407-fix-soft-reset-e857ff5e9d36
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kyle Tso <kyletso@google.com>, Guenter Roeck <groeck@chromium.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Amit Sunil Dhamne <amitsd@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776128317; l=3756;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=NwZV1h3KslKY2J3kpCMvfsd4RiG9+nem3pcyoUztlBQ=;
 b=L+zGllswkMyHtEnmJRQti/NK1h3u/2HnMp/iO2cCjE6AKAR/VOsOinXE0DbEqjv2eAOmXPU3D
 HijQCI6ofuaCnb2vcFX4QQ1G3hCauX6vX5JfKrIStEYr/36GsyaQhcl
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237691-lists,stable=lfdr.de,amitsd.google.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 427FB3F4B32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Sunil Dhamne <amitsd@google.com>

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
Cc: stable@vger.kernel.org
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
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

---
base-commit: 81dc1e4d32b064ac47abc60b0acbf49b66a34d52
change-id: 20260407-fix-soft-reset-e857ff5e9d36

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



