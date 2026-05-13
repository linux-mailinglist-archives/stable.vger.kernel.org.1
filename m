Return-Path: <stable+bounces-246737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHFaJPf+A2qiBwIAu9opvQ
	(envelope-from <stable+bounces-246737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:32:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3692752D2BF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9049D304ABF4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 04:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90596306766;
	Wed, 13 May 2026 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fx+hQVw1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA7C42A9D
	for <stable@vger.kernel.org>; Wed, 13 May 2026 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646771; cv=none; b=dcJPy2MQnABdA5NyJojQgtF2W8h87bQ2zSqAOJ82E8eU1d1vmlOwgKSwOim/9yrAdOs1c1ebaaBprMTvGRuLCnki79G7wiJoKGw+7qnoerJBEhVIHle+A13xd7LX/LJD3j5/cg3xHr5/wgPmyWwsAf0RQlD+QG7gP0PQcCgZ5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646771; c=relaxed/simple;
	bh=P/jxpq9oXNdBdY/Mrla4j6zezRD1GM7njMmiea00mp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bTgpCGXfFGNgh3eiW1s3i1DZQXCgqlFaTGjZoA7TTVPspaetplztqAHktQf25BpYGtCNCZ0cwCBZ2o5pamcdSdPYDRec1Gg0c5/s/Mey7UQO/+H9Re8+zZIqegZaCo6pGGf5HyzW3MuBndDRJSkV6MGM/RfKxGeQnSO6z2Tzvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fx+hQVw1; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so10163545eec.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 21:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778646769; x=1779251569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksy4BaX5jygaCyJXcc2XPioj+Sba6iUsmM/w0BjP6B8=;
        b=fx+hQVw1mA+wQyJCPuLwhJ4URQUFGtCsL6sc7UEQPcF1x6p5u64JkiOMxyWZRFFkV6
         v8ZbPz3/1Eacum+nVxxL8thgDjMrui8AwHzZ8Trxzzw1FPikbYGjfvtD4UeH4Ue3Xtwk
         SaJJKhXkzOY3RHBNDREjof7ghG3L0XH9ThSSET8kvsksOSy9yZEyublr469g/Gx06EzE
         JUGmJu1mQMybClnPVU2O2UbyF226R1gSxWwnrV3Hr9rfxWxQPqn/jeOxCx1fVKDhUSMt
         gI53c13tUoSsSQUy3OdCyhFWY75UtRCvuLx+HXOnBNymFwwjY/w0HGPFk+HhcwfVlmw4
         hqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778646769; x=1779251569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksy4BaX5jygaCyJXcc2XPioj+Sba6iUsmM/w0BjP6B8=;
        b=QXuJnRQOgRbVV50acLGPqcPA90bhGL08lR3/wkFcNlLulkqGFfFforMp9F8z3vLehh
         Xs3H7VzBVHfdUggqqoYfu+P9akZI0QGHydQgqDHHS3/OTAh4Rz4OKZvKl2vnM3P22Ahi
         cbsujweg8qCtUMHA4yb1K7v+PdsMgO/TPSZ7p6MSrB+NlZqupPCTq159y4qLrFfespOw
         jmr+LWiSQgy97smLKrhbm4diXZJqURZ2WY++CgqnGrbcXeBrcIzF6tjcau12OlpjP5Ii
         xSKdfqLRGQ82Jx2amS1gaFfkhsievVAWEp91TMO1cJxjEjKX5khA0fCBTJv86JEQwQbF
         H4zw==
X-Gm-Message-State: AOJu0YyGZnxhsTcuPTUko6ny43w1vTsCZ8os8S9GZ5tRacaBAdqWw+zN
	tg3r4ESrIUH4sesWUqmY3Y9SFJzm63DPqGQaGWJBYpZi3M3JOu09ryOg27tYm0+Mkb/uFDnePwe
	xVhJVq83BMI4STw1NULOjG0jVs6hyV4zHH5+KhxMJOJv07B3fxJ6hSBNlpM8k2ytIEm3TMCJ1ru
	3NyZtBT45Pcc7+22jDSdoLPJzrubTRynfRQugO
X-Received: from dygg14.prod.google.com ([2002:a05:693c:80ce:b0:2ee:3abb:9c9])
 (user=amitsd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2a30:b0:2d9:db50:c6d6
 with SMTP id 5a478bee46e88-30155653381mr715894eec.21.1778646768668; Tue, 12
 May 2026 21:32:48 -0700 (PDT)
Date: Wed, 13 May 2026 04:32:25 +0000
In-Reply-To: <2026051211-oil-gauze-6124@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026051211-oil-gauze-6124@gregkh>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513043226.3639455-1-amitsd@google.com>
Subject: [PATCH 6.6.y] usb: typec: tcpm: reset internal port states on soft
 reset AMS
From: Amit Sunil Dhamne <amitsd@google.com>
To: stable@vger.kernel.org
Cc: Amit Sunil Dhamne <amitsd@google.com>, stable <stable@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3692752D2BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246737-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,msgid.link:url,intel.com:email]
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
index 2e39686e01c9..c6330084d4f6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4610,6 +4610,8 @@ static void run_state_machine(struct tcpm_port *port)
 		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
 		port->partner_source_caps = NULL;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		port->vdm_sm_running = false;
+		port->explicit_contract = false;
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
-- 
2.54.0.563.g4f69b47b94-goog


