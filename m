Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B872BEC8
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjFLKWB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbjFLKVU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929D6260A6
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC92B6219B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 09:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC0BC433EF;
        Mon, 12 Jun 2023 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686563958;
        bh=brtOdPSO0Au8ghs7BltwU9uLcpff6n76baFt3kG2dCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp+5VRqxmoOcXjjl3j2H1pD9e88lTqSusNOPj6eJBpmnEk7Ea70QbFwHkj/L4XN7c
         Tlp998JDGM51vLi2HOZGIJ1TFOQ7ctEj3pjpJr7yWeW1b88MLyMxz4RShuhDQB3NCy
         SidgVuhWo4mM+ywo2ymeHZ/R1J8s+JO2bX7fgsaU=
Date:   Mon, 12 Jun 2023 11:59:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [PATCH for 5.4] rbd: get snapshot context after exclusive lock
 is ensured to be held
Message-ID: <2023061207-henna-sizing-e8a8@gregkh>
References: <20230611184127.29830-1-idryomov@gmail.com>
 <2023061228-dab-doorbell-c1ed@gregkh>
 <CAOi1vP9chuevEnh4j0KTPMJ6VUKSM78TsFL8CQndz40uRXPb-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOi1vP9chuevEnh4j0KTPMJ6VUKSM78TsFL8CQndz40uRXPb-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 12, 2023 at 11:32:32AM +0200, Ilya Dryomov wrote:
> On Mon, Jun 12, 2023 at 11:25 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 11, 2023 at 08:41:27PM +0200, Ilya Dryomov wrote:
> > > Move capturing the snapshot context into the image request state
> > > machine, after exclusive lock is ensured to be held for the duration of
> > > dealing with the image request.  This is needed to ensure correctness
> > > of fast-diff states (OBJECT_EXISTS vs OBJECT_EXISTS_CLEAN) and object
> > > deltas computed based off of them.  Otherwise the object map that is
> > > forked for the snapshot isn't guaranteed to accurately reflect the
> > > contents of the snapshot when the snapshot is taken under I/O.  This
> > > breaks differential backup and snapshot-based mirroring use cases with
> > > fast-diff enabled: since some object deltas may be incomplete, the
> > > destination image may get corrupted.
> > >
> > > Cc: stable@vger.kernel.org
> > > Link: https://tracker.ceph.com/issues/61472
> > > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > > Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> > > [idryomov@gmail.com: backport to 5.4: no rbd_img_capture_header(),
> > >  img_request not embedded in blk-mq pdu]
> > > ---
> > >  drivers/block/rbd.c | 41 ++++++++++++++++++++++++-----------------
> > >  1 file changed, 24 insertions(+), 17 deletions(-)
> >
> > What is the commit id in Linus's tree of this change?
> 
> Hi Greg,
> 
> It's 870611e4877eff1e8413c3fb92a585e45d5291f6.

Great, now queued up, thanks.

greg k-h
