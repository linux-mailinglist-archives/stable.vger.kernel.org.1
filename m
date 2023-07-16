Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98062754F06
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjGPOan (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPOan (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 10:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D3E5C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 07:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 335C560C90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 14:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A83DC433C7;
        Sun, 16 Jul 2023 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689517840;
        bh=JVjM1iN4GUUEiMQdmqx8vgbv0yimXyCKQG1Y68paivk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXKxasPIwPV4UpX/Jr6D993PKHocbnBVXvuNuYpgu4+NBk7sqjXfzRY/EOGOiPo2S
         rI577aGi+v5UnQQPs+tqzBAhUMsCL1w4/DBtHZ9FKhx1QmAxpqqRx9ov5Yq1AzWRrX
         TFcGTsbODDYNhzshzbJduDe3OvD/A+wCQ06ZLSJE=
Date:   Sun, 16 Jul 2023 16:30:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Build failures / crashes in stable queue branches
Message-ID: <2023071625-parsnip-pursuable-b5c8@gregkh>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
 <20230715154923.GA2193946@google.com>
 <907909df-d64f-e40a-0c9c-fc5c225a235c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <907909df-d64f-e40a-0c9c-fc5c225a235c@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 11:20:33AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/07/15 23:49, Joel Fernandes 写道:
> > Hi Yu,
> > 
> > On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
> > [..]
> > > ---------
> > > 6.1.y:
> > > 
> > > Build reference: v6.1.38-393-gb6386e7314b4
> > > Compiler version: alpha-linux-gcc (GCC) 11.4.0
> > > Assembler version: GNU assembler (GNU Binutils) 2.40
> > > 
> > > Building alpha:allmodconfig ... failed
> > > Building m68k:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> > > In file included from block/genhd.c:28:
> > > block/genhd.c: In function 'disk_release':
> > > include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
> > >     88 | # define blk_trace_remove(q)                            (-ENOTTY)
> > >        |                                                         ^
> > > block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
> > >   1185 |         blk_trace_remove(disk->queue);
> > 
> > 6.1 stable is broken and gives build warning without:
> > 
> > cbe7cff4a76b ("blktrace: use inline function for blk_trace_remove() while blktrace is disabled")
> > 
> > Could you please submit it to stable for 6.1? (I could have done that but it
> > looks like you already backported related patches so its best for you to do
> > it, thanks for your help!).
> 
> Thanks for the notice, however, I'll suggest to revert this patch for
> now, because there are follow up fixes that is not applied yet.

Which specific patch should be dropped?

thanks,

greg k-h
