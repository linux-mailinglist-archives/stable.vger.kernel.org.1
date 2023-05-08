Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334A16FA05B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEHG6Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjEHG6R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 02:58:17 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381541A11A
        for <stable@vger.kernel.org>; Sun,  7 May 2023 23:58:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0F03D320027A;
        Mon,  8 May 2023 02:56:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 May 2023 02:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683528985; x=1683615385; bh=/+
        6s3vtxHdNnlhvLdsn2o9TFpM6NVj97Kla/yEa9ioU=; b=aYrPLs2odUwPfervYT
        ErDjucGNgLd7HOoMRcQYmE+oNKsRNBPrdzUoEWtv62erxBOVVnNDpLAekDiimOMg
        eqUmBq10Av5QPOdLcbcz6s3rNrD++bRh9UjMzQkj6IBRhZ9StmAU50wDuANJF63I
        9Nyi5o5PpAB3d74KfAUwjTlwshvWtmMECUclgPX79mrGqcgOQk0kOJBTSUaU0NyD
        aFWhDCmhbQBZogcyUFNjTSY8otM56IHWXdxyP8TzbBRyidtTdP44/eiHBiDhri7K
        +FiGdFI22FoXj8epF/lA0qr6a6qyT7axieXTBO+xkGL0/QkbPl99+rOXdSPlLpPn
        HQFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683528985; x=1683615385; bh=/+6s3vtxHdNnl
        hvLdsn2o9TFpM6NVj97Kla/yEa9ioU=; b=AQ3JGZkB8lXd4EVLU9FMe9N0K5rp8
        n2/bqvCn0/QQm6vZjT6Ehq5vvrMlB0ItsaXKrCkldCExKvkwjyCqzV957w/OUoyD
        x1xeXiTMB2ambWNmkavcTBZGCKTpDJxH9wg+FW4DLUD+LK97xEy6/tUzrjRrLLpA
        Dnk8XrVm7FzJhD1wEGrci6/cdjqD91b3yRKFQnKu2YuPfO5W6x8ywBl3BzXNs2np
        DYJ1qvoudoezZggXI0mFSqRi+PdVI8HTLMFdeSn+djb/qHU42wyB9vrSEU2lLKex
        9gblaLOS+fx3vD9Vz9GUeN9IfSqi0OSbiT04Ky/qj6zR0D7xcbAMPSGrg==
X-ME-Sender: <xms:GJ1YZFazxbe6YXKTzbWbXo0LeiHA6Bs55X5qFywa54HztvUCDDOgqQ>
    <xme:GJ1YZMa7ig3coMhZZGvN2k62qMBDFhbTmYze3uaKa-UQUnIe1TNV4xd4K5nZ_1IKM
    2kAWhIV-_JZFQ>
X-ME-Received: <xmr:GJ1YZH8vri4uD2HyYWPdatDzQboDd-RtGqAAuiTZ9sp-ePlvL_LKbhrnH7nufV3p0-XvmWYYygYmIjnr-gZ8LP7CqsTtdYRXcZVuOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:GJ1YZDq_zY4X0H9B9oaGb0MSOU2MVyUaKHAhcEP0xf-R2K-icG3dfA>
    <xmx:GJ1YZApMJHnDpIt_91fz1DETHX6qwC86J_HslkkGG7wlcOilUPVWYQ>
    <xmx:GJ1YZJT443azU0mn4pJsgldZhwFULA8D0pQshbK6Qg4QQs4UvuzGcQ>
    <xmx:GZ1YZJYwNXtt0YHSbsT3k6bO_6BW1NfQ-qPvGfLnGV83xj6zHVN6bw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 May 2023 02:56:23 -0400 (EDT)
Date:   Mon, 8 May 2023 08:56:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Patrick Daly <quic_pdaly@quicinc.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4.14.y] mm/page_alloc: fix potential deadlock on
 zonelist_update_seq seqlock
Message-ID: <2023050828-asleep-semicolon-240e@gregkh>
References: <2023042455-skinless-muzzle-1c50@gregkh>
 <20230507145629.4250-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507145629.4250-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 07, 2023 at 11:56:29PM +0900, Tetsuo Handa wrote:
> commit 1007843a91909a4995ee78a538f62d8665705b66 upstream.

For obvious reasons, we can't just apply this to 4.14.y.  Please provide
fixes for all other stable trees as well so that you do not have a
regression when updating to a newer kernel.

I'll drop this from my review queue for now and wait for all of the
backported versions.

thanks,

greg k-h
