Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F37EA3D8
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjKMTjv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 14:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTju (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 14:39:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21723D6E
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:39:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb10a5d44so3188684276.0
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 11:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699904387; x=1700509187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mb5ZDARmMxBM77SrsGPWxbm6DQ3xgBxfaDU7K9Qp/Wc=;
        b=ewXT7fnoAaseK9UxO12qL5gxhFAfenXHV7yrnrwCVqeavj+BsOAniItcF+JJfceFIy
         CnA0tMqTCgP24dAKnDImnlIzp8J83iLAjvHP0c5CutyEpBVumP41RqZxpXlZ80N3y3o0
         ifaDyxrq0MHHjLtRFKld+oN2I+n7CReI38E31EBdhVc1CUPDVNJ+upGC/NB23W4xKdUO
         K9JbYZU+m7Jxb/MbwKQrsPIKkvARgMtikoHcF0xL/z6n/0Vfdecqw9LLTZ/e5o52L/h8
         jyyQvhuxt+V9mejLZ8rWdKLca+auTfx0rQ9Z7A5punc3xbiBoE5uofEtoDD1lUMgJ+aw
         d8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699904387; x=1700509187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mb5ZDARmMxBM77SrsGPWxbm6DQ3xgBxfaDU7K9Qp/Wc=;
        b=Jq+CM3Fu3RmfEJEYkwFhyVVwMvz3PoUfxfpQFIobMAdeqhSYNlI5GvveyaXwDPI58d
         j/XVelLHX1Ve1WBRTzjvxpoJP0CSnFHsIQ/F8FjWMxHjl49XGZ+6ZYdLgfRJGRHiOk9q
         g87EJ4BlmXT2H0T6F0BtCf0o5RLPpqLHEYYhMKCbgXwi8xoOhqd3UI4I/zwVfiL13GGQ
         E5xbgti29DP1DrXBVpVC/B1lXr6js5bREHzF+pgIq1izLaNh1fBBWRZkTrXnlTFVxMqM
         mK59wIq76kfA8vw1NbUqbLy8m7t9s0DNDmADw18kz3Qm6fDidJEPrlYx1HoP6w6tSYwN
         gyTQ==
X-Gm-Message-State: AOJu0YyzC4KAWtyRPJXImuzMXrPHaD5UlKaDirRXnh2Y8ihHBk212uhd
        16KdYGBJ+1WFPAMBhouCHzBRFLEwIrzwCM6QMLjFdav7AEiPRe89pi5l7PAQr7zRA0gbZ3IpHZa
        2ColUGvwX7Ch1jCIJOfntiZFtOPjlvgJf1aecwuNcQ0g2BVFAOv1+kw296HA=
X-Google-Smtp-Source: AGHT+IFCqAH5yk1qsDXiOFvRUK98XoO6c2R+cwjoXyDWDbavasdlHuoPTWETN+MsmIEgZnaxtXYlb1aApg==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a25:c545:0:b0:da0:3bea:cdc7 with SMTP id
 v66-20020a25c545000000b00da03beacdc7mr189683ybe.2.1699904387348; Mon, 13 Nov
 2023 11:39:47 -0800 (PST)
Date:   Mon, 13 Nov 2023 19:39:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113193940.156928-1-hegao@google.com>
Subject: [PATCH 5.10] Backport the fix for CVE-2023-25012 to kernel v5.10
From:   He Gao <hegao@google.com>
To:     stable@vger.kernel.org
Cc:     He Gao <hegao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is the fix of CVE-2023-25012 for kernel v5.10.

Upstream commit:  https://github.com/torvalds/linux/commit/7644b1a1c9a7ae8ab99175989bfc8676055edb46

The affected code is in io_uring/io_uring.c instead of io_uring/fdinfo.c for v5.10. So the patch applies the same change to io_uring/io_uring.c.

Thanks!
He

Jens Axboe (1):
  io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

 io_uring/io_uring.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

