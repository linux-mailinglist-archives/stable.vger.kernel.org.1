Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E07695CF
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGaMOj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjGaMOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018010EB
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62EA16106E
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D404C433CB;
        Mon, 31 Jul 2023 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690805660;
        bh=Q16/b78aCRRK6M1VKYUwVhk/BzRSVrmFWKXGuaPwTBo=;
        h=Subject:To:Cc:From:Date:From;
        b=TM9AfNNziCEwYqfXySK+7mPRXuXFU40T8RU0arz9nDSDWD+iNwPJXeBYo0iNIdeqC
         XCb2m5lRmMEwv9Tg296KiNwVE6/o0SxPKkYaqUyY6Zu7fYuKqjK2wn18OG9QudxJur
         n56igi8aKCOJApSQGQ5wR3UhfAJ1UtYBSrv4T/Mk=
Subject: FAILED: patch "[PATCH] staging: r8712: Fix memory leak in _r8712_init_xmit_priv()" failed to apply to 5.4-stable tree
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        namcaov@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 31 Jul 2023 14:14:14 +0200
Message-ID: <2023073114-salute-rust-a0f4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ac83631230f77dda94154ed0ebfd368fc81c70a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023073114-salute-rust-a0f4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

ac83631230f7 ("staging: r8712: Fix memory leak in _r8712_init_xmit_priv()")
f179515da978 ("staging: rtl8712: Use constants from <linux/ieee80211.h>")
0e934ce2904e ("staging: rtl8712: clean up comparsions to NULL")
bd7a168a024d ("staging: rtl8712: use common ieee80211 constants")
3ee97e220648 ("staging: rtl8712: switch to common ieee80211 headers")
15ea976a1f12 ("staging: rtl8712: Fix IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK")
2aaeaaff1ae2 ("staging: rtl8712: code improvements to make_wlanhdr")
45afa5637b85 ("staging: rtl8712: fix long-line checkpatch warning")
5979afa2c4d1 ("staging: Replace zero-length array with flexible-array member")
96b06c0a16f7 ("Revert "staging: octeon-usb: delete the octeon usb host controller driver"")
4fb8b5aa2a11 ("staging: wilc1000: refactor p2p action frames handling API's")
a474df5c1484 ("staging: wilc1000: remove use of vendor specific IE for p2p handling")
034280e33ea0 ("staging: wilc1000: refactor SPI read/write commands handling API's")
7a80aa23d0f0 ("staging: wilc1000: return zero on success and non-zero on function failure")
01fbbd42d1f4 ("staging: wilc1000: remove redundant assignment to variable result")
95ace52e4036 ("staging: octeon-usb: delete the octeon usb host controller driver")
710d7fbe21ee ("staging: octeon: delete driver")
075a1e87d1e2 ("staging/octeon: Mark Ethernet driver as BROKEN")
282eaa624f06 ("staging: octeon: indent with tabs instead of spaces")
6cfed5984804 ("staging: rtl*: Remove tasklet callback casts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac83631230f77dda94154ed0ebfd368fc81c70a3 Mon Sep 17 00:00:00 2001
From: Larry Finger <Larry.Finger@lwfinger.net>
Date: Fri, 14 Jul 2023 12:54:17 -0500
Subject: [PATCH] staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

In the above mentioned routine, memory is allocated in several places.
If the first succeeds and a later one fails, the routine will leak memory.
This patch fixes commit 2865d42c78a9 ("staging: r8712u: Add the new driver
to the mainline kernel"). A potential memory leak in
r8712_xmit_resource_alloc() is also addressed.

Fixes: 2865d42c78a9 ("staging: r8712u: Add the new driver to the mainline kernel")
Reported-by: syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/x/log.txt?x=11ac3fa0a80000
Cc: stable@vger.kernel.org
Cc: Nam Cao <namcaov@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Reviewed-by: Nam Cao <namcaov@gmail.com>
Link: https://lore.kernel.org/r/20230714175417.18578-1-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345bad223..6353dbe554d3 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -21,6 +21,7 @@
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
+#include <linux/usb.h>
 #include <linux/ieee80211.h>
 
 static const u8 P802_1H_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0xf8};
@@ -55,6 +56,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	sint i;
 	struct xmit_buf *pxmitbuf;
 	struct xmit_frame *pxframe;
+	int j;
 
 	memset((unsigned char *)pxmitpriv, 0, sizeof(struct xmit_priv));
 	spin_lock_init(&pxmitpriv->lock);
@@ -117,11 +119,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 	pxmitpriv->pallocated_xmitbuf =
 		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		kfree(pxmitpriv->pallocated_frame_buf);
-		pxmitpriv->pallocated_frame_buf = NULL;
-		return -ENOMEM;
-	}
+	if (!pxmitpriv->pallocated_xmitbuf)
+		goto clean_up_frame_buf;
 	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -129,13 +128,17 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		INIT_LIST_HEAD(&pxmitbuf->list);
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
-		if (!pxmitbuf->pallocated_buf)
-			return -ENOMEM;
+		if (!pxmitbuf->pallocated_buf) {
+			j = 0;
+			goto clean_up_alloc_buf;
+		}
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
 				 ((addr_t) (pxmitbuf->pallocated_buf) &
 				 (XMITBUF_ALIGN_SZ - 1));
-		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
-			return -ENOMEM;
+		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
+			j = 1;
+			goto clean_up_alloc_buf;
+		}
 		list_add_tail(&pxmitbuf->list,
 				 &(pxmitpriv->free_xmitbuf_queue.queue));
 		pxmitbuf++;
@@ -146,6 +149,28 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
 	return 0;
+
+clean_up_alloc_buf:
+	if (j) {
+		/* failure happened in r8712_xmit_resource_alloc()
+		 * delete extra pxmitbuf->pallocated_buf
+		 */
+		kfree(pxmitbuf->pallocated_buf);
+	}
+	for (j = 0; j < i; j++) {
+		int k;
+
+		pxmitbuf--;			/* reset pointer */
+		kfree(pxmitbuf->pallocated_buf);
+		for (k = 0; k < 8; k++)		/* delete xmit urb's */
+			usb_free_urb(pxmitbuf->pxmit_urb[k]);
+	}
+	kfree(pxmitpriv->pallocated_xmitbuf);
+	pxmitpriv->pallocated_xmitbuf = NULL;
+clean_up_frame_buf:
+	kfree(pxmitpriv->pallocated_frame_buf);
+	pxmitpriv->pallocated_frame_buf = NULL;
+	return -ENOMEM;
 }
 
 void _free_xmit_priv(struct xmit_priv *pxmitpriv)
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 132afbf49dde..ceb6b590b310 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -112,6 +112,12 @@ int r8712_xmit_resource_alloc(struct _adapter *padapter,
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
+			int k;
+
+			for (k = i - 1; k >= 0; k--) {
+				/* handle allocation errors part way through loop */
+				usb_free_urb(pxmitbuf->pxmit_urb[k]);
+			}
 			netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] == NULL\n");
 			return -ENOMEM;
 		}

