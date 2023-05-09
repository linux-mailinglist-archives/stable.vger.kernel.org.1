Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73536FC83B
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEINxI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEINxI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 09:53:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D103C35
        for <stable@vger.kernel.org>; Tue,  9 May 2023 06:53:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 686CB5C0079;
        Tue,  9 May 2023 09:53:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 May 2023 09:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683640384; x=1683726784; bh=4S
        WD+4Y3jzk+QuVIfV6Zxsyxits3w4DYx7CdkQwMg3Q=; b=wWbDz2/P9KGpiVuuXt
        JstSHVRtkinoQasJ+tGAUrW7ztr7mgpO3qqgQkctqM1XiA1QPXDu6Mq9Zi9lcACw
        /tkngLPA+/BTe6EcLsfI2QT3UpLxIclBphwfonvWlws6nUIsGye2je1n5uJfJGF3
        CWRt0ugsPaPDh2sEUCyo7IfuLKusQVMvggf8PhWeNpaPhPTHecgZijXrgLvMarcz
        Ruh/r998zg8jPo/me0UL+mv4WFg3Lo7F39tNc+QGiJlPQc+n/5oovfRsCIs+PJdl
        KLH5ptcSFHMlfRgx4GN9rfC1K2CiRgS5Phu1NTtN5Pw/bG34ZIssQAGxvSU2qJf5
        tVSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683640384; x=1683726784; bh=4SWD+4Y3jzk+Q
        uVIfV6Zxsyxits3w4DYx7CdkQwMg3Q=; b=WofCARdkSq+C7Cw8Y9wW00rn/tlCg
        3tRJ1e/wuTbeqBVIq7/Cbd+l5xaqOqTd6ZSVmY/QMKcvbUUXrzbQ08a0CRQ/0bT6
        o8AFnACVycTdrbON3SIXX4H0+DDLlFnAGVCpnTwEffHwM14PcZq2wvysbKCIcMik
        ztY8ZZnKsRFjxToa6dYppBRP/JHvDB+CXLpr4qY1SnpoYzawOxKW5Rgn982A9XCH
        ysjReYGOZCho2shOs75MKW+3iRsaGg7qiLCvBlgb9GazXztNIc2xj52nM/PpkRpO
        13LTcYpfB6nAo5oXt35zUtfS8kXC90lbUHOiYlVp+0lq2y1gNlg41oBHA==
X-ME-Sender: <xms:P1BaZNQjzg8rUto1P2OddMGG3G7GQ3bzv7RZjFmTa4BJTMpd5PCwDA>
    <xme:P1BaZGzVWxZV0QHT7cMAM4HGXRRFaOjRCQrKOUYkysGNA1sakZRDll_7eQ4_JHYNh
    6umiZxqhEM8LA>
X-ME-Received: <xmr:P1BaZC0_yWXvRMCAlxgHnqOLf-nHzh-j4P4QqTcLY97iA9FiFw35xbeMsUrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:QFBaZFDA0a2npppyAGXtBlXqCQ0eCvg9X0OIB8yCEyYYVaaHgrtzNQ>
    <xmx:QFBaZGiGGls-B01TdH4l6Il9Hw0Plrml_4zU8utiNN9hBnC986HgMg>
    <xmx:QFBaZJpG0ze3KpIaeNmeWltW2PvxgSsR-y7yLw1nNbFtt04PnOn6Pw>
    <xmx:QFBaZBUmHAfyJZJOwXSlHZqsZcE-G3Ix9yUgIfme9IFOhREHYqwlIg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:53:03 -0400 (EDT)
Date:   Tue, 9 May 2023 15:53:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Yeongjin Gil <youngjin.gil@samsung.com>
Cc:     stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 4.19.y] dm verity: fix error handling for
 check_at_most_once on FEC
Message-ID: <2023050932-unashamed-frenzy-cae5@gregkh>
References: <2023050708-verdict-proton-a5f0@gregkh>
 <CGME20230509121858epcas1p24a0d408759e91024d242768821827a34@epcas1p2.samsung.com>
 <20230509121856.13689-1-youngjin.gil@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509121856.13689-1-youngjin.gil@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 09:18:56PM +0900, Yeongjin Gil wrote:
> In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
> directly. But if FEC configured, it is desired to correct the data page
> through verity_verify_io. And the return value will be converted to
> blk_status and passed to verity_finish_io().
> 
> BTW, when a bit is set in v->validated_blocks, verity_verify_io() skips
> verification regardless of I/O error for the corresponding bio. In this
> case, the I/O error could not be returned properly, and as a result,
> there is a problem that abnormal data could be read for the
> corresponding block.
> 
> To fix this problem, when an I/O error occurs, do not skip verification
> even if the bit related is set in v->validated_blocks.
> 
> Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to only validate hashes once")
> Cc: stable@vger.kernel.org
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> (cherry picked from commit e8c5d45f82ce0c238a4817739892fe8897a3dcc3)
> ---
>  drivers/md/dm-verity-target.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

You sent multiple versions of this, that are different, and I have no
idea which one is correct :(

Please resend a v2 so that we have a chance to get this right.

thanks,

greg k-h
