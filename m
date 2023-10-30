Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39C7DBED5
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 18:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjJ3RZn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 13:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJ3RZn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 13:25:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD999
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 10:25:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D3BC433C8;
        Mon, 30 Oct 2023 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698686741;
        bh=ortTzTenVrQdu4BpkdbctsBV/qUBuB31wOB8PhQ1rBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mT9IYEw4b7Up1VfhbsheIxHksrDhuMaU/0QowFbTbyw5RQ3JqoMHR3fZ0tNcaxKwG
         y6fhdagNGC/SF79Yu8E2Khw6XR4Bnmwvu/9sNGEFdP/GNHPPgsXX+VyxMNSXEwPfVi
         kod4wK1tpXCBr3CciTw9dfyF3juiAw2o/MUlgzmY=
Date:   Mon, 30 Oct 2023 18:25:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Subject: Re: Security Fix Backport: Intel RDMA driver
Message-ID: <2023103015-footpath-veggie-63fb@gregkh>
References: <MWHPR11MB00293EBF6DD3DAA4C836E382E9A1A@MWHPR11MB0029.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB00293EBF6DD3DAA4C836E382E9A1A@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 30, 2023 at 04:47:01PM +0000, Saleem, Shiraz wrote:
> Hi,
> 
> There was a security bug fix recently made to the Intel RDMA driver (irdma) that has made to mainline.
> 
> https://github.com/torvalds/linux/commit/bb6d73d9add68ad270888db327514384dfa44958
> subject: RDMA/irdma: Prevent zero-length STAG registration
> commit-id: bb6d73d9add68ad270888db327514384dfa44958
> 
> This problem in theory is possible in i40iw as well. i40iw is replaced with irdma upstream since 5.14.
> 
> However, i40iw is still part of LTS 4.14.x, 4.19.x, 5.4.x, and 5.10. Since it is a security fix, I am thinking its reasonable we backport it to i40iw too for these kernels. The patch would need some adjustments and I can do this if required.

If you feel it is needed, yes, please do the needed backport and submit
it here.

thanks,

greg k-h
