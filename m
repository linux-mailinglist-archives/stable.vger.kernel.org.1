Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F272B533
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 03:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjFLBtz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 21:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFLBtp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 21:49:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5A712F
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 18:49:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b0338fac5dso4154395ad.0
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686534584; x=1689126584;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xus9Jdno3dSYyQj1Y02RRzobrTs+sJiqzjSX1kh0CtE=;
        b=OfipTe5QQuBYY3a7kGYEe3i/tRYJuwD+MjRMZ6tTuxeLCMCp+NmoRImTCFjVlvVdRA
         XQxx1nsmf0YZIW8WgHwdqxVP3Kq2hCstGzs9FPpl3IRKVXuwHjt7wRew+2BGrXyGJ+65
         VLE545UYbMxMvKU+rkhb6hXyzCfeJPrKzyLzisUJ6xJ4WLUuCyYcErCFZ3Bie1eh9Ud+
         cFX8Drmi+ZRuwR5sJX+FXctulqJfGggnPHVULyQRgUDafid+zO7C4MaTFShXrCsZ1Ayz
         zH8ql1Aq1/B4pcAfyuPyhZh90RlchdLIH0rQHM6Pt9pbifFBuxCRuclfXSVXL17UtRFY
         epJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686534584; x=1689126584;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xus9Jdno3dSYyQj1Y02RRzobrTs+sJiqzjSX1kh0CtE=;
        b=ZPlvJwe1crBJHvHie8IVrSquImEFe8y7iYd9EaL2aAieLSnS29bR5EijoEe7FI0cvD
         PAzS68KSH5YUJdjCkseaXtUN9Wj+3Flpjt3Bmmq3z5XMGOkU4cn3RdOGbiZsYhhAeQUu
         awOcYF4/5W43O0ZSrQHad1u8hrM0E27FgHuLG8T+dlAisQDRquY7Sn10MDAJugDzu1y4
         kCcCYjorQnxcB7A0TG2OohfqIJV+OtHtCBEWRgKSb19KgTRMNeYXj7rhzfaZC/mgiLOh
         siQj4tyYBvcNBaFjVJzTCabzdpADHlKUg0jBKRm1buK6l/8WaMAyAC9ImdWRA+Lp88eQ
         qUWg==
X-Gm-Message-State: AC+VfDyvtYz1/iytRLHLmBQhdqqw6g0SXh24eMvh5nK5rzKilMrm/8UW
        ZLNm4+OhNXpjnCZ7vGWuffQKlw==
X-Google-Smtp-Source: ACHHUZ63qohTtWPXlmI/KO02vGFG1A5HuuzA8XxyrEdIQ2ajiyb5iircK2AVLoqOGJRYwSwr9Z6a5A==
X-Received: by 2002:a17:902:e744:b0:1af:b80a:b964 with SMTP id p4-20020a170902e74400b001afb80ab964mr8723912plf.5.1686534584540;
        Sun, 11 Jun 2023 18:49:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jd17-20020a170903261100b001b3cc4d60b7sm884833plb.238.2023.06.11.18.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 18:49:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org,
        Jay Shin <jaeshin@redhat.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>
In-Reply-To: <20230609234249.1412858-1-ming.lei@redhat.com>
References: <20230609234249.1412858-1-ming.lei@redhat.com>
Subject: Re: [PATCH V4] blk-cgroup: Flush stats before releasing blkcg_gq
Message-Id: <168653458323.828509.645185217328655352.b4-ty@kernel.dk>
Date:   Sun, 11 Jun 2023 19:49:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Sat, 10 Jun 2023 07:42:49 +0800, Ming Lei wrote:
> As noted by Michal, the blkg_iostat_set's in the lockless list hold
> reference to blkg's to protect against their removal. Those blkg's
> hold reference to blkcg. When a cgroup is being destroyed,
> cgroup_rstat_flush() is only called at css_release_work_fn() which
> is called when the blkcg reference count reaches 0. This circular
> dependency will prevent blkcg and some blkgs from being freed after
> they are made offline.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Flush stats before releasing blkcg_gq
      commit: 20cb1c2fb7568a6054c55defe044311397e01ddb

Best regards,
-- 
Jens Axboe



