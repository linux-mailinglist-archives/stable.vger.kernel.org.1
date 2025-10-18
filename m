Return-Path: <stable+bounces-187833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF063BECD75
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 12:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5384C620912
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384BC2F39C2;
	Sat, 18 Oct 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="uakC5jdb"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C032F2607;
	Sat, 18 Oct 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760783009; cv=none; b=f5Ou5mM747sKxMvsOvBWrsJY4LhXId/fFuJFP/N9ILFaf+vNtV2p6rfv2UPcEM5/4Xh5Dr3J9/OHtiprpV9By4q6cj0gKLLQjlFOvOhde6JeZZumnekXvF8yeAaMnliifhDEKRB7mfAGNyYNp+Wo8+5AHIyZ7DKdgQCWwOIROI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760783009; c=relaxed/simple;
	bh=tHkAd3d04Br1yWxsSbGdG5sMfa7iGWufQVq92X1HAPE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU5t+4GvQq1iV69pf3B5+fP4bbprQX+mlVlIPnuGw7al7PxpJD9b+n5UINKB161sy8o9036509SChxY4COl+q6m6mD69tgI94pTTfFUUPLxWWvhVfVe2UkiAyDztLa6vDE0IXW7N7JTsUmXvBtvFrED1AwsUjG14bKur18uLyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=uakC5jdb; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sat, 18 Oct 2025 12:17:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1760782627;
	bh=tHkAd3d04Br1yWxsSbGdG5sMfa7iGWufQVq92X1HAPE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=uakC5jdbueC/JpspD7WHhnYz1cveatChek8pqoCRHgcHfxXu/3HPfoDqI/9SYuIWX
	 223hZi3l6jv+wb3D1VtViW+nyi+4PHnJXXg1aya+brXq51scZNzB25VYFZa5A8blid
	 bpx+jnyQFbHFI8H5+RYJAYBqZs29458tsLx0RGbf2KhY/3mMb68IomsokfqJc9EqdP
	 AHqazTOQZ1EvEeYXDGUTxRl6Rhf6TyJMXfueo21HD9cCfkJ2JB+bFHbYPBuKeEv1ux
	 tvqGS8+Hd1j5coNSNwmMwn32iSNjOntsT2MKIa1SBTgXOSh7EiTC5aRDYQLw5zJ4ml
	 MzuIbmZ4SzJcQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
Message-ID: <20251018101706.GA3227@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017145201.780251198@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.

Hi Greg

6.17.4-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

