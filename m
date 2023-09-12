Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5579D2FC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjILN5o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjILN5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:57:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54F10CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdcade7fbso708393366b.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527058; x=1695131858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7VJj3VHo3KXbpurSHe5ERsO6HMjoAp18HwFQX58MjQ=;
        b=BFP/7QYJBs4OTuEN9jSeBdqCHK7wsadzpzJhDEaIfteTs2kEGUhJdtZnmBiRYfxsz1
         iXhVsK+oAoKhmIMueprKb1zdT8NvAv36ENIv35GUqnFEj5gjTRhZjnvkShvhbLBZrp4E
         YJ0/vyfv6dzSOtNuDAZv67ySj1zNR/Vbmv2cFLKYZwW+y0RYZKERw7XFFoDznuqMqUm7
         gkKODYhffEyOT12bfBpV2T/FiCOX8f+PPq/cfZ9tlC/tEqYpHsnsf5W0VnB9U1GlTAEG
         fyc5E9t5cMEOMty4Z7wuO9wuyYZ7Xd+LXal8cH2Dg2G1lqjpXEQ0r6X1CCxNOECTKJ8g
         DjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527058; x=1695131858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7VJj3VHo3KXbpurSHe5ERsO6HMjoAp18HwFQX58MjQ=;
        b=NaMFr3cDX+LD1aeAU/Bm0c1aF1I4qk2zmN5DJmJs0PvfaFrNCbh5lnUhCnnkCkDmar
         MVOhvYnm7DtnseHwBYnmGDoR8ZBVn4xfeL82lBTeLXnocUOT9uX7LVk2oeIIvi1JTZqs
         J5h7R+OnXEGvy6o0VB2matSQqhPAtsqErVcAiJ1Fe5WIdCu3btkkSqMBl/9qNok3bJmU
         HZzVrlLPDn7hqNUhAzB812tVfncEU4oxkZYt4LMWVaOKzgfsUbJhoPRl+ldvyrAKmGKJ
         KZjWHkcgo9uFFS8CWhS1f6Vmw5+2GptkvkcAINZMXZUfXvIpDUCy37r0xZQ8eCp/6lN7
         UnsA==
X-Gm-Message-State: AOJu0Yy/4icZu5NUOD8L6zwDqi1woMOhYo6TJ1knwI0sdj8GfFNFUezO
        UkXisr3NdlFV431cdwWZpq99G+9Ih5Q=
X-Google-Smtp-Source: AGHT+IEDowOUnfuNDwT70TIozCv0S33GVud39eklWBi57o59pGtt/xtrvu4RhQprszUN/ju4dx2ibA==
X-Received: by 2002:a17:906:300f:b0:9a1:cdf1:ba6 with SMTP id 15-20020a170906300f00b009a1cdf10ba6mr10796869ejz.12.1694527057928;
        Tue, 12 Sep 2023 06:57:37 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0099cadcf13cesm6863182ejw.66.2023.09.12.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:57:37 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 0/6] stable-6.1 io_uring patches
Date:   Tue, 12 Sep 2023 14:57:02 +0100
Message-ID: <cover.1694486400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Recently failed to apply io_uring stable-6.1 patches

Dylan Yudaken (2):
  io_uring: always lock in io_apoll_task_func
  io_uring: revert "io_uring fix multishot accept ordering"

Gabriel Krisman Bertazi (1):
  io_uring: Don't set affinity on a dying sqpoll thread

Jens Axboe (1):
  io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used

Pavel Begunkov (2):
  io_uring/net: don't overflow multishot accept
  io_uring: break out of iowq iopoll on teardown

 io_uring/io-wq.c    | 17 +++++++++++++++--
 io_uring/io-wq.h    |  3 ++-
 io_uring/io_uring.c | 31 ++++++++++++++++++++-----------
 io_uring/net.c      |  8 ++++----
 io_uring/poll.c     |  3 ++-
 io_uring/sqpoll.c   | 17 +++++++++++++++++
 io_uring/sqpoll.h   |  1 +
 7 files changed, 61 insertions(+), 19 deletions(-)

-- 
2.41.0

