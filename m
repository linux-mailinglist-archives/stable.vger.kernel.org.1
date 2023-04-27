Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27B6F02A6
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 10:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbjD0If7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjD0If6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 04:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A883D4C04
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 01:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31980611FC
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4958DC433D2;
        Thu, 27 Apr 2023 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682584556;
        bh=rNs1R0LE/TVRmPAZphEVcs894JUR37l1sMJtlE8iriI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1kDhJdkmvS+qNm4OhEEuTmv0j3sykdKJYNyL3LcxQzXk0dsgNFZGBPwBMxwXz78f
         550C1WmryxPMOoQEyjUvwj3VtD7ea9eLHXk9Kvdzo0QfK+TQlmHooe14KuYkg6uzlQ
         ov/vBjOZHRQUkP1xYse+idNPauhUiit+zKKj+jus=
Date:   Thu, 27 Apr 2023 10:35:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     stable@vger.kernel.org, kvmarm@lists.linux.dev,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [BACKPORT PATCH 6.1.y] KVM: arm64: Retry fault if vma_lookup()
 results become invalid
Message-ID: <2023042746-gladly-spree-6b1a@gregkh>
References: <20230425121338.8474-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425121338.8474-1-will@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Apr 25, 2023 at 01:13:38PM +0100, Will Deacon wrote:
> From: David Matlack <dmatlack@google.com>
> 
> [ Upstream commit 13ec9308a85702af7c31f3638a2720863848a7f2 ]
> 

Now queued  up, thanks.

greg k-h
