Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0675C350
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGUJnm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjGUJnd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 05:43:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C53A8D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932585; x=1721468585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tLgPEKbGd/u9qGyj2ikmC1YzDAKb/Vg9Ks4lSvrugXQ=;
  b=SeehdNNJ5Ij6wSOp1lQFUmqF5ZDofnYIWu9PqqvvaHZ82IYYM6B7wf0D
   VYfU/Ud5QgDLp0EoG9SG/34SQC7stv0V5Wn6P4gobc1yFw+6qbGlEjQfK
   rkE6gjh+/94e6vnDhTntFXJfNWtuH77n1RWJfwSglT79ouLNXHFcq/IgU
   f2TsgDp1g4Qt/a/QL2d7ojh6vkl3LkX7JO90d5ibEUZfQMvCXxGbS05sg
   I1MBQ8UxB7XeIoXynBNVakJ1YWivd14VUMMsO4Zhn2Jj0V3AdtgTeHfdv
   CCn1wyhGMqIrj7ON817ocZYE44N26YFVBDhjTxrh7+KTNcQfk8zkgiOD8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369656237"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="369656237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868187023"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.21.56]) ([10.213.21.56])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:41:25 -0700
Message-ID: <26ccff3c-b50a-e6e6-97d1-18bb40833108@intel.com>
Date:   Fri, 21 Jul 2023 11:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [Intel-gfx] [PATCH v7 2/9] drm/i915: Add the has_aux_ccs device
 property
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
References: <20230720210737.761400-1-andi.shyti@linux.intel.com>
 <20230720210737.761400-3-andi.shyti@linux.intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230720210737.761400-3-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 20.07.2023 23:07, Andi Shyti wrote:
> We always assumed that a device might either have AUX or FLAT
> CCS, but this is an approximation that is not always true as it
> requires some further per device checks.
> 
> Add the "has_aux_ccs" flag in the intel_device_info structure in
> order to have a per device flag indicating of the AUX CCS.

As Matt mentioned in v6, aux_ccs is present also in older platforms.
This is about presence/necessity (?) of aux_ccs table invalidation.
Maybe has_aux_ccs_inv, dunno?

Moreover you define flag per device, but this is rather per engine, 
theoretically could be also:
MTL:
.aux_ccs_inv_mask = BIT(RCS0) | BIT(BCS0) | ...
Others:
.aux_ccs_inv_mask = BIT(RCS0) | ...

looks overkill,
maybe helper function would be simpler, up to you.

Regards
Andrzej

> 
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: <stable@vger.kernel.org> # v5.8+
> ---
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 4 ++--
>   drivers/gpu/drm/i915/i915_drv.h          | 1 +
>   drivers/gpu/drm/i915/i915_pci.c          | 5 ++++-
>   drivers/gpu/drm/i915/intel_device_info.h | 1 +
>   4 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> index 563efee055602..0d4d5e0407a2d 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> @@ -267,7 +267,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   		else if (engine->class == COMPUTE_CLASS)
>   			flags &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
>   
> -		if (!HAS_FLAT_CCS(rq->engine->i915))
> +		if (HAS_AUX_CCS(rq->engine->i915))
>   			count = 8 + 4;
>   		else
>   			count = 8;
> @@ -307,7 +307,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
>   	if (mode & EMIT_INVALIDATE) {
>   		cmd += 2;
>   
> -		if (!HAS_FLAT_CCS(rq->engine->i915) &&
> +		if (HAS_AUX_CCS(rq->engine->i915) &&
>   		    (rq->engine->class == VIDEO_DECODE_CLASS ||
>   		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
>   			aux_inv = rq->engine->mask &
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 682ef2b5c7d59..e9cc048b5727a 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -848,6 +848,7 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
>    * stored in lmem to support the 3D and media compression formats.
>    */
>   #define HAS_FLAT_CCS(i915)   (INTEL_INFO(i915)->has_flat_ccs)
> +#define HAS_AUX_CCS(i915)    (INTEL_INFO(i915)->has_aux_ccs)
>   
>   #define HAS_GT_UC(i915)	(INTEL_INFO(i915)->has_gt_uc)
>   
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index fcacdc21643cf..c9ff1d11a9fce 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -643,7 +643,8 @@ static const struct intel_device_info jsl_info = {
>   	TGL_CACHELEVEL, \
>   	.has_global_mocs = 1, \
>   	.has_pxp = 1, \
> -	.max_pat_index = 3
> +	.max_pat_index = 3, \
> +	.has_aux_ccs = 1
>   
>   static const struct intel_device_info tgl_info = {
>   	GEN12_FEATURES,
> @@ -775,6 +776,7 @@ static const struct intel_device_info dg2_info = {
>   
>   static const struct intel_device_info ats_m_info = {
>   	DG2_FEATURES,
> +	.has_aux_ccs = 1,
>   	.require_force_probe = 1,
>   	.tuning_thread_rr_after_dep = 1,
>   };
> @@ -827,6 +829,7 @@ static const struct intel_device_info mtl_info = {
>   	.__runtime.media.ip.ver = 13,
>   	PLATFORM(INTEL_METEORLAKE),
>   	.extra_gt_list = xelpmp_extra_gt,
> +	.has_aux_ccs = 1,
>   	.has_flat_ccs = 0,
>   	.has_gmd_id = 1,
>   	.has_guc_deprivilege = 1,
> diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
> index dbfe6443457b5..93485507506cc 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.h
> +++ b/drivers/gpu/drm/i915/intel_device_info.h
> @@ -151,6 +151,7 @@ enum intel_ppgtt_type {
>   	func(has_reset_engine); \
>   	func(has_3d_pipeline); \
>   	func(has_4tile); \
> +	func(has_aux_ccs); \
>   	func(has_flat_ccs); \
>   	func(has_global_mocs); \
>   	func(has_gmd_id); \

