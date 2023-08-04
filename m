Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E68576FECE
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHDKr0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjHDKqx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46C859DA
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B57C61F9F
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 10:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD25C433C9;
        Fri,  4 Aug 2023 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691145932;
        bh=XEJ6/taXKzOxz1qeJ2Fp7+Ci0QrPjH39eE9R1Dxw134=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDZUIZExDIV1jEqFMR42JUE+BLLBnZaPKw2/rpgybwfoN4VPm7L84KMz9GeSMthsW
         eoIkpys5NSywPfJQar8Qav7Pl67Dh2llOtylOfaC+wS/TytFGXv9QlQOxyFJgBkWbY
         jqJ6c/54PNbnH2jwXhwsk3jRatIWyaWTGVIjXazI=
Date:   Fri, 4 Aug 2023 12:45:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Elder <elder@linaro.org>
Cc:     stable@vger.kernel.org, kuba@kernel.org, dianders@chromium.org,
        elder@kernel.org
Subject: Re: [PATCH] net: ipa: only reset hashed tables when supported
Message-ID: <2023080420-wrongdoer-omega-d6f9@gregkh>
References: <20230803200506.282159-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803200506.282159-1-elder@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 03, 2023 at 03:05:06PM -0500, Alex Elder wrote:
> commit e11ec2b868af2b351c6c1e2e50eb711cc5423a10 upstream.

Now queued up, thanks.

greg k-h
