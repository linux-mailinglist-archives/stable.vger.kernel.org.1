Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2270E7DE647
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 20:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKATLg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 15:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjKATLf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 15:11:35 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC217111
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 12:11:32 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49e035bdca7so66554e0c.2
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698865891; x=1699470691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nDwpXVjvwIgDVe2FBcBp2oPwP+wRbGqRCDZZEKkbOWY=;
        b=wCmNJhMGxcm4AxIPcSuup1y3Tj9wxT0qEW42Sj33Qp9aeBaTOwKVCUG/Hy5LODopXa
         +qxqxbk9rta5YUxN/emMG8V0PGHj0PKIt+7s+KVv54XLhviBF08Rx3vmhMfHqwlI2Esc
         UGtHrGNves4qBk/G/4Y+wASIJAvffINY3wvZ/Y7fRqSq3dZnjFO8N9x8Tl08ueLkijy6
         X4chWy8lt1/fgOE2ZRbO59DEZjap/f+3i8TTnkiOPfwbAOYCJ4mhCup1tsk1nTv2rgdG
         gBpeRN9ufo87uSKr1ZkuVvdGC4Tp5xj+Cld9IDSQnvbh9MMLEwKtrxgBxKzINwoF7avj
         rOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698865891; x=1699470691;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDwpXVjvwIgDVe2FBcBp2oPwP+wRbGqRCDZZEKkbOWY=;
        b=tvQnUDwkvtOTd0Q73TRWmgeanyy8pYtJTeQB3ecwZkcqFVAk4mf7fHVsOEKb7iLbgG
         S7tEsU5CJ8GEfoLdax+OF6Vv5NNfzOztiHJOpi+2yEuZj3G3OwQRUVD6cZfhQyT/7RMd
         oivC9dqf0DiOMGHdVI6ZTHzZt2Xn5INXWm7hg5h+cvUcvrZ6KDZFpGj7LyYOXEWYuUKQ
         TQMOOzTWZ0V2hz9fMGkPsv6FKdbH5Evg4Q0KgrttRkj60OOG5jDzYEQbwr/ZCDZgDTiM
         MfaYPPBtOKGnO5w7aGUGj6VDLHYJ16ye/zQH0YSw8EuRX+uYjSCW6QJ0dDHM35Y5oRlb
         ge+w==
X-Gm-Message-State: AOJu0YzkGdoK7zS3boi13c3B11q5A1c8fNVDZyjcj/olTnOFexDbAG35
        Z7uvDN+hUoGXJ0oTKM74Ihw9giQiDhL7zvIG190bZDJep9nsPF4zu8V6Ig==
X-Google-Smtp-Source: AGHT+IHOWTNAHIGwuJt13KZHt26EzjdtDoYpLoCwyB1lsB7TO391CFpW9P9slLmgswzLHpkPW99MFPfEFZGh3u5QrLE=
X-Received: by 2002:a1f:17cf:0:b0:49a:6742:b176 with SMTP id
 198-20020a1f17cf000000b0049a6742b176mr13651024vkx.16.1698865891528; Wed, 01
 Nov 2023 12:11:31 -0700 (PDT)
MIME-Version: 1.0
From:   Mingwei Zhang <mizhang@google.com>
Date:   Wed, 1 Nov 2023 12:10:55 -0700
Message-ID: <CAL715WLTjMGQrhm6wWqFSeL_Oq-HzoQd5CqewvLRLv0Xbnibgw@mail.gmail.com>
Subject: Request to backport commit f9cdeb58a9cf ("perf evlist: Avoid
 frequency mode for the dummy event") to stable versions of Linux kernel
To:     stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

Apology for any inconvenience. This is info and justification for patch.

Commit-id: f9cdeb58a9cf46c09b56f5f661ea8da24b6458c3
Subject: perf evlist: Avoid frequency mode for the dummy event

Justification:

This patch fixes a critical performance issue at perf-tool level for
anything running PMU in a virtualized environment.  Majority of the
justification is within the commit message. The only thing I would
like to add is that this patch could save up to 50% of the vCPU time
when running perf in sampling mode with a large number of events in
the VM.

Appreciate your help.
-Mingwei
