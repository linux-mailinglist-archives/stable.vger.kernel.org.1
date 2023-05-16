Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6F5704632
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjEPHUO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 03:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjEPHTk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 03:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E081421D
        for <stable@vger.kernel.org>; Tue, 16 May 2023 00:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A68361772
        for <stable@vger.kernel.org>; Tue, 16 May 2023 07:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D896FC433EF;
        Tue, 16 May 2023 07:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684221574;
        bh=wmYkRYF+yvLqVr17NTcRzLuGmJoYEiXBVSA6nlwZa/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yWDAfthObouQH2Q6b3T03jnrd18pQVwk1QpB2A/o1rsSsRxe3EOsgEMQDPaxTdOIS
         m/+BMisJ7Afsp4QZnYwJk1K0x9hqeEAAqTYaW7GUQXQ8RosY1dQVqaRe7fxxr5RBPp
         i81B460/GSrTD6O3834RXmtzmXzYGI1vusKxSGLQ=
Date:   Tue, 16 May 2023 09:19:31 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Sripada, Radhakrishna" <radhakrishna.sripada@intel.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "Manna, Animesh" <animesh.manna@intel.com>,
        "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>,
        "Souza, Jose" <jose.souza@intel.com>
Subject: Re: [PATCH 6.2 213/242] drm/i915/mtl: update scaler source and
 destination limits for MTL
Message-ID: <2023051607-rocker-refinish-8c6c@gregkh>
References: <20230515161721.802179972@linuxfoundation.org>
 <20230515161728.319620707@linuxfoundation.org>
 <51bf59b96c22c2e79d81e38c3dc1b006959a14c8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51bf59b96c22c2e79d81e38c3dc1b006959a14c8.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 16, 2023 at 07:13:42AM +0000, Coelho, Luciano wrote:
> On Mon, 2023-05-15 at 18:28 +0200, Greg Kroah-Hartman wrote:
> > From: Animesh Manna <animesh.manna@intel.com>
> > 
> > [ Upstream commit f840834a8b60ffd305f03a53007605ba4dfbbc4b ]
> > 
> > The max source and destination limits for scalers in MTL have changed.
> > Use the new values accordingly.
> > 
> > Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> > Signed-off-by: Animesh Manna <animesh.manna@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
> > Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20221223130509.43245-3-luciano.coelho@intel.com
> > Stable-dep-of: d944eafed618 ("drm/i915: Check pipe source size when using skl+ scalers")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> 
> This patch is only relevant for MTL, which is not fully supported on
> v6.2 yet, so I don't think we need to cherry-pick it to v6.2.

Does it break anything on 6.2?  If not, I think you want it as it is a
dependancy for another fix, right?

thanks,

greg k-h
