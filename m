Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8A77A19D
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjHLSEQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLSEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F933CC
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C966D61D4B
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B0C433C7;
        Sat, 12 Aug 2023 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691863458;
        bh=0xYbTVB/myLF6pKFN8ogNfumndk7i4Po2xqUPuAw0jk=;
        h=Subject:To:Cc:From:Date:From;
        b=i6Yj7Z2r4/D6caVPbMO4wekJ5872omBEQHKhkJEvPgpZvLXIyvW2WtmnQIAvv2Szj
         BK5nXOIuHocVgCNiykDZZiq0FeogBCn1u9eUB4YWUFdoeLBJpY12VdV7QWoz4MfxA9
         79BSC9cn3NtByGhve32eCzE6xy+4oAwKnXE8P0Co=
Subject: FAILED: patch "[PATCH] net: tls: avoid discarding data on record close" failed to apply to 5.4-stable tree
To:     kuba@kernel.org, davem@davemloft.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:04:12 +0200
Message-ID: <2023081212-shivering-tactful-b5cb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 6b47808f223c70ff564f9b363446d2a5fa1e05b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081212-shivering-tactful-b5cb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

6b47808f223c ("net: tls: avoid discarding data on record close")
7adc91e0c939 ("net/tls: Multi-threaded calls to TX tls_dev_del")
113671b255ee ("net/tls: Perform immediate device ctx cleanup when possible")
f08d8c1bb97c ("net/tls: Fix race in TLS device down flow")
3d8c51b25a23 ("net/tls: Check for errors in tls_device_init")
f3911f73f51d ("tls: fix replacing proto_ops")
6942a284fb3e ("net/tls: make inline helpers protocol-aware")
0403a2b53c29 ("net/tls: use semicolons rather than commas to separate statements")
d5bee7374b68 ("net/tls: Annotate access to sk_prot with READ_ONCE/WRITE_ONCE")
5bb4c45d466c ("net/tls: Read sk_prot once when building tls proto ops")
a9f852e92e40 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b47808f223c70ff564f9b363446d2a5fa1e05b2 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 4 Aug 2023 15:59:51 -0700
Subject: [PATCH] net: tls: avoid discarding data on record close

TLS records end with a 16B tag. For TLS device offload we only
need to make space for this tag in the stream, the device will
generate and replace it with the actual calculated tag.

Long time ago the code would just re-reference the head frag
which mostly worked but was suboptimal because it prevented TCP
from combining the record into a single skb frag. I'm not sure
if it was correct as the first frag may be shorter than the tag.

The commit under fixes tried to replace that with using the page
frag and if the allocation failed rolling back the data, if record
was long enough. It achieves better fragment coalescing but is
also buggy.

We don't roll back the iterator, so unless we're at the end of
send we'll skip the data we designated as tag and start the
next record as if the rollback never happened.
There's also the possibility that the record was constructed
with MSG_MORE and the data came from a different syscall and
we already told the user space that we "got it".

Allocate a single dummy page and use it as fallback.

Found by code inspection, and proven by forcing allocation
failures.

Fixes: e7b159a48ba6 ("net/tls: remove the record tail optimization")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 2021fe557e50..529101eb20bd 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -52,6 +52,8 @@ static LIST_HEAD(tls_device_list);
 static LIST_HEAD(tls_device_down_list);
 static DEFINE_SPINLOCK(tls_device_lock);
 
+static struct page *dummy_page;
+
 static void tls_device_free_ctx(struct tls_context *ctx)
 {
 	if (ctx->tx_conf == TLS_HW) {
@@ -312,36 +314,33 @@ static int tls_push_record(struct sock *sk,
 	return tls_push_sg(sk, ctx, offload_ctx->sg_tx_data, 0, flags);
 }
 
-static int tls_device_record_close(struct sock *sk,
-				   struct tls_context *ctx,
-				   struct tls_record_info *record,
-				   struct page_frag *pfrag,
-				   unsigned char record_type)
+static void tls_device_record_close(struct sock *sk,
+				    struct tls_context *ctx,
+				    struct tls_record_info *record,
+				    struct page_frag *pfrag,
+				    unsigned char record_type)
 {
 	struct tls_prot_info *prot = &ctx->prot_info;
-	int ret;
+	struct page_frag dummy_tag_frag;
 
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
 	 * use socket memory to improve coalescing (re-using a single buffer
 	 * increases frag count)
-	 * if we can't allocate memory now, steal some back from data
+	 * if we can't allocate memory now use the dummy page
 	 */
-	if (likely(skb_page_frag_refill(prot->tag_size, pfrag,
-					sk->sk_allocation))) {
-		ret = 0;
-		tls_append_frag(record, pfrag, prot->tag_size);
-	} else {
-		ret = prot->tag_size;
-		if (record->len <= prot->overhead_size)
-			return -ENOMEM;
+	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
+	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
+		dummy_tag_frag.page = dummy_page;
+		dummy_tag_frag.offset = 0;
+		pfrag = &dummy_tag_frag;
 	}
+	tls_append_frag(record, pfrag, prot->tag_size);
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
 			 record->len - prot->overhead_size,
 			 record_type);
-	return ret;
 }
 
 static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
@@ -541,18 +540,8 @@ static int tls_push_data(struct sock *sk,
 
 		if (done || record->len >= max_open_record_len ||
 		    (record->num_frags >= MAX_SKB_FRAGS - 1)) {
-			rc = tls_device_record_close(sk, tls_ctx, record,
-						     pfrag, record_type);
-			if (rc) {
-				if (rc > 0) {
-					size += rc;
-				} else {
-					size = orig_size;
-					destroy_record(record);
-					ctx->open_record = NULL;
-					break;
-				}
-			}
+			tls_device_record_close(sk, tls_ctx, record,
+						pfrag, record_type);
 
 			rc = tls_push_record(sk,
 					     tls_ctx,
@@ -1450,14 +1439,26 @@ int __init tls_device_init(void)
 {
 	int err;
 
-	destruct_wq = alloc_workqueue("ktls_device_destruct", 0, 0);
-	if (!destruct_wq)
+	dummy_page = alloc_page(GFP_KERNEL);
+	if (!dummy_page)
 		return -ENOMEM;
 
+	destruct_wq = alloc_workqueue("ktls_device_destruct", 0, 0);
+	if (!destruct_wq) {
+		err = -ENOMEM;
+		goto err_free_dummy;
+	}
+
 	err = register_netdevice_notifier(&tls_dev_notifier);
 	if (err)
-		destroy_workqueue(destruct_wq);
+		goto err_destroy_wq;
 
+	return 0;
+
+err_destroy_wq:
+	destroy_workqueue(destruct_wq);
+err_free_dummy:
+	put_page(dummy_page);
 	return err;
 }
 
@@ -1466,4 +1467,5 @@ void __exit tls_device_cleanup(void)
 	unregister_netdevice_notifier(&tls_dev_notifier);
 	destroy_workqueue(destruct_wq);
 	clean_acked_data_flush();
+	put_page(dummy_page);
 }

