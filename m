Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC677E2306
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjKFNIC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjKFNIA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:08:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B920D4C
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:07:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA954C433BB;
        Mon,  6 Nov 2023 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276075;
        bh=322LPzALC+xry8M7gytLV4RGLKpDANTYWPEDgeuQCkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6vRpykfKqAaYDNk09rziccy9zVxTA9/roQ23t1UaVvnvnQiIH2QYatt3/MxUjk9A
         OIfbDeU3u/r3HOMmLaz8R+6FKLwk2RRg5GyHHcGHiKmiluo13ve9oRTqQKEOsBtJC0
         kPLxtZAO9l6b5Ul6AL4/kvvMgqFcf90tVrMlM/Kk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.6 12/30] usb: typec: tcpm: Add additional checks for contaminant
Date:   Mon,  6 Nov 2023 14:03:30 +0100
Message-ID: <20231106130258.374805912@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Badhri Jagan Sridharan <badhri@google.com>

commit 1a4a2df07c1f087704c24282cebe882268e38146 upstream.

When transitioning from SNK_DEBOUNCED to unattached, its worthwhile to
check for contaminant to mitigate wakeups.

```
[81334.219571] Start toggling
[81334.228220] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[81334.305147] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[81334.305162] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[81334.305187] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[81334.475515] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[81334.486480] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0, disconnected]
[81334.486495] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[81334.486515] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 ms [rev3 NONE_AMS]
[81334.506621] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 ms]
[81334.506640] Start toggling
[81334.516972] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[81334.592759] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[81334.592773] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[81334.592792] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[81334.762940] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[81334.773557] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0, disconnected]
[81334.773570] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[81334.773588] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 ms [rev3 NONE_AMS]
[81334.793672] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 ms]
[81334.793681] Start toggling
[81334.801840] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[81334.878655] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[81334.878672] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[81334.878696] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[81335.048968] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[81335.060684] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0, disconnected]
[81335.060754] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[81335.060775] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 ms [rev3 NONE_AMS]
[81335.080884] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 ms]
[81335.080900] Start toggling
```

Cc: stable@vger.kernel.org
Fixes: 599f008c257d ("usb: typec: tcpm: Add callbacks to mitigate wakeups due to contaminant")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20231015053108.2349570-1-badhri@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3903,6 +3903,8 @@ static void run_state_machine(struct tcp
 		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
 						port->state == SRC_UNATTACHED) ||
 					       (port->enter_state == SNK_ATTACH_WAIT &&
+						port->state == SNK_UNATTACHED) ||
+					       (port->enter_state == SNK_DEBOUNCED &&
 						port->state == SNK_UNATTACHED));
 
 	port->enter_state = port->state;


