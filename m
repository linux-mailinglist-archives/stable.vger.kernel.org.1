Return-Path: <stable+bounces-196554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2BC7B421
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58B834ECB7C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBD4204E;
	Fri, 21 Nov 2025 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN1k/9rJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB042F1FF4;
	Fri, 21 Nov 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748782; cv=none; b=Kl9KjxRELLNKoyO61eotW6o4kfKE8SzzQAsFiz6JaP3N4LqPi0pvYJ+nFWEcKujIFvw1MXNUm4TEd94SQdIJCi+/b3lUEeFAeEaukaJXjcvkVynsPb79MqR+N+Dw0AaKiMmfsPXulE4BJg+lxhjIKbRaThmyXcZCx4OJse/79lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748782; c=relaxed/simple;
	bh=ciG2Nj0pYXsP4aHEj533fCSUzMUNHoWTFeM6CiB3B0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV9VQmhDPxg2Cb9zMicRqC+gthTKh5t3+xgLWxxG3W8gCjwpBqKrYcMK4Jf12Y6QzTEqzoXGgh3Q3tNXQIQqI0nnLmbAWIg8YyWQO3j3BIsbtVemQki3u1r6PPC5lT7PnI995d0lZWbjRzZ29KtCG46+bvxIL+gcWWBn78YZS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN1k/9rJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA419C4CEF1;
	Fri, 21 Nov 2025 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748779;
	bh=ciG2Nj0pYXsP4aHEj533fCSUzMUNHoWTFeM6CiB3B0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN1k/9rJrgxYja0V5Pxf7+XmQlb5kVx8MgFpNKr6AWRA9lvQS1Ix8EoauPi91BSPz
	 0NH8miljFSMCT7Up86LXBZBaLUfQ9iQQKzCGg1cM7DulB9sbfG751f7bTLwZKPsweL
	 M0ZtX08oaGGVfbqX9nWxLDRvFP8URzlxa48oc/VS3Nn0psQScsJidhFYBnl1PoXBUR
	 CVNOvRIXAFxLk6F+bntJfavW5hpvdxumZ/6FvJzkOYhxd/Hsm8u7wHgxoVGuvPB7mL
	 wJqHyZJR9cFbgATC36TJtv9ZTfIfZStLM0yzywTZstm8yV3TTW4PENz7ETjmMOqdKJ
	 s8uu+0GrFRl9w==
Date: Fri, 21 Nov 2025 13:12:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 6.6 251/529] RDMA/irdma: Update Kconfig
Message-ID: <aSCrqljm-7ghfKtv@laps>
References: <20251121130230.985163914@linuxfoundation.org>
 <20251121130239.948035019@linuxfoundation.org>
 <IA1PR11MB772718B36A3B27D2F07B0109CBD5A@IA1PR11MB7727.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <IA1PR11MB772718B36A3B27D2F07B0109CBD5A@IA1PR11MB7727.namprd11.prod.outlook.com>

On Fri, Nov 21, 2025 at 05:40:39PM +0000, Nikolova, Tatyana E wrote:
>
>
>> -----Original Message-----
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Sent: Friday, November 21, 2025 7:09 AM
>> To: stable@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
>> patches@lists.linux.dev; Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>;
>> Jacob Moroni <jmoroni@google.com>; Leon Romanovsky <leon@kernel.org>;
>> Sasha Levin <sashal@kernel.org>
>> Subject: [PATCH 6.6 251/529] RDMA/irdma: Update Kconfig
>>
>> 6.6-stable review patch.  If anyone has any objections, please let me know.
>
>Hi Greg,
>
>Even though IDPF driver exists in older kernels, it doesn't provide RDMA support so there is no need for IRDMA to depend on IDPF in kernels <= 6.17.
>
>060842fed53f ("RDMA/irdma: Update Kconfig") patch shouldn't be backported in kernels <= 6.17

I'll drop it, thanks for the report!

-- 
Thanks,
Sasha

