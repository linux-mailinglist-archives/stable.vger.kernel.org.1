Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3C7358A6
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFSNdK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFSNdG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 09:33:06 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04EFE7C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:33:03 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-38dec65ab50so2600125b6e.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687181583; x=1689773583;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXdXXYJFqC8VyAIbUMRsLK8kC4+RccqWSrq3lwcnNn0=;
        b=qzwptOOc5d9KRi41BOKdXTYNe00r4RtZEy8yzwrX8eQsggmtVkGqo5um/q7AehQtRj
         RZN+2ADQebSYDsDieEHp6PmMXJf9sIYDAoYnOiiqlfyWG7SeZkK71AXD2t/udC2T20FN
         8yklNkpXkXtVvTBYefxAEKig02DM4ALdrIitlILSRUzbL3B8bO7B8bPuiTCe/PmS9ExY
         AI6qYNqo2+5SFPsOQGk8UsG3mImr873yzHu7WViCIa+OhcRdrSTmtvXJsFdOcPMvqSQP
         bVH4/q7SKq4Id27ARONOk9vz76fg289jguPpEPUkZYiASJ46vjnBrrLTVABiZ4gU7t/J
         ll+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687181583; x=1689773583;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aXdXXYJFqC8VyAIbUMRsLK8kC4+RccqWSrq3lwcnNn0=;
        b=dlChU5tEszLU3aSE6sI+jt19j/BI1ukDL1BDujcjrwefS6G57XJSkvNQyZhWWMnnHU
         UxYD557nAEqj5mBIZBk4MoRkZukVFW9mx0gWwOSZy2k2oLIP7T0+ntRWjVhd7yM0/a7o
         2kdr9KJl24ravwaKAltsdIF3tD7A3CXs0Fe2ndipWWsAVHGec1Wv6vSlbjkvZsQx7Xwr
         7/5YXcypNnpK0JBUboozcft7kyvxZpEYtVbX2V4qo1dXd1MQ8xE+KgLOryaXJKSMRO4P
         ot94/lTZ8DrSy1hG8xDvPMl8kxEgLP5COKDyHoTZ2FbrbgHcWEVyiTFGWsk2FJPgsoiH
         2BPw==
X-Gm-Message-State: AC+VfDzINzBCeQZNJgSe0H6H1WAV6QepTX8d4+3N31x9yJzBx7Od8VMe
        oROHKooYZKTh1COyd/OrPGn4O6USVA==
X-Google-Smtp-Source: ACHHUZ6a2GM3oWgMYdmKE/m+C1k9/x0VEN2WtiZMF2HdD5zczVwHdsdRJR4aLA4vJBcLz7f6yPG3Hw==
X-Received: by 2002:a05:6808:1cf:b0:3a0:33a6:a05c with SMTP id x15-20020a05680801cf00b003a033a6a05cmr448112oic.42.1687181582013;
        Mon, 19 Jun 2023 06:33:02 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 7-20020aca0f07000000b003a033fc87c7sm139076oip.30.2023.06.19.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:33:01 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:f28b:4a5a:d6b1:259b])
        by serve.minyard.net (Postfix) with ESMTPSA id AF6191800BF;
        Mon, 19 Jun 2023 13:33:00 +0000 (UTC)
Date:   Mon, 19 Jun 2023 08:32:59 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: IPMI related kernel panics since v4.19.286
Message-ID: <ZJBZCxyRTPsuGQ0l@mail.minyard.net>
Reply-To: minyard@acm.org
References: <7ae67dbec16b93f0e6356337e52bf21921b0897c.camel@nokia.com>
 <2023061927-fox-constrict-1918@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061927-fox-constrict-1918@gregkh>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 02:23:47PM +0200, Greg KH wrote:
> On Mon, Jun 19, 2023 at 11:11:16AM +0000, Janne Huttunen (Nokia) wrote:
> > 
> > We recently updated an internal test server from kernel v4.19.273
> > to v4.19.286 and since then it has already multiple times triggered
> > a kernel panic due to a hard lockup. The lockups look e.g. like
> > this:
> 
> Does this also happen on newer 5.4 and 6.4-rc7 releases?

If I am correct, no, it will not happen there.  I was surprised 

I believe the change that causes this issue was:

  b4a34aa6d "ipmi: Fix how the lower layers are told to watch for messages"

which was backported into 4.9.  But there was a locking change:

  e1891cffd4c4 "ipmi: Make the smi watcher be disabled immediately when not needed"

that came in 5.1.  That was required for b4a34aa6d to work correctly,
and I didn't realize that.  If Janne tests that patch (and the other fix
for it), then kernels 5.1 and later are good as they are.

Thanks,

-corey

> 
> thanks,
> 
> greg k-h
