Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76864704AC9
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 12:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjEPKfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 06:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjEPKf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 06:35:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B684A5B89
        for <stable@vger.kernel.org>; Tue, 16 May 2023 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684233304; x=1715769304;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Q3xihOYSQDL7czm406p3wlVwChQlspeLAyw9yXtpvZk=;
  b=b/l31h2/psB4Pgp4IfkOtqKJIXVaA79g7hMNsqBsalq+yTnPgc4dcqlT
   lIsK6qRz3IDiK1508Ap3UwKzYBCTxCCGfDtW47UWsCYDxz/r0EdJDy66b
   dKz3CBGxVvMZJJvJY6judNOi8gN9Prz6TAHxBDo9cil9aFYDiDAW3M2Al
   Jbxxse0c2BdR81iOKE2b8rTL1tbwCCvhhIvMqEaicJrmPdLG+SJbPrEJh
   ISr3tWFnOitA2VZul505/toHY8G6A00jXCVMXgpj4DuLdzeofXalEDNpM
   bef2NjAh29l/v5E7KeE4xcqerWUUSr6SmrjfEcEdB8wLAHar4sZ7BUzb7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331803717"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331803717"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 03:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="701304605"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="701304605"
Received: from khach-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.69])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 03:34:25 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     lyude@redhat.com, ville.syrjala@linux.intel.com,
        imre.deak@intel.com, harry.wentland@amd.com, jerry.zuo@amd.com,
        Wayne Lin <Wayne.Lin@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/dp_mst: Clear MSG_RDY flag before sending new
 message
In-Reply-To: <20230427072850.100887-1-Wayne.Lin@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230427072850.100887-1-Wayne.Lin@amd.com>
Date:   Tue, 16 May 2023 13:34:22 +0300
Message-ID: <87zg64h8ep.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 27 Apr 2023, Wayne Lin <Wayne.Lin@amd.com> wrote:
> [Why]
> The sequence for collecting down_reply from source perspective should
> be:
>
> Request_n->repeat (get partial reply of Request_n->clear message ready
> flag to ack DPRX that the message is received) till all partial
> replies for Request_n are received->new Request_n+1.
>
> Now there is chance that drm_dp_mst_hpd_irq() will fire new down
> request in the tx queue when the down reply is incomplete. Source is
> restricted to generate interveleaved message transactions so we should
> avoid it.
>
> Also, while assembling partial reply packets, reading out DPCD DOWN_REP
> Sideband MSG buffer + clearing DOWN_REP_MSG_RDY flag should be
> wrapped up as a complete operation for reading out a reply packet.
> Kicking off a new request before clearing DOWN_REP_MSG_RDY flag might
> be risky. e.g. If the reply of the new request has overwritten the
> DPRX DOWN_REP Sideband MSG buffer before source writing one to clear
> DOWN_REP_MSG_RDY flag, source then unintentionally flushes the reply
> for the new request. Should handle the up request in the same way.
>
> [How]
> Separete drm_dp_mst_hpd_irq() into 2 steps. After acking the MST IRQ
> event, driver calls drm_dp_mst_hpd_irq_step2() and might trigger
> drm_dp_mst_kick_tx() only when there is no on going message transaction.
>
> Changes since v1:
> * Reworked on review comments received
> -> Adjust the fix to let driver explicitly kick off new down request
> when mst irq event is handled and acked
> -> Adjust the commit message
>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 35 ++++++++++++++++---
>  drivers/gpu/drm/i915/display/intel_dp.c       |  5 ++-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       |  5 ++-
>  include/drm/display/drm_dp_mst_helper.h       |  4 +--
>  5 files changed, 45 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1ad67c2a697e..48bdcb2ee9b1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3259,10 +3259,9 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
>  		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
>  		/* handle HPD short pulse irq */
>  		if (aconnector->mst_mgr.mst_state)
> -			drm_dp_mst_hpd_irq(
> -				&aconnector->mst_mgr,
> -				esi,
> -				&new_irq_handled);
> +			drm_dp_mst_hpd_irq_step1(&aconnector->mst_mgr,
> +						 esi,
> +						 &new_irq_handled);
>  
>  		if (new_irq_handled) {
>  			/* ACK at DPCD to notify down stream */
> @@ -3281,6 +3280,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
>  					break;
>  			}
>  
> +			drm_dp_mst_hpd_irq_step2(&aconnector->mst_mgr);
>  			/* check if there is new irq to be handled */
>  			dret = drm_dp_dpcd_read(
>  				&aconnector->dm_dp_aux.aux,
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 70df29fe92db..2e0a38a6509c 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4045,7 +4045,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>  }
>  
>  /**
> - * drm_dp_mst_hpd_irq() - MST hotplug IRQ notify
> + * drm_dp_mst_hpd_irq_step1() - MST hotplug IRQ notify
>   * @mgr: manager to notify irq for.
>   * @esi: 4 bytes from SINK_COUNT_ESI
>   * @handled: whether the hpd interrupt was consumed or not
> @@ -4055,7 +4055,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>   * topology manager will process the sideband messages received as a result
>   * of this.
>   */
> -int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled)
> +int drm_dp_mst_hpd_irq_step1(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled)

