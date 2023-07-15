Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1107549E9
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGOPt1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 15 Jul 2023 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGOPt0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 15 Jul 2023 11:49:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF12691
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 08:49:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7837329a00aso134425439f.2
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689436165; x=1692028165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6l2Aky5AIBQggivLbRqzCWJTM73ANHCGJs8ysIFdNxE=;
        b=vAuLbqOr8pKFcvAyD3UW6IJQN33qqlcpowz7/O9P5CjmFvXXZl3Q07ZB4W+rw+IzsT
         +tGqQQsTkRfY5wX+tV/PBuEs2j+Iw34uPtCjJbOKiFQw/gDSLdIBiAKyIvhTxN+ZnhQ6
         yFYJbXLK3RyENp+bgSXrDETXTCPaBZ7QxXE+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689436165; x=1692028165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l2Aky5AIBQggivLbRqzCWJTM73ANHCGJs8ysIFdNxE=;
        b=DOKvALC57JEgoQTaJWWnMGN/hI6MNVNs9stBCYCWdpzLXAhGevGxKGyiydVvIRRkDW
         GVk6oksMo/YgXnB8Ac2R0102X4fnVgzdGZPyYXlkoGHXrhPV9mduPhKpDRtpIkjhvyT5
         6bR7gpVr8YYLEFPtg3OTfZ6g3apjypudIni6FmvqNp3s55QbHNOtZh71hYu9zYDxtUHD
         tuCmmufwFJV4F7lTIrBXaExOXR9T75PDMS+Gl+XVEy81T7EXMvngU/lL1FkALFCA6HgD
         LLpNPGxioZAzDYfb0Ujyexm4Q8S6ZILLntB8uWuq1K3B85ZkyMhMMTRDW+6U+6kDGs5b
         hFKA==
X-Gm-Message-State: ABy/qLa7GrtMyEsxWEqkgzyXy85W75UzFh6j7OVjr0h/idHiwKFAgdjK
        xrRjowsHWxYJnhpG63f4ZTSZRbMk3sb9JZXGotE=
X-Google-Smtp-Source: APBJJlFQERgO8ZRMHO2ToBPPNfPst+ctWdHw++f2J5e++WqMWcR3cxWub2122T9MHHmCW7w52qLxbw==
X-Received: by 2002:a6b:d919:0:b0:787:167e:f796 with SMTP id r25-20020a6bd919000000b00787167ef796mr7195044ioc.15.1689436165131;
        Sat, 15 Jul 2023 08:49:25 -0700 (PDT)
Received: from localhost (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id n17-20020a056602221100b0078647b08ab0sm3592670ion.6.2023.07.15.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 08:49:24 -0700 (PDT)
Date:   Sat, 15 Jul 2023 15:49:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     stable <stable@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build failures / crashes in stable queue branches
Message-ID: <20230715154923.GA2193946@google.com>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Yu,

On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
[..]
> ---------
> 6.1.y:
> 
> Build reference: v6.1.38-393-gb6386e7314b4
> Compiler version: alpha-linux-gcc (GCC) 11.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
> 
> Building alpha:allmodconfig ... failed
> Building m68k:allmodconfig ... failed
> --------------
> Error log:
> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> In file included from block/genhd.c:28:
> block/genhd.c: In function 'disk_release':
> include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
>    88 | # define blk_trace_remove(q)                            (-ENOTTY)
>       |                                                         ^
> block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
>  1185 |         blk_trace_remove(disk->queue);

6.1 stable is broken and gives build warning without:

cbe7cff4a76b ("blktrace: use inline function for blk_trace_remove() while blktrace is disabled")

Could you please submit it to stable for 6.1? (I could have done that but it
looks like you already backported related patches so its best for you to do
it, thanks for your help!).

thanks,

 - Joel

