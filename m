Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB97297E5
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbjFILMB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbjFILLV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 07:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5930D8
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 04:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC56F656E9
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 11:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CCFC433D2;
        Fri,  9 Jun 2023 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686309076;
        bh=jPCIT6JOyXi0mlomAF7pEMTNGCHWIKgsNq/RthLHOf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GB9GFYlvaPZNQm5LMIW6z+i5Y2HEB4dtr3pgn8nOZb62a5g+JF81n+Q1xgLmCY0wg
         h/IksODZ53/L00Q0pnrcoBeCYzrl9i40EoJByaDVMj2lcn74qyOPlLCIlX8t1LPW/5
         EJrbHSKKSTfRTDIuNsbcIeaEGWUTIvw/iA7FpY4M=
Date:   Fri, 9 Jun 2023 13:11:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: f2fs: fix iostat lock protection
Message-ID: <2023060944-exterior-taco-200a@gregkh>
References: <CA+PiJmQRvJSARPejSHuQY2J_f4ZxMqH6Zps9YZNJbvwtgUDjQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PiJmQRvJSARPejSHuQY2J_f4ZxMqH6Zps9YZNJbvwtgUDjQg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 07, 2023 at 02:54:38PM -0700, Daniel Rosenberg wrote:
> 144f1cd40bf91fb3 ("f2fs: fix iostat lock protection")
> 
> Fixes a deadlock present since 4.14

Doesn't apply to 5.4.y and older, but I've added it to the newer ones.

If you want it in the older kernels, please submit working backports.

thanks,

greg k-h
