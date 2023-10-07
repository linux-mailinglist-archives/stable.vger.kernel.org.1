Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EAD7BC715
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 13:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbjJGLWH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 07:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbjJGLWG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 07:22:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77648B6;
        Sat,  7 Oct 2023 04:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CB0C433C8;
        Sat,  7 Oct 2023 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696677725;
        bh=Z5uEds1Mo99/fmj7mVc1AcM0874N3EkljcgDY7j9jSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIqjDr7E+QSsNPIJbf1T2sZ2bm/euOWRYPbQxRPe4L+ZJ9FJgNfWQVBffyDNxBVUx
         M/sN7cycEzhv020tJW2YWoyBTuTVOSUafG+5X26Nap3002ykWVYhyfC1DCYvqeHvx6
         uE5c+1Wt1oF2S50Cp48MJJXyfqTdIWQPWugM06Ys=
Date:   Sat, 7 Oct 2023 13:22:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksandr Mezin <mezin.alexander@gmail.com>
Cc:     stable@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: hwmon: (nzxt-smart2) backport device ids to v6.1
Message-ID: <2023100753-quarrel-harbor-a6f3@gregkh>
References: <CADnvcfJn--J-51tjOVe2Z55Y8CxnXePXmP9V_j9HkVOt-RH4LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnvcfJn--J-51tjOVe2Z55Y8CxnXePXmP9V_j9HkVOt-RH4LA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 22, 2023 at 09:33:56PM +0300, Aleksandr Mezin wrote:
> Please pick the following commits:
> 
> - e247510e1baad04e9b7b8ed7190dbb00989387b9 hwmon: (nzxt-smart2) Add device id
> - 4a148e9b1ee04e608263fa9536a96214d5561220 hwmon: (nzxt-smart2) add
> another USB ID
> 
> into v6.1 stable kernel. They add device ids for nzxt-smart2 hwmon
> driver, and they don't require any other code changes. This will
> synchronize the driver code with v6.3.

Both now queued up, thanks.

greg k-h
