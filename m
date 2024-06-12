Return-Path: <stable+bounces-50226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABBB9051E4
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4F81F28272
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C824416E89A;
	Wed, 12 Jun 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znOG+aYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB016D4F6
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193709; cv=none; b=h/oNvJlgkELRtlzUG5gM537ivEQ2Qeamz83Wv/aKMdfaPImkO4k5tBNDQ1CuNFagvOoOfgHJZz/4Yssn4NIT9gOl2ZjwanSVNNu6QHOUyK7rJL7uc6/qxbd1d4tHuxeQREf9+QrBz2uSgD2kWVzUWaVGeza9XXuJYJG3zBfSCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193709; c=relaxed/simple;
	bh=geL+ZeVfOsx+we5jrwkWNSigH7tWotxjSx/StKIWPkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0sf0jr6E6L4cXPGyS2eciV86AQkPLOApPLO/iggPNT1txdMRwssDFVvotzo8jz+/W2xDWtRQ8IKW6XU5oPonAGHxdif5vxoO/eoLbQI/U8ASe9mIlhaZ28PLqVg1jjnlrE5MajGLR0WF9qiEKLaiRFk15gOs6x5YqzIXUKs3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znOG+aYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932B8C3277B;
	Wed, 12 Jun 2024 12:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718193709;
	bh=geL+ZeVfOsx+we5jrwkWNSigH7tWotxjSx/StKIWPkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=znOG+aYkOqYu/BN2jRztc0udXJVxeTlJcSCWVYsiZuzhCTI9kk8Al1vFqyZg2csQW
	 Bi/sy2WzF+esK22gJz1QHfQry8PqtRQ93m7e9mtWMtTM+QlvyEPxW5vDQkobRLxqJ1
	 cngmz/kB+p6mqIT4zpcpN4B4MMHsMTtezkXC/VjE=
Date: Wed, 12 Jun 2024 14:01:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: stable@vger.kernel.org, decui@microsoft.com
Subject: Re: Request for backporting of two drm patches
Message-ID: <2024061228-cesspool-caress-b13c@gregkh>
References: <20240530055152.GA13146@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240612051629.GA15465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612051629.GA15465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Jun 11, 2024 at 10:16:29PM -0700, Shradha Gupta wrote:
> Gentle reminder of any update on this.

Sorry for the delay, now queued up.

greg k-h

