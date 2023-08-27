Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B56789C39
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjH0Iif (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjH0IiE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817010E
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A187760DD7
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB2DC433C7;
        Sun, 27 Aug 2023 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693125481;
        bh=2mKHjCsWYLDV9AARVDZrSeaqEDAKgttj5cF3sskEJEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6b6qYv+TGiSg7/g+/WfvZOECXoyOeqC80FzVxYLimTw1Rfv3bY5fg3I+gJEGE85L
         R4xfREYQK66vDyH5PJz4k1gracISBC90YWtzRLnfCZeLrv5iUZ/ow3FYzGLHkzWcDz
         0z5QOS+8KNS1E6gQwKy6/BjnkO4sdvkmG5vsyuvA=
Date:   Sun, 27 Aug 2023 10:37:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     chenhuacai@loongson.cn, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] LoongArch: Ensure FP/SIMD registers in
 the core dump file is" failed to apply to 6.4-stable tree
Message-ID: <2023082731-dotted-plexiglas-ce0d@gregkh>
References: <2023082705-predator-enjoyable-15fb@gregkh>
 <CAAhV-H5WYTGSvkz6tgZZud7gUOYyQGUXgSY_7ipe_0BGkz=YeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5WYTGSvkz6tgZZud7gUOYyQGUXgSY_7ipe_0BGkz=YeQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 27, 2023 at 04:23:35PM +0800, Huacai Chen wrote:
> On Sun, Aug 27, 2023 at 2:45 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 656f9aec07dba7c61d469727494a5d1b18d0bef4
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082705-predator-enjoyable-15fb@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
> >
> > Possible dependencies:
> I'm sorry, this is my mistake. 6.4 also need to cut the simd_get()
> part, because simd is only supported since 6.5

I do not understand, sorry.  Is this relevant for 6.4.y?  If so, can you
provide a working backport?

thanks,

greg k-h
