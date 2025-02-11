Return-Path: <stable+bounces-114844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B6A303C0
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2CD3A544C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B81D79A6;
	Tue, 11 Feb 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rJ6CjxRG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88E26BD90
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256146; cv=none; b=blA0TLBwpbKcsgOyWpfX6NGefHK5t9HjCKCgbhIezYJWoU24tuYwb83M4RMWga64kNs7forfUtxH/BbPp3vn5MDLFyvMAlUjYxpk7bzdD4xaz7OO7/+MUzh55nOvtgOOoYFVDo/9YPgxfq9jUoyzuHJQEJKna/3DuAX7BM1pptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256146; c=relaxed/simple;
	bh=nS7a5bQMrwyNzrvCnSN54zBA9/5zdMEbd5szRhrjprw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5YbUh12rHTdkUJAoJXZw+oMaNZAkD54a0T5LWSEoXOIDLEOq5lxlPdwIf7qmJItVlSOJ4KBGbFIL9gRPmkXls5hVa5xMTm/epRWd1AIfTZ5ci5KtsXtyWIQtnFICepNmiz6HoaLbVD+ohHhi5ShZ/PbTzymWUoZLTW/FdWBEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rJ6CjxRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A3C4CEDD;
	Tue, 11 Feb 2025 06:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739256146;
	bh=nS7a5bQMrwyNzrvCnSN54zBA9/5zdMEbd5szRhrjprw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJ6CjxRGajliBbQCIDJ6xJk/Qdm47OwjbGqq0YrfkZ5Ot15yRsBCGplWkdY/R5MU5
	 TXRfX3ziwgD1l7xp5Ot5dKFIPNG2lQmn0A6W/todBZV1OiS7p08KHQ9/bMkP2loLpD
	 r9Z7fnLVy/QSFIxdwSDvY0iYmgx3MZ527CGYrLl4=
Date: Tue, 11 Feb 2025 07:41:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: andrii@kernel.org, ast@kernel.org, bruno.vernay@se.com,
	stable@vger.kernel.org, xukuohai@huawei.com
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <2025021135-silent-saggy-5d03@gregkh>
References: <2025021027-repaying-purveyor-9744@gregkh>
 <20250210163233.6445-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210163233.6445-1-hsimeliere.opensource@witekio.com>

On Mon, Feb 10, 2025 at 05:32:33PM +0100, hsimeliere.opensource@witekio.com wrote:
> On Mon, Feb 10, 2025 at 10:55:07AM +0100, gregkh@linuxfoundation.org wrote:
> 
> > Never link to nvd, their "enhancements" are provably wrong and hurtful
> > to the kernel ecosystem.  Always just refer to cve.org records or better
> > yet, our own announcements.
> 
> Thank you for this information, I will take note of it for our next contribution.
> So the CVE must be under a CNA or CISA score for the patch to be required by the kernel?  

The kernel CNA provides NO "score" as that obviously is impossible to do
given that we do NOT know your use case.

What exactly are you trying to do here?  Backport random changes to
older kernels for what reason?  We are glad to take backports for fixes
that did not apply to older kernels, but you have to test them and
provide a reason for why they should be included.  To not have that on
your side already feels very odd.

> Where can I find your own announcements? 

You have read the in-kernel documentation about how we handle CVEs,
right?  It's listed there :)

thanks,

greg k-h

