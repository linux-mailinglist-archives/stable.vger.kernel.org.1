Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BB701534
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 10:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEMIJ7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIJ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 04:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0BC172C
        for <stable@vger.kernel.org>; Sat, 13 May 2023 01:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD3561032
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF31AC433EF;
        Sat, 13 May 2023 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683965397;
        bh=w2NAakyk9JG+dbO9yWRXKqXJEeO3S47xN45lGP4bDq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgKodvtCVQuopjs3I31JnkMwAC/ZSZ4KmYbPd23Avcg5FC+mm8FzupvuouscB2p/D
         95QPyh+EA2SIuUeL8j7pSI8oAbp8Be86RKcJ+gqzs/DtFzaHjVaGbxKWT8yAIWtSEN
         +7v3lkGAOVQj1WT+s+WldniZs9hs2UtVXbmGKrvk=
Date:   Sat, 13 May 2023 16:50:08 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ping Cheng <pinglinux@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: [PATCH] HID: wacom: Set a default resolution for older tablets
Message-ID: <2023051359-jawline-magical-7b44@gregkh>
References: <20230409164229.29777-1-ping.cheng@wacom.com>
 <CAF8JNhJudYKrzBuyaT5aYy+fzeaxtB6HALRrbHwYzjcwz+=S0g@mail.gmail.com>
 <ZFmxMO6IyJx2/R1O@debian.me>
 <2023050922-zoologist-untaken-d73d@gregkh>
 <CAF8JNhJ9Q6+7O1pK-8SK_LYiJLsNYJLMyCaZbY73+1=-9jwdHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8JNhJ9Q6+7O1pK-8SK_LYiJLsNYJLMyCaZbY73+1=-9jwdHw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 10, 2023 at 05:06:03PM -0700, Ping Cheng wrote:
> On Mon, May 8, 2023 at 7:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 09, 2023 at 09:34:24AM +0700, Bagas Sanjaya wrote:
> > > On Mon, May 08, 2023 at 06:05:02PM -0700, Ping Cheng wrote:
> > > > Hi Stable maintainers,
> > > >
> > > > This patch, ID 08a46b4190d3, fixes an issue for a few older devices.
> > > > It can be backported as is to all the current Long Term Supported
> > > > kernels.
> > > >
> > >
> > > Now that your fix has been upstreamed, can you provide a backport
> > > for each supported stable versions (v4.14 up to v6.3)?
> 
> To speed up the process, I tested the patch on all stable branches.
> The upstream patch can be APPLIED to kernels 5.15 and later, AS IS.
> 
> The attached patch applies to kernels 4.14 to 5.10. If you'd like me
> to send the patch in a separate email, please let me know. Thank you
> for your effort!

All now queued up, thanks.

greg k-h
