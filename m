Return-Path: <stable+bounces-60775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872C93A122
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2211F231EA
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5459153517;
	Tue, 23 Jul 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F4J0Hrvu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F915350B
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740613; cv=none; b=hkrAPZX8viIomcqk6Gx5efHl2S5AGdTGjoDZrxk0EO+kU8gnDI9MUdHSUGvIgSqfCkakWqKR/yzxLqIL+uuSkh0GVk0ACKfGey/W+9ueAj5/vUaPqevFHXv3Nm1rJST7YK3d37e9HjILZFS2h/vEpySHKn8q1rIO8PIsZB0hxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740613; c=relaxed/simple;
	bh=TKDpbJjYtgHzoo5T7u/nqZs/plbq4bQB1Hh6uc9n1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snWhlDLaptQJFyvcyoHIctIQtHaLiHq8AR3/ApqOJ3MX2L3/W/NIoRzI815JfNWYdzQI4ulLT1+awTGd0YhFw8797vb5yL910bByYKL879RiVDAKbfNhn19Jfc+0iuivjLKZXXyv54p/7NaqeIpfY9kC22d2cA09Py//mXQP+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F4J0Hrvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1975C4AF16;
	Tue, 23 Jul 2024 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721740613;
	bh=TKDpbJjYtgHzoo5T7u/nqZs/plbq4bQB1Hh6uc9n1Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4J0HrvuXGrRS99cF2ZuuOacAOY9GTO/lfS6m40aAU+0YoDwgXoRtjnW03hiEGAWn
	 Pl/ifJcKVGFb9l1r2qL7Jm+fIm6S///LtzPRSLhmhKdHbm2mKzbYen3o4vOVvSYiYY
	 1QAyuEdy3iwWIHXR4/lsgnK05r8KBzWG9aBytC+8=
Date: Tue, 23 Jul 2024 15:16:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: syphyr <syphyr@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Missing writer side af_unix annotations in 4.19.317
Message-ID: <2024072322-victory-wanting-67b6@gregkh>
References: <e10727bf-d914-a902-9e46-195ca28799e9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e10727bf-d914-a902-9e46-195ca28799e9@gmail.com>

On Thu, Jul 18, 2024 at 08:14:53PM +0200, syphyr wrote:
> Several commits were made in v4.19.317 for af_unix to fix race conditions.
> Most of the READ_ONCE commits were added to v4.19.317, but the WRITE_ONCE on
> the writer side did not get added. For example, https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.163&id=5b9668fd874144d02888e55bb95ed5f4aacdf703

Can you submit working backports for the needed trees?  I don't see that
commit in 5.4.y or 5.10.y either, shouldn't it go there first?

thanks,

greg k-h

