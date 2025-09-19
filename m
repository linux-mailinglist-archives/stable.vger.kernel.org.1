Return-Path: <stable+bounces-180659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF0B89BE1
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D61A624FFE
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33730EF67;
	Fri, 19 Sep 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ww6JVWaz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A741212549
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290180; cv=none; b=Wz5hHUNAcAvcZIB2mjteZ3J7rxlnR8t8RaK3qikg/5OKkmyIumrIorShscTF8whb4lB/tryRqQrzsckguWHTnZFSt3594wJYvxonj+O/+h06ktX3BM96XUaI9FLOz3LLE7IGCaW8gNfCoBNuz5YryZoO38PgC/xNe2c3V7i72U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290180; c=relaxed/simple;
	bh=kjuVWPnxBM8yxYcCh+eGZzYMxYFQrpfUGOcnpxtq6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtTqhzzmk0hqQtOjXWh581Cmasl1rzmXs1qEXd7eIobFx0aQoZ/KtR2ham/IxNHJOVsUiN3gt9z3LMqjlCFjfIARw3LjCq6HuBdH4Wp1O3ihq5lY/bd6D31rI8JcP0ZLPnE38xvBfCCSpR1q1CRIxqdyQ9i57+htZhAtrUYM97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ww6JVWaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C47C4CEF0;
	Fri, 19 Sep 2025 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758290179;
	bh=kjuVWPnxBM8yxYcCh+eGZzYMxYFQrpfUGOcnpxtq6VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ww6JVWazBQQM8Gk9RZAihpXgXldR999Yrq6Bpm/agDNmXcLoK6aM53bhkvGZsfvg8
	 jC3rTxXU/cLZI88lfLPaLa0j6tQclRlnDoAxbLFbISpyOF6glT9ysqP7J+AP97zLTX
	 FMbthteac6K9QjYRLDozM/uHQFfZGvc4/kBCh+7I=
Date: Fri, 19 Sep 2025 15:56:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Angel Adetula <angeladetula@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 0/1] perf/x86/intel: Fix crash in
 icl_update_topdown_event()
Message-ID: <2025091939-oat-haste-6ef1@gregkh>
References: <20250918215208.1108713-1-angeladetula@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918215208.1108713-1-angeladetula@google.com>

On Thu, Sep 18, 2025 at 09:52:07PM +0000, Angel Adetula wrote:
> This patch fixes a crash in icl_update_topdown_event().

What is "this patch"?  I do not see a 1/1 email here, nor on
lore.kernel.org, did it get lost somewhere?

> This fix has already been applied to the 'linux-6.1.y', 'linux-6.6.y', and
> 'linux-6.15.y' stable trees. This submission is to request application to the
> 'linux-6.12.y' stable tree, as it appears to be still missing there.
> This should also fix kernel bug CVE-2025-38322.

Please submit a working backport and we will be glad to queue it up.

thanks,

greg k-h

