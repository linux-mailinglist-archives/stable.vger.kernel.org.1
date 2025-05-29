Return-Path: <stable+bounces-148089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B57AC7D4A
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 13:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4605A417F5
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE728E60E;
	Thu, 29 May 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VtiueGA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF52749F3;
	Thu, 29 May 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518827; cv=none; b=PTe8LP+hlUuFMz61HDotYgstKETR4w0BR7JNeZLCGr2LAQfrtKUY0nSL7myWigb4fz2wUclB4eXdHW9q+yWiOqd5ValMEf3Ty9AAEWnFEaXeS/UcVkP1D2ThuvStUJOzSCt0E29iMtSlwlUdEO7mBFVthxpAGrkox/gqmNJVi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518827; c=relaxed/simple;
	bh=y0MRYtwXJkJII3kLYNc7oLmACdvAsnvHCj+o5xBkdwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di6rRmFn/7X9yQ6fllGKFCt8JYkEo1SFEAFUzmzeV69PR+iv4dR1KraxcFh4BYci5mbRIz2qETg2zXyrpc/a1rdA2g7L9UrVOQNeWC8FSnBWcZNjJHopXtIxPELLtx2kG1/Wm4lt9CkwLAVWaHWg+YZLeo6Q5YoZYrfpr8UyT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VtiueGA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC5EC4CEE7;
	Thu, 29 May 2025 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748518827;
	bh=y0MRYtwXJkJII3kLYNc7oLmACdvAsnvHCj+o5xBkdwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtiueGA7mP+sOzE63uSX6FYWPieAKtj7Bbs4kBDtAplgThKjUPXoIgyLdkpX8TiFe
	 G29wQ7UYsYwyBYZKjY8Qn6yvHGDEclX1C7QFHMauTXOZ6B1imHSFs4Nog7AOgZ5hu6
	 Yj4bqlqafS5cejQUmM0pkrFgJ6okhY7TA+lJNIkI=
Date: Thu, 29 May 2025 13:40:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: Re: Backports of 2e43ae7dd71cd9bb0d1bce1d3306bf77523feb81 for 5.15
 and older
Message-ID: <2025052916-diploma-patient-cf7c@gregkh>
References: <20250527235023.GA2613123@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527235023.GA2613123@ax162>

On Tue, May 27, 2025 at 04:50:23PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please find attached backports of commit 2e43ae7dd71c ("drm/i915/gvt:
> fix unterminated-string-initialization warning") to address an instance
> of -Wunterminated-string-initialization that appears in the i915 driver
> with GCC 15 and Clang 21 due to its use of -Wextra. Please let me know
> if there are any issues.

Now queued up, thanks.

greg k-h

