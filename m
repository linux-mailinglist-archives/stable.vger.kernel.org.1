Return-Path: <stable+bounces-116793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A534EA3A09C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F63A38C7
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CF23958C;
	Tue, 18 Feb 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hza6CLpY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EEA14E2E2
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890487; cv=none; b=cBZqxqUnQLbjAfET8PGu1fGdxBSwu6YXhLRBPgvgfVbhctVjUBhifhX6lf/iN0nZTlzxRrQlSaV5lAzBTkKagI6ouZE2lkQearCsjr27OvAfwvGy9BaNHOWFHlGh1u35KtWYuJtM+f2ychS5oX67SbwxuhVtF7b1fPhMEDxyyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890487; c=relaxed/simple;
	bh=Wn/EvvndZJd0g+eQDaQENAEBCULKVS+KW0Glch3inBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB3mrw8qxWdmz/SVjjx205ErGtWxhLObggazeMJjMDXu5xwz1FYOVHurmuHzVDRMAhcqv6Ap01W4jU4N/5/3mlGC40299rTqtfZ7gZcU+GSeF60fYoGpzJRurgkZxbDONLek6Si4F7gSf02Qa0BgedBn7eR0/woegdOdzlfodNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hza6CLpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602D3C4CEE2;
	Tue, 18 Feb 2025 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739890486;
	bh=Wn/EvvndZJd0g+eQDaQENAEBCULKVS+KW0Glch3inBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hza6CLpYMsRxlKgjGMgZZbDR6ZhSazDE2a6thIl19QECEe/jYkYWpGY9kKcLcqFa6
	 QHKgRtkgmc5GkzK2T1eDDDZpwK5VZHpuKsdOcisCdgyDsTC5X/6cPK+MvIp78hSot7
	 Q8UkM3dQ6aJyNl3la2di7gCK0OtMO8q9uVtcYppo=
Date: Tue, 18 Feb 2025 15:54:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Xen.org security team" <security@xen.org>
Subject: Re: Patches for the stable branches
Message-ID: <2025021837-trapeze-late-ea8e@gregkh>
References: <e925b8b0-76da-4c83-852e-225acf4aa333@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e925b8b0-76da-4c83-852e-225acf4aa333@suse.com>

On Fri, Feb 07, 2025 at 10:30:05AM +0100, Jürgen Groß wrote:
> Greg,
> 
> please add the following upstream commits to the stable branches:
> 
> 5cc2db37124bb33914996d6fdbb2ddb3811f2945
> 98a5cfd2320966f40fe049a9855f8787f0126825
> 0bd797b801bd8ee06c822844e20d73aaea0878dd
> 
> They are fixing boot failures when running as a Xen PVH guest for
> some kernel configurations.

All now queued up, thanks.

greg k-h

