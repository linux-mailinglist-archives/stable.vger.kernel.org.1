Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF27C9A69
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJORqY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 13:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJORqX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 13:46:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C6AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 10:46:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2124C433C8;
        Sun, 15 Oct 2023 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697391979;
        bh=jVCckBE7rZhtysXMKY8mqBT1G1lgNoJAjVzJSw3iHTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiPJCObushEq5BFPPY0PlkH2p5I04RljX0bEA9zA3PPfWc10b7czn5vLbA98oESpL
         +46frILcncdDV0E7uOxg7uFTYr4yCY6k79SUF1HpoCiusihuJWJtLRJZKNWZsP6RQh
         HeRCfvzLcoH4+j3zrfd7sLGnIyrq/0Lhy622oX2Q=
Date:   Sun, 15 Oct 2023 19:46:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Rohr <prohr@google.com>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH 5.10 0/3] net: add sysctl accept_ra_min_lft
Message-ID: <2023101505-speed-procreate-347d@gregkh>
References: <20231013214414.3482322-1-prohr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013214414.3482322-1-prohr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 02:44:11PM -0700, Patrick Rohr wrote:
> I am following up on https://lore.kernel.org/stable/20230925211034.905320-1-prohr@google.com/ with
> cherry-picks for 5.10.198. I have run our test suite with the changes applied and all relevant tests
> passed.

All now queued up, thanks.

greg k-h
