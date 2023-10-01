Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA47B459A
	for <lists+stable@lfdr.de>; Sun,  1 Oct 2023 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjJAGZQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 1 Oct 2023 02:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJAGZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Oct 2023 02:25:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D30BD
        for <stable@vger.kernel.org>; Sat, 30 Sep 2023 23:25:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8673a90f56so13566671276.0
        for <stable@vger.kernel.org>; Sat, 30 Sep 2023 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696141513; x=1696746313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb5Z9z/58eDQL0T1G9xYJwLpZjFH8cLFxZE9cID1oeo=;
        b=NNkhlF4yLLOLB8BcovxtmPCqrEcbd4CIbD2v4bgM1aVdAojBbxtdRSvowRHZRoIWaR
         xY/ExC7obQHMgGmGqhgZJOWtWUJviAWKYoumsY0q3EbkVAHQ0APn4HcKDmKNBQxsiqfy
         GlbqwWQx2/XElYGRZgOCULgF0hlFL5zxRRkhEpkY9Qrkd9l6eb35p6G3KLaljUzrJjQd
         jSiIwI26zKakbTTcZamCtKMiO4nH5VkXMrtZOpXFzlT5FBKtDftFcc7azibk67vjdQZR
         +wLNo5exL6uMH2XE14mbtqa08yAXcpwFeOQdVGrwx/cz9LRLHEUBIlxnacIfDqlqOHLw
         Z5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696141513; x=1696746313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb5Z9z/58eDQL0T1G9xYJwLpZjFH8cLFxZE9cID1oeo=;
        b=NvyTdTbWSoedofhUr9eHiYhc9fn6/XUJ2u6OBMr8VSj583uYLSkJBFFsPYsjCIdeos
         m+1IlOuRzLsbSB5uEGSsM3syu/LRowFvNzc5n0OETjUzj14Ogx2f7eNbw8YBTvK83mNK
         5qQwqvhZ9lRHzWXcZ5DbOpRhku5hRABVd91RTuBfn9PAXjNJy0bOxMfKKNVldhmNyEs2
         8zMS+eoNKVCbVfQZlSpdg0fE7ZjiTtdiHylMRUI1pW3a4p//ykjgPmqc736aF4F8w1Gt
         CFXNPtcI5HvYxcVwJSMfn2ceSeq0+uG1hysmXgzBk58LFao0gnqBmnrzEECh2LFJCa0k
         C63A==
X-Gm-Message-State: AOJu0YwWzC0QQpcV28uVAlg1nAN/ixhQJguibbbEyycB2nlVm9mOJdfv
        GCSrDYNdLxaFCObE+pvcJoiOuAbymAxlSxVkk39Yf2+0
X-Google-Smtp-Source: AGHT+IFddtWtBssnFvy5nB+l6df1dSefbjGjKuIZ6oRwusMehRM48Q9rdrvZNoocnfe1vcJ83m/wCbRFai2NRNBAIgI=
X-Received: by 2002:a25:9c87:0:b0:d53:f98f:8018 with SMTP id
 y7-20020a259c87000000b00d53f98f8018mr6749232ybo.65.1696141512895; Sat, 30 Sep
 2023 23:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
 <2023100121-curfew-remindful-aaef@gregkh>
In-Reply-To: <2023100121-curfew-remindful-aaef@gregkh>
From:   =?UTF-8?Q?Erik_Dob=C3=A1k?= <erik.dobak@gmail.com>
Date:   Sun, 1 Oct 2023 08:25:02 +0200
Message-ID: <CAH7-e5sjhky74KaY9AODvhGrFFu_FeiH=Nc3SR15C-KZWZsVdg@mail.gmail.com>
Subject: Re: bluetooth issues since kernel 6.4 - not discovering other bt
 devices - /linux/drivers/bluetooth/btusb.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

thank you sent it to linux-bluetooth.
E

On Sun, 1 Oct 2023 at 08:11, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 01, 2023 at 07:47:54AM +0200, Erik Dob=C3=A1k wrote:
> > please reconsider this commit.
>
> Please contact the linux-bluetooth developers about this if you wish to
> have a patch applied, there's nothing that the stable@vger list can do
> about this, sorry.
>
> good luck!
>
> greg k-h
