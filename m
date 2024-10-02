Return-Path: <stable+bounces-78657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00498D3C5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EF428251C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1D1D0156;
	Wed,  2 Oct 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KS8snWKQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230541D0141
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873739; cv=none; b=YrVdiY1me5WTlIeJISRhpag8lMBFuwlSakjhQiN+FiUb3WINipBiu/WxU7ZTiexl/n0QK79c9lbvSMrIZ/8FhcjxZA9wRku8US9V+oiJ5lXbtr86xe9/Tt4P5CDUx7Em/kFuwWgP69vZqEkGQSIPWsoc6wlNLQ+phRgv/0dF4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873739; c=relaxed/simple;
	bh=NEm7yL1tY+z8OyLIg67x8nN2SXHaA3+9XqrxKRl2XHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx/d58LNTMpEJyI1EGUNicZZ43m4+m/q5DsKlWgO6KfVhqhpr75S2t6s6h6FFFYETzFK9ZeycLO7GEilRuUsxd6sS0sF0WMPiJWf7gYh7gy5ONrM/wEsAOxPAXlterQFFD55B3KUKgyYSS2u19oVDWHVh7rfLoV2O+84le/MlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KS8snWKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55192C4CEC5;
	Wed,  2 Oct 2024 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727873738;
	bh=NEm7yL1tY+z8OyLIg67x8nN2SXHaA3+9XqrxKRl2XHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KS8snWKQcifTgbnPXZFgXbP7GivAI8q8/a5UToOtdG4voaBDEUWSiMHdMlLc+GXz7
	 4JobqJJMaN9iEZFNc0SMU0hAnOX/USrP1zt7vLaeudpfgsXbRPo2vIQffJWEwLU2I8
	 kKfbukL0B86hthtDuilKjLw3jGtdHOBlXlLIZ6jo=
Date: Wed, 2 Oct 2024 14:55:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>
Cc: stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Helmut Grohne <helmut@freexian.com>, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: mt76: do not run mt76_unregister_device() on
 unregistered hw
Message-ID: <2024100229-washcloth-unworldly-e913@gregkh>
References: <2024100221-flight-whenever-eedb@gregkh>
 <20241002120721.1324759-1-georgmueller@gmx.net>
 <2024100217-sighing-rehab-b6fd@gregkh>
 <d039eb47-d41e-48d3-a51f-1a0cb6c0ebb9@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d039eb47-d41e-48d3-a51f-1a0cb6c0ebb9@gmx.net>

On Wed, Oct 02, 2024 at 02:41:21PM +0200, Georg Müller wrote:
> > What kernel tree(s) do you want this applied to?
> 
> linux-6.1.y, please.

Now queued up, thanks.

greg k-h

