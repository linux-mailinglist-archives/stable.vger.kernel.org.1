Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8645175CA69
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGUOoT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGUOoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B4930D2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B4C61CC6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69C6C433C7;
        Fri, 21 Jul 2023 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950655;
        bh=lXPyKd4Kjj6hgSjZFMR9iJsWgzyJ5iuZPdq8sp6H8Ak=;
        h=Subject:To:Cc:From:Date:From;
        b=kASAC+RO//VwIs5byZPo2oLK8eG6Alcmt+CoiwOChrYL4oOOkPJnw43kheu3Fyx10
         2kHX7TIpAgxGFyv2J2lN50Sm62Z+9L8+qZI3CbwFApcqK/1dKxGiZupYe5P+IhB25z
         cH45wKciEaKi+4nnkAksRpsA97TMGRRlXs2tB2bo=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Correct the index of array" failed to apply to 4.19-stable tree
To:     bhazarika@marvell.com, himanshu.madhani@oracle.com,
        martin.petersen@oracle.com, njavali@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:44:12 +0200
Message-ID: <2023072112-plywood-delusion-dd8d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b1b9d3825df4c757d653d0b1df66f084835db9c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072112-plywood-delusion-dd8d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

b1b9d3825df4 ("scsi: qla2xxx: Correct the index of array")
27258a577144 ("scsi: qla2xxx: Add a shadow variable to hold disc_state history of fcport")
58e39a2ce4be ("scsi: qla2xxx: Change discovery state before PLOGI")
983f127603fa ("scsi: qla2xxx: Retry PLOGI on FC-NVMe PRLI failure")
c76ae845ea83 ("scsi: qla2xxx: Add error handling for PLOGI ELS passthrough")
84ed362ac40c ("scsi: qla2xxx: Dual FCP-NVMe target port support")
f3f1938bb673 ("scsi: qla2xxx: Fix N2N link up fail")
7f2a398d59d6 ("scsi: qla2xxx: Fix N2N link reset")
ce0ba496dccf ("scsi: qla2xxx: Fix stuck login session")
897def200421 ("scsi: qla2xxx: Inline the qla2x00_fcport_event_handler() function")
0184793df2e8 ("scsi: qla2xxx: Use tabs instead of spaces for indentation")
a630bdc54f6d ("scsi: qla2xxx: Move qla2x00_set_fcport_state() from a .h into a .c file")
bd432bb53cff ("scsi: qla2xxx: Leave a blank line after declarations")
2703eaaf4eae ("scsi: qla2xxx: Use tabs to indent code")
a6a6d0589ac4 ("scsi: scsi_transport_fc: nvme: display FC-NVMe port roles")
f8f97b0c5b7f ("scsi: qla2xxx: Cleanups for NVRAM/Flash read/write path")
ecc89f25e225 ("scsi: qla2xxx: Add Device ID for ISP28XX")
24ef8f7eb5d0 ("scsi: qla2xxx: Fix routine qla27xx_dump_{mpi|ram}()")
df617ffbbc5e ("scsi: qla2xxx: Add fw_attr and port_no SysFS node")
64f61d994483 ("scsi: qla2xxx: Add new FW dump template entry types")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1b9d3825df4c757d653d0b1df66f084835db9c3 Mon Sep 17 00:00:00 2001
From: Bikash Hazarika <bhazarika@marvell.com>
Date: Wed, 7 Jun 2023 17:08:42 +0530
Subject: [PATCH] scsi: qla2xxx: Correct the index of array

Klocwork reported array 'port_dstate_str' of size 10 may use index value(s)
10..15.

Add a fix to correct the index of array.

Cc: stable@vger.kernel.org
Signed-off-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-8-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index cce6e425c121..946a39504a35 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -109,11 +109,13 @@ qla2x00_set_fcport_disc_state(fc_port_t *fcport, int state)
 {
 	int old_val;
 	uint8_t shiftbits, mask;
+	uint8_t port_dstate_str_sz;
 
 	/* This will have to change when the max no. of states > 16 */
 	shiftbits = 4;
 	mask = (1 << shiftbits) - 1;
 
+	port_dstate_str_sz = sizeof(port_dstate_str) / sizeof(char *);
 	fcport->disc_state = state;
 	while (1) {
 		old_val = atomic_read(&fcport->shadow_disc_state);
@@ -121,7 +123,8 @@ qla2x00_set_fcport_disc_state(fc_port_t *fcport, int state)
 		    old_val, (old_val << shiftbits) | state)) {
 			ql_dbg(ql_dbg_disc, fcport->vha, 0x2134,
 			    "FCPort %8phC disc_state transition: %s to %s - portid=%06x.\n",
-			    fcport->port_name, port_dstate_str[old_val & mask],
+			    fcport->port_name, (old_val & mask) < port_dstate_str_sz ?
+				    port_dstate_str[old_val & mask] : "Unknown",
 			    port_dstate_str[state], fcport->d_id.b24);
 			return;
 		}

