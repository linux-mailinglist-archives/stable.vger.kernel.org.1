Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909B8727FF7
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFHM1i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFHM1h (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 08:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2E1BFF
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686227212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99DxBnaZUEbAqMp4zX7cQ0uWWclnnpqDzA9UnIQbL20=;
        b=OO+xhSGfF2OrMcRPkjs0qnzzSfZy7sdloK9JRRKCn/wtcM7p90GCjLGQCkGXmmU2LTVB5c
        CD8BDyw9Tgsh18h+08eqCYaiQaQnA7wJ6JdDBAOiMbgt4KInvk+ZiOdy8Wn7WhlxqRU9wr
        06eZO/odng/Fj00ZJYHgWRonN5dxffc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-JLh2gwV0NRCO6KQfe9LjDg-1; Thu, 08 Jun 2023 08:26:51 -0400
X-MC-Unique: JLh2gwV0NRCO6KQfe9LjDg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51664cca8dcso620139a12.1
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 05:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686227209; x=1688819209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99DxBnaZUEbAqMp4zX7cQ0uWWclnnpqDzA9UnIQbL20=;
        b=Wzd7GHDl3Qhfuco9Z1hmRPc1uBeQCXPCruB8h37eXQaSFw52R8DhfQv3y8ooD6U93T
         MiRF5NMGFW9KfSwPieWrRtP442kBtiFcUaaKZbg1OKsSDFTzsI2HirgyrwJrTQOrOSBy
         S5LW2RD32tBIuM6c55/5sgEj61u09Kx/OARTKNw3/lrW2WK0EFuli4fFrebDaDFCtJ5O
         0UmoEymd6ASY1Jvo1/R6M4kDMOD7sq8qpP7uGItrMl1N944zU/fwujSIn/kCCLtedMeD
         RX3humctYHndS4k5h2qRYK7lLfTkYAKLZmq7Ovz1f0JjMc+84CWAg+RAGKhXXb+sA5YP
         Z5ww==
X-Gm-Message-State: AC+VfDzAMDbXG6U+x5rD7enb3TBLKvedm8pPYc3GSBFzdERv0zC5nk5k
        Q0hUq3lA+ij+48bntHYmyO5v92tSj3V1sqJDRaYTUhThQS9gQ2Ej0d4dbW/UXo6Gb3Kh/L1J5ZC
        zNBLcvXwUPt73jhF7gZGPAv2B/r9aHupHul5d/Gwn
X-Received: by 2002:a17:907:7d8c:b0:961:b0:3dfd with SMTP id oz12-20020a1709077d8c00b0096100b03dfdmr8924898ejc.7.1686227209609;
        Thu, 08 Jun 2023 05:26:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rIJnxOZ/k6AILEkTqFs3rcnLiGPhtn521OxmI8TJH1Xhui8U5Qn7FhKUXevEAS25sXJIOmzsoLC0PnSe3NTE=
X-Received: by 2002:a17:907:7d8c:b0:961:b0:3dfd with SMTP id
 oz12-20020a1709077d8c00b0096100b03dfdmr8924884ejc.7.1686227209377; Thu, 08
 Jun 2023 05:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230608105821.354272-1-aahringo@redhat.com>
In-Reply-To: <20230608105821.354272-1-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 8 Jun 2023 08:26:38 -0400
Message-ID: <CAK-6q+i1G2r7p2UqFGEMjMwVuJ54=5ukubbyiAxSYEt7gkBzXA@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next] fs: dlm: fix nfs async lock callback handling
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Thu, Jun 8, 2023 at 6:58=E2=80=AFAM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> This patch is fixing the current the callback handling if a nfs async
> lock request signaled if fl_lmops is set.
>
> When using `stress-ng --fcntl 32` on the kernel log there are several
> messages like:
>
> [11185.123533] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000=
002dd10f4d fl 000000007d13afae
> [11185.127135] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000=
002dd10f4d fl 00000000a6046fa0
> [11185.142668] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000=
002dd10f4d fl 000000001d13dfa5
>
> The commit 40595cdc93ed ("nfs: block notification on fs with its
> own ->lock") removed the FL_SLEEP handling if the filesystem implements
> its own ->lock. The strategy is now that the most clients polling
> blocked requests by using trylock functionality.
>
> Before commit 40595cdc93ed ("nfs: block notification on fs with its own
> ->lock") FL_SLEEP was used even with an own ->lock() callback. The fs
> implementation needed to handle it to make a difference between a
> blocking and non-blocking lock request. This was never being implemented
> in such way in DLM plock handling. Every lock request doesn't matter if
> it was a blocking request or not was handled as a non-blocking lock
> request.
>
> This patch fixes the behaviour until commit 40595cdc93ed ("nfs: block
> notification on fs with its own ->lock"), but it was probably broken
> long time before.
>

mhhh, this patch only removes the book keeping of "cat /proc/locks"
and when I am observing it I don't see fcntl() locks when using nfs
with gfs2 under locks there and this is the issue here.

I need to investigate more into this.

- Alex

