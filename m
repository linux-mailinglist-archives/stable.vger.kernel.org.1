Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96FA72691F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjFGSpU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjFGSpT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3981712
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60CB63C15
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9439C433EF;
        Wed,  7 Jun 2023 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686163518;
        bh=Rwf8wuP9q/UiC0bXziw9Cb2RJyundJ0q2m1mvgASUnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XeIEhkUvlKKzCRhbCJREcRnWKKgJepAKVzG0D9hTneceB5GMNZRAPSLiRzeaX/PwF
         1wpbC6BtDj5Jc8O9IkvZwGQQbCLfnNMjBBeJZV3j/T9Uynf050QXvhzhQj3gKXDZ3n
         +ufBaXrmduEo690i+8vUTAXzanbSuvkjUOwmeCAE=
Date:   Wed, 7 Jun 2023 20:45:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 5.10.y] selftests: mptcp: join: skip if MPTCP is not
 supported
Message-ID: <2023060707-valium-derived-a0a0@gregkh>
References: <2023060735-smelting-gas-07a2@gregkh>
 <20230607154542.2693217-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607154542.2693217-1-matthieu.baerts@tessares.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 07, 2023 at 05:45:42PM +0200, Matthieu Baerts wrote:
> commit 715c78a82e00f848f99ef76e6f6b89216ccba268 upstream.
> 
>   Backport note: a simple conflict with 87154755d90e ("selftests: mptcp:
>   join: check for tools only if needed") where the context attached to
>   the new line we want to add has been moved to a dedicated function.

All backports now queued up, thanks!

greg k-h
