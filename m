Return-Path: <stable+bounces-112017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF5A2599C
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F023A80A4
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF12046A2;
	Mon,  3 Feb 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDS4XqXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2991FFC69;
	Mon,  3 Feb 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586457; cv=none; b=XNsDWn1dVpvWbuSxzTW39F+XsrMQSHoyCCFS3D/ZqyPai4MgnyUI2c4pvoBFiuv3FZ8ISp+PeaZMopidg1ayjFmjgrgqmmJGhJMOOPPMaI18pe6cghm6pCfnEgkoNhcqq3p6v4rNUIlQ0POhciAaSqdfBrHYgu+a7mxZjZBGHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586457; c=relaxed/simple;
	bh=2x4543iDCyMYIvzXvj88Hmrxc9skXCRk25au5A/HS5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoZ5nRWkiQ6Ftplhz/eLi3wpaoXrZDtXqKHhMArHOUuNNQx+/PduJBQ8bPKfukUdM+4O6bXJAb9PLhjNR3DV63agRKgY+LYD8RcYTw64V2VBYeb9l863RL2mUikiFK2qM7fTVDeTJBI6BskFA/gy849x1qB7+yH4HcpklQoT5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDS4XqXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125FCC4CED2;
	Mon,  3 Feb 2025 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738586456;
	bh=2x4543iDCyMYIvzXvj88Hmrxc9skXCRk25au5A/HS5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDS4XqXuzPEZjwamGcSp4jfdgJF6SvVD9QAOTmzrhIR3PLfGfWb3NJBlU92fJRu5l
	 9WRzOaMM/mZ1qhw+vhXUywC6u3ridXJF1ykTXdPJ/oRHU4HqgqfG60yGbeGjUHbi+f
	 zZXMef90W1iPpp0Dsx77h+WyB7QLDIkY42LGq1d6AQyKWqGsI9t67+41Ysi6wxlYdS
	 R3+sh3cXLmG+NLcjleSu+casPMi+7MRiGbGRzv20g1u1AXlq5beF7jiAJKdZCbdF4s
	 D9g81CNwAgztlJz4h2eM3uVneXI/89azwbShzxBb52YbSvBf8WHblBRUzChpPMrJIk
	 2jJBf8qojgUoQ==
Date: Mon, 3 Feb 2025 07:40:54 -0500
From: Sasha Levin <sashal@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	matthew.brost@intel.com, Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/ttm: Add ttm_bo_access" has been added to the
 6.12-stable tree
Message-ID: <Z6C5VoKzOeXZy4-B@lappy>
References: <20250202043332.1912950-1-sashal@kernel.org>
 <36c6750c-6bc1-4b56-bc9b-3c27ca23b8b6@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36c6750c-6bc1-4b56-bc9b-3c27ca23b8b6@amd.com>

On Mon, Feb 03, 2025 at 10:22:57AM +0100, Christian König wrote:
>Am 02.02.25 um 05:33 schrieb Sasha Levin:
>>This is a note to let you know that I've just added the patch titled
>>
>>     drm/ttm: Add ttm_bo_access
>>
>>to the 6.12-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
>This isn't a bug fix but a new feature and therefore shouldn't be 
>backported.

Right, it was added as a dependency for:

>>     Stable-dep-of: 5f7bec831f1f ("drm/xe: Use ttm_bo_access in xe_vm_snapshot_capture_delayed")

But since 5f7bec831f1f is going to be dropped, I'll drop this commit
too.

-- 
Thanks,
Sasha

