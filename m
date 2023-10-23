Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C17D2FB9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJWKXz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjJWKXo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:23:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C5F1995
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:23:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739B3C433C8;
        Mon, 23 Oct 2023 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698056593;
        bh=JQL7NUyL5GQlB8D87WonISz32bnyXVvvCpb+z7AEHxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhLG4K4KhiYwruJKUjgRDRTA+O+KtCRl/hW1962fb7XOdUPvY7X5o6pydiGJTC8yA
         eJ4bqPKBgzOygLJNomkjqid72j3LLdzCQ74AQ0Hb5PyogqyxXrNsfFpvn5NkJK6EER
         HNMqPN4jsQqqiRZ7l4QtbpXF4+KXe+ieGPBMlzQU=
Date:   Mon, 23 Oct 2023 12:23:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matttbe@kernel.org>
Cc:     stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: no RST when rm subflow/addr
Message-ID: <2023102357-tibia-overlook-ded1@gregkh>
References: <2023102046-haven-jargon-a683@gregkh>
 <20231022213229.3394813-1-matttbe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022213229.3394813-1-matttbe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 22, 2023 at 11:32:29PM +0200, Matthieu Baerts wrote:
> commit 2cfaa8b3b7aece3c7b13dd10db20dcea65875692 upstream.
> 
> Recently, we noticed that some RST were wrongly generated when removing
> the initial subflow.
> 
> This patch makes sure RST are not sent when removing any subflows or any
> addresses.
> 
> Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
> Cc: stable@vger.kernel.org
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-5-17ecb002e41d@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---
> Backport notes
>   - No conflicts

All backports now queued up, thanks

greg k-h
