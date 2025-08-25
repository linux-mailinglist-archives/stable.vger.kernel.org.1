Return-Path: <stable+bounces-172888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164DBB34BDE
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 22:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E43C1B227AE
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F8927EFF1;
	Mon, 25 Aug 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpJ/V/wT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA5296BDF
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153742; cv=none; b=s1ppdxcPd0StQOFuSYjWSIuKCRiyLRNoq2qxz5E4cvfvTi1o53H4N7GlLq2xyBVZzsIbBP/8btU1qndK7e89muuztw8PE7aM1bcIN5byzqUuHoqw01T8KW3zWW/DdOKtxsPp9V7GZy94k75Dc+I1Ex1SeGofolFsCnt0CEwMITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153742; c=relaxed/simple;
	bh=cMFpc538AFBMdcE1lIa0328QIOWBCzu97/gWCg21c+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPlvwVYDD7lTufmK/AhAh/eObPxTR7tSZbmMHhc0ZjjJKvc3PMc3DO2g2P1CeHx8Fdxcb2ZUFTqZHcYDQH9fapkfh7xA7PzWU/YZCijeOLZUhpVaIn7rd+riBJPSjNrcxdcM6G1gqdRVAMwtUIdyLmx7DQIWLCpah0Y25E4CZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpJ/V/wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC2BC113D0;
	Mon, 25 Aug 2025 20:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756153742;
	bh=cMFpc538AFBMdcE1lIa0328QIOWBCzu97/gWCg21c+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MpJ/V/wT6nf1djFA8HrkEBZ7bk0W/6678LIj4RqRQvO4kCvdI07Fi0dftSwmID8vz
	 MnKgff/dSUT10yp11ARi/pEaMClP1Gm+daKinGju+6mAM1ReU1LFiFYHu89DopMA8K
	 IVXcFvL8MNc41bn0YsR9lH6FOH46aFCMGjbmGtS6I7r5Vr20J02A8C8arqTxgH/LE1
	 w+I5m7lvsvR4XRRqvZRBSlzJiddG/KW2JptJzP2WeZr2RJGj74AUcHQHb/uYDgHZp6
	 NEJTmHTIWWrwD7Z2DGDKaItYj4Sebrl8EoDihC6sLpYJjckqMTRjozE7ivK/fNhsJt
	 cErL3qM3iJzBA==
Message-ID: <f6efb0c8-532a-44d3-89a0-e419ab6265c2@kernel.org>
Date: Mon, 25 Aug 2025 22:28:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/nouveau: fix error path in nvkm_gsp_fwsec_v2
To: Timur Tabi <ttabi@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20250813001004.2986092-1-ttabi@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250813001004.2986092-1-ttabi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 2:10 AM, Timur Tabi wrote:
> Function nvkm_gsp_fwsec_v2() sets 'ret' if the kmemdup() call fails, but
> it never uses or returns 'ret' after that point.  We always need to release
> the firmware regardless, so do that and then check for error.
> 
> Fixes: 176fdcbddfd2 ("drm/nouveau/gsp/r535: add support for booting GSP-RM")
> Cc: stable@vger.kernel.org # v6.7+
> Signed-off-by: Timur Tabi <ttabi@nvidia.com>

For this and patch 2 and 3:

Applied to drm-misc-fixes, thanks!

