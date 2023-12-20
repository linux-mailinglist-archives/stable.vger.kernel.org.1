Return-Path: <stable+bounces-7979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E481681A14D
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 15:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C23B21C3A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58F3D97F;
	Wed, 20 Dec 2023 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YsSEJZCn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B13D966
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E153FC433AB;
	Wed, 20 Dec 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703083317;
	bh=D4LOMoxBaj23V4eaa3ybTWr2HjE6HQAlBgZfc+K8kHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsSEJZCniTTye2UWupK7CFgyIuMqgvwqDcuLMTA/ekfjNtHzJ9JSVcZInsjYrZP4d
	 fxsfL5EuVFtxtpjM2dNXjOrWO2iwSoNH1dP/s1qxg7oprxbmxnRDXu/PYm4kO88SqB
	 wPnAdz012yrCy63Q0t180Ie/RQDbJiyo1Ti/Mssc=
Date: Wed, 20 Dec 2023 15:41:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org, smfrench@gmail.com
Subject: Re: [PATCH 5.15.y 000/154] ksmbd backport patches for 5.15.y
Message-ID: <2023122045-snuggle-rocky-b3f8@gregkh>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>

On Tue, Dec 19, 2023 at 12:32:20AM +0900, Namjae Jeon wrote:
> This patchset backport ksmbd patches between 5.16 and 6.7-rc5 kernel.
> Bug fixes and CVE patches were not applied well due to clean-up and new
> feautre patches. To facilitate backport, This patch-set included
> clean-up patches and new feature patches of ksmbd for stable 5.15
> kernel.

All now queued up, thanks!

greg k-h

