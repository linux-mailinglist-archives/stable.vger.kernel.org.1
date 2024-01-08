Return-Path: <stable+bounces-10020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EA88270C8
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD361F22E92
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13546427;
	Mon,  8 Jan 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="potal3XF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63645C07
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 14:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2406C433C8;
	Mon,  8 Jan 2024 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704723147;
	bh=g0CyI3IM59Nwu0RmGUbsGVo1YgOVrILQUQ5KDtCjkds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=potal3XFdjaW2zkb4AgK8sVHUZSwO5XWgfNQVQdhmq2NS4VdMILXoM7TRtjO9X28Z
	 vjmfMRYmKRu0LHjqt3qnWLZTEe3bFV04UI2TmRVg0ZJtswe6V6RWpG2qhsEQX521R+
	 6o2xlBczTtiR3ijpiGXYV3KQbPHaDQR0AjMbTnBE=
Date: Mon, 8 Jan 2024 15:12:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stable <stable@vger.kernel.org>
Subject: Re: [PATCH for-6.1.y] Revert "interconnect: qcom: sm8250: Enable
 sync_state"
Message-ID: <2024010850-latch-occupancy-e727@gregkh>
References: <20240107155702.3395873-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107155702.3395873-1-amit.pundir@linaro.org>

On Sun, Jan 07, 2024 at 09:27:02PM +0530, Amit Pundir wrote:
> This reverts commit 3637f6bdfe2ccd53c493836b6e43c9a73e4513b3 which is
> commit bfc7db1cb94ad664546d70212699f8cc6c539e8c upstream.
> 
> This resulted in boot regression on RB5 (sm8250), causing the device
> to hard crash into USB crash dump mode everytime.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

Any link to that report?  Is this also an issue in 6.7 and/or 6.6.y?

thanks,

greg k-h

