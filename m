Return-Path: <stable+bounces-100832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018959EDF82
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1067284349
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E7202C2A;
	Thu, 12 Dec 2024 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sI1/h9r5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D532036F9
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985144; cv=none; b=FPq9Rlly75kVfRLruKMA3VZx6YZ0bE7upejl2V+P2UXjZ4YLNYMl74FW33ogqfXf1p6sgIJiQFcFc0tb9qVR4dkJFVbvsCCfAlfNk4FewhjD9cFVrzEYWZgayXZDI0UhB7oJ7OfqEFSnB1xjRtoIAm4fyRQOSS89dGg5LIMV0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985144; c=relaxed/simple;
	bh=8AhYCeBJru7ooJkug6kqPcfx0xyUducE7/MWq4h/hzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1iE+4YvflPtkrrcDB9xwPV7KR+hl3wvi7ps33Xzli96wO36qH1PCN0GI+AUIT2rbNTWAE6sZ8Y4mMS41lnl7kM80jXdAJfXnDLO/z2r3oUsbgQhQ2djAstrA4Fs1RrXMiAEBI8Xf8dC8Y5dzIz7AzTjpCypLIZ2g7vZa5du/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sI1/h9r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF712C4CECE;
	Thu, 12 Dec 2024 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733985143;
	bh=8AhYCeBJru7ooJkug6kqPcfx0xyUducE7/MWq4h/hzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sI1/h9r5XXc81j2RcwLcALg9lrpdvQkyQ3f+StrpjzJhauzIADbnp+Uy6WOulSiKE
	 j25uBLKrx+gCSCbUA8l2OD7AGoxV50l5Nu+4lKzLr/D7eisFsqm1bmQPk1p/+a1s3w
	 K62ZruwxpO+IEvH5ZyJEzw4M92377VeIwD/9mMrg=
Date: Thu, 12 Dec 2024 07:32:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: mschmidt@redhat.com, selvin.xavier@broadcom.com, leon@kernel.org,
	xiangyu.chen@windriver.com, stable@vger.kernel.org
Subject: Re: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-ID: <2024121256-frenzied-tackle-2526@gregkh>
References: <20241212022121.618415-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212022121.618415-1-guocai.he.cn@windriver.com>

On Thu, Dec 12, 2024 at 10:21:21AM +0800, guocai.he.cn@windriver.com wrote:
> From: Michal Schmidt <mschmidt@redhat.com>
> 
> V2: Corrected the upstream commit id.

As documented, this goes below the --- line.

Please fix up and resend.

greg k-h

