Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E47694F5
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 13:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGaLdv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGaLdu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 07:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2E6A6
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 04:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400AE61072
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 11:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB33C433C7;
        Mon, 31 Jul 2023 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690803228;
        bh=Ykx5Q0tqHG1+hHyFPx1EVvom8elHBP06GyipXqL9Huk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK14N9X9s7DDPAEX/1QUSErfXFMP7DwTaFVuzeuXdlpqyzFbdPEVwGczlFwhPVXLM
         G1gw4lhk9yiC0gnwepxuNpprt/2QIamiakx5JPxtBSFB6NIJK1TNoBI/Mw8866AGEP
         1TCJqH1k3RptaKyHrNVZScGgzKlYVfQ77J+EWlGc=
Date:   Mon, 31 Jul 2023 13:33:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [RESEND PATCH v5 1/3] test_firmware: prevent race conditions by
 a correct implementation of locking
Message-ID: <2023073147-sleeve-regular-46cd@gregkh>
References: <1a2a428f-71ab-1154-bd50-05c82eb05817@alu.unizg.hr>
 <ZMb3Yf4km8NTeMZj@bombadil.infradead.org>
 <a09b4fa3-d6dc-b7a9-f815-d6f43211910b@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09b4fa3-d6dc-b7a9-f815-d6f43211910b@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 31, 2023 at 01:29:19PM +0200, Mirsad Todorovac wrote:
> On 31.7.2023. 1:50, Luis Chamberlain wrote:
> > On Sat, Jul 29, 2023 at 11:17:45AM +0200, Mirsad Todorovac wrote:
> > > ---
> > > v5.1
> > >   resending to v5.4 stable branch verbatim according to Luis Chamberlain instruction
> > 
> > If this is a backport of an upstream patch you must mention the commit
> > ID at the top. After
> > 
> > For instance, here is a random commit from v5.15.y branch for stable:
> > 
> > bpf: Add selftests to cover packet access corner cases
> > commit b560b21f71eb4ef9dfc7c8ec1d0e4d7f9aa54b51 upstream.
> > 
> > <the upstream commit log>
> 
> Hello,
> 
> I have reviewed the module again and I found no new weaknesses, so it is only
> a backport from the same commit in torvalds, master, 6.4, 6.1, 5.15 and
> 5.10 trees/branches.
> 
> This is a bit confusing and I am doing this for the first time. In fact, there
> was probably a glitch in the patchwork because the comment to the
> Cc: stable@vger.kernel.org said "# 5.4" ...
> 
> However, I do not know which commit ID to refer to:
> 
> torvalds 4acfe3dfde685a5a9eaec5555351918e2d7266a1
> master   4acfe3dfde685a5a9eaec5555351918e2d7266a1
> 6.4      4acfe3dfde685a5a9eaec5555351918e2d7266a1
> 6.1      6111f0add6ffc93612d4abe9fec002319102b1c0
> 5.15     bfb0b366e8ec23d9a9851898d81c829166b8c17b
> 5.10     af36f35074b10dda0516cfc63d209accd4ef4d17
> 
> Each of the branches 6.4, 6.1, 5.15 and 5.10 appear to have a different commit
> ID.
> 
> Probably the right commit ID should be:
> 
> test_firmware: prevent race conditions by a correct implementation of locking
> 
> commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 master
> 
> Will the patchwork figure this out or should I RESEND with a clean slate?
> 
> But first I would appreciate a confirmation that I did it right this time ...

I don't understand at all what you are trying to do here.

Is this a patch for Linus's tree?  If so, great, let's apply it there.

Is this a patch for the stable kernel(s)?  If so, great, what is the git
id in Linus's tree and what stable kernel(s) should it be applied to?

That's all we need to know and right now, I have no idea...

confused,

greg k-h
