Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434BD7C5F9B
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjJKVy0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKVyW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 17:54:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A5B6
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 14:54:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fb8f60374so5202439f.1
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697061259; x=1697666059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohH/miBpn5ItkKls4R/7tm9vrnVTWoPlqg4hiAS+YR8=;
        b=OQECjdpqT+SFnGPjgr+Cs/tPZJYm3xPF4CkaVWrGKCzdR9HktfmS7jDPFAnPa1dlib
         z+JBc3AzSCA43YtoRrFd3/Y7IGC0z6UM7o4EgRZKvSaY7cIiwtxa5CpM9Zis+LPYTQjs
         85NZ+Idnlx2VJPGSRYl8GZ8KLVqVtsPf9zT15I/8HXQ8v+z0i0B/HnNN0uGZNbJ9LcF3
         w6HuR56Xkb+bXNvKaQ96JNPWpqLy/0q6LD9ClynJXrMtBVeuHBC+zAVOtIzQC+5rsqoK
         V75r0x3/ajG6RUVZIv03OTbMfDdeH80ZR4i/L3+FXbvgIiBcobf8e5sfMBloLzVgS/N2
         qI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061259; x=1697666059;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohH/miBpn5ItkKls4R/7tm9vrnVTWoPlqg4hiAS+YR8=;
        b=AUCTmq3NOvgcj5wrn4KA2MvVVuQSg7W6b29yk11/cY70zlRsDR916Y5C0KKSW/5uEj
         4g9CJdfY/uyNzdUsn6mmomlZePvwezbxVxGrPSoWhggNAGQzc8CdTPC8yoZf/eRUYWu0
         wU/poK5lS9ZEyHirB0XXYdxmNp6B/0cCY7CgVRBkotrbXMkGKQNofMxrmHM1QXp7O+lY
         H0AxGWDJANliHRqTzafu8TuCQxRyvg0h/2mmYKOFEdq1+rorx4SFlF5zsTzmc1nlsbmI
         rOWwhwIndE+eyCCfhyZ4yuxG4CB2vGAGkd+m1OkpXhiPANDVsyVshvU5RH3c01gOVIUN
         9UnA==
X-Gm-Message-State: AOJu0YxxijaPx2garZ7ondf1r85tQhcerUE/k/JBEHZH3xj0KPikiqEP
        ynhWP0sKLKW2WZnfyvwfa2uwvA==
X-Google-Smtp-Source: AGHT+IGJuzmogMZdl+dw5y6weM59oSkgD5rsCk9dv0kBAo7+BDiEekAdHiJtBidspuHNnfP4r3i3mQ==
X-Received: by 2002:a05:6602:3a05:b0:792:6be4:3dcb with SMTP id by5-20020a0566023a0500b007926be43dcbmr23320945iob.2.1697061259360;
        Wed, 11 Oct 2023 14:54:19 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bx9-20020a056602418900b007870289f4fdsm1168180iob.51.2023.10.11.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:54:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
In-Reply-To: <20231011201230.750105-1-sarthakkukreti@chromium.org>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
Subject: Re: [PATCH] block: Don't invalidate pagecache for invalid falloc
 modes
Message-Id: <169706125840.1583104.3695441099284489023.b4-ty@kernel.dk>
Date:   Wed, 11 Oct 2023 15:54:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Wed, 11 Oct 2023 13:12:30 -0700, Sarthak Kukreti wrote:
> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.
> 
> 

Applied, thanks!

[1/1] block: Don't invalidate pagecache for invalid falloc modes
      commit: 1364a3c391aedfeb32aa025303ead3d7c91cdf9d

Best regards,
-- 
Jens Axboe



