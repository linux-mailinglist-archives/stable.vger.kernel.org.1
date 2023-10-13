Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461F07C8B55
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjJMQWI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjJMQVw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 12:21:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99183
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 09:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F5CC433C7;
        Fri, 13 Oct 2023 16:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697214074;
        bh=lqVlwmUfSE3oakFQ+O+Pw5nIlA0kLdN6jHlJFgtXbsQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZlA7DIV0VY4C8i/ugKQb151CzRNZ2phxAleUozRyW1mD+XU+QRTjWPENi+inW7W7p
         L0tD1bG+sN6uth2WtcTgKLS1SrjKGSNemqgym9JnB//k9mVFET/2fqVGNypg6hIX2K
         ue6hSv3y0j6uDjsIXI7hpbxyCrZd5HHmzZIKgSJvdoSZOvw2GtUs8utm7vsnSTHYWT
         5WodtkTw+t+GSknS1Oc/indUEdDpj4LBQV8GBY6Q0PcbLLDn6LLuPTamKolbDM1Jsh
         MmwH09bjtNOMdx/Lo4rlzQtFh0WA8+WpM4g2i25BumkXDinNF7j1lrDYwq6jvLrGfy
         r9yMIgp39+rZg==
Message-ID: <42778c9a-d487-f1a1-ae70-70a9f69c3b82@kernel.org>
Date:   Fri, 13 Oct 2023 11:21:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] net: change accept_ra_min_rtr_lft to affect all RA
 lifetimes
Content-Language: en-US
To:     Patrick Rohr <prohr@google.com>, stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20231012235524.2741092-1-prohr@google.com>
 <20231012235524.2741092-3-prohr@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231012235524.2741092-3-prohr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/12/23 5:55 PM, Patrick Rohr wrote:
> commit 5027d54a9c30bc7ec808360378e2b4753f053f25 upstream.
> 
> (Backported without unnecessary UAPI portion.)
> 

no such thing as "unnecessary UAPI". If the original patch has a uapi,
the backport to stable should have it too.

