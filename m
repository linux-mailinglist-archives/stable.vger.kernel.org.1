Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B97D13CA
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjJTQOc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjJTQOb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 12:14:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6FFD5A
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 09:14:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE5C433C7;
        Fri, 20 Oct 2023 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697818469;
        bh=tnyzhUX5PiuAtuB6RtAAcqPi47htPhw4raAzZrXuJRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0Sw4gMF80+ZwPRcQWJ5vnp40QKscmhAWNFfImFK5h0yaIeqP3eJUVhMmPy072Z7V
         Js4ov9tdgi/yGQv+gA4nLtnQqS36sxz+dObUWyMiq/8UnNSr/u+pzJx5YI6pbtrlNg
         hFbFVtcBDrLQ+RBf/NAjLLDa4+pM/LdLreZ5eYmI=
Date:   Fri, 20 Oct 2023 18:14:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Cc:     stable@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 4.14.y] usb: hub: Guard against accesses to uninitialized
 BOS descriptors
Message-ID: <2023102016-ajar-extradite-39ac@gregkh>
References: <2023101553-strict-slogan-ea90@gregkh>
 <20231017060613.3580689-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017060613.3580689-1-ricardo.canuelo@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 17, 2023 at 08:06:13AM +0200, Ricardo Cañuelo wrote:
> Many functions in drivers/usb/core/hub.c and drivers/usb/core/hub.h
> access fields inside udev->bos without checking if it was allocated and
> initialized. If usb_get_bos_descriptor() fails for whatever
> reason, udev->bos will be NULL and those accesses will result in a
> crash:

All now queued up, thanks.

greg k-h
