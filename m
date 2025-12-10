Return-Path: <stable+bounces-200688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC8CB2589
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 09:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE77A3019892
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D729279DB4;
	Wed, 10 Dec 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="j4x7zBgI"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C321C9EA;
	Wed, 10 Dec 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353752; cv=none; b=tE6CTAGqX0R2fwKH7jxE2P0WWykey1a/jhAu7AptU0yZmGUQQDRJbnrHEvkgPoFmIu8EEIFO+FiXKJIZghtkcyyBsM100aKXl+L1moRB6rXcl1x/CGRCan6dSZn/wDJXvCALK53y22IS198ca1y/D9nk1OwitQbBT5k3xwiY0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353752; c=relaxed/simple;
	bh=F88937KEeOv34OTjx3/qIHR/L+oFarYNTHp8BwLp0iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXZ0PdDj8faw9JM2jD/7r/rhuenVmS2U5kB4BHuqhTfCG7nQYN7wDi0KPRFE66twjgWsodGRE9jA5+G5KCqBDZMfZVqrDAiikppwalkG4jj4JZbw7Yofp0u8XrDnIs2Tda68ome0ZlowU2VaZmPwQetJKd0dHfl1CToXX9QqRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=j4x7zBgI; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1765353748; x=1796889748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F88937KEeOv34OTjx3/qIHR/L+oFarYNTHp8BwLp0iU=;
  b=j4x7zBgIElg66dVVXBSBxSPmVgrmBY1C2UKD9HVnDf3kJ1CSU/KztLDl
   J+dUCF1UwJw6IIDrc9pHd7DYCclmIfdwOyLkdDz18J9mYtZSVloHKN6Ul
   v0JNEtImwY0eHiOMI8X/GWvppdMInGH+GDd7RkVIQQ9/sTtuSTVZWPa3q
   0vrme7sYcoEO9FAFAcfzGlLiKPPv6GkLj1yZGfXRplEwBZ5wPZEqvXB7y
   qOJluqKcz4swsSdihl0cZ0p6/tuGKlpOMovJm8hGlQVVMms7Fg6M8IV2T
   AKG3LGN4JG8tJiEaOJBOLLXxp9DJQv4oII40byUiLfCBUbzDbt3TQKUry
   Q==;
X-CSE-ConnectionGUID: 0VJmMiU/RziYp0AYQ1doew==
X-CSE-MsgGUID: ZD5JtUBhQqSvv79B85X3KA==
IronPort-SDR: 693928fa_tPIoLN0LbybcUrnD3nN0d3D1N8LnoHFX2UG5Fb5jq4DCiNo
 CZFw9NrTiGB1Tfk301HKikNC4awDAkctyCT/g8A==
X-IronPort-AV: E=Sophos;i="6.20,263,1758578400"; 
   d="scan'208";a="1478287"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 10 Dec 2025 09:02:03 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id 1B46813005C8;
	Wed, 10 Dec 2025 09:01:43 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id 0400613005F4;
	Wed, 10 Dec 2025 09:01:43 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id XEJXAxwHLqfw; Wed, 10 Dec 2025 09:01:42 +0100 (CET)
Received: from [192.168.100.117] (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id D3D5C13005C8;
	Wed, 10 Dec 2025 09:01:42 +0100 (CET)
Message-ID: <d92d036b-fc99-4ce0-8377-4079a3d00fb9@hale.at>
Date: Wed, 10 Dec 2025 09:01:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: nfc: nci: Fix parameter validation for packet data
To: Simon Horman <horms@kernel.org>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <20251209132103.3736761-1-michael.thalmeier@hale.at>
 <aThO7rm4MqONBurh@horms.kernel.org>
From: Michael Thalmeier <michael.thalmeier@hale.at>
Content-Language: en-US
In-Reply-To: <aThO7rm4MqONBurh@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/25 17:31, Simon Horman wrote:
> On Tue, Dec 09, 2025 at 02:21:03PM +0100, Michael Thalmeier wrote:
>> Since commit 8fcc7315a10a ("net: nfc: nci: Add parameter validation for
>> packet data") communication with nci nfc chips is not working any more.
>>
>> The mentioned commit tries to fix access of uninitialized data, but
>> failed to understand that in some cases the data packet is of variable
>> length and can therefore not be compared to the maximum packet length
>> given by the sizeof(struct).
>>
>> For these cases it is only possible to check for minimum packet length.
>>
>> Fixes: 8fcc7315a10a ("net: nfc: nci: Add parameter validation for packet data")
> 
> Hi Michael,
> 
> I don't see that hash in net. Perhaps it should be:
> 
> Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet data")

Hi Simon,

You are right. This was a hash from a stable branch.
I will send a v2.

> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> 
> ...


