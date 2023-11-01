Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA97DDA9A
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 02:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbjKAB2w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 21:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjKAB2v (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 21:28:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6943F5
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 18:28:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so6545098276.3
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698802129; x=1699406929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VxjREVhKIwNUHPrTEbniLZS6ji7rcCI9L7LUymPl9mk=;
        b=cBl+Hb5H45g1Zs6aUOl/J0Z6Xf2sgzRwQ/ZCiOqF8NtuAId5Syl15yUc1yhXsZ7v69
         nRS9vVfLU4Ziu/YQaa6koE9UAGFXA7Zw/0jUF/4bHmhADxwYMn7c7iX50FBxVPaA9lEt
         9cTz+o/zgktS99MB2oxMDE3Op6XZENrCYemmJp1wqCjfnuQLS5PovYg4oVCLdDHyl6vE
         Ys8yUu57Bd2X70uwsGw9UHDks/MukaAtcbvhI6glrPExwaSLhhLnSncM0BVz4QDxU1Cs
         1TdqH70uy2YjCzUMr0NOtfJXIMAFwGOX6VmDWNkLQQlzVIj/1wj2c0NPTZNjxvmqT4dC
         7C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802129; x=1699406929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxjREVhKIwNUHPrTEbniLZS6ji7rcCI9L7LUymPl9mk=;
        b=CnpbWRzQ6Q8cxehCJiceRDrWcifax1hQ4Bzy6y5Shq2SOSVtiGr5FyHDQgArwIqJj3
         ph8/P7Vdsb6Imr2QSbF2JesfDVBzOEjdbWUQGaR8RA3rUqr7MIwXiD78xyaDFOy/iL5M
         x0v6kDZweZtv85ElLCRzKv1bAS14iKdr53jT2sEKy7ltibNn0hWpfNyCOor+cfTjpM7Q
         6D6IL2/BWVXBe7GcLbzWghYgWiBETFcGsUbPmuykl/vbCTZsYzqGN6q8Lv8W41FApJ6j
         W7uOosyR0BT7BCe67bm9fMxwsuhnIXViYD6cWhZu5C7M7ubeMMrwm51GaMuIrFwD8AvY
         dT9Q==
X-Gm-Message-State: AOJu0YwE+FetGR7NbCbUlAkUj8/WRVjKPer+eWD0rJvJYT+V/ki8OERI
        mRCwUxM6qYjhTkWscRDi8Jgssjd1BC8=
X-Google-Smtp-Source: AGHT+IH2G54HVEVIYbn3qEM7Uh8KXF5UOjbqJ1LWEr//qTninScBLtbinVdR0me/FhTzFqgkkOQXirVVsvg=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a25:5c2:0:b0:d9a:68de:16a1 with SMTP id
 185-20020a2505c2000000b00d9a68de16a1mr276149ybf.0.1698802128834; Tue, 31 Oct
 2023 18:28:48 -0700 (PDT)
Date:   Wed,  1 Nov 2023 01:28:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101012845.2701348-1-badhri@google.com>
Subject: [PATCH v3] usb: typec: tcpm: Fix sink caps op current check
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

TCPM checks for sink caps operational current even when PD is disabled.
This incorrectly sets tcpm_set_charge() when PD is disabled.
Check for sink caps only when PD is enabled.

[   97.572342] Start toggling
[   97.578949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[   99.571648] CC1: 0 -> 0, CC2: 0 -> 4 [state TOGGLING, polarity 0, connected]
[   99.571658] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[   99.571673] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[   99.741778] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[   99.789283] CC1: 0 -> 0, CC2: 4 -> 5 [state SNK_DEBOUNCED, polarity 0, connected]
[   99.789306] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[   99.903584] VBUS on
[   99.903591] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AMS]
[   99.903600] polarity 1
[   99.910155] enable vbus discharge ret:0
[   99.910160] Requesting mux state 1, usb-role 2, orientation 2
[   99.946791] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
[   99.946798] state change SNK_STARTUP -> SNK_DISCOVERY [rev3 NONE_AMS]
[   99.946800] Setting voltage/current limit 5000 mV 500 mA
[   99.946803] vbus=0 charge:=1
[  100.027139] state change SNK_DISCOVERY -> SNK_READY [rev3 NONE_AMS]
[  100.027145] Setting voltage/current limit 5000 mV 3000 mA
[  100.466830] VBUS on

Cc: stable@vger.kernel.org
Fixes: 803b1c8a0cea ("usb: typec: tcpm: not sink vbus if operational current is 0mA")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v2:
* Fix the "Fixes" tag
* Refactor code based on Guenter Roeck's suggestion.

Changes since v1:
* Fix commit title and description to address comments from Guenter Roeck
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 058d5b853b57..afc791ab6d4f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4273,7 +4273,8 @@ static void run_state_machine(struct tcpm_port *port)
 				current_lim = PD_P_SNK_STDBY_MW / 5;
 			tcpm_set_current_limit(port, current_lim, 5000);
 			/* Not sink vbus if operational current is 0mA */
-			tcpm_set_charge(port, !!pdo_max_current(port->snk_pdo[0]));
+			tcpm_set_charge(port, !port->pd_supported ||
+					pdo_max_current(port->snk_pdo[0]));
 
 			if (!port->pd_supported)
 				tcpm_set_state(port, SNK_READY, 0);

base-commit: c70793fb7632a153862ee9060e6d48131469a29c
-- 
2.42.0.820.g83a721a137-goog

