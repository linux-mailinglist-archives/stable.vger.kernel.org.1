Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C57BE500
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377787AbjJIPhX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377802AbjJIPhM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 11:37:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071E118
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 08:36:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso2608800a91.0
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696865771; x=1697470571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJL8V40tsSWFyehvdeNucJbgMTHvw0jxVfkGTAO4img=;
        b=ERcPL4LE8ywm7rTWzZqnI505MADqRdQDW5TKzS7LOFjC54yd6jCc3biMgoKOkEuzNv
         NPt59eCC8rJ1fXfnSf0JiSm3H0wZdz5/IJu0PuxiItcWa4YXfUmzRum7JDfoW4ovnKFV
         5GMviGCl1Ro6JVpXs8Gu6aDqSkZjsH/mdhcw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865771; x=1697470571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJL8V40tsSWFyehvdeNucJbgMTHvw0jxVfkGTAO4img=;
        b=UcOfl+/Ggur0ze7XKGeeBaB7/5QvPZu1Yv7iVUpiGklhcA0qs8pVpE+B2Biu4mclrq
         0GkWsJatC8toGYY9oQbluVyHcrFd8j6MzpAacVEjGjzERQAsLIBzaWzKFUDsbem0NQ7g
         njumWwSR5Ge5a5MRYvSEZ+Wx09WjQ4lUuWTknhPMSItngdlgHIxXV9Ee+2pFm7al5K+/
         BtVyjPPDNbr3Cf0ohCmkhEZ3YbPDlqZjTbXAvmy3Y2+zkEO0O6VbCqRxd2X41SzDiKxF
         u5BgnP9BLYTd9qpAtfkTf+qyJUSNf/+tPPME1VbQbqMSOZLGts0evJUR2+mHr0UXL8I2
         8MUg==
X-Gm-Message-State: AOJu0YwQ18cBkM9WFU5oVjBwdIgoCjxv1BF/wReSbE8KB3vG0lFk64yi
        JHJePoVhFmjei3GE5KjYV7VpkNJvchv7nHiz5nE=
X-Google-Smtp-Source: AGHT+IEvh2lrwfLLNbcjnCABx/cpL/JcqMgG6OZBfrG4S8+zT9oK/l2geCVz6Lxc3ksxW0Ym53sz7Q==
X-Received: by 2002:a17:90b:24b:b0:274:4b04:392f with SMTP id fz11-20020a17090b024b00b002744b04392fmr12039740pjb.24.1696865771179;
        Mon, 09 Oct 2023 08:36:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a980200b00263154aab24sm8491463pjo.57.2023.10.09.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:36:10 -0700 (PDT)
Date:   Mon, 9 Oct 2023 08:36:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Lee@kernel, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Message-ID: <202310090835.4DEB79C5@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009134826.1063869-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 09, 2023 at 03:48:19PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These functions are simple wrappers around memcmp() and memcpy(), which
> contain compile-time checks for buffer overflow. Something in gcc-13 and
> likely other versions makes this trigger a warning when the functions
> are not inlined and the compiler misunderstands the buffer length:
> 
> In file included from net/bluetooth/hci_event.c:32:
> In function 'bacmp',
>     inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3276:7:
> include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
>   364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Use the __always_inline annotation to ensure that the helpers are
> correctly checked. This has no effect on the actual correctness
> of the code, but avoids the warning. Since the patch that introduced
> the warning is marked for stable backports, this one should also
> go that way to avoid introducing build regressions.

Yes, good call.

> 
> Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Lee, Chun-Yi <jlee@suse.com>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/net/bluetooth/bluetooth.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 7ffa8c192c3f2..27ee1bf51c235 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -359,11 +359,11 @@ static inline bool bdaddr_type_is_le(u8 type)
>  #define BDADDR_NONE (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
>  
>  /* Copy, swap, convert BD Address */
> -static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
> +static __always_inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
>  {
>  	return memcmp(ba1, ba2, sizeof(bdaddr_t));
>  }
> -static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
> +static __always_inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
>  {
>  	memcpy(dst, src, sizeof(bdaddr_t));
>  }
> -- 
> 2.39.2
> 

-- 
Kees Cook
