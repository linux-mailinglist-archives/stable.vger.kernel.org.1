Return-Path: <stable+bounces-246749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHAfA90JBGqKCgIAu9opvQ
	(envelope-from <stable+bounces-246749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:19:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9652D7EC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B0533013D76
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B639D3EC;
	Wed, 13 May 2026 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZWKHGap"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7812D1F1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649561; cv=none; b=LpqfUinwBdc7aNb7HSKwZBI/3Q2wN5Ej35jvt6ddU0vnlhAr/XfhKGydvuxYhmmnT0nfRn+EwdMOD/LMhAN5LgbWVvnZSBeLDrRqy83nNOwrSoMLs+eEqJo65jfigIpyfByl4SVMADcmiTD7+9juHY67tpxgTjIjzXzA6aEOCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649561; c=relaxed/simple;
	bh=u31jdN6IZpgSv9jmcz4d46ukNTa9hKflIXu1n5notlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2rUhzcfDVNoQAoGHkYNBCddg/0Hrlm2HWyJceRa3DqqH+KmVolRVF/Goa2jSxNc0J31GRRSniXV5ApRAXmu3TEy1yQLDCRJgmXaFEDOssn9HGLZwCCI/a8O31fShZ7kvNUxYHiakN1WAUktn91SY2s0+/3ZSlV07J1HXF9y+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZWKHGap; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312cff948so7410595c88.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 22:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778649559; x=1779254359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie9r1YumDjdnquGBX6UZZfBVm1c1SwEVVu4dR4Eicqs=;
        b=JZWKHGapY8rsHACsUI8L2e28nOwzEkIc5OACIEgi7sWdJzEzjeo5SfZHRBJWnUl5UK
         C/IIg2VKcnGh2RuHd+taHaM2ZPyKi54n3/I6xcFxKciEsvq+SIuvVHUtVv+XKqoo0Sn1
         UmFcSMrRFvdURq6ZnOuD9A7PNJf3VD+531AUV2dEB/h/8rRc0M7w0I4ZLyLfnvBQe/KZ
         k0yO+v/uC3UeQ/6NdBlq2Ryb0oaJNtSAHcJGJzGlQNqgtrs2o+6t7lv7TMWFOriyGf9h
         v0RZ5YaxWnXMMsR5P5lokANWPeclSRjGMVq+m5MKj5LV9gn+9jM6EmpEF2kGxljc4dv9
         0mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778649559; x=1779254359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie9r1YumDjdnquGBX6UZZfBVm1c1SwEVVu4dR4Eicqs=;
        b=IV0YdBaFAuZr5qO4u1+9GOKBwonsoamh2lPh16QBPJ4p+plZ99jdsJZfBKjyCC0wAT
         q2V/gXgxzDq4QEc8GtxKoPF6dtLbCBjHF3ZvmyBHj00TDOUj8/HrM/UgfOoYbOkg+B3b
         1X9QiEt2G9KAf7a8XbXWHZSyePwUePzEINvdcuvO34bRpIrgDQQ/mbSaYwwVXswkJp1H
         2DwKTek7xYG0HyGUnPVNxOYCWzVCftpX0IJlWBwG0sJHOYyarPtPpASYoLu6pzRq7dM3
         l07nm68H1k/LfiXyBb7PV77BxKcVvq2YDr9z3ebsjmvb4A77lTT0OQYTsgzMQ8qHEWrG
         ZiDw==
X-Gm-Message-State: AOJu0YwtLD/2KquoBKpHpVj7oaWDwTKHXAIbyHN7kmPFqkPw+KEOHQXJ
	8vtsbA1+92SQ0mRGUSJxIRiG2OLTZQ59gp8HVUKDHMdqLYQo7ez9bczYHru4j780tsbQx310ACj
	rI9ph6az3eV53q2FoEBlXSTAWnDUwI5V/Mqcz0sPCA5ErUBUDgUMoVwz1A+sBSW+PMwnuUCzG9r
	8YWD/ZbjmwipulPc0FkAmUtlgDUyjc45l/T5vL
X-Received: from dlea18-n2.prod.google.com ([2002:a05:701b:4212:20b0:12c:211d:3e86])
 (user=amitsd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec9:b0:132:1de0:12b0
 with SMTP id a92af1059eb24-1343699b1f1mr1216900c88.21.1778649558342; Tue, 12
 May 2026 22:19:18 -0700 (PDT)
Date: Wed, 13 May 2026 05:17:45 +0000
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512173938.452574370@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513051745.3740542-1-amitsd@google.com>
Subject: [PATCH 6.18.y] usb: typec: tcpm: reset internal port states on soft
 reset AMS
From: Amit Sunil Dhamne <amitsd@google.com>
To: stable@vger.kernel.org
Cc: Amit Sunil Dhamne <amitsd@google.com>, stable <stable@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 60B9652D7EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246749-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email]
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
index cc78770509db..584618fe5fe5 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5521,6 +5521,8 @@ static void run_state_machine(struct tcpm_port *port)
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


