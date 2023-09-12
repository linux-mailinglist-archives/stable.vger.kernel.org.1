Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087CF79D2F0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjILN4C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILN4B (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:56:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B410CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:55:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf3f59905so705940966b.3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526956; x=1695131756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnU+SS13t5VvYrR9Q9FSZcHI4uWT1h3sersFCqmFkQQ=;
        b=TMd3pffEvzvGrYI6iGBKGWiW206ABsLApC5EcMXdp/K9xlSf12SV4CJY5Kz1kARyWE
         SnHfeJJthVN+gdy88NGCOUr4cDTkOf/gq5w7pOhVyhVtsHlJ2mPc0YaZZCoeTX/sh+zF
         gZlOnT4LpterqRUP7sdsZWwWaTSbKgWfuiC+1qyA3+RnS85liVZAhNIf54LAAmiGUfVA
         vE3wvo8F04dtZuG1bQ7QQbEGubMjO+H0KBlluZ8fOn1IguPNWtFg9NwEkocCz4FPL/Bq
         hWJ2SChhjhq3IJ3FPxxcJHzKqWcnep6QOovPUF4S26kVdDOeTTPfC57qrOxBw/B9ymmc
         TDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526956; x=1695131756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnU+SS13t5VvYrR9Q9FSZcHI4uWT1h3sersFCqmFkQQ=;
        b=IAk4jdOEmfsjlPUeotoghrDrwAEoVHlngYcZbGSZr25aIRug/7x8FVWtQgjlH0wr3g
         z+I5PBjS3ly2lDZ2lWGR/sEuoA0HapjHZ/jrKJrU6gpmPeVwokpZCMrGt4CiO2MRZreI
         wPQBMNFhIcIVC1jwckXeTsrBYpvx+8TFlVzvzhoVo/j+EVPonokTkFJvvyhbzCWIMsxS
         r5/dvXRoR7sriu/9EzQySzJXA6nrUTg8H3qC6DJyVmKo9m+krprAkdUGpDSetDuZeWkY
         6iXct+Fh6U358FoCmjtjeYwHztzuBFlVI/SwrgOVVRLIOBHfSiyFgeK6+rJokEQwn2nB
         PdVA==
X-Gm-Message-State: AOJu0Yy+X7EQg2H0WJSaiV/4bRYxkbf9EDwOuePvao1CtBCZCropsvp4
        rFaropZfedPnmkc4Q8Mdqs/6d21kxXc=
X-Google-Smtp-Source: AGHT+IE2xUaqtn9KcJZGuPZVF7vRdEu97K8T7JyqBf3dVwf5wVNrxDSbDRDSfhCLFXoRMBoqEzpDmg==
X-Received: by 2002:a17:907:78d1:b0:9a1:edfd:73bb with SMTP id kv17-20020a17090778d100b009a1edfd73bbmr11344631ejc.47.1694526955480;
        Tue, 12 Sep 2023 06:55:55 -0700 (PDT)
Received: from 127.0.0.1localhost ([85.255.237.46])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906344c00b009a5c98fd82asm6802337ejb.81.2023.09.12.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:55:55 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com
Subject: [PATCH 0/3] stable-6.4 io_uring patches
Date:   Tue, 12 Sep 2023 14:55:21 +0100
Message-ID: <cover.1694479828.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Recently failed to apply io_uring stable-6.4 patches.

Jens Axboe (1):
  io_uring: cleanup io_aux_cqe() API

Pavel Begunkov (2):
  io_uring/net: don't overflow multishot accept
  io_uring/net: don't overflow multishot recv

 io_uring/io_uring.c | 4 +++-
 io_uring/io_uring.h | 2 +-
 io_uring/net.c      | 9 ++++-----
 io_uring/poll.c     | 4 ++--
 io_uring/timeout.c  | 4 ++--
 5 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.41.0

