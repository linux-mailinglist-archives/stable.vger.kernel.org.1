Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8555673097F
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 22:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFNU6H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjFNU6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 16:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245EE2693
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 13:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF8261E7A
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 20:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD6AC433C0;
        Wed, 14 Jun 2023 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686776275;
        bh=z8ZWQft7AssxeR6/feMvU6173/9CccnopUSVjMhA2QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mU6hGO6lTmOkAkoLNQPzsW2QHp70Ftpd02pGjXzMS8NX40NT35kSsODWWNlhoj/KO
         YIJas8s2b/gwFa+40fWRRJZXcfgGzC364xcSBM/+q6pEaf3hBh/oOasWH6iA/cr12i
         Nhr8POPgfmX3+w6ZUhRCmBbBZdnYnPAVfDRLm7nQ=
Date:   Wed, 14 Jun 2023 22:57:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robert Kolchmeyer <rkolchmeyer@google.com>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev, kafai@fb.com,
        ast@kernel.org, sashal@kernel.org, paul@isovalent.com,
        Meena Shanmugam <meenashanmugam@google.com>
Subject: Re: BPF regression in 5.10.168 and 5.15.93 impacting Cilium
Message-ID: <2023061453-guacamole-porous-8a0e@gregkh>
References: <CAJc0_fwx6MQa+Uozk+PJB0qb3JP5=9_WcCjOb8qa34u=DVbDmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJc0_fwx6MQa+Uozk+PJB0qb3JP5=9_WcCjOb8qa34u=DVbDmQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 11:23:52AM -0700, Robert Kolchmeyer wrote:
> Hi all,
> 
> I believe 5.10.168 and 5.15.93 introduced a regression that impacts
> the Cilium project. Some information on the nature of the regression
> is available at https://github.com/cilium/cilium/issues/25500. The
> primary symptom seems to be the error `BPF program is too large.`
> 
> My colleague has found that reverting the following two commits:
> 
> 8de8c4a "bpf: Support <8-byte scalar spill and refill"
> 9ff2beb "bpf: Fix incorrect state pruning for <8B spill/fill"
> 
> resolves the regression.
> 
> If we revert these in the stable tree, there may be a few changes that
> depend on those that also need to be reverted, but I'm not sure yet.
> 
> Would it make sense to revert these changes (and any dependent ones)
> in the 5.10 and 5.15 trees? If anyone has other ideas, I can help test
> possible solutions.

Can you actually test if those reverts work properly for you and if
there are other dependencies involved?

And is this issue also in 6.1.y and Linus's tree?  If not, why not, are
we just missing a commit?  We can't revert something from a stable
release if you are going to hit the same issue when moving to a new
release, right?

thanks,

greg k-h
