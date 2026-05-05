Return-Path: <stable+bounces-244004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQOClii+WnR+QIAu9opvQ
	(envelope-from <stable+bounces-244004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:55:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809054C855A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7257301052A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E073E4C6D;
	Tue,  5 May 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6w+ul3j"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A23E3159
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967672; cv=pass; b=OK7nb/T6BuQLLnde7+ejCl1IixvOy8sv7jcmCY1Z8nh8HMw4dpV4bBZthFF+6wDsxksxMIZTlTBJofUtE/5TMO3EP/f/8wX6GSZ1DIhD2UoqfseeuCIOJs8xZ7XF43/A7bsg/PKNAeQuvv5aVdOeOk3mnx578kfzDZoCxufpsQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967672; c=relaxed/simple;
	bh=+qJ4YHyeQCm/Bg4W28ChXgXo4YJ3WH+NhGRvqcilHzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JP7PW6Nf7pUUoriHKpUuy9FNIPclzUjnMgfPoN21LJCfm17fu1Dn2RQFdzLYSp1fTnuBJO20YLQ6Iy5gGjqdJo9VubW8qFwJ7r9ljTc5iakeO86OXQAec1gQwUAW1GCwL9SdMaOCAidnYDbRthtWwv4BIxCCNox/bJc7g/4WEgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6w+ul3j; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c21049dafso4623744d50.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777967670; cv=none;
        d=google.com; s=arc-20240605;
        b=M2aHl3nl8kGpa+OW/b8YCiplXr6QVxu07JXJE0QyUo/YVEYccInYPiVjPjphbI06pX
         z78OHWg6uOi60XHsx67g5O8NxqamZ9mOsO8mOHqM0oBC11lgrxi3B0vRAHEge0rwu8VG
         ICbBosYkkpkxRhovRmCrOJvcJ4IpkTMeuQ2HkpCVpgG3bn9yNz3+2VEyeTWdy+RyDkgd
         ugQnKma4GUuc3RfHUs+i6khjxQl65WA3FAJGARfOShhtiWT+xwvYdetTDrZe2zWuz5tA
         1zwBz10Y1eUE0QgMUqh3gx8F6cEZzH/DRBxMhKXxcfeLlMdOaOgbJ0ax4I6o9JV6kryu
         aLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+qJ4YHyeQCm/Bg4W28ChXgXo4YJ3WH+NhGRvqcilHzs=;
        fh=SfyqdJ142vfNH9tleu/w1nsRjWEJepA3lyyBlBOKFbQ=;
        b=TsgbzpNCD1Bj6ZgZYAjQ83+lRNQ4Pzvypq0wthEoIdmBUpBc+RtIG1RbACEG3VaK1A
         N6lQxpOezDTlxbxnXTokAdKaAIHIqA0gOaoPI8MNAf4DqoPlumjC09NstYeDly4MNdYA
         z87YTXAUfu+0jQWpOwmyxKZOI1hIsEYmw1m4Ane12u2TnYnuyN7G9WhYwPieS5mBppVY
         dqgCG5RoE4zjrfToGXYY2imnWF7iAOAGLbp7071J+d+H0XJ+/TUd2w/LTbe4Z7MPDAK+
         Ycgd/iDYeYuY7AegnFgPtlBLhd+MBCBNOPJAVqmrfh6JHpejtgKRdPjwq129dYkSwLNq
         y2aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777967670; x=1778572470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+qJ4YHyeQCm/Bg4W28ChXgXo4YJ3WH+NhGRvqcilHzs=;
        b=d6w+ul3jm54RrZpyA99cT487o8F43waJIaEXmYzNgOiuR2Bb0lL/OVktCqp9yvYV2p
         hCDofHovUxMsPUsJfqAEffjXvk+t0HjZpn1bkJ7mfIO3f8OkRile2pMJe256mzf/mg0V
         qyU40mpcDfxz1vcaXdHpmJaxNxAGDHioFeVl4o7tkT2o0jEkTvU0iD38XqpS//FWQ8mI
         qK/M9yAOUps4WD14nvTnSx/pHUvNyMrIiQ+rmGxqvEz53PWFV/aHmJ+JGz/byBNgpGQo
         9FpkFrIjQWh7E7A23J4acwJOovqrdIBdJZy2OuX+p0XuVE1L5GMOdbcTF708sOqav45G
         UMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967670; x=1778572470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qJ4YHyeQCm/Bg4W28ChXgXo4YJ3WH+NhGRvqcilHzs=;
        b=l6QioXNcTm9bPxUmQGhtRDvQ9m9KrUf3qLmNMV3tMu9TftD/x7lvmuymaFU/c0V/en
         cyTzITwiEarLN4bmZ/sIpcAzi+mY/b4AAoQUzr5pkcujCJxKnnkwMcYP3henUDJ0L8Dw
         XT1jZULKna0FyaDu+EhsMr4f+ppIHMSRruhO0nDyQMHAYutnZ5FEuXiq6sCl0igTfNf/
         tdrFZNKlF7Iv6YRUt3Pu7ac77G2bnxHUAZ4qEGrQ0wL2c5bQjBwzN0iGiUiMVzGiBwtQ
         93DCizK1wlPc9opqesdAL1U0GZS2wYDfH2hjxNBE0cZr9EI/z7UEDqYyZy9QlGYp4v7T
         mMug==
X-Forwarded-Encrypted: i=1; AFNElJ9sPBKo9oAuIeU/5cY53f9NuGVIYd50FI8dKG5l5wD6k2URqIIdeb2qaqFoGWuHTFSuXtnBMmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6u1IN1sfrxi6KPUJw+fxaVRQgRpju1Z2kM/kr9g9gS0JccyQZ
	Tl3iML9Sx3IYTVYnuqUWogwm2POj7PE9baluxAyWjUSkp0NqTrysQY/qaC3xmEjEMzXz7YIJ4kz
	bRp8V7c17fWc7E17/f3Mc1mR91M7S0Xg=
X-Gm-Gg: AeBDiet3iRfyJ+UF2YjrZdGrbwSTGEpk9WssiYE4HrziE90y+70cXwNTL805UVlyxA2
	vd7816ItgQELjz5uF5yA9Sn4F8ybH6vN6zwi/NOc1yD3DTjraYCpbYrxA4Gew/khfnGLutiTPnr
	saSTxfnBH4F4ky3nUnWZW5i14qVMKYsxwN1YmadFYrjj+fMZtBHk01Jz4hlkrZjkfJdZQV8a8ji
	mrJy0oE75bGqLICc7sj+1aAp9H/K7ZWqvj/LfmOrGALX7LpLqZ645L+1drl+0Rh7+Jr98RAuw+k
	8ZYtcCmW5+EKll+8MMU=
X-Received: by 2002:a05:690e:130b:b0:65c:391:4553 with SMTP id
 956f58d0204a3-65c3d972826mr13438227d50.2.1777967670455; Tue, 05 May 2026
 00:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502115528.530401-1-lgs201920130244@gmail.com> <afju2dg8fZ_RSD7-@lizhi-Precision-Tower-5810>
In-Reply-To: <afju2dg8fZ_RSD7-@lizhi-Precision-Tower-5810>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 5 May 2026 15:54:21 +0800
X-Gm-Features: AVHnY4LouAC2lU1dj0J8xcKYYWaYsdxpQJ4QBxgr9v4zBA8FqVVNp9OP76U4_MY
Message-ID: <CANUHTR8VCdYS1NdTXU_P1hAkCwiZ=pbTApv3B3ShLB678Son9Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Frank Li <Frank.li@nxp.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 809054C855A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244004-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,mail.gmail.com:mid]

Hi Frank,

Thanks for reviewing.

On Tue, 5 May 2026 at 03:09, Frank Li <Frank.li@nxp.com> wrote:
>
> >
> > This issue was found by a custom static analysis tool.
>
> Nit: needn't mention this.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

I will drop that sentence in v4.

Best regards,
Guangshuo

