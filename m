Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841DD7C641F
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 06:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjJLEg7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 00:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjJLEg6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 00:36:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CCEA9
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 21:36:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E98606732D; Thu, 12 Oct 2023 06:36:52 +0200 (CEST)
Date:   Thu, 12 Oct 2023 06:36:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231012043652.GA1368@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 11, 2023 at 11:04:58AM -0600, Keith Busch wrote:
> > > Given the way things are in NVMe, I do not find a better way.
> > > Maybe another day for commands that do (or can do) things very
> > > differently for nlb and PI representation.
> > 
> > Fixing just a subset of these problems is pointless.  If people want
> > to use metadata on vendor specific commands they need to work with
> > NVMe to figure out a generic way to pass the length.
> 
> NVMe already tried to solve that with NDT and NDM fields, but no vendor
> implemented it. Maybe just require SGL's for passthrough IO since that
> encodes the buffer sizes.

How is that going to help us with metadata where neither we, nor most
devices support SGLs?

> I don't think it's reasonable for the driver to decode every passthrough
> command to validate the data lengths, or reject ones that we don't know
> how to decode. SG_IO doesn't do that either.

I don't want that either, but what can we do against a (possibly
unprivileged) user corrupting data?

SCSI has it much either because it has an explicit data transfer length
(outside the CDB) instead of trying to build it from information that
differs per opcode.  One of the many places where it shows that NVMe
is a very sloppy and badly thought out protocol.
