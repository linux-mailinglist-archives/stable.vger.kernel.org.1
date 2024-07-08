Return-Path: <stable+bounces-58211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C708C92A1B4
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0432F1C21009
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7080024;
	Mon,  8 Jul 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuSDhghI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD37FBDA
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439748; cv=none; b=DmM7mY+KEZc2qHakhQoNYuztxeX6v0GQ2Hj3oG23eAOyBnsio/N3wYl2/PR6Hfn7YNv51EUtTolEVX7I9Ps6CcH0VoqiM8OpQHfGvGwEiRPtH9kvWycE5lmlMcWjAC8XCJWXmHMLjrEROikOnaqHfd6Iakaec111SGZTOZM+WYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439748; c=relaxed/simple;
	bh=zRyQlimr+9aMoGmjCRWbzlO/wRqMO3DLfUzOzx5X2Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InIsOKTv3pp9URSxVAJ73Tex0rBcuHH49xz/oY23wj+x+vAC0WKjKyhKT26jM5FrGhNI+54zrpJAagVA5pC93k4MdiDTzWh7DYDqxDNptrY7uBY07W2zuR4Z8/ysG/1rfEFMoOza2qAC+PZPjzXVVLMnRYJ7aaz8Rdu3ChjZ4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuSDhghI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BFFC116B1;
	Mon,  8 Jul 2024 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720439747;
	bh=zRyQlimr+9aMoGmjCRWbzlO/wRqMO3DLfUzOzx5X2Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuSDhghIibaLSdgTPjd+GQIeCTkTdZIMz22w1LZfP7T8RrbFSk5WVSVIIyFW6n5r8
	 K6fM4eDBIH+nVu5q9e3v0T/yH9kNgDyfETJEFsdxELLxih+BCEQpigwgF1g3azTgja
	 VsytiOk+kOfIyZ/YSGr0ORVaH3KHNb9GOFmyZzKC2/7UKKV1Qr9QbuTuwBJmJdZmOs
	 P+2utGPwjujt4uS2VZnM/S/HJ3o5fhK27HleH2w+LqscmgV5DQdRIsK/TZNRiogl1m
	 8g9F04/kZJe0QNdV4bZf0bKLzvhur/BVWUw3NOIWTOlOrxwfgkjFEhqS0hpgyrI4Lq
	 ufv3wtbX9CO6w==
Date: Mon, 8 Jul 2024 07:55:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 18/18] null_blk: Do not allow runt zone with
 zone capacity smaller then zone size
Message-ID: <ZovTwvP1XFbjv70W@sashalap>
References: <20240605120409.2967044-1-sashal@kernel.org>
 <20240605120409.2967044-18-sashal@kernel.org>
 <aef09490-f8bd-46e9-abbf-a4cc9acc49aa@gmail.com>
 <7fcbb3c6-ae1a-460d-be2b-e2eca88151c9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fcbb3c6-ae1a-460d-be2b-e2eca88151c9@gmail.com>

On Wed, Jun 05, 2024 at 05:04:25PM +0200, François Valenduc wrote:
>>
>>Is not 6.8 supposed to be end-of-life ?
>>
>>François Valenduc
>Sorry, I replied to the wrong message. But there is also an autosel 
>series for 6.8 posted today. So is 6.8 really end-of-life ?

Yup, it is!

-- 
Thanks,
Sasha

