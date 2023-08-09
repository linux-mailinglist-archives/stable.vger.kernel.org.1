Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211A775C77
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjHIL1p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjHIL1h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD9268B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E63632B0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01564C433C9;
        Wed,  9 Aug 2023 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580452;
        bh=DDL0sNACxlWLCo5OoHmg+z4rP9wJsJDnj8w0Be9tRVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrADcpfq0A03PBX3D5USyvZOU5P5yuhnWEfplBrH6ZrQd7z3MTI9idJNUfUTi/MPX
         E6qIjJtUzaReApz/4YBcUwAaGKxMj+pDM7BFWJJ2k60CzzU6PgZbWTecaQygmB+iW6
         jUYbIk34pZkxVgFKUimEIqOYtHrMAGwi94vtQw+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Pavlu <petr.pavlu@suse.com>,
        Joey Lee <jlee@suse.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 030/154] keys: Fix linking a duplicate key to a keyrings assoc_array
Date:   Wed,  9 Aug 2023 12:41:01 +0200
Message-ID: <20230809103637.989020222@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Petr Pavlu <petr.pavlu@suse.com>

[ Upstream commit d55901522f96082a43b9842d34867363c0cdbac5 ]

When making a DNS query inside the kernel using dns_query(), the request
code can in rare cases end up creating a duplicate index key in the
assoc_array of the destination keyring. It is eventually found by
a BUG_ON() check in the assoc_array implementation and results in
a crash.

