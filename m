Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8178479BF99
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbjIKU5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbjIKP1W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:27:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF592E4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:27:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01898C433C7;
        Mon, 11 Sep 2023 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446038;
        bh=LiOKM0Jz3ZgCG5xhegVLCOpwYsNmYSfXjYi2r0qAUhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmSLcmw7smsM5XeaOfxUVze/XXwLFW0gMAaaMLN4bCnMkOni98Z1Dvo3eQm3xfael
         MvMK/t1TP3GVTgAovXT8819Px+6/ULsi7kNFqTfsJCiGjTAlWy5Kz/03euwZB3Bv+S
         3RVJwkYWyhKDHBBfMKoH2JVCnemwocTNZecuMZi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 560/600] parisc: Fix /proc/cpuinfo output for lscpu
Date:   Mon, 11 Sep 2023 15:49:53 +0200
Message-ID: <20230911134650.142360029@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 9f5ba4b3e1b3c123eeca5d2d09161e8720048b5c upstream.

The lscpu command is broken since commit cab56b51ec0e ("parisc: Fix
device names in /proc/iomem") added the PA pathname to all PA
devices, includig the CPUs.

lscpu parses /proc/cpuinfo and now believes it found different CPU
types since every CPU is listed with an unique identifier (PA
pathname).

Fix this problem by simply dropping the PA pathname when listing the
CPUs in /proc/cpuinfo. There is no need to show the pathname in this
procfs file.

Fixes: cab56b51ec0e ("parisc: Fix device names in /proc/iomem")
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/processor.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -372,10 +372,18 @@ int
 show_cpuinfo (struct seq_file *m, void *v)
 {
 	unsigned long cpu;
+	char cpu_name[60], *p;
+
+	/* strip PA path from CPU name to not confuse lscpu */
+	strlcpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
+	p = strrchr(cpu_name, '[');
+	if (p)
+		*(--p) = 0;
 
 	for_each_online_cpu(cpu) {
-		const struct cpuinfo_parisc *cpuinfo = &per_cpu(cpu_data, cpu);
 #ifdef CONFIG_SMP
+		const struct cpuinfo_parisc *cpuinfo = &per_cpu(cpu_data, cpu);
+
 		if (0 == cpuinfo->hpa)
 			continue;
 #endif
@@ -420,8 +428,7 @@ show_cpuinfo (struct seq_file *m, void *
 
 		seq_printf(m, "model\t\t: %s - %s\n",
 				 boot_cpu_data.pdc.sys_model_name,
-				 cpuinfo->dev ?
-				 cpuinfo->dev->name : "Unknown");
+				 cpu_name);
 
 		seq_printf(m, "hversion\t: 0x%08x\n"
 			        "sversion\t: 0x%08x\n",


