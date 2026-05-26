Return-Path: <stable+bounces-254257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC22JNZIFWq+UAcAu9opvQ
	(envelope-from <stable+bounces-254257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9C5D19C6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2466D3013011
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0293C8C47;
	Tue, 26 May 2026 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCbTSlD3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6833F585
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779796; cv=none; b=JwtgZRxP55fvVU+P6e4IRvW/sEpjoCy2wzDDXGotPnj3rh6d2ZxNIXlHm9ZhwNDxnZspVYaDFcIlkzwnDkyr+GtPBg+eKh5nXSruG260hIF/eQGEduZQli1Nc0WKOQzAQOE77Al17/+aE34XWeceS8i0nQYaTplZdZZE/pFlWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779796; c=relaxed/simple;
	bh=m4+IQOo0EGMHhlaHDqYgTldeZO4rGpI+3vfP+VqwAgU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nF2vip2xgqZ8N15q5FsY8ZHs4mZn0krLMgeCUWQD4TFScKLP5fe9+4Cd6v3X2R2FI/2obedWGq3KhhK3nifnuavlS3rZTOoJSf2+GaZr17ErXNjJJjevIE8WIVx6GiBVbML3B2UP7vSNNSWOdPRTi9W7fi7yjgBkMxgt4sza5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCbTSlD3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so75233685e9.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779779793; x=1780384593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qT/bMdEBMK/k6bRtXEjwywoU6w4KQoZt190nLYNxOs=;
        b=lCbTSlD3hOd/qg2Ihto9HlrGI+fN426xP13mohXiDfpFqJdGTBfxwYgY9lxCeUTqKn
         HS3WGwK6I5cuVWBZZoqNTS1qMm5zhWaqxdR1NbvR78JyGpuYkFkLbQOSeWyxRWN0J8oC
         4ah4sTsCfdJn1fkLqxVoxM5vnc4Apq1a6V/DJKU4RzlGk99Ay69F43NAO+HZfseY93cs
         BvIi05JZ4g8k0y7RQWJYP+naKTHtgUMNdsVOh9PpMeYhQNQPcZlXW5Z8cgGyhcF/FIQm
         QGPwLu1NpC+yHR1S608HwHsgre6/HHXckZpvC+iWyIp/c9XEjr9rcmIEq57JccIugIh3
         TMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779779793; x=1780384593;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qT/bMdEBMK/k6bRtXEjwywoU6w4KQoZt190nLYNxOs=;
        b=hyKmXblXZ1wY1gDAu4truo7alQhSz8cYD0WfV5mKcTIGHhE7wLKjdRUwr8H6OevbaX
         KIFvLwQebzcH2hzKrvMaW1y2WnUhUCK61wRo1rY7MrHvhWXdNXyXv4/5inWqzF2568Hu
         moUTSerFSp9ESJhkRphZcR92rTaSsoN3ZeQ0O5pR8qB7hw0WTAmAS9UFAYUnIu9dqrY5
         oCHvumMrTFF2OuHJG7le0uE6IINlvGnHdGsPraOUiK9yWNzoC9CDsRbLuJ3MFoVCriFv
         oxAXa40tyFO+cxrHjHSF/3qN76YApWtTDUQkv25R8sqLyNKDOL3e7Pwiu3RbGpPVmEHi
         LVsg==
X-Forwarded-Encrypted: i=1; AFNElJ+Lj5tIOSp084VCG059QyP5ha39DcfIOznqgwnK+cNdgNKBLHFHwggEMNyorOhh7Y2bY65Cz4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGgWhprYzQDXcOgxI+5Eq41+Kl5vAuiJz9JCk5Nml3UgTofna
	EuEOZBKX4mxSYMeHoxGbP36kLDCFA0JuAnMfpzFxXQlOD4J5gDKnocCLh1u+MvI4ATQ=
X-Gm-Gg: Acq92OFV/4/fQ4a56wiHxg+0E7O9MAeXqSosgh0Qi+67MIoUqDJMeYhDQld99vXDZpB
	xnflCPXYfUL3dNa0VN4vhDIAPIj9QNokOjTOtw7nAD2eIA2gRR6PrCx6qTJCozj4Tdw7KZ/XZop
	kRFLGDr5fCMeY4hdsnU8PA+duoQPSA0mLziWxMhHdrYoS+86JnnlEz9gKocTnnf4pclFKF/peUc
	wPKxV1ubB5W9G4uk+tWRY6Q4sC6ewIL6f7zIPW6XGwnA1yP1ZiSk03bRv3RwDYsDQ4SxZpyyOrc
	cGeQLZz78hnm4jHc1TlHeMpK4mkoyoDP6UqML43HyXS3TwdcgvXJXdFH4AfmMFppL6T83EiblPl
	jsPFnISKMC4A2tZQgAStisNAi3MpZEba6lSvWLxyY8GfxlaRCso0Jf9KYYglOq5SwwncImmqpXE
	UquPsDTZ/wPHGAJEX4y2aueWG4IKtWcMBj6+JYauUHbyCS3MqM7yFvehRUMa4cTT2wtZRON/V9r
	mYn+1HTHmY3fdcnSw==
X-Received: by 2002:a05:600c:4591:b0:490:6869:46c6 with SMTP id 5b1f17b1804b1-490686947a8mr90737495e9.31.1779779792774;
        Tue, 26 May 2026 00:16:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a? ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526ca21sm299610585e9.3.2026.05.26.00.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 00:16:32 -0700 (PDT)
Message-ID: <147bb128-a77c-49e4-897d-ba6ee1b1449d@linaro.org>
Date: Tue, 26 May 2026 09:16:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/meson: clean up KMS polling on register failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260524160657.17802-1-mhun512@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260524160657.17802-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:replyto,linaro.org:email,linaro.org:mid,linaro.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,baylibre.com,googlemail.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254257-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 2CC9C5D19C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/24/26 18:01, Myeonghun Pak wrote:
> meson_drv_bind_master() starts the KMS polling helper before registering
> the DRM device. If drm_dev_register() fails, probe unwinds the IRQ and
> DRM device without stopping the polling helper.
> 
> Call drm_kms_helper_poll_fini() on that failure path before freeing the
> IRQ.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/gpu/drm/meson/meson_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 49ff9f1f16..e49de5df73 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -352,12 +352,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>   
>   	ret = drm_dev_register(drm, 0);
>   	if (ret)
> -		goto uninstall_irq;
> +		goto uninstall_poll;
>   
>   	drm_client_setup(drm, NULL);
>   
>   	return 0;
>   
> +uninstall_poll:
> +	drm_kms_helper_poll_fini(drm);
>   uninstall_irq:
>   	free_irq(priv->vsync_irq, drm);
>   exit_afbcd:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

