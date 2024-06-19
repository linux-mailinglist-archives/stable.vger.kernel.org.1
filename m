Return-Path: <stable+bounces-53839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382B90EA43
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6230282F9F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D0713DDC9;
	Wed, 19 Jun 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jc9GIvu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E476035
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798397; cv=none; b=kOaweLbMEBdKCOdVGj0sNKnLq+bsLoXwWWTyBpNZtMBEBKVcfSbIDAQ2wYJTsszwwcJQv698QQwxVDT4NrYtZFSi7+7DNJODgUHhU2I5kzQ3mtoKE1uQHw0aVu0LY8e7oswLaLPGHTbnNKacgrvLrpS4zfjtK/1Z9wfxkjH93x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798397; c=relaxed/simple;
	bh=eo+sjsvFZWk6wtF6z6Qd/J0XE7PQdoDowSFJVfEEzPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtWNdaOUcLYhNQL9B/fgszlFldJ6ldHyURMSTBW/SUaqQi0tNZktH5eYOIebi+rR+ew8L8m90WnH5YAM5tFH1P6vPxFJjLaDny6r+wuG+lYnFqTMFcurYey9XGnN+Jh/PHKBK9iUI2Jvv22GykNGP7Pj3YBXWL85SFN8mUyzlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jc9GIvu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E643EC2BBFC;
	Wed, 19 Jun 2024 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718798397;
	bh=eo+sjsvFZWk6wtF6z6Qd/J0XE7PQdoDowSFJVfEEzPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jc9GIvu8xBau2+1SvMASPt1jpTLZiPT4WaxTlFrzU/R5MZ9tLtPAjDCHuqkZzeV3t
	 lU7XRVjPhTUo3lv5hDqhIiwK7297n7bsQo9OHl+bc3iN2OT7tttZ3mdLln9WU/xDHZ
	 wiEz7O7vEalorzWVS62m/D9ab/cLwWim1mxzPDqo=
Date: Wed, 19 Jun 2024 13:59:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc3 Deadlock
Message-ID: <2024061951-heavily-finisher-eda0@gregkh>
References: <CAK4epfwxVTJBZWWcSuCYkV1F0rnq-vWTvA4TBOHzUKqjA9id9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfwxVTJBZWWcSuCYkV1F0rnq-vWTvA4TBOHzUKqjA9id9g@mail.gmail.com>

On Fri, Jun 14, 2024 at 07:15:39PM -0400, Ronnie Sahlberg wrote:
> Pruned list of commits that look like genuine deadlocks that are not
> yet in linux-rolling-stable
> 
> 44c06bbde6443de206b3

Already in the queue.

> 8c2f5dd0c362ec036f02

Fixes 6.10-rc1

> e57f2187ccc125f1f14f

Fixes 6.10-rc1

> 67ec8cdf29971677b2fb

Fixes 6.10-rc1

You might want to adjust your scripts so you don't send false-positives
like this :(

thanks,

greg k-h

