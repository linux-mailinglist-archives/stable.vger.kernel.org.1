Return-Path: <stable+bounces-139128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570DEAA47B4
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6D19A8639
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853723184F;
	Wed, 30 Apr 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUUPXN9t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685F23814C
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746006875; cv=none; b=mNT+yA/7LzV2xdtpNJDOcG1tvNPaCMagbs6JclS3cYAY79oye1QtgKbPUpPy1lFURYUesyQokGwPXXhHV25zXlBIWMZRRXzP/HIHnufWC4QG1pf5JNHZa7e6kK+oxvUfjkrVuAMxDHrUm7NGUKMCvxz0TRKxOC99akRnYxaYteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746006875; c=relaxed/simple;
	bh=6umE8nJIoeN1hhn9w2TznwDr+dr/IG9JvoRgZNKDnrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfiorJH6zY4BQ5Qbu3xFLfVDIeBrTzyNlTa72mAtGuodE6x3xyf2i/PdGWEk+UMe2Q3rVKHSo0ZLxWZT6WGeHHi8euUZuQQnkdadiPCac+WMBvfwn6wc23OW/7/Gtu8H6a+oUgiQS5TdU8MYa2c2CSf6PAm0ChLxQ+j/CGbH4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUUPXN9t; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746006873; x=1777542873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6umE8nJIoeN1hhn9w2TznwDr+dr/IG9JvoRgZNKDnrU=;
  b=RUUPXN9tIVSKqEywFUI+5GplSQSHTSQ4Gli9WzuJfE9IIi9L9vEagNP2
   xb/kgmM4zj3ImfYBOmT+lbB+BSXqf4jemNsPF/nNtipqYYJtQX1v9iEym
   NHvON4pH8TqISnzqjJup8A3yzhn9vgSWH9kqFVlBBJ7/95HOtA6U05ny8
   7ndKqkD8vUSBIHBX0r72TGGZ7a0pQweGBGyb4AxA/oZUOXVGuyjULJ8Bl
   f1C+oPTr9Pm4twBmh6M74etH5J9kZ0LSxqZSS04cEa68O5VjoIDlYf8zO
   v5QvWO27HeCZoGEUSb8+Svjl5yhobvwl8F4SloAJ1gpzjzpI79Gc0BfTk
   Q==;
X-CSE-ConnectionGUID: ryY9X+hIQ0OChl79mInBoQ==
X-CSE-MsgGUID: +YNQL0O6Qby5Ldp9/HKwzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46776423"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="46776423"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 02:54:30 -0700
X-CSE-ConnectionGUID: JbUoR+aCSvCuJyw+CJnqWw==
X-CSE-MsgGUID: OzwhMOAjTs+6M/5bq7WR7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134594096"
Received: from dmatouse-mobl1.ger.corp.intel.com (HELO [10.245.252.148]) ([10.245.252.148])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 02:54:29 -0700
Message-ID: <07c8be10-3454-42db-b787-99a764520924@linux.intel.com>
Date: Wed, 30 Apr 2025 11:54:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Increase state dump msg timeout
To: dri-devel@lists.freedesktop.org
Cc: quic_jhugo@quicinc.com, lizhi.hou@amd.com, stable@vger.kernel.org
References: <20250425092822.2194465-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250425092822.2194465-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-fixes

On 4/25/2025 11:28 AM, Jacek Lawrynowicz wrote:
> Increase JMS message state dump command timeout to 100 ms. On some
> platforms, the FW may take a bit longer than 50 ms to dump its state
> to the log buffer and we don't want to miss any debug info during TDR.
> 
> Fixes: 5e162f872d7a ("accel/ivpu: Add FW state dump on TDR")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index ec9a3629da3a9..633160470c939 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -119,7 +119,7 @@ static void timeouts_init(struct ivpu_device *vdev)
>  		else
>  			vdev->timeout.autosuspend = 100;
>  		vdev->timeout.d0i3_entry_msg = 5;
> -		vdev->timeout.state_dump_msg = 10;
> +		vdev->timeout.state_dump_msg = 100;
>  	}
>  }
>  


