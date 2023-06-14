Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5F72BFFD
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjFLKsl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjFLKsW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E660107
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89108623CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CECC433EF;
        Mon, 12 Jun 2023 10:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565983;
        bh=uklwMjG0BMcz3K3iGKfopYhLHaU1LzbYkwgMG+y+vBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiRflv1ETsB/MpFHcjl3xDJ0j/MAqLYeNeCbHxt5wS/qXquPpk79cW2jknUnqldSs
         eBJ+gJDN8TovtzzwPYZC2rMdHFMQFQcTQ9jpBH7zXZFCzKdptAPR8Q9VNznarzyhlm
         1utLNUcrSgWqvLotZIIzi33S0Xie9sjaNDnosEPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 07/68] blk-iocost: avoid 64-bit division in ioc_timer_fn
Date:   Mon, 12 Jun 2023 12:25:59 +0200
Message-ID: <20230612101658.771721966@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 5f2779dfa7b8cc7dfd4a1b6586d86e0d193266f3 upstream.

The behavior of 'enum' types has changed in gcc-13, so now the
UNBUSY_THR_PCT constant is interpreted as a 64-bit number because
it is defined as part of the same enum definition as some other
constants that do not fit within a 32-bit integer. This in turn
leads to some inefficient code on 32-bit architectures as well
as a link error:

arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: block/blk-iocost.o: in function `ioc_timer_fn':
blk-iocost.c:(.text+0x68e8): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: blk-iocost.c:(.text+0x6908): undefined reference to `__aeabi_uldivmod'

Split the enum definition to keep the 64-bit timing constants in
a separate enum type from those constants that can clearly fit
within a smaller type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230118080706.3303186-1-arnd@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-iocost.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -256,6 +256,11 @@ enum {
 	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
 	VRATE_CLAMP_ADJ_PCT	= 4,
 
+	/* switch iff the conditions are met for longer than this */
+	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
+};
+
+enum {
 	/* if IOs end up waiting for requests, issue less */
 	RQ_WAIT_BUSY_PCT	= 5,
 
@@ -294,9 +299,6 @@ enum {
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
 
-	/* switch iff the conditions are met for longer than this */
-	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
-
 	/*
 	 * Count IO size in 4k pages.  The 12bit shift helps keeping
 	 * size-proportional components of cost calculation in closer


