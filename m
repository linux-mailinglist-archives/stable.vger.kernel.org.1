Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBE7A777F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjITJ3f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjITJ3b (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:29:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46959D3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:29:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168EFC433C7;
        Wed, 20 Sep 2023 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695202164;
        bh=opUZe8KOB8c38Djs4O6OFWzIGscsq6EqXBH1itvaXvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GURHlvpCRcS2WI8D7eckgGqIaKVUUCYrM3/dbQDhNHX7OMJX58PIYdzW7QYruJJwo
         qxxVLh7dZpxSmj6tICnZKYfSNLlDhbAn4mhJu/O/HqHeB2EX3DBPJKfQ4kJS4sQZ+Q
         BNqevOqCsHCJJ6LEZ6SQJfcRUjy2Q6nt8UySnLabWrUrk7OW9bMCXdh3QE/+O8934S
         Ic9ALP99oLn6Nf4sONtpRKPKg8s9OiLu+be29GarMcEx6bxpqMFKmZ0mb6U3l3oKMN
         Zyxuf4vueI5ZT2mrYTV/2jU9KMnYvhj8jLnfAb9XC5iNgUWgvNHgNEyPykscf1MJD6
         nj59PpHuRpvzg==
Date:   Wed, 20 Sep 2023 10:29:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH 0/5] netfilter: Reinstate dropped Stable patches
Message-ID: <20230920092920.GB13143@google.com>
References: <20230919164437.3297021-1-lee@kernel.org>
 <ZQnRAGKWu5Nm/qLw@calendula>
 <ZQnRkDY8YTysf1mo@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQnRkDY8YTysf1mo@calendula>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 19 Sep 2023, Pablo Neira Ayuso wrote:

> On Tue, Sep 19, 2023 at 06:49:08PM +0200, Pablo Neira Ayuso wrote:
> > Hi,
> > 
> > On Tue, Sep 19, 2023 at 05:44:28PM +0100, Lee Jones wrote:
> > > Dropped in August:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=da9e96b4de57f6621f21e682bad92b5ffed0eeee
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=8d1dbdfdd7612a9ea73b005f75a3b2b8b0610d4e
> > > 
> > > Only re-applied and build tested against v6.1.53.
> > > 
> > > If they do apply and test well against linux-5.{4,10,15}, all the better.
> > 
> > I have a pending queue of patches for all these trees.
> > 
> > I will follow up asap, please hold on with this.
> 
> For the record, this is my pending list of -stable patches:
> 
> https://people.netfilter.org/pablo/linux-stable/
> 
> I will rebase on top of current -stable releases and post them. There
> is also a few more recent fixes not yet in that queue that are also
> good to have.
> 
> so, please, let me take care of this.

Sure.

-- 
Lee Jones [李琼斯]
