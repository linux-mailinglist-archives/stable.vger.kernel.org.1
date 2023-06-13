Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6272EFFD
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjFMXXp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbjFMXXf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 19:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDA19B7
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686698564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGLPbtaO6/FMLJ93VwoP9QzoKQHeRUYwNndHsqox87g=;
        b=C+AfWPw9xQYH/gSO2RONa7SpBaGCnYg4H7kpG3/oPue+4Mi8yB5oq9QNRbBGdLwY+FzYLS
        MT33ag+V0u+kgZxOhePBOJiFFPAxyue6HLuDKHpZPr/9z8UnelcIoT4NEQxLlmIuFxwef4
        XoFodzukGYR8TCQsHyF7NZ++Mp/3qDI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-hcrwIQ9tM7CSMsQjBJavdg-1; Tue, 13 Jun 2023 19:22:41 -0400
X-MC-Unique: hcrwIQ9tM7CSMsQjBJavdg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62de89f4695so17787886d6.3
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 16:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686698560; x=1689290560;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGLPbtaO6/FMLJ93VwoP9QzoKQHeRUYwNndHsqox87g=;
        b=kwzpZw8xg0r/pcaiLLfJE0MIf8lAI9D7JkYIg/SyS9dyv8FvVopOAkjLmVhADmud3J
         UX/yz9udckXXztKmNOUw4uctG/jDIoPCcfesHPMctb+eZTj471nqw+69mHzN/YN/lBvE
         +6wgd6LLNfOej48EXDXsqtKjFFR/KyvdxVQh+njHILHJtwZu9NFHRUimH9Y1GBXVnZNk
         gP9na/i9zhEl2rir7lWXOjubGI7rPC7sGPe9sWLhQxiPvCLOvMdYz39WLMWTICvcNZlQ
         Oagm/xytRd4GLVOeCh9pN3EuKF2AjVnU6hvvwdXbrp459owfdwbkDAc6eu5HdW6JMo46
         gVbA==
X-Gm-Message-State: AC+VfDxcs+2YiHVj744BKRQK+8lVdd7q+zlO2d/8IMqHEav1KnpZgoxz
        6E/r1+lDuKriax4L6oOdO5UepQppUwHk9Uc/yRDKTT4xEQYJzECqEDAK1r39eOn8NUDxO2SWnUH
        XO7DrxkPXC5XepJMf
X-Received: by 2002:a05:6214:20eb:b0:626:2f1b:b427 with SMTP id 11-20020a05621420eb00b006262f1bb427mr14220918qvk.10.1686698560375;
        Tue, 13 Jun 2023 16:22:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MEFTRUzOC69Jgj5XMoNd54D49R+ddJOlqiXaonMYnbmso4nM9+sjWsYuKVw4fjOnMcZrTOg==
X-Received: by 2002:a05:6214:20eb:b0:626:2f1b:b427 with SMTP id 11-20020a05621420eb00b006262f1bb427mr14220901qvk.10.1686698560090;
        Tue, 13 Jun 2023 16:22:40 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id mg9-20020a056214560900b006260e4b6de9sm4285720qvb.118.2023.06.13.16.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:22:39 -0700 (PDT)
Message-ID: <8e8cdc519429cbd0cefad60386a2548f0c96a5c1.camel@redhat.com>
Subject: Re: [PATCH v5] drm/dp_mst: Clear MSG_RDY flag before sending new
 message
From:   Lyude Paul <lyude@redhat.com>
To:     Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     ville.syrjala@linux.intel.com, jani.nikula@intel.com,
        imre.deak@intel.com, harry.wentland@amd.com, jerry.zuo@amd.com,
        stable@vger.kernel.org
Date:   Tue, 13 Jun 2023 19:22:37 -0400
In-Reply-To: <20230609104925.3736756-1-Wayne.Lin@amd.com>
References: <20230609104925.3736756-1-Wayne.Lin@amd.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Alright, managed to figure out my MST woes! Just tested with nouveau and I =
see
no regressions :)

