Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7947BE09F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377357AbjJINmO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377385AbjJINmM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:42:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F9C6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:42:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9736CC433C9;
        Mon,  9 Oct 2023 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858931;
        bh=kfY0oxERcQIbwB4ua+aGvkEU3SAGLtJqCMCmY/NeeEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXOKIX/nCLYRa7v8bEd6xmzuudxYZzn85kXOD5tsPxec9nOfb1VFQMGa8MTxfBOXX
         Nvb3e4OJesi+NYL7v8pVGfVnr3AD1S2lGp/T9XuNkWGXe4/+scgjZneLegcdOOK7Dw
         qmfoOgOyPiTz+X3irTpQZp/WSXK+J+m2oDoUZT5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 5.10 145/226] Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"
Date:   Mon,  9 Oct 2023 15:01:46 +0200
Message-ID: <20231009130130.513511210@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Starke <daniel.starke@siemens.com>

commit 29346e217b8ab8a52889b88f00b268278d6b7668 upstream.

This reverts commit 9b9c8195f3f0d74a826077fc1c01b9ee74907239.

The commit above is reverted as it did not solve the original issue.

gsm_cleanup_mux() tries to free up the virtual ttys by calling
gsm_dlci_release() for each available DLCI. There, dlci_put() is called to
decrease the reference counter for the DLCI via tty_port_put() which
finally calls gsm_dlci_free(). This already clears the pointer which is
being checked in gsm_cleanup_mux() before calling gsm_dlci_release().
Therefore, it is not necessary to clear this pointer in gsm_cleanup_mux()
as done in the reverted commit. The commit introduces a null pointer
dereference:
 <TASK>
 ? __die+0x1f/0x70
 ? page_fault_oops+0x156/0x420
 ? search_exception_tables+0x37/0x50
 ? fixup_exception+0x21/0x310
 ? exc_page_fault+0x69/0x150
 ? asm_exc_page_fault+0x26/0x30
 ? tty_port_put+0x19/0xa0
 gsmtty_cleanup+0x29/0x80 [n_gsm]
 release_one_tty+0x37/0xe0
 process_one_work+0x1e6/0x3e0
 worker_thread+0x4c/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe1/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2f/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

The actual issue is that nothing guards dlci_put() from being called
multiple times while the tty driver was triggered but did not yet finished
calling gsm_dlci_free().

Fixes: 9b9c8195f3f0 ("tty: n_gsm: fix UAF in gsm_cleanup_mux")
Cc: stable <stable@kernel.org>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
Link: https://lore.kernel.org/r/20230914051507.3240-1-daniel.starke@siemens.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_gsm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2179,10 +2179,8 @@ static void gsm_cleanup_mux(struct gsm_m
 
 	/* Free up any link layer users and finally the control channel */
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i]) {
+		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
-			gsm->dlci[i] = NULL;
-		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);


