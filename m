Return-Path: <stable+bounces-239227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OGCHt9I5mnSuAEAu9opvQ
	(envelope-from <stable+bounces-239227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:40:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F542E754
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 518143121BE0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255A3D4138;
	Mon, 20 Apr 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="dvUiYrjR"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169893B6C19;
	Mon, 20 Apr 2026 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692285; cv=pass; b=KzMDdTBacgGn1q5pcMDam7OrG2AQtp6ur7A48EfZcZuZrtNX8mZUZwO/4w18HMBGnQzgim2pxUumxKOHABWIZyrfWMyILFOB7EeZWkxYv6MRq4lwQD4oFWPGFJPpdQlKeOscFHRYH3NlWL8nNE0eXkkLeICGhG+dxh/nWV8g/CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692285; c=relaxed/simple;
	bh=d20UoEeNwtxEpiO4s5aE/cawYq2kPFMUnBMS+p4oaZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9CCWbjv3YTkqN5Mbq6l5gZ+z4MT8mGlFmCj6yZYjI8EB2a7bunp7ScA1pDcnUG/0XjebuabPGP7mAx+MATGN2+BYtYTnj/BLeltPbeDhIUoDYQEkLmuLBbV3zQ3UNaWxYsuLs7quIHqqNlK/3ODMEeTiBJmZMKtuaEoFJ4Qtmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=dvUiYrjR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776692259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RWuopc1rG9JdUNG6zDMjGAUTTWtPYEnLcp0sLCFyYcgLbZytAeawma6xzGBtbz0t+vNXSW3xKDEg7IMOLhbwN8Tr5YpFWiEECp9HNH/t8Lu5U46acpPE+jjhTyLsJsKGvzWJ63391glBN/6sTND3PNbm9t71j5u599vDpngAHBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776692259; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=stQoYOnLVldTdbwAlWB07GHkggCwMIPdlp60EQdUSsA=; 
	b=dIKgjjm9U7TwgNmR8YtchVlR2M8Pkt//442RMx5CLE9a4VJYh1cXI40N56MZCB9gG24wLdxIOHgjEXomx20WVlX0/SjgGzCSIK+pHtCLh1xeM095up+iVw2k+CE0Z0i5Y3CKTlth7r7EltJRsbfZ5sfGfImED/XB2hJd6hSCRek=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776692259;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=stQoYOnLVldTdbwAlWB07GHkggCwMIPdlp60EQdUSsA=;
	b=dvUiYrjRdprJhe6eT+ADPlCPFZNNmuMpwRySExvbC21bOBlad/ZqZDRYSleubnAZ
	roFr+J6NpILaE5/VEGR5z5A0XDAt4YeFN9cebsGuhKn6QjG9txQMuvk4e5Iq3xEaHkP
	sUvkOHKaaRFs7OnVpORIn2UnwlAmmM+1Hkz1qOCA=
Received: by mx.zohomail.com with SMTPS id 1776692257243717.4700776279008;
	Mon, 20 Apr 2026 06:37:37 -0700 (PDT)
Message-ID: <6317220f-4912-4a53-a987-08fd61b2d70d@collabora.com>
Date: Mon, 20 Apr 2026 09:37:34 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Frank Zhang <rmxpzlb@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, cristian.ciocaltea@collabora.com,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
 <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
 <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
 <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
Content-Language: en-US
From: Detlev Casanova <detlev.casanova@collabora.com>
In-Reply-To: <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239227-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[detlev.casanova@collabora.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,collabora.com,ideasonboard.com,kwiboo.se,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:dkim,collabora.com:mid]
X-Rspamd-Queue-Id: 128F542E754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dmitry,

On 4/20/26 05:00, Dmitry Baryshkov wrote:
> On Mon, Apr 20, 2026 at 02:11:28PM +0800, Frank Zhang wrote:
>> On 4/19/26 08:40, Dmitry Baryshkov wrote:
>>> On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
>>>> The following panic was observed during system reboot:
>>>>
>>>> Kernel panic - not syncing: Asynchronous SError Interrupt
>>>> CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
>>>> Call trace:
>>>>    ...
>>>>    regmap_update_bits_base+0x5c/0x90
>>>>    dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
>>>>    drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
>>>>    ...
>>>>    dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
>>>>    drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
>>>>    drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
>>>>    hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>>>>    ...
>>>>    snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
>>>>    snd_pcm_release+0x60/0xe8 [snd_pcm]
>>>>    ...
>>>>
>>>> The root cause is pipewire tries to close the HDMI audio device after
>>>> atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
>>>>
>>>> In this case, dw_hdmi_qp_audio_disable() will call
>>>> drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
>>>> accessing registers without checking tmds_char_rate.
>>>>
>>>> Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
>>>> if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>>>>
>>>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
>>>> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>>>>
>>>> ---
>>>> Changes in v2:
>>>> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>>>>     the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>>>> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>>>> index d649a1cf07f5..7760527484c8 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>>>> @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
>>>>    {
>>>>    	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>>>> -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>>>> -
>>>> -	if (hdmi->tmds_char_rate)
>>>> +	if (hdmi->tmds_char_rate) {
>>>> +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>>>>    		dw_hdmi_qp_audio_disable_regs(hdmi);
>>>> +	}
>>> Will audio and audio infoframe remain disabled after consequetive
>>> atomic_enable() call?
>>>
>>>>    }
>>>>    static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
>>>> -- 
>>>> 2.53.0
>>>>
>> Sorry, I missed clearing the audio infoframe when the PHY is down. The next
>> atomic_enable() will write the stale audio infoframe. My mistake.
>>
>> To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can handle it
>> in the else branch directly, but this seems like a layering violation for a
>> bridge driver
>>
>> I think the better approach is to add a 'reset_audio_infoframe' interface in
>> drm_hdmi_state_helper.c that does basically the same as
>> drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only clearing
>> the software state without calling clear_infoframe(). It's also a bit odd
>> since it would only be used by dw-hdmi-qp.
> That sounds too fine-grained and it also will not work straight ahead...
>
> Just for my understanding, let's consider the opposite situation: the
> user tries to start audio playback before setting the mode. How is it
> handled in the driver?
Currently, when setting audio params, the value of tmds_char_rate is 
needed to
compute some clocks value.

So if the user starts audio before any mode is set, we just return -ENODEV.

I sent a tentative fix to just return 0 some time ago:
https://lore.kernel.org/all/20250722195437.1347865-2-detlev.casanova@collabora.com/

Detlev.
>> I'd like to get the maintainers' opinion about adding such an interface.
>>
>> Thanks,
>> Frank Zhang
>>


