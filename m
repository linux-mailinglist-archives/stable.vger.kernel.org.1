Return-Path: <stable+bounces-240381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CWuM0kd6Wl+UgIAu9opvQ
	(envelope-from <stable+bounces-240381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:11:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703C44A070
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 109E030F3CDC
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E534B661;
	Wed, 22 Apr 2026 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVnwLagj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MMcvoKbB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB833DED5
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884828; cv=none; b=jCb39Q4Ru+usQoSBwJUtjNetGScl40MG0SXfb4hAK+PhSVQsdmsPpa+WMKC6yQh00dbNsVZvThaN3QZN5fKdZPSCJTHllKsLTV1OTi2+fPc0jKCx3I1opZjFde2/PSNxD2uzxgoWh7H1so0Iw8qvWGEhFVxlo0YhZnoriawe0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884828; c=relaxed/simple;
	bh=YpPybOjNzb/K1Bmz4REhOqae1lLzwg3wkx8ZqS1Nu/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDcj/ZRdytpgGR0gnlXHKST9bNmT8wac9kH2QMYWT61wCQasQ8tiV6Nzzzmg+VqUg4gLQFP+BGAQxQPA6bFUSP3gkxFBbbaib+sh9TUR1dnXeHWH2hORFzG6WJdUVn9cl/TNAQFXFIn87Dxz0Ny6i+NLmVEbaZkTzpvb9h7jwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVnwLagj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MMcvoKbB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MFDLvT664127
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7EZiYe5N6hRvm3v4NIe+b/e9
	uhWdqKzT0/KCiMPYNrs=; b=jVnwLagjUG5doy+C7taNoVt8DrO9QX7I2rU0QGG3
	vl/10/xgV4szHYqArzA2GWY7TzN+teJWKSM/eQqjfqzO/K1R3Ja50fzS40Xt0DLF
	uRZQywMtd0W5RySjbJdsb1PCsz5S6RAMlvnXzqN8EOnAlhu5z1VhLsWb280Uam0K
	EB/ojqeXH2USNHvyC0SmUt1JB2TaE+LELgnt7Q06Y7NbkkZN+7nQxJPUYD4OVAJt
	DdoYrjVkyscQBcj+7oSxqWsZkKk1BtuTjobLgq+PbaUzmWLkzjVynB+bSQWKTgiq
	ChcqiSRarCj8jRF2XkIaYuVdgZWrpBK1yqlnMpwZuOJhkQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgt67m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:06:59 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-953e9d7ba08so2598997241.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776884818; x=1777489618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EZiYe5N6hRvm3v4NIe+b/e9uhWdqKzT0/KCiMPYNrs=;
        b=MMcvoKbBpYp7ccosInXRijzlqe3N29EwL6Gpv0dvM247+y88hhJNXjpefXWYySmY1H
         VF2sxAF2P8lxyRh9bH6jBIcFeZJXqZOlep3E1jWxscIHhbmmq69RZRoucKj2MEJ6jHhw
         ECaPrbwil4UVxTHj+HLREzm9L0mDUiBIsZecuxCx5ShgqSDdnXHvwsjgmrXZoKJ9HX6s
         VS3QWUTd4hi45oBTAKNDZ/gloHIaNKpNVEWC7Xc9IuYQCBfSF1KvM3unFcUkUyDqpBYJ
         6ig3ps8kwAGmcCO2Ju6749DytHa15z1XTCZ9XjGedIt5hR1ToKFxrqwyv9tLj29PheYw
         IFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884818; x=1777489618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EZiYe5N6hRvm3v4NIe+b/e9uhWdqKzT0/KCiMPYNrs=;
        b=sUCCdsSLhGtI1BxctCRj5ZL6QfwcEUJKZhJvaI4ivAxYPx4iT9C6HdzxJvFnVN57Fj
         kxWxt/lqy4r6OhjofxziU10emkAz9TDBg7uPWXdXM89ncbjFImu8FUvBgBUSQfhHq97i
         5qeJ2T2EhJ874FXb8PY/XulxmqgJ4jmy4U2+JRBDn/yVoZHSyJeAd9B/rr/60UdNy9FE
         jaDPAOAibrvzILxDIo+DZVqjtU0guTFWaO2LXWbsFOj/VcOiAI8MIfCrFNgy2u8nl7UE
         msG1mw7n1Rv4wLUSfuu14u8mjx8nTbPzGRBEis4dGZ1KayNwjS9aJtY/VpurK4sGqAT8
         BI3g==
X-Forwarded-Encrypted: i=1; AFNElJ/zNaAsN/jccbfbAHIS3+Ldbkc3yXnbIt04Y6EeCHNXTqGS2TS4W6wdJe+TBAxC7CXDINdjcMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTQ941z51pm8LY0Hji4K/aJBFGiAzN52qhmf0VjwYNNftq6IY
	nqJIi4OvtOkI5UtULhe/KhltX4PoOdTjdI5GZb5QO/HAVTi78CWemhme1YLhrcX7YdupffloTkx
	W2Zbh95zYKdhbJKZwi4O2Y7TCYh0pfsjG+79J5cfsuXAc1VD02EBvot90fh8=
X-Gm-Gg: AeBDiesTwb5YVapf18BpIwvk8wZNmpr2SIPDB3N7jbIJp0zzQTkBSJYYOQvF4ig/aFG
	ExHVsO2HHlizqDCFJapvVukmxv4aqo5cy3oVQ3iMoJQUd1u85em39oBcc1GdT5/PNkCnh1oXi5x
	OpwtDAIcCVQHAo/9u4XgncDED+pU0st/e3CstSRvtUn2dzvapynyBud8l01kPFRJlV70Mjkob0n
	ghFG3TdreSzzm8viS0brxlrMJyuV6xaEhlHl14xgZT8rwQcu4hB6UGQWYxqrSrdWgvdaERS5DyC
	+XUKG3cj280YneZayIONOmMCwwpBmCSYOREsHquXIEl5tMu/XzLyAYv9P2cqCBwAF6UCXc/5UmR
	SFdI1LCAKFuAywMfod5Vz+ToOIJ0IH28dOhoRRQVzzETszrBtorUSFt5sl/8776SHAqGWEWbMod
	1rNbWSCZ/8frCtMF8kRBCbmjSNFqFX3hoXDEdQw1GrR4d2xA==
X-Received: by 2002:a05:6102:80a8:b0:608:a960:c852 with SMTP id ada2fe7eead31-616f4d792b0mr12274695137.9.1776884818511;
        Wed, 22 Apr 2026 12:06:58 -0700 (PDT)
X-Received: by 2002:a05:6102:80a8:b0:608:a960:c852 with SMTP id ada2fe7eead31-616f4d792b0mr12274635137.9.1776884817942;
        Wed, 22 Apr 2026 12:06:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f65absm37608011fa.11.2026.04.22.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:06:56 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:06:55 +0300
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
Message-ID: <urguajogb4zsz4jg3ef32hpyf2awxkywdtlk5ackdi2gjai4l7@vpjaf3sznkto>
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
 <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
 <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
 <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
 <99f6fde4-ac69-4e7d-a345-a378762eb9bb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f6fde4-ac69-4e7d-a345-a378762eb9bb@gmail.com>
X-Proofpoint-ORIG-GUID: Lg2dJ7taFpRKTEcc6DxaBXy46YxmktX8
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e91c53 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=kn-r4vqxNxNuTmBUix8A:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: Lg2dJ7taFpRKTEcc6DxaBXy46YxmktX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4NCBTYWx0ZWRfX57+S/vep853A
 V5Egw2cPTPjYlsCqj1RET+lj8sTfqlsAoq0YLl8Y//Ru0ASgFDragrI44GJyDXB02ofi+Tb4mPc
 RLOFuCT6RdwxeqbQOXz0ZqEqQ4SaG3eacVrPMRFK5M6VeJVGUKGZTDznELNRoUJVkdY52mqQxb5
 TIjBtc82cp+W2/99xtq4wNkB5s69s3nTGMntXXZKxCSHtBhET+hpdqlkrh+il0FdsbzFoRd6i7U
 /ifJArt2R+xRdok4vyypndTx3qLGNeGkADTD4lloxoxmNUSq54EC1eQKxKT8/CYihbB/TvXeXVk
 gHXNUhHFEPJbGpfyRTnxApLy7D8tbidNK1WbT6u+edI5tZBY44rHJsaf4L1bYS3md/UaSLpjNSu
 WH1I/z+SRA7U3V5v7+/Jrwcqm4/9RE+o6bnI0di9/WZEehyaOyu9Q/1aQuen9IGn2MNvFqj3lTC
 yVNJRxIq0KY45421kCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220184
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240381-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,collabora.com,ideasonboard.com,kwiboo.se,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4703C44A070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:31:19AM +0800, Frank Zhang wrote:
> On 4/20/26 17:00, Dmitry Baryshkov wrote:
> > On Mon, Apr 20, 2026 at 02:11:28PM +0800, Frank Zhang wrote:
> > > On 4/19/26 08:40, Dmitry Baryshkov wrote:
> > > > On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
> > > > > The following panic was observed during system reboot:
> > > > > 
> > > > > Kernel panic - not syncing: Asynchronous SError Interrupt
> > > > > CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
> > > > > Call trace:
> > > > >    ...
> > > > >    regmap_update_bits_base+0x5c/0x90
> > > > >    dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
> > > > >    drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
> > > > >    ...
> > > > >    dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
> > > > >    drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
> > > > >    drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
> > > > >    hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
> > > > >    ...
> > > > >    snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
> > > > >    snd_pcm_release+0x60/0xe8 [snd_pcm]
> > > > >    ...
> > > > > 
> > > > > The root cause is pipewire tries to close the HDMI audio device after
> > > > > atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
> > > > > 
> > > > > In this case, dw_hdmi_qp_audio_disable() will call
> > > > > drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
> > > > > accessing registers without checking tmds_char_rate.
> > > > > 
> > > > > Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
> > > > > if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > > > 
> > > > > Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> > > > > Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> > > > > 
> > > > > ---
> > > > > Changes in v2:
> > > > > - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
> > > > >     the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> > > > > - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > > > index d649a1cf07f5..7760527484c8 100644
> > > > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> > > > > @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
> > > > >    {
> > > > >    	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
> > > > > -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > > > > -
> > > > > -	if (hdmi->tmds_char_rate)
> > > > > +	if (hdmi->tmds_char_rate) {
> > > > > +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> > > > >    		dw_hdmi_qp_audio_disable_regs(hdmi);
> > > > > +	}
> > > > 
> > > > Will audio and audio infoframe remain disabled after consequetive
> > > > atomic_enable() call?
> > > > 
> > > > >    }
> > > > >    static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
> > > > > -- 
> > > > > 2.53.0
> > > > > 
> > > > 
> > > 
> > > Sorry, I missed clearing the audio infoframe when the PHY is down. The next
> > > atomic_enable() will write the stale audio infoframe. My mistake.
> > > 
> > > To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can handle it
> > > in the else branch directly, but this seems like a layering violation for a
> > > bridge driver
> > > 
> > > I think the better approach is to add a 'reset_audio_infoframe' interface in
> > > drm_hdmi_state_helper.c that does basically the same as
> > > drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only clearing
> > > the software state without calling clear_infoframe(). It's also a bit odd
> > > since it would only be used by dw-hdmi-qp.
> > 
> > That sounds too fine-grained and it also will not work straight ahead...
> > 
> > Just for my understanding, let's consider the opposite situation: the
> > user tries to start audio playback before setting the mode. How is it
> > handled in the driver?
> > 
> 
> audio_prepare() will return -ENODEV before the mode is set.
> 
> I admit modifying dw-hdmi-qp is more reasonable. I have a new approach:
> 
> dw-hdmi-qp should have an internal function to clear the audio infoframe
> related registers.
> dw_hdmi_qp_bridge_clear_audio_infoframe() should check tmds_char_rate, call
> the new function only when tmds_char_rate is available.
> dw_hdmi_qp_bridge_write_audio_infoframe() should call the new function
> directly instead of dw_hdmi_qp_bridge_clear_audio_infoframe(), without
> checking tmds_char_rate.
> dw_hdmi_qp_audio_disable() doesn't need any modification.

Assuming that all audio-related registers are cleared when you perform
PHY disable / enable cycle, this looks good to me.

> 
> With this approach, clear_audio_infoframe guards register access by checking
> tmds_char_rate, while write_audio_infoframe does not need to check it again.
> How about it?
> 
> Thanks,
> Frank Zhang
> 
> > > 
> > > I'd like to get the maintainers' opinion about adding such an interface.
> > > 
> > > Thanks,
> > > Frank Zhang
> > > 
> > 
> 

-- 
With best wishes
Dmitry

