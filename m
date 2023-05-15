Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C363702D02
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbjEOMqy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbjEOMqw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4011A6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC9E61DC0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EDBC433D2;
        Mon, 15 May 2023 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684154808;
        bh=dpoHamVFG+cwgOWw/S4Qqs82u1tSCdn6SeV4KKeluK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0H/i6XcuTQ/a1LrLan8XD8oY/fQGKrGQ2DhO1bZFfFCSqth8GWUoLtRKBzAHAJ6vR
         sa/ghXbjvMthhwKLhkA0sZi4slyaAVBAuOxASq9pNNfDKVCTE6LP53tx8rtGUbcM15
         L8GXltb9xTZVilgjnlKvgpyriX/7dVrJQWp6llfY=
Date:   Mon, 15 May 2023 14:46:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 5.10.y] bus: mhi: host: Range check CHDBOFF and ERDBOFF
Message-ID: <2023051536-ammonium-tropical-bfd9@gregkh>
References: <2023050613-slacked-gush-009c@gregkh>
 <1683733522-13432-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683733522-13432-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 10, 2023 at 09:45:22AM -0600, Jeffrey Hugo wrote:
> Commit 6a0c637bfee69a74c104468544d9f2a6579626d0 upstream.
> 
> If the value read from the CHDBOFF and ERDBOFF registers is outside the
> range of the MHI register space then an invalid address might be computed
> which later causes a kernel panic.  Range check the read value to prevent
> a crash due to bad data from the device.
> 
> Fixes: 6cd330ae76ff ("bus: mhi: core: Add support for ringing channel/event ring doorbells")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Link: https://lore.kernel.org/r/1679674384-27209-1-git-send-email-quic_jhugo@quicinc.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/bus/mhi/core/init.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

This breaks the build, did you test it?

