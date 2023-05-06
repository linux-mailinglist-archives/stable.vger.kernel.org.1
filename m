Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500B36F8EC7
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjEFFwE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEFFwA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9368F7EF0
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCBE615D9
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A376FC4339B;
        Sat,  6 May 2023 05:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352318;
        bh=z7G8mzNJb9gG2C+pg+t3jRVWabBiovs3MONF1l39RzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f66vhcOSuVCQ2liRL6VPtlfW53ri3s4rqpablb/nztkcg2OfwJGfebD54v+9JRN+q
         ALJ7tRV7mGB4I4TcIzheXiaznxsTP7xThUy99oX7b+Sh+9D2b2B8oosFNsAMYZDlTz
         z7H168fFM2yZSNFJsTi+aFdZz0PxKDFzdFi/Qeqw=
Date:   Sat, 6 May 2023 09:59:52 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: stable backports for arm64 shadow call stack pointer hardening
 patches
Message-ID: <2023050636-had-crabgrass-e9c4@gregkh>
References: <CAMj1kXHCN0CuB86RpE_y=2KOo=KR80KjBzEMTPkmxxn8=D4uaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHCN0CuB86RpE_y=2KOo=KR80KjBzEMTPkmxxn8=D4uaA@mail.gmail.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 02, 2023 at 11:57:38AM +0200, Ard Biesheuvel wrote:
> Please backport the following changes to stable kernels v5.10 and newer:
> 
> 2198d07c509f1db4 arm64: Always load shadow stack pointer directly from
> the task struct
> 59b37fe52f499557 arm64: Stash shadow stack pointer in the task struct
> on interrupt

These did not apply to 5.10.y, but they applied to newer kernels.

thanks,

greg k-h
