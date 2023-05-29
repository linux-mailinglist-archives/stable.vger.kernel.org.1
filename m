Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99410714C1F
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjE2Og1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE2OgZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 10:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E55A0;
        Mon, 29 May 2023 07:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45CD66259C;
        Mon, 29 May 2023 14:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624F4C433EF;
        Mon, 29 May 2023 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685370983;
        bh=eal3a2td60OrnI/gl07U5Mo+TkS2btUmcGfjgogDJz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEXijtnKYoFmUUI+KnfmZysRjLlx4ciqA80bYdV3gmfVlmBBtZMZaoN8Y8xwGRvK7
         LSqh4MoILCSniVCvKQirw4OC5uo1sGQa5uZAvi4ykRBCklJMPpcYFQ9AYXBlV2GeMh
         ErD6JDi/M912oxOHya9bqYtOme9VNqc/CLuOwHOo=
Date:   Mon, 29 May 2023 15:36:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: usb: snps,dwc3: Fix
 "snps,hsphy_interface" type
Message-ID: <2023052903-eggbeater-ranking-4b3e@gregkh>
References: <20230515172456.179049-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515172456.179049-1-marex@denx.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 07:24:56PM +0200, Marek Vasut wrote:
> The "snps,hsphy_interface" is string, not u8. Fix the type.
> 
> Fixes: 389d77658801 ("dt-bindings: usb: Convert DWC USB3 bindings to DT schema")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
> V2: Add Fixes, RB from Krzysztof, CC stable

You need to put the cc: stable up there above the --- line.  I'll go do
it by hand...

