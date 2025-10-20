Return-Path: <stable+bounces-187999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E51BF0102
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FA3A909B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0722EAB71;
	Mon, 20 Oct 2025 08:59:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C81DE89A;
	Mon, 20 Oct 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950750; cv=none; b=Wf2D7d7Ju7q5y5Am/8wDGb2ZfaymF1kr7OA76PuAgc3J4E5VI8XKTI102YslCEXGyXoTRtxmr/oR6yjocyRTHXDl7XrBJy/CoBN7xTsb3xHyKnv4kUWMlu6Yqs3yw8Q4Ju5Iiq4p2wRBJe+WXfFSfKnSDoB53lndE0YlTOH/igA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950750; c=relaxed/simple;
	bh=ZCs2019+jPctDm3Qzk5fe7AUu7C1JkV6NIBfph2D0no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWS/GkaKyQMIuToGZelW3axW4aOB8BpVXEpFoJfqA7B8YwbdLStyj8JJRzZJuIuF6CvOTqVAOpwIJtNhI7HXaGyH12Vbd6Vxj0O3uqvVcUsuLyPbQI3Y0O7lyY9d0JA4ZkuUnG9X3AVTSwiqEdAePKqhYk1BgnzX6UZ+Cki3gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53F261063;
	Mon, 20 Oct 2025 01:58:59 -0700 (PDT)
Received: from [10.1.30.161] (unknown [10.1.30.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E3EE3F66E;
	Mon, 20 Oct 2025 01:59:05 -0700 (PDT)
Message-ID: <0e78a91d-f791-4cc2-be58-a44e2ec7e6f5@arm.com>
Date: Mon, 20 Oct 2025 09:59:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4-6.17 0/2] arm64: errata: Apply workarounds for
 Neoverse-V3AE
Content-Language: en-GB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251016111208.3983300-1-ryan.roberts@arm.com>
 <2025101708-antsy-steadier-5ab6@gregkh>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2025101708-antsy-steadier-5ab6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2025 08:08, Greg KH wrote:
> On Thu, Oct 16, 2025 at 12:12:04PM +0100, Ryan Roberts wrote:
>> Hi All,
>>
>> This series is a backport intended for all supported stable kernels (5.4-6.17)
>> of the recent errata workarounds for Neoverse-V3AE, which were originally posted
>> at:
>>
>>   https://lore.kernel.org/all/20250919145832.4035534-1-ryan.roberts@arm.com/
>>
>> ... and were originally merged upstream in v6.18-rc1.
>>
>> I've tested that these patches apply to 5.4-6.12 without issue, but there is a
>> trivial conflict to resolve in silicon-errata.rst for it to apply to 6.16 and
>> 6.17. Are you happy to deal with that or should I send a separate series?
> 
> Please resend a separate series for that, and then resend this series as
> well, marked for the specific kernel releases that they are for.

OK will do. Incoming shortly...

> 
> thanks,
> 
> greg k-h


