Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B07462EC
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGCSzw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGCSzw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F2FE64
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3C060F15
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473F3C433C8;
        Mon,  3 Jul 2023 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410549;
        bh=0HyXh3ZIgxPjn2Pj5ByUT2iF6oZ7zKM9xBUJI/OV9Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvFYQ4UzpAHvT7b6V6NLgEazKNS+Dk80C8Ay8TP1IsII7tYqmkLpcCd94Om/QHSNy
         iA2F0IfgB4DlPisdakZNhNlwItgPs8sIzwXB5c6HWIimtRyRDUwZRSKUU6/gAwJ9U2
         6FHJP7TwIcEP79vmATRsYDaKOOqIA8C51tRwUXmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6.4 08/13] nubus: Partially revert proc_create_single_data() conversion
Date:   Mon,  3 Jul 2023 20:54:09 +0200
Message-ID: <20230703184519.514175124@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.261119397@linuxfoundation.org>
References: <20230703184519.261119397@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Finn Thain <fthain@linux-m68k.org>

commit 0e96647cff9224db564a1cee6efccb13dbe11ee2 upstream.

The conversion to proc_create_single_data() introduced a regression
whereby reading a file in /proc/bus/nubus results in a seg fault:

    # grep -r . /proc/bus/nubus/e/
    Data read fault at 0x00000020 in Super Data (pc=0x1074c2)
    BAD KERNEL BUSERR
    Oops: 00000000
    Modules linked in:
    PC: [<001074c2>] PDE_DATA+0xc/0x16
    SR: 2010  SP: 38284958  a2: 01152370
    d0: 00000001    d1: 01013000    d2: 01002790    d3: 00000000
    d4: 00000001    d5: 0008ce2e    a0: 00000000    a1: 00222a40
    Process grep (pid: 45, task=142f8727)
    Frame format=B ssw=074d isc=2008 isb=4e5e daddr=00000020 dobuf=01199e70
    baddr=001074c8 dibuf=ffffffff ver=f
    Stack from 01199e48:
	    01199e70 00222a58 01002790 00000000 011a3000 01199eb0 015000c0 00000000
	    00000000 01199ec0 01199ec0 000d551a 011a3000 00000001 00000000 00018000
	    d003f000 00000003 00000001 0002800d 01052840 01199fa8 c01f8000 00000000
	    00000029 0b532b80 00000000 00000000 00000029 0b532b80 01199ee4 00103640
	    011198c0 d003f000 00018000 01199fa8 00000000 011198c0 00000000 01199f4c
	    000b3344 011198c0 d003f000 00018000 01199fa8 00000000 00018000 011198c0
    Call Trace: [<00222a58>] nubus_proc_rsrc_show+0x18/0xa0
     [<000d551a>] seq_read+0xc4/0x510
     [<00018000>] fp_fcos+0x2/0x82
     [<0002800d>] __sys_setreuid+0x115/0x1c6
     [<00103640>] proc_reg_read+0x5c/0xb0
     [<00018000>] fp_fcos+0x2/0x82
     [<000b3344>] __vfs_read+0x2c/0x13c
     [<00018000>] fp_fcos+0x2/0x82
     [<00018000>] fp_fcos+0x2/0x82
     [<000b8aa2>] sys_statx+0x60/0x7e
     [<000b34b6>] vfs_read+0x62/0x12a
     [<00018000>] fp_fcos+0x2/0x82
     [<00018000>] fp_fcos+0x2/0x82
     [<000b39c2>] ksys_read+0x48/0xbe
     [<00018000>] fp_fcos+0x2/0x82
     [<000b3a4e>] sys_read+0x16/0x1a
     [<00018000>] fp_fcos+0x2/0x82
     [<00002b84>] syscall+0x8/0xc
     [<00018000>] fp_fcos+0x2/0x82
     [<0000c016>] not_ext+0xa/0x18
    Code: 4e5e 4e75 4e56 0000 206e 0008 2068 ffe8 <2068> 0020 2008 4e5e 4e75 4e56 0000 2f0b 206e 0008 2068 0004 2668 0020 206b ffe8
    Disabling lock debugging due to kernel taint

    Segmentation fault

The proc_create_single_data() conversion does not work because
single_open(file, nubus_proc_rsrc_show, PDE_DATA(inode)) is not
equivalent to the original code.

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org # 5.6+
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/d4e2a586e793cc8d9442595684ab8a077c0fe726.1678783919.git.fthain@linux-m68k.org
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nubus/proc.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -137,6 +137,18 @@ static int nubus_proc_rsrc_show(struct s
 	return 0;
 }
 
+static int nubus_rsrc_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nubus_proc_rsrc_show, inode);
+}
+
+static const struct proc_ops nubus_rsrc_proc_ops = {
+	.proc_open	= nubus_rsrc_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
 void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 			     const struct nubus_dirent *ent,
 			     unsigned int size)
@@ -152,8 +164,8 @@ void nubus_proc_add_rsrc_mem(struct proc
 		pded = nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
 	else
 		pded = NULL;
-	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show, pded);
+	proc_create_data(name, S_IFREG | 0444, procdir,
+			 &nubus_rsrc_proc_ops, pded);
 }
 
 void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
@@ -166,9 +178,9 @@ void nubus_proc_add_rsrc(struct proc_dir
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
-	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show,
-			nubus_proc_alloc_pde_data(data, 0));
+	proc_create_data(name, S_IFREG | 0444, procdir,
+			 &nubus_rsrc_proc_ops,
+			 nubus_proc_alloc_pde_data(data, 0));
 }
 
 /*


