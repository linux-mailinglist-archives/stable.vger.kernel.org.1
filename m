Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7364C782A58
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjHUNUm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 09:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjHUNUm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 09:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30128F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 06:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE9E60AE9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EEDC433C8;
        Mon, 21 Aug 2023 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692624040;
        bh=UkTI2lAId7ESwjOYS2GtTtaUyQqnCYzHx4EHAnfJn7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHV9ZH0GjhfMGViZ3t9TzYd1RjtSv3UkaI2DCc6FFqAeGCiQ29PKQ2bA3QvkZk2ZJ
         qOe4bOhlMa3KG+5DYTRg3PkX0T4dnFks+2a9bEBL52Nbar/ZcYiGsBMf2wDuRWCC5T
         mcsdN6H6ZwI3UrNfgtlEDNMP6xL3IguefmAYIQnk=
Date:   Mon, 21 Aug 2023 15:20:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     stable@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        stable <stable@kernel.org>
Subject: Re: [PATCH 4.14.y] binder: fix memory leak in binder_init()
Message-ID: <2023082130-mystified-entrust-3c1b@gregkh>
References: <2023081201-exhale-bonelike-1800@gregkh>
 <20230815180521.1049900-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815180521.1049900-1-cmllamas@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 15, 2023 at 06:05:21PM +0000, Carlos Llamas wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> commit adb9743d6a08778b78d62d16b4230346d3508986 upstream.
> 
> In binder_init(), the destruction of binder_alloc_shrinker_init() is not
> performed in the wrong path, which will cause memory leaks. So this commit
> introduces binder_alloc_shrinker_exit() and calls it in the wrong path to
> fix that.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Carlos Llamas <cmllamas@google.com>
> Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
> Cc: stable <stable@kernel.org>
> Link: https://lore.kernel.org/r/20230625154937.64316-1-qi.zheng@linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [cmllamas: resolved trivial merge conflicts]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Now queued up, thanks.

greg k-h
