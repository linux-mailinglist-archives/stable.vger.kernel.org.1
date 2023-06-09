Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BB7293EB
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjFIIze (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 04:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbjFIIyO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 04:54:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753830E3
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686300822; x=1717836822;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=T11vZfsBg9+4G9OSNHQ+OPyp9PW8VEExnz5/IWZIgP0=;
  b=O+/u7GsOVJcLyUrb+BE4NFqckjUu5pXlUXaP5OKurmOe73ohLLQkcGNh
   xw0gCHNG+YSYf26K8evyjfYUnyB/+aCdWTumgO/THqlYvsX7runzAnrD3
   9NvjFlEnpzP4RqVSDD3kh9zPVjyLaJfyk2ZgnEpgTfCnNVGgIMEWU+nxX
   C8dCqQscMYvbgbCU+HxGfmlkql2f0VuwO+qrnCuMa7I3A3a4GnaFCJdEV
   IVotrL74aQrWyk9cSeFXq0r3C90MwwzY0riTmH8QdbUw9f4B7TPNXhXZa
   gkctma1jOAZTkf8UzbuYXt8NEgbv01m+PEYGp2d7TE+mDFSZm9bTSWwDb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385910288"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="385910288"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="800152172"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="800152172"
Received: from skolhe-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.254])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:53:22 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     "Lin, Wayne" <Wayne.Lin@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc:     "lyude@redhat.com" <lyude@redhat.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "imre.deak@intel.com" <imre.deak@intel.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v4] drm/dp_mst: Clear MSG_RDY flag before sending new
 message
In-Reply-To: <CO6PR12MB548948F83852B367F228F9A9FC51A@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230608114316.3078024-1-Wayne.Lin@amd.com>
 <87a5xarvh9.fsf@intel.com>
 <CO6PR12MB548948F83852B367F228F9A9FC51A@CO6PR12MB5489.namprd12.prod.outlook.com>
Date:   Fri, 09 Jun 2023 11:53:17 +0300
Message-ID: <871qilrp8i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

>> > bool *handled)
>> > +int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr
>> *mgr, const u8 *esi,
>> > +                               u8 *ack, bool *handled)
>> >  {
>> >     int ret = 0;
>> >     int sc;
>> > @@ -4078,18 +4089,47 @@ int drm_dp_mst_hpd_irq(struct
>> drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handl
>> >     if (esi[1] & DP_DOWN_REP_MSG_RDY) {
>> >             ret = drm_dp_mst_handle_down_rep(mgr);
>> >             *handled = true;
>> > +           *ack |= DP_DOWN_REP_MSG_RDY;
>>
>> My idea was that esi and ack would be the same size buffers, so the caller
>> wouldn't have to worry where exactly to point ack to.
>>
>> I think the asymmetry here is misleading, with ack and esi having to point at
>> different locations.
>>
> Thanks, Jani.
>
> But Event status Indicator Files (DPCD 0x2000h ~ 0x21FFH) are not all designed
> to be ack clear, e.g. esi[0] here. My thought is to be precise about what is handled
> and what is going to be ack clear. Otherwise, write ack[0] to DPCD 0x2002h is
> not reasonable.

The point is that you have the same indexes everywhere, even if ack[0]
ends up being unused.

Handle esi[1] & DP_DOWN_REP_MSG_RDY, set ack[1] |= DP_DOWN_REP_MSG_RDY.

Similar pattern everywhere, drm core and drivers. The only place that
needs to know the difference is where the ack is written back to DPCD.

If we end up adding more helpers for drm core handling ESI, we'll keep
repeating the same pattern, instead of passing individual u8 acks
everywhere, with the driver having to figure out what pointers to pass.

BR,
Jani.




-- 
Jani Nikula, Intel Open Source Graphics Center
