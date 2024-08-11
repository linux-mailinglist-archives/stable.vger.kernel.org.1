Return-Path: <stable+bounces-66347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045AA94E0B7
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 11:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967D21F215FB
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED638F9C;
	Sun, 11 Aug 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLYrGmxA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80467F6
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723369567; cv=none; b=rc8pLPEPTxalLUSCgbOg5q/n79Zsr/hQVYrIrxjghRh4LW70eJwU1gEJzkJbqe8qY9+kMQLOLeQcojNU9EKnAx/E1sCzmvlPg90j98mZZF1l80afgSMMggTl2xZXbc4hOJdiif6T4R5s1kqnhTZVvRe0T4Ps3IL5xxE0IAziQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723369567; c=relaxed/simple;
	bh=zwUxA61WKaRiOGHLt2zSl/s/NyK2YjHFJ5r+Iv5wD7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evyKeGiFU33dIgNVwWlG3jTROM9G4dKvUQKHlsptERlQ/OWXx3bSgnDBImyinXuSXmNNBVtQE9Ai2mObX6rhhvQc+DhKLnmhthX0M4x+fwtA+IAlDoZ4bhIHOwC52dyTKUZWlMw9t5KXdZF6eQyuBIk9txl/vK9E3WdUbB1Np9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLYrGmxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8050C32786;
	Sun, 11 Aug 2024 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723369567;
	bh=zwUxA61WKaRiOGHLt2zSl/s/NyK2YjHFJ5r+Iv5wD7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLYrGmxAu3miSHRZFQAuv9oeVQ52DLgn7NColb4qxrhlTDorX+3VJl5h26YwwG/SC
	 uJZR66JR2JxGVuNBsm1CbzkjJk4No+3Lc4QInZNeaW0v5mW6SsMWY7zLK/PaZL6O5C
	 ZHGt9L4hJwiL9rLPeVKG8pZd3J0wgy6IqdRkpZeQ=
Date: Sun, 11 Aug 2024 11:46:04 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/amdgpu: fix locking scope when
 flushing tlb" failed to apply to 6.10-stable tree
Message-ID: <2024081132-sterling-serving-8b4f@gregkh>
References: <2024080738-tarmac-unproven-1f45@gregkh>
 <SA1PR12MB85999CF5386E2AADEA301076EDBA2@SA1PR12MB8599.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB85999CF5386E2AADEA301076EDBA2@SA1PR12MB8599.namprd12.prod.outlook.com>

On Fri, Aug 09, 2024 at 01:37:50PM +0000, Li, Yunxiang (Teddy) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Greg,
> 
> I believe this commit has already been picked onto 6.10-y as commit 84801d4f1e4fbd2c44dddecaec9099bdff100a42

Then why is it showing up here again?  What broke in your workflow to
cause this?  Please fix that as there are loads of these "double"
commits with no ability for me at all to detect them being a double
commit.

If this continues, I'll just end up dropping all AMD stable-marked
patches as it's too much of a hasle to deal with, and expect you all to
send me either git ids, or patch series, to apply.  No other subsystem
has this issue.

greg k-h

