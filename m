Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158877535F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 08:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHIG74 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 02:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjHIG7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 02:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E31FD8
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 23:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1CEA62FBE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 06:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC52C433C8;
        Wed,  9 Aug 2023 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691564388;
        bh=TFLpQyOx2gb3MAoTaV5+qtIzRQFdo+3Tas6F/w521r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9CnfD5TYsEW0YY9W7zl4d7N2n7IYwpmHZVmTj7Mc6Xz2vaUpNTMfea09cuSEGmox
         ojoUQKRBO3xIWcXgxaJW3id8VaB9Jaf68zA3QTY9ANwBuYLKbdpPHhSkEcTC3cpjzi
         eqwnUkdtpPtVZJOjeCl76PdymXn0Shm185wzmB/E=
Date:   Wed, 9 Aug 2023 08:59:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: stable-rc: 5.15: arm: fsl_dcu_drm_plane.c:176:20: error:
 'drm_plane_helper_destroy' undeclared here
Message-ID: <2023080946-wow-cross-1079@gregkh>
References: <CA+G9fYvTjm2oa6mXR=HUe6gYuVaS2nFb_otuvPfmPeKHDoC+Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvTjm2oa6mXR=HUe6gYuVaS2nFb_otuvPfmPeKHDoC+Tw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 09, 2023 at 11:47:45AM +0530, Naresh Kamboju wrote:
> While building Linux stable rc 5.15 arm with gcc-13 failed due to
> following warnings / errors.

I appreciate you attempting to build older LTS trees with newer
compilers, but note that usually, as you are finding out, this doesn't
work.

Right now I've finally gotten support for gcc-12 in all active stable
kernel trees, gcc-13 takes more work as you are finding out so I'm only
testing with newer trees (6.1 and newer).

So when you run into issues like this, that obviously work in newer
kernel releases, a report doesn't do much, BUT a git commit id of what
the commit that needs to be backported IS appreciated.

thanks,

greg k-h
