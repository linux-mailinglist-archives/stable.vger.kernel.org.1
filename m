Return-Path: <stable+bounces-143172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D47AB3389
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4365E860893
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C139A25F7BD;
	Mon, 12 May 2025 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIot0SOO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859C2566F4;
	Mon, 12 May 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041869; cv=none; b=u19iouaTOYyuYnc3MhFGNab/bQr7yMfsDXB/FLRLeRzjWISPpWuPQsbVPLh1e/0nWAS4fE8hntv1HFKWDtGjQo4ynhKNK0YckTXD5lEkwgLwLkpQZwUV732Uuijbb69PZiTiBTR7VtZjlP5x7l9nI7weFEONiFU+wdyzqEqDuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041869; c=relaxed/simple;
	bh=SepfAwFmEPyhCW7mcqed5FnkvJ30i4FjvqzI0hrQgm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlz3Xug9uOyHeHBh9GMu81Cw0c5vHiRjUavkwe2kXa9uKN1e/c2EYcPAaeyjyN4sTfe0dhuzcxZPRoa0HV9iXJaiWdHYCvUZF6ynk5KB2pIv+47FlJ/6Ekis2LF1Fllr8ap5mTzB/QX6tGD6fz5cEWf8lL88vjHYplR/dz9gfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIot0SOO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747041868; x=1778577868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SepfAwFmEPyhCW7mcqed5FnkvJ30i4FjvqzI0hrQgm0=;
  b=CIot0SOOUrl4hJ1J1+t7jqOjk/97Maixp2xVge9+hj3EDsWtcUuWKTUc
   ka4AF/a4kWSeR9ShZhvp3dc8urAS1ikayEq14TXAwCr4DtCm1ainYN8tN
   E2WFtMhXmHgxp6iAzqfb+K6kbSt1KgDIy2gqZpJH4M5Fuy8DUR56TL5sB
   80K2BakC1ubU7q8MdU8r1N0KyLZ+zowyA633jbJgWXiQmgNIq4ZG5JDPp
   xCw9SLiYN9A6IXK4sa7Y/c539kFIrltn/OLHCMX3JO1zUiohQrP0q4VGt
   aSpP6YH+iXrDBvfYlF3FOr4F2PTCgm96pnNI0dq6LERiEYsJHuyy8niLD
   A==;
X-CSE-ConnectionGUID: Z/tAuSuhTVeta4wm6CVrUQ==
X-CSE-MsgGUID: bU7jMK42TBaNfGntviD5Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48980268"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="48980268"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:24:27 -0700
X-CSE-ConnectionGUID: 1tVxKyEuSbiofFOu0DBnGw==
X-CSE-MsgGUID: ErCKQ8jpQD69Q9c/3yHA4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142525408"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.124.249.161]) ([10.124.249.161])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:24:25 -0700
Message-ID: <1862275b-e7ca-4fa0-bdea-f739e90d9d22@linux.intel.com>
Date: Mon, 12 May 2025 17:24:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mtrr: Check if fixed-range MTRR exists in
 mtrr_save_fixed_ranges()
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Bernhard Kaindl <bk@suse.de>,
 Andi Kleen <ak@linux.intel.com>, Li Fei <fei1.li@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250509170633.3411169-2-jiaqing.zhao@linux.intel.com>
 <20250509173225.GDaB48KZvZSA9QLUaR@fat_crate.local>
 <0ec52e49-3996-48e2-a16b-5d7eb0a4c8a6@linux.intel.com>
 <FFB8ACEC-7208-40D0-8B57-EBB2A57DF65F@alien8.de>
Content-Language: en-US
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <FFB8ACEC-7208-40D0-8B57-EBB2A57DF65F@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-12 16:46, Borislav Petkov wrote:
> On May 12, 2025 10:31:23 AM GMT+02:00, Jiaqing Zhao <jiaqing.zhao@linux.intel.com> wrote:
>> This fixes unchecked MSR access error on platform without fixed-range
>> MTRRs when doing ACPI S3 suspend.
> 
> Is this happening on hw which is shipping now and users will see it or is this some new platform which is yet to see the light of day in the future?
> 
Actually it is happening on virtualized platform. A recent version of
ACRN hypervisor has removed emulated fixed-range MTRRs.

Thanks,
Jiaqing

