Return-Path: <stable+bounces-67690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF13952175
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CCE1F2219A
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D61566A;
	Wed, 14 Aug 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2fpIusVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74961B86D5;
	Wed, 14 Aug 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657515; cv=none; b=UDCgZnPocsYJKzY3x6vkjPbenf1qHlULoxDeBd9QlMHe9PRsoVaC9hKSjG6pr78kXDQN8SYi9LksDUN5qz++oT09rnXoi3vTLKtnhYNt4CnRxE5iFjMny0iiJoN0bPVbf4fXHkIuSfdO+fGsJ1C4nqAqTejDFhW2FzhVy6uopI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657515; c=relaxed/simple;
	bh=/8Ew+4ZOFRmrKzDgN2oqtTSflHfwUkFCv/OKvSUOrjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hILArNW/3g9Rsb+Eo3i5Fphyk5FCbBLpkIA/cp7Da8UoNXC4GY4LHP2jDzC/oJcq1auMZHgrlvIbPSHHAW8UteNzc+ANWWGxnB2j2TQFi7hwq/Y05C+BcVbPAPXhwk7jPyYeeWGVipFFZcoE+o9fCPCjh6fSoryaihSt1wksjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2fpIusVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFBEC116B1;
	Wed, 14 Aug 2024 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723657515;
	bh=/8Ew+4ZOFRmrKzDgN2oqtTSflHfwUkFCv/OKvSUOrjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2fpIusVbvQQR4KfsGEo+UQmk83OXoOlC60ObLjwEIdmRCGzcw30SaRJaFDvV7oIta
	 vdRgEKvoL3S8TXNn8X+gbGSWJ2qsCzOXAueMmYH/yOZd8O1yPyGSj7PsrfB/a02lRm
	 7oebJCK5RpyIhr+GFxWmBlmvZ5tY9ZsJjXp19Fjg=
Date: Wed, 14 Aug 2024 19:45:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/5] Backport of "mptcp: pm: don't try to create sf
 if alloc failed" and more
Message-ID: <2024081404-tissue-manor-5166@gregkh>
References: <2024081245-deem-refinance-8605@gregkh>
 <20240813092815.966749-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813092815.966749-7-matttbe@kernel.org>

On Tue, Aug 13, 2024 at 11:28:16AM +0200, Matthieu Baerts (NGI0) wrote:
> Patches "mptcp: pm: don't try to create sf if alloc failed" and "mptcp:
> pm: do not ignore 'subflow' if 'signal' flag is also set" depend on
> "mptcp: pm: reduce indentation blocks" which depends on "mptcp: pass
> addr to mptcp_pm_alloc_anno_list". These two patches are simple ones,
> doing some refactoring that can be picked to ease the backports.
> 
> Including these patches avoids conflicts with the two other patches.
> 
> While at it, also picked the modifications of the selftests to validate
> the other modifications. Note that this last patch has been modified to
> work on v6.1.
> 
> If you prefer, feel free to backport these 5 commits to v6.1:
> 
>   528cb5f2a1e8 c95eb32ced82 cd7c957f936f 85df533a787b 4d2868b5d191
> 
> In this order, and thanks to 528cb5f2a1e8 and c95eb32ced82, there are no
> conflicts.

All queued up, thanks.

greg k-h

