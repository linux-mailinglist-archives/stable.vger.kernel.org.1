Return-Path: <stable+bounces-189010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B2BFCE8C
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E1A3A3B3B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B432ABEF;
	Wed, 22 Oct 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YziLEkxW"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28621EB193
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147320; cv=none; b=S2oh1BB8Hge0/Nh+FxImeuXiIoqkZaHxmZPZ0z/W7W5u0lw3eYRbsRtKlz6tmRUXzehJfXm3v5BWA0jY1K6vUuV2I7SxDGnuTGg8eqY7I+qlQzkwn0vT7iCCn39+d/WeZp0EPWbIc1vpXrCOTclP3ZAEfwBS/SNEFj4+lRYd/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147320; c=relaxed/simple;
	bh=uf/k+/AEgekOeLH9j2kWf0SPl+SLHvNUSxmDTt1LbNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvIzDvFQEq+yt03NG+PGXWDNiYDlzA/YlaspO19AKPEFSBanIn+C0wSHbZGbGD2LAX5Wbas3MCHdcmFqE2jFiourpFDlDletVSQOd/1OT/TmuDdaO3RHNo8iqC5s3i2fN5GlFXfHOYN1BFCfMSV2gmXbmvZx6LyMq03hBoph3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YziLEkxW; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1e5a58b-f5a5-4acb-85ea-59a7f43c060f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761147317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iYpTFR7g26YCYkL8ooNPprAkKOl1jlVIj+zsrDxsYk=;
	b=YziLEkxWruWwReycddBdGYvvFQvSScqhH4PRwz5NsTxfUgA5M2Ik2/DOYJ2msrqta3lwRo
	VOUyIzGYF0ntgG0DnOQvf1j22qXsR+0dwVanf3QPMHHTnWVNtybgtQ1rDkb69NKNISvEfO
	hXFo+H36RfsB5BL5IWxNrSau7VJIxc0=
Date: Wed, 22 Oct 2025 23:35:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <2025102230-scoured-levitator-a530@gregkh>
 <ff0b2bd4-2bb0-4d0b-8a9e-4a712c419331@linux.dev>
 <2025102210-detection-blurred-8332@gregkh>
 <70f8c6a1-cbb5-4a62-99aa-69b2f06bece2@linux.dev>
 <2025102241-clubbed-smirk-8819@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <2025102241-clubbed-smirk-8819@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/22 22:26, Greg KH wrote:
> On Wed, Oct 22, 2025 at 09:34:52PM +0800, Leon Hwang wrote:
>>
>>
>> On 2025/10/22 16:20, Greg KH wrote:

[...]

>>
>> Hi Greg,
>>
>> After checking with 'git blame map_hugetlb.c', the issue was introduced
>> by commit a584c7734a4d (“selftests: mm: fix map_hugetlb failure on 64K
>> page size systems”), which corresponds to upstream commit 91b80cc5b39f.
>> This change appears to have caused the build error in the 6.1.y tree.
>>
>> Comparing several stable trees shows the following:
>>
>> - 6.0.y: not backported*
>> - 6.1.y: backported
>> - 6.2.y: not backported*
>> - 6.3.y: not backported*
>> - 6.4.y: not backported*
>> - 6.5.y: not backported*
>> - 6.6.y: backported
>> - 6.7.y: backported
>>
>> Given this, it might be preferable to revert a584c7734a4d in 6.1.y for
>> consistency with the other stable trees (6.0.y, 6.2–6.5.y).
> 
> Ah, yeah, it looks like this commit was reverted from other stable
> releases, as it shows up in the following releases:
> 
> 	4.19.310 4.19.315 5.4.272 5.4.277 5.10.213 5.10.218 5.15.152 5.15.160 6.1.82 6.6.18 6.7.6
> 
> So a revert would be fine, want to submit it?
> 

Got it. I'll send a patch to revert it later.

Thanks,
Leon



