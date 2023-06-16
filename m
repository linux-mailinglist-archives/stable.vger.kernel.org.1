Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A87326C5
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 07:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjFPFsw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 01:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbjFPFsv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 01:48:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3882D5E;
        Thu, 15 Jun 2023 22:48:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D30767373; Fri, 16 Jun 2023 07:48:47 +0200 (CEST)
Date:   Fri, 16 Jun 2023 07:48:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-m68k@vger.kernel.org, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
Message-ID: <20230616054847.GB28499@lst.de>
References: <20230615030837.8518-1-schmitzmic@gmail.com> <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de> <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com> <20230615055349.GA5544@lst.de> <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com> <69ecfff9-0f18-abe7-aa97-3ec60cf53f13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ecfff9-0f18-abe7-aa97-3ec60cf53f13@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 16, 2023 at 07:53:11AM +1200, Michael Schmitz wrote:
> Thanks - now there's two __s32 fields in that header - one checksum each 
> for RDB and PB. No one has so far seen the need for a 'signed big endian 32 
> bit' type, and I'd rather avoid adding one to types.h. I'll leave those as 
> they are (with the tacit understanding that they are equally meant to be 
> big endian).

We have those in a few other pleases and store them as __be32 as well.  The
(implicit) cast to s32 will make them signed again.
