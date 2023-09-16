Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8F7A2FB9
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjIPLgF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjIPLfw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:35:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A1BCC4
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:35:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66287C433C8;
        Sat, 16 Sep 2023 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864147;
        bh=65lUWC0xOqZC+2fzoKnYWNPyNeDMVox/eXWFhjQ2iog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjtpzDO6g8WHgYxxfCNfVKg5+4o1eA9c3nU14or+oMWw76oSddpFFRb7LXdPtBMbP
         MKtrOEzdL/ZpclWEWP05XxOoumBgxeKqM6CfuTQl/dJWZ7Sr+7++R6a2LBGe+rlqNw
         4wQ4LQT1Co5LpYROYjZHKy7ZTxBvv3RoWqmtci6Q=
Date:   Sat, 16 Sep 2023 13:35:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gerhorst@cs.fau.de
Cc:     alexei.starovoitov@gmail.com, ast@kernel.org, eddyz87@gmail.com,
        laoar.shao@gmail.com, patches@lists.linux.dev,
        stable@vger.kernel.org, yonghong.song@linux.dev,
        hagarhem@amazon.de, puranjay12@gmail.com, daniel@iogearbox.net,
        Luis Gerhorst <gerhorst@amazon.de>
Subject: Re: [PATCH 6.1 562/600] bpf: Fix issue in verifying allow_ptr_leaks
Message-ID: <2023091653-peso-sprint-889d@gregkh>
References: <20230911134650.200439213@linuxfoundation.org>
 <20230914085131.40974-1-gerhorst@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914085131.40974-1-gerhorst@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 14, 2023 at 08:51:32AM +0000, Luis Gerhorst wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> > 
> > From: Yafang Shao <laoar.shao@gmail.com>
> > 
> > commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2 upstream.
> 
> I unfortunately have objections, they are pending discussion at [1].
> 
> Same applies to the 6.4-stable review patch [2] and all other backports.
> 
> [1] https://lore.kernel.org/bpf/20230913122827.91591-1-gerhorst@amazon.de/
> [2] https://lore.kernel.org/stable/20230911134709.834278248@linuxfoundation.org/

As this is in the tree already, and in Linus's tree, I'll wait to see
if any changes are merged into Linus's tree for this before removing it
from the stable trees.

Let us know if there's a commit that resolves this and we will be glad
to queue that up.

thanks,

greg k-h
