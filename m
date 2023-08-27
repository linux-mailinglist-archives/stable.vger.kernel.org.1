Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1906E789BB8
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 09:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjH0HSB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 03:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjH0HRl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 03:17:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DCBB3
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 00:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872FF6223B
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 07:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9048DC433C9;
        Sun, 27 Aug 2023 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693120657;
        bh=YFKz3OCK4Bph9+sNtS/54GBNlg60z0GN8ptPeo14HfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNBD8i9ZgxJj/598jAzAAOJuwDYMR3D+482y2ABZl4As2DOx1OhUJviuVv/ZmCIGd
         qulkgWeNbCTAA4dtoCYqNIVGOfEBqHQBf5pwfjwX1f6sst2ksyfXvsOfZUC/yqLXww
         dWCG+n8yuies+gBnzu/4+F13PPQOqHgi09wY5sCE=
Date:   Sun, 27 Aug 2023 09:17:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     andrzej.hajda@intel.com, luciano.coelho@intel.com,
        matthew.d.roper@intel.com, rodrigo.vivi@intel.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/i915: fix display probe for IVB Q and
 IVB D GT2 server" failed to apply to 6.4-stable tree
Message-ID: <2023082728-crayfish-grandkid-213e@gregkh>
References: <2023082143-rummage-chasing-3ff3@gregkh>
 <87cyzf7aai.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyzf7aai.fsf@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 22, 2023 at 11:26:13AM +0300, Jani Nikula wrote:
> On Mon, 21 Aug 2023, <gregkh@linuxfoundation.org> wrote:
> > The patch below does not apply to the 6.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 423ffe62c06ae241ad460f4629dddb9dcf55e060
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082143-rummage-chasing-3ff3@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
> >
> > Possible dependencies:
> 
> I think it should work to cherry-pick this as the dependency:
> 
> 12e6f6dc78e4 ("drm/i915/display: Handle GMD_ID identification in display code")

That worked, thanks!

greg k-h
