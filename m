Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCC7B6EB3
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 18:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbjJCQhw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbjJCQhv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 12:37:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B377A6
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 09:37:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A86C433C8;
        Tue,  3 Oct 2023 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696351067;
        bh=kATiELhUUKjSO7KEyxv88WSB5hjFIbtyEcIz5vVtGSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prfywvRXYGYUeeVWaDu7J2GOAF4QW+q7dxya9nXqkpy9nJQAYqzmnPyTHUtcYKYrF
         nV8eEVHmD1A7+Vz6gHZ0hhOXNhxHNtlI69UwdbyCYrSCQkQjL7vSs5dJBBShfWKVQg
         CXQ0xWEPpLG9eGpC18R+S7ku0AeDFPFXDhztIUts4RCc/AweQeqqozL85LMYVSueJK
         YYV3k2f+8rQJomkpQCP+zsc3s33t6mFRRTpIp8lStRivmWhbG7yCr3E5LI+87MMG6k
         nx5ImcITHTghIiMrrj6AqnhIXr0/7YPrVtSvF4FYsjXROXA+xuBkuWiJaYzmixTsSq
         OtCEctciCP8hw==
Date:   Tue, 3 Oct 2023 12:37:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     stable@vger.kernel.org
Subject: Re: v6.5 backport request: 6d2779ecaeb56f92 ("locking/atomic:
 scripts: fix fallback ifdeffery")
Message-ID: <ZRxDWQop/3kdbObN@sashalap>
References: <ZRw-0snchQiF5shv@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZRw-0snchQiF5shv@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 03, 2023 at 05:18:26PM +0100, Mark Rutland wrote:
>Hi,
>
>Could we please backport commit:
>
>  6d2779ecaeb56f92d7105c56772346c71c88c278
>  ("locking/atomic: scripts: fix fallback ifdeffery")
>
>... to the 6.5.y stable tree?
>
>I forgot to Cc stable when I submitted the original patch, and had (mistakenly)
>assumed that the Fixes tag was sufficient.
>
>The patch fixes a dentry cache corruption issue observed on arm64 and which is
>in theory possible on other architectures. I've recevied an off-list report
>from someone who's hit the issue on the v6.5.y tree specifically.

Already done, it came in via AUTOSEL.

-- 
Thanks,
Sasha
