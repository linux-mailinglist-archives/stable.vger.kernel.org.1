Return-Path: <stable+bounces-181914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1FBA9558
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6941B7AE0B3
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F073074AB;
	Mon, 29 Sep 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UA1vo3/l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BC302CB6
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152505; cv=none; b=CYudANWB6plRPiIh47LgWJOEPDj92nG7GHkkZa0FLZLO0MSoy3J9P5FN2agSDJ9uqbn1ClSYbC683sjAgXdGUctwYMNRgYKVa5Kpfw6AbmwMInrp9vT2UMuGJbUgb+WuqIqawZuFUPxnHikkkaAwuAGm/pmSva0Hdop9ZwAFaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152505; c=relaxed/simple;
	bh=vDBmbgqNXxYNasciikhN72C16V7MXnsoG4bsd+slarQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srOIua8NHgYvUeNB4DByFRCws5B26bqNV+NBv6GHIyhA8du+K1muDVdfeSKLBcGSZ+SI+ff2JTy0ExP2Cv2Bk8/uhwuGkuw0o0uMQgizH58o3lkmsJSCSz2JNxrbCeynWxiGgtSqi3pxvyo+1XpwuRXfqdD+USczaGLhY4w1qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UA1vo3/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F93C4CEF7;
	Mon, 29 Sep 2025 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759152504;
	bh=vDBmbgqNXxYNasciikhN72C16V7MXnsoG4bsd+slarQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UA1vo3/l+dFj6BW2UkRsYWhA1tIIoHLxNAcwvFySk4pGY2WOEDDAMoyKUXFlF2HGn
	 M2oLh1Sxefxf4njUNMkHE6+gXpF7oe5q8BEu3QI2PMbS3PaeJXBE61H0QVpkajAM+O
	 7AKbWWNKEOWdHj02rnfu8DD2Xozmfpol+93FK8cA=
Date: Mon, 29 Sep 2025 15:28:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yangerkun <yangerkun@huawei.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-stable <stable@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [BUG REPORT] Incorrect adaptation of 7e49538288e5 ("loop: Avoid
 updating block size under exclusive owner") for stable 6.6
Message-ID: <2025092911-grappling-tutor-8f40@gregkh>
References: <7f6f5d7d-385d-ea47-43b8-bbd6341e2ec6@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6f5d7d-385d-ea47-43b8-bbd6341e2ec6@huawei.com>

On Wed, Sep 24, 2025 at 10:36:19AM +0800, yangerkun wrote:
> Error path for blk_validate_block_size is wrong, we should goto unlock, or
> lo_mutex won't be release, and bdev will keep claimed.

Can you provide a working patch we can apply?

thanks,

greg k-h

