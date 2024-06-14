Return-Path: <stable+bounces-52143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C59083F1
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC7B23272
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 06:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82C145B34;
	Fri, 14 Jun 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2lOfdGQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68031474C0
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347287; cv=none; b=nJaX4FLahkPlDsTA6iwJeY4vcRj1CLHChfQRZLOE+iP75hODxrXBX0eeo75/AICKspCz9/4iTZnjThLSOIhhFzPSpbFwFrapAg1o3rIhC4QMmEAd5hdEYWM3+bPLwmOEn89l+/lxCknU976GC+19rbiSBDzpS7SGDAmTrgz+LrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347287; c=relaxed/simple;
	bh=Y2Wh+UXVjnhAmfXieNs3297oj5XDEXpjlP1xZPsL2No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7W3rorkMKmwpUF2Qbtmi9KU6rMcvlWVZArscp2v29P+hpR5Nc6k6UwLGWxX91m2yz2orF3se4vDYoMuuHNAJhVvGnOF47YGveEfpr9fFlIJXP9a4FTJsst7dbCOkoH7U4XrYbjfCCi0mTfv+ryNJ7r1jaYnkYF3N50wD5nZNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2lOfdGQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B637C2BD10;
	Fri, 14 Jun 2024 06:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718347286;
	bh=Y2Wh+UXVjnhAmfXieNs3297oj5XDEXpjlP1xZPsL2No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2lOfdGQ4GiNRpulvbRPVdMP5qqg9438HBoFJhqe41KRlQEMO2ABLG+E+IO5SI+kv7
	 81dF5L4rDyUPcUkpePvuxTNCLn3FsU/dSzdy2zWDQ/YOqVAVL4GBr574GUiRT83lEo
	 uzv/KNCqQWdfq/+wm8CqLH7RdJZY9mr8Uyy1wPXc=
Date: Fri, 14 Jun 2024 08:41:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sam James <sam@gentoo.org>
Cc: leah.rumancik@gmail.com, stable@vger.kernel.org,
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 6.6] backport: fix 6.6 backport of changes to fork
Message-ID: <2024061400-squash-yodel-4f49@gregkh>
References: <CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQWNjfwEx4Fps6g@mail.gmail.com>
 <87zfro3yy5.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfro3yy5.fsf@gentoo.org>

On Fri, Jun 14, 2024 at 05:55:46AM +0100, Sam James wrote:
> Is it worth reverting the original bad backport for now, given it causes
> xfstests failures?

Sounds like a good idea to me, anyone want to submit the revert so we
can queue it up?

thanks,

greg k-h


