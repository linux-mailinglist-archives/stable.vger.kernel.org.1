Return-Path: <stable+bounces-135045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53987A95F3C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC353B78F1
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AB238C31;
	Tue, 22 Apr 2025 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfy0XOA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65472367B7;
	Tue, 22 Apr 2025 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306650; cv=none; b=mthifLzgL79ijZoZDJ+X5zWKtxpHl20vHvWwIIggSLnrrWt7506BRue5CWaMnVfU+Fx0Cq+fFCM4WIeEyJfqyceNlbKazH3L73FT3Sg8pwpA99U5iusxzg0QmQYsvjeDLjx7XiON+5OEVFzLSaDnHKPqzcE8lQjknRABuNgEtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306650; c=relaxed/simple;
	bh=8DTcTxbdVgCbu+VQ+vw2b7TEstY2Tmu60WHjO6bAJEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pikALF7VIV6PEdFI25lKaJwnSl07d7U4rMPyWuAjKTiih0dVAHe9Bywn5FjqMtAYYO4uTmnr0CMNn6o7DC/TzWLs+gN/1jOoGanAiOx9asegEKcXrr3b7maXCJ9D/oL/HSjakGxNSnDoRqit3/zh77Ga4rEue52y2Sbh5J01kZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfy0XOA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF57C4CEE9;
	Tue, 22 Apr 2025 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745306650;
	bh=8DTcTxbdVgCbu+VQ+vw2b7TEstY2Tmu60WHjO6bAJEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfy0XOA0Nf7+RIOYBmgAp2XgFWtskrTdXkiJFA2aHo36G0/wGq/R+5JKfFHEU6xCK
	 gheANCatJYPW/NZqBJ+JBlgPjDkLeXh0B0AwDuDwhKy6gIXNrqvAMwtmpswuF3UAbp
	 isSRZ+7SclZwo5bLkk8GTlnXSNeC7KjF3Af3v9uA=
Date: Tue, 22 Apr 2025 09:23:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Backports of 84ffc79bfbf7 for 6.12 and earlier
Message-ID: <2025042248-culinary-unnamable-89e4@gregkh>
References: <20250417171024.GA171175@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417171024.GA171175@ax162>

On Thu, Apr 17, 2025 at 10:10:24AM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please find attached backports for commit 84ffc79bfbf7 ("kbuild: Add
> '-fno-builtin-wcslen'") to 6.12 and earlier. It has already been queued
> for 6.13 and 6.14 since it applied cleanly. If there are any issues,
> please let me know.

Now applied, thanks.

greg k-h

