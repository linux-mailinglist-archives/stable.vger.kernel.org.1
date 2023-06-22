Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2640473A21B
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFVNov (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFVNo2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:44:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA981988
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:44:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b5585e84b4so7179045ad.0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687441467; x=1690033467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QEGc8CR8Pr3tGbaRgcTsNieSj5VRjsvAYuAbzW8HS0=;
        b=tq6w5OMU0L4RQ9dzRtj0tmzqHRwBRWRVZFk9zSgLdBFCIV6g55ifYj7/P/+ho34gwR
         RkrM/nPm3K4wpyk7mYq8w2nhqciuLYxlF+mBlWh78w4Pnn3rI1nXvSQUGHeZSrCoQH4M
         MsQvuWueYuHGR2YKGokn8gvk/5WqDqxNMauymUheLYG866EvEnkEmL9tQi2RjLV3l1Wb
         VVww4JYsNEoYmztarA+Rv65GLc8+AqrgGccyKoGcfh+H9FKRJkCofR8GUtkh83Tt9OZy
         lL1fMO1KzGHjGNp7fBtXcbqfNEKx+lgkUqRy/7pZwXNdr5Q/iDNGR/Hh853Pusts7vIm
         sLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441467; x=1690033467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QEGc8CR8Pr3tGbaRgcTsNieSj5VRjsvAYuAbzW8HS0=;
        b=MElUXiRdLrcBQ6KGDAp3RZdDRiC0D3+jOSj4pi4mPV8uu8jA9jEkTbpJsc41yZx3HM
         LqgDtWuzzP7a1CGLXoUuBQb3XBXA1qW8FpKLfgDcUoPQ/5ZHb935vcpJTzUk7HzOf/dQ
         kPB0ADerWs56wQ4F1ipfphNJPCY1/JKoSdGG4Jy7lRzdJLYKJ8ZvQMkqsLrlBfAffPzA
         STQU4H85G5EYu8JaJHWhSnlBQUVIerA0R1rGHQgoTtHdlKv989dxQ49pIBecGlUZF3wc
         m1fCAbjWdP1i2g7O+/YV52Ce6Jz1TkpR9YHeRoufRHHg9VeQPpQo820MrJPa5k9Vyv6V
         V3PQ==
X-Gm-Message-State: AC+VfDwsLyk2QA7RmSqmsC4Kik3Akn3a2Wap1JE/BTBEAP6tu3JBzmLQ
        if7YFqS5MzVXJCC2f3IPI/Ld5OziHsiI08uQnXU=
X-Google-Smtp-Source: ACHHUZ7MuI033/q1hiq2rZL5zOhJ5uEVN2EXEgVqsBGscpxKBbpBLJzo9J+KZvRGD0Sxrp0CYyMdzA==
X-Received: by 2002:a17:902:d509:b0:1af:a349:3f31 with SMTP id b9-20020a170902d50900b001afa3493f31mr22463387plg.3.1687441466837;
        Thu, 22 Jun 2023 06:44:26 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b02bd00c61sm5387559plg.237.2023.06.22.06.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:44:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
In-Reply-To: <20230622084249.1208005-1-ming.lei@redhat.com>
References: <20230622084249.1208005-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: make sure local irq is disabled when calling
 __blkcg_rstat_flush
Message-Id: <168744146523.13052.8013072657538410475.b4-ty@kernel.dk>
Date:   Thu, 22 Jun 2023 07:44:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-d8b83
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Thu, 22 Jun 2023 16:42:49 +0800, Ming Lei wrote:
> When __blkcg_rstat_flush() is called from cgroup_rstat_flush*() code
> path, interrupt is always disabled.
> 
> When we start to flush blkcg per-cpu stats list in __blkg_release()
> for avoiding to leak blkcg_gq's reference in commit 20cb1c2fb756
> ("blk-cgroup: Flush stats before releasing blkcg_gq"), local irq
> isn't disabled yet, then lockdep warning may be triggered because
> the dependent cgroup locks may be acquired from irq(soft irq) handler.
> 
> [...]

Applied, thanks!

[1/1] block: make sure local irq is disabled when calling __blkcg_rstat_flush
      commit: 9c39b7a905d84b7da5f59d80f2e455853fea7217

Best regards,
-- 
Jens Axboe



