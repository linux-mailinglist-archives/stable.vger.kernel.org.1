Return-Path: <stable+bounces-45461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874718CA1EB
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 20:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D1E282A2F
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77653E13;
	Mon, 20 May 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJpXADkp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C211184
	for <stable@vger.kernel.org>; Mon, 20 May 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229184; cv=none; b=OFEHssWmNlCkYN8TKo3eUhbFTuJ5TKKI+6Xp+7tc+PUF/xUVVklEm6ffgt5pd8dTHB8avlKdBzSSdH8ZfMuVUDaGKpjb/k2k0tHZSOcszCBuvI2ZCR9GPD02AjsvJaIx8A5Yh/c08GI5AxDw1E/bJlO4nKXjbLseWUNfMJ5DBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229184; c=relaxed/simple;
	bh=xQJFulkVrnnn3woxhca4HK9mp0Pp2QS3h+r5fGcwg9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSSRQknz/+yQQjxGbUw2YpiLSt4qLjCKNof0QqabnAOGqQZlDMauPMQTp8rCLOpwRmi9OKOo7StdnpWK0MOQjuGl9ujJRP1f+LMt6SQOoICYb78tw79a2BGI/SvX+rxajEvGhLP//StWYeR8PKgnhMiE2H8+h8u+nORrZvDt4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yJpXADkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73182C2BD10;
	Mon, 20 May 2024 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716229183;
	bh=xQJFulkVrnnn3woxhca4HK9mp0Pp2QS3h+r5fGcwg9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yJpXADkpq9LVX3pXUHTb1Rpa3oZmkLif5oL5RpFoiwvpDtiG9IUg5/ZDGTc+XX9jq
	 Kp+Sxu/Ko3fvfttMz4iCFMl1fTf9VxVpAvKpJW9cHtgZm/ArqB+dsNRk8JT2Er7eId
	 1QnYqSq2bWMqRR4gzfNeRU36kMHffFO0sUCMLAQM=
Date: Mon, 20 May 2024 20:19:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vidya Srinivas <vidya.srinivas@intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Message-ID: <2024052054-zebra-throat-0da6@gregkh>
References: <20240520165005.1162448-1-vidya.srinivas@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520165005.1162448-1-vidya.srinivas@intel.com>

On Mon, May 20, 2024 at 10:20:05PM +0530, Vidya Srinivas wrote:
> In some scenarios, the DPT object gets shrunk but
> the actual framebuffer did not and thus its still
> there on the DPT's vm->bound_list. Then it tries to
> rewrite the PTEs via a stale CPU mapping. This causes panic.
> 
> Credits-to: Ville Syrjala <ville.syrjala@linux.intel.com>
> 	    Shawn Lee <shawn.c.lee@intel.com>

Isn't that what "Co-developed-by:" is for, or "Suggested-by:"?

I haven't seen "Credits-to:" before, where is that documented?

thanks,

greg k-h

