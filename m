Return-Path: <stable+bounces-192397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD6C31550
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106183A20CF
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0A329E54;
	Tue,  4 Nov 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri/ihQG6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4D328615;
	Tue,  4 Nov 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264614; cv=none; b=FqhpUMVZpUbZ87lPq9jV/pNqadJ6avYfP9sIDW0IjAG4fQAEL+UUEk0wzUrO6sByPM/GXShyyyN8gnnLh8BVywBZOyp0K/bnGPQjqNaPe/JuCxYlLETVPxtAYPgjyJz9LcDysJFfMgqUNa5gRDp3MFB7aYQrgnKSC1TyOlICM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264614; c=relaxed/simple;
	bh=io5PAIiiIVOczAfgqSDOgAR98uLwbh8QyX/emmJjf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI33YTatx8x/KZey9rbPtYC8ADMl2EnC3n14B+mfDLsFhg7e62l9jw7SamWCf2Kk6HPf6//PAzIVA2yHn4AQ4wiRKYwnIDHYvIaVbQl81DbVkMU3g/TF+agNLozl4UhOQ7nRTEj6v4LISK9q9tlEiURGl5wj4yTL5Honw1YF2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri/ihQG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD1C4CEF7;
	Tue,  4 Nov 2025 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264613;
	bh=io5PAIiiIVOczAfgqSDOgAR98uLwbh8QyX/emmJjf0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri/ihQG6gRbmU6UDTFUz1m6ZqauKkQVlnxoZApnv3vY0fmtxUgA7HQTvTv+onVhEv
	 IdZ8CUbU/M+tzJ0WhJQoQtjKfnAjJ6Me9q6KBEE51ZdBs+ZF6r4DEupe2POGHCU2q8
	 x+x9gfxT/AISazb4wwBKqDa0O5BGQzza9BB8sis+6gzSsl2ZmpyZVvSYD2/lCz9nyw
	 OGB1Zl8pO74DN0xUVHBx2Is1t6fGbZsElCvWX+Tcdy234s7sX+8ssM5HE8p4+IjaNU
	 eMNr1E9EvceH8IYmdqyszikQErpggK96auNZIrLbWcgu0YTVQggEPRj11xB9hK53tk
	 f0xy0GodaadBg==
Date: Tue, 4 Nov 2025 08:56:52 -0500
From: Sasha Levin <sashal@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.17-5.15] ntfs3: pretend $Extend records as
 regular files
Message-ID: <aQoGJP3PsVsq9A4y@laps>
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-125-sashal@kernel.org>
 <cde69513-a413-447e-8cb4-5627da29550e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cde69513-a413-447e-8cb4-5627da29550e@I-love.SAKURA.ne.jp>

On Sun, Oct 26, 2025 at 05:12:23PM +0900, Tetsuo Handa wrote:
>On 2025/10/26 0:55, Sasha Levin wrote:
>> Conclusion: This is a targeted bugfix to comply with VFS invariants and
>> prevent failures when interacting with $Extend records. It’s safe and
>> appropriate to backport to stable kernels that include ntfs3 and the
>> may_open() invariant check.
>
>Please consider waiting for
>https://lkml.kernel.org/r/tencent_F24B651BC22523BA92BB5A337D9E2A1B5F08@qq.com
>to arrive at linux.git before backporting "ntfs3: pretend $Extend records
>as regular files".

Looks like that fix still didn't land, so I'll drop this patch.

-- 
Thanks,
Sasha

