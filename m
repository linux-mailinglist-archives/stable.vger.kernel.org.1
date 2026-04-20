Return-Path: <stable+bounces-238701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eRFYJbLD5WkEoAEAu9opvQ
	(envelope-from <stable+bounces-238701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:12:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5946427082
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC12300CBEA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 06:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C93815E2;
	Mon, 20 Apr 2026 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUoahSW/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6C2A1B2
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665519; cv=none; b=eoZFLoLbycxJX3Hd2hIfFzTx5aW7jv1xOGwy5EnbNVuyK/J+ae+gVoCuXqop/Pl49JFC31Nd7oVcVoixSnX7L1fFFmS3zkUZlvg3AWvhMyEr+PJ3g3hNG23+bot3GMvgUWeasoVb/ps44bMpKG4u8W1UucnMi6HAwKplBcEMTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665519; c=relaxed/simple;
	bh=/TCPWbhYgy1QrzBrAce/kNZ6xNY12c29If1AEOzWWT8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a8l94pgfsjkR4m/Aqc08boaSB411HjCAnlQ8DHG+zQf0OAaK5mbkEPbivbZzTsnEwyQYM7xtxaseNjgQVYAn2Y31nWcARJ93NUOVpjALfS1xUOL9Ts0lerOnC/FxX3s29R0UArI8J2EK3KqO78iv/sm27TzV0ehA+Bo3SV/wjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUoahSW/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7b1dcb58b8dso889937b3.3
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776665517; x=1777270317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f8Nyf4cpJRKorO7rgUUCbDBAbZjdSUwn4aYVqe/Bdmk=;
        b=CUoahSW/3lYZDBBaXolbjxsH25OyL0bUv8OdS8nSyYONCFT5deTn6U4HkGok404PCz
         3BJ0KNq0bQKzDZ770o2gkE3ahVabQbFZr/yMuAn/cEY+pI/QYNqEhv0VSn+T6cWwajCX
         Uz8p4oMKea6OLt+bo5dYH8TKDTwdFISEKGPcfOnM0Z7O1f8f1SbqWmFzeS0Qwik3Wvgq
         cJ+6UOBAQq1lUIewIT9U9+Lhx3+YAtuwZL1pmRU0pRdqX5WvMS/EFAR9uviQyORgeLTX
         7uBEU/YwjmQsRVpRMyeukR9WkFAPo9joA9vB2eJAMZk9JavdKR61abtNcFUtudBDMU8E
         qj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665517; x=1777270317;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8Nyf4cpJRKorO7rgUUCbDBAbZjdSUwn4aYVqe/Bdmk=;
        b=AfluZwK5V0qT9eLRoPw+GpQW0iYY264I3F3s/ROc9NLf01HUBQ6BeFdjmwMqEftzs2
         RG8EtvmdX6Ngnd0NI0GizB9rLZxlpH3W7pQSL18toS57erxvoyDooLM4d2ROyoRAsN+l
         VqNOPb9TUgLuGGFfZhXqNKNzOnJH0xSS+CbAv5utnUBSvUEB0GeXK81f4o55E2bwd33d
         W8DiArTvnMMh6xVR+RCqgCdaG0fhLBUtwkGSVImei3Yign2hStu6pCORFtE3p768K499
         k32ngJAxK/wAs6ArcONFXAUeeYiYxa11Gnkq8QDUrEjLmIcyZU1uNBFeeV6kSjkN/Dun
         I6bg==
X-Forwarded-Encrypted: i=1; AFNElJ9VE1YnkHEuNc+GfziFuEQMXTJohLluGeHplFSwuezQk2r4A86dD4CAFcuoGvvQw53gDr8vw6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sWwTIJ+2SA2BK/iSESjTbappBYCQzmosU3ftxE1i4O75ML3y
	D4+hgc1ggBOeUON9fPRi8GA2wzycsHPcpnKQJ6hc7C69X/KMiViWZG+z
X-Gm-Gg: AeBDiesXFngpGHkccSuydJ7Nq2hR3kKwGROj9Gk8duUXoRtixKPySL1geU3BxJrcMPG
	fFT6YCUFtU1eaNcGAil72Nd6W8mJYknehEgLc9V6dmy78oMf0kAdELBHUbEvb+Bwy567AvdKd9W
	LZ1ZKaU9UpJG7XkBzTHKd1ZEyKsjbrFSzpUSX9qGW/PowdCi4XcmPNzd4t+Dv8zDCndbP4VW8Xn
	bIw3yEuAaGwipVljH+J/8zrEsV3QX9nbq2RwTu+DciqNPsVXlt1bL/2M/7d8AinEaRBwLbiaoIL
	IUnEtiiFc9455ZW0ocLzZzznFzTdYoStxg3s/fs+QdmkRrlNeNVPiBhU/0n5gQQq8E7wNWE14cy
	cjxyYZnoG/OJ2Xb6FCVmpZVBQXr6JGr+P4wIWt7O/+e75WHP91W1WricdvwhVRhOAp7/NbjX37f
	WNWPvszPTBlWg/Cc0MBEOP1l906hBs0iBpp1sWB5ESuBb4DAws8RsBhLDjwnp4dg/ixr2dZWyT4
	4iv
X-Received: by 2002:a05:690c:4485:b0:7b6:db48:2f1d with SMTP id 00721157ae682-7b9eccea04amr83767167b3.0.1776665517197;
        Sun, 19 Apr 2026 23:11:57 -0700 (PDT)
Received: from [192.168.11.79] (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com. [2607:8700:5500:a805::2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314e3510esm4693954d50.10.2026.04.19.23.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 23:11:56 -0700 (PDT)
Message-ID: <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
Date: Mon, 20 Apr 2026 14:11:28 +0800
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
Content-Language: en-US
In-Reply-To: <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,collabora.com,ideasonboard.com,kwiboo.se,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238701-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmxpzlb@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E5946427082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 08:40, Dmitry Baryshkov wrote:
> On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
>> The following panic was observed during system reboot:
>>
>> Kernel panic - not syncing: Asynchronous SError Interrupt
>> CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
>> Call trace:
>>   ...
>>   regmap_update_bits_base+0x5c/0x90
>>   dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
>>   drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
>>   ...
>>   dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
>>   drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
>>   drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
>>   hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>>   ...
>>   snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
>>   snd_pcm_release+0x60/0xe8 [snd_pcm]
>>   ...
>>
>> The root cause is pipewire tries to close the HDMI audio device after
>> atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
>>
>> In this case, dw_hdmi_qp_audio_disable() will call
>> drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
>> accessing registers without checking tmds_char_rate.
>>
>> Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
>> if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>>
>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
>> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>>
>> ---
>> Changes in v2:
>> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>>    the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> index d649a1cf07f5..7760527484c8 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
>>   {
>>   	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>>   
>> -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>> -
>> -	if (hdmi->tmds_char_rate)
>> +	if (hdmi->tmds_char_rate) {
>> +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>>   		dw_hdmi_qp_audio_disable_regs(hdmi);
>> +	}
> 
> Will audio and audio infoframe remain disabled after consequetive
> atomic_enable() call?
> 
>>   }
>>   
>>   static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
>> -- 
>> 2.53.0
>>
> 

Sorry, I missed clearing the audio infoframe when the PHY is down. The 
next atomic_enable() will write the stale audio infoframe. My mistake.

To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can 
handle it in the else branch directly, but this seems like a layering 
violation for a bridge driver

I think the better approach is to add a 'reset_audio_infoframe' 
interface in drm_hdmi_state_helper.c that does basically the same as 
drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only 
clearing the software state without calling clear_infoframe(). It's also 
a bit odd since it would only be used by dw-hdmi-qp.

I'd like to get the maintainers' opinion about adding such an interface.

Thanks,
Frank Zhang


