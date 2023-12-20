Return-Path: <stable+bounces-7981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C52181A151
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E979B20BBD
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891193D397;
	Wed, 20 Dec 2023 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmXjZZHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652F24B3E
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B2FC433C7;
	Wed, 20 Dec 2023 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703083414;
	bh=Mu4hZfoRNoh1a8Rph22C2Hap+ZvsOZb4QiAIn3F/GFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmXjZZHRJEQqjcW219h9CEcWa+kOny89eer+0oc4PqCgannPFqT0htIKuv+UMr8tZ
	 teCosbOeU8lMLeJXqllQiFbnTD49kG4hCoPGLmltmcHe+0tT2Q/FZrtZy1+sxrUGFF
	 qz3neqWf7Jglp0Ue52Vz+Scf+daSTxhSXWheM33Q=
Date: Wed, 20 Dec 2023 15:43:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH for-5.15.y 0/3] Revert lt9611uxc fixes which broke
Message-ID: <2023122026-improving-circular-bc52@gregkh>
References: <20231219101118.965996-1-amit.pundir@linaro.org>
 <CAMi1Hd3-kYAfSOS7SBR2=ZLZ0sbvDWgyPm=t0KALzGpdomQGSw@mail.gmail.com>
 <2023121933-trapping-snazzy-1c69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121933-trapping-snazzy-1c69@gregkh>

On Tue, Dec 19, 2023 at 11:52:52AM +0100, Greg KH wrote:
> On Tue, Dec 19, 2023 at 03:44:14PM +0530, Amit Pundir wrote:
> > Apologies for the half-baked subject line. I don't know what went
> > wrong there. I meant "Revert lt9611uxc fixes which broke display on
> > RB5".
> 
> Thanks, will queue these up after the latest -rc releases are done in a
> few days.

All now queued up, thanks.

greg k-h

