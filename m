Return-Path: <stable+bounces-25307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B086A418
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 00:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0181B1F2385B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 23:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2F56B68;
	Tue, 27 Feb 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBWiEFmc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BD56472
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078320; cv=none; b=aIBGYbfM/rUPmAo7Z9R5XHvrmpiCLv/0dQ8HRCz2MZoIze10ggSRC+rm13f1WIl3p9aklVXpAo3IymBEkH6/AYX+EyoppYRaWIrFR0n/UKx/POUUOqBVcOSm82AyqfPhLb5GKP4WNpsWAWF5vkLfq/motCwLbUdEPUvsRfJckoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078320; c=relaxed/simple;
	bh=2/lRzbav4ZEIZxCx4lcDj3Wd/X8auYnCnUQfBTX1XUM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NIkZGgMNAjFqcI3fs6jL8Kx2F62QVc/S9rELja7tuhsZFAUKjpF/tG51wT/mG83/7IvUKi///HGkyNh7/yDDq8sjcoMHxe8RHuwW3ZKT2dOeY+fwarmIRsQeHuEfm8zF6JHcILWPTUh3AdJa/TxlM3Uj6/hJdc4Jgi3/6HQ/Kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBWiEFmc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so8131223276.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709078318; x=1709683118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LdW7tPXFcFwIvF+jtRCAIo7Kke3BZ9m44DLtohg7Ec=;
        b=rBWiEFmcZqnDXPkn82+eQ5P9Zb2pGgmxxXOarVQMVv6GFdSfMNb8im2/RqG529TFWp
         sScu0GxpmpcqBUL14wytPzS/yywlC2lk/qlFJTUIcK3xb2YrOSkBV+68Np88wZeenloy
         eQYpIHe9e4Hx1C9dKZS76Yu41AqmTF0XJ9KIkBjFlYxKPQzlM03dRJm38DVo01Nr4lhB
         5z4Us1QwcUkp8fW3nSx6s1d6o7XK3PJKpeo1pbCHWIFXwDYz4w5oOGDSjmakMQu4SQbT
         1UCtCAODID72PnFNI07TY2LGdlJMNR4NVgRFZP9yNxlfDt/V4s7mP9gDpN0I75mKGVTR
         oKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078318; x=1709683118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LdW7tPXFcFwIvF+jtRCAIo7Kke3BZ9m44DLtohg7Ec=;
        b=oN2CHQRVfYlsjJ2N4x9IF5AFcgzvCml9QIJhLwTcP1dwJNO8DAdGrD/lIw5bOZOVvK
         7GVF8Gl3+vzhXwwaWMEUB8x8y804+FOFFuG9Qj6qxNWQpCmSXy0p+wnacdmbkKRs8Q3V
         3I8EXgF2RsTURccY35ItuW/20PJqoz1f0KQrBofYMDScVMQxr4swNOe0hINYlNnq/0Gp
         gMciUuPCpRLkM+HWt5ExhfH75GsIFTWs4NaKU1xo/uLlPRRn5U8bmvugDyMip/w8LP1t
         iRYJNLztpzCJv/DJY1r/FzbNiolWlwbj+s+ZePP0uOiwoeVb8nVpHcbXXXqFyobLkEly
         tkQA==
X-Forwarded-Encrypted: i=1; AJvYcCXitR9MPdMA4Q5FytfNN4viEVu+GT+6ZOthJTnoCGcDy9DcV3PDkIRvy5Q9PrfqcVRNWDl8XQ+uV91i+KCruNHWbSMx0bFm
X-Gm-Message-State: AOJu0YxaTIctbgHelpMQ4vZFkP0pF3fWQH1ILC3NwcF2fbiTXLBUv+je
	fjHnqxW3JGOL7aRBsRdVFjdYk+yRAqNCiYsgi5uw93O0tJ8BMq0CQ4OE1XLQKn/HzbtvxTHPPI3
	8eA==
X-Google-Smtp-Source: AGHT+IG0oglXzdl0/+UCvI8lhfH7WFBVyu8Ryq/6LJlQ/oklxmy8TdLcC0HnTPw/C46EKLLizN5gxuAWvGY=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a25:b341:0:b0:dcb:bc80:8333 with SMTP id
 k1-20020a25b341000000b00dcbbc808333mr294382ybg.13.1709078318262; Tue, 27 Feb
 2024 15:58:38 -0800 (PST)
Date: Tue, 27 Feb 2024 23:58:32 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227235832.744908-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, broonie@kernel.org, 
	Badhri Jagan Sridharan <badhri@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

While commit 69f89168b310 ("usb: typec: tpcm: Fix issues with power being
removed during reset") fixes the boot issues for bus powered devices such
as LibreTech Renegade Elite/Firefly, it trades off the CC pins NOT being
Hi-Zed during errory recovery (i.e PORT_RESET) for devices which are NOT
bus powered(a.k.a self powered). This change Hi-Zs the CC pins only for
self powered devices, thus preventing brown out for bus powered devices

Adhering to spec is gaining more importance due to the Common charger
initiative enforced by the European Union.

Quoting from the spec:
    4.5.2.2.2.1 ErrorRecovery State Requirements
    The port shall not drive VBUS or VCONN, and shall present a
    high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.

Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
CC pins are set to default state after tErrorRecovery in
PORT_RESET_WAIT_OFF.

    4.5.2.2.2.2 Exiting From ErrorRecovery State
    A Sink shall transition to Unattached.SNK after tErrorRecovery.
    A Source shall transition to Unattached.SRC after tErrorRecovery.

Fixes: 69f89168b310 ("usb: typec: tpcm: Fix issues with power being removed during reset")
Cc: stable@kernel.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c9a78f55ca48..bbe1381232eb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5593,8 +5593,11 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
-		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
-			    TYPEC_CC_RD : tcpm_rp_cc(port));
+		if (port->self_powered)
+			tcpm_set_cc(port, TYPEC_CC_OPEN);
+		else
+			tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
+				    TYPEC_CC_RD : tcpm_rp_cc(port));
 		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
 			       PD_T_ERROR_RECOVERY);
 		break;

base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
-- 
2.44.0.rc1.240.g4c46232300-goog


