Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB547CB294
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJPSeq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjJPSep (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 14:34:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E7ED
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 11:34:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CD6267373; Mon, 16 Oct 2023 20:34:38 +0200 (CEST)
Date:   Mon, 16 Oct 2023 20:34:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <20231016183438.GA15911@lst.de>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com> <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de> <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp> <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de> <CA+1E3r+gSWvN3VR38Uu=rHLy=9+iC-G5ta2sXq6LEXTG+OK_-g@mail.gmail.com> <ZS2BA_Oj4kcwRbiY@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2BA_Oj4kcwRbiY@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 12:29:23PM -0600, Keith Busch wrote:
> It sounds like the kernel memory is the only reason for the concern, and
> you don't really care if we're corrupting user memory. If so, let's just
> use that instead of kernel bounce buffers. (Minor digression, the
> current bounce 'buf' is leaking kernel memory on reads since it doesn't
> zero it).

No, arbitrary memory overwrite is always an issue, userspace or kernel,
data or metadata buffer.

Note that even without block layer bounce buffering, there can always
be other kernel memory involved, e.g. swiotlb.

We need to get the fix to disable the unprivileged passthrough in ASAP.