Reviewed-by: Lyude Paul <lyude@redhat.com>


On Fri, 2023-06-09 at 18:49 +0800, Wayne Lin wrote:
> [Why]
> The sequence for collecting down_reply from source perspective should
> be:
>=20
> Request_n->repeat (get partial reply of Request_n->clear message ready
> flag to ack DPRX that the message is received) till all partial
> replies for Request_n are received->new Request_n+1.
>=20
> Now there is chance that drm_dp_mst_hpd_irq() will fire new down
> request in the tx queue when the down reply is incomplete. Source is
> restricted to generate interveleaved message transactions so we should
> avoid it.
>=20
> Also, while assembling partial reply packets, reading out DPCD DOWN_REP
> Sideband MSG buffer + clearing DOWN_REP_MSG_RDY flag should be
> wrapped up as a complete operation for reading out a reply packet.
> Kicking off a new request before clearing DOWN_REP_MSG_RDY flag might
> be risky. e.g. If the reply of the new request has overwritten the
> DPRX DOWN_REP Sideband MSG buffer before source writing one to clear
> DOWN_REP_MSG_RDY flag, source then unintentionally flushes the reply
> for the new request. Should handle the up request in the same way.
>=20
> [How]
> Separete drm_dp_mst_hpd_irq() into 2 steps. After acking the MST IRQ
> event, driver calls drm_dp_mst_hpd_irq_send_new_request() and might
> trigger drm_dp_mst_kick_tx() only when there is no on going message
> transaction.
>=20
> Changes since v1:
> * Reworked on review comments received
> -> Adjust the fix to let driver explicitly kick off new down request
> when mst irq event is handled and acked
> -> Adjust the commit message
>=20
> Changes since v2:
> * Adjust the commit message
> * Adjust the naming of the divided 2 functions and add a new input
>   parameter "ack".
> * Adjust code flow as per review comments.
>=20
> Changes since v3:
> * Update the function description of drm_dp_mst_hpd_irq_handle_event
>=20
> Changes since v4:
> * Change ack of drm_dp_mst_hpd_irq_handle_event() to be an array align
>   the size of esi[]
>=20
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++------
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 54 ++++++++++++++++---
>  drivers/gpu/drm/i915/display/intel_dp.c       |  7 +--
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       | 12 +++--
>  include/drm/display/drm_dp_mst_helper.h       |  7 ++-
>  5 files changed, 81 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d5cec03eaa8d..ec629b4037e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3263,6 +3263,7 @@ static void dm_handle_mst_sideband_msg(struct amdgp=
u_dm_connector *aconnector)
> =20
>  	while (dret =3D=3D dpcd_bytes_to_read &&
>  		process_count < max_process_count) {
> +		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] =3D {};
>  		u8 retry;
>  		dret =3D 0;
> =20
> @@ -3271,28 +3272,29 @@ static void dm_handle_mst_sideband_msg(struct amd=
gpu_dm_connector *aconnector)
>  		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
>  		/* handle HPD short pulse irq */
>  		if (aconnector->mst_mgr.mst_state)
> -			drm_dp_mst_hpd_irq(
> -				&aconnector->mst_mgr,
> -				esi,
> -				&new_irq_handled);
> +			drm_dp_mst_hpd_irq_handle_event(&aconnector->mst_mgr,
> +							esi,
> +							ack,
> +							&new_irq_handled);
> =20
>  		if (new_irq_handled) {
>  			/* ACK at DPCD to notify down stream */
> -			const int ack_dpcd_bytes_to_write =3D
> -				dpcd_bytes_to_read - 1;
> -
>  			for (retry =3D 0; retry < 3; retry++) {
> -				u8 wret;
> -
> -				wret =3D drm_dp_dpcd_write(
> -					&aconnector->dm_dp_aux.aux,
> -					dpcd_addr + 1,
> -					&esi[1],
> -					ack_dpcd_bytes_to_write);
> -				if (wret =3D=3D ack_dpcd_bytes_to_write)
> +				ssize_t wret;
> +
> +				wret =3D drm_dp_dpcd_writeb(&aconnector->dm_dp_aux.aux,
> +							  dpcd_addr + 1,
> +							  ack[1]);
> +				if (wret =3D=3D 1)
>  					break;
>  			}
> =20
> +			if (retry =3D=3D 3) {
> +				DRM_ERROR("Failed to ack MST event.\n");
> +				return;
> +			}
> +
> +			drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
>  			/* check if there is new irq to be handled */
>  			dret =3D drm_dp_dpcd_read(
>  				&aconnector->dm_dp_aux.aux,
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 38dab76ae69e..487d057a9582 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4053,17 +4053,28 @@ static int drm_dp_mst_handle_up_req(struct drm_dp=
_mst_topology_mgr *mgr)
>  }
> =20
>  /**
> - * drm_dp_mst_hpd_irq() - MST hotplug IRQ notify
> + * drm_dp_mst_hpd_irq_handle_event() - MST hotplug IRQ handle MST event
>   * @mgr: manager to notify irq for.
>   * @esi: 4 bytes from SINK_COUNT_ESI
> + * @ack: 4 bytes used to ack events starting from SINK_COUNT_ESI
>   * @handled: whether the hpd interrupt was consumed or not
>   *
> - * This should be called from the driver when it detects a short IRQ,
> + * This should be called from the driver when it detects a HPD IRQ,
>   * along with the value of the DEVICE_SERVICE_IRQ_VECTOR_ESI0. The
> - * topology manager will process the sideband messages received as a res=
ult
> - * of this.
> + * topology manager will process the sideband messages received
> + * as indicated in the DEVICE_SERVICE_IRQ_VECTOR_ESI0 and set the
> + * corresponding flags that Driver has to ack the DP receiver later.
> + *
> + * Note that driver shall also call
> + * drm_dp_mst_hpd_irq_send_new_request() if the 'handled' is set
> + * after calling this function, to try to kick off a new request in
> + * the queue if the previous message transaction is completed.
> + *
> + * See also:
> + * drm_dp_mst_hpd_irq_send_new_request()
>   */
> -int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, boo=
l *handled)
> +int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr,=
 const u8 *esi,
