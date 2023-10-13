Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737357C7CFA
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 07:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMF0U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 01:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMF0U (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 01:26:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F968B7
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 22:26:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB4C967373; Fri, 13 Oct 2023 07:26:12 +0200 (CEST)
Date:   Fri, 13 Oct 2023 07:26:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <20231013052612.GA6423@lst.de>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com> <20231013051458.39987-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013051458.39987-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
> Changes since v3:
> - Block only unprivileged user

That's not really what at least I had in mind.  I'd much rather
completely disable unprivileged passthrough for now as an easy
backportable patch.  And then only re-enable it later in a way
where it does require using SGLs for all data transfers.

