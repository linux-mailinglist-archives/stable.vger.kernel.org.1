Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8E677007F
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHDMs3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHDMsX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:48:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA14C04
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691153230; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fPPfv7Wf/FPOe0PdLkcNWUDqB504GCex5b6XdweL4YxnJv+RFTy4CwiRsab2hEgo/L
    es3BMNAc2VeihGIszGXKR4L7dDPDX9mg7cCIpPki0BjjqFQEuuxdwTT/0uNJWF/KK/rN
    HuEZ1S98YS+p+rnr8OULRTSi8+/Uymuinq/pp6n5fUGIOfrygdQY4a31VmSD1wkN5cYP
    KXhwQ/MyqXFkOS2l0LwCXL4gOUcPFyNzBRudAk1NMrY8kgaTAvQBjXRUTS+8hPxt6bmZ
    ZhHbqf5F81dYQkZ7a8SpjNRl2kD3P2wQDseDluqln8M1Bs8gIPL2KdUIeJZ08k+Q6dz4
    TABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691153230;
    s=strato-dkim-0002; d=strato.com;
    h=References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9EYPZh3bK4/rfwAilTxfULasm0qSCr/n1iUN2yQEIqw=;
    b=ODI6w+7xrbc1jEyW1ONt9mGBMp9KjaXKL5ffdUkSVo9d2yQaHChirp30CJu3CBvGUE
    9HmBtNCMoFtU8EEKcrx1exVtasMuv3z2Y1w15Ii/X+zVPP9Psv/jeTPe8Br8LeoatpEo
    n47unxX1OU6e6d8BWzp5LtTuwYfOBgXjHRCpeqtpYnfYg9Vqt5sP96DGLLyTHcAGIUSK
    Mh0EUo2PAPrs0zdIA2SK0/PHwbHFo8qkOgvbwRJF0SeNWxdQe8LAC8ekGc2HV70ULHuu
    Dihv6z/GtdjVGxi8KaHjcKnj4fpf/N9NZ99eGgKQVdgybuqKiJEYZwKuTpa85SI7htZh
    6aKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691153230;
    s=strato-dkim-0002; d=kravcenko.com;
    h=References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9EYPZh3bK4/rfwAilTxfULasm0qSCr/n1iUN2yQEIqw=;
    b=TqP2h85NJh2aEUoJOlpNH4jD4fVeXC9Q6PdsyJuA/BG7vvkQCKJrfA9Hcfy9G7Ay7R
    /I6a3O5rvESDswGGPi7vz8RSM9d0osvWgtrYqy8oY4Ym7r40oYwH8tJLm4uKqziyIhQp
    vqk5El8IZEpNO62k/kt7Fsub/ClLMmzMjH9FBHWswEinm6q2RrP3vDDDMN90IpBxhd3d
    dGwSSrkPrgTwcUbxbLDyK9x4fZGz5Z5Qlc4oslNa/OyvH0ay7RyqHbVKSFUE1AO08Dso
    fZhb751cJoUjZs+mI0PZIZdCywMeeKUCJH8shC5+gXsA/dQnmFmCl2UzfVJ/6awrbTVt
    T0ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691153230;
    s=strato-dkim-0003; d=kravcenko.com;
    h=References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9EYPZh3bK4/rfwAilTxfULasm0qSCr/n1iUN2yQEIqw=;
    b=HDQWQS8l+d70MoVSgEaj3hlj6tipBNWp3rmySPugmybXsoFbfiuW4pdizNDCMZWTJW
    RkaT62lHLgj7q6st+NBQ==
X-RZG-AUTH: ":I2AFc2Cjaf5HiRB0lhnvZ9elhwku56KjVuxY6AZJWRy8C0aEhFGbVIvMVnbXlOZqFTX/PnlW"
Received: from duane.cam.uni-heidelberg.de
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id dd2654z74ClAWsx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 4 Aug 2023 14:47:10 +0200 (CEST)
Date:   Fri, 4 Aug 2023 14:46:54 +0200 (CEST)
From:   Olaf Skibbe <news@kravcenko.com>
To:     Karol Herbst <kherbst@redhat.com>
cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        1042753@bugs.debian.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: nouveau bug in linux/6.1.38-2
In-Reply-To: <CACO55ttcUEUjdVgx4y7pv26VAGeHS5q1wVKWrMw5=o9QLaJLZw@mail.gmail.com>
Message-ID: <0a5084b7-732b-6658-653e-7ece4c0768c9@kravcenko.com>
References: <20be6650-5db3-b72a-a7a8-5e817113cff5@kravcenko.com> <c27fb4dd-b2dc-22de-4425-6c7db5f543ba@leemhuis.info> <CACO55ttcUEUjdVgx4y7pv26VAGeHS5q1wVKWrMw5=o9QLaJLZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 4 Aug 2023 at 14:15, Karol Herbst wrote:

> mind retrying with only fb725beca62d and 62aecf23f3d1 reverted?

I will do this later this day (takes some time, it is a slow machine).

> Would be weird if the other two commits are causing it. If that's the 
> case, it's a bit worrying that reverting either of the those causes 
> issues, but maybe there is a good reason for it. Anyway, mind figuring 
> out which of the two you need reverted to fix your issue? Thanks!

I can do this. But if I build two kernels anyway, isn't it faster to 
build each with only one of the patches applied? Or do you expect the 
patches to interact (so that the bug would only be present when both are 
applied)?

Cheers,
Olaf