If you're changing the signature of the function, I'd make esi "const u8
*esi", and add a separate "u8 *ack" that you have to provide, where this
function would |= the flags to ack. It would be useful at least in i915.

As to naming, _step1 and _step2 are pretty vague.

>  {
>  	int ret = 0;
>  	int sc;
> @@ -4077,11 +4077,38 @@ int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handl
>  		*handled = true;
>  	}
>  
> -	drm_dp_mst_kick_tx(mgr);
>  	return ret;
>  }
> -EXPORT_SYMBOL(drm_dp_mst_hpd_irq);
> +EXPORT_SYMBOL(drm_dp_mst_hpd_irq_step1);
> +
> +/**
> + * drm_dp_mst_hpd_irq_step2() - MST hotplug IRQ 2nd part handling
> + * @mgr: manager to notify irq for.
> + *
> + * This should be called from the driver when mst irq event is handled
> + * and acked. Note that new down request should only be sent when
> + * previous message transaction is done. Source is not supposed to generate
> + * interleaved message transactions.
> + */
> +void drm_dp_mst_hpd_irq_step2(struct drm_dp_mst_topology_mgr *mgr)

_done, _finish, _complete?

> +{
> +	struct drm_dp_sideband_msg_tx *txmsg;
> +	bool skip = false;
>  
> +	mutex_lock(&mgr->qlock);
> +	txmsg = list_first_entry_or_null(&mgr->tx_msg_downq,
> +					 struct drm_dp_sideband_msg_tx, next);
> +	/* If last transaction is not completed yet*/
> +	if (!txmsg ||
> +	    txmsg->state == DRM_DP_SIDEBAND_TX_START_SEND ||
> +	    txmsg->state == DRM_DP_SIDEBAND_TX_SENT)
> +		skip = true;
> +	mutex_unlock(&mgr->qlock);
> +
> +	if (!skip)

Please avoid negatives like this. You could have bool kick = true instead.

> +		drm_dp_mst_kick_tx(mgr);
> +}
> +EXPORT_SYMBOL(drm_dp_mst_hpd_irq_step2);
>  /**
>   * drm_dp_mst_detect_port() - get connection status for an MST port
>   * @connector: DRM connector for this port
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 75070eb07d4b..9a9a5aec9534 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3803,7 +3803,7 @@ intel_dp_mst_hpd_irq(struct intel_dp *intel_dp, u8 *esi, u8 *ack)
>  {
>  	bool handled = false;
>  
> -	drm_dp_mst_hpd_irq(&intel_dp->mst_mgr, esi, &handled);
> +	drm_dp_mst_hpd_irq_step1(&intel_dp->mst_mgr, esi, &handled);
>  	if (handled)
>  		ack[1] |= esi[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
>  
> @@ -3880,6 +3880,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
>  
>  		if (!intel_dp_ack_sink_irq_esi(intel_dp, ack))
>  			drm_dbg_kms(&i915->drm, "Failed to ack ESI\n");
> +
> +		if (ack[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY))
> +			drm_dp_mst_hpd_irq_step2(&intel_dp->mst_mgr);

I'm getting confused about the division of responsibilities between the
two functions to be called, and the caller. Why does i915 do things
differently from nouveau and amd wrt this?

>  	}
>  
>  	return link_ok;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index ed9d374147b8..00c36fcc8afd 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1332,12 +1332,15 @@ nv50_mstm_service(struct nouveau_drm *drm,
>  			break;
>  		}
>  
> -		drm_dp_mst_hpd_irq(&mstm->mgr, esi, &handled);
> +		drm_dp_mst_hpd_irq_step1(&mstm->mgr, esi, &handled);
>  		if (!handled)
>  			break;
>  
>  		rc = drm_dp_dpcd_write(aux, DP_SINK_COUNT_ESI + 1, &esi[1],
>  				       3);
> +
> +		drm_dp_mst_hpd_irq_step2(&mstm->mgr);
> +

Don't you think the return value should be checked first?

>  		if (rc != 3) {
>  			ret = false;
>  			break;
> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> index 32c764fb9cb5..6c08ba765d5a 100644
> --- a/include/drm/display/drm_dp_mst_helper.h
> +++ b/include/drm/display/drm_dp_mst_helper.h
> @@ -815,8 +815,8 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr);
>  bool drm_dp_read_mst_cap(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
>  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state);
>  
> -int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled);
> -
> +int drm_dp_mst_hpd_irq_step1(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled);
> +void drm_dp_mst_hpd_irq_step2(struct drm_dp_mst_topology_mgr *mgr);
>  
>  int
>  drm_dp_mst_detect_port(struct drm_connector *connector,

-- 
Jani Nikula, Intel Open Source Graphics Center
