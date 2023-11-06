Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2434B7E230A
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjKFNIL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjKFNIK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:08:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A0FBF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:08:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B56EC433C8;
        Mon,  6 Nov 2023 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276086;
        bh=CEAJR28lGuJn4Ms7WsTN29GW2G5m+kdlO7JDR0G10zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGdWDsADLuaUZqmqXKlWLfGQUE+ybj61EWvhLflJ6sNcKJ4X+3FEI07E4JRATzvWP
         xAzEVHS7hs8OOM9YX0pyqJ3phpFLs/FwcPvcfpNACJ876LG8k3x0etnEN9aM+aNy6t
         hvOM9pc5DV/eOx96xTuOFppTaDOp09h4iNOnpMfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 6.6 16/30] tty: n_gsm: fix race condition in status line change on dead connections
Date:   Mon,  6 Nov 2023 14:03:34 +0100
Message-ID: <20231106130258.514617627@linuxfoundation.org>
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
@@ -4108,6 +4108,8 @@ static int gsm_modem_upd_via_msc(struct
 
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
+	if (dlci->gsm->dead)
+		return -EL2HLT;
 	if (dlci->adaption == 2) {
 		/* Send convergence layer type 2 empty data frame. */
 		gsm_modem_upd_via_data(dlci, brk);


