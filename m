Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041B6724F6D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbjFFWDw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbjFFWDp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 18:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEE1739
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686088985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVKUdzpCpVRlbxarpaUoo1QmcbnwUVepFks5Eg0Cjvk=;
        b=b0ojin5VslnAG8NdL5ekrFl9jt0beSj7Gctq0AIMLsnlVxiuur0rMsfEWvVW+hc2wt5IwM
        M0TyCTOjO5uVeThOGorxjkdZ0Wjs9vkzP6OKXxnLoag08QOTV7kcaXIltIzvw65VEYr+l0
        6knbUGp9568hQgqwARXMebSQTWjsFzo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Ly8bg_z4N_6Ei65N78ByGw-1; Tue, 06 Jun 2023 18:03:02 -0400
X-MC-Unique: Ly8bg_z4N_6Ei65N78ByGw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75ec7dedd93so122921285a.0
        for <stable@vger.kernel.org>; Tue, 06 Jun 2023 15:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686088982; x=1688680982;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVKUdzpCpVRlbxarpaUoo1QmcbnwUVepFks5Eg0Cjvk=;
        b=jBsuAy1UEVuypahdiE34vllWoYvNlIfE4uiAJf2rCvjEr2xWb8NjzJt3nTWIr6b7P2
         x4OTGNkV5FGfGG8lKU8KceYFvquN3MWwQ0xjhs7atDc+bR4GWbPHdGaYcH3KeZ9ECDHA
         HJyCc7udUTMIxlCVaqCPJM0O+nneVCRHJeRjfgHHS1/KjgI8OOBG20C4XuRAnPj4mpsi
         MVzw7XtYoZvOT8oiMfDKsNkcP0E+chH8iI0E4/4ARidMRLuZzv1jjHMq6i9ifOPX2qzT
         ZCyJ2F+ZNcnarXK4aOJIHlpxS6dVvUp/e6DtG5TH7q7sEDmQtAnj4dfeAW6SUYuQxfrG
         UrNA==
X-Gm-Message-State: AC+VfDxonJ+j6/KmPLkXr+8a7yKh3y0H1HRygGxTZombHzj58AYfY2fT
        T5SC2Qs88IcDv9XV+pU7EVHjAbngyz0QXX23O8MVV84VTKaXiYFv3eBU2NitbVzsH7+bgDQ2JpF
        rbsQL5qM1MWskVNyi
X-Received: by 2002:a37:aca:0:b0:75d:59e3:6aaf with SMTP id 193-20020a370aca000000b0075d59e36aafmr1493778qkk.12.1686088981788;
        Tue, 06 Jun 2023 15:03:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ764SGHWFkieA6gJEGBjk8hjnspoTeAuihudVSU8jkMkSEimoG9Fb7Z0bPMpmJUqw5bRWFmJg==
X-Received: by 2002:a37:aca:0:b0:75d:59e3:6aaf with SMTP id 193-20020a370aca000000b0075d59e36aafmr1493748qkk.12.1686088981444;
        Tue, 06 Jun 2023 15:03:01 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a144800b0075b27186d9asm5191713qkl.106.2023.06.06.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:03:00 -0700 (PDT)
Message-ID: <6bdd1e1182e74fa1eddb823a2f8b813ec8028073.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Clear MSG_RDY flag before sending new
 message
From:   Lyude Paul <lyude@redhat.com>
To:     Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     ville.syrjala@linux.intel.com, jani.nikula@intel.com,
        imre.deak@intel.com, harry.wentland@amd.com, jerry.zuo@amd.com,
        stable@vger.kernel.org
Date:   Tue, 06 Jun 2023 18:02:59 -0400
In-Reply-To: <20230531040027.3457841-1-Wayne.Lin@amd.com>
References: <20230531040027.3457841-1-Wayne.Lin@amd.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
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

My apologies for taking so long to reply to this. I'll be honest - the last
MST fiasco seriously burned me out big time, and I had to take a big step b=
ack
from working on MST for a while. Comments below

