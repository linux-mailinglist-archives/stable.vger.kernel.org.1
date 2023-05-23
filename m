Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4870DB8A
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjEWLfg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjEWLfg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 07:35:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11EFA;
        Tue, 23 May 2023 04:35:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C508B6732D; Tue, 23 May 2023 13:35:31 +0200 (CEST)
Date:   Tue, 23 May 2023 13:35:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anuj Gupta <anuj20.g@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        gost.dev@samsung.com, anuj1072538@gmail.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] block: fix bio-cache for passthru IO
Message-ID: <20230523113531.GA28790@lst.de>
References: <CGME20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b@epcas5p2.samsung.com> <20230523111709.145676-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523111709.145676-1-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 04:47:09PM +0530, Anuj Gupta wrote:
> +	if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <= BIO_INLINE_VECS)) {

The inner braces are superflous.
