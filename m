Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9025B755F85
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGQJkk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjGQJkM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 05:40:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7112D40
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 02:38:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so91055e9.0
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689586702; x=1692178702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F7xH44pSR87wfHmzN8XeGaLUNitnx7cNk83gCctcXI=;
        b=xw8RVI04szkgflTVWnQRKDa9wUGmZ/JBcWesiMgT2NfDFQLSsU60ki8SfUyopcdTQC
         PAnZq8QAoD7h/prMIBUAASkFF2W140GwWuKRwqvPlnff/FQZJUCyIfos3GeimJrCUodM
         X6KArsOwZkTUb0zITNwsZWOx3eIwd9wbYytrD6aqdhCjUCQpDJcKoOAcAZ+D7zowN4AB
         hU0fMWm89/NqE0gtfaXS01Ika/PEXkKbpEG/E6Gvhy5GlVRt12NwQ8iOx9cYzrv+pOY7
         5NGNS31pXWAxgEd5OEGEg0x68+KdZGdHoti38A8GFA2G1SSMVWXLB+duVJ0zuHxN4Uhs
         uonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586702; x=1692178702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F7xH44pSR87wfHmzN8XeGaLUNitnx7cNk83gCctcXI=;
        b=ACT6SmmSdJ9K1uvcjMfxa/JT22zTSPHHn7pto8MJtGbufZ15i3i6kUTZ4QVsL8jyWP
         Ge9C32XRVLo0UbRvmm4PNJovjyWqdQYPopN3G5ZxOLeUzwahhIAbfFIryjneqXYV2v0F
         DXjPsSpPcMAmRNlpiBKiijlnwVMTWGqOLPjTTrqMJrYbdzi3l+pngzvoUQjvqvwcF3a4
         SgIjmzyKK+BdsBTwsas+5gkyR5mgW+U3fW8NbIv+NL6XC7QKsT8MXmud6JA0PDqkbWsD
         W6RRglMpCgQRWc7VwbmKCqZ8/YX1dXuTIinxGHTFW5NYHkcNWfqGUsdyahDRRzDUTGBg
         swzQ==
X-Gm-Message-State: ABy/qLbLWdfpJTWCvEiJLXPvvZYULwTFDqo6r2xnZYJgrrskxY4ouCGr
        9GXaMAW/A2KSBIXVe59iYkeggTg6OhiUhzuvnMez/0+n6sDXlkLZfVJL3Q==
X-Google-Smtp-Source: APBJJlGHW/Qv5Khx6X8f0EXb59wLIOeX/dp7w3Z5fDxgO4myiQrv7V1DWnmYOh2S5xO4nFa69cjDTGDzn7/DVOibBQc=
X-Received: by 2002:a05:600c:8609:b0:3f1:73b8:b5fe with SMTP id
 ha9-20020a05600c860900b003f173b8b5femr482464wmb.3.1689586702548; Mon, 17 Jul
 2023 02:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <202307170435.p9l0j6zC-lkp@intel.com>
In-Reply-To: <202307170435.p9l0j6zC-lkp@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 17 Jul 2023 11:37:45 +0200
Message-ID: <CAG48ez0mT5KYe1=Bd0YHXvaM8a5OF_5OJOnF7jO1nmMteDvZMg@mail.gmail.com>
Subject: Re: [stable:linux-4.14.y 4549/9999] drivers/android/binder.c:3355:
 Error: unrecognized keyword/register name `l.lwz ?ap,4(r20)'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        stable <stable@vger.kernel.org>, openrisc@lists.librecores.org,
        Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 10:20=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le.git linux-4.14.y
> head:   60a6e3043cc8b918c989707a5eba5fd6830a08a4
> commit: f40f289b96bf856e1613f17bf9426140e8b89393 [4549/9999] binder: Prev=
ent context manager from incrementing ref 0
> config: openrisc-randconfig-r002-20230717 (https://download.01.org/0day-c=
i/archive/20230717/202307170435.p9l0j6zC-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230717/202307170435=
.p9l0j6zC-lkp@intel.com/reproduce)
[...]
>    drivers/android/binder.c: Assembler messages:
> >> drivers/android/binder.c:3355: Error: unrecognized keyword/register na=
me `l.lwz ?ap,4(r20)'
>    drivers/android/binder.c:3360: Error: unrecognized keyword/register na=
me `l.addi ?ap,r0,0'
>    drivers/android/binder.c:3427: Error: unrecognized keyword/register na=
me `l.lwz ?ap,4(r20)'
>    drivers/android/binder.c:3432: Error: unrecognized keyword/register na=
me `l.addi ?ap,r0,0'
> >> drivers/android/binder.c:3555: Error: unrecognized keyword/register na=
me `l.lwz ?ap,4(r21)'
>    drivers/android/binder.c:3560: Error: unrecognized keyword/register na=
me `l.addi ?ap,r0,0'

Probably same issue as
https://lore.kernel.org/oe-kbuild-all/202010160523.r8yMbvrW-lkp@intel.com/
? That thread says the fix is
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/a=
rch/openrisc?h=3Dv5.9&id=3Dd877322bc1adcab9850732275670409e8bcca4c4
, and it was then backported to 5.4 (as
a6db3aab9c408e1b788c43f9fb179382f5793ea2) and 5.8.
