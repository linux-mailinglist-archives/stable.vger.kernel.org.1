Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1B73E76B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFZSPD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFZSOz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CACD9F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9823B60F4F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E07AC433C9;
        Mon, 26 Jun 2023 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803293;
        bh=5vM43OMlDNd9tXqqXWlnmhWiDh7m1pA8se7+4GeiHsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=au17qfgD/D4DSHfLnJlFR+732suPkIwO1csza5ebyXbpuYsoHNgMtxQdcedbruwF0
         4kqjZC/G/v8Dh9AhW1beC8d/ZYwm1WgE1qrgmcFoB6yFGh85Z8mZ9JT80yfWq8a8pM
         CY8bjVPdEofy8Fo9eFlw1J34wJ7am7FtoDao9wN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sami Korkalainen <sami.korkalainen@proton.me>
Subject: [PATCH 6.3 012/199] Revert "efi: random: refresh non-volatile random seed when RNG is initialized"
Date:   Mon, 26 Jun 2023 20:08:38 +0200
Message-ID: <20230626180806.190872010@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 69cbeb61ff9093a9155cb19a36d633033f71093a upstream.

This reverts commit e7b813b32a42a3a6281a4fd9ae7700a0257c1d50 (and the
subsequent fix for it: 41a15855c1ee "efi: random: fix NULL-deref when
refreshing seed").

It turns otu to cause non-deterministic boot stalls on at least a HP
6730b laptop.

Reported-and-bisected-by: Sami Korkalainen <sami.korkalainen@proton.me>
Link: https://lore.kernel.org/all/GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me/
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/efi.c |   21 ---------------------
 1 file changed, 21 deletions(-)

--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -361,24 +361,6 @@ static void __init efi_debugfs_init(void
 static inline void efi_debugfs_init(void) {}
 #endif
 
-static void refresh_nv_rng_seed(struct work_struct *work)
-{
-	u8 seed[EFI_RANDOM_SEED_SIZE];
-
-	get_random_bytes(seed, sizeof(seed));
-	efi.set_variable(L"RandomSeed", &LINUX_EFI_RANDOM_SEED_TABLE_GUID,
-			 EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
-			 EFI_VARIABLE_RUNTIME_ACCESS, sizeof(seed), seed);
-	memzero_explicit(seed, sizeof(seed));
-}
-static int refresh_nv_rng_seed_notification(struct notifier_block *nb, unsigned long action, void *data)
-{
-	static DECLARE_WORK(work, refresh_nv_rng_seed);
-	schedule_work(&work);
-	return NOTIFY_DONE;
-}
-static struct notifier_block refresh_nv_rng_seed_nb = { .notifier_call = refresh_nv_rng_seed_notification };
-
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted with
@@ -451,9 +433,6 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efi_secret", 0, NULL, 0);
 #endif
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
-		execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
-
 	return 0;
 
 err_remove_group:


