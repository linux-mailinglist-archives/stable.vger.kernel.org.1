Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FC702CF9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbjEOMny (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbjEOMnj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:43:39 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405CF2684
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:43:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C270932007F9;
        Mon, 15 May 2023 08:43:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 May 2023 08:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684154598; x=1684240998; bh=RD
        kwjy8wl26IHUMvtar7r0EtQTZnjSLBjEloeP/hYC4=; b=Ae/u24UxSqE1Jf3cEd
        AKEc2RuLrKxZbQiOca16nDdCzHKyNLavw5WDJb1nJGK59y8+y0aRy9MtI36d2DoB
        lWkQP2jttKl5f71ASEZMPoslBSGjV+nqquiYN4qIGo83UKJ6erxOBsjCB3GDuxXs
        crhShTMPDFWrSBU6Afu0dxM87iSG027IELb+Qkp7heufto5AMWMR1toqFdvDkdx6
        yDKfe7LX1ct0FwpVr3zwriPfhrEoYPhqzmO/QVbF0c0gm343zow/vNIPq31ID8eG
        ZIUrAGXkRO6FKmAXrUvAy1X9QPzk5d3UEs/SBI57oQKVofQnJOPWz9U0O+alCQ69
        kQ6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684154598; x=1684240998; bh=RDkwjy8wl26IH
        UMvtar7r0EtQTZnjSLBjEloeP/hYC4=; b=ByLA4RsM57XjVgCg4VjeLxF9QEjAx
        unZsM7VK4gfzdKxV5YXiQKly+AILd3ZVM8vZX6YNSC0bS2ocLJI2aCRLEtaeL7Si
        2Pq4ku699CaCNiSiBXkcRnfFN4O1S6wHmj1SYsFLIzw/L/eVUF5+pEEqxYGIhWuI
        C8c+lM5SKkqQiiWdwgFBtMNzBHBDH1NMlWn5t27OsZGvjZHgZ1TADcmh6DagZ3KK
        zg47qDERegklw4iHeUcvdRC8er+0KyHfWLcYlJ8mNww5zRr1ZT6BiM9Fj8o1e5W3
        xx3G79gpWeOTeivRrvbt+HpvzgFQqyDxRpVPx/LEC2cov1cFZiOKfhShg==
X-ME-Sender: <xms:5ihiZONUaZh96DN4IBELpJURmge5wRV0JtecTzW_SKlpYf1R1F7r2Q>
    <xme:5ihiZM8yV-qajmPc-2D8nTCYIBHvDZo37fJVi2XGyQ2sx82xYhisFltkofClEaUg2
    VHsr2n-kFZgqA>
X-ME-Received: <xmr:5ihiZFT0-m4o5RhmNaoIsWyjIWzsvjBGGFEq_WWPJgdbGOTlNkpOW0W7m36Y3zI-lMe-ZwNGva7434lfROgm8Eg79xmunE16dZ4FXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:5ihiZOvrsBKktNPKRH-DlxI1_sYp4Ah2JCWYzydxWkcf4PTY7xwW2Q>
    <xmx:5ihiZGdZMWwU7hY73uuVBC4sKZoRM3j9eTtAEPw1xn099eSAGDLiLA>
    <xmx:5ihiZC03MKVhe8SbcKCZUOhsaHWPnTmjJ-xpwIPiWrhvhaoqP6KDTw>
    <xmx:5ihiZNyZX5Go84SJK4REVVO2NYd9pQP2kuHmsIUA_xM2g8T45zu1Hg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 08:43:17 -0400 (EDT)
Date:   Mon, 15 May 2023 14:43:14 +0200
From:   Greg KH <greg@kroah.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     stable@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.3 0/2] s390/mm: fix direct map accounting
Message-ID: <2023051507-basil-broadly-63dc@gregkh>
References: <cover.thread-961a23.your-ad-here.call-01683642007-ext-1116@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.thread-961a23.your-ad-here.call-01683642007-ext-1116@work.hours>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 04:31:11PM +0200, Vasily Gorbik wrote:
> As an alternative to backporting part of a large s390 patch series to the
> 6.3-stable tree as dependencies, here are just couple of rebased changes.
> 
> Avoids the need for:
> Patch "s390/boot: rework decompressor reserved tracking" has been added to the 6.3-stable tree
> Patch "s390/boot: rename mem_detect to physmem_info" has been added to the 6.3-stable tree
> Patch "s390/boot: remove non-functioning image bootable check" has been added to the 6.3-stable tree

All now queued up, thanks.

greg k-h
