Return-Path: <stable+bounces-87971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4A89AD9E0
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 04:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6892283733
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 02:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28317147C91;
	Thu, 24 Oct 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+erznpW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855214F9F3
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736559; cv=none; b=ag25rz7DNZicafmkTbSFq9z6/IpnYQ17IfV3jNTwTkHtKMT9z1YAvkMpb5bbnDjILIeiyRtVrezx5aQxvWQHLg/r3kZrC9b8H4Im9ECUo3l63MWfUw/DnCLT/sGN2VWDO5hA8x1sSW87SGkPvRACiDf/8VEeYbYMsmQ/vUijAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736559; c=relaxed/simple;
	bh=hGtFXbU9VAyW/8pRrl9hkSCxmzALYxOVKBLxqL2fk0A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dIxSi5QbuQkJLzk1gaFfO1G59OJJ3PsoLYLdPrvEeo9ntg3jVUeFQG+cyZN11KcLsW5VPsmZa8+nbkpFnjYK6GaHdFnmDjwWzgql8ZIx4QiQ43VaAQEVKIYmy7Lhy2TtO7gs1fYyRUK995+1yNUDwY8mbMRPa1D8QUeI5Lb8vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+erznpW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2bd09d2505so848200276.2
        for <stable@vger.kernel.org>; Wed, 23 Oct 2024 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729736557; x=1730341357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RChQ6ImziR2UxxxuK55p/UZIl7zlomw2h99sUv/4Mus=;
        b=v+erznpWBQDEyOUMlqOzpaGZzerZyNvleKRA7ha7hTclyESeNCsp5NKe4DHk2VRdJ7
         igEJXgyd3s8GV3V530EhFsjZpQwwmhebCvIrLQkK0lgzf3L7ipCjzuwTElE/W/dm5r/d
         Wurh9ztigHb3davaIYXamgeBSM8KuPOMsP7DNk1ggihaUPE8DyE3xcmslSIAJRUmCpC7
         xfAH5z7aUbt432yCtupI7BHU+FvF3ug861L4IlFNurAOTbEGb4yZpJdJeiIc5FaAdTlr
         rgOLu4J0GRWtTIKerGY4ZjHwuGn6ra+4KE4UB1XhB56NDeRRtxO17MKYbQQP8hz8Ov+w
         GzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729736557; x=1730341357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RChQ6ImziR2UxxxuK55p/UZIl7zlomw2h99sUv/4Mus=;
        b=WHkqliKv5BHLLy0FLc8TnMTAYmisPHdtb1j9FWNmUPb0FmnvpTTiIXhB6izNzWsavY
         mia5dRFWWOfq/rcafnoPZqu0pDpdZd/3NqZ9AWUg2dA3/s0H9OXbzGqEfdyp9MBwHNJM
         ixhz0TREyNwNa8REVHeszspoIfSzShSNt/bFtfQhmcWZ/Z2GLkh79ekUCZ//3Bgdhiy4
         70Jp0mKx4IGWTqavo0oL/Fct+GoxUGqQ5R2kp0oEHX3rn/PGeJTUNowXEegczuDleFCP
         5KMpo/cf8z2GtwPnj98tJofLNa0rt8EL0yrjAqkkWi5I/YHDWsaC4ntgblR5JVPI1/qH
         Oe8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/+RR/mBVCJKHsjEBLPL6E3pSJwhPGT183Z/GQ80vxU9L/7++tGQ37XUMOD6/bXZdfffrk3jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZ72opthoQI85WT5MKbHXCIQ9NBAkwwfftINdNhrPp82UiHh9
	qn0hraC7qNeI2vzvBrV/VbAckEfPrycAHxXhqmtUM/RBIDPqExJqYZR4jaSQf7+EswYgjUVuKrS
	a1Q==
X-Google-Smtp-Source: AGHT+IHvpgV2IEy6a8M5p6FINEmbO9iwt7048YunZFeK8TEB+fKeKeGsJJogBorbRaYHFXdxrIma//8yhks=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:74c9:0:b0:e2e:2c11:bbf8 with SMTP id
 3f1490d57ef6-e2f2fbbb888mr230276.9.1729736556338; Wed, 23 Oct 2024 19:22:36
 -0700 (PDT)
Date: Wed, 23 Oct 2024 19:22:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024022233.3276995-1-amitsd@google.com>
Subject: [PATCH v1] usb: typec: tcpm: restrict SNK_WAIT_CAPABILITIES_TIMEOUT
 transitions to non self-powered devices
From: Amit Sunil Dhamne <amitsd@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: rdbabiera@google.com, badhri@google.com, xu.yang_2@nxp.com, 
	sebastian.reichel@collabora.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PD3.1 spec ("8.3.3.3.3 PE_SNK_Wait_for_Capabilities State") mandates
that the policy engine perform a hard reset when SinkWaitCapTimer
expires. Instead the code explicitly does a GET_SOURCE_CAP when the
timer expires as part of SNK_WAIT_CAPABILITIES_TIMEOUT. Due to this the
following compliance test failures are reported by the compliance tester
(added excerpts from the PD Test Spec):

* COMMON.PROC.PD.2#1:
  The Tester receives a Get_Source_Cap Message from the UUT. This
  message is valid except the following conditions: [COMMON.PROC.PD.2#1]
    a. The check fails if the UUT sends this message before the Tester
       has established an Explicit Contract
    ...

* TEST.PD.PROT.SNK.4:
  ...
  4. The check fails if the UUT does not send a Hard Reset between
    tTypeCSinkWaitCap min and max. [TEST.PD.PROT.SNK.4#1] The delay is
    between the VBUS present vSafe5V min and the time of the first bit
    of Preamble of the Hard Reset sent by the UUT.

For the purpose of interoperability, restrict the quirk introduced in
https://lore.kernel.org/all/20240523171806.223727-1-sebastian.reichel@collabora.com/
to only non self-powered devices as battery powered devices will not
have the issue mentioned in that commit.

Cc: stable@vger.kernel.org
Fixes: 122968f8dda8 ("usb: typec: tcpm: avoid resets for missing source capability messages")
Reported-by: Badhri Jagan Sridharan <badhri@google.com>
Closes: https://lore.kernel.org/all/CAPTae5LAwsVugb0dxuKLHFqncjeZeJ785nkY4Jfd+M-tCjHSnQ@mail.gmail.com/
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d6f2412381cf..c8f467d24fbb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4515,7 +4515,8 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
 		return ERROR_RECOVERY;
 	if (port->pwr_role == TYPEC_SOURCE)
 		return SRC_UNATTACHED;
-	if (port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
+	if (port->state == SNK_WAIT_CAPABILITIES ||
+	    port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
 		return SNK_READY;
 	return SNK_UNATTACHED;
 }
@@ -5043,8 +5044,11 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_SOFT_RESET,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
-			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
-				       PD_T_SINK_WAIT_CAP);
+			if (!port->self_powered)
+				upcoming_state = SNK_WAIT_CAPABILITIES_TIMEOUT;
+			else
+				upcoming_state = hard_reset_state(port);
+			tcpm_set_state(port, upcoming_state, PD_T_SINK_WAIT_CAP);
 		}
 		break;
 	case SNK_WAIT_CAPABILITIES_TIMEOUT:

base-commit: c6d9e43954bfa7415a1e9efdb2806ec1d8a8afc8
-- 
2.47.0.105.g07ac214952-goog


