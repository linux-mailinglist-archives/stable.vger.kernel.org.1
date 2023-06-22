Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621F2739D89
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjFVJhD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjFVJgO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:36:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090419A1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:29:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 61FA95C00E8;
        Thu, 22 Jun 2023 05:29:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 22 Jun 2023 05:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687426180; x=1687512580; bh=oz
        yq1HT+tGUwlYeiUbvauhLLtqAA+pFVlTw94X40kaw=; b=LnrIBqKMEzTdrEFdEt
        SHwbQHUvwBFotRyCg4eOxtAWP2g+lQpaHfZB/X/MMD7l3KvbXQheTlEpRA3APPUO
        1DUS/bfUfHtQnhzPrm64NMfPEc3augQA1Edj8aI2YkILeC3ZtCKCROnPY0H5RSyB
        WwdP0uc0qicwUSnj0jY3BZf8gJajsS+zNFYrJGErbJEXLBJuUfyvcpSVIHN4pHhK
        n7miD8D3QcgwL78Q/qIUP5Auoh2pI70Q/B7yFJfw49+ZOPcJdUq0mTCp56NEPQoT
        QsDacuunnrmsVRASyk7kZkb9y+Or2xwEiHglcfcRGlrg0Us1GrYVgKV860ngc9qL
        Mamw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687426180; x=1687512580; bh=ozyq1HT+tGUwl
        YeiUbvauhLLtqAA+pFVlTw94X40kaw=; b=PUGe4CtUJpbUhuc7jsnnN/9bL68H/
        YWeoTf1qYQDVy6Ibwkn3aO8wsUCMxSjLU1vTf4cH+GmaGyaZwIM0K3iEIdQaMo/A
        fADUc4uVa+VmggxHzonoys/Z28p7Wia5DwXB3Z/Dy8s1WEA0jmP+W+i0sbsK6DDq
        b4+AwFxGUaw6uhNN5CPJj8CDgmyYiNHfB/fU0NiNsbNuxGSd6QZhbp+jmF/qJWVa
        vMqTEKDQmMmdw/Mw8bQxrqubwU7Y1e3PZHwHyVK+j6gAHc3Hpf6DeRD/tAozghaI
        8mhqvt1B3ARQy8ENMXko5qsI4TXsxGtHSf3036/CZHmaG14wLKiHAFfmg==
X-ME-Sender: <xms:hBSUZMc4WTXwAZIz3JRKwNT1EVjpxNXDVyvi4xKLiAxHVHy9kv1jxw>
    <xme:hBSUZOMSahHx_unTkk_jXdTcj47IlRQb4gTZxd82GWfdDRD_qcGBNkL_D56MoJtdY
    bxL5NKEb-M0Rg>
X-ME-Received: <xmr:hBSUZNhUxvEVugA7l2uPDmNdxgDZ2maQ_uhDG0QewOfluoM5tuOrEktwVoXrL1kdYkYRdmkf_ICxzENSpmQYhX4a2CRQB_fuUHIwJ3j4DBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:hBSUZB-cr-3lPk_9Nae6REMgdZA_kXXTslBCIVReWbA-M9604o4csw>
    <xmx:hBSUZIsX4QRlZITKoKPORTXgwJPAjbpu_RpqcbxZkjhyBh6vHpOTtA>
    <xmx:hBSUZIGECA6kREwgEbJ9DgYMmzrDmKLiSgKgzW-BQL0DSmwFRlUPHg>
    <xmx:hBSUZKIsKBN9fm-dCuVnaefsuz2DMUTgZQGk8QwdqM1ytjsCtOr_tA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 05:29:39 -0400 (EDT)
Date:   Thu, 22 Jun 2023 11:29:37 +0200
From:   Greg KH <greg@kroah.com>
To:     ovidiu.panait@windriver.com
Cc:     stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 5.4 2/3] media: dvbdev: fix error logic at
 dvb_register_device()
Message-ID: <2023062222-kindred-football-53e1@gregkh>
References: <20230622085645.1298223-1-ovidiu.panait@windriver.com>
 <20230622085645.1298223-2-ovidiu.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622085645.1298223-2-ovidiu.panait@windriver.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 11:56:44AM +0300, ovidiu.panait@windriver.com wrote:
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> commit 1fec2ecc252301110e4149e6183fa70460d29674 upstream.
> 
> As reported by smatch:
> 
> 	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:510 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
> 	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:530 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
> 	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:545 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
> 
> The error logic inside dvb_register_device() doesn't remove
> devices from the dvb_adapter_list in case of errors.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
>  drivers/media/dvb-core/dvbdev.c | 3 +++
>  1 file changed, 3 insertions(+)

Only 2 of 3 patches ever showed up, is there a 3/3?

thanks,

greg k-h
