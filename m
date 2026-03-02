Return-Path: <stable+bounces-222601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDd8OXWZpWnxEgYAu9opvQ
	(envelope-from <stable+bounces-222601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:06:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5871DA5F4
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B526F3047374
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A73FB05D;
	Mon,  2 Mar 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSx9Hmt5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308173FB057;
	Mon,  2 Mar 2026 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459908; cv=none; b=ZiWuAlUG6n6/rxLqSg7Nvu+ekUkFV8Zj1XYMlb9CQywZ7R2X0iNpVvhNG5WRZBD9VqePMB6STwZh40EnHz99almIqyZ06twujhLEo+wuUGtScpCrG8Ftf0f8xoPsF9Q7e99Frcxa+32iZrE7vIPVjOEZAicw+9l5Obgck8Bhg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459908; c=relaxed/simple;
	bh=GgqKjJN/rOk5xgaTihQE2wv4/AmImW7P7d/dDc2JBJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBW1GBKXEIk6jy8vU01ctUerFE1Iqk5kd9fl5kX2noqEJc5zYrMCd0GskB6BfeEaThk8Ogkvh+GSn1bwabL3v6egTUYqj660E4hcbX++SPyYl/194qm5WUTgvgGbdEs7g+Kafhqb8EEACOtbt69yqPqH9foDmMd4pkLN95I+ufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSx9Hmt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9067C19423;
	Mon,  2 Mar 2026 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772459907;
	bh=GgqKjJN/rOk5xgaTihQE2wv4/AmImW7P7d/dDc2JBJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSx9Hmt5By8+PdJFO4mmDpgH0NepzkfFt54xbCZhgYGM4UtEKPhrxBNYkZJeez/BO
	 mgcXLHU3/Hsm91/BBWbYGirE7pXLAVnbQaLkwNMnQ0MTFPSAdzm4vHwnbVgRfJZoD2
	 7cYsfFbNWNKeKm3pfbfLJw3EFVwCk99qWu2NnuOAOZFEoZTr+3dX+96iWrP7x4iZ/X
	 4bRFO/qRc8nPjoilU2jZlXv87IhvhSPOqWBCcn1J9KnC9mO3AaXEVv4Px4Jdhv4jT2
	 liUQhkxK3W73m2vYT+GFTXmKCUr9OXAATCaBRo1+rXzqv4sKuHJEg1BP7wr8QX0ZzG
	 gq6mgFxBXMiJA==
Date: Mon, 2 Mar 2026 08:58:26 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 6.19 164/844] drm/amdgpu: Refactor amdgpu_gem_va_ioctl
 for Handling Last Fence Update and Timeline Management v4
Message-ID: <aaWXgu3t5xFcIuTC@laps>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <20260228173244.1509663-165-sashal@kernel.org>
 <ff07a4ff-ecd4-4953-a191-cc45bf17cc52@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ff07a4ff-ecd4-4953-a191-cc45bf17cc52@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222601-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: BA5871DA5F4
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:24:00AM +0100, Jiri Slaby wrote:
>On 28. 02. 26, 18:21, Sasha Levin wrote:
>>From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>
>>[ Upstream commit bd8150a1b3370a9f7761c5814202a3fe5a79f44f ]
>
>A new fix appeared:
>efdc66fe12b0 drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling 
>Last Fence Update and Timeline Management v7

Queued up, thanks!

-- 
Thanks,
Sasha

