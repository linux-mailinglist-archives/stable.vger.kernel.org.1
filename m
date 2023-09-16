Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493717A2FB7
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjIPLe3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbjIPLeM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:34:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBECC4
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:34:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509B4C433C8;
        Sat, 16 Sep 2023 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864046;
        bh=7Eqg0f0BI1e740+fFbCOjnG90x/EolLazUtPHV1leWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obcG4/BQ4zviQVAtxhMY64w1RY+Sa0yJWg12BOs74sDHppiN9NcCkKAEfsT2KN1Fj
         /M/4n/32ki3TTBDqTS50+vodWb3VQG4ddasRcO+tklC4nWSndKeB2UGER5pJF0R/jV
         MENMquXDT1qNo+DpatfbtybxsXq1xQMoVEbwxDPI=
Date:   Sat, 16 Sep 2023 13:34:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [STABLE][PATCH] linux/export: fix reference to exported
 functions for parisc64
Message-ID: <2023091656-posted-poking-c78c@gregkh>
References: <ZQM6XXX9Sln2SZx2@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQM6XXX9Sln2SZx2@p100>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 14, 2023 at 06:52:45PM +0200, Helge Deller wrote:
> Hi Greg,
> 
> could you please cherry-pick this upstream commit:
> 
> 	08700ec70504 ("linux/export: fix reference to exported functions for parisc64")
> 
> to the v6.5 stable kernel series?

Now queued up, thanks.

greg k-h
