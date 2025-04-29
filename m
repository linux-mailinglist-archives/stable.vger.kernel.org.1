Return-Path: <stable+bounces-137059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAFAA0B5E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5241B6254B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232BC2C10A2;
	Tue, 29 Apr 2025 12:18:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A11EEF9
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929114; cv=none; b=C40goi925Dw9+tPescOAu9HWzx5WzpCtohHvqijRpG4+QVrGnbT6j4oTYcFa4gi5jdQii9x9Og+xmiq8soNMXOltUiTLuvo7aw/SsHn5a4qpxYvcMu886UE+xzkxk3uQyF7ZYta8w039V0zd/vfLe0BOWbHYJy2RtGcikl+kxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929114; c=relaxed/simple;
	bh=tli6/R+CTgKmXTLrhL6wlb/y/6SPOT5+i0hw9etSIj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqqnEzUe3KfQp7SbsLZEJJBOBs6uq47dlKKThAVKDwweWEMIpt/i8QPET2vs9eGnRsfDTHB1B7gKiPf4IaJimPnAo0pZ6HhnHwnRpa9s0nBdRb+GHzWipzOm9V0H55qLZE66y5t7Qf9Pkxp2XdtupxtU2TVSgGNlfHSs2xS7Go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C6501515;
	Tue, 29 Apr 2025 05:18:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A0B3F66E;
	Tue, 29 Apr 2025 05:18:27 -0700 (PDT)
Message-ID: <c50921c6-98bb-4aee-8eba-c254556f2c79@arm.com>
Date: Tue, 29 Apr 2025 13:18:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] iommu: Handle race with default domain setup
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
References: <e1e5d56a9821b3428c561cf4b3c5017a9c41b0b5.1739903836.git.robin.murphy@arm.com>
 <2025042955-pelt-scorebook-dd4d@gregkh>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2025042955-pelt-scorebook-dd4d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2025 8:35 am, Greg KH wrote:
> On Fri, Apr 25, 2025 at 03:19:22PM +0100, Robin Murphy wrote:
>> [ Upstream commit b46064a18810bad3aea089a79993ca5ea7a3d2b2 ]
> 
> <snip>
> 
> You seem to have forgotten about a backport for 6.12.y as well.  You
> know we can't take backports that skip stable branches, otherwise users
> will have regressions when they upgrade.
> 
> Please resend this when you also send a 6.12.y backport, and we will be
> glad to queue both up.

Hmm, 6.12.y should have had the mainline patch already, I wonder why it 
didn't get picked? Admittedly I didn't explicitly CC stable, but I'm so 
used to autosel picking up fixes tags these days... I resent anyway for 
good measure, given what else I also managed to mess up last time, sorry 
for any confusion.

Thanks,
Robin.

