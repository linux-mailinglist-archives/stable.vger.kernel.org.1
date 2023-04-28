Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE92B6F1674
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjD1LPs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjD1LPs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516944C2D
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E28D26420D
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0373C433EF;
        Fri, 28 Apr 2023 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682680546;
        bh=3N65UvbeXHeEGW9XlsFVJAqOqfVyrGK8y/OQihQ3eQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXoWvqdnLvduTlUgcDIZ3emkHiGQ4veTEyWDR+TJmBvmeyYmqgHQaZ5AeQPJkYd2e
         3x0bbmGFUOlOQ6qcM5chReJLkJdJIRNQv00UmaxBwsqe3mDOCGjUFMA48xDRIHx0wY
         6aWF+i8ltavAwdWxS4hSEgBdlH1mdUu4vHozp1So=
Date:   Fri, 28 Apr 2023 13:15:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.2.11 v2 0/3] Fixes for dtb mapping
Message-ID: <2023042822-pushpin-coil-b0bc@gregkh>
References: <20230428103745.16979-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428103745.16979-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Apr 28, 2023 at 12:37:42PM +0200, Alexandre Ghiti wrote:
> We used to map the dtb differently between early_pg_dir and
> swapper_pg_dir which caused issues when we referenced addresses from
> the early mapping with swapper_pg_dir (reserved_mem): move the dtb mapping
> to the fixmap region in patch 1, which allows to simplify dtb handling in
> patch 2.
> 
> base-commit-tag: v6.2.11

Thanks for redoing all of these, now queued up!

greg k-h
