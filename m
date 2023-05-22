Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8F70C390
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjEVQga (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjEVQg1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 12:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D8F1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 09:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 067A961B5F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 16:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43597C433D2;
        Mon, 22 May 2023 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684773380;
        bh=x3WoWBnXzN/NTh6aSDHS3bcgHVGPfkc5wKh4bZ5YrT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WipIlgMq7p12o3ka1Sqlygiw79EZWLk+sjikVhPhVwZ603XWn8o+naLW3ICES8nGm
         gbYYuI3hbXOmVGzWFMGE5qWFUBIfkAFwKXPZFCdsqV3CWT+JSMJcRSS7qa45tswDUm
         6Qiawh7BMYsf5VGCjM+tC+Pyec/qJf4qpv8gAb9IItGnKOQAMvlnidIqw5Fkpuzz+w
         GqL9h4jLs4aEmY1tBBD7W0A4T2/S46SyKzeZDBWv/iwgfd0Hv5ZQXJopbgG7CzEbhJ
         j9cdTlXzyYReR+TSkTHXAvM8j9Syx4e3J2AQ3KCtsdXJIoV7IIuG7Iy/eY6s18uZh8
         w+vT94yxvGcSQ==
Date:   Mon, 22 May 2023 12:36:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: v6.3 backport request
Message-ID: <ZGuaAs36tVuNJyhd@sashalap>
References: <CAMj1kXEJSzkEMuHvzuS1y9SJ=HaAi7z=LgB_0vJHr8H8EeQUVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXEJSzkEMuHvzuS1y9SJ=HaAi7z=LgB_0vJHr8H8EeQUVg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 18, 2023 at 02:30:38PM +0200, Ard Biesheuvel wrote:
>Please backport
>
>c76c6c4ecbec0deb ARM: 9294/2: vfp: Fix broken softirq handling with
>instrumentation enabled
>2b951b0efbaa6c80 ARM: 9297/1: vfp: avoid unbalanced stack on 'success'
>return path

Queued up, thanks!

-- 
Thanks,
Sasha
