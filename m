Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D27466C1
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGDBIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 21:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDBIX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 21:08:23 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DC184
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:08:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 075333200A88
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 21:08:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jul 2023 21:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688432898; x=1688519298; bh=4i99dNquXLGCn9208vrpXsrFZfW28/4HSbP
        31k5WNdw=; b=LFYskeQSgeIXEL6hEMqF6jFRaJsN7kHySjHgZFFk7CSykN4Sgov
        6IQV6KUMaiDNUmamI7OP5f6WFwqGRmeMA7yUTWNymv+jE2s4366wku+WzTnTZyxv
        5uHZV68EyXkNvctOmPC73O6zDeBiYkwFFYa3fwCprXB0joVtz1NsSzC+J7WMX9BX
        f6dN5fB3dyf3eDn2Ezc6/PX0W6nwzKUq35X96uyvRgAAtIW+CpEStuoh7H0FmM46
        8u3cBKUWqf2Kvs8qdWdo0dJO/T6aPJURRLtX6GxeCbYpMMP7fOotL9I3iRH4/BBi
        P2T5DzCFoUlHqWpTscOPqOWvybKzb272/6w==
X-ME-Sender: <xms:AnGjZDWKtPFEp50h_48TH1KMevCNuvfc8WlrV0ct4BFg8L4203WJqA>
    <xme:AnGjZLmS3MTrpqekFMMCPDB-s_CxwRfCaVa-qtZincIDTs_9H9WBmdloSYpHqDbJF
    a6JKgNFhocMumWLgqQ>
X-ME-Received: <xmr:AnGjZPYGqaW6UMBwvslkn5FzgN4WU4gOLA37X0oL-Kf-y31l3HWxheHGuoGQktuS3fx7Z_YY1jtCz2IGgAmmScvkWU8vlV7Jstc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffkjghfhffuvfestddtredttddttd
    enucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieek
    khdrohhrgheqnecuggftrfgrthhtvghrnheptdekveffiedugffftdettddtuefgffeuff
    ffheehteektdfhfeduudeljedtjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:AnGjZOVm5GhYxFq4fv7u2rWhsNZ7XNvdDIRpKsek4q0xVcrGWOyKiQ>
    <xmx:AnGjZNlREYtvmDVUVJ9iwgE2mfqbEVUVzQ5bL2kXxV2t31fAimbphg>
    <xmx:AnGjZLdr2-jcgxX6vXCrbBRTm-LJz24C7LxkloUcNQ8prOwEEiSQtg>
    <xmx:AnGjZJwmFru85tnv-9-t8GGi53tXW0b_SlnnMHoxk-DrhCb_wR3ZHg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Mon, 3 Jul 2023 21:08:15 -0400 (EDT)
Date:   Tue, 04 Jul 2023 11:09:21 +1000
Message-ID: <9bb320e617f10d0b99fed211fbaf5543.fthain@linux-m68k.org>
In-Reply-To: <2023070300-copious-unhidden-592f@gregkh>
References: <2023070300-copious-unhidden-592f@gregkh>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 5.10.y] nubus: Partially revert proc_create_single_data()
 conversion
To:     <stable@vger.kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit 0e96647cff9224db564a1cee6efccb13dbe11ee2)
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/nubus/proc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 88e1f9a0faaf..78cf0e7b53d5 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -137,6 +137,18 @@ static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
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
@@ -152,8 +164,8 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 		pde_data = nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
 	else
 		pde_data = NULL;
-	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show, pde_data);
+	proc_create_data(name, S_IFREG | 0444, procdir,
+			 &nubus_rsrc_proc_ops, pde_data);
 }
 
 void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
@@ -166,9 +178,9 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
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
-- 
2.39.3

