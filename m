Return-Path: <stable+bounces-212936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A1pXGwrFfWluTgIAu9opvQ
	(envelope-from <stable+bounces-212936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 10:02:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44084C14FD
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 10:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D235D300BD85
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFBA2D46B2;
	Sat, 31 Jan 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BtCPt0Kp"
X-Original-To: stable@vger.kernel.org
Received: from mail-m15597.qiye.163.com (mail-m15597.qiye.163.com [101.71.155.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463B284672
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769850117; cv=none; b=rh+wkVLvEuw1vmhfBAGITjRTsMGVPmwtcEbbOU7ebzeXoYtQWYMAxZJGsHgU2gWDVoceyfqkBRWVRwmoDh9rQZds3UIw3XWhuLcojGWTkRAwdfs3uOnam4gZ8y7yD6W7oz3VPbyoviHC3Liy9SEU02ULh/aGezf97LK/+QtFLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769850117; c=relaxed/simple;
	bh=q5zAwWJ5OViU8rtnwwo4W+RKeWgEirkEfGhOCmj17pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REfgfYJU2fMaHHKstFa8Qj/9ThYUVJccrV4B4okX+r6ZXvcbDpTUi2C77ImVO04qORivUvrpCdkAeoCj8m9J7ctdBuG6foe6PlV8j53PWSTuEStnI7oOZ8vCAQ0fYOZdRPY370cE9uqtqEA7XmIZInl0AcDe5rbutqpx/8tB/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BtCPt0Kp; arc=none smtp.client-ip=101.71.155.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.51] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32a4eb17c;
	Sat, 31 Jan 2026 16:26:11 +0800 (GMT+08:00)
Message-ID: <4855e4f6-a5ab-4735-9808-83c4adf306a5@rock-chips.com>
Date: Sat, 31 Jan 2026 16:26:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/rockchip: cdn-dp: add missing check in
 cdn_dp_config_video()
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <adf6b313-f7db-4d8f-9000-8c65446ba041@auroraos.dev>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <adf6b313-f7db-4d8f-9000-8c65446ba041@auroraos.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9c1328dda603abkunm096245786fd915
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgZSFYeT0IZTxpPHU5PGk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BtCPt0Kpcz5TawjOxWrSNM1ajfmdQduEdCw8S/PIiCtJPzcDdwTNDMRZy61Kh8jK/pjOox4RcthoLIG/zFZbkyhMjlRcnaKFaehbNo8oY3yirP6kr1DP8+9eQuX+zWI+/hhT3G5g1zyTFD0e86rwvLInsy6PfcAFyiXAKinnbNQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=mARx+b1Q3aoFUp5NQEI2ofWrMi9GfyBXAGYq1ttozEQ=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212936-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rock-chips.com,sntech.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaoyi.chen@rock-chips.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,auroraos.dev:email,rock-chips.com:email,rock-chips.com:dkim,rock-chips.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: 44084C14FD
X-Rspamd-Action: no action

On 1/31/2026 4:35 AM, Sergey Shtylyov wrote:
> The result of cdn_dp_reg_write() is checked everywhere (with the error
> being logged by the callers) except one place in cdn_dp_config_video().
> Add the missing result check, bailing out early on error...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: 1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> Cc: stable@vger.kernel.org
> ---
> Either we need to add the check or drop the assignment to the ret variable
> as the value gets ignored anyway...
> 
> The patch is against the drm-misc-fixes branch of the DRM kernel.git repo
> on gitlab.freedesktop.org.
> 
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> index 0dc3804051a9..9b82b27770e5 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> @@ -685,6 +685,8 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
>  	val = div_u64(8 * (symbol + 1), bit_per_pix) - val;
>  	val += 2;
>  	ret = cdn_dp_reg_write(dp, DP_VC_TABLE(15), val);
> +	if (ret)
> +		goto err_config_video;
>  
>  	switch (video->color_depth) {
>  	case 6:

Not sure why this was resent, but it looks good to me :)

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

-- 
Best, 
Chaoyi

