Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B87A41C2
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbjIRHIe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 03:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbjIRHIH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 03:08:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8A3100
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 00:08:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52914C433D9;
        Mon, 18 Sep 2023 07:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695020881;
        bh=5cYT6s+W1+FBarzJ57lGL9ZmJ16G6TyPMMoG6llhjo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFmk4/bEtk8kL34oAphCEgNmqOoJ+m63NPpt36EPmnCuvVkodbvfejfHCuenCI4H2
         WpkKBYaGdkTd1rMnraF1C4Nd1uz2jbmeTbv0U7K+4DYhLm7tHQ1GRhkpyrOKQBLdkU
         1vZ3xGn16/qcl7kkUD9O46bV1Yg6eNrSuTKrVSQ0=
Date:   Mon, 18 Sep 2023 09:07:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        stable <stable@vger.kernel.org>, patches@lists.linux.dev,
        Yonghong Song <yonghong.song@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, gerhorst@amazon.de
Subject: Re: [PATCH 5.10 294/406] bpf: Fix issue in verifying allow_ptr_leaks
Message-ID: <2023091815-skier-freemason-988c@gregkh>
References: <20230917191101.035638219@linuxfoundation.org>
 <20230917191109.075455780@linuxfoundation.org>
 <276965bc5bb339bc02bbd653072ceb50a7103400.camel@gmail.com>
 <CAADnVQ+OwQzzGC7tP_qbLYi=k6T4dPKrod57iXt2-_JFCdqF4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+OwQzzGC7tP_qbLYi=k6T4dPKrod57iXt2-_JFCdqF4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 17, 2023 at 06:51:14PM -0700, Alexei Starovoitov wrote:
> On Sun, Sep 17, 2023 at 1:21 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Sun, 2023-09-17 at 21:12 +0200, Greg Kroah-Hartman wrote:
> > > 5.10-stable review patch.  If anyone has any objections, please let me know.
> >
> > I believe Luis Gerhorst posted an objection to this patch for 6.1 in [1],
> > for reasons described in [2]. The objection is relevant for 5.10 as well
> > (does not depend on kernel version, actually).
> 
> Yes. Let's delay the backport of this patch until that thread is resolved.

Ok, but note, this is already in a released 6.1.y and 6.5.y release so
we need fixes in there for whatever ends up in Linus's tree to resolve
this.  I'll drop this from the pending queues right now for now.

thanks,

greg k-h
