Return-Path: <stable+bounces-231220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F2DFvJ5ymnk9AUAu9opvQ
	(envelope-from <stable+bounces-231220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:26:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B689D35BEB8
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5FF530649C5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AFF3D16E6;
	Mon, 30 Mar 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtAx0egD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922F2D060C
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876592; cv=none; b=FsWftK4yw27tcECmbJLUs1Db8K7PzJBPLKACkTQdYu0Er97ARpQUNQ5oYri2RTqrOxLEWsslns0QWUzE0WxtEqelAnsFw5iQjbD9OHn62zLvs+4il6FPQbxPwgl4b6Ck6r3TO5TFgM5pj9BhxS567hAWUWLT6MtNrd8bJ4z7qlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876592; c=relaxed/simple;
	bh=zWF4UgzvVABLXHuPwtVbkqFJoZ3qrTrWiWP8wKnX+MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiujKUc/oVFm7DqGyEh0cMkPMRYcIFiQNu62LNfe2fx/fbBXHublsiS15DHwg+Mw4IP9wQ3Z4p+DS2Lai7zLsv+xjYUDBBAjxfBEt5L8oN68er54Xx6Rff2voMg/S61BvT1rDJIFd2zohO+dtKvmv7SAPWFamQIFMsYLFeFQ6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtAx0egD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fb439299so41067175e9.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774876589; x=1775481389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1C10NA1cQG8ePlBzaiPYyKeha1tOz/zSCaYB7MJP6w=;
        b=JtAx0egD2P0C8rcAt+nJMX1vn0HZBt1Vfd1GBemWNsa5TgMEVMQ6bxmc9sqUjAFAv+
         Fna0HTuSqEMzlu24Hr5VTxklBRQWjivdQP5kwCuNw16Q/T1RmnKK1p/Gnr5vJ0YCoTGs
         W84Mk3LHXr5upxadj3lEpTiCowbq0Yhptip4tt1wPNYqzJctacPxqZ8Rlb0qM1kfEtts
         Uknsy0w7Tiy/myQ6Qe8rvstqDDdrgTPOaKeLj123EA6pejJa37XnQs/4ad9uxskS8Tiz
         y9ZiKfHRlYfFWeSBulrkhqSbPCmOFHf/TYzVUnEaNG2P0Hhy/OjHTk+iYg2TlQJ4BWeh
         RKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876589; x=1775481389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1C10NA1cQG8ePlBzaiPYyKeha1tOz/zSCaYB7MJP6w=;
        b=V/ph8AM5ENVsxeyJKl9KUELGMvzlbdb706UENl5KR7XxjsU6uBqCgByYQ9wYQdzMmB
         VoGXMcHqeXsvPOjSqx05mdvWsqcn4Qm0ZCT0tK3ZKH07qY3RpUeVq+vSpXAOP1Uef743
         OEAKZZc0ysU8b6satagZYunt6Clp0ROcld/yuHgAUbkGEcYi2EwNan8x0LACnTMMNJdI
         lPnoiYeOsU4ttzWT9s4op4nGEGrKhoOhjdhma0cNBhoQbrfYRfBRUzTWUL6BM2SRiF9+
         mLoy1s2LzFyg4MXHbnvFps2rZyh/0VZXB3C9CzRAyxDewyMyxrGz62lQymoTldlAhpFE
         3H0Q==
X-Gm-Message-State: AOJu0Yxcdfs4E3NqnxGTdetEVbQDaXlz/Hfg4j0iXzr4Xt8Go4D8VMtO
	SCN5raCOzKfJDiiiMOSEUsi7dZkX/CJRk+JFsEOi6toZokf2BApJRJw5gwFwC+ms
X-Gm-Gg: ATEYQzzxrjh8E9vH+fIZV/q7JiikXXfxdaEMGdMBmJ1WCHFAXbi385OBOVEa2VICHkt
	9F5FnVRv9NwnSqaJxCU1/8HuWDZgSTItXtCAI1toHa+1vS1x7gof6BdaKPFoUW1tSGGWWZlhqA5
	LYccqh1aVMlETGT6TWK3Ba6lSfmw2PhQHrDMeHkPjvCnAzdXG04mXMXPxC0Eh89J6Uje8U3JTq9
	wXyxWVXinLNVV3R39pA6tivMq1yVLeZ2qcjEoF/vEpIoIG/KL9bo2gL7Q1amBrVSXYNuf6o+Kw3
	B6FZWMQ6EnRZKQ6tYPqFjUVAR2+8qq5cvaSHNtk+E959qCBOk1eoCeZ0azkyG+42hEdFZ4MKLNV
	E0BOV1b2QSV2DDF53MJtpi8H5biVOgP6619VspWcXWmGWe+5mgmO3CMO34crEMs3FIM4i9yPA8e
	lymJbIciv4jbGdLTRIzylw5zkXPTsDgSIdexE/nCvJ9KOiCF6J8OP4zDipfCYZrYceRmGpts1a
X-Received: by 2002:a05:600c:1393:b0:485:3c8f:e4d9 with SMTP id 5b1f17b1804b1-487280a09a2mr210977455e9.26.1774876589201;
        Mon, 30 Mar 2026 06:16:29 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC26F.dsl.pool.telekom.hu. [94.27.194.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872718dfdfsm78504085e9.30.2026.03.30.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:16:28 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: stable@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6 too
Date: Mon, 30 Mar 2026 15:16:26 +0200
Message-ID: <2312151.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <20260326234716.16723-4-rosenp@gmail.com>
References:
 <20260326234716.16723-1-rosenp@gmail.com>
 <20260326234716.16723-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231220-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: B689D35BEB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Summer Time =
Rosen Penev=20
wrote:
> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
>=20
> It already didn't work on DCE 8,
> so there is no reason to assume it would on DCE 6.
>=20
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This patch is incorrect and should not be backported.

(Note that the error is already fixed upstream. For stable kernels IMO it's=
=20
best to drop this one.)

> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> df69e0cebf78..7dc99c85b8ea 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc,
> struct dc_state *context)
>=20
>  	get_edp_streams(context, edp_streams, &edp_stream_num);
>=20
> -	// Check fastboot support, disable on DCE8 because of blank=20
screens
> -	if (edp_num && edp_stream_num && dc->ctx->dce_version !=3D=20
DCE_VERSION_8_0
> && -		    dc->ctx->dce_version !=3D DCE_VERSION_8_1 &&
> -		    dc->ctx->dce_version !=3D DCE_VERSION_8_3) {
> +	/* Check fastboot support, disable on DCE 6-8 because of blank=20
screens */
> +	if (edp_num && edp_stream_num && dc->ctx->dce_version <=20
DCE_VERSION_10_0)
> { for (i =3D 0; i < edp_num; i++) {
>  			edp_link =3D edp_links[i];
>  			if (edp_link !=3D edp_streams[0]->link)