On Wed, 2023-05-31 at 12:00 +0800, Wayne Lin wrote:
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
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++-------
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 39 +++++++++++++++++--
>  drivers/gpu/drm/i915/display/intel_dp.c       |  7 ++--
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       | 12 ++++--
>  include/drm/display/drm_dp_mst_helper.h       |  7 +++-
>  5 files changed, 70 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d5cec03eaa8d..597c3368bcfb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3236,6 +3236,7 @@ static void dm_handle_mst_sideband_msg(struct amdgp=
u_dm_connector *aconnector)
>  {
>  	u8 esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] =3D { 0 };
>  	u8 dret;
> +	u8 ack;
>  	bool new_irq_handled =3D false;
>  	int dpcd_addr;
>  	int dpcd_bytes_to_read;
> @@ -3265,34 +3266,36 @@ static void dm_handle_mst_sideband_msg(struct amd=
gpu_dm_connector *aconnector)
>  		process_count < max_process_count) {
>  		u8 retry;
>  		dret =3D 0;
> +		ack =3D 0;
> =20
>  		process_count++;
> =20
>  		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
>  		/* handle HPD short pulse irq */
>  		if (aconnector->mst_mgr.mst_state)
> -			drm_dp_mst_hpd_irq(
> -				&aconnector->mst_mgr,
> -				esi,
> -				&new_irq_handled);
> +			drm_dp_mst_hpd_irq_handle_event(&aconnector->mst_mgr,
> +							esi,
> +							&ack,
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
> +							  ack);
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
> index 38dab76ae69e..13165e764709 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4053,9 +4053,10 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_=
mst_topology_mgr *mgr)
>  }
> =20
>  /**
> - * drm_dp_mst_hpd_irq() - MST hotplug IRQ notify
> + * drm_dp_mst_hpd_irq_handle_event() - MST hotplug IRQ handle MST event
>   * @mgr: manager to notify irq for.
>   * @esi: 4 bytes from SINK_COUNT_ESI
> + * @ack: flags of events to ack
>   * @handled: whether the hpd interrupt was consumed or not
>   *
>   * This should be called from the driver when it detects a short IRQ,
> @@ -4063,7 +4064,8 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_m=
st_topology_mgr *mgr)
>   * topology manager will process the sideband messages received as a res=
ult
>   * of this.

We've gotta update the documentation here to reflect the changes being made=
.
Otherwise I think this looks good. Mind sending out a new version and I wil=
l
confirm this works on nouveau's side before giving an RB

(That might take a day or two, I accidentally discovered nouveau's MST supp=
ort
regressed a bit while I was away :( )

>   */
> -int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, boo=
l *handled)
> +int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr,=
 const u8 *esi,
> +				    u8 *ack, bool *handled)
>  {
>  	int ret =3D 0;
>  	int sc;
> @@ -4078,18 +4080,47 @@ int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology=
_mgr *mgr, u8 *esi, bool *handl
>  	if (esi[1] & DP_DOWN_REP_MSG_RDY) {
>  		ret =3D drm_dp_mst_handle_down_rep(mgr);
>  		*handled =3D true;
> +		*ack |=3D DP_DOWN_REP_MSG_RDY;
>  	}
> =20
>  	if (esi[1] & DP_UP_REQ_MSG_RDY) {
>  		ret |=3D drm_dp_mst_handle_up_req(mgr);
>  		*handled =3D true;
> +		*ack |=3D DP_UP_REQ_MSG_RDY;
>  	}
> =20
> -	drm_dp_mst_kick_tx(mgr);
>  	return ret;
>  }
> -EXPORT_SYMBOL(drm_dp_mst_hpd_irq);
> +EXPORT_SYMBOL(drm_dp_mst_hpd_irq_handle_event);
> +
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
> =20
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
> index 4bec8cd7979f..f24602887015 100644
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
> +	drm_dp_mst_hpd_irq_handle_event(&intel_dp->mst_mgr, esi, &ack[1], &hand=
led);
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
> index 9b6824f6b9e4..b2d9978e88a8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1357,6 +1357,7 @@ nv50_mstm_service(struct nouveau_drm *drm,
>  	bool handled =3D true, ret =3D true;
>  	int rc;
>  	u8 esi[8] =3D {};
> +	u8 ack;
> =20
>  	while (handled) {
>  		rc =3D drm_dp_dpcd_read(aux, DP_SINK_COUNT_ESI, esi, 8);
> @@ -1365,16 +1366,19 @@ nv50_mstm_service(struct nouveau_drm *drm,
>  			break;
>  		}
> =20
> -		drm_dp_mst_hpd_irq(&mstm->mgr, esi, &handled);
> +		ack =3D 0;
> +		drm_dp_mst_hpd_irq_handle_event(&mstm->mgr, esi, &ack, &handled);
>  		if (!handled)
>  			break;
> =20
> -		rc =3D drm_dp_dpcd_write(aux, DP_SINK_COUNT_ESI + 1, &esi[1],
> -				       3);
> -		if (rc !=3D 3) {
> +		rc =3D drm_dp_dpcd_writeb(aux, DP_SINK_COUNT_ESI + 1, ack);
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

