Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902970C572
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjEVSnX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEVSnX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74666C4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06CBB61E88
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1160EC433D2;
        Mon, 22 May 2023 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684781001;
        bh=neazSvXkYTncHWg51sdCM1l5GjCOxYGW0rpLlqRMmYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWkuPzkbMfMa6XESAZOpA2Y1YRuyRIu4dl2B+ReBnzl/vk4ejVhR6DXATtXwfHBwn
         R2HPDucERf1a2BKqOwXEkHau/tU236w37b65FzPekuf+Ou2YTxKiGYaTPuTMquf7+g
         3E9ft27Bda5gTbyF8Nm9/mUUHVP5Agq/D6IBWmdU=
Date:   Mon, 22 May 2023 19:43:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ping Cheng <pinglinux@gmail.com>
Cc:     "stable # v4 . 10" <stable@vger.kernel.org>
Subject: Re: [PATCH] HID: wacom: add three styli to wacom_intuos_get_tool_type
Message-ID: <2023052209-concave-reproach-b55a@gregkh>
References: <20220928204929.56157-1-ping.cheng@wacom.com>
 <CAF8JNhL1QRrR7yieQzrKR2NHif1ffnfE2eCCoqeEzc3Gz-vOLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8JNhL1QRrR7yieQzrKR2NHif1ffnfE2eCCoqeEzc3Gz-vOLg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 16, 2023 at 04:22:01PM -0700, Ping Cheng wrote:
> This patch, ID bfdc750c4cb2f3461b9b00a2755e2145ac195c9a, can be
> applied to stable kernels 5.4 to 5.15, AS IS.
> 
> The patch has been merged to stable 6.1 and later. Thank you for your support!

all requests now queued up, thanks.

greg k-h
