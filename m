Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6C78AC98
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjH1Klc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjH1KlI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8C1A3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39AFF63E56
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D5C433C8;
        Mon, 28 Aug 2023 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219259;
        bh=OksEVLbxlFD94W06+LsVmGGRufjauz2DO3pyuDU3mvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R13XgYNjRBv+kdwSmG9KAqpTDhGNn9bGU2QGTCQphnJ41Uz4vbN3Fm961XrtRhY+V
         CE1RWh/1Fw0cQtRB09r4qiAQslHcA8Fe1ng4fDwETcmf8rZaz45lkWQr7kCWXwrS8P
         +igZ2vQydEICRR1qPJEeAQPILGKq+drOApEU382M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 103/158] MIPS: cpu-features: Use boot_cpu_type for CPU type based features
Date:   Mon, 28 Aug 2023 12:13:20 +0200
Message-ID: <20230828101200.779796843@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 5487a7b60695a92cf998350e4beac17144c91fcd ]

Some CPU feature macros were using current_cpu_type to mark feature
availability.

However current_cpu_type will use smp_processor_id, which is prohibited
under preemptable context.

Since those features are all uniform on all CPUs in a SMP system, use
boot_cpu_type instead of current_cpu_type to fix preemptable kernel.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/cpu-features.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index b72887e033082..ae4a2f52e3c4d 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -128,7 +128,7 @@
 ({									\
 	int __res;							\
 									\
-	switch (current_cpu_type()) {					\
+	switch (boot_cpu_type()) {					\
 	case CPU_CAVIUM_OCTEON:						\
 	case CPU_CAVIUM_OCTEON_PLUS:					\
 	case CPU_CAVIUM_OCTEON2:					\
@@ -358,7 +358,7 @@
 ({									\
 	int __res;							\
 									\
-	switch (current_cpu_type()) {					\
+	switch (boot_cpu_type()) {					\
 	case CPU_M14KC:							\
 	case CPU_74K:							\
 	case CPU_1074K:							\
-- 
2.40.1