> +				    u8 *ack, bool *handled)
>  {
>  	int ret =3D 0;
>  	int sc;
> @@ -4078,18 +4089,47 @@ int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology=
_mgr *mgr, u8 *esi, bool *handl
>  	if (esi[1] & DP_DOWN_REP_MSG_RDY) {
>  		ret =3D drm_dp_mst_handle_down_rep(mgr);
>  		*handled =3D true;
> +		ack[1] |=3D DP_DOWN_REP_MSG_RDY;
>  	}
> =20
>  	if (esi[1] & DP_UP_REQ_MSG_RDY) {
>  		ret |=3D drm_dp_mst_handle_up_req(mgr);
>  		*handled =3D true;
> +		ack[1] |=3D DP_UP_REQ_MSG_RDY;
>  	}
> =20
> -	drm_dp_mst_kick_tx(mgr);
>  	return ret;
>  }
> -EXPORT_SYMBOL(drm_dp_mst_hpd_irq);
> +EXPORT_SYMBOL(drm_dp_mst_hpd_irq_handle_event);
> =20
> +/**
> + * drm_dp_mst_hpd_irq_send_new_request() - MST hotplug IRQ kick off new =
request
> + * @mgr: manager to notify irq for.
> + *
> + * This should be called from the driver when mst irq event is handled
> + * and acked. Note that new down request should only be sent when
> + * previous message transaction is completed. Source is not supposed to =
generate
> + * interleaved message transactions.
> + */
> +void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr =
*mgr)
> +{
> +	struct drm_dp_sideband_msg_tx *txmsg;
> +	bool kick =3D true;
> +
> +	mutex_lock(&mgr->qlock);
> +	txmsg =3D list_first_entry_or_null(&mgr->tx_msg_downq,
> +					 struct drm_dp_sideband_msg_tx, next);
> +	/* If last transaction is not completed yet*/
> +	if (!txmsg ||
> +	    txmsg->state =3D=3D DRM_DP_SIDEBAND_TX_START_SEND ||
> +	    txmsg->state =3D=3D DRM_DP_SIDEBAND_TX_SENT)
> +		kick =3D false;
> +	mutex_unlock(&mgr->qlock);
> +
> +	if (kick)
> +		drm_dp_mst_kick_tx(mgr);
> +}
> +EXPORT_SYMBOL(drm_dp_mst_hpd_irq_send_new_request);
>  /**
>   * drm_dp_mst_detect_port() - get connection status for an MST port
>   * @connector: DRM connector for this port
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 4bec8cd7979f..f4a2e72a5c20 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4062,9 +4062,7 @@ intel_dp_mst_hpd_irq(struct intel_dp *intel_dp, u8 =
*esi, u8 *ack)
>  {
>  	bool handled =3D false;
> =20
> -	drm_dp_mst_hpd_irq(&intel_dp->mst_mgr, esi, &handled);
> -	if (handled)
> -		ack[1] |=3D esi[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
> +	drm_dp_mst_hpd_irq_handle_event(&intel_dp->mst_mgr, esi, ack, &handled)=
;
> =20
>  	if (esi[1] & DP_CP_IRQ) {
>  		intel_hdcp_handle_cp_irq(intel_dp->attached_connector);
> @@ -4139,6 +4137,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp=
)
> =20
>  		if (!intel_dp_ack_sink_irq_esi(intel_dp, ack))
>  			drm_dbg_kms(&i915->drm, "Failed to ack ESI\n");
> +
> +		if (ack[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY))
> +			drm_dp_mst_hpd_irq_send_new_request(&intel_dp->mst_mgr);
>  	}
> =20
>  	return link_ok;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 9b6824f6b9e4..42e1665ba11a 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1359,22 +1359,26 @@ nv50_mstm_service(struct nouveau_drm *drm,
>  	u8 esi[8] =3D {};
> =20
>  	while (handled) {
> +		u8 ack[8] =3D {};
> +
>  		rc =3D drm_dp_dpcd_read(aux, DP_SINK_COUNT_ESI, esi, 8);
>  		if (rc !=3D 8) {
>  			ret =3D false;
>  			break;
>  		}
> =20
> -		drm_dp_mst_hpd_irq(&mstm->mgr, esi, &handled);
> +		drm_dp_mst_hpd_irq_handle_event(&mstm->mgr, esi, ack, &handled);
>  		if (!handled)
>  			break;
> =20
> -		rc =3D drm_dp_dpcd_write(aux, DP_SINK_COUNT_ESI + 1, &esi[1],
> -				       3);
> -		if (rc !=3D 3) {
> +		rc =3D drm_dp_dpcd_writeb(aux, DP_SINK_COUNT_ESI + 1, ack[1]);
> +
> +		if (rc !=3D 1) {
>  			ret =3D false;
>  			break;
>  		}
> +
> +		drm_dp_mst_hpd_irq_send_new_request(&mstm->mgr);
>  	}
> =20
>  	if (!ret)
> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/displa=
y/drm_dp_mst_helper.h
> index 32c764fb9cb5..40e855c8407c 100644
> --- a/include/drm/display/drm_dp_mst_helper.h
> +++ b/include/drm/display/drm_dp_mst_helper.h
> @@ -815,8 +815,11 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_m=
st_topology_mgr *mgr);
>  bool drm_dp_read_mst_cap(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIV=
ER_CAP_SIZE]);
>  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr,=
 bool mst_state);
> =20
> -int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, boo=
l *handled);
> -
> +int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr,
> +				    const u8 *esi,
> +				    u8 *ack,
> +				    bool *handled);
> +void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr =
*mgr);
> =20
>  int
>  drm_dp_mst_detect_port(struct drm_connector *connector,

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

