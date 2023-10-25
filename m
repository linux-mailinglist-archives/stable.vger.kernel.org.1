Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE7F7D5F08
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 02:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbjJYAXw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 20:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbjJYAXv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 20:23:51 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C9118
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 17:23:50 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-579de633419so51229807b3.3
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698193429; x=1698798229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLbK6nBug5JnUDCMy21slx8tvMmSSuQRyeHYO02LHog=;
        b=iopFP1gbiiga0/vMH714/o5wfZuScWOT+dp3BGWSpr+bEJrglXcBaWiXgIKMRoHM9o
         MgoC5AeR3AmqMrf+eARFY4RYd6B7M9HxuO3hQl9JjIiXADkUc/ezfBOP8ZZqc8NebO/h
         005rQX0WgH4oiV7sHvowN+GRvJQrLbf4c2l8F+S0ys24fBj4rZtWZjRQmvx9A3EICP1L
         W3ditxjUpuESBUWK6syaUNMWiMnx6b/ZjwpH41ksk8/dJddqSgNvaEBdbW70/OF2ji8A
         NiqpsHfD1XbnvmdDfaBh/Q9VRTlXnWvVHicLzP2ZE87+5l4HsojdVvFwdkvMgWoTPuTD
         OlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193429; x=1698798229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLbK6nBug5JnUDCMy21slx8tvMmSSuQRyeHYO02LHog=;
        b=tEwPwKx9Gcd9510FJOQeuw08OyyyfRCLKZT/JHCoT/QjuK0TSWFQEdJy2beWrv8Whp
         8tFhO47LjmYkh823Bo081almgRHFej9IsoNIbraJ+H7E9oEhP5StEA5rlF2uJ7kyt+2m
         U2CbIX5AbnuoROi6MQ9dJyRqg09skpzrKKMqQty8/CJWerZAvy6Z59BVWScSVsWocdQ2
         UsyLdzMBue7+dgPfbRwi44PDiNcVtRid45ndwtaTjqD7lHKvMOvXVqGSx3UcRQqw32B8
         O4F8wpRE8LuKf3E2CRHZp7sYDMhD93BM8Ygo8lE8y7i6Wk7GMilXYZkKoqOxFpaQ1dXD
         4EqQ==
X-Gm-Message-State: AOJu0YzcZ0q0MP/rvcHNBvf9HyCrrHapzfICXlG9tA9Qw86QQYL8QkVR
        QXjQ4p+X6maDwL8L6yiWDU0yJ7hT18n4rn82tWU=
X-Google-Smtp-Source: AGHT+IEqcJP3dl9ct9mkQgXzpHxX0DAOHNdLhyL/zr+Kp7DnFTdG1s6vhEf3RK6lu9+jrC+WYAChluTOmPIZvllRBF0=
X-Received: by 2002:a25:b19a:0:b0:d9a:4d90:feda with SMTP id
 h26-20020a25b19a000000b00d9a4d90fedamr13637704ybj.62.1698193429239; Tue, 24
 Oct 2023 17:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <2023102132-relay-underpay-845a@gregkh>
In-Reply-To: <2023102132-relay-underpay-845a@gregkh>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 25 Oct 2023 02:23:37 +0200
Message-ID: <CANiq72ni+183BNVi45Odx60E6N5n=wxZd2NY6HP+36xOiV1mGQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: docs: fix logo replacement" failed
 to apply to 6.5-stable tree
To:     gregkh@linuxfoundation.org
Cc:     ojeda@kernel.org, a.hindborg@samsung.com, benno.lossin@proton.me,
        stable@vger.kernel.org
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

On Sat, Oct 21, 2023 at 10:19=E2=80=AFPM <gregkh@linuxfoundation.org> wrote=
:
>
> The patch below does not apply to the 6.5-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

For reference, this one got applied later on by Sasha/Greg for 6.5
(thanks!) by taking the Stable-dep-of: cfd96726e611 ("rust: docs: fix
logo replacement"), which I tested.

Cheers,
Miguel
