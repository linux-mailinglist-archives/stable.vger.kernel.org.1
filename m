Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB117BFD2E
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJJNUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjJJNUf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 09:20:35 -0400
Received: from mail-ed1-x562.google.com (mail-ed1-x562.google.com [IPv6:2a00:1450:4864:20::562])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3091
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 06:20:33 -0700 (PDT)
Received: by mail-ed1-x562.google.com with SMTP id 4fb4d7f45d1cf-53da80ada57so549390a12.0
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google; t=1696944031; x=1697548831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klWQQLel+kfzddvQV5jdp3oXAW1qFwzXzukYzZQ/wN8=;
        b=TVqDc/+e/ZAiHM54KDtlfbxvI9wCnlfjMvQbkP732VwljOr04jfJYD1Z+BYRHvN//3
         DgcsBut8zUB8uVgfk3TFnWwTAqslpN+lMHNRkw1CRZTlnUSeo3xFCs3MUFBHVwIOxumf
         TY8ZB8ibUDbDWFMxtAf0+0jFMpCqWXAyi5vbrt+tAByCS5EpA5FAV0MjuNjQjVaxChua
         bOHUq6XUmu/ivunXz9AB+yhqFw8eBBQ6ZAOnzNqs/poGmN4JflnU77yyHnztzZsDZrnB
         9mHCsU008errC06u9HjTUyO7armZeNeviC2fhFqrwcRJwYyGkfpws80eg6/wFtzJS+jV
         Ggzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944031; x=1697548831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klWQQLel+kfzddvQV5jdp3oXAW1qFwzXzukYzZQ/wN8=;
        b=QHyzO3xzINTQ3HJUlzIr+wsz/L9Rq7ha4nKrqOk36h5Br9jU71gekCUFxUtYE7uYly
         nUzwZdCo2TBKVvDmwTXlzQGY8EWx59iiIDzpmayjIE5TmMfp3npSguJ8ZaHcvqmwiVjT
         IXE8cqmV/XEfAzkRRzMIZ2BV+V85B/38DzFVCN8oj0kMC2qISu828VDiq4d2USQWYKZK
         dpmis1Pvvl6OjgEHsoDZdwqDC+6oSp2IgI4hlvxzDxJER4bmAMNH+XjoG2dDt/UnXVZo
         g3K5pv4uQj+x6QuaQ60Jo5QXhwYFj9x37c/E3pkdJqqFirDnBQYR9yV+JOYkLQodJB5r
         FrmQ==
X-Gm-Message-State: AOJu0YzUPJumU7B+iPwhT1oznab6DU2wbeaHaIhk0IECTBUa5G7UKWA2
        WqI8Voisv5cZSKHQ0+aa/spDvwDzKKi1DrMOg4+N8365wq4GiyLleQAoIexEQtkpH84m6y2xbRM
        BP6NfedZ3SEb2BmnojpyDKnRG3tkjU4rB4ONwSaT9bI8UkxqSiOcH91qz2SqxJ79Yx7o65gAbD7
        3NBBlYFP+7o2qAv4SHt9HKH6dM/sM=
X-Google-Smtp-Source: AGHT+IEzZ6e4B5MrWtE89wlUax/GwV2zuK4/ekYIvKKPs1FPSFjSbfsj3NqbJjVs3Py5/q/djmUIZZ1PUy/v
X-Received: by 2002:a50:ee87:0:b0:514:9ab4:3524 with SMTP id f7-20020a50ee87000000b005149ab43524mr16801660edr.7.1696944031353;
        Tue, 10 Oct 2023 06:20:31 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id f28-20020a50a6dc000000b00533c7e90bc5sm2045253edc.34.2023.10.10.06.20.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Oct 2023 06:20:31 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [10.32.51.167] (port=49644 helo=FR-BES-DKT15486.dynamic.besancon.parkeon.com)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1qqChF-0003TE-DQ; Tue, 10 Oct 2023 15:22:49 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        etnaviv@lists.freedesktop.org
Subject: [PATCH 5.4] drm: etvnaviv: fix bad backport leading to warning
Date:   Tue, 10 Oct 2023 15:19:28 +0200
Message-Id: <20231010132030.1392238-1-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When updating from 5.4.219 -> 5.4.256 I started getting a runtime warning:

