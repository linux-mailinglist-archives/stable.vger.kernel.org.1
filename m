Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F370E33E
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbjEWROI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbjEWROD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 13:14:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B9129
        for <stable@vger.kernel.org>; Tue, 23 May 2023 10:14:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760dff4b701so167339f.0
        for <stable@vger.kernel.org>; Tue, 23 May 2023 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862039; x=1687454039;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k88qCVwcZa1f8fNaWmQwZNtP2UmSyRYMW1h4mnpwcI=;
        b=rhdAfeRDbJmV0coNwwtLAWZdVXOofT1UdxJjGXcSRViQbRVuZ8FnUMRC76WPG/9T5Q
         nVoomGNwKzzqo8FayjjsRBuNoPcfRmAuhz9DpozcRaL4sqLVc5TcNW7E6FJCho7w17rM
         I50v4Q7AMpW+5sf5n0sTtGsA8qhmkUk230SGRSovk7kxhOhSws9/XO15Uy80VvpGNBz8
         66FB1k+fZaAUTDB0E/ICHc05RIIbAmUh9ASqfD52HFxrtIbK8fROTXdNDEw3O8osrpJm
         LlI6vzwTjqx6ZIozjW/QP+od+Wd7ybXAhUq+vJy69TttrXxTW2lr9DsK+rwsV5uGvMQl
         ZO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862039; x=1687454039;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k88qCVwcZa1f8fNaWmQwZNtP2UmSyRYMW1h4mnpwcI=;
        b=hvW/Rw7cCEGwS2J2MsUWtnEadXtMfD7TTDU888J6+j21wV5VOVEiph7YeCJ0LuV3qY
         Gisvjrijfhpv9vup0bkk8ply1IPXLlyD3bXo+lQiLgTCXlVXhwqffw5ch2PKFEWusSG0
         Fknj9gyuSvnkQziCP+vmr32bNCa19vXWxFKTP9Yf+L5R0Rt2OHLQNbEMAcsCmO9crfv5
         Vo94aDGv3P/JL84m3z1FFLWpKygpWaDa8YQivCc2GT+u0llrzQwiJPKTyDZ9gspEqR3c
         IHKmL7jK/OWhgNpthqYPfzzpq3NiCd6K2W3naApzanusATtnjuJrSFF0lPEUo88YU7aZ
         miaw==
X-Gm-Message-State: AC+VfDwSomqwVxcEm84ZBnj4H+8fVx5DxAWetrKGiAGFEzE6miZNkhZU
        DWw6Nkpn+g1k6G5fxL/UwPYgVQ==
X-Google-Smtp-Source: ACHHUZ5lI6ZJzmHP2RmyEmRkLyYJRDQQXAZ4tqrkSxq5mRlghLrc9YkfThO9dMuwV0hk2urNFdCKog==
X-Received: by 2002:a6b:b20f:0:b0:774:8351:89ac with SMTP id b15-20020a6bb20f000000b00774835189acmr1406141iof.1.1684862039717;
        Tue, 23 May 2023 10:13:59 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, Anuj Gupta <anuj20.g@samsung.com>
Cc:     linux-block@vger.kernel.org, gost.dev@samsung.com,
        anuj1072538@gmail.com, joshiiitr@gmail.com, stable@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20230523111709.145676-1-anuj20.g@samsung.com>
References: <CGME20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b@epcas5p2.samsung.com>
 <20230523111709.145676-1-anuj20.g@samsung.com>
Subject: Re: [PATCH] block: fix bio-cache for passthru IO
Message-Id: <168486203851.398377.17993706922201051962.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Tue, 23 May 2023 16:47:09 +0530, Anuj Gupta wrote:
> commit <8af870aa5b847> ("block: enable bio caching use for passthru IO")
> introduced bio-cache for passthru IO. In case when nr_vecs are greater
> than BIO_INLINE_VECS, bio and bvecs are allocated from mempool (instead
> of percpu cache) and REQ_ALLOC_CACHE is cleared. This causes the side
> effect of not freeing bio/bvecs into mempool on completion.
> 
> This patch lets the passthru IO fallback to allocation using bio_kmalloc
> when nr_vecs are greater than BIO_INLINE_VECS. The corresponding bio
> is freed during call to blk_mq_map_bio_put during completion.
> 
> [...]

Applied, thanks!

[1/1] block: fix bio-cache for passthru IO
      (no commit info)

Best regards,
-- 
Jens Axboe



