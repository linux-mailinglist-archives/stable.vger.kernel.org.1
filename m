Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EB7C684D
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjJLIqB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjJLIqA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 04:46:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104798
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 01:45:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8BEC433C8;
        Thu, 12 Oct 2023 08:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697100359;
        bh=7mxnM53+nn0jTR8CYqrcjxMadVuQePPv6iqgMSWERGs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oAuNaEjXa8L/p9QRGnjlto5Qx0MSKD2ZvDCF57wGtahEndrebicCJbX2EWCOiTnLq
         IcYGnArQqOlYWWgaPMTUZBPH3bYM4EveAG8aImaebZ/BUrmuWTPaZ5Gv/SHoNyP6Ac
         paeHAo1cixoiqy/QqjRYz55skufzyT/0jOt55bzsM/u1dzCxSOI6whEYqIzyMBVh2O
         QpBZa6kcevMlmydUVjpj1e72gnr/JxU/5epxzGU+93LfxWd9Q0lWcYTZWrdlUuKe/l
         e7BrSjZVGbun/OiQP9fsmh9zyvS9haplBp8oFgovtirk4A2Hkf3NPNzhhbb8lgqv18
         5yywkpz5UzSjw==
From:   Maxime Ripard <mripard@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        stable@vger.kernel.org
In-Reply-To: <20231005135648.2317298-1-willy@infradead.org>
References: <20231005135648.2317298-1-willy@infradead.org>
Subject: Re: (subset) [PATCH] drm: Do not overrun array in
 drm_gem_get_pages()
Message-Id: <169710035649.2154889.9854709966386177590.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 10:45:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 05 Oct 2023 14:56:47 +0100, Matthew Wilcox (Oracle) wrote:
> If the shared memory object is larger than the DRM object that it backs,
> we can overrun the page array.  Limit the number of pages we install
> from each folio to prevent this.
> 
> 

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

