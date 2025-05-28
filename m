Return-Path: <stable+bounces-147986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFFCAC6EB0
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB851C005FF
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7328CF41;
	Wed, 28 May 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjSr4hRO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548428C860
	for <stable@vger.kernel.org>; Wed, 28 May 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451884; cv=none; b=WSakwuJFmdb8QGoQtxrgQ5V2XFEgnnbPSc/JA6tycOAQ4j2TojOLaT8VxVtE0EELccdiAVBmn4jbpuoekP4s4u3xYhMitp2WcLdmysgU4LtXqlJ9+1lx/BcHuzeg44K8YzUkczmgyd7jW52VMfrVD39UNLlEw7gygdZFgqxyYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451884; c=relaxed/simple;
	bh=5EtuRLonphyCCnc+QgxsWcjVjIo63t4LM9wqQ2viGwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eihawT2LdOkod6bfx5IKvr+kt/STJQ1oWttEvwtbiOV1EhhsqHxwR9RIeCk+xTYx8WO30yaGDStQclz2zJaBWPixcTEy4OWTRbSJSdUO+Cwhs08uzCOf1jjBsMmJXsqEHqiKztqZpAbDiPOPveQqaVS0C59YaFdd5lj0MUSIsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjSr4hRO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748451882; x=1779987882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5EtuRLonphyCCnc+QgxsWcjVjIo63t4LM9wqQ2viGwk=;
  b=EjSr4hROg2yQJvPJ+NSdJjmiZsozS38YOauBkzeNbHOI3MlG46sujzGk
   QtTx/b5GrvUwBzFarcvxsGu3NtSKePuQ3mC2EPhnh+YXFYdAOm/PF6qak
   C0+qUhYY8VJJ7podDBl5A8jjvVsqJ8YWPT7gV3sBI05/JuJKfE6W93PK4
   RuKiUZ2cJVnEDunWzJ/ZM0JgmTuXxbMHfOGvB2CbbqI1i8DA3yLIDzQuU
   3uRM9K1PHPIU3v3/RBnGH8zYgjeRBebvYrxpX2MuKHzkQMAJvBsBn1DY9
   7dWCemDiYocyaS57dgY4+NRoafPnppA9qgyShyw6kHkbwZIEVw+IGmMjJ
   g==;
X-CSE-ConnectionGUID: oNidO5OLQieFaRJmfcq5SQ==
X-CSE-MsgGUID: IwM64NIiQfqj7fgmWubrEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="49736912"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="49736912"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:04:41 -0700
X-CSE-ConnectionGUID: tKyUjOaZTjiRp1cnt/rs+w==
X-CSE-MsgGUID: 6ejF+RmdRM2Inh925j6rDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="148600786"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO [10.245.252.12]) ([10.245.252.12])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:04:41 -0700
Message-ID: <64bc9a8d-a358-4f96-8721-970a8363961c@linux.intel.com>
Date: Wed, 28 May 2025 19:04:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix warning in ivpu_gem_bo_free()
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, stable@vger.kernel.org
References: <20250528154225.500394-1-jacek.lawrynowicz@linux.intel.com>
 <f2cc768c-3daa-3219-a0e4-703cee8abd78@amd.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <f2cc768c-3daa-3219-a0e4-703cee8abd78@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/28/2025 6:33 PM, Lizhi Hou wrote:
> On 5/28/25 08:42, Jacek Lawrynowicz wrote:
>> Don't WARN if imported buffers are in use in ivpu_gem_bo_free() as they
>> can be indeed used in the original context/driver.
>>
>> Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
>> Cc: <stable@vger.kernel.org> # v6.3
>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_gem.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
>> index 5908268ca45e9..0371a8b4a474f 100644
>> --- a/drivers/accel/ivpu/ivpu_gem.c
>> +++ b/drivers/accel/ivpu/ivpu_gem.c
>> @@ -285,7 +285,8 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
>>       list_del(&bo->bo_list_node);
>>       mutex_unlock(&vdev->bo_list_lock);
>>   -    drm_WARN_ON(&vdev->drm, !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
>> +    drm_WARN_ON(&vdev->drm, !bo->base.base.import_attach &&
>> +            !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
> 
> Probably drm_gem_is_imported()?

Yep, I will send v2.


