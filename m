Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D95F6F3EDC
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjEBIMp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjEBIMm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 04:12:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB149FC
        for <stable@vger.kernel.org>; Tue,  2 May 2023 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683015161; x=1714551161;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=aRI90Oy+HqlK84Xuqr7+48kIlZ9I7LkLkQI16YjvfpU=;
  b=iHMn81zIsEhL+wjmqqMFlFFTYkYICf+Yllh18xUL4Ign7huzT4WssNbr
   1N4Prz/wEKGxDNRc+7tFmCphWiJ4Ovp5BQddY22JidhZgkjFIKjyEKlva
   mdSTUriGIDavCoPqjVdwgsS9M5Bpf5/160Lv8XGtyEUyb66QmyzWJeEUP
   manaWnoJW0nowJAIfVyVFZ2TQg1ErFSyDqSFP/NLgNw9WljF8LJ3Ew9iy
   zZ19tMAIW9pmF9Gjgb+TtWHJ66AqN1hm7/iop+hWyyhnNiCV9X2E2sVnQ
   KD5Ra6vfU+9lQ8ysX81sNHUXzw7l52SFAknoVDSexoiMGznY03xG2pHJ1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="411472087"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="411472087"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 01:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="1025966257"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="1025966257"
Received: from xinpan-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.163])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 01:12:38 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
        dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/dsc: fix
 drm_edp_dsc_sink_output_bpp() DPCD high byte usage
In-Reply-To: <c2617e8c-c2d5-0b86-b400-570d3f808454@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230406134615.1422509-1-jani.nikula@intel.com>
 <c2617e8c-c2d5-0b86-b400-570d3f808454@intel.com>
Date:   Tue, 02 May 2023 11:12:36 +0300
Message-ID: <871qjz2lu3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 20 Apr 2023, "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com> wrote:
> LGTM.
>
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

Thanks for the reviews, pushed these a week+ ago.

BR,
Jani.


>
> On 4/6/2023 7:16 PM, Jani Nikula wrote:
>> The operator precedence between << and & is wrong, leading to the high
>> byte being completely ignored. For example, with the 6.4 format, 32
>> becomes 0 and 24 becomes 8. Fix it, and remove the slightly confusing
>> and unnecessary DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT macro while at it.
>>
>> Fixes: 0575650077ea ("drm/dp: DRM DP helper/macros to get DP sink DSC parameters")
>> Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
>> Cc: Manasi Navare <navaremanasi@google.com>
>> Cc: Anusha Srivatsa <anusha.srivatsa@intel.com>
>> Cc: <stable@vger.kernel.org> # v5.0+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>   include/drm/display/drm_dp.h        | 1 -
>>   include/drm/display/drm_dp_helper.h | 5 ++---
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
>> index 358db4a9f167..89d5a700b04d 100644
>> --- a/include/drm/display/drm_dp.h
>> +++ b/include/drm/display/drm_dp.h
>> @@ -286,7 +286,6 @@
>>   
>>   #define DP_DSC_MAX_BITS_PER_PIXEL_HI        0x068   /* eDP 1.4 */
>>   # define DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK  (0x3 << 0)
>> -# define DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT 8
>>   # define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  0x06
>>   # define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  0x08
>>   
>> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
>> index 533d3ee7fe05..86f24a759268 100644
>> --- a/include/drm/display/drm_dp_helper.h
>> +++ b/include/drm/display/drm_dp_helper.h
>> @@ -181,9 +181,8 @@ static inline u16
>>   drm_edp_dsc_sink_output_bpp(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
>>   {
>>   	return dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_LOW - DP_DSC_SUPPORT] |
>> -		(dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
>> -		 DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK <<
>> -		 DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT);
>> +		((dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
>> +		  DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK) << 8);
>>   }
>>   
>>   static inline u32

-- 
Jani Nikula, Intel Open Source Graphics Center
