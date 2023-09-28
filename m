Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D17B1B02
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjI1Lao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjI1Lan (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 07:30:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A079C;
        Thu, 28 Sep 2023 04:30:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26019C433C8;
        Thu, 28 Sep 2023 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695900642;
        bh=XUGjjfqZSfPT6r6W3F0evqoEC0B03asOvLdRaYwqxnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeYl3VOfsZ9gigdil3ijduxX9QflhRm+zWHaUiejR/DcVH42YKvE5F8DPWFMcWCLb
         zWizPZdfNCc31/7YOgk7SIiCBxnoefl2fjyrL+4dxQtFvd2n1sExPgQYkCn2wjxEd4
         yBcMaTAGx23MZc37t2av99pcpdRhT9Doij3HAsm1OImsDwxs7sDPYcQksCUZxV9zfH
         OM3snX/ANMyu1/oIDcKVvujVcefqY+CuuJx74jPAoVKStt0ZjXzqukll1RNgA/JISI
         XpKK8punC8um+K+pd1Uvo8tVHMCIgP0bDehk5H5EO6KY8ptMaLc3AOON/rs6rz2dWv
         Yc9S6mZr7thHQ==
Date:   Thu, 28 Sep 2023 07:30:40 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH -stable,5.10 0/2] Netfilter stable fixes for 5.10
Message-ID: <ZRVj4OD1PNl+ZK0t@sashalap>
References: <20230927153007.562809-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230927153007.562809-1-pablo@netfilter.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 27, 2023 at 05:30:05PM +0200, Pablo Neira Ayuso wrote:
>Hi Greg, Sasha,
>
>The following small batch contains two more fixes for a WARNING splat on
>chain unregistration and UaF in the flowtable unregistration that is
>exercised from netns path for 5.10 -stable.
>
>I am using original commit IDs for reference:
>
>1) 6069da443bf6 ("netfilter: nf_tables: unregister flowtable hooks on netns exit")
>
>2) f9a43007d3f7 ("netfilter: nf_tables: double hook unregistration in netns path")
>
>Please, apply.

Queued up, thanks!

-- 
Thanks,
Sasha
