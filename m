Return-Path: <stable+bounces-7881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0048183A8
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A71C1F25058
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E444101EF;
	Tue, 19 Dec 2023 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pd2sU6iR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB112B61
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 08:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC342C433C8;
	Tue, 19 Dec 2023 08:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702975498;
	bh=1jLpPfzzkbIK83bRbSTxGQdIOX/RzBETCdq/xkqp6aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pd2sU6iRj/tWLfNZAnOJksiwCw+z6EZnOozec4lvmyp+RoSOgCF44gKXdYYGth7FW
	 ZdDWbdOswqBOPvSQ0lz+er41zrjOz3mpPZyZ9xf/URfHMPTN9q2DHQAmpncOPAyIu5
	 cxjhyScfhY04YaOiGlexyhM+S7bGPlCLhjS6sAMY=
Date: Tue, 19 Dec 2023 09:44:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	stable <stable@vger.kernel.org>
Subject: Re: Request to revert lt9611uxc fixes from v5.15.y
Message-ID: <2023121931-spool-outlying-4ef9@gregkh>
References: <CAMi1Hd2jWZpZn8O1eP5qCZ2HfLbvBAEJsM5FwZxp-rC3q-V7KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd2jWZpZn8O1eP5qCZ2HfLbvBAEJsM5FwZxp-rC3q-V7KQ@mail.gmail.com>

On Tue, Dec 19, 2023 at 01:54:59PM +0530, Amit Pundir wrote:
> Hi Greg,
> 
> The following lt9611uxc fixes in v5.15.139 broke display on RB5 devboard.
> 
> drm/bridge: lt9611uxc: fix the race in the error path
> drm/bridge: lt9611uxc: Register and attach our DSI device at probe
> drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers
> 
> Reverting them (git revert -s d0d01bb4a560 29aba28ea195 f53a04579328
> #5.15 SHA Ids) fix the following errors on RB5 and get the display
> working again on v5.15.143.
> 
> lt9611uxc 5-002b: LT9611 revision: 0x17.04.93
> lt9611uxc 5-002b: LT9611 version: 0x43
> lt9611uxc 5-002b: failed to find dsi host
> msm ae00000.mdss: bound ae01000.mdp (ops dpu_ops [msm])
> msm_dsi_manager_register: failed to register mipi dsi host for DSI 0: -517

Great, can you send patches that do the reverts along with the reasoning
why the reverts are needed so that we can queue them up?

thanks,

greg k-h

