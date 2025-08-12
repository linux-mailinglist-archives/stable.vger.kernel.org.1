Return-Path: <stable+bounces-169292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13A8B23A84
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D897C170E0B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42B1F4CA0;
	Tue, 12 Aug 2025 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERqyQvrV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAA2F068B
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033539; cv=none; b=o76iz2Ji0coPG5RmGmQtF8Dc8ucDluMJuNARoYE92I4dPsHA/hsElNoeFGYBtLxCa2xR7XRV2ujr4YMOQlx4cY4N6jC6XH+mdEKmlGYLQFVqUPkmo/hgJlXlrVMbjGJQ3L/1WF+AmaIpFccvbebPve69jwVtBV5X4vLWIvlIASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033539; c=relaxed/simple;
	bh=5kzI1oDyVzFVSIU3I4B+w+YqJhhjxx+I1pSuXgGA0s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyX9Pvu8Krwxd7Og9ArQ+Q229gVRYe1gUJjTQoETqI1uX+PTvgKIjVP1zOqROz/YCl3J9AMcZq983LxTwxCtfG3qolmlm/uIwSK5mbWZA+dV+nHLvTgGecM7D3kszDwRFdYzZEAtzsCUP5RHXT+NsfWpxmvsEcGvzJNv/j7T80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERqyQvrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F20C4CEF0;
	Tue, 12 Aug 2025 21:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755033538;
	bh=5kzI1oDyVzFVSIU3I4B+w+YqJhhjxx+I1pSuXgGA0s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERqyQvrVP0zGAikqRBs9203b1khwsn5gDISL3tGOXUCQ9P9JggqLOpyEdeuOFlfbr
	 F8uW376ba5GetqDfcpiGFU378Vf8ZuwJExv+4GqBlBW8/GpxwBxXKy85vXF2goLvJG
	 R+FjaryP0ubi2mNEL9bCP7zkyNzPDPlBu80IRckochNi15TqyWj/LpKZn0lu7LdV5v
	 bs/BS+c0rFz6unVLw3TZ+oTJL8qfUmUVDXZSH0Rdk44FW1UUtzYdvvOI76uY5InhwB
	 lhvaJO1awEWTMZOgOUS6NhmMfNaZdLJY6uOsdehHiBm8et2f9cNTY1B+Y7oluE1kmF
	 Yaw1qAPOgLvHQ==
Date: Tue, 12 Aug 2025 14:18:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4 2/6] kbuild: Update assembler calls to use proper
 flags and language target
Message-ID: <20250812211855.GC532342@ax162>
References: <20250811235151.1108688-3-nathan@kernel.org>
 <1754967336-37137ffc@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1754967336-37137ffc@stable.kernel.org>

On Tue, Aug 12, 2025 at 12:12:27AM -0400, Sasha Levin wrote:
> The upstream commit SHA1 provided is correct: d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0
> 
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Nathan Chancellor <nathan@kernel.org>
> Commit author: Nick Desaulniers <ndesaulniers@google.com>

Same comment as the other change, there is a From: line in the patch, so
shouldn't Nick still have authorship of the backport?

> Found fixes commits:
> 87c4e1459e80 ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS

Present as the first change of the series.

Cheers,
Nathan

