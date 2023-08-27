Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4565B789BB2
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjH0HPS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0HPF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 03:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6649123
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 00:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440D562022
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 07:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F61C433C7;
        Sun, 27 Aug 2023 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693120501;
        bh=5vdR7FVPPsy73umm8EmPoilpkNTMqpwx5tW1EMejzfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+ksOZEcEtpDcqyPeo+Yp1Z4wu4c2H0+2tw4SFgOjVox76bsygU6CdCoCl41FSPyu
         /DX20mdIyY/1mYBH6qFHcIO0HAdUb+aqZIJWXLupyQBiaMCe8cUiAtO14ZL+4TO5IA
         Wgs8tARxuVtv9oS8JesRBEBoV5XdzfY5YEjLU/P4=
Date:   Sun, 27 Aug 2023 09:14:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Patches for 6.1-stable
Message-ID: <2023082752-entangled-unhook-de55@gregkh>
References: <7bebe361-e33f-42e7-b4d7-00efd024a986@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bebe361-e33f-42e7-b4d7-00efd024a986@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 22, 2023 at 06:07:28PM -0600, Jens Axboe wrote:
> Hi,
> 
> Looks like we missed a few backports related to MSG_RING, most likely
> because they required a bit of hand massaging. Can you queue these up?
> Thanks!

All now queued up, thanks.

greg k-h
