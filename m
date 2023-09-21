Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0BE7A977D
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjIURYe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIURYP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:24:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD737BEF
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:13:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1204392f8f.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1695316398; x=1695921198; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PImsx6KWbNqeW3aSQcC5Ii8dPWKbRVigN6bpHRAR4iI=;
        b=SpuTYjjfufihzbKpfDT09ZpOVv7Cky3O7Aom2jJ/Ze23kJnLUJIQwFBlprBoeuzInG
         NtZqVoavMN0EFj7Ive6jNYQSljKAB46JWtgxSZ7JtlLKSC8V6I5m+OEDtOL0BwxESd9V
         xhhejNVTFnCryQzG7uVFmbQxPefMGiPKJfmoBzy+SnNGBfsZH90IdwTxC7g5Hh4BAylo
         xEQQZ/08OjANUwx8WVsHfFBnwVXaN2eF7ibBK1MtvBVrGvNDEwVQrBSXUMSlYwd3o2Gv
         9w0HxwdwTK2oW+ME6RmdzWd5KfPyoQjAGiARP73AnH2aRpL6Va2BLwvvB/xSXGXFInYT
         xVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316398; x=1695921198;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PImsx6KWbNqeW3aSQcC5Ii8dPWKbRVigN6bpHRAR4iI=;
        b=neYwn+Baruc00RgbaKW5ZQBCkNlOIuXnBkBrOxT3aSFy12HVN4u3r6FfxsoMM1u8Ql
         enAYV+MdO2ROdURkUBQ3l5iT6X4Ut69hXJ1wBic6cUs/G+bVjfzTDI9jmTK9Xr8fk6b7
         +zEznfyh+QrUGWbM+tSYqt7kl69XgKV1yRdoovNnHcPEMGfdphCt7qk9o3Yuz62V+prj
         BiYzcrHPFE35jP2PBFd7KjY/7fVq0IssvwQzD07mYRlQmACHuoy30mwh5ORQ76/X+hpG
         AU/p78NVyHqsAlD/ZO3DK5NmJpDB33oqGWHEgExthy6pbp7MNNjPUe4bVKWslK9KF+eK
         qbug==
X-Gm-Message-State: AOJu0Yz2JNPIOhUkKuJ1gFleq8aYbBDC6qKxaH0kGiZm/kOez0Ros5aA
        fwhY48XxDInLJ/E5P7Goq0M4f1W0v315tWtfxtC+QUAAhKCB+nKlPw==
X-Google-Smtp-Source: AGHT+IFl+eP0H2PDCxlqQpOe2LDiAdzem0Vet1AdL+OxBmXcP12GPV6P5bL+gRXHdK1uYNaJH8PE9PebIIyY/Kq9MCk=
X-Received: by 2002:a05:6512:617:b0:500:b5db:990b with SMTP id
 b23-20020a056512061700b00500b5db990bmr4609070lfe.47.1695300086936; Thu, 21
 Sep 2023 05:41:26 -0700 (PDT)
MIME-Version: 1.0
From:   Da Xue <da@libre.computer>
Date:   Thu, 21 Sep 2023 08:41:16 -0400
Message-ID: <CACqvRUbXK3gNXB5me0OvWy2qkyHU22JjBZaJ8Sxm=KJd8gzM-g@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Soft reset phy on probe for host
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Thinh,

I can confirm your patch fixed the issue on RK3399 when I was running
on Linux 6.1.54.

I'm not on the ML for this so I'm sorry if this email causes any issue
as I'm not sure how to reply to a thread from a ML I am not on.

Best,
Da
