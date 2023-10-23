Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1D7D2FBC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjJWKYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjJWKYJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:24:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141C2102
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:23:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807D0C433C7;
        Mon, 23 Oct 2023 10:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698056619;
        bh=HiH8+lPc1t66You5vfBwcEQDJO/OtErY/hGxnULGrvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1lxZBI8EBImldSZny0sxXuLu7/CInS9jkmEh3JiCuot//4oyfLiyODgwcyW7gZtAO
         zm9in6EozJaqiPlaNBofQquvXTm0XEGHn++4unqOYz63e1Z0FUUnmt5MGcIFie/0Ty
         D0Q02ANOKEM8MPJLuMnFCkHxYiVFkhLakWw58u4E=
Date:   Mon, 23 Oct 2023 12:23:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4.14.y 0/1] Return EADDRNOTAVAIL when func matches
 several symbols during kprobe creation
Message-ID: <2023102317-liberty-kelp-3492@gregkh>
References: <2023102140-tartly-democrat-140d@gregkh>
 <20231023094947.258663-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023094947.258663-1-flaniel@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 23, 2023 at 12:49:46PM +0300, Francis Laniel wrote:
> Hi.
> 
> 
> I received messages regarding problems to apply the upstream patch.
> I was able to reproduce the problem on the following stable kernels:
> * 4.14,
> * 4.19,
> * 5.4
> * and 5.10
> But it seems to be false positive for kernel 5.15 and 6.1, is this case possible
> or I did something wrong?

Did you try to build with the patch applied?  That might be the issue
for those kernels.

thanks,

greg k-h
