Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBDC7D2E45
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjJWJ3L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 05:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjJWJ3G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 05:29:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B083B7
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 02:29:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3EAC433CA;
        Mon, 23 Oct 2023 09:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698053343;
        bh=HT5FJIXb0NtZ/8xZkSTNupDHYvxznXdoBkYHMpHmDw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBnIaKukikXygMHays0geDmWNfqHgR4Zm5TuUmZDIrE1BM9/2vCypU2jvS9rgSSFR
         y5HdN0hEP5Gi2s8XdvfOD5QEY3Ypu0dUPKtKW/o+lCGfwyFBiOTR22dTjTuv262hpz
         MqminLUR4LGTtT5ljpLehYZ3GKcY/Vddodpw1n5ilvUA/6ndkWQk3iuNE2oW4AiHq5
         N7sP5usKTclXcwVnBNx40JRWtnF/UsepQMymx3ojmfb8mBZcrxkaqBcwWu9DLKMsIe
         J39QsNGBuwYYzBkK3aI7stYs1va7qqse1Fa71ZkazIatfME8eDqFogK48a+QXHC8QR
         bHf+k1xTqSgaA==
Date:   Mon, 23 Oct 2023 10:28:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4.14.y 1/2] driver: platform: Add helper for safer
 setting of driver_override
Message-ID: <20231023092859.GC8909@google.com>
References: <20231018120611.2110876-1-lee@kernel.org>
 <2023102055-overkill-emphases-8044@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023102055-overkill-emphases-8044@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 20 Oct 2023, Greg Kroah-Hartman wrote:

> On Wed, Oct 18, 2023 at 01:06:06PM +0100, Lee Jones wrote:
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > commit 6c2f421174273de8f83cde4286d1c076d43a2d35 upstream.
> 
> <snip>
> 
> Why only 2 4.14.y patches and not 3 like the 4.19.y and other series?
> 
> confused,

Because the function fixed by the other [PATCH 2/3] patches doesn't
exist in to v4.14.

-- 
Lee Jones [李琼斯]
