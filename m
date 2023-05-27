Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6C71316E
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 03:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjE0BUL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 21:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjE0BUL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 21:20:11 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDCD9
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:20:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C3D7E320090B;
        Fri, 26 May 2023 21:20:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 26 May 2023 21:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685150406; x=1685236806; bh=1d
        7oKPGVdWB5JAEgMj9dkOXHwQuyjIMmlSbKS0bEYuk=; b=QfQ9unCm3iciiXRh6f
        V7W/J1OfSjCOSBSgAKv0QLLxkU1E+74aqKQCauR71jmTRE+jCCcJWqUKUe2Bq8DU
        vtKYPtUI9gp3t/bm2txM0tXS2WHI858sp9Ak9p2mQU3Jic1NDoTyRAOGoCv65D6p
        ZbAr3oqkfhFdj36kOqj3m9kzP6Ojqnpn4ZFRoyy6Rzy21BzzOrK6YUK9eQRh272a
        5+tdUKrSrgQeUALGJRIRFfTmmSv32ssPKcQQnpxzpfZ3yJXbxWkbmXsBtuC8H0Ca
        S27fv8BJdf1pbixqlKlhdtMNYKdSYWC28f8UL9EI/0Rfuz1TpzzEHsBpBFzucAwE
        YtoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685150406; x=1685236806; bh=1d7oKPGVdWB5J
        AEgMj9dkOXHwQuyjIMmlSbKS0bEYuk=; b=DtLlItFUFURx8AO3WVuiUA2QdvVRc
        dGlV2AA1jVoj+jhOMi0VZ8gGN3+e78jtxddQaqooOqF5X51H3U0ibVD0S9u6QtMv
        yczHHhxKm2+PVpmdLqIGJ4HMoQkElCExTJQcVRa/ZeyoCJM+CKiniRJCPb46JFiV
        TyEihR8F7Pv7fHZfOIPLGmEnefXNxB4uetBstALK3nAEQCvSiB1g/BxjXmT64ZOD
        wjBWnBEi0qZbqpsw4lCwEHY2p3FUYvBaEZBhmCtkcpcvUay7+r6c8gIUyuCpOO0/
        ngs1UjjglKoHdGbj/GZ2hxgZG39duodP1z4aeej6rISHaFA8H/finY0fQ==
X-ME-Sender: <xms:xlpxZP0dZ3EEfINUAhYmEc8j-ylCsXBF9WIaWMKB3cL8BgZBgohpkg>
    <xme:xlpxZOEuC0EVuGEgStDYsFpr3aIrq56n-qBeN_R437cXh1PQxGomg_mu1NqpaAFJa
    oTUDAF7sGzyB9M2-AU>
X-ME-Received: <xmr:xlpxZP5zrQoMrr_WK-o_iI25SN4qrbxiCXS17MRwFcx1p6_CsQpuw-Nx8ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeektddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeigfdvheejhefgtdfgfffgfeejveejueejfedvgfefveevudfgtdfgteegueff
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehthihh
    ihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:xlpxZE0DHNn_SqGnhmxwVdt9OLFJxqop0UhN6z6dkW6YXNiFJCiG0g>
    <xmx:xlpxZCFaJKk_90Y5wBXu48FxY5ZQvWygVLWxQhbak59dv19SmpKiPQ>
    <xmx:xlpxZF-ixuIehEj_CUI_76s4EQeqby5k4RjRYTp9RZEHGcyxl0Zw0g>
    <xmx:xlpxZHQqOqQiyY1ZTAh62Kqp66KPlk2By5GlQGBeg-Tz9TaUQjHdGA>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 21:20:05 -0400 (EDT)
Date:   Fri, 26 May 2023 20:20:03 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Hardik Garg <hargar@linux.microsoft.com>, stable@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown
 type name build failure
Message-ID: <ZHFaw6k8+2+MM1jv@sequoia>
References: <20230526232136.255244-1-hargar@linux.microsoft.com>
 <ZHE/avMpv2Sjqwxf@3bef23cc04e9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHE/avMpv2Sjqwxf@3bef23cc04e9>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-05-27 07:23:22, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
> Subject: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown type name build failure
> Link: https://lore.kernel.org/stable/20230526232136.255244-1-hargar%40linux.microsoft.com
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Please ignore this mail if the patch is not relevant for upstream.

I think Hardik did the right thing here. This is a build failure bug
that's present in stable kernels but was fixed in upstream by an
unrelated commit:

 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")

It wouldn't be right to backport that patch because MFD_NOEXEC_SEAL and
MFD_EXEC weren't introduced until v6.3.

There was an (unmerged) attempt to fix this specific build failure in upstream:

 https://lore.kernel.org/all/20211203024706.10094-1-luke.nowakowskikrijger@canonical.com/

Hardik opted to follow what was done upstream in a patch specifically
for the stable tree.

Tyler

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 
> 
