Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8037881FE
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjHYI0e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbjHYI0e (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 04:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5D19A1
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 01:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0824262450
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 08:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3918C433C8;
        Fri, 25 Aug 2023 08:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692951991;
        bh=rS7nJOT7jSNBOOFuhSPsGo80VRBi0vicxS2o2qswm/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjCCjOu6AUQrtVUV58wtAUW6Vg9SCK1JYvdhzJwJhhaOarGh5aoIRTRxp9c+AOqsr
         jW5E5UVUzHtPWN0CrMBXKD1PIfs/Ge8URvLQubyS7IBh6Sj27QDuCL+u0pI5AobZNC
         gb8WUCF1y0BmJrG2u6A4MtmLl9Wqdk5wpoC7oDv4=
Date:   Fri, 25 Aug 2023 09:12:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 054/135] usb: cdnsp: Device side header file for
 CDNSP driver
Message-ID: <2023082541-reshape-bagel-f9f2@gregkh>
References: <20230824170617.074557800@linuxfoundation.org>
 <20230824170619.509775632@linuxfoundation.org>
 <BYAPR07MB5381AFFA172B5646A78FB009DDE3A@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR07MB5381AFFA172B5646A78FB009DDE3A@BYAPR07MB5381.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 25, 2023 at 07:01:52AM +0000, Pawel Laszczak wrote:
> Hi Greg,
> 
> I don't understand why this is queued for 5.10 stable version.
> 
> Driver has been upstreamed into 5.12 version.

Which specific driver?  cdns3 is in 5.10

> >Because the size of main patch is very big, I’ve decided to create
> >separate patch for cdnsp-gadget.h. It should simplify reviewing the code.
> >
> >Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >Signed-off-by: Peter Chen <peter.chen@nxp.com>
> >Stable-dep-of: dbe678f6192f ("usb: cdns3: fix NCM gadget RX speed 20x slow
> >than expection at iMX8QM")

The patch was taken as a dependancy of this commit, which is fixing an
issue for the change that went into 5.4, which is in 5.10.y.

Maybe the dependancy checker got this incorrect, let me go see...

thanks,

greg k-h
