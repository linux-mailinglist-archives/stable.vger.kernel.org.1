Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781BD79CE9B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjILKoI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 06:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjILKoH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 06:44:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAEB1FF5
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 03:34:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED57C433C7;
        Tue, 12 Sep 2023 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694514845;
        bh=LUobv7SluRAhwPkCwsysSqViibZox9UQzgrORWf91hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itSKEfHZgDCToPGuEf9aCSCneUW5kawklARi1gt9JGYquCuvfgMQE48EsG2GG+dBJ
         oROQpGgOGeX5a2HrK3Q/GeaDesePdq/h1u12jqtmhGO6K3N9TYsYvmKfZJkH4lLA96
         DP7Fp0VVyzuAqATw9CIqK/mttWmivYwZ/VMx0oNQ=
Date:   Tue, 12 Sep 2023 12:34:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 213/600] drm: bridge: dw-mipi-dsi: Fix enable/disable
 of DSI controller
Message-ID: <2023091252-baggage-calorie-e2e8@gregkh>
References: <20230911134633.619970489@linuxfoundation.org>
 <20230911134639.905252752@linuxfoundation.org>
 <6xoqdk4sttjv5pskf67r5gc24ttsuspb6bnip5o35xcfmdtilp@72qguymwyt7y>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6xoqdk4sttjv5pskf67r5gc24ttsuspb6bnip5o35xcfmdtilp@72qguymwyt7y>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 05:49:30PM +0200, Ondřej Jirman wrote:
> On Mon, Sep 11, 2023 at 03:44:06PM +0200, Greg Kroah-Hartman wrote:
> > 
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> See patch message comment:
> 
>        (But depends on functionality intorduced in Linux 6.3, so this patch will
>         not build on older kernels when applied to older stable branches.)

Ah, missed that, thanks, now dropped.

greg k-h
