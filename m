Return-Path: <stable+bounces-28104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787087B455
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 23:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391801C213FE
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5275A0ED;
	Wed, 13 Mar 2024 22:27:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7F5A0E7
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368856; cv=none; b=CvmjJbHyAV7M4GuHjPkY+vqtW8ZRIqk/ysxn6bXm0aK7AbhN1ZXw78hRx9HnlpivJ2UbaLhXsynQXATIuVmfVWqBTKxCjqkDIC14/PepwtOzENk7IXCA4QZDfomH5zl31T5L5LgIWDW/OoXr6hUqjDdQbpL9DXBUuP0Ja7DYeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368856; c=relaxed/simple;
	bh=xuUS+Oww9w1u2cMRpGW5x7+mLKY8ro2ndYZAk8ijRtg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R2OZTeZ4Y6Nq8heomZzFQTKj/Rn3vGHzdyUBbjPLrd9LERJWNHyFBzB5gBWRtzcCE6LeMUf1qkcOJIHAjJAQpBjV1Z02A80s7w4lfLBRVZaD7+hEBImZZfNPEAm/s1HupvdYo34Ob2K4suEUJ57XTewvFOKp/ICig3Ch7+r+DCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 126bd006;
	Wed, 13 Mar 2024 15:27:33 -0700 (PDT)
Date: Wed, 13 Mar 2024 15:27:33 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Sasha Levin <sashal@kernel.org>
cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
In-Reply-To: <ZfIKCLek_q-Wzn0D@sashalap>
Message-ID: <762cfca9-45b8-752b-3fe8-f59bca716578@aaazen.com>
References: <7f21928-bc75-adac-7260-d2b0cc8dd3fe@aaazen.com> <ZfIKCLek_q-Wzn0D@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Mar 2024, Sasha Levin wrote:

> For some reason the v5.15.151 release tag wasn't pushed.
>
> I've pushed it now, so the link above should start working whenever the
> git.kernel.org caches expire. I'll check back in an hour.

Thanks Sasha,

   This new kernel 5.15.152-rc1 compiles and runs fine on my x86_64
AMD zen 3 system.

Richard Narron

