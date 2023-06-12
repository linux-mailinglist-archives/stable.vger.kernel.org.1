Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E673672D480
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbjFLWf1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbjFLWfE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 18:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8A13D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686609253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbeCENkMKx/+aAQtVAjinuSws5DYTdc2Zscj2BYBR5M=;
        b=JaIOt2oPwSU7iL/hptSdWrnkyysHDGuZtoVnBYsaD7gYpo12mdoHwztlp/2UvPRWRxPIvh
        TnHbwPKNxOJ4sxWtxkd7mos+CpGVtR8o6w0Ii4vN0Ok9TOmhh+JQQVrdh/QqXt4aoBBdmu
        dwVGjdaZ/Tr+4HC3asu1eBGFzgGEY1g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-18S3X_44Ofe1a2O78XDSAw-1; Mon, 12 Jun 2023 18:34:12 -0400
X-MC-Unique: 18S3X_44Ofe1a2O78XDSAw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f9d61c0990so5797241cf.3
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 15:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609251; x=1689201251;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbeCENkMKx/+aAQtVAjinuSws5DYTdc2Zscj2BYBR5M=;
        b=UlLiIUjFrLgbZnP1apArVYs+3XnmIplDKxQ7sdNAMG9Bb/vh27BuXN20qHTt7FtDM3
         IT1HOexFY3Q0Bo3z2ahKvs8J7c0jck3ArC1/OGNTRpngTiuz8wUVaaOIHm7gdOeC7aY+
         xGWr+3HwDoFimHSL+hM5W2Prm1fZCugd+IBCQu29GhfSsvExogFxLn6wlo8KeTxUy16N
         mj6AHqK1qHA+iFhwcMwBfrT89oaJ2iajvcmiAMW8w+gOSxGcW1341ykD6Wm4o2tjLNbi
         Mc8z6CA53zneGXA2JvKY6N6ZSsg4HCkqf9w5fPaviv+JF9AOAw34F+ImyAvb6A+pGtlN
         QwyQ==
X-Gm-Message-State: AC+VfDyfnR7odUb0lbt9W8OWZ8R3DUahphSebqNp1sIhWBRWiHuotC3j
        uDjDmi7/4/XPLiJ6HHHMF7EGcUrGOwqDudo/qdYDyd5GUWnVPObGEsaefIiaEBfgQ+Opq85nUDl
        oiO1xtnnmyQja8MjW
X-Received: by 2002:a05:622a:100c:b0:3f6:9b4e:512a with SMTP id d12-20020a05622a100c00b003f69b4e512amr11740508qte.54.1686609250803;
        Mon, 12 Jun 2023 15:34:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40JOINKlTsIVmrGQ0AaM7ywK31TKcr/8Fs7KJrfRHtAxNfOfJAoa2ygQC7gloFxvmoeQOkOQ==
X-Received: by 2002:a05:622a:100c:b0:3f6:9b4e:512a with SMTP id d12-20020a05622a100c00b003f69b4e512amr11740486qte.54.1686609250484;
        Mon, 12 Jun 2023 15:34:10 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85642000000b003f9c2f51558sm3724441qtt.24.2023.06.12.15.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 15:34:10 -0700 (PDT)
Message-ID: <cf4bd446d5cbbd7021a44418f54c6f70958b9c4e.camel@redhat.com>
Subject: Re: [PATCH v5] drm/dp_mst: Clear MSG_RDY flag before sending new
 message
From:   Lyude Paul <lyude@redhat.com>
To:     Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     ville.syrjala@linux.intel.com, jani.nikula@intel.com,
        imre.deak@intel.com, harry.wentland@amd.com, jerry.zuo@amd.com,
        stable@vger.kernel.org
Date:   Mon, 12 Jun 2023 18:34:09 -0400
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

FWIW: Should have a response to this very soon, figured out the cause of my
MST issues so I should be able to test this very soon

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

