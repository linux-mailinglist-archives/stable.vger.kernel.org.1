Return-Path: <stable+bounces-240024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAu0KIrh5mmr1gEAu9opvQ
	(envelope-from <stable+bounces-240024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:31:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8B4357E5
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0865F300DE0E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9751207A20;
	Tue, 21 Apr 2026 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcDX6BhZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195915B0EC
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738693; cv=none; b=Alfn6rCBWXOdkow3f/475dOQvSwEE6pc7NrLQxMD6Y5k7oe7WKpsJ/TPUYZh5bzhws0ZckFuHbnJ94PpGBd2BDsPCgLRuyiLepJ7f4gJngxpIK0PgJHQctV/u6GqnyU7BitdCrPYrrhhQfL93mU8D6CZE8K1+bMnjy566sdfvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738693; c=relaxed/simple;
	bh=sp3R6bmYxrno0C9baRRapNxuKoTU+SdyfvK5YZwdvZI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Obq4JPUIVnJ7spQ0vnZRF0ZcaXQQpcREdiH5BPROa5/+lRaUpRQ12dEnNNrEQhqfOLq5ocVtz5cz/pg6KoxvWve/4JSobvMwhiAbpJyCfmzCUVbGoddPsYCdAc1aPiaTsN4YovqzKL8ybh5LRZ0ArbUpUneTdUiiyyI9b6DNaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcDX6BhZ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6543c251311so97580d50.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 19:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776738691; x=1777343491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ipI0idJGNrZodVG5ZIm4eDtcetTLm6jd3SJUdqoCiio=;
        b=ZcDX6BhZtNbLhUpJbhYyKmq3eStaasVn5q9t0RT4t5Hpg+VgtEmnvJA9S8GyOOURj2
         ar6nJ7gHivNtPdhjByT5yC/av83bTY3VYqIYRIAojkkDSjupyuyMDyAJdj7gE7XR1VUN
         Lkoomj7qlltUkriSffcb7nLIQhiYLdcJyjiHS7h4+VI2GOSTHzYA7+4CixCaAMcSepyA
         +GtlEmFGJiAg2WBXa65No0/aZfD+xhrqoHFPGgb26B2TEr6VH+I9Ct9XG/iiAJPSHmd7
         AYQAkAHiVSBMwKAjzEFmsTE2ncyGCznBdz9wYkR1Q9cOZQ6poFG3J6adtuOzn8dp0MYL
         A/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738691; x=1777343491;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipI0idJGNrZodVG5ZIm4eDtcetTLm6jd3SJUdqoCiio=;
        b=jsZPQoP0OEKhJVoiPuzAVvTRbS3mzJYH5VEqmRD3ayCRQ0m6mSjhLcKzuUhEQTaJj0
         M2no0IWkzKWn0ubnA2h30e2laUvimM7Yai9MWKK8wyfMkhVi/mWB9Tei7xklfK2bHqzU
         XROW6iuYfwdn7iVOQq8KXbxtLJNS54p75YvoOHIaSxZgi0D3U33rMl5uAURg3REJrRET
         qs+HbyP5KzsuLhn5PAKxX4bCMiUHZSiFGlYL1kIccAP2M7wFxyUdT5vL6sJcN6iXtoVo
         jmbY7N6ibEZjiRSC970atxS31icbmR1PkuCgHLhSU21syGRQ4XdEW4TaKP3VGdTNgvC7
         2xxw==
X-Forwarded-Encrypted: i=1; AFNElJ+6Gl9LQNr9LCX6TVsx8RDW8xOOjljvzDyNz/l3jukkje901/mMkb8RnzKj8nTR8cT/5UODHGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OuycAX+jk8eevAQFDqhZKF+eXLUnNuSf89TKIup5rQdeW1iy
	QpX/fePTe5ihXLsMOnUgBlL/OGRRAkiNA6EOlX9DF86Tpxz0m6WWr8gD
X-Gm-Gg: AeBDies9jNAtvmOOOhZDHNa8kXyJAHnq7JMs7h/VJG/Pu3uAdm8A9deHGX4F57LgStF
	IIUKHKfEQuYvxkNgNNMbqt0DGzvyCgzTbbxGplvv3tCB+KdWamcQjdamPWSxClMS/vRrvv3i0bU
	m/wW9Sw2ZIv8LVwbTG8ePSSOQUiJKf3tfddmXw1rh4ywaWXp7lOlMhxQjfM/Kl5FCUg9CZnY6m0
	y042amAL98LSLeKYzivRcnZ6sgo7v8Q+I9IiR6XXpL7w71Mx58l+Y7wRGRA6pC4H37TVvSClLUd
	rJQQAEvn9GHsrYWfLtPl/TkQeNMXT+qitb9bXnCrpVEAcXDfVIb2WhJZOJGNv7C7B6JUCbJmXPk
	tjR+eM3Htq+DnIcVd1YH4wkQ1Ugi4gGZlfMuY7YBAkCCXdI/JLs37ETZ5z4dX1tYPJ5zjWeXqTg
	gYtsW2I/NDX6DwVejPYXi8vBMqjP9ESNu3sNzUW4A5Pr9RYLYwxdshx67Yvl7kaimw8k8ghJo17
	f/B8hj+ke4oGUM=
X-Received: by 2002:a05:690c:4b92:b0:7b1:c8e4:3271 with SMTP id 00721157ae682-7b9ed12bbc9mr119038577b3.3.1776738691366;
        Mon, 20 Apr 2026 19:31:31 -0700 (PDT)
Received: from [192.168.11.79] (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com. [2607:8700:5500:a805::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8be8e4sm52804197b3.14.2026.04.20.19.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:31:30 -0700 (PDT)
Message-ID: <99f6fde4-ac69-4e7d-a345-a378762eb9bb@gmail.com>
Date: Tue, 21 Apr 2026 10:31:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Frank Zhang <rmxpzlb@gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, detlev.casanova@collabora.com,
 cristian.ciocaltea@collabora.com, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
 <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
 <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
 <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
Content-Language: en-US
In-Reply-To: <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240024-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,collabora.com,ideasonboard.com,kwiboo.se,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmxpzlb@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08E8B4357E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 17:00, Dmitry Baryshkov wrote:
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
>>>
>>> Will audio and audio infoframe remain disabled after consequetive
>>> atomic_enable() call?
>>>
>>>>    }
>>>>    static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
>>>> -- 
>>>> 2.53.0
>>>>
>>>
>>
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
> 
> That sounds too fine-grained and it also will not work straight ahead...
> 
> Just for my understanding, let's consider the opposite situation: the
> user tries to start audio playback before setting the mode. How is it
> handled in the driver?
> 

audio_prepare() will return -ENODEV before the mode is set.

I admit modifying dw-hdmi-qp is more reasonable. I have a new approach:

dw-hdmi-qp should have an internal function to clear the audio infoframe 
related registers.
dw_hdmi_qp_bridge_clear_audio_infoframe() should check tmds_char_rate, 
call the new function only when tmds_char_rate is available.
dw_hdmi_qp_bridge_write_audio_infoframe() should call the new function 
directly instead of dw_hdmi_qp_bridge_clear_audio_infoframe(), without 
checking tmds_char_rate.
dw_hdmi_qp_audio_disable() doesn't need any modification.

With this approach, clear_audio_infoframe guards register access by 
checking tmds_char_rate, while write_audio_infoframe does not need to 
check it again. How about it?

Thanks,
Frank Zhang

>>
>> I'd like to get the maintainers' opinion about adding such an interface.
>>
>> Thanks,
>> Frank Zhang
>>
> 


