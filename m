Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5BD7AA006
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjIUUaq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjIUUac (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 16:30:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1558DEDA;
        Thu, 21 Sep 2023 10:44:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so11361101fa.0;
        Thu, 21 Sep 2023 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318251; x=1695923051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQlhQ18mkiygDlJKtoMX3pgyYRKOBMaaTP/lu4ZhNHs=;
        b=BQbpyTr4ATdIauar8Wl9rLCfiCr46ujVf1ClfO2TzwziV3dbcvGzNfs8gOiYnOUeQa
         VL1K6AnRm22Tyn7rw6CCUDd2c5p3UsoCR9T6NrG0oT1X7oHlqjHP7jjUgDHQ2VctFMgF
         0z7eVb1HJq+rCeQcWwxqNIJLB7LZUpUDIOoNO+hMs8+hwpBogQyfzA+BvbgZCP1InJs5
         X3v5Wn464EJkn5bYinMWZ596qBO7Zt+RrWQdouszvLcTskgYV7sup4nL0IcnLhzTnvvL
         Ig2hk0WtAc5vnPMdgWKmFtNiYytXs37V6/SOpH/twXGjiqGNcgp+GND4CDMU26t1eHa6
         6cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318251; x=1695923051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQlhQ18mkiygDlJKtoMX3pgyYRKOBMaaTP/lu4ZhNHs=;
        b=nGFOLxzGW022e3tSUmWBOCRUipx9W1+ApnvBWbDOGsLm2PDcfB3LQ2ZOpo8YlCVpsW
         a62a38ScbWhxenw2UbeCQuM9fiAhHj7oBUMBPZ5WXBa917rvXhPoBpIb6o9mshIaBcRZ
         M00RTcOTwL8rFwRbwNVVfIlbjLyHERvC6+x8LBktKcQ6todjs0sTESPM5rO8y5lIFvzF
         L+NxfazdUNsSmVlQ7pqEmCACcZpKFDea9kplkqTPzwhiQut1XqIt3in6sgvW8a7cRBUa
         t6yedU8ipdUbJvKLE0ZWZMsKVad/Xhr9kq1tjRt0Gb86T2FoFERRrFaT9D1AKTL0b2W4
         kPsQ==
X-Gm-Message-State: AOJu0YyiGMesennWWpxyRsvA/3GlYAm+xmxsZHihvTdZsRhmeAoz9L8U
        hL1pq1wZGmhjl2lwcFBDRL+4RDyBggw=
X-Google-Smtp-Source: AGHT+IHZ4A/BJ+1JF1sRLXOnBdteqw91VqGx+yAvlagrN9AYVba/sQuAo7hedbTGqHzfvCk6U1OByg==
X-Received: by 2002:a19:7602:0:b0:503:3421:4ebd with SMTP id c2-20020a197602000000b0050334214ebdmr4559888lff.63.1695300179956;
        Thu, 21 Sep 2023 05:42:59 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.133.205])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7db4c000000b005312b68cb37sm783444edt.28.2023.09.21.05.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:42:59 -0700 (PDT)
Message-ID: <d0f4a2ab-7010-5b09-f47e-21dc54a759c2@gmail.com>
Date:   Thu, 21 Sep 2023 13:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/3] net: prevent rewrite of msg_name in
 sock_sendmsg()
To:     Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jordan Rife <jrife@google.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Cc:     dborkman@kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20230919175254.144417-1-jrife@google.com>
 <650af39492a56_37ac7329469@willemb.c.googlers.com.notmuch>
 <139933c6013e444047dc685ade53fa3dc1ad68d3.camel@redhat.com>
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <139933c6013e444047dc685ade53fa3dc1ad68d3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/21/23 09:32, Paolo Abeni wrote:
> On Wed, 2023-09-20 at 09:28 -0400, Willem de Bruijn wrote:
>> Jordan Rife wrote:
>>> Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
>>> space may observe their value of msg_name change in cases where BPF
>>> sendmsg hooks rewrite the send address. This has been confirmed to break
>>> NFS mounts running in UDP mode and has the potential to break other
>>> systems.
>>>
>>> This patch:
>>>
>>> 1) Creates a new function called __sock_sendmsg() with same logic as the
>>>     old sock_sendmsg() function.
>>> 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
>>>     __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
>>>     as these system calls are already protected.
>>> 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
>>>     present before passing it down the stack to insulate callers from
>>>     changes to the send address.
>>>
>>> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
>>> Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jordan Rife <jrife@google.com>
>>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> CC Jens and Pavel, as I guess io_uring likely want to use
> __sock_sendmsg(), in a follow-up patch.

Yeah, likely so. Thanks Paolo, we'll take a look

-- 
Pavel Begunkov
