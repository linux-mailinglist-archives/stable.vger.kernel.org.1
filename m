Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8979CEF1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjILKzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjILKzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 06:55:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80652B3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 03:55:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55C4C433C8;
        Tue, 12 Sep 2023 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694516108;
        bh=sHKKugO9ZHrlkUfenT+hGUjJb9NF61q8E7uoZuqlIv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K24iGGg6iZmRjCoxEg+q7CgM8abJKPMCHrzsJhKoHJGOCztq99hWTPGViLOCWihDS
         MpDAS8gmkjKDnobnXDprse5mIcawO2z3bAG2s2B+L8tBwT5Jf0p1FKaG1tQebzlwl4
         Rw4mZnGayP+WxXWlYM/KtRB39eSn8V4L3ReUO3Ug=
Date:   Tue, 12 Sep 2023 12:55:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 363/739] ASoC: pxa: merge DAI call back functions
 into ops
Message-ID: <2023091247-playmaker-ferocity-e647@gregkh>
References: <20230911134650.921299741@linuxfoundation.org>
 <20230911134701.287984009@linuxfoundation.org>
 <ZP8oR4nDRDpsxLkM@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP8oR4nDRDpsxLkM@finisterre.sirena.org.uk>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 03:46:31PM +0100, Mark Brown wrote:
> On Mon, Sep 11, 2023 at 03:42:42PM +0200, Greg Kroah-Hartman wrote:
> > 6.5-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > [ Upstream commit 98e268a7205706f809658345399eead7c7d1b8bb ]
> > 
> > ALSA SoC merges DAI call backs into .ops.
> > This patch merge these into one.
> 
> This is obviously not stable material.

Odd, Sasha, how did these get picked by your scripts?

I've dropped all 3 now, thanks for noticing them.

greg k-h
