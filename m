Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B137A5EDF
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 11:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjISJ4m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjISJ4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 05:56:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFC2D54
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695117308; x=1726653308;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=VE2rjU6vKS7B5FcRe/RnrC2e6YXvyOnWP8lQUDgIgR0=;
  b=ae6gRg/qfWALCNqW4AXHb7HAr4zFOCe3rD1lYHJIjOcvxuR64OIK8lA4
   V+2M299gnLQ7Hu6GM9lC/TqNqmNdYaR/LVrpYPTveJKXz05DKMEwkfF82
   TB0PF+VyGjB+uqlMQY80vjCRiFTt72cKgze3iRgu9jSBdAoucVrQJdaKq
   rArEf4rIFo2YzuF4Y3dA+jmO+d3ihpRuA2LW8UCs4kTfTmmTF5wY7Ip3S
   dOpyClZcmu3VSA2UwVVEj9kAzS+E9p0R5CMniigvUujJcV7Ki+NGOtQP7
   JrzEigSC8caM4+8bqj9WcNGRFkHdNDjLs5ZT98WepBdnwi+7ReC+USl7l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382651756"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="382651756"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="695850188"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="695850188"
Received: from tjquresh-mobl.ger.corp.intel.com (HELO localhost) ([10.252.37.227])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:55:00 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/meson: fix memory leak on ->hpd_notify callback
In-Reply-To: <a4b4432b-fdde-4922-8d95-3697807eefdb@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230914131015.2472029-1-jani.nikula@intel.com>
 <a4b4432b-fdde-4922-8d95-3697807eefdb@linaro.org>
Date:   Tue, 19 Sep 2023 12:54:58 +0300
Message-ID: <87msxitrm5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 15 Sep 2023, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> On 14/09/2023 15:10, Jani Nikula wrote:
>> The EDID returned by drm_bridge_get_edid() needs to be freed.
>> 
>> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: Jerome Brunet <jbrunet@baylibre.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-amlogic@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: <stable@vger.kernel.org> # v5.17+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> 
>> ---
>> 
>> UNTESTED
>> ---
>>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>> index 9913971fa5d2..25ea76558690 100644
>> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
>> @@ -334,6 +334,8 @@ static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
>>   			return;
>>   
>>   		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
>> +
>> +		kfree(edid);
>>   	} else
>>   		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
>>   }
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks. I don't seem to have a toolchain to get this to build... would
you mind applying this, please?

BR,
Jani.


-- 
Jani Nikula, Intel
