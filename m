Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32A7326C8
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 07:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbjFPFtZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 01:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjFPFtY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 01:49:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E92702;
        Thu, 15 Jun 2023 22:49:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA3AE67373; Fri, 16 Jun 2023 07:49:20 +0200 (CEST)
Date:   Fri, 16 Jun 2023 07:49:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org, stable@vger.kernel.org
Subject: Re: [PATCH v11 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
Message-ID: <20230616054920.GC28499@lst.de>
References: <20230616011907.26498-1-schmitzmic@gmail.com> <20230616011907.26498-3-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616011907.26498-3-schmitzmic@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
