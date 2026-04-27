Return-Path: <stable+bounces-241235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAH3NPAL72kq4wAAu9opvQ
	(envelope-from <stable+bounces-241235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:10:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFF46E206
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 262363034EFB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B1390234;
	Mon, 27 Apr 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BS13jtl2"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A562384232;
	Mon, 27 Apr 2026 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273626; cv=none; b=QknA4qa0onBw+Zk4Z16x9pUXNJhWZ1gwLHmoYykNZAqQKMhzWF/LR7n+ogwektrf4T0DE6qCp/TZtzWOumOIOnbxQ4hbzPkEgKGgHDPNgV+F1Dy7nFcC3sR+vR/rK8E09IQQ+K/gQG0yeXCzsqC+fCHbH1oGVBangyCGCr9LYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273626; c=relaxed/simple;
	bh=DE32e92uHYOIlpoYVLw0H68uGO9loNojkjoUsdSiKI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp0NFvzUDEA3NI72Hd2BgPP7rYkH4StyVNUkJ587uq5saT5o8rPR4lXBRIH2s66p0RnUx700PQN8bepT0XMz4cFL5vbU3Mx6BI0KUO0FJlSiWGpRKnn1+ytYfyvFRIU8krAXMs+bV+ra/vmnuY3AfwNpIzYv1Dkng9SI6w7lXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BS13jtl2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.11] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8AB7B20B7169;
	Mon, 27 Apr 2026 00:06:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AB7B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777273619;
	bh=giftQ86SgZqHyZWw3I0V5U91tZwxylDb3voNzLxgeDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BS13jtl2GjrbvZ2/GXt+CpSA+U7hfA+dkZ4jfw6jGA4oYh3copnmIQTqTLVo+AR0A
	 M0W5D7CsVkKBv/g0Mx7zShBz/R6T0oYAfwyBx4U9rWIy3/bxW/cNyDKpv7VHTeU572
	 twRMWTpYnPb9rW6Monv0HgVf0HKPwTZJr+hbhgT8=
Message-ID: <32170102-490f-4eb3-bfe5-faa38848129f@linux.microsoft.com>
Date: Mon, 27 Apr 2026 12:37:01 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cdx: Fix double free when sysfs file creation fails
To: "Gupta, Nipun" <nipun.gupta@amd.com>, nikhil.agarwal@amd.com,
 abhijit.gangurde@amd.com, puneet.gupta@amd.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
 <20260320102117.1554548-1-ptsm@linux.microsoft.com>
 <c67594eb-7e3a-9fda-858a-a9ffa4e3d190@amd.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <c67594eb-7e3a-9fda-858a-a9ffa4e3d190@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4BFFF46E206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241235-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

Hi Nipun,

On 01-04-2026 15:12, Gupta, Nipun wrote:
> 
> 
> On 20-03-2026 15:51, Prasanna Kumar T S M wrote:
>> In cdx_create_res_attr(), if sysfs_create_bin_file() fails, the code
>> frees res_attr but doesn't set cdx_dev->res_attr[num] to NULL. This
>> leaves a dangling pointer in the array. Then cdx_destroy_res_attr()
>> frees the already-freed memory. Fix the double free by initializing
>> cdx_dev->res_attr[num] after sysfs_create_bin_file() completes.
>>
>> Fixes: aeda33ab8160 ("cdx: create sysfs bin files for cdx resources")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> 
> Acked-by: Nipun Gupta <nipun.gupta@amd.com>

I am not able to see this patch in linux-next, although I can see the 
other patch.

Is this patch still on track for merging?

Thanks,
Prasanna Kumar

