Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A87EA3C7
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 20:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjKMTcg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTcf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 14:32:35 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F4D6E
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:32:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b9a1494e65so4626031a12.2
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699903952; x=1700508752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqFcYNCfms2muQ1zZhvFyy0ErUpG+GIpKXBdaBukd6c=;
        b=Iv/lSdymzrZZmhmH00QXHP8miHfdK6Ss8hyqFz+havox9zbqvjHcPn95aphcD9Yimd
         bztQrEHyKR0MkUa/djJO8Fe9VJkPhW+xFC8vubLZpHB+YTfELSRUt2R6U7NZ2nlKr8z8
         VFbmrNfShCjVboFfUqlpjnmb8qrwPxO2Trx3VOWJU/nDoER8KbNlPJ6EkmlsGSUYnv+6
         Dye815AYa0bkZh242nWOuxlFYVxLbQLQmzKHOjcu86oyz5RiL1fRyVFVG4u8jdSkX0lN
         aJLmz1uCK8oyErTjIVi9b3fULsolK2gHOSkmDIFiYrxo2P1z4bzzF+sSIUPu5ZTZkxv0
         ZdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903952; x=1700508752;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqFcYNCfms2muQ1zZhvFyy0ErUpG+GIpKXBdaBukd6c=;
        b=aMfhCMGs+u+vHk7I/plSNuFtMg1t18WnbTcumjDXuuswql8CUgMycACDftKQSXTV+b
         tUJ8KvFieFH+ahkvmQPQW05914OE0OAvPDP8wwnP5hB00HN6UfIpTomOAvhwqiZgSvxK
         FW8dL5y3BnZyDJztlHuq9QamKNfvEPpqFppbIi/N0NoZ1Ca0IyXQuPnoMNtIqIOnRTuP
         F1G7fe5RmCmZ75pZG27zb6BT2ewSHQ1+UuIJAVsyEMYoFQOFSu+rSTwKWWgcwaMquLmj
         /hm/8PnJHPIcbXFHDhonHwwwUO3h45dn/QIrS1taujTTwTpdLsgwFCaRwU47iRxIG+Fg
         mJyA==
X-Gm-Message-State: AOJu0Yx60NiB30XyLDYd/uifm58YibRnBq3wIoKqJbgI3exrVMCMRpMY
        JgBNkYrzOICeJiY+vWljmF06NG1AVWEjH7oaiHpQdkFMbnaJ67rJ5Gc57NW0P7j3k5Lc4eiAE4c
        JLbnfe3E2Iv538tWvUbPdSpgtF47UM2hJcGLRErmqsG4F9crOGzwiY2P9g+w=
X-Google-Smtp-Source: AGHT+IE4y3O3GwZcp6HRPISXeTZ/JdKTIhy8NPIO23pIShhTkLN6UAdexaVBjLdf5WMD8YsjaH+Xg+SFgA==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a63:4622:0:b0:5bd:a359:7e0a with SMTP id
 t34-20020a634622000000b005bda3597e0amr5772pga.9.1699903951701; Mon, 13 Nov
 2023 11:32:31 -0800 (PST)
Date:   Mon, 13 Nov 2023 19:32:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113193227.154296-1-hegao@google.com>
Subject: [PATCH 5.15] Backport the fix for CVE-2023-25012 to kernel v5.15
From:   He Gao <hegao@google.com>
To:     stable@vger.kernel.org
Cc:     He Gao <hegao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is the fix of CVE-2023-25012 for kernel v5.15.

Upstream commit:  https://github.com/torvalds/linux/commit/7644b1a1c9a7ae8ab99175989bfc8676055edb46

The affected code is in io_uring/io_uring.c instead of io_uring/fdinfo.c for v5.15. So the patch applies the same change to io_uring/io_uring.c.

Thanks!
He

Jens Axboe (1):
  io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

 io_uring/io_uring.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

