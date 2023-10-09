Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73507BE2A4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjJIOZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 10:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjJIOZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 10:25:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D707299
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 07:25:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F14C433CA;
        Mon,  9 Oct 2023 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696861515;
        bh=WOlnNGHMyydzvtJIBcYhAJgvZj7qinJUk2Gu0CNK4Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eG7oVkJ3uGTek6paPwZnTq6ZPWlWPgP6h0LP5qi/hxeXRmRwfySaNr97Rcw1de+px
         0Sy00/pRGxriSD35VHsVrNOo2bBd3v5qZi22OP7MkxNJc+dG3I/EDduSKskEcxChE/
         9aV0CWgRIKsrxk/y9jjc3kZTf3at+KEQqBVQnaNviOX2wwPiKY2c0LYdqZOXbdb+Ii
         2AO8xiS5H06m4b/wvij6waXbDoPlxj8R+NJSgmPkqrrxJ2iLAwBrvpWGDF2d/qWSwt
         SOdGYEbJolW4kpIOlEGnknkSXkMHYl+0gpOmu1b4nySeppSX1Y0dXmwB9rlllQAIzE
         f80eMUS8CoSJg==
Date:   Mon, 9 Oct 2023 10:25:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH 6.5 001/163] ALSA: hda/tas2781: Add tas2781 HDA driver
Message-ID: <ZSQNSeJtY2WxedV3@sashalap>
References: <20231009130124.021290599@linuxfoundation.org>
 <20231009130124.064374662@linuxfoundation.org>
 <875y3gsznc.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <875y3gsznc.wl-tiwai@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 09, 2023 at 03:17:59PM +0200, Takashi Iwai wrote:
>On Mon, 09 Oct 2023 14:59:25 +0200,
>Greg Kroah-Hartman wrote:
>>
>> 6.5-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Shenghao Ding <shenghao-ding@ti.com>
>>
>> [ Upstream commit 3babae915f4c15d76a5134e55806a1c1588e2865 ]
>>
>> Integrate tas2781 configs for Lenovo Laptops. All of the tas2781s in the
>> laptop will be aggregated as one audio device. The code support realtek
>> as the primary codec. Rename "struct cs35l41_dev_name" to
>> "struct scodec_dev_name" for all other side codecs instead of the certain
>> one.
>>
>> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>> Link: https://lore.kernel.org/r/20230818085836.1442-1-shenghao-ding@ti.com
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> Stable-dep-of: 41b07476da38 ("ALSA: hda/realtek - ALC287 Realtek I2S speaker platform support")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This makes little sense without the backport of commit
>5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver").
>Confusingly, the patch subject is very same as this commit...

This is a tricky one: 3babae915f4 really doesn't add a new driver but
rather just refactors some of the quirk handling which is needed for
later patches to apply. It's the following 5be27f1e3ec9 which actually
adds the driver (which we don't need here).

We don't actually want to bring in a new driver, so 5be27f1e3ec9 is
unnecessary.

>And the above commit has more follow-up fixes, too.
>1c80cc055b3f
>17a1eab7b70d
>ed81cb9e0517

If we don't take 5be27f1e3ec9 then we don't need any of the follow-up
fixes.

-- 
Thanks,
Sasha
