Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5D7267E4
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFGSAn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjFGSAm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E7719D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDA96396D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE03CC433EF;
        Wed,  7 Jun 2023 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686160840;
        bh=dbJGvnpAAU3aNlhh+mNF60HQIDtPKqzissUhYAtP7yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0ZsxEJNVvQJKCFUGXgYasJ5OSEnQCFlmOQWeNdB+ABqmM7J5vU9q143ew0LukHrL
         ok58iU3GGDkUACOsX/XIyBjytpvyi1MV7aEbYYfQGhEAydsbk7aWribqikHwbeN1Fs
         eh0csQtisXPX93tR52+ZUFj+QFfEHq7U7yX4VYAY=
Date:   Wed, 7 Jun 2023 20:00:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.3 145/364] staging: rtl8192e: Replace macro
 RTL_PCI_DEVICE with PCI_DEVICE
Message-ID: <2023060719-smasher-deluxe-e339@gregkh>
References: <20230522190412.801391872@linuxfoundation.org>
 <20230522190416.389735437@linuxfoundation.org>
 <aa0d401a7f63448cd4c2fe4a2d7e8495d9aa123e.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0d401a7f63448cd4c2fe4a2d7e8495d9aa123e.camel@decadent.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 02, 2023 at 08:35:31PM +0200, Ben Hutchings wrote:
> On Mon, 2023-05-22 at 20:07 +0100, Greg Kroah-Hartman wrote:
> > From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > 
> > [ Upstream commit fda2093860df4812d69052a8cf4997e53853a340 ]
> > 
> > Replace macro RTL_PCI_DEVICE with PCI_DEVICE to get rid of rtl819xp_ops
> > which is empty.
> 
> It is not empty (except in 6.4).
> 
> This needs to be reverted from all stable branches.

{sigh}  You are right.  I'll go revert it from everywhere, thanks for
the review and letting me know.

greg k-h
