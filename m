Return-Path: <stable+bounces-238618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAkBCook5GnvRgEAu9opvQ
	(envelope-from <stable+bounces-238618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 02:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D732422C4B
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 02:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0F0302E792
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15674233D9E;
	Sun, 19 Apr 2026 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V/xuSyYQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RiUO4lb/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BA10F1
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776559232; cv=none; b=pgtVkY/5JjdIVxxXROjqUAnwBZMl4CL9A5wXDL+lS2AWCDqBqRnM/hwoKR1z7EmKCZZgLR9VaeYgNmEApcYQb1JkIQvT8mw4dqr8XbxKgIzmknOrrWF80YWsYF6TNClq+6WVZMoRNB+fR/qQLO+HV2uTJjnpHl0l/SGAX4+wuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776559232; c=relaxed/simple;
	bh=bI9Yl9ViGeQph4xa6qGHRhQ9gxpOgYbrJG7aFlKhGKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK9t6dxvUT6Jymzq7Gud858xzErYAkM0U+sDutZyCgiCVDQf8gsKxUN2cHLqR9y9IHn1aXntMZmSvbyq0dUa0tBDatJ2MjRha/LPwxYpDi9QshyQkJ4QLhbuvZBoWYmOp6KZzi1gi5qZhaKrfHI4XdZE37jL5yKm1SNCe+R9pe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V/xuSyYQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RiUO4lb/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63INKOgu090102
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 00:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u8hqGnhqQvo+1kHYK672RCa0
	BshwCk42qeeZrE4YnGQ=; b=V/xuSyYQQlEI/KH8VjbFgrGwfs31rsc3Ufw62pfJ
	khNd/atHgJIZjp0zxRf6DpHrLqtD9pXplmXlhWeW6QSiZyFDFbl2HKBJ+F83xVb8
	LZkqjO5Zwl3lkzSyZk8T6OBS48NZvRscFmOdthwA73aGBt1d8+/AqvY2UBuKZWXC
	aV/GA4su4NNEy3LpTAm1g0tPG+mZX8NIn4p6IEVsuZjgRmvt3JOmRtH6PcFT3nGr
	+IAVDbeeymEFvVn/jVxR6Yatz+1F6c8sS1JwkBf50LbmHJAIqhD8M+gDctbRKIL/
	u6DobnH+egteD+0ZY9GyFTD9/6ml5ub9RDpnmlp65JpOCQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0y61ts0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 00:40:30 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-953cccadb32so2149819241.2
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776559230; x=1777164030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8hqGnhqQvo+1kHYK672RCa0BshwCk42qeeZrE4YnGQ=;
        b=RiUO4lb/HZRY9TlIyMN/obNeSjPWwewYh65piMBCgbkxJwT16/xBrQrjQJmFSvTaNb
         cGimijRDjA6btP8dxgiSj7ANgSkjEFNaiCFEAjaz41HNf6B1juZzjBbQI3mbl85Rm4Nu
         FAYI94J0a9rxg3kQARSPmCfiMv+IF0NiUe4A9NPKKKW193fi0wC67RYjm36BLEJ6o6c6
         M2C8SmzMhKVtlrRJ28pxgZZyFT59iTL0eTSr4NhcmD3c5R0W/LYUma7w4zOlnfg5eXhz
         9n+JwavJOEwfm64BQvtnuZ36exPXhebTUIK4MAgWLzn2jjke/WOcZIgu/HuLfR4jV4G2
         D33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776559230; x=1777164030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8hqGnhqQvo+1kHYK672RCa0BshwCk42qeeZrE4YnGQ=;
        b=aB0LCCXlZHK6NJAiYkw0ZfRvB9dkjAcA1Fog+RMHUUtSVb8VI98VXd96C/+BoQH5m5
         x1Z6jclldqQe+QCnVntmldZTQWuRTu/b+NBlDfjGtn/by3rW4v4cCHkcgs7NNAyXJyYz
         455cCCOG7KnHqIypmF/YDuaiK2hyOsr4lm/B4dwNll5nj0G7jD+txUX80MFI5HUksd3G
         N8/IeJsbABIjOq0f1bHfyC+gsXoBRCJtoQJDUQV2j/8PRaVfA7ozmHK23M6oIICE6w3L
         2nLBmTCsZx3Eg/XBwvmM8V/j09Bu5+UKzT29hn9Lgm6YhcxvjGln6BFGeskAy4O791QC
         luEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tP++4C0pj02t7zW1Y9K2cnVWcLSTzgku5YzGZa3HrjkW4wTmX7cxL2e8WY4hGqv+i246Qdcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT975RVnjxaRRRaDknRVmPofgc6kxA6OYa6C2DMT07hAARiMCS
	va4W6OmK1PB0Fbb/Lqp1T9V/qCWEFvD98Tg9bU/wa7yJRRA44Pq7VVETnGeT/dy90uYANw7r6IO
	ZThx1xc+3LvhucsHGcQVbKUa5NeFD0PTnBBmRC6fmdhsEmaVJrjGINzktNP0=
X-Gm-Gg: AeBDiev/GB+TqyIubUfaubGA1F7kThtU76G6JMJ5o2Hw1YfLo1Uvn73Pv6B4MQd2L0k
	p8AFWAZvkHobr0uFkwYq9SP/rnO9WmhPNDpooQtM0yyCc08KOUMYTkF5TtCbz6xDb6T/WJP/30s
	N+oU2wZVjP+zOJrp3aBcShWwZTr0HCokMHF8ID1hGj/QQhERRN2YksXpYG8lw/uT0QEKW2TVCUD
	YTkJt0fqS8GZ94Upeo5basmihWThUTGffFimFqfF+kOO2Uplm2HfLb9kRBkchY+liZ9Omw+JF7R
	H8CYGlaUIN+y4apQsaGD+vQ+PkOJGZ8YqSRBtNq6tAP9xezaZsIk82+3ob0Lsp75XSkCEp338C0
	hukbTk57n2AW4a+oyjf02j0LxNq56tU4LMaUxA8IJN7L+jR/CgxRejQFXj1S+/VYuBDGz6MCsg3
	VaYr86uxdPs9xUPHz42AG7ZxrGWCsaZ8VW0Fthwn8iyOwHdQ==
X-Received: by 2002:a05:6102:ccc:b0:602:7589:6545 with SMTP id ada2fe7eead31-616f7947776mr4090297137.28.1776559229837;
        Sat, 18 Apr 2026 17:40:29 -0700 (PDT)
X-Received: by 2002:a05:6102:ccc:b0:602:7589:6545 with SMTP id ada2fe7eead31-616f7947776mr4090280137.28.1776559229330;
        Sat, 18 Apr 2026 17:40:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f669dsm14484791fa.14.2026.04.18.17.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 17:40:27 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:40:24 +0300
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
Message-ID: <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418101936.7731-1-rmxpzlb@gmail.com>
X-Proofpoint-ORIG-GUID: QW7uN6w4SrWnil2yKj7jGQ5rt9VPWc-F
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69e4247e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=7Tts1Zsv5J0H2K1XiSQA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: QW7uN6w4SrWnil2yKj7jGQ5rt9VPWc-F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwNCBTYWx0ZWRfX4oLm/9aOo3rI
 DO82EYuui4H8HhbNZrH3FB0Ya2ItDc/8dPoo/MHXFmvxz0912c24w3MUHRJr4XPmnDuA4byeqM/
 g9bhW9syNCyjFVLnlAQLYiZyiJpqPJRngeKdFPl8BMCVf4rnNNq7pMrr7cWXGWkREbyyDbaVTNM
 F3esq4Wij6Rg4yHNHrg8C8ovMGDhra39RIJS49wNqTQgHo270Ufiow3b7RwuHyi2YgnWu1Ia5UI
 /tnf2ASw6b6J92y08vgjXakc6518pjHf/hyXvpnwPZdK/Bee6BkEgMgU4p/6NUsXvgOdMxlLn7A
 BSgldqI0sXCmn3MGVHaOZLynvsKLbYIvtzAhwUD8R9aoNhILTJ5FyF4Wjy5s1/oM8rdLHiHWreS
 vlZrJl5ETA4umCjy3PzFwp9RcrTazoBKTmzPlRuZI5ps933ndFwiorMtVzm+R06KEywUXcGSYJr
 Y2MFnDMJ1Noz5ne7Ojw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190004
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238618-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8D732422C4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
> The following panic was observed during system reboot:
> 
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
> Call trace:
>  ...
>  regmap_update_bits_base+0x5c/0x90
>  dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
>  drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
>  ...
>  dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
>  drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
>  drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
>  hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>  ...
>  snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
>  snd_pcm_release+0x60/0xe8 [snd_pcm]
>  ...
> 
> The root cause is pipewire tries to close the HDMI audio device after
> atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
> 
> In this case, dw_hdmi_qp_audio_disable() will call
> drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
> accessing registers without checking tmds_char_rate.
> 
> Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
> if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> 
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> 
> ---
> Changes in v2:
> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>   the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..7760527484c8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>  
> -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> -
> -	if (hdmi->tmds_char_rate)
> +	if (hdmi->tmds_char_rate) {
> +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>  		dw_hdmi_qp_audio_disable_regs(hdmi);
> +	}

Will audio and audio infoframe remain disabled after consequetive
atomic_enable() call?

>  }
>  
>  static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry

