Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296067DCFB8
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbjJaOt2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344323AbjJaOt1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 10:49:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1ABDB
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 07:49:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F052EC433C8;
        Tue, 31 Oct 2023 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698763765;
        bh=jX9X488M46nSgOf3u2MjOiUV05GZ1qk283hkNBcnTkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qyas4pQiyJkvg0JmZoDayzxemtfg2Lf89gDH6FV+o4xtdEfsbuSG9kBIECOzmjSKy
         USynr8Xaly5IW2WTL74jQ2Wc94ymMHmu+OyFoJXnj9LxJcCaMx3ow1IgzBVdTYQTmR
         hSeoLJxgD6cSW2whKM+uhBb6zLJnpLYTEq35RCPQ=
Date:   Tue, 31 Oct 2023 15:49:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4.14.y 1/5] driver: platform: Add helper for safer
 setting of driver_override
Message-ID: <2023103106-morse-cesarean-80d9@gregkh>
References: <20231031114155.2289410-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031114155.2289410-1-lee@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 11:41:46AM +0000, Lee Jones wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> commit 6c2f421174273de8f83cde4286d1c076d43a2d35 upstream.

All now queued up, thanks,

greg k-h
