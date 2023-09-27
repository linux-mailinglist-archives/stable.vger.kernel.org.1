Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFF37B0594
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjI0NhP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjI0NhO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 09:37:14 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEFFC
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 06:37:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79f9acc857cso340842539f.2
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695821833; x=1696426633; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wLkiE2z9JJ6gZFz/EkEVTFVUJ1HqgB4Vkj/VIK5SvrY=;
        b=EhGkBLgO0HV6xWGoXoScxfKmOhu0pUo43IFrDbnmd2+yO4dRe+o3Xl0RTR+KgUeQtL
         FiazXGIaOqKbP1hfATjAKm3XYhhRdvRKyQLhRZ1/rgOibbvuxLc7kvjKwPHWnyBrw0ia
         L1Htjq7ikOuPoyiVxwgQJQOyBkAGOD8ehejRo5ChWjykCbr5jUtkPz2pfU/yh1ktqQ8/
         hQOzSy2oXuTvlsB9vD0fkTYQlJ4E7mljGlOcxUGQ1GmT1+Hb4+4ymTzGPUe7BLjCrDMB
         5bdClwgkYiguO6Iayx6ZwNoNiMmbXJoxzseSa7K85f2+wx2hfZXydzZn3qSqSPotkOsR
         vlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695821833; x=1696426633;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLkiE2z9JJ6gZFz/EkEVTFVUJ1HqgB4Vkj/VIK5SvrY=;
        b=jjMLqCFp3hfYHZldzAc1JJEVW60FYVfh6DwAKg22xc8WIaNbn1gk+ylzuBiTbJAFox
         +2rRX5z/lwU+7Ek1TKE6wjECJHPnYlnC1ekzza8bD6cKvpeTShyQoyQD4vz9z7eJIK+J
         kvBxPRHuOt44V40CppnRSEVZvkCRiJ+tOKz5HIpkca7pQ0VnrKng9cwOMdwmH2hiTp8Z
         vYnn7ev/BNInThGtsjWGC0McGB6toWy4x1o3Zv/BzZnKDZkt4nBSWH97qLJhwc4DpDqN
         Kfq73ssm6LuC3e92HqkWtPH1d07dypSw0GthsnSF20GgjMzqxn2jeYSdilGmX2j7rV5q
         QD4w==
X-Gm-Message-State: AOJu0YxAhtWRJjYz1D/ErBTjMsYcRBG2nWgQjqO/Q73O8fzMVaSBwbur
        XRyFxEZmcnbfvjkTPaJ2qxlHM+t7Wik=
X-Google-Smtp-Source: AGHT+IFaOIDA/Iw6brTSoGeXRJQsi9y1p1mqT0Lqy1PBeefrwBRJWL6yT4hVg910g0iPu8agFD8S/g==
X-Received: by 2002:a05:6602:39a:b0:794:ed2b:2520 with SMTP id f26-20020a056602039a00b00794ed2b2520mr2309961iov.15.1695821832886;
        Wed, 27 Sep 2023 06:37:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9-20020a02a609000000b0042b279bb086sm4133545jam.66.2023.09.27.06.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:37:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Sep 2023 06:37:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Clark <robdclark@chromium.org>
Subject: Build failure in v5.15.133
Message-ID: <e56ced8d-d09d-469b-80df-0cc2bdd943f4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

I see the following build failure with v5.15.133.

Build reference: v5.15.133
Compiler version: aarch64-linux-gcc (GCC) 11.4.0
Assembler version: GNU assembler (GNU Binutils) 2.40

Building arm64:allnoconfig ... passed
Building arm64:tinyconfig ... passed
Building arm64:defconfig ... failed
--------------
Error log:
drivers/interconnect/core.c: In function 'icc_init':
drivers/interconnect/core.c:1148:9: error: implicit declaration of function 'fs_reclaim_acquire' [-Werror=implicit-function-declaration]
 1148 |         fs_reclaim_acquire(GFP_KERNEL);
      |         ^~~~~~~~~~~~~~~~~~
drivers/interconnect/core.c:1150:9: error: implicit declaration of function 'fs_reclaim_release' [-Werror=implicit-function-declaration]
 1150 |         fs_reclaim_release(GFP_KERNEL);
      |         ^~~~~~~~~~~~~~~~~~

This also affects alpha:allmodconfig and m68k:allmodconfig. The problem
was introduced with 'interconnect: Teach lockdep about icc_bw_lock order'.

#include <linux/sched/mm.h> is missing. Presumably that is included
indirectly in the upstream kernel, but I wasn't able to determine which
commit added it.

Guenter
