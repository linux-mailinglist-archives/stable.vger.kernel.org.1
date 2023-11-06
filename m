Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774E97E23C4
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjKFNOW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKFNOV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:14:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0494
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:14:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEFAC433C8;
        Mon,  6 Nov 2023 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276458;
        bh=LgvoSewN0xOw9bKzhZtdzFomeWGOBHpSQ8x216m0PG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/D2F69tb4nEcFoAQh0WzSJGLhP6BElRex3dPk6/5203jOKocaN3OuuZlMQ14rjZZ
         4WbB2b4E4HQU/R9EiI64TJZrD462JUIw5fio2CEhb4y51IuTTIcaA0EgwiFvea68RW
         AV09fir/enVtIHQn5CAchN3fM/JzWRm7zqgQivII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 6.1 50/62] tty: n_gsm: fix race condition in status line change on dead connections
Date:   Mon,  6 Nov 2023 14:03:56 +0100
Message-ID: <20231106130303.568518652@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Starke <daniel.starke@siemens.com>

commit 3a75b205de43365f80a33b98ec9289785da56243 upstream.

gsm_cleanup_mux() cleans up the gsm by closing all DLCIs, stopping all
timers, removing the virtual tty devices and clearing the data queues.
This procedure, however, may cause subsequent changes of the virtual modem
status lines of a DLCI. More data is being added the outgoing data queue
and the deleted kick timer is restarted to handle this. At this point many
resources have already been removed by the cleanup procedure. Thus, a
kernel panic occurs.

Fix this by proving in gsm_modem_update() that the cleanup procedure has
not been started and the mux is still alive.

Note that writing to a virtual tty is already protected by checks against
the DLCI specific connection state.

Fixes: c568f7086c6e ("tty: n_gsm: fix missing timer to handle stalled links")
Cc: stable <stable@kernel.org>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
Link: https://lore.kernel.org/r/20231026055844.3127-1-daniel.starke@siemens.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_gsm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3404,6 +3404,8 @@ static int gsm_modem_upd_via_msc(struct
 
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
+	if (dlci->gsm->dead)
+		return -EL2HLT;
 	if (dlci->adaption == 2) {
 		/* Send convergence layer type 2 empty data frame. */
 		gsm_modem_upd_via_data(dlci, brk);


