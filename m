Return-Path: <stable+bounces-94111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0F99D3A5E
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1469C2815ED
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9766A1A4F0C;
	Wed, 20 Nov 2024 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fp2MJm8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF61A3BC3;
	Wed, 20 Nov 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104739; cv=none; b=VSR1z1/0WLR0O4saau1SlVYMWGfmP/i8e6W2kUvBA8I6fxX6gtFH/o0klv+86J6DN+5w5IztKDdxZpr44SHE974naq2DgKtK2OqJtPnuZ/dlI3uUavc89/YIFkJ+pZLb1XnofFeAXrnT0K9BIdWbXiPuSqYC4chVVp3pcyKleOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104739; c=relaxed/simple;
	bh=oiygYG/wtmXUyo5fgLc1zqYnwiDE8n9y4M8Jz5PcRTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK2GcFAZtCTjShhxomircRmoXk1np0Blp51re6UCMGvymwaq60/HqjeEvs+IFeAWZ7VuW+FdJ56zl9KTUX9fvY2EZWL453LCTIWKWaLE/oaYYdliCH1aL4X9vzuP07i7GU0yVzY/CMGZUua2E5J+wL64EPMY7dEs306xnQC7WCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fp2MJm8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DBDC4CECD;
	Wed, 20 Nov 2024 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732104738;
	bh=oiygYG/wtmXUyo5fgLc1zqYnwiDE8n9y4M8Jz5PcRTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fp2MJm8rCHcrdq7Pke4dtqv+AZDnimj1uAANvxD1EaAsNC/dWq3cfawo6IH8PlN9B
	 kJbuLJfVktb20tmV8ixZy2LAEJalJ8mYsPacYmvavJC8IuzU2oArQxLbOusEDe4r42
	 sFz3AdpevK8Hiaus9gOuaohvRQnGiIBeAdzzKvy4=
Date: Wed, 20 Nov 2024 13:11:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chenbo Lu <chenbo.lu@jobyaviation.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: Performance Degradation After Upgrading to Kernel 6.8
Message-ID: <2024112025-dynasty-shabby-c141@gregkh>
References: <CACodVevaOp4f=Gg467_m-FAdQFceGQYr7_Ahtt6CfpDVQhAsjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACodVevaOp4f=Gg467_m-FAdQFceGQYr7_Ahtt6CfpDVQhAsjA@mail.gmail.com>

On Tue, Nov 19, 2024 at 04:30:02PM -0800, Chenbo Lu wrote:
> -- 
> This email and any relevant attachments may include confidential and/or 
> proprietary information.  Any distribution or use by anyone other than the 
> intended recipient(s) or other than for the intended purpose(s) is 
> prohibited and may be unlawful.  If you are not the intended recipient of 
> this message, please notify the sender by replying to this message and then 
> delete it from your system.
> 

Now deleted.

