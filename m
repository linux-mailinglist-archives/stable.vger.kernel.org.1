Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33258754E18
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGPJag (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGPJag (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399DBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAD960C19
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D5FC433C7;
        Sun, 16 Jul 2023 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689499834;
        bh=NkKNJJRXghSwuQU8B/B3SqeAqPtMsrMVHGtYXTrc7hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4JJOZICxLtBqcj468ng/xlKleY26INE5gLpoDqGeZ9YyNX0XPlmSi/lOV0ofJLKB
         rvLkMlLcg8V2CbLmzpT/q8uscdG0QEL9FWM8VjuD5NQrI1FMHKM6q/RbqjAZsMb+Mk
         4zHLDTOb27SBLPsh1V8rPkRk2uBW+f+YAyZhpYOc=
Date:   Sun, 16 Jul 2023 11:27:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     stable@vger.kernel.org
Subject: Re: Backport Request: ipvs: increase ip_vs_conn_tab_bits range for
 64BIT
Message-ID: <2023071643-creed-fabric-b25a@gregkh>
References: <53777E0A-89E0-4326-8B43-6F023E6B0D65@linux.microsoft.com>
 <D1B92E6E-A6AD-4D7E-B806-8D7029CDEE68@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1B92E6E-A6AD-4D7E-B806-8D7029CDEE68@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 12, 2023 at 01:40:58PM -0700, Allen Pais wrote:
> Hi Greg,
> 
>  Could you please pick the below commit for v6.3, v6.1 and v5.15
> 
> Upstream Commit:
> 04292c695f82 2023-05-16ipvs: increase ip_vs_conn_tab_bits range for 64BIT [Pablo Neira Ayuso]

Now queued up, thanks.

greg k-h
