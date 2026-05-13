Return-Path: <stable+bounces-246734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMTzOtP8A2okBwIAu9opvQ
	(envelope-from <stable+bounces-246734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:23:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78052D242
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC0DA3046053
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 04:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175236655F;
	Wed, 13 May 2026 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0Q1PFpJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05471991D4
	for <stable@vger.kernel.org>; Wed, 13 May 2026 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646225; cv=none; b=haGi1M4yhtGFYDq8LtlOSOyP02fUZnacNj1BbIwaa0EMhdz3xe/Mi95L6D5y60PnBtcwHrYoyFuNbcWCoyzoCaRDVLVtDHucKloLeXon4Zs2xoLS75kv8R8n42+MovTW8+2NMTUB3KvJH0AUNKBnQfEt60OscaDAHoAm2JOvGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646225; c=relaxed/simple;
	bh=0LVYAhKZtbQyVO8Jb3cbU1izRVzlkPXfPeYO9+vkri0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UkChRM9MghXoB8txxqY1on4tZlZMK3XeNqaYa0YMKvLCYAvrcmCcgZEWzXe95VyW6xRnMw7QmYJyFIcKX0/XGLD/LGfjBKNYcoIjv4eZYWejApC2IOSd4UcmhTw/72eSgZdzrXD01whWAT1Mh1bWMuOKcGgHfaOnZlfihKhmbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0Q1PFpJ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso8038147eec.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 21:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778646223; x=1779251023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOK/mqADpcyGou7nnRQWYOfvCUulOduyAJ2YyhMYiWU=;
        b=k0Q1PFpJTNyIz3fLgNEwYUyzVzxhtJybicD2rAACCg0iUBdI6/3KvISgN/5L93otJf
         Ww1XuY4bd2I4ucQjrJoXv4OFr9IM7HjzVoqh/QteGMEFClTVG1uwBEfoSmttMGqhGezo
         n1puxJ4bvWmujpy0O2t3Wx1YfvEdmUg2KUydcbu6ON2v8lCkE9hzgiHPRGUeSWiqlidb
         Pc3cLvmwBSaHsBvq2GVm2LwbMMyhVeGxQxQsmwnbQhbKJv7uuIo4RpumwrdBvBOYvAgr
         0A882J3l3iJ5LQHdR1Kp1GfOaCqnBuVXLk3Hp1yh5mEE2oPMYPp1yS6sVnLceyi3jmKL
         vzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778646223; x=1779251023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOK/mqADpcyGou7nnRQWYOfvCUulOduyAJ2YyhMYiWU=;
        b=V8zYTExP+Y5BzzhD+JCKM2TGUmSMtDs13dCHqXGPziXcG/RG7kU0hCYY7evkTI01FO
         now+5rnWmuX4hR9CFI5P3o0H4R0h9EAt0ehdbeJyWBiw7M6gcVM246OUNkVwwnuz2N74
         Nua/5/SI4ASTYqDRwHN3SZR5pVmzIbNrOd/sMvkz8H9r86d9ytOFkTo3eQvuk1ScB2tP
         94GC9frfq+0aNiz/SLVrtbYgbzlsAb7NiF2z2Fuqycdkked1JxXzdVfC1IsM9HY/WK+2
         YZPN4JKG0WFe4JS1u4Be5rPmY5v5H3aOZ6WHMxP1MU/jt1rIDX1r6hxC3tw+zaMqBP37
         zg/w==
X-Gm-Message-State: AOJu0YwyTGocb9XUnBWWmyEo3To7o6x4cRI+wK+ZE41wyJcHFnXBVsW4
	O+vZBtb4VNCikmIjeaGK8WMQs/qnhB0fSzhAEYN+6GAB0vWe9i/AvQc5DFo9H6R/I0IuR23iABD
	N8gLTD5POX85Cn15ASX12AisWJvRCn9n/x3EpqzFyK4tBhDTkNMkmpddGenr2MZlihFnLqzoe4I
	pEJC/qzlo7w6xwzJBKk72EZCxec67m3tkq1Dag
X-Received: from dycnn10.prod.google.com ([2002:a05:7301:140a:b0:2de:ed01:5510])
 (user=amitsd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc92:b0:2da:1874:f3bd
 with SMTP id 5a478bee46e88-30155f3027emr575700eec.16.1778646222520; Tue, 12
 May 2026 21:23:42 -0700 (PDT)
Date: Wed, 13 May 2026 04:23:07 +0000
In-Reply-To: <2026051212-unbounded-attic-50ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026051212-unbounded-attic-50ea@gregkh>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513042307.3593957-1-amitsd@google.com>
Subject: [PATCH 6.1.y] usb: typec: tcpm: reset internal port states on soft
 reset AMS
From: Amit Sunil Dhamne <amitsd@google.com>
To: stable@vger.kernel.org
Cc: Amit Sunil Dhamne <amitsd@google.com>, stable <stable@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4D78052D242
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246734-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
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
index 9d8fcfac5761..60bba8501532 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4651,6 +4651,8 @@ static void run_state_machine(struct tcpm_port *port)
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


