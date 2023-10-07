Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083827BC71B
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjJGLYm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 07:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjJGLYl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 07:24:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73664B9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 04:24:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3FECF3200999;
        Sat,  7 Oct 2023 07:24:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 07 Oct 2023 07:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696677875; x=1696764275; bh=QV
        t/3v9LjowRKy98MrMKYBNEyAEJnitE9we2PnKUIHM=; b=Ko2Ea3/qJkFWpqFibS
        p/0nm0hVG7FH5Rq6wHlsG3GcZlmENHsyd5euBV4tbc1MdEMLTsQX0I/vt10PM4AT
        JmFPKen/IRkGs4MLpmhp1Tum1Y18l3DQhcDKeBnWjZ++mxu4rh1leBwoCNyNeEsa
        8nxNwN2uxN9F26L35wrlclYAhfjpFDjgcKQr3ZqjSt38qUN1yksHrZb6/xkGRIeU
        000Qwex6PCc1qRGxRxaW33ewaBv6w8DPzGNKYuB4o7suVd8yopg8KNzA/JGRCBWP
        e+CIaNJEekpdkyhdRmSt2KNitx9cTDOkDBRqcawhcKJZy1CdKvPLu+OLO53pj3pA
        XBQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696677875; x=1696764275; bh=QVt/3v9LjowRK
        y98MrMKYBNEyAEJnitE9we2PnKUIHM=; b=a2W0nVTlsE5H0y2fFB5X8gYAu+raZ
        U7vkYaJmbiQc23/fuybamJF0YF0+Kd0mdfzhsuwkUjgtHzfRSg0An+yimkfRCWRp
        oskqRPl/thJacH1BisHmw/gdkl3Ua0nykp5CDawaMdQDwOwjq39tFKEERFeGKOb5
        J8XrOUxuNZS+DTlo/6wTxp0ylxsHAReUsX4uuCQNzA/Sq5+h1zul1QnrD1Ytgr60
        zfg4VBMliMp2QUbsJwe8cV4kbx6yc2kTP48xkWlbwaIkEZqMHXcqsBDD4vnqfFdn
        B0U5QGmKtuowMeYqxiNTDijxPTxxrSWxY+F+/2jIEtAEM2tpWdjwBeHdQ==
X-ME-Sender: <xms:8z8hZT3E-QUJasb4D8_4A535pgjuZbYJBmOGzGdux0jr5DG9fC2AwQ>
    <xme:8z8hZSF42QesuMch-GkLbActm5fTQVUciEFE6vpBOEMfThv6gOogsWHTY8C3i39DP
    wFbwSMnILWVUA>
X-ME-Received: <xmr:8z8hZT4kUg3KJpwtprFvPpNOH9duTpFhucKEqYGxsDOyWuR5y4qW3EH6I9Q9YJqghjcgr40DaeM9iOkpcTERAhYAtaU_t1I4WjY3bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:8z8hZY2OlOrG6mNVap-I1mQdWWux7yBW2maVaaqfZ4Y6yHokMTejVA>
    <xmx:8z8hZWEkk0WVKDfgAF34atfBxzxfxAo1xY2ymrKhuxk_xP5Lh1PbXw>
    <xmx:8z8hZZ8_qPrzMprBbmb06OakjYc0DwEer06pNp3cCnCxMtPC8wfeoA>
    <xmx:8z8hZUaY6umroTaTgpqnyav3ybCacF8aNq4w_x9gvUe1hWjD8IlPsA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 07:24:35 -0400 (EDT)
Date:   Sat, 7 Oct 2023 13:24:32 +0200
From:   Greg KH <greg@kroah.com>
To:     Shaoying Xu <shaoyi@amazon.com>
Cc:     stable@vger.kernel.org, markovicbudimir@gmail.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 4.14] net/sched: sch_hfsc: Ensure inner classes have fsc
 curve
Message-ID: <2023100716-hacksaw-pampers-22f1@gregkh>
References: <20230920175145.23384-1-shaoyi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920175145.23384-1-shaoyi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 05:51:45PM +0000, Shaoying Xu wrote:
> From: Budimir Markovic <markovicbudimir@gmail.com>
> 
> [ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]
> 
> HFSC assumes that inner classes have an fsc curve, but it is currently
> possible for classes without an fsc curve to become parents. This leads
> to bugs including a use-after-free.
> 
> Don't allow non-root classes without HFSC_FSC to become parents.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ v4.14: Delete NL_SET_ERR_MSG because extack is not added to hfsc_change_class ]
> Cc: <stable@vger.kernel.org> # 4.14 

Trailing whitespace, please fix your editor :(

Anyway, now queued up, thanks.

greg k-h
