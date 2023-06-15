Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6C730EDF
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 07:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjFOFxy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 01:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFOFxx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 01:53:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E8410E9;
        Wed, 14 Jun 2023 22:53:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7468067373; Thu, 15 Jun 2023 07:53:49 +0200 (CEST)
Date:   Thu, 15 Jun 2023 07:53:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        martin@lichtvoll.de, fthain@linux-m68k.org, stable@vger.kernel.org
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
Message-ID: <20230615055349.GA5544@lst.de>
References: <20230615030837.8518-1-schmitzmic@gmail.com> <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de> <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 15, 2023 at 04:50:45PM +1200, Michael Schmitz wrote:
>> And as far as I can tell everything that is a __u32 here should
>> be an __be32 because it is a big endian on-disk format.  Why
>> would you change only a single field?
>
> Because that's all I needed, and wanted to avoid excess patch churn. Plus 
> (appeal to authority here :-)) it's in keeping with what Al Viro did when 
> the __be32 annotations were first added.
>
> I can change all __u32 to __be32 and drop the comment if that's preferred.

That would be great!

