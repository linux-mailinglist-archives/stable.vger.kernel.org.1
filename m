Return-Path: <stable+bounces-184029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C3BCE19E
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 19:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E03819A10E5
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79B22157F;
	Fri, 10 Oct 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="W4dJUOjk"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6220C023;
	Fri, 10 Oct 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117878; cv=none; b=gEu44aqzjRgpZdVP4/6OJNKSsQzEzlBBCJa2xCrAQgvYwrRIllZDDMw4Ggo+ENIa9ObFP4SAhywWF4CzwM5tQzT/lbLmi8/S29zkX4mLggbR2hFw3gw889NNP4cFIG4Mgxb15hE+GA1W6hLfPiXUGE5RVmLUvPmRFdnFSxOJRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117878; c=relaxed/simple;
	bh=K8tQrfrhp78OMG2/IOMfrkE249BlFmU31TXdhPDQjuA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxMVryt+BA5OTBwjWX3zsHM6z8ycHxJMTFN+6RmpCkcGKf0FWqVxbuU9KCArxJeIaWNlMmMj80aCBlHKpFMDyS3MqUY0ID9hkF+ljb4kGkBCt3QZuDB2SYpuoKQzKPihaKcScrzC248/0XCm0aJ3Cjw+WnaRb8458O/UW9HbjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=W4dJUOjk; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 10 Oct 2025 19:37:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1760117868;
	bh=K8tQrfrhp78OMG2/IOMfrkE249BlFmU31TXdhPDQjuA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=W4dJUOjky87PJ5wA15aBxe3lhZD7vT2YqO1fV1mVKtsB9qUQVPkJxaXhH47BHKru4
	 hW+a8raa169S7GjN5nJoYj+7c9hzyPyGw9M+85SvbEGjknFxm5SkRH1xsUClp5zv5p
	 ibY2p3OZ7I3JA7PFK4ZPZfCK/iOn5ZTahX7pKnfxmcV4fuKTbvdDHw6ZM52Ma2fIur
	 XNORLCvxkys+eX9OuhzJq4O7mDlKHyQAXmiFZBjHiRs23N0n9XlmQ8EPVqkfeAsTwl
	 lb4GjqYajHTi8cpoe4cRGtfJx2b/y71Uhtnv7ThV5TCWxhyM+9//nzSpM4XBW/D0XM
	 H/D2pjCblylrw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
Message-ID: <20251010173748.GB18723@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251010131333.420766773@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.

Hi Greg

6.16.12-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

