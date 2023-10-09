Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083587BDDEB
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376899AbjJINOM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376869AbjJINNu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E61AF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:13:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7ADC433C7;
        Mon,  9 Oct 2023 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857228;
        bh=+iTaA3lwLUsawlzI7j/d3mKGDl4FEHYR2e7X9kayjPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaqGtHc/CQ6IJYcayWDYB1r10yn1UZGKHHWgm6enZa/1LjpjzZlUHn3d8+Fh6otbM
         leAMRjLsDBSinre4ZAD7nmnrVOY6GR8qgrmGe1M5LwqtJLfNDW+DPE649mmrQk679i
         g9qyzpOzKPT/P0N8CqcTmTgUayk1dvuVhujJ3nhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.5 139/163] parisc: Fix crash with nr_cpus=1 option
Date:   Mon,  9 Oct 2023 15:01:43 +0200
Message-ID: <20231009130127.886119719@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit d3b3c637e4eb8d3bbe53e5692aee66add72f9851 upstream.

John David Anglin reported that giving "nr_cpus=1" on the command
line causes a crash, while "maxcpus=1" works.

Reported-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.18+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/smp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -440,7 +440,9 @@ int __cpu_up(unsigned int cpu, struct ta
 	if (cpu_online(cpu))
 		return 0;
 
-	if (num_online_cpus() < setup_max_cpus && smp_boot_one_cpu(cpu, tidle))
+	if (num_online_cpus() < nr_cpu_ids &&
+		num_online_cpus() < setup_max_cpus &&
+		smp_boot_one_cpu(cpu, tidle))
 		return -EIO;
 
 	return cpu_online(cpu) ? 0 : -EIO;


