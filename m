Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACC576127D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjGYLDL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjGYLC6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20673AAB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C554C61697
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D907BC433C7;
        Tue, 25 Jul 2023 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282815;
        bh=tZtf5cAeJABiPCxbmtjTcmBvyY3x5u3787ZlPqudGJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejWMaIiYl8iq9L+w+j3PL12HU+iZJ55TkKaEHbYjuQiksQyF+eUc46syYt7FyPnT+
         rNRUnl4aAtuM4p3X0Kfy2OvMyjzcgXCj6i9HhElY1nxgPCDL5o/GwifUxVeu/MTFna
         bXcTDlBZC71QQly9s96oJsxAo9KK/FuxHLt93Kys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 009/183] btrfs: fix warning when putting transaction with qgroups enabled after abort
Date:   Tue, 25 Jul 2023 12:43:57 +0200
Message-ID: <20230725104508.160200253@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit aa84ce8a78a1a5c10cdf9c7a5fb0c999fbc2c8d6 upstream.

If we have a transaction abort with qgroups enabled we get a warning
triggered when doing the final put on the transaction, like this:

  [552.6789] ------------[ cut here ]------------
  [552.6815] WARNING: CPU: 4 PID: 81745 at fs/btrfs/transaction.c:144 btrfs_put_transaction+0x123/0x130 [btrfs]
  [552.6817] Modules linked in: btrfs blake2b_generic xor (...)
  [552.6819] CPU: 4 PID: 81745 Comm: btrfs-transacti Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
  [552.6819] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
  [552.6819] RIP: 0010:btrfs_put_transaction+0x123/0x130 [btrfs]
  [552.6821] Code: bd a0 01 00 (...)
  [552.6821] RSP: 0018:ffffa168c0527e28 EFLAGS: 00010286
  [552.6821] RAX: ffff936042caed00 RBX: ffff93604a3eb448 RCX: 0000000000000000
  [552.6821] RDX: ffff93606421b028 RSI: ffffffff92ff0878 RDI: ffff93606421b010
  [552.6821] RBP: ffff93606421b000 R08: 0000000000000000 R09: ffffa168c0d07c20
  [552.6821] R10: 0000000000000000 R11: ffff93608dc52950 R12: ffffa168c0527e70
  [552.6821] R13: ffff93606421b000 R14: ffff93604a3eb420 R15: ffff93606421b028
  [552.6821] FS:  0000000000000000(0000) GS:ffff93675fb00000(0000) knlGS:0000000000000000
  [552.6821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [552.6821] CR2: 0000558ad262b000 CR3: 000000014feda005 CR4: 0000000000370ee0
  [552.6822] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [552.6822] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [552.6822] Call Trace:
  [552.6822]  <TASK>
  [552.6822]  ? __warn+0x80/0x130
  [552.6822]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
  [552.6824]  ? report_bug+0x1f4/0x200
  [552.6824]  ? handle_bug+0x42/0x70
  [552.6824]  ? exc_invalid_op+0x14/0x70
  [552.6824]  ? asm_exc_invalid_op+0x16/0x20
  [552.6824]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
  [552.6826]  btrfs_cleanup_transaction+0xe7/0x5e0 [btrfs]
  [552.6828]  ? _raw_spin_unlock_irqrestore+0x23/0x40
  [552.6828]  ? try_to_wake_up+0x94/0x5e0
  [552.6828]  ? __pfx_process_timeout+0x10/0x10
  [552.6828]  transaction_kthread+0x103/0x1d0 [btrfs]
  [552.6830]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
  [552.6832]  kthread+0xee/0x120
  [552.6832]  ? __pfx_kthread+0x10/0x10
  [552.6832]  ret_from_fork+0x29/0x50
  [552.6832]  </TASK>
  [552.6832] ---[ end trace 0000000000000000 ]---

This corresponds to this line of code:

  void btrfs_put_transaction(struct btrfs_transaction *transaction)
  {
      (...)
          WARN_ON(!RB_EMPTY_ROOT(
                          &transaction->delayed_refs.dirty_extent_root));
      (...)
  }

The warning happens because btrfs_qgroup_destroy_extent_records(), called
in the transaction abort path, we free all entries from the rbtree
"dirty_extent_root" with rbtree_postorder_for_each_entry_safe(), but we
don't actually empty the rbtree - it's still pointing to nodes that were
freed.

So set the rbtree's root node to NULL to avoid this warning (assign
RB_ROOT).

Fixes: 81f7eb00ff5b ("btrfs: destroy qgroup extent records on transaction abort")
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/qgroup.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4410,4 +4410,5 @@ void btrfs_qgroup_destroy_extent_records
 		ulist_free(entry->old_roots);
 		kfree(entry);
 	}
+	*root = RB_ROOT;
 }


