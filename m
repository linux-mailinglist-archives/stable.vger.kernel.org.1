Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F877C9AFD
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 21:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJOTUP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 15:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjJOTUO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 15:20:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021CB7
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 12:20:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so38600555e9.2
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697397611; x=1698002411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GofQLZWTi6FbZHWXBIt+6WRQsgJYYQDRGNXx0VI/oQ=;
        b=Ty7pRhCVTZ//GRaaFpsRMDSZnGEU6nvsCPp7qXZiTVjAQ281Q0XJZVI0cZO2wLAvS3
         02h/vRDJGrsMIno5aUOIMJIxissijoUTg1rPgcDHJqutDp30umfWa5DFHcU2YGAlOEYO
         WDQBsfG9rG8fUF8DiL0HdxZ+d1kUBmnggbjBlxG7NJm0d7rlMLzHWm0t+kd0orflao49
         CLRhI5TZCSmM9wCQZDPu1CN35P+yhVObJ372OUbdHPTqHHEuypUu2DWRy50Tgzj7poiq
         vilV+b4NphToxtEKMl/Y7JRgC8jkVdUoQ5NsxI51/qp9XulZ47KEKdRcKDer7aqgqyJ5
         ml3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697397611; x=1698002411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GofQLZWTi6FbZHWXBIt+6WRQsgJYYQDRGNXx0VI/oQ=;
        b=GzhvWfdykqrf7DWc2Hs94+OUz7DDSNBuUgfJwE8XCE0ygVyZPRPxwJT1BE1wHn7qib
         16HcqVnV1WuFP5A6cH8pqTe1FXJAPYC6f0FmGsMSv+M/cTGNXBnpwE/MIBXxMwEBR2gg
         kHKKQ7SBb9HR/uEKnYcP03ugIMFoeI50EoTo4HDy62SJYs8r9G/Gk1dRFJtZBuwWmXNT
         mjlz516sthoJJMUIKkFzlR6C8b9CUwit1nl6WVycL6SrPskddXja/8cGPhNyBgttLI6s
         +gcTOi2/IaKYGtgiH0NC6F4vxvG3AghSC0BqKtnUVSzitabCzLsrnaNG3LK3ynex3jWi
         DVQA==
X-Gm-Message-State: AOJu0Yy354Pq7NVr34OzQ+u1ughs03r+dFMR2htiVOB+EwJoo3hWSli9
        r3CGti8Hddd/NVrEA5x+9iKu33I6yu7hGID0M7Q=
X-Google-Smtp-Source: AGHT+IEO6jRQY0jXh4Tku2XP4+Z/ER8upt6B/6W1/9HjOIaH5cul61iotiIWNzdCVUPNTj0udX4pcEQ+I6aneunUQ2M=
X-Received: by 2002:a7b:ce09:0:b0:403:b86:f624 with SMTP id
 m9-20020a7bce09000000b004030b86f624mr27452222wmc.23.1697397611251; Sun, 15
 Oct 2023 12:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
In-Reply-To: <20231013154708.GA17455@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 16 Oct 2023 00:49:45 +0530
Message-ID: <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 9:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> The main limitation is that the device needs to support SGLs, and
> we need to as well (we currently don't for metadata).  But for any
> non-stupid workload SGLs should be at least as fast if not faster
> with modern hardware.  But I see no way out.

You may agree that it's a hardware-assisted way out. It is offloading
the checks to a SGL-capable device.
I wrote some quick code in that direction but could not readily get my
hands on a device that exposes metadata-with-sgl capability.
That reminded me that we are limiting unprivileged-passthrough to a
niche set of devices/users. That is the opposite of what the feature
was for.

OTOH, this patch implemented a software-only way out. There are some
checks, but someone (either SW or HW) has to do those to keep things
right.
The patch ensures the regular user cannot exploit the hole and that
the root user continues to work as before (Keith's concern).
So, I really wonder why we don't want to go for the way that solves it
generically.
