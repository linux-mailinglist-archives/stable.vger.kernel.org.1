Return-Path: <stable+bounces-43563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B58C31A1
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949121C20B65
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507D51C3B;
	Sat, 11 May 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOzgf3MG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7950A68
	for <stable@vger.kernel.org>; Sat, 11 May 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433925; cv=none; b=ZObOzHxqL0B3W7ppkVmLwStQjfR4t1pAMTz9Qp6HnFGkEm3MQ6WC8JZWlRh4kRpse9l84z0n+xk34kggt86cqy0UeFLqweDz7jJ6okFTq297Qlt3PsA0jtM6RCM+s3yJi/Wz/U79LtWxmtT0K/0wAvCBUdFS7UwDc0KNapL+KWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433925; c=relaxed/simple;
	bh=vaq1p059PGbVLLuad93zbPchC5XA9+zkiLd+ibEt/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNVfQzts9bLwsDmBQcDsYMz/yUH4HNjVZWOOc6m1JE4f4uqxZgDlwFN6VDovLjrEIcupJHFcKrLFaPW3RUcihcvENVccwU7IZX3QxYC3XD/KF2HnrLmQTYhvXwu5NCUrS3nCm10sOQWyuNm1gvrEoXcJsxML4vH6FTzCKqYbVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOzgf3MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC20C2BBFC;
	Sat, 11 May 2024 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715433925;
	bh=vaq1p059PGbVLLuad93zbPchC5XA9+zkiLd+ibEt/AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOzgf3MGg748k4A6IMsvJuW7zJZgTax7kOpbgJNsRpiWJPbF+cbxWGjcFmcEu910W
	 Q8faikyLVlpQWeBose6Oj9TCEnsvWOFaES5c0ekemoXG/dFJzy1W3+OteW3gmDflJL
	 dgAyQK9o7IMAppdSkNHgH3xLGZQBWVTAno35V1+qblIAAUvDarGWloKIuVHDPmzAf3
	 kqjwrCc0VvSt0mpqZgMLEBSA4QMMvNeJxAYoTAI/Ol1GnUcFnvK9N3x9wgfZvkhatG
	 JbDr5TDRcUpjif/Jz7kuBBNaNH5gXOpevIIPEwTb/G5ap9ffl3sMzgKw8bYJcR0iRC
	 CXaIg20sXk03w==
Date: Sat, 11 May 2024 09:25:22 -0400
From: Sasha Levin <sashal@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH RESEND 5.15.y 0/3] Use access_width for _CPC package when
 provided by the platform firmware
Message-ID: <Zj9xwkZmWT7SC5cv@sashalap>
References: <20240509194126.3020424-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240509194126.3020424-1-eahariha@linux.microsoft.com>

On Thu, May 09, 2024 at 07:41:23PM +0000, Easwar Hariharan wrote:
>This series backports the original patch[1] and fixes to it[2][3], all marked for
>stable, that fix a kernel panic when using the wrong access size when
>platform firmware provides the access size to use for the _CPC ACPI
>package.
>
>This series was originally sent in response to an automated email
>notifying authors, reviewers, and maintainer of a failure to apply patch
>[3] to linux-5.15.y at [4].

Queued up, thanks!

-- 
Thanks,
Sasha

