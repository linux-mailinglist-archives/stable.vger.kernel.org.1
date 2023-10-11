Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ADD7C4A82
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjJKGZV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 02:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345225AbjJKGZU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 02:25:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D2B6
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 23:25:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6664EC433C7;
        Wed, 11 Oct 2023 06:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697005518;
        bh=fbABpt57oyvBzr7MqQakhuu6vprh4A4yq0O9urYFSyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bayeAah0No+7A9o7C0L3GgS29P5L8pfaO+6qSnwjS9ZC5FW5YV0u9QSCdy/CrC9tA
         Xf2UBCsK+kB2HExnSB/NZ39nIQHJ1Yda+JLKM23hVO9tPOMikLl2L1CXi5rP9Cr9Iz
         jNljQ4OMzZ+q4/8kv644vOPcnWWA7AhxdukpvgkM=
Date:   Wed, 11 Oct 2023 08:25:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        gfs2@lists.linux.dev, christophe.jaillet@wanadoo.fr,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND 4/8] dlm: fix creating multiple node structures
Message-ID: <2023101138-rickety-collector-e9fc@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
 <20231010220448.2978176-4-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010220448.2978176-4-aahringo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 06:04:44PM -0400, Alexander Aring wrote:
> This patch will lookup existing nodes instead of always creating them
> when dlm_midcomms_addr() is called. The idea is here to create midcomms
> nodes when user space getting informed that nodes joins the cluster. This
> is the case when dlm_midcomms_addr() is called, however it can be called
> multiple times by user space to add several address configurations to one
> node e.g. when using SCTP. Those multiple times need to be filtered out
> and we doing that by looking up if the node exists before. Due configfs
> entry it is safe that this function gets only called once at a time.
> 
> Cc: stable@vger.kernel.org
> Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/midcomms.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Why does patch 4/8 have a cc: stable, when it depends on patches 1-3 as
well?  That is going to drive us crazy when it hits Linus's tree, how do
we know the dependancies here anymore?

thanks,

greg k-h
