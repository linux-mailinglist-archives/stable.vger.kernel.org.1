Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B207D2ECE
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjJWJsW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJWJsV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 05:48:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E19A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 02:48:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D9FC433C7;
        Mon, 23 Oct 2023 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698054499;
        bh=iMS1o9mnWuPsscKDyiduYVbM34gCmMEfTwy8U7k2xw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJWsPGKY+zLh7TErxV6dIgXuUDuTnkDFmhUmJZNOy2lFJXWI3JPLL0pPo0dfQEQlA
         4lq94RunWTMYdzVw6GXK3b54iiE/pvBMdebcNyV9B5iNNY7zs9/K09kPL8ROJlWRz+
         JG4ZLi2jwGEQxUjJm1OOrKUCImoRdHegIT68xdNK+OHOq+ZtMfJiNLkM/KXyZ0KHwb
         65x9m6FTen2X0hjnJaHXlhKsDZggtbEzqeUKpTwcmZlH/Z5kbKUabo0WIlN+hyo5Iy
         LczD0c/mKaZV1HIHISJJzwCEfU8+nb+zvJYEPyTZdNENVdHCGnErmtukxMibYyX8O0
         XGxaBFx5+pRqA==
Date:   Mon, 23 Oct 2023 10:48:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5.4.y 1/3] driver: platform: Add helper for safer
 setting of driver_override
Message-ID: <20231023094815.GE8909@google.com>
References: <20231018120527.2110438-1-lee@kernel.org>
 <2023102037-subscript-negate-0f30@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023102037-subscript-negate-0f30@gregkh>
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

> <snip>
> 
> Something went wrong with this 5.4 series you sent, I got the following
> emails which look like 2 different versions of this series?:
> 
>   11   C Oct 18 Lee Jones       (7.0K) [PATCH v5.4.y 1/3] driver: platform: Add helper for safer setting of driver_override
>   12   C Oct 18 Lee Jones       (2.6K) ├─>[PATCH v5.4.y 3/3] rpmsg: Fix kfree() of static memory on setting driver_override
>   13   C Oct 18 Lee Jones       (1.1K) ├─>[PATCH v5.4.y 2/3] rpmsg: Constify local variable in field store macro
>   14   C Oct 18 Lee Jones       (2.6K) ├─>[PATCH v5.4.y 2/2] rpmsg: Fix kfree() of static memory on setting driver_override
>   15   C Oct 18 Lee Jones       (1.1K) └─>[PATCH v5.4.y 1/2] rpmsg: Constify local variable in field store macro
> 
> And you can see it here:
> 	https://lore.kernel.org/all/20231018120527.2110438-1-lee@kernel.org/#r
> 
> So I don't know what patches to take for 5.4, sorry.  Can you please resend the
> properly ones?

You're right.  They're in my inbox too.

One set was sent 1s after the other, so must be a tooling error.

The 2 sets are identical.

1/3 == 1/3
2/3 == 2/3
3/3 == 3/3

-- 
Lee Jones [李琼斯]
