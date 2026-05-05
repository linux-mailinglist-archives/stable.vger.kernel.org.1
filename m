Return-Path: <stable+bounces-243952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKqRMXxj+Wke8QIAu9opvQ
	(envelope-from <stable+bounces-243952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:26:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC284C623E
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A303230087DD
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 03:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F43A3E93;
	Tue,  5 May 2026 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JD/3igld"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89739B971;
	Tue,  5 May 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777951609; cv=none; b=bbMFQdfVpqcsDoqAr6v+Dvez8hhLMro9tUTdXyDeWZIE9LosLD3sgERFKlw8oQ+QeATceBy1V3bnpSdvat72IRVetGtcWaI9JdkGQEHkTtNdkwgQ+Cz5bjDL2XqDzxCBc1TRwJZ0OGtYprw/WOMkUVlzjFhmqAf+NV0lgG0PV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777951609; c=relaxed/simple;
	bh=VFe7PgpFxQ1/JBMQ2tXnIfjekzfcHIqzZyLSb948a4g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LSXfjhmryNpRwE1gx3ISuKC1g5g4SAu87JrxxBmXpdwzLayTD4ezaEQATD3lKKhaFa3eK7JAyjPSY/pGdnL469XV4CEETmygJITcgR2nKg0Mr5GdKIgPqCK0v6tQap+oDGEtjWG+vqTW1yWl6CeykCFvRkxYTa+zZ+2OTr+QyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JD/3igld; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777951607; x=1809487607;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VFe7PgpFxQ1/JBMQ2tXnIfjekzfcHIqzZyLSb948a4g=;
  b=JD/3igldjrUVo1Z50OkVloC3dFACkYKTOjKVRh5pXeb6IK4ziQxhpjpu
   z5JMPB74n4vc4WUsurLmVNuA82p+i9aJa6KvZSdKNA71SSCdJ/tsjOfgL
   GbKTh7qO+v5hxVfmvEO9kn8qurr9ZJozrhtm/FLsqlJdeGDSeG7J8nH6A
   Hj/8nS9/1gtcpy6Eo0nTQQJ7Vu1n+gFTrk2enY83aQ0dKnht8HlsA+BGk
   r7AV+UwbF1Zw273SXrZz3HNc7+UWFE/VkDDU6+3Y6rDlfS88Yvl8a/cEB
   DtDOoEKIjx3MjKy5CnlLEjXQNMBQ5/RSqfL72zWVegYlYZmgRz9uFddYp
   w==;
X-CSE-ConnectionGUID: xfYAPT7mQCOeGYTUhcqPPg==
X-CSE-MsgGUID: M7RQPoacRq65Cl3fr0N7dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78838278"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78838278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 20:26:47 -0700
X-CSE-ConnectionGUID: dNMWoRljRr6xxgdFkHaM6Q==
X-CSE-MsgGUID: vnpdTCCqRr6hIpW+beQVEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239668138"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 20:26:45 -0700
Message-ID: <7e085616-ec18-49a0-9414-d3a2302b2c72@linux.intel.com>
Date: Tue, 5 May 2026 11:26:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
To: Kai Aizen <kai.aizen.dev@gmail.com>, jgg@nvidia.com
References: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3AC284C623E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-243952-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

On 5/1/2026 1:56 AM, Kai Aizen wrote:
> The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
> path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):
> 
> 	if (!vevent_for_lost_events_header(cur) &&
> 	    sizeof(hdr) + cur->data_len > count - done) {
> 
> hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
> evaluates to the size of the pointer.  Surrounding code uses
> sizeof(*hdr) consistently:
> 
> 	if (done >= count || sizeof(*hdr) > count - done) {
> 	...
> 	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
> 	...
> 	done += sizeof(*hdr);
> 
> struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
> flags and sequence), so on 64-bit (sizeof(void *) == 8) the two
> expressions happen to be equal and the check works as intended.
> 
> On 32-bit (sizeof(void *) == 4) the check under-counts the header by
> 4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
> count - done while 4 + cur->data_len does not will pass the check,
> then the loop will copy_to_user 8 bytes of header followed by data_len
> bytes of payload, writing past the user-supplied buffer.
> 
> It is also a latent bug for any future expansion of struct
> iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
> should not depend on the type happening to match the host pointer
> width.
> 
> Use sizeof(*hdr) to match the rest of the function and the actual
> amount that will be copied.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc:stable@vger.kernel.org
> Reported-by: Kai Aizen<kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen<kai.aizen.dev@gmail.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

