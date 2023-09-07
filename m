Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D09797796
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbjIGQ1g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbjIGQ0h (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 12:26:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE386A6
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 09:23:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1BEC3279A;
        Thu,  7 Sep 2023 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694098049;
        bh=rTeO1U45/2dVRGN2wr6xRGgoltY8gGjF/1QIYVC55ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WP7ZQUYpxqBxyg4D9oKAEVQav0JB06QO30U2Mjz9y/Q8JuXGaw6nUH3GfYTFuAgQc
         j7OQoMKW4Hb1oFtfxlBbPTy890yCmanBnkMgYoFmkkHGfQsd20MpCCsy1+RXdX1Rvv
         784MXB/efSW1gxkvVTo3PBAnU+nqJVGWiHcQqFqY=
Date:   Thu, 7 Sep 2023 15:47:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-stable <stable@vger.kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
        CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>
Subject: Re: Please apply b51ba4fe2e13 to 4.14/4.19/5.4/5.9
Message-ID: <2023090710-perjurer-snub-bb76@gregkh>
References: <07cf81cb-50fe-591a-3c9e-5b6c39d311f3@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07cf81cb-50fe-591a-3c9e-5b6c39d311f3@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 07, 2023 at 02:10:08PM +0000, Christophe Leroy wrote:
> Hi,
> 
> Could you please apply commit b51ba4fe2e13 ("powerpc/32s: Fix assembler 
> warning about r0") to kernels 4.14/4.19/5.4/5.9 so that we avoid having 
> the related warning.

5.9 is a long-end-of-life kernel, but I've queued this up for the
others, thanks.

greg k-h
