Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3937F18B0
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjKTQfH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 11:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKTQfG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 11:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB51ED
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 08:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700498102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZvczFxIKyKy6D2excjoW9QSNl/x+SIklQ2YwnPNLtE=;
        b=N6SzkD2QNnvW7jhSSL6HGCAkF8WwQa0Uz8NVdWZq/Oxfg2vsFH1Ep3r0pKzuMJ2X15Hu9L
        wpQdk42ES/K/GYfp9I5FjiN2jgCpW9YUJW/XUZndE30zYKajtipUQP7mRsJ8jmY2HnClUw
        31ZjeKRF4xmcjF7AjnTzCqH+m55XnFM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-iLcxUp8vMWiboKASdzNEcw-1; Mon, 20 Nov 2023 11:35:00 -0500
X-MC-Unique: iLcxUp8vMWiboKASdzNEcw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58a276efa48so4357352eaf.1
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 08:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498100; x=1701102900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZvczFxIKyKy6D2excjoW9QSNl/x+SIklQ2YwnPNLtE=;
        b=g9GW/0+C2uRW20DcMeUtHiycAbo5BCr0xwTgEpwItTvXImZbkeX2bJo8zsNsT9F1m6
         Y0MoX8zYRQSkP+HzZ0P8acUTfCLnV3R2dOY6qhX2HdyfVVfZu6k2kKS4w/TfchSZQ+ky
         VHaYiC1OCrSURT0lgozeUmWn6sxIWhxfaEJdwAliDroTKtA1E44e9s+PhNRh3q6iIJsQ
         xB/LEnJBOmzjzuTXTUFycdEn0oTaoExhY9kD4VO5cYYE+GUPqlIVTbXEAXjOsOlz1Ngt
         5akBo8DCfiP2HhfIRXJhbBrpZ7wBiyQVcZL913Y7eZIu9voN8woUPOgIk70N1Blis7FD
         R+sA==
X-Gm-Message-State: AOJu0YzGYZgqR7vI9nSG2jS9cN4rIhmyXu7ddYe3Q3sIcoB8TJvDbI1K
        f7IK4quJ35epM+TQRDmcN/IsEE7FDSk5vqePd46k8ubgEWEZu+8lRnWugoVG67dJCXFzVQW6aee
        F71USvaJcobGAi7i8KPQXDDi/WRVjNqdW
X-Received: by 2002:a05:6358:726:b0:16b:4b12:1842 with SMTP id e38-20020a056358072600b0016b4b121842mr8647505rwj.6.1700498099541;
        Mon, 20 Nov 2023 08:34:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR0FE8SSbDLW3AevgsAwFEu6zOq5yK2N2TwdyzHuvhL6NWib3gECyjA5arteEcU++mTZz2XKREqHBK0HUJhqc=
X-Received: by 2002:a05:6358:726:b0:16b:4b12:1842 with SMTP id
 e38-20020a056358072600b0016b4b121842mr8647488rwj.6.1700498099328; Mon, 20 Nov
 2023 08:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20231120105545.1209530-1-cmirabil@redhat.com> <8818a183-84a3-4460-a8ca-73a366ae6153@kernel.dk>
In-Reply-To: <8818a183-84a3-4460-a8ca-73a366ae6153@kernel.dk>
From:   Charles Mirabile <cmirabil@redhat.com>
Date:   Mon, 20 Nov 2023 11:34:48 -0500
Message-ID: <CABe3_aHtkDm0y2mhKF0BJu5VUcMvzRWSd7sPeyTFCZEFZt05rA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/fs: consider link->flags when getting path for LINKAT
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, asml.silence@gmail.com,
        io-uring@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 20, 2023 at 10:59=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 11/20/23 3:55 AM, Charles Mirabile wrote:
> > In order for `AT_EMPTY_PATH` to work as expected, the fact
> > that the user wants that behavior needs to make it to `getname_flags`
> > or it will return ENOENT.
>
> Looks good - do you have a liburing test case for this too?
Yes, see here https://github.com/axboe/liburing/issues/995 and here
https://github.com/axboe/liburing/pull/996.
>
> --
> Jens Axboe
>
Best - Charlie

