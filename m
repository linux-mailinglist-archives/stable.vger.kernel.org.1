Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41D67CBAA0
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 08:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjJQGNl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 02:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjJQGNl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 02:13:41 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6781B0
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 23:13:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso45962731fa.2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697523218; x=1698128018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PrU5F1bkeMRXYqVBf2Cia9LhULD3R/o5tbScjMTV1EE=;
        b=A3k9Sz59vkGpN4V1/Ym2EFfdP3wjxIBGXzuyPtzH65ub3PnS37WkOAR4c0LKo5RJwZ
         zdJTHbWU5beJg3pZ7+mRm/ylYDHE4qKF0TfwK4km4SLGsXAyllwPY/3HPR/8Jh6mPO05
         JLBIVZR+0X+nqVfPisVmg/qj4i2/tPs60YlYkONHWAP63KGRARUoVCHEuPdkUkQnu/+d
         ADKTjOCSBoXtUiRCTcI4Kjly3ZNuZpxAaUofQa8hYDbTaEd3ic2HMqrf6+FrxzRmzslz
         cyoAFa084tyClUZDFWsFdSUsx4ShfP6NTPiB1hgAMzee5i4DfdvAjnfH6PNhGbYuP5Ke
         ypQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523218; x=1698128018;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrU5F1bkeMRXYqVBf2Cia9LhULD3R/o5tbScjMTV1EE=;
        b=Rv6uOc8v8U0An/3YYxbZvAz5dVHEY8i6quW00Kr4CNdoFyf9QoZ5JoIf5IZ2M6uYFX
         405hFcgt0OEWYZpCC/3flTE6ZpnqrjbDBhe3FcxY0+44x79zPPfYh1Bu3naYpZkH5Nqv
         mVw1JT2ClcXuALl6Spko8MYTOtLxeVb33LIp1itV2QhgUU/CUTNRbXWvutSvBrqQ2Usa
         izuQ/KOe6/wQPxGYAMS6i23m1N1wdTfYO1XmgH+h52GOPT2dnUSC1ERa57DDubVq4bSF
         hldpeDrUFj8LltvUKFuH1I7Q0W+vxJPb0BBvnKuaa6Cg0bEQIpyvrWJaZf7XQx65dkr0
         yN8Q==
X-Gm-Message-State: AOJu0YzprGZKrneJ6Aa4v8mP/7LG0q1k6oBKOHRe9OIcnzyOO7Tux1OR
        EqS/niX1vDb4OU22gEMck6i5dGEBN8rouJv1s7M=
X-Google-Smtp-Source: AGHT+IFzgW6u6TtjDdSph95Upq8dw97wURcnv9OuHYddB3zyqXzRhjQnpvdxFBpbTt+PQYDOxPppivyPzvvLZQADLr4=
X-Received: by 2002:a2e:bea5:0:b0:2c3:c75e:18cf with SMTP id
 a37-20020a2ebea5000000b002c3c75e18cfmr1090897ljr.0.1697523217484; Mon, 16 Oct
 2023 23:13:37 -0700 (PDT)
MIME-Version: 1.0
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 17 Oct 2023 11:43:26 +0530
Message-ID: <CANT5p=rReboKPbEySnZsFAn8Zv2ZzgQQ8LhyTxkt538QgyxB7A@mail.gmail.com>
Subject: [request for patch inclusion to 5.15 stable] cifs: fix mid leak
 during reconnection after timeout threshold
To:     Greg KH <gregkh@linuxfoundation.org>,
        Stable <stable@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

It recently came to my attention that this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=69cba9d3c1284e0838ae408830a02c4a063104bc
[Upstream commit 69cba9d3c1284e0838ae408830a02c4a063104bc]
... which is marked with Fixes tag for a change that went into 5.9
kernel, was taken into 6.4 and 6.1 stable trees.
However, I do not see this in the 5.15 stable tree.

I got emails about this fix being taken to the 6.4 and 6.1 stable. But
I do not see any communication about 5.15 kernel.

Was this missed? Or is there something in the process that I missed?
Based on the kernel documentation about commit tags, I assumed that
for commits that have the "Fixes: " tag, it was not necessary to add
the "CC: stable" as well.
Please let me know if that understanding is wrong.

Regarding this particular fix, I discussed this with Steve, and he
agrees that this fix needs to go into all stable kernels as well.

-- 
Regards,
Shyam
