Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20A17A8360
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjITN3A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjITN27 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 09:28:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA691;
        Wed, 20 Sep 2023 06:28:54 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-773ac11de71so372087685a.2;
        Wed, 20 Sep 2023 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695216533; x=1695821333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIWgxY3/V9YOuv89H/HAnhBGBkq4ee0D61xCeXLJOwc=;
        b=lybBFEuBgVBaH3rsuH5KyRqXCodYyeu2GqCxD7PsZkDcWn4eRMwzdMJ13h2TK/gkVQ
         IfIDd5yRCjPyBX1lte22oOv3UPClmxdqRAlEegKcCbzBCg7CpCS8qomnfiyjbV7f8ZlC
         F+pGkNcf1Qhv7i4bTVgYOcLxm2cfM327HL4nwgERI9nJ/wlCGoxHWoJeVCHKI6xaS+Jr
         IQ25zDGXW66idTnRHomRIWTh2kJcKMnavnuX5EH4TfXMulep7jnMMRlGKZf7Hwd2ediD
         zcAd/tj6wVveFBid4BOBOMFGgSmXt/y39j2l8yW96YI764WqFgWjfa7L4IQHniV/8SrL
         x/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216533; x=1695821333;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vIWgxY3/V9YOuv89H/HAnhBGBkq4ee0D61xCeXLJOwc=;
        b=tE7spRTOte9MI5fyHbP9mvZuRoYxdeHWNLOwShJIUnVgfp2tA2QElw/vnJwq9ghAnQ
         QsP57XotAQwjW6IYgatXPN60ATPN5csEg50OARxIIxKoIulMyiC7n3Z8MY8g4gSX8UXN
         7HBEdgx9GxVIYAGobE+6n5o8dyFlC/ge86r+hXF7urzLgzS6JBFsdh83UWASTxhmLBjz
         +ykg25ATLZvzNW64fOqKV0DuNTLwseHtwW9pwJHKtViaf0QRsRwqeJ8kOOqHsfqT+yUO
         6+L4Kj+5FhMR85oV+T83QLyB3hWaUEYZ3p9sPicQBU9CIINL4T5TuP/dIelB+zjYjc1w
         Va5w==
X-Gm-Message-State: AOJu0YwfY/LkHOCA6GpO6R2Lf79PZbyjHZE2yz4iGBgFT9wjhKMW7Wu/
        QSBe+kvouGf0VLTVsywX+PY=
X-Google-Smtp-Source: AGHT+IFJ+GJ0WzHhmVBLQ1o6OFBNHFST+PNmxXmM1sWW2ARifBJFyfFuMoGFixzzFzYm3N4JaNNlKQ==
X-Received: by 2002:a05:620a:2454:b0:76e:ff2e:44c5 with SMTP id h20-20020a05620a245400b0076eff2e44c5mr3105848qkn.37.1695216533126;
        Wed, 20 Sep 2023 06:28:53 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id m12-20020ae9e70c000000b00772662b7804sm4802716qka.100.2023.09.20.06.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:28:52 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:28:52 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Jordan Rife <jrife@google.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc:     dborkman@kernel.org, Jordan Rife <jrife@google.com>,
        stable@vger.kernel.org
Message-ID: <650af39492a56_37ac7329469@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230919175254.144417-1-jrife@google.com>
References: <20230919175254.144417-1-jrife@google.com>
Subject: Re: [PATCH net v4 2/3] net: prevent rewrite of msg_name in
 sock_sendmsg()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Jordan Rife wrote:
> Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> space may observe their value of msg_name change in cases where BPF
> sendmsg hooks rewrite the send address. This has been confirmed to break
> NFS mounts running in UDP mode and has the potential to break other
> systems.
> 
> This patch:
> 
> 1) Creates a new function called __sock_sendmsg() with same logic as the
>    old sock_sendmsg() function.
> 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
>    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
>    as these system calls are already protected.
> 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
>    present before passing it down the stack to insulate callers from
>    changes to the send address.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
