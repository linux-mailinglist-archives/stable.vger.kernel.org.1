Return-Path: <stable+bounces-110420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A641AA1BD11
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3805B3AD5BF
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA2224B07;
	Fri, 24 Jan 2025 19:56:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2B14A630;
	Fri, 24 Jan 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748611; cv=none; b=XPaV2wdP40VtLpao7SQoOsAidiceJHjcR5QLFJdJQYEGNougF+l5K7Lhbw/7Jf1Ajb/6I1LKveLa/4/lEeqMeO2ht/JJ/xiVgGy7nwT8XcCM9hJSm3iB/79VguXzQrPpjFhT1GX1XAmJaFiooh8yU8gsVcAasQlJlBKKVpZf1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748611; c=relaxed/simple;
	bh=+IZ7uBx+UfednXliwXguRQ78xVSJlBWi7wc9FtJOYLA=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=AshRPcimzxrPqS/7cgrUbimGI4WUB0PfCz4AZO771unTi+RGolvAeLtQGTjd1bvFuegKLJIR0MMMiyafLOTneoYgW/smDkWBocsOHiRMWEdVe1rtV0eSVMjsOrwPYsDHQnahYshG+UagxSm8TTcewRc+AXLKntuKEVzss4IFQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-190-252.static.sonic.net (192-184-190-252.static.sonic.net [192.184.190.252])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 50OJiZJO022499;
	Fri, 24 Jan 2025 11:44:36 -0800
From: Forest <forestix@nom.one>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke fastboot android bootloader utility
Date: Fri, 24 Jan 2025 11:44:35 -0800
Message-ID: <2tq7pj5g33d76j2uddbv5k8iiuakchso16@sonic.net>
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net> <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com> <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net> <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com> <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net> <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
In-Reply-To: <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVYUNXZYVNL+twlhcDcM7O7ZGjbsZa7RKQ0pEf/BCTtrz6pBXmRZy4pU15G2goJU2b8kIFNOoceYgi2lh3kUS8yg
X-Sonic-ID: C;YN0CpIva7xGUSYGchs+snA== M;nFwapIva7xGUSYGchs+snA==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

On Mon, 13 Jan 2025 17:05:09 +0200, Mathias Nyman wrote:

>I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
>Let me know if you want to submit it yourself, otherwise I can do it.

It looks like I can't contribute a patch after all, due to an issue with my
Signed-off-by signature.

So, can you take care of the quirk patch for this device?

Thank you.

