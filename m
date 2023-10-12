Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C04E7C71CA
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjJLPq1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJLPq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 11:46:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374CC0
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 08:46:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FB9668AA6; Thu, 12 Oct 2023 17:46:19 +0200 (CEST)
Date:   Thu, 12 Oct 2023 17:46:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231012154618.GA17670@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de> <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com> <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com> <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 09:31:38AM -0600, Keith Busch wrote:
> > I don't want that either, but what can we do against a (possibly
> > unprivileged) user corrupting data?
> 
> The unpriviledged access is kind of recent. Maybe limit the scope of
> decoding to that usage?

Let's just drop support for unpriviledged passthrough for now.  That's
easily backportable and gives us time to sort out what we can do.
Probably only allowing it when SGLs are in use, including a flag to
force using it.

