Return-Path: <stable+bounces-7899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89D8185B2
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822141F25311
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C226F14AB6;
	Tue, 19 Dec 2023 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmSU9twR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6715480
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EDCC433C7;
	Tue, 19 Dec 2023 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702983174;
	bh=C/yRQY131N+fIRH2V9YxWiKOfCFofXvq9906hs5Rc1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmSU9twR3LD3+Mm0bBvei0S/HX5zCVRlLn0ZReRa1bfbGGXMQXDeF0XVyqgG0qql0
	 e67nc8tEAlPPI0HQNPoFUC4Lic65uxTlVtdWVWXydEDEH+Ieb5dgJJ0n9MkSzdCK3+
	 gUYJ/YAZ5nYD3cZUtGcf+eYXehwOMsN/VuyZXsc8=
Date: Tue, 19 Dec 2023 11:52:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH for-5.15.y 0/3] Revert lt9611uxc fixes which broke
Message-ID: <2023121933-trapping-snazzy-1c69@gregkh>
References: <20231219101118.965996-1-amit.pundir@linaro.org>
 <CAMi1Hd3-kYAfSOS7SBR2=ZLZ0sbvDWgyPm=t0KALzGpdomQGSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd3-kYAfSOS7SBR2=ZLZ0sbvDWgyPm=t0KALzGpdomQGSw@mail.gmail.com>

On Tue, Dec 19, 2023 at 03:44:14PM +0530, Amit Pundir wrote:
> Apologies for the half-baked subject line. I don't know what went
> wrong there. I meant "Revert lt9611uxc fixes which broke display on
> RB5".

Thanks, will queue these up after the latest -rc releases are done in a
few days.

greg k-h