[   58.229857] ------------[ cut here ]------------
[   58.234599] WARNING: CPU: 1 PID: 565 at drivers/gpu/drm/drm_gem.c:1020 drm_gem_object_put+0x90/0x98
[   58.249935] Modules linked in: qmi_wwan cdc_wdm option usb_wwan smsc95xx rsi_usb rsi_91x btrsi ci_hdrc_imx ci_hdrc
[   58.260499] ueventd: modprobe usb:v2F8Fp7FFFd0200dc00dsc00dp00icFEisc01ip02in00 done
[   58.288877] CPU: 1 PID: 565 Comm: android.display Not tainted 5.4.256pkn-5.4-bsp-snapshot-svn-7423 #2195
[   58.288883] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   58.288888] Backtrace:
[   58.288912] [<c010e784>] (dump_backtrace) from [<c010eaa4>] (show_stack+0x20/0x24)
[   58.288920]  r7:00000000 r6:60010013 r5:00000000 r4:c14cd224
[   58.328337] [<c010ea84>] (show_stack) from [<c0cf9ca4>] (dump_stack+0xe8/0x120)
[   58.335661] [<c0cf9bbc>] (dump_stack) from [<c012efd0>] (__warn+0xd4/0xe8)
[   58.342542]  r10:eda54000 r9:c06ca53c r8:000003fc r7:00000009 r6:c111ed54 r5:00000000
[   58.350374]  r4:00000000 r3:76cf564a
[   58.353957] [<c012eefc>] (__warn) from [<c012f094>] (warn_slowpath_fmt+0xb0/0xc0)
[   58.361445]  r9:00000009 r8:c06ca53c r7:000003fc r6:c111ed54 r5:c1406048 r4:00000000
[   58.369198] [<c012efe8>] (warn_slowpath_fmt) from [<c06ca53c>] (drm_gem_object_put+0x90/0x98)
[   58.377728]  r9:edda7e40 r8:edd39360 r7:ad16e000 r6:edda7eb0 r5:00000000 r4:edaa3200
[   58.385524] [<c06ca4ac>] (drm_gem_object_put) from [<bf0125a8>] (etnaviv_gem_prime_mmap_obj+0x34/0x3c [etnaviv])
[   58.395704]  r5:00000000 r4:edaa3200
[   58.399334] [<bf012574>] (etnaviv_gem_prime_mmap_obj [etnaviv]) from [<bf0143a0>] (etnaviv_gem_mmap+0x3c/0x60 [etnaviv])
[   58.410205]  r5:edd39360 r4:00000000
[   58.413816] [<bf014364>] (etnaviv_gem_mmap [etnaviv]) from [<c02c5e08>] (mmap_region+0x37c/0x67c)
[   58.422689]  r5:ad16d000 r4:edda7eb8
[   58.426272] [<c02c5a8c>] (mmap_region) from [<c02c6528>] (do_mmap+0x420/0x544)
[   58.433500]  r10:000000fb r9:000fffff r8:ffffffff r7:00000001 r6:00000003 r5:00000001
[   58.441330]  r4:00001000
[   58.443876] [<c02c6108>] (do_mmap) from [<c02a5b2c>] (vm_mmap_pgoff+0xd0/0x100)
[   58.451190]  r10:eda54040 r9:00001000 r8:00000000 r7:00000000 r6:00000003 r5:c1406048
[   58.459020]  r4:edb8ff24
[   58.461561] [<c02a5a5c>] (vm_mmap_pgoff) from [<c02c3ac8>] (ksys_mmap_pgoff+0xdc/0x10c)
[   58.469570]  r10:000000c0 r9:edb8e000 r8:ed650b40 r7:00000003 r6:00001000 r5:00000000
[   58.477400]  r4:00000001
[   58.479941] [<c02c39ec>] (ksys_mmap_pgoff) from [<c02c3b24>] (sys_mmap_pgoff+0x2c/0x34)
[   58.487949]  r8:c0101224 r7:000000c0 r6:951ece38 r5:00010001 r4:00000065
[   58.494658] [<c02c3af8>] (sys_mmap_pgoff) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

It looks like this was a backporting error for the upstream patch
963b2e8c428f "drm/etnaviv: fix reference leak when mmaping imported buffer"

In the 5.4 kernel there are 2 variants of the object put function:
	drm_gem_object_put() [which requires lock to be held]
	drm_gem_object_put_unlocked() [which requires lock to be NOT held]

In later kernels [5.14+] this has gone and there just drm_gem_object_put()
which requires lock to be NOT held.

So the memory leak pach, which added a call to drm_gem_object_put() was correct
on newer kernels but wrong on 5.4 and earlier ones.

So switch back to using the _unlocked variant for old kernels.
This should only be applied to the 5.4, 4.19 and 4.14 longterm branches;
mainline and more recent longterms already have the correct fix.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Fixes: 0c6df5364798 "drm/etnaviv: fix reference leak when mmaping imported buffer" [5.4.y]
Fixes: 0838cb217a52 "drm/etnaviv: fix reference leak when mmaping imported buffer" [4.19.y]
Fixes: 1c9544fbc979 "drm/etnaviv: fix reference leak when mmaping imported buffer" [4.14.y]

---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index fe7817e4c0d1..4400f578685a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -98,7 +98,7 @@ static int etnaviv_gem_prime_mmap_obj(struct etnaviv_gem_object *etnaviv_obj,
 	ret = dma_buf_mmap(etnaviv_obj->base.dma_buf, vma, 0);
 	if (!ret) {
 		/* Drop the reference acquired by drm_gem_mmap_obj(). */
-		drm_gem_object_put(&etnaviv_obj->base);
+		drm_gem_object_put_unlocked(&etnaviv_obj->base);
 	}

 	return ret;
--
2.25.1

