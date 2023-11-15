Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0CC7ED635
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjKOVsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjKOVsX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:48:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86F0E1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:48:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C558C433C8;
        Wed, 15 Nov 2023 21:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700084900;
        bh=x3TrGFDZezUCjAArGq3dPXLXXta370F4oMOzYuKwjUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXIA0Yq2bR6HahhjuTeQs6wOsYKBoyDuwDRu9A0UtZmbDNB+1Oxm1k4/qhz9REkBn
         CKJiUUXNBPrnBOYvGUEP/HC/A6u6scmVhidmZ3q1lq2aQIUySOUUR+NeV4BuDEL/XB
         AZUj364mdhC7A3Rs+pWJ7NSEeWcwz/ibiksc9nNU=
Date:   Wed, 15 Nov 2023 16:45:50 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 010/191] wifi: iwlwifi: Use FW rate for non-data
 frames
Message-ID: <2023111541-diffuser-amount-bc81@gregkh>
References: <20231115204644.490636297@linuxfoundation.org>
 <20231115204645.129133114@linuxfoundation.org>
 <173d2adc744a2878544c14c3960765587bd96521.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173d2adc744a2878544c14c3960765587bd96521.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 15, 2023 at 10:35:08PM +0100, Johannes Berg wrote:
> On Wed, 2023-11-15 at 20:44 +0000, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> > 
> 
> I wouldn't backport this patch anywhere.
> 
> First of all, it's only _required_ for real WiFi7 operation, which isn't
> supported in any of these old kernels. Secondly, it introduced a
> regression wrt. the rates used by the firmware, which, while not that
> important, caused some folks to complain.

Ok, thanks!  I'll drop it from all queues.

greg k-h
