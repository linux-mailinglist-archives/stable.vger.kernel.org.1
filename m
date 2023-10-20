Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEBD7D13BA
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377790AbjJTQJU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377756AbjJTQJU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 12:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC09114
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 09:09:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4C1C433C7;
        Fri, 20 Oct 2023 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697818158;
        bh=pUXAGo87u0SwfuM+mxNsSdIt4mx/743us+LpcbAUW3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zlOOMDR7cH7fMF4x4evIrhRKmc9STuao7DziSOiF0IkacKOw6vA1VhNidBf+SHDR7
         EyJVwqCz/4ngwMtGT7ALd0w6MMCx0v+UA1IdnC8GhLYItyz8iQepe2Fcy+R+0XQ0DC
         zBrNrqYWSxd58soacypAdTBWb1Tux1l1vGyp0ZNg=
Date:   Fri, 20 Oct 2023 18:09:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4.14.y 1/2] driver: platform: Add helper for safer
 setting of driver_override
Message-ID: <2023102055-overkill-emphases-8044@gregkh>
References: <20231018120611.2110876-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018120611.2110876-1-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 01:06:06PM +0100, Lee Jones wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> commit 6c2f421174273de8f83cde4286d1c076d43a2d35 upstream.

<snip>

Why only 2 4.14.y patches and not 3 like the 4.19.y and other series?

confused,

greg k-h
