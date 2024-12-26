Return-Path: <stable+bounces-106170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F69FCE23
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4253A029B
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 21:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BED1A238A;
	Thu, 26 Dec 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXT8jiq/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA619DF98
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249804; cv=none; b=TjAlvjH2ccdvqor5FP9g0NonUFoGYolAVRE+IkTsIOPFmPsfgdhaxpCSUvBiISfeNZ+LSbzJL5Z94DDkVU4lJwZO40YYzv9r9ogphNtkWG7NiuiEntu3vdKIwYMFU9JrRLiWdyqLowYi6cy/D9140tSfZzSpEHe1e0ao6CkK5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249804; c=relaxed/simple;
	bh=sLSjzbl/h6eJToFyWQL9bgsj7zV97ED/IsIkXavg4Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5YMmXDgYAcIJXJmZzlo9r0KdrstIqUOF8AQ3g2JxrPpqUf6xgEkCbhMl+entn6KZBoxg4KxIVoGysyx7VuQ4Pugx6YfIp2dbGv8qfAdLg6Qtdw2e0CymxLwvhVx5EnDWCoZD7Mso4zguPblGw1jhSdFtVT0xt8lAh0JweAaPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXT8jiq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5191C4CED1;
	Thu, 26 Dec 2024 21:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735249803;
	bh=sLSjzbl/h6eJToFyWQL9bgsj7zV97ED/IsIkXavg4Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXT8jiq/QiTqKzoH7ywNBPb7IwFMGyDkVvzZiEUuTWOBcDGC1k+xh5KgRO4XjS0Ao
	 8PQbMweWE3QeYJevDwrZG+keMkDM9lGQU/njtKDRgP5TqKosGfyhvxEqMGQ4qGcd2X
	 ayuROlmVcetictHMKymaZ+nQE4Xf/g6c9shWC5OrjIWYEzUujaNPFU1dkXxpHSaBKe
	 Rrp6oZm/BuH/kp6caxqNThal16yvQiO6oFHQMOh8efuPx8XDTFrJZe8PFrZssQMapG
	 e1+E12C2k8CXZNaYmC8L8mqbZ1j1ZqNxIMMyEIcTIEakLfFm2BkZhxQnTQciPttDB5
	 j7qhcmEn1/LXA==
Date: Thu, 26 Dec 2024 16:50:02 -0500
From: Sasha Levin <sashal@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] vmalloc: fix accounting with i915
Message-ID: <Z23Pijiak5WGnUQd@lappy>
References: <20241223200729.4000320-1-willy@infradead.org>
 <20241225183106-cee20b35fc2f9d72@stable.kernel.org>
 <Z218psbww0eNEkhs@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z218psbww0eNEkhs@casper.infradead.org>

On Thu, Dec 26, 2024 at 03:56:22PM +0000, Matthew Wilcox wrote:
>On Wed, Dec 25, 2024 at 08:21:56PM -0500, Sasha Levin wrote:
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> Found matching upstream commit: a2e740e216f5bf49ccb83b6d490c72a340558a43
>>
>> WARNING: Author mismatch between patch and found commit:
>> Backport author: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Commit author: Matthew Wilcox (Oracle) <willy@infradead.org>
>
>Do I need to adjust my tooling, or do you?

I'll go fix it...

-- 
Thanks,
Sasha

