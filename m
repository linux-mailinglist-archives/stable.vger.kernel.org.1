Return-Path: <stable+bounces-238722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CpWLjTs5WnxpAEAu9opvQ
	(envelope-from <stable+bounces-238722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B67428A00
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87D2D305BFF4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04438B7DD;
	Mon, 20 Apr 2026 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMo7Yzcy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lq9hAuHK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37A38B124
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675629; cv=none; b=rCqcoz5MdYI5r073+oDi3kng7bkm0cr6OQu0AauJi+P37EdQiCzPif760/WHDczsb9zuANTltbYvvYpWWljK8EOtY00e8jvF+H4sa+NOR3jFzsplPvsNipLYYI7cnuPpl4WPf/yCSsMkqGZsBWllEmJ8Xi9lb8xhGn+7L/6x7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675629; c=relaxed/simple;
	bh=AG+lIbQ6Z8SlZGN4N9t9K17/j/RzlLGimBhlDZYjYJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGhK1iK12gIiUqb9DDS0t9M0BY7LGIsJBcSilias78grfmenfNK3+zKPF3Hg5NhMLEICFJsveE+xUUZlIGHSHMva9IzsdhcxrF/iSahOm4t1IiEPg2pd4lHVxZpxg75e0ArtootFqlaCHo0l3xl1nqHgLjaJg0aZZQcVlMIgf1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YMo7Yzcy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lq9hAuHK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7Ccwh2783942
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/lO0wUKTVYLddzZduPrPryU/
	1GxHKJTrxAiMfoqglG0=; b=YMo7Yzcyug+Kfs3+ERy00tBibDuu24kBh7Y1UR1/
	zEp4+GzPUo5VfnVsywv86EEE6fG9G4KbnQSlsx8XCbP+FLpXznb2b0+Z1JmlMepI
	hv5WmG9UgHV0EYHjpUr6bkLPetaihYn3L0r3Kka5Ppt1EXhy6by+XEwoTmgijnfZ
	toLbXo042tXFXs1ZYNjfrBskT1RhjrRPmUPLXgTysvCFAH3izmfihUWmOj9KCtM0
	181JlYcQLqBCoTUlgm0Qo5FI+IiLkIH8qK9j68vLmZinPf8dGBBXnRCDkjR51e1B
	j/XDDWtkuF7AHrM51oi5+7t6ncTAhe26vT2mU6DGbQ6Fqw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0y65btv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:00:25 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-605e5d95cccso1917290137.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776675624; x=1777280424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lO0wUKTVYLddzZduPrPryU/1GxHKJTrxAiMfoqglG0=;
        b=Lq9hAuHK+MubFimkmfTH+BnYBEOUPAHFdbrj8JjD1jN+/4PpmfjtWVtLtBGMXUsRp3
         0OlkNGGHn4yluaaBiHPNMFVqWYASir4zn9XCz/9KGPN7i2k1cOT+fwCIozB8RxbduMKG
         AY7xHRJyFFrcGwp98VQw+N/Bel71zbfTouEQlZgXF4L1vHFzfnNqgOQeiKdBqTAcE/nl
         Tp7wblkXCUxUSdnVEES0ymfTPkBjlPwY0bStncML5yW5C1blvHNIlgL2gEPGxPVebjI/
         xF6VtQKl4UxWC7W8eY9ZOf5X0YZrzx9nhM2HtHE7vfDwx/fvakE03fW7dfp9NY3cfi9t
         ze7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675624; x=1777280424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lO0wUKTVYLddzZduPrPryU/1GxHKJTrxAiMfoqglG0=;
        b=bwu/2u3+QYgGTTDgXQjVPiLvST50R7P9Cy9W2HfKVznCY8PFxA+QBn/R2oN0ZeBa5/
         kcodO9om611QipBT5WrA68P4lteUH+0omK/E3ELxUJB7HFWwuX5kd7ESdYqpadtimOm0
         hmy+7xSO9SlaUMX7Ckt3AGsbaihi7OgmNL7gT5NtdEqavzkO+C6dkTxL/0qnQck2ng7Q
         YD6hz7exlR6+qe0Eu9zITfrJfVL1px4ehw6s+sKGKnge9u7QW25PrkXMIN5hgTrwEwEP
         2N0cuX6v4TEMwVAHq2VMsR/uZo5oJsKaXCumuh1GTfFL3Gl7heenAsWorLydQj0FIpIt
         1zrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cpCVls6CF0q9CpNfMA7urvSRk4xEPqlUXLOg60VwTyn146OaPwtoEVcGSR76vEtxYaAI9s8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7zK2yAnBe1bSocqzSXjItb/2YbFLbvygkW7lKnBZ9l7safRl
	HV5bspxE5ejeiao323Yvb0q7G1AjYXgnchcB7W7NOI3Vq6+uZOQlgoRRBg33ByE80w/30bMuOrW
	cbgNii/1zY3S6giCDUnx2uh/saZ95gYy9ND+96upYHWxZcYCB7jWpsztMowA=
X-Gm-Gg: AeBDietju2XC93qIg+0GCcvn9Rnh8vpeo/r15nr0upQs0dKhhjtKiwvZe9gQZe1g4zI
	PkC5o2xB1wowxK8mY+1YIxUm0xTFYF+6gb53S41PAV5TNgk3J8p1jNX7VayT3eJdM4ID/o/+Ml4
	rw6GkpZMv/7cQIzdHeyU6lK9RCFab+Bd406SBesg3y9P9usoq2lz91oyrQ67tdZITwfJP6b+GDZ
	85C3jpIkQgffxNR7LlfAqursmGcHDGW46LubZ6CS2Yqr/k1VMiJXFrCCSBJZxMgSWkWbOc9UWzg
	2s+zklcPadssPGmvTHhyS8g3G+OgM0nzNqqvDKSeNYAoD/UPqj2UlwyyWuBFN7j5hzaYngj06AQ
	mvF7NyKUJzbwzNY/5gOZVGod/MV2MBN9SkOMdL1tboUECPlXGiwBA5eukbg4C1YDFDTBu8sAJjm
	TVSI+PWg1SIfZBkhr8ziAVX4QyfOQxpkVFSxHUXQ0ez/wQKA==
X-Received: by 2002:a05:6102:3581:b0:611:a5b6:f4d3 with SMTP id ada2fe7eead31-616f73fa0e4mr5157060137.22.1776675624422;
        Mon, 20 Apr 2026 02:00:24 -0700 (PDT)
X-Received: by 2002:a05:6102:3581:b0:611:a5b6:f4d3 with SMTP id ada2fe7eead31-616f73fa0e4mr5157037137.22.1776675623997;
        Mon, 20 Apr 2026 02:00:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f652asm22224871fa.12.2026.04.20.02.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:00:22 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:00:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        detlev.casanova@collabora.com, cristian.ciocaltea@collabora.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
Message-ID: <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
 <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
 <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
X-Proofpoint-ORIG-GUID: -5GSL4zITrmR7nFDxVdEl8NvrA7a_axw
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69e5eb29 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=-aDFVIzMO8mTH3V4WnwA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: -5GSL4zITrmR7nFDxVdEl8NvrA7a_axw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NiBTYWx0ZWRfX2CkX9VQRUruF
 +o7KOLMlD7bRA1Cd8AN2ELoZnfnLDhHTZyDNi+sz9UX6KAt/i/fojBHHxiQExO3c8hKkv3tBzz9
 VnqRe7KEwdBhFF2OtunvBLagGls8FxwPjEhzbUWB+6NTfTccUZtQLLmGbFk5z+BEhRAcEkHJjxG
 9dguBJ6u0YB2T4WJ6KKZZS0SVP9l+HETr0I0L0w8ZNcFjVIHRn8pM2JXutaTS4x63jRGXAQfUEp
 aaycMg7TbHm405CMOis3SJDDQd1zwabGQ5tQVr8cwKRrQIZd0/yCysAStTEG6Qhj9uOFNthGOn3
 msF5vIC3zaMTFCK2bmtSu3GgrigDUUkcFwdP2Y6yUef+RW+V5sz9KW+nDbQmpL9UWj1PV6WCr+X
 usGlw4OxksPnw64lXxWi+0HLX53K+RAnTSP0t/sD7+6RfYci0wI9rktmtwZ9Z8kW6mY3xV7eUBD
 jEHoa18xTALDx6rBHTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200086
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238722-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,collabora.com,ideasonboard.com,kwiboo.se,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35B67428A00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 02:11:28PM +0800, Frank Zhang wrote:
> On 4/19/26 08:40, Dmitry Baryshkov wrote:
> > On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
> > > The following panic was observed during system reboot:
> > > 
> > > Kernel panic - not syncing: Asynchronous SError Interrupt
> > > CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
> > > Call trace:
> > >   ...
> > >   regmap_update_bits_base+0x5c/0x90
> > >   dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
> > >   drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
> > >   ...
> > >   dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
> > >   drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
> > >   drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
> > >   hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
> > >   ...
> > >   snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
> > >   snd_pcm_release+0x60/0xe8 [snd_pcm]
> > >   ...
> > > 
> > > The root cause is pipewire tries to close the HDMI audio device after
> > > atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
> > > 
> > > In this case, dw_hdmi_qp_audio_disable() will call
> > > drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
> > > accessing registers without checking tmds_char_rate.
> > > 
> > > Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
> > > if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > 
> > > Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> > > Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> > > 
> > > ---
> > > Changes in v2:
> > > - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
> > >    the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > index d649a1cf07f5..7760527484c8 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
> > >   {
> > >   	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
> > > -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > > -
> > > -	if (hdmi->tmds_char_rate)
> > > +	if (hdmi->tmds_char_rate) {
> > > +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > >   		dw_hdmi_qp_audio_disable_regs(hdmi);
> > > +	}
> > 
> > Will audio and audio infoframe remain disabled after consequetive
> > atomic_enable() call?
> > 
> > >   }
> > >   static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
> > > -- 
> > > 2.53.0
> > > 
> > 
> 
> Sorry, I missed clearing the audio infoframe when the PHY is down. The next
> atomic_enable() will write the stale audio infoframe. My mistake.
> 
> To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can handle it
> in the else branch directly, but this seems like a layering violation for a
> bridge driver
> 
> I think the better approach is to add a 'reset_audio_infoframe' interface in
> drm_hdmi_state_helper.c that does basically the same as
> drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only clearing
> the software state without calling clear_infoframe(). It's also a bit odd
> since it would only be used by dw-hdmi-qp.

That sounds too fine-grained and it also will not work straight ahead...

Just for my understanding, let's consider the opposite situation: the
user tries to start audio playback before setting the mode. How is it
handled in the driver?

> 
> I'd like to get the maintainers' opinion about adding such an interface.
> 
> Thanks,
> Frank Zhang
> 

-- 
With best wishes
Dmitry

