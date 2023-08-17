Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0377FF4E
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354914AbjHQUw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355057AbjHQUwB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 16:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A913598
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 13:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD34E636A4
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 20:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA3BC433C8;
        Thu, 17 Aug 2023 20:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692305500;
        bh=PmpBtuiqPTqaqph0epv2hT4fSOfd1jXNPG7ZYGJm59I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7StYACezEjphx1sX1MBXMN9I2dDyK8AlkBVLjV/jwY6arh/SJeh6x71FMrPjnI3f
         o0nZuG275bhTgoKPBYgSHdxdufJNSy+9Ig6pTHYrl/EVMZBGBLQdHjPSN98jlAn1gw
         65UB/gBCmG20KEaCdM1WSkclu8amX3p50MmxJ+h8=
Date:   Thu, 17 Aug 2023 22:51:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SG <prosparety@danwin1210.de>
Cc:     stable@vger.kernel.org
Subject: Re: Request to add a patch to Stable Branch 6.1
Message-ID: <2023081712-flock-collapse-5cda@gregkh>
References: <bfd58918-d130-5b88-bd9e-39611fdbbfae@danwin1210.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd58918-d130-5b88-bd9e-39611fdbbfae@danwin1210.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 17, 2023 at 07:33:11PM -0000, SG wrote:
> (Before starting, i want to say i am not the developer of the patch, i am
> just an end user of a distribution kernel, which has just faced some
> problem, i don't even know if kernel team accepts patch requests from non
> dev, and thi mail is mostly shot in dark)
> 
> Respected Sir/s/Ma'am/s
>     I want to request that patch
> https://lore.kernel.org/all/20230627062442.54008-1-mika.westerberg@linux.intel.com/#r
> be accepted in to the stable 6.1 branch, it is already present in the
> current branch, and i request for it to be backported. This fixes some
> Intel CPUs (according to other users claims, ranging back to 6th gen
> for some) not going to deeper c states with kernels 5.16+, and was
> fixed by this patch in 6.4.4+, since many institutions, and
> distributions use 6.1, it would be great if this is included (from
> what i understand from requirements
> (https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html)
> i guess it fits all)

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h
