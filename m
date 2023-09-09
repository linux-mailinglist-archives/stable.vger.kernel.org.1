Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7F7995DB
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 03:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbjIIBwT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 21:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbjIIBwS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 21:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A91FEA
        for <stable@vger.kernel.org>; Fri,  8 Sep 2023 18:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694224288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SanvGomkSje1s3xXLYmIy8A6OYMvM6JQdu3zGT78Ysw=;
        b=TNXr6cexwb9mJ/lUTcmng/4bjdzxSyHO53qjKCD/N+Ka/a38ZF0Mt9E7h4nFuLwqr3WrV7
        cjmvAoFrX5XTDl2+cgV4Pg5O5ubBOBwMDxx7BAzEuaAmGALbi8O7s6xQeTn82GNWTo0Ee6
        Ny7K156LrT/oiOcw7nvwXVGgQOpz0W8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-twYaE_hDOlKAG_RjTgEhdw-1; Fri, 08 Sep 2023 21:51:26 -0400
X-MC-Unique: twYaE_hDOlKAG_RjTgEhdw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-655d7107e70so2897336d6.1
        for <stable@vger.kernel.org>; Fri, 08 Sep 2023 18:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694224286; x=1694829086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SanvGomkSje1s3xXLYmIy8A6OYMvM6JQdu3zGT78Ysw=;
        b=KQxO/yqgI/v8OoOJzfxRAGwO+MG1yYSOPcLXtl8Lu1Qs712g+PVA5Ng1H7bR1PLKbC
         BIvDF9N8Usl+EXgmApQ0M/1TzmYAIHFmBg5774JH9CWc9oQKAnwdnMdKW4GtwWdD+nfQ
         q3iyZIpwfGHUMYdiciDfxBfJzTH2tXKh/8L6n4+V04JoR1dTFpIMXb5y5M+mkHkMNzfM
         VDzIYuraUQzTcHLrfhi9/cMLiHi8mTAejAmW2+qfCBb0dJdsuGdxYeF6Brgvj1ya1DuB
         b/CG+/XRTdxzHNLil3/EV5RWBUBDI+gzQXYJuWd5grfn+oPDqacoyo2t682oM2h0D63z
         c3Kw==
X-Gm-Message-State: AOJu0YwHTjSBuXuUONT+Jo3OaWZ0kaKlQnQmg/6pMeARgQb8pk8olx9s
        ROPCjRDQJCbyaaDtq9+tAlbhYm/v1ULg4CXMIUvdlqJwNKC2ylbmUQPvD8E2LSJ0N8+Xq+jxQA3
        wvIxUTwTyWtkV3x0+2bhTb53z
X-Received: by 2002:a0c:f189:0:b0:64f:4ba6:3b2d with SMTP id m9-20020a0cf189000000b0064f4ba63b2dmr3995137qvl.44.1694224286023;
        Fri, 08 Sep 2023 18:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVh4ux+7IqqyRIt488t13shoGm2kJKCOWhsRwEuleU7OnKpj/Zy1OLf+heVW5s49yNQ892NA==
X-Received: by 2002:a0c:f189:0:b0:64f:4ba6:3b2d with SMTP id m9-20020a0cf189000000b0064f4ba63b2dmr3995122qvl.44.1694224285794;
        Fri, 08 Sep 2023 18:51:25 -0700 (PDT)
Received: from x1-fbsd.aquini.net (c-73-249-122-233.hsd1.nh.comcast.net. [73.249.122.233])
        by smtp.gmail.com with ESMTPSA id x13-20020a0ce24d000000b0064c1b27bf2dsm1145804qvl.140.2023.09.08.18.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 18:51:25 -0700 (PDT)
Date:   Fri, 8 Sep 2023 21:51:21 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Rafael Aquini <raquini@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: fix slab_caches list corruption after
 kmem_cache_destroy()
Message-ID: <ZPvPmU9vBXQoFBm4@x1-fbsd.aquini.net>
References: <20230908230649.802560-1-aquini@redhat.com>
 <ZPvHUK95S6Dgl86v@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPvHUK95S6Dgl86v@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 09, 2023 at 02:16:00AM +0100, Matthew Wilcox wrote:
> On Fri, Sep 08, 2023 at 07:06:49PM -0400, Rafael Aquini wrote:
> > This patch fixes this issue by properly checking shutdown_cache()'s
> > return value before taking the kmem_cache_release() branch.
> 
> Is this the right way to fix this problem?  If the module destroys the
> slab cache, it's not going to be possible to free any of the objects
> still allocated from the cache.  I feel that we should treat this as
> implicitly freeing all the objects that were allocated from the cache
> rather than saying the cache is still busy.
>

Leaving the cache with the unfreeable slabs "alone" is how it was historically 
done, and we have to fix this corner case opened by 0495e337b703 this way to 
address the corruption on stable releases without changing their established 
and expected behavior.

I think your proposal for a different behavior upon cache destruction is
something we should discuss for future releases, but it is orthogonal to
this required follow-up fix.


