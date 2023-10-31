Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C187DCC11
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjJaLqJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjJaLqI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:46:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A4D8
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:46:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25672C433C8;
        Tue, 31 Oct 2023 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698752764;
        bh=SgUOMuPXAesazlAEjMfdvCJ/PhnyQoC8T3LbeBZfnw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVb8Zruo5PLZBYLztBwJjpR1sEyxmenI/sduFFCfN/1g0d8ZgXoIc/LgRzaQ8fN9n
         0SUlU7VIR5wfPHenni+Myb4gh76+chGbsbzGZ7POaIeQQAbT9lc50CwTMBzN43HXLH
         vLIAd8fu3xEbeLSXHSw/qh3yq7N4W6Cm9VlDm4QY=
Date:   Tue, 31 Oct 2023 12:46:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksandr Tymoshenko <ovt@google.com>
Cc:     stable@vger.kernel.org, Wang Hai <wanghai38@huawei.com>
Subject: Re: [PATCH 5.10 1/1] kobject: Fix slab-out-of-bounds in
 fill_kobj_path()
Message-ID: <2023103152-compactor-trout-52f2@gregkh>
References: <20231025042144.2247604-1-ovt@google.com>
 <20231025042144.2247604-2-ovt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025042144.2247604-2-ovt@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 25, 2023 at 04:21:44AM +0000, Oleksandr Tymoshenko wrote:
> From: Wang Hai <wanghai38@huawei.com>
> 
> [ Upstream commit 3bb2a01caa813d3a1845d378bbe4169ef280d394 ]
> 

Thanks, now queued up everywhere.

greg k-h
