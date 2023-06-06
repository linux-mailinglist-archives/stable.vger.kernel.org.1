Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8BE723811
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 08:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjFFGsu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFFGst (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 02:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A191
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 23:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 243E8621DD
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 06:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155BDC433D2;
        Tue,  6 Jun 2023 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686034127;
        bh=Bav9iM9rMKcodMY0mUucuDU82CNLgghrfwFEi3/Jo98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZRcleDASd4WVrkft+mAe5HcJtgLUDIcOlHl6HRXyHEDquUy/fjWXiHBu1K25LU7Z
         8NoFamgRreC6uugGXfUDgz/vGS3bFH9rwqucH2BWPQLeusbp4YoPkhxtAO0HX3GqYR
         36758HFdfldoIZh0/eBSzDg+O2vAzSJklLMuI43o=
Date:   Tue, 6 Jun 2023 08:48:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Kochera <kochera@google.com>
Cc:     stable@vger.kernel.org
Subject: Re: Backport fix for CVE-2023-2124
Message-ID: <2023060655-superglue-occupier-80a9@gregkh>
References: <CAN1hJ_P+FG3ac4iV8AocZfffGC_dMUSZfpXKH4zPO1LS8+8RCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN1hJ_P+FG3ac4iV8AocZfffGC_dMUSZfpXKH4zPO1LS8+8RCQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 05, 2023 at 03:54:54PM -0600, Michael Kochera wrote:
> Hello, the following patch cherry-picked cleanly during my testing.
> 
> Subject of Patch: xfs: verify buffer contents when we skip log replay
> Commit Hash: 22ed903eee23a5b174e240f1cdfa9acf393a5210
> Reason why it should be applied: This fixes CVE-2023-2124.
> Kernel Versions to be applied to: 6.1, 5.15, 5.10

The xfs maintainers have their own process for getting patches into the
stable tree.  Please at the least, cc: them in order so that they can
review the changes to see if they are relevant or not.

Did you test the above change that it solves the problem?  If so, can
you provide a "Tested-by:" for it?

thanks,

greg k-h
