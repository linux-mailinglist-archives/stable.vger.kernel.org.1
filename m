Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3D79D31C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjILODZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILODY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:03:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B371710CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c136ee106so706885866b.1
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527399; x=1695132199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo7iXbHy4x2PvD9ozhmBhM2+HNuolyF4QbOeweFSeTQ=;
        b=qnhQxFtdeI2ufOq5rVWJ4pEdqu2umHGK4s1HHHWI9Ea04apAL0U+9pFK0JwNPwfD1n
         Ah/Mht8hOGXGr+2Puqw8+ctghwNuGbYu8uDE4uKUYJU/B1VFL5IBxxfOGnBPuhnk6J8n
         FsZqbyrdP9FnmcCrXCY4fmrVkmP3p+P7mhIGAmDEg/mkmWQfvt1ccZQKh5vhfMfns63Q
         PC6qgQYdj9Az1kPRozQZ+BIYU/HumA3qhTAREYottNZ3uawtJAj1tN691drB4lGXHues
         dKQFAYodcSrpRu2kkkHIDFviYjFcYPzGKutXkIt+y+Ghybcon5miAEpT2zTXplcE0yfY
         s75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527399; x=1695132199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo7iXbHy4x2PvD9ozhmBhM2+HNuolyF4QbOeweFSeTQ=;
        b=JTLG+8b3D887Vhq667wAZw1Oc17/jHyg1qQCQaGYUVv1HLBZBY6NTBOMF5kqUnPUWT
         FAB+Bg83P6PZEFEuAi4WKDCyhrZUOqmmBCJGT5k6Tj7pnMvxqt1LP/dXbULTw42gLe3Q
         g+ZfbwN/lsvVyKOp+cOWWc3yjFECvv2N8Mic14HFDVHHMIZKKE6BNoudWWRW9AJ0RwRa
         HXKBtQdi/G+2aqc0PWk9LpO3Nr3rJzlzuxuBPMwGOJq5XGFt43SjD1tAfpuxxyoa9nbF
         lp9vtkuqjWHoz9ICUBaW0MKJofzZchzTc89+Vo5uBaAc1rsx5ZG62N/HsTxhyR7mNiM/
         zLfA==
X-Gm-Message-State: AOJu0Yx7xw9lcd+Y5FgSzYWx/7Y++J/Pivv9W3qatCk68v8zk7SoirZW
        5DXUnF4C6axY1rpaZfUGpJ9aHN4O9p8=
X-Google-Smtp-Source: AGHT+IH/woy9V89aKd3RgBiqyyuwgn921h0Gu+mK5p/7x0bawqRuEUKuGSpIr2HAs7WEkRYUVyxNTw==
X-Received: by 2002:a17:907:762d:b0:9a9:ef41:e5a6 with SMTP id jy13-20020a170907762d00b009a9ef41e5a6mr10868925ejc.1.1694527398969;
        Tue, 12 Sep 2023 07:03:18 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id ib10-20020a1709072c6a00b009ad8d444be4sm751671ejc.43.2023.09.12.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:03:18 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 0/3] stable-5.10 io_uring patches
Date:   Tue, 12 Sep 2023 15:02:47 +0100
Message-ID: <cover.1694524751.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Recently failed to apply io_uring stable-5.10 patches.

Dylan Yudaken (1):
  io_uring: always lock in io_apoll_task_func

Pavel Begunkov (2):
  io_uring: break out of iowq iopoll on teardown
  io_uring: break iopolling on signal

 io_uring/io-wq.c    | 10 ++++++++++
 io_uring/io-wq.h    |  1 +
 io_uring/io_uring.c |  9 ++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.41.0