Example report:
[2158499.700025] kernel BUG at ../lib/assoc_array.c:652!
[2158499.700039] invalid opcode: 0000 [#1] SMP PTI
[2158499.700065] CPU: 3 PID: 31985 Comm: kworker/3:1 Kdump: loaded Not tainted 5.3.18-150300.59.90-default #1 SLE15-SP3
[2158499.700096] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[2158499.700351] Workqueue: cifsiod cifs_resolve_server [cifs]
[2158499.700380] RIP: 0010:assoc_array_insert+0x85f/0xa40
[2158499.700401] Code: ff 74 2b 48 8b 3b 49 8b 45 18 4c 89 e6 48 83 e7 fe e8 95 ec 74 00 3b 45 88 7d db 85 c0 79 d4 0f 0b 0f 0b 0f 0b e8 41 f2 be ff <0f> 0b 0f 0b 81 7d 88 ff ff ff 7f 4c 89 eb 4c 8b ad 58 ff ff ff 0f
[2158499.700448] RSP: 0018:ffffc0bd6187faf0 EFLAGS: 00010282
[2158499.700470] RAX: ffff9f1ea7da2fe8 RBX: ffff9f1ea7da2fc1 RCX: 0000000000000005
[2158499.700492] RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000000
[2158499.700515] RBP: ffffc0bd6187fbb0 R08: ffff9f185faf1100 R09: 0000000000000000
[2158499.700538] R10: ffff9f1ea7da2cc0 R11: 000000005ed8cec8 R12: ffffc0bd6187fc28
[2158499.700561] R13: ffff9f15feb8d000 R14: ffff9f1ea7da2fc0 R15: ffff9f168dc0d740
[2158499.700585] FS:  0000000000000000(0000) GS:ffff9f185fac0000(0000) knlGS:0000000000000000
[2158499.700610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2158499.700630] CR2: 00007fdd94fca238 CR3: 0000000809d8c006 CR4: 00000000003706e0
[2158499.700702] Call Trace:
[2158499.700741]  ? key_alloc+0x447/0x4b0
[2158499.700768]  ? __key_link_begin+0x43/0xa0
[2158499.700790]  __key_link_begin+0x43/0xa0
[2158499.700814]  request_key_and_link+0x2c7/0x730
[2158499.700847]  ? dns_resolver_read+0x20/0x20 [dns_resolver]
[2158499.700873]  ? key_default_cmp+0x20/0x20
[2158499.700898]  request_key_tag+0x43/0xa0
[2158499.700926]  dns_query+0x114/0x2ca [dns_resolver]
[2158499.701127]  dns_resolve_server_name_to_ip+0x194/0x310 [cifs]
[2158499.701164]  ? scnprintf+0x49/0x90
[2158499.701190]  ? __switch_to_asm+0x40/0x70
[2158499.701211]  ? __switch_to_asm+0x34/0x70
[2158499.701405]  reconn_set_ipaddr_from_hostname+0x81/0x2a0 [cifs]
[2158499.701603]  cifs_resolve_server+0x4b/0xd0 [cifs]
[2158499.701632]  process_one_work+0x1f8/0x3e0
[2158499.701658]  worker_thread+0x2d/0x3f0
[2158499.701682]  ? process_one_work+0x3e0/0x3e0
[2158499.701703]  kthread+0x10d/0x130
[2158499.701723]  ? kthread_park+0xb0/0xb0
[2158499.701746]  ret_from_fork+0x1f/0x40

The situation occurs as follows:
* Some kernel facility invokes dns_query() to resolve a hostname, for
  example, "abcdef". The function registers its global DNS resolver
  cache as current->cred.thread_keyring and passes the query to
  request_key_net() -> request_key_tag() -> request_key_and_link().
* Function request_key_and_link() creates a keyring_search_context
  object. Its match_data.cmp method gets set via a call to
  type->match_preparse() (resolves to dns_resolver_match_preparse()) to
  dns_resolver_cmp().
* Function request_key_and_link() continues and invokes
  search_process_keyrings_rcu() which returns that a given key was not
  found. The control is then passed to request_key_and_link() ->
  construct_alloc_key().
* Concurrently to that, a second task similarly makes a DNS query for
  "abcdef." and its result gets inserted into the DNS resolver cache.
* Back on the first task, function construct_alloc_key() first runs
  __key_link_begin() to determine an assoc_array_edit operation to
  insert a new key. Index keys in the array are compared exactly as-is,
  using keyring_compare_object(). The operation finds that "abcdef" is
  not yet present in the destination keyring.
* Function construct_alloc_key() continues and checks if a given key is
  already present on some keyring by again calling
  search_process_keyrings_rcu(). This search is done using
  dns_resolver_cmp() and "abcdef" gets matched with now present key
  "abcdef.".
* The found key is linked on the destination keyring by calling
  __key_link() and using the previously calculated assoc_array_edit
  operation. This inserts the "abcdef." key in the array but creates
  a duplicity because the same index key is already present.

Fix the problem by postponing __key_link_begin() in
construct_alloc_key() until an actual key which should be linked into
the destination keyring is determined.

[jarkko@kernel.org: added a fixes tag and cc to stable]
Cc: stable@vger.kernel.org # v5.3+
Fixes: df593ee23e05 ("keys: Hoist locking out of __key_link_begin()")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Joey Lee <jlee@suse.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/request_key.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 17c9c0cfb6f59..964e2456f34da 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -401,17 +401,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
 
 	if (dest_keyring) {
-		ret = __key_link_lock(dest_keyring, &ctx->index_key);
+		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
-		ret = __key_link_begin(dest_keyring, &ctx->index_key, &edit);
-		if (ret < 0)
-			goto link_prealloc_failed;
 	}
 
-	/* attach the key to the destination keyring under lock, but we do need
+	/*
+	 * Attach the key to the destination keyring under lock, but we do need
 	 * to do another check just in case someone beat us to it whilst we
-	 * waited for locks */
+	 * waited for locks.
+	 *
+	 * The caller might specify a comparison function which looks for keys
+	 * that do not exactly match but are still equivalent from the caller's
+	 * perspective. The __key_link_begin() operation must be done only after
+	 * an actual key is determined.
+	 */
 	mutex_lock(&key_construction_mutex);
 
 	rcu_read_lock();
@@ -420,12 +424,16 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (!IS_ERR(key_ref))
 		goto key_already_present;
 
-	if (dest_keyring)
+	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed;
 		__key_link(key, &edit);
+	}
 
 	mutex_unlock(&key_construction_mutex);
 	if (dest_keyring)
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
 	kleave(" = 0 [%d]", key_serial(key));
@@ -438,10 +446,13 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	mutex_unlock(&key_construction_mutex);
 	key = key_ref_to_ptr(key_ref);
 	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed_unlocked;
 		ret = __key_link_check_live_key(dest_keyring, key);
 		if (ret == 0)
 			__key_link(key, &edit);
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto link_check_failed;
 	}
@@ -456,8 +467,10 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	kleave(" = %d [linkcheck]", ret);
 	return ret;
 
-link_prealloc_failed:
-	__key_link_end(dest_keyring, &ctx->index_key, edit);
+link_alloc_failed:
+	mutex_unlock(&key_construction_mutex);
+link_alloc_failed_unlocked:
+	__key_link_end(dest_keyring, &key->index_key, edit);
 link_lock_failed:
 	mutex_unlock(&user->cons_lock);
 	key_put(key);
-- 
2.39.2



