Return-Path: <stable+bounces-192290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F94C2E942
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 01:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24A554F64D9
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 00:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9615530C;
	Tue,  4 Nov 2025 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs0d4vQd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089B35898;
	Tue,  4 Nov 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215737; cv=none; b=SovtMsDEcvAPW0cil+q0TLIK2r+PjWSvqOgiI8nnWgBrMqOTuoGDO4F1GSZbhDK2qV0Z6T47LkQMcejQVGgW8L2bkLXY1Vz/7sPX8xHS/23X4FAFrg9OdSOQyI+H8O9A2U6tSNcABn0cBn7oyl3ZFfGRCjfED9c4dCch11jKw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215737; c=relaxed/simple;
	bh=umMkQ/I1GqBqTCSFshRO2Q3ySgL6SDeXavuMjayIeOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntIQQY0fGrSg+7ObxnHUmkb9rTC4+G03MUktuuyzGB852Pe9oU3p1nj5lSA7cGTmRRpDqVbJqrn2hCpyGCPYq6dGNvbYQGrPGWiPAlf/mvKtkFmXyUMfuaAzOK0D9wqnX5aMekpwc/M5cHoyubyofmwiG7svRak17GzkX3/gZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs0d4vQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BBFC113D0;
	Tue,  4 Nov 2025 00:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215736;
	bh=umMkQ/I1GqBqTCSFshRO2Q3ySgL6SDeXavuMjayIeOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs0d4vQdyC9kPDBtTXowXOfaJUt6XgcIM1HB1t1GAQ48bwekhthaz0mOB9jATQP0+
	 7XvXMQKGAnc4NgF1K3meZdHZEBWWFTQZ6c+ZFqVvSxZqIkgy1JyMJtivkN2wdAJgnu
	 e6MPj8lXU31D7NsVj7N6fOnyo1Ynp+xbD2HBQSRRB4bZF1+dVwGFaHmPGPtLRZWibw
	 //NfMdjvfctJQKSWJlLWndI81dFWqmCt+XmNQSoaETZ8xHBrmjOdUHM9U1GuQYHVuc
	 WRjbw7TDtOXwgzUXoY8ZVuENWd/EpuePKo3OJcqNswzLz733CpRC9IzmGLM1k9N2ei
	 AutSUuxE0WT5g==
Date: Mon, 3 Nov 2025 19:22:15 -0500
From: Sasha Levin <sashal@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Sven Peter <sven@kernel.org>, j@jannau.net, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] soc: apple: mailbox: Add Apple A11 and
 T2 mailbox support
Message-ID: <aQlHN7Nu-1aAyrXp@laps>
References: <20251009155752.773732-1-sashal@kernel.org>
 <20251009155752.773732-9-sashal@kernel.org>
 <28f4950a-e3eb-4a54-b867-67bd269b8407@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28f4950a-e3eb-4a54-b867-67bd269b8407@gmail.com>

On Fri, Oct 10, 2025 at 10:22:18AM +0800, Nick Chan wrote:
>
>Sasha Levin 於 2025/10/9 晚上11:54 寫道:
>> From: Nick Chan <towinchenmi@gmail.com>
>>
>> [ Upstream commit fee2e558b4884df08fad8dd0e5e12466dce89996 ]
>>
>> Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
>> coprocessors in the system.
>>
>> Reviewed-by: Sven Peter <sven@kernel.org>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> Link: https://lore.kernel.org/r/20250821-t8015-nvme-v3-2-14a4178adf68@gmail.com
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>
>> LLM Generated explanations, may be completely bogus:
>>
>> ## Backport Analysis: Apple A11 and T2 Mailbox Support
>>
>> **ANSWER: YES**
>>
>> This commit should be backported to stable kernel trees (and has already
>> been backported as commit 37b630a26d235).
>>
>> ---
>This patch adds support for new hardware which is not just a device ID
>addition. None of the hardware that depends on this mailbox is supported
>in stable either. Please drop.

Dropped, thanks!

-- 
Thanks,
Sasha

