Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084477DDAE5
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjKACTR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 22:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjKACTQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 22:19:16 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096DED
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 19:19:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b87150242cso4723028a12.0
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 19:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698805154; x=1699409954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YxMLCnvrWc25EU4H4xs2rJSBgkcEn2A7t+6WriOcpdA=;
        b=QiAXIgx8BWbe7hw4awJHYl6/U2/l+ROHgBNVlkSD30Gb99uEQ2bdhkO7MLWQEXNa00
         BJfdVKe0AtA7YwbxV0K2HbYcpv78wL3V/VcJ4je2dLWmactBdkwYkQBQLqtn6Lz7em9s
         b1PH7UJ45SUSJ6Ye0qIVs7RMy3XFVrH+s7Kt7WTcQr6+ZL/W6ClFkvDc3CeEh7l6TkY3
         L2uOQBbvqt/Hkm8QEtKc/uhoSpZK1L9EmezEJEU9Nb5PLJzURJ4v9nt2492zptkbYdwI
         YNnplLVJQLIl5ifpfIqdEk5h4B88y4E9jyhfsPl8XJtcVKlb43lPaAbH+GNsuHou+dG7
         THtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698805154; x=1699409954;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxMLCnvrWc25EU4H4xs2rJSBgkcEn2A7t+6WriOcpdA=;
        b=leVOQAbDbbWbgpRO9TdU+GPN+PnP6bwUfBfuc61XZo9zBK7E8QrGJExypW/ceD620m
         ZG091iOEePe7RmSX0tLCf/Dsq2gPkwlgjZ9oYnkPmv8QURqz27CV48PHLyIThRh/Knxj
         2ZwiIGb+4lm6XwCvOBHR+RowEfkER60s9szl3beNVIT9BiN5BPkrPIss94AdhpnfkJRK
         b7qDZ7Ke030vTGAJ6mhzlgprWya5ARLWS4wzP3eRuU0wzsmebgM2UXTvFdIsg6w4m+ye
         fiGuUR8P69VasvsEIU/0ouz/LOP0kQccN5GAzWqoMYRoVH9h5MZMmnWKABr10BuKIHZK
         aTPQ==
X-Gm-Message-State: AOJu0Yw/REOkq9+7jDp72A6L1disu1zpuwIaTbBpvy3f5B2BQQ+8bo+s
        nasibhXMhb3h5xXi05Cc3Ym6NLGHBVM=
X-Google-Smtp-Source: AGHT+IG12wBNMJ1P0/BdAkR/0ARm+Dw/pyRIRjaikGvugugX+UjkePUEUplt1JoJ//05fozTbly+stJq0Ow=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a63:344b:0:b0:5a9:fb7b:7f1d with SMTP id
 b72-20020a63344b000000b005a9fb7b7f1dmr255710pga.0.1698805153730; Tue, 31 Oct
 2023 19:19:13 -0700 (PDT)
Date:   Wed,  1 Nov 2023 02:19:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101021909.2962679-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Skip hard reset when in error recovery
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        amitsd@google.com, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hard reset queued prior to error recovery (or) received during
error recovery will make TCPM to prematurely exit error recovery
sequence. Ignore hard resets received during error recovery (or)
port reset sequence.

```
[46505.459688] state change SNK_READY -> ERROR_RECOVERY [rev3 NONE_AMS]
[46505.459706] state change ERROR_RECOVERY -> PORT_RESET [rev3 NONE_AMS]
[46505.460433] disable vbus discharge ret:0
[46505.461226] Setting usb_comm capable false
[46505.467244] Setting voltage/current limit 0 mV 0 mA
[46505.467262] polarity 0
[46505.470695] Requesting mux state 0, usb-role 0, orientation 0
[46505.475621] cc:=0
[46505.476012] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
[46505.476020] Received hard reset
[46505.476024] state change PORT_RESET -> HARD_RESET_START [rev3 HARD_RESET]
```

Cc: stable@vger.kernel.org
Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 058d5b853b57..b386102f7a3a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5391,6 +5391,15 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 	if (port->bist_request == BDO_MODE_TESTDATA && port->tcpc->set_bist_data)
 		port->tcpc->set_bist_data(port->tcpc, false);
 
+	switch (port->state) {
+	case ERROR_RECOVERY:
+	case PORT_RESET:
+	case PORT_RESET_WAIT_OFF:
+		return;
+	default:
+		break;
+	}
+
 	if (port->ams != NONE_AMS)
 		port->ams = NONE_AMS;
 	if (port->hard_reset_count < PD_N_HARD_RESET_COUNT)

base-commit: c70793fb7632a153862ee9060e6d48131469a29c
-- 
2.42.0.820.g83a721a137-goog

