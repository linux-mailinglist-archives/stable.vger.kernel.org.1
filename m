Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F097C9A6F
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJORsm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJORsl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 13:48:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A3AAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 10:48:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781ABC433C7;
        Sun, 15 Oct 2023 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697392120;
        bh=e7pYUIwoY9i67vYNaeVnPKr11BmBB0CqKXeTA68t9zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLGpzlXS72JBStrwk+tH5fqYDTq1MX28BXyPbWtXmfCo0PqCFaKfNQ0ZGUFzs3ecs
         STco/qdrEoo3uNU7Wy9BfjhgoA8CFr2HxUAZu9up9Ng8fDFuPPxVMhuCnSjoVGDhce
         WRV0uhSDHtwGRgbwszsGZvWdH0FVzpW/FekrDqm8=
Date:   Sun, 15 Oct 2023 19:48:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     stable@vger.kernel.org, hackerzheng666@gmail.com,
        sashal@kernel.org, patches@lists.linux.dev, amergnat@baylibre.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled  work
Message-ID: <2023101528-scuba-walmart-fe3f@gregkh>
References: <20231015144747.729031-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015144747.729031-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 10:47:47PM +0800, Zheng Wang wrote:
> This is a security bug that has been reported to google.
> It affected all platforms on chrome-os. Please apply this
> patch to 5.10.

Both now queued up, thanks.

greg k-h
