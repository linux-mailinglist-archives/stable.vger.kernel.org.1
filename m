Return-Path: <stable+bounces-11838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6588304BC
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E63F1C2426E
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 11:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009891DFD1;
	Wed, 17 Jan 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwsqLbLw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD61DFC9
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492067; cv=none; b=M7VVGlT3n8JlXLicc2YdHNec0LTrhTabimHFDzij5s7THKYlSPm8yEV4XMF1d9H8W5HnvSmuhDZ5O8VJaLk+kOfUijf3899Nd6HH3jfo0BhXQUVPbAEo8NHytCLwwO8eIBKbY1UGK6OZtrjttwdxi2OeQU1nSJaYAJkT65vh0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492067; c=relaxed/simple;
	bh=Nui8zu8V3ndYddOaheaEne/imbsV07hHxFFahrvH2Sg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=KUFgX/3Bz6fHmEuLaay3zXv3AT2iGSD2krejgAvbmvynf9CpjqhCNomRoyVb0YNy5qdzgVZ5RzU9FS3wH78a58BbKHdOKunCVIoSmWZ6h83bZtrNAsSgCZKxbn2BL8bt0ie/AM7/id5H04zUa2ON/1xklcXAhc0qFcPB6HRZZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwsqLbLw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28dbd89e5cdso7229927a91.1
        for <stable@vger.kernel.org>; Wed, 17 Jan 2024 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705492065; x=1706096865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W4MUqY7qziRkIoVCBAjHtlR0P63yXdlU8r3ZOJ0yHa4=;
        b=EwsqLbLwrHC+6uec1zex3MPtORgYgWFtDZ6TP9jbVleJwmOBNJmyr49VRSFO3xKtje
         tGYknPHymYsxUZuWNYD7QahGByjQ8hFrsaaTDJa3YLPSshOgLuHfvBgWdqMHRse4FPVW
         mtm6xhudADl1OiO6tb1Xi1PSTh9mBlTQgWcxMHrCcERYI5QzBfS8G5YRc1yJcWAqP50Q
         J4iVDzbXCiI73XO8EP4KFFC8WZ/hYrG8uaViZVgTSYV9hvt3Yb/YvoBvNqtvS42MYLQp
         p0IOJ/qZpVVGdY4m8NoXLdWY5fm8P8R6ySNszP/bxDBtnjsjaOhM61w89c+A9ymhyN6a
         LrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705492065; x=1706096865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4MUqY7qziRkIoVCBAjHtlR0P63yXdlU8r3ZOJ0yHa4=;
        b=o1koTEuUz33I1SDDIp+IDktDl6qxEJG60brXaD4pCnDLZ7i8QEdkbyH1C3pArRm0+n
         W/nIBayE5kZPZ74A95vTNFBa4QUFpkZ4+S0l+MmMQqxO7xwUxZaGVK4eNQVnaRCiQVOm
         QaQSiLe9NbMZdEcxyJH9soHzb71tDs0ZHYnEaJKg2tcKBRnDYBHIK1t5aegHlLAuZM6q
         4ESKfBhYYjBxJJjFXEgDnZ9fT5o1q9snXtKqCWMc6stlhZCsHRAf98UzH9ga/qB6ujaN
         eyoHkTW4xzID5m2xAeHC4GVpqE2gcGVx7l17CYMFX09bYV1nY2V107QAOzKZCfGWvPjp
         fz+Q==
X-Gm-Message-State: AOJu0YwpfxIATVDgBYfEvUeqLhQEGWUwFnCA1pu5uTJcU9LANlT+LjTE
	kI3klqIUQTXExuC53jD8oYCNH3bTUroHZl2yKg==
X-Google-Smtp-Source: AGHT+IGbV5MXvSWEBDVzyqZxJqAc/AaSt2OI+WAdKyDsredw51/qTJldbeyuukgdzoqCm1Fy3ggzJuQQK8c=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a17:90b:5292:b0:28b:d1dc:8836 with SMTP id
 si18-20020a17090b529200b0028bd1dc8836mr381586pjb.5.1705492065692; Wed, 17 Jan
 2024 03:47:45 -0800 (PST)
Date: Wed, 17 Jan 2024 11:47:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240117114742.2587779-1-badhri@google.com>
Subject: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, 
	Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.

Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
the CC pins, setting CC pins to default state during PORT_RESET
breaks error recovery.

4.5.2.2.2.1 ErrorRecovery State Requirements
The port shall not drive VBUS or VCONN, and shall present a
high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.

Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
CC pins are set to default state after tErrorRecovery in
PORT_RESET_WAIT_OFF.

4.5.2.2.2.2 Exiting From ErrorRecovery State
A Sink shall transition to Unattached.SNK after tErrorRecovery.
A Source shall transition to Unattached.SRC after tErrorRecovery.

Cc: stable@vger.kernel.org
Cc: Frank Wang <frank.wang@rock-chips.com>
Fixes: 1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5945e3a2b0f7..9d410718eaf4 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4876,8 +4876,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
-		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
-			    TYPEC_CC_RD : tcpm_rp_cc(port));
+		tcpm_set_cc(port, TYPEC_CC_OPEN);
 		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
 			       PD_T_ERROR_RECOVERY);
 		break;

base-commit: 933bb7b878ddd0f8c094db45551a7daddf806e00
-- 
2.43.0.429.g432eaa2c6b-goog


