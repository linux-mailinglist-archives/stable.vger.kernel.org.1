Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08716F02A5
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 10:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbjD0Ifq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjD0Ifp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 04:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EAE49D8;
        Thu, 27 Apr 2023 01:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA42663B9C;
        Thu, 27 Apr 2023 08:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1E5C433EF;
        Thu, 27 Apr 2023 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682584544;
        bh=56ZuxxjVGQ0wwMl+CYr8NbxhIuyIPhOPGsSWzFEbVRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlFT4lcftBtOXr8y8aniYxD4y6io34mF2cjt3bWQbnHjCyG4qyNXJMtIAfb2KoVNM
         nEXix/tlhrQ4ggnSYYydsZsqI0TC4uh6DhUDiuYq4wV3AhFkNAvr9bw83ys8d3Px3J
         AP6TM+5knJTPHKZ1+8OiqRth7tXLhhVQ0UqPhZI4=
Date:   Thu, 27 Apr 2023 10:35:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     stable@vger.kernel.org, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 1/1] linux-6.2/rcu/kvfree: Avoid freeing new kfree_rcu()
 memory after old grace period
Message-ID: <2023042735-book-upstate-b209@gregkh>
References: <20230425164541.423811-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425164541.423811-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Apr 25, 2023 at 06:45:41PM +0200, Uladzislau Rezki (Sony) wrote:
> From: Ziwei Dai <ziwei.dai@unisoc.com>
> 
> commit 5da7cb193db32da783a3f3e77d8b639989321d48 upstream.
> 

Now queued up, thanks.

greg k-h
