Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539457676A9
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjG1T6b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjG1T6a (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 15:58:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08293C1D
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VVgIaXnvKGSF0VzaO7Y2nL6FGVSo/B0CVzzPEY0GXbg=; b=Jp7SThqWs7WkKBgbqnR9TI86EB
        H5J6euC2NWyTU7zRvZFpNbne/yOgPv/vleC2wLCt6DphO47DwCibiY/r/E1SY8i/XB5cLUeydd2hL
        3Cw6wInvMB9OHYghD+ZlDsWpN67+lg4AKm3mzF4RyCM8cIKejmmaOv4DV0nsG1na7ysIMqpn7DM93
        3VCvxpTIDGbuFUJL0Ozr+mCTueBE1tU2xglBV0mFwod20E/C178sXaNuW5ZSMRkyLZalapvSgGw/o
        TD+HcP1E3mLwcmw8Pu0K/5k/ASITVEhdW5lq3l1uzDIr9YzXS580S1biRoDJIuyTsPR9t4/QXq9UK
        rzz2xilg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qPTbX-004ryg-1b;
        Fri, 28 Jul 2023 19:58:27 +0000
Date:   Fri, 28 Jul 2023 12:58:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/1] test_firmware: fix some memory leaks and
 racing conditions
Message-ID: <ZMQd49Qp8EzapxEE@bombadil.infradead.org>
References: <84fde847-e756-3727-c357-104775ef1c4f@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84fde847-e756-3727-c357-104775ef1c4f@alu.unizg.hr>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 28, 2023 at 09:48:08PM +0200, Mirsad Todorovac wrote:
> v3 -> v4
>  - fix additional memory leaks of the allocated firmware buffers
>  - fix noticed racing conditions in conformance with the existing code
>  - make it a single patch

This is not quite right.

Your patch commit 48e156023059 ("test_firmware: fix the memory leak of
the allocated firmware buffer" is already upstream and now you're taking
that same patch and modifying it?

If you have something else you want to fix you can use the latest
lib/firmware.c refelected on linux-next and send a patch against that
to augment with more fixes.

If your goal however, is to make sure these patches end up in v5.4
(as I think you are trying based on your last email) you first send
a patch matching exactly what is in the upstream commit for inclusion
in v5.4. Do not modify the commit unless you are making changes need
to be made due to backporting, and if you do you specify that at the
bottommon of the commit after singed offs of before in brackets
[like this].

Furthermore, I see you have other fixes other than this one merged
already on upstream so if you need those for v5.4 you need to send those
too.

  Luis
