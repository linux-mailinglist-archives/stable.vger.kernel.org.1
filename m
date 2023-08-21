Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F481782EA4
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjHUQmF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjHUQmE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 12:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FEBFD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 09:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0214663EC3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 16:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD23C433C7;
        Mon, 21 Aug 2023 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692636121;
        bh=ghxwnj2aU6SANSy7udoepeMEUhhU0DsMtfERhvGnVFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KL/BmbS4s7mtS2mjK6+cVQa8tWSDO9rjAQCC8cXyXRzzB0tvhl+5X6z+wXKZstNJF
         bWA4HalLVXwSPSW4h1mMEpX/EGfviTFk/cqwwGlRhgo7gaQhQyf8Nkc3Gbhi3Zgxmr
         Us7gsc+nYfBgvBTC3oFWivvXdOK+EyIJ8RLTT6ko=
Date:   Mon, 21 Aug 2023 18:41:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com,
        asavkov@redhat.com, hawk@kernel.org, irogers@google.com,
        jolsa@kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] Revert "perf report: Append inlines to
 non-DWARF callchains"" failed to apply to 6.4-stable tree
Message-ID: <2023082125-renovator-nearby-8a4f@gregkh>
References: <2023081251-conceal-stool-53f1@gregkh>
 <ZNu+OFN4bwJ0lBir@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNu+OFN4bwJ0lBir@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 15, 2023 at 03:04:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Aug 12, 2023 at 06:50:51PM +0200, gregkh@linuxfoundation.org escreveu:
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
> > git cherry-pick -x c0b067588a4836b762cfc6a4c83f122ca1dbb93a
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081251-conceal-stool-53f1@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
> 
> Had to add "--no-cover-letter":

That's odd, is "cover letter" a default setting somewhere?  I've never
seen that triggered, but then I don't use git send-email with a patch
range...

thanks,

greg k-h
