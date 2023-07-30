Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490E3768950
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 01:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjG3XvG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 30 Jul 2023 19:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjG3XvD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 30 Jul 2023 19:51:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C26510CA
        for <stable@vger.kernel.org>; Sun, 30 Jul 2023 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VxSBgwoFHhTP2ix3LeOl5Lmtfs34upckxqGzQXvDTD4=; b=SUwyXBZHvcMp+KOovzySiWyB11
        AVYbX+2tdB/ESZY+7eJ8OdyzTrQkIAJcXRpsreppBgINRcaYvob3Taa+stO2c0J/pf5LiVOo1EXO9
        jekJWewYuVLVUiRtA09Or9fG+GbFE1jlY6YrEV4NPSzwqQl9zLI1tFFofu4dPV1JirTWH7khNopMf
        p505MWqvstNZnuDYxCAgsPHFI7PMkTe76TRRwQX+kA/W9h3ga/rUkvKGMfB0HbmCAnGHoYbaiWx9J
        7VaK7L9MMSG/fIkuqrBEnhyZaAvt0mcIAujYCO4Ekz3LXf3ZUGzxvfQ9QqnewzI45nIy2pRrUbSFQ
        1CN80mxg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQGBd-00D7OZ-1z;
        Sun, 30 Jul 2023 23:50:58 +0000
Date:   Sun, 30 Jul 2023 16:50:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [RESEND PATCH v5 1/3] test_firmware: prevent race conditions by
 a correct implementation of locking
Message-ID: <ZMb3Yf4km8NTeMZj@bombadil.infradead.org>
References: <1a2a428f-71ab-1154-bd50-05c82eb05817@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2a428f-71ab-1154-bd50-05c82eb05817@alu.unizg.hr>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 29, 2023 at 11:17:45AM +0200, Mirsad Todorovac wrote:
> ---
> v5.1
>  resending to v5.4 stable branch verbatim according to Luis Chamberlain instruction

If this is a backport of an upstream patch you must mention the commit
ID at the top. After

For instance, here is a random commit from v5.15.y branch for stable:

bpf: Add selftests to cover packet access corner cases
        
commit b560b21f71eb4ef9dfc7c8ec1d0e4d7f9aa54b51 upstream.

<the upstream commit log>

If you make modifications to the patch to apply to v5.4.y which
otherwise would let the patch apply you need to specify that in
the commit log, you could do that after your signed-off-by, for
instance you can:

Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
[made some x, y and z changes to ensure it applies to v5.4.y]

If this is a new commit for a fix not yet merged on Linus tree
then your description quoted above does not make it clear.

  Luis
