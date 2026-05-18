Return-Path: <stable+bounces-249327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGC5GJIwC2plEQUAu9opvQ
	(envelope-from <stable+bounces-249327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:30:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C356FFF3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C7203045E32
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23EF3793BE;
	Mon, 18 May 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Swf6KFu9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79836CDE3;
	Mon, 18 May 2026 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117975; cv=none; b=WauEU3qu0c2KWcsxMMQ7FU720rrv37jk6yYYmWUNX+joweJ4rrFt3aWTImNsqqOxo+gl+ktrCDSKb3w1lMuXQEo2MKXqJ+7/WB0LvvACgrgYRce9WvPCYR9a33aQa4XRvahrRb2TpQOAgeDVVDukqWlh8oAHOQbqz1rVFofaNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117975; c=relaxed/simple;
	bh=QnEgcDMuEmArNzqSjTMlfUOg9mh6NKf8WsVB6cj+vVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYwTr+VOSCi2paNGwoWWBU5m71ohHqR+p92hWN4xcMalvOndnMY3c4NLirvGfPJ9QwEcj6olOC6BZtWHoLle0dUy6FL1j3TYFNlIW0s0oM0oo8cOFH+w6QGTNM/0jCz/7yUO4oPH1cJ7viWrpf7I9qtn0qB2tvS+MnOPHuTTpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Swf6KFu9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779117973; x=1810653973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QnEgcDMuEmArNzqSjTMlfUOg9mh6NKf8WsVB6cj+vVM=;
  b=Swf6KFu9a0vyDcfDoC6AHzT03veF/S5mFFSs6Nl4PjVXwxvfADPHg9hr
   I7dDicpPXTFAH/RCWpBZWNlk9VBiunqqCT5+o8YOu/hYmSrrK13QyOVFo
   MiiOjlzGjTSyWAzUbZ+hSfZsaQUsA05q7N/wxuISbpuoFwxz3samDVBep
   +NzqVDvFA2LhCupsPCc/eKfhj6nq7rkZhaPd+mCY5TVK+8pbsb4SIMbLb
   XvrHZSmuPcYxHHiopFKJaRr5IU4mXTPnCtJhGwqEH6jKRGppHLr2WwpWt
   j8ym7x1vjILrxrB080opqvDtqNw1cR8s8iuUwzLIu7B72vKMrih5a1fhg
   A==;
X-CSE-ConnectionGUID: YW92FD+1SaSyCZkzTNYxUg==
X-CSE-MsgGUID: RwSUg95XR1WhvWFL6x8WPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91077649"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="91077649"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:26:12 -0700
X-CSE-ConnectionGUID: blIO6GNyS7GjePt86FUgmw==
X-CSE-MsgGUID: 3Y8eMW9yQeqZp83OwebVgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="239528845"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.65]) ([10.125.109.65])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 08:26:12 -0700
Message-ID: <bc6da490-a2b0-4381-8659-e6ee50f4cff2@intel.com>
Date: Mon, 18 May 2026 08:26:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fwctl: pds: Validate RPC input size before parsing
To: Heechan Kang <gganji11@naver.com>, Brett Creeley <brett.creeley@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517062232.1858747-1-gganji11@naver.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260517062232.1858747-1-gganji11@naver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249327-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[naver.com,amd.com,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,naver.com:email]
X-Rspamd-Queue-Id: CF4C356FFF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/16/26 11:22 PM, Heechan Kang wrote:
> The fwctl core allocates the device-specific RPC input buffer with
> fwctl_rpc.in_len and passes that buffer to the driver callback.
> 
> pdsfc_fw_rpc() casts the buffer to struct fwctl_rpc_pds and then calls
> pdsfc_validate_rpc(), which reads fields from that structure before
> checking that the input buffer is large enough to contain it. A short
> in_len can make pds_fwctl read beyond the allocation.
> 
> Reject pds RPC buffers that are smaller than struct fwctl_rpc_pds before
> parsing any pds-specific fields.
> 
> Fixes: 92c66ee829b9 ("pds_fwctl: add rpc and query support")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Heechan Kang <gganji11@naver.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/fwctl/pds/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index 08872ee8422f..68fe254dd10a 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -362,6 +362,9 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  	void *out = NULL;
>  	int err;
>  
> +	if (in_len < sizeof(*rpc))
> +		return ERR_PTR(-EINVAL);
> +
>  	err = pdsfc_validate_rpc(pdsfc, rpc, scope);
>  	if (err)
>  		return ERR_PTR(err);


