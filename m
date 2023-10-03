Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3845E7B67CB
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjJCLZa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 07:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjJCLZa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 07:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F294B7
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 04:25:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A3AC433C7;
        Tue,  3 Oct 2023 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696332322;
        bh=N/valvlXOXORDjKihkY13jGQW1p1+ccz/In5bFSgxBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ff4uQkC25Y4/xsZ2JRS/WTfklbvdSmwGirdx5sfXhaPq2PLp5x6gWkTnUGMSJYTPQ
         lF+kgv4zjXWuNf4B1arWb9JmI0Sd++Iu0s8uooISwqCe7ciJx6pXCHEwzIVw8xKUvf
         7AwhtK8tx+VXWb3b2zdr6syY4wyyHQU+EjDq/c/Ie/rpiiiT+4I2Pnq72tVZMdo5KF
         Do7igCob4aJNUojIMQlvYFavhr4dE1tp6oj6oQUlI31ykhOedv4y1vGkf37u9PVO4l
         JHV3gurLTB6mrIUrhIazyDPCpc7QSaafreYyuBlQOJAguh/pLmVx8bp5Zm44MRBxfK
         9rau6jrbo8zJA==
Date:   Tue, 3 Oct 2023 07:25:20 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Akemi Yagi <toracat@elrepo.org>
Subject: Re: 6.5-stable backport request
Message-ID: <ZRv6IFKjB+KMr6CH@sashalap>
References: <CAM9d7cggeTaXR5VBD1BoPr9TLPoE7s9YSS2y0w-PGzTMAGsFWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAM9d7cggeTaXR5VBD1BoPr9TLPoE7s9YSS2y0w-PGzTMAGsFWA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 28, 2023 at 01:41:34PM -0700, Namhyung Kim wrote:
>Hello,
>
>Please queue up this commit for 6.5-stable:
>
> * commit: 88cc47e24597971b05b6e94c28a2fc81d2a8d61a
>   ("perf build: Define YYNOMEM as YYNOABORT for bison < 3.81")
> * Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>
>The recent change v6.5 series added YYNOMEM changes
>in the perf tool and it caused a build failure on machines with
>older bison.  The above commit should be applied to fix it.

Queued up, thanks!

-- 
Thanks,
Sasha
