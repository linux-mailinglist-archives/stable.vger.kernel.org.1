Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AD8781EB4
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjHTP0E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjHTP0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 11:26:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5444B7
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 08:23:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2273349f8f.0
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544984; x=1693149784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv1diFTOqKzZA/O5DSFMKhZ0OSO8cZgHEP5aFkxJC+4=;
        b=qKNxL6QLG2aT8Xf0mtrCGrP65BnpCNMkY8Wyc4uwYkPmBKbnN38X4fys7PiJT7Mzi8
         pLvMpR6nr2XmWLwYyVaZcp5vXI6/n4b0RTmmLVdN5fGCeYBQIsD7APxLkVw3/18XJeBR
         NoDK40chE5YJJusQA9yVPNJKKMMf/5ZvXUN7j6I8vD/FShNrm4xZcBicQcyqueIrh8b9
         Pn5T9/U1xlR0HQn+Gd0uE9yp+8EKArHjabSOb0yLLLNMPZrUBgdoz443fv1jgGMlb81X
         MBJkqmZwN8oPlk+mZ95pu5EE6TK4CExOab6JWstNHl466shjX2dpvnL08SjZs1SDnSDB
         Dpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544984; x=1693149784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qv1diFTOqKzZA/O5DSFMKhZ0OSO8cZgHEP5aFkxJC+4=;
        b=GFgQ5C2m9Gz5XSj/TCO5dBIvnoxNxdg2UcCFZ6kl1ooUEeLh+M5Tx4gQ0iVateacLc
         xLuF+QW/YRKizvxCxf6amafX3nYBAzG6xZNgaJmSibaJ7RiuevuHDcHlqm035P65BT35
         /WKfuaeF5SF39tKXgP4iwfHiTFDd7RNQFcXP6+NHdOL93fPeSG/bsu+5qL77glilA5Dz
         De7jDFdJKiLNSNBwMV/ELrU1X87sL4ZNrsTcNu2dhDuQhVLpPmeOgP+gL54gk5WEVlF/
         owL5RKoliXQkZZFchftVp/Doz73Lznzjop1dIsQryNFAgJ0GOSUNCPTpr6rPBFbkwFvH
         CuqQ==
X-Gm-Message-State: AOJu0YwX84fUNAZ9MxXCjs/QoRZH2mkryX76PAFl6ewT0nso22c6XqZW
        S6ncQ3YjKOyQoOW6Rl+u8SydeccX/iZImUcEy+g=
X-Google-Smtp-Source: AGHT+IHdE/AEygT/NrtOnZA6mlsQcgk/7jhVtKZTnhCkXsc1n1JR1RYRgCu09madAxma15q41RrKKw==
X-Received: by 2002:a05:6000:1808:b0:317:5bb2:aeca with SMTP id m8-20020a056000180800b003175bb2aecamr3014805wrh.16.1692544983763;
        Sun, 20 Aug 2023 08:23:03 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0031773a8e5c4sm9527466wrm.37.2023.08.20.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:23:03 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/6] Backport rework of deadline bandwidth restoration for 5.15.y
Date:   Sun, 20 Aug 2023 16:22:52 +0100
Message-Id: <20230820152258.518128-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a backport of the series that fixes the way deadline bandwidth
restoration is done which is causing noticeable delay on resume path. It also
converts the cpuset lock back into a mutex which some users on Android too.
I lack the details but AFAIU the read/write semaphore was slower on high
contention.

Compile tested against some randconfig for different archs and tested against
android14-5.15 GKI kernel, which already contains a version of this backport.

My testing is limited to resume path only; and general phone usage to make sure
nothing falls apart. Would be good to have some deadline specific testing done
too.

Based on v5.15.127

Original series:

	https://lore.kernel.org/lkml/20230508075854.17215-1-juri.lelli@redhat.com/

Thanks!

--
Qais Yousef

Dietmar Eggemann (2):
  sched/deadline: Create DL BW alloc, free & check overflow interface
  cgroup/cpuset: Free DL BW in case can_attach() fails

Juri Lelli (4):
  cgroup/cpuset: Rename functions dealing with DEADLINE accounting
  sched/cpuset: Bring back cpuset_mutex
  sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
  cgroup/cpuset: Iterate only if DEADLINE tasks are present

 include/linux/cpuset.h  |  12 ++-
 include/linux/sched.h   |   4 +-
 kernel/cgroup/cgroup.c  |   4 +
 kernel/cgroup/cpuset.c  | 232 ++++++++++++++++++++++++++--------------
 kernel/sched/core.c     |  41 ++++---
 kernel/sched/deadline.c |  66 +++++++++---
 kernel/sched/sched.h    |   2 +-
 7 files changed, 238 insertions(+), 123 deletions(-)

-- 
2.34.1

