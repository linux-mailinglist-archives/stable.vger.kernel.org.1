Return-Path: <stable+bounces-66089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A194C6B8
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 00:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE4282F05
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 22:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675A158853;
	Thu,  8 Aug 2024 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O+XzCVyJ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1D146588
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154799; cv=none; b=VbIbNfL+nAwNvhOethisAW9brDSDsAepgrvE/WgIcTQXgMRJitRAPaMayhqZK6IFEMPXhrcCkKCiAcVEV3qxJ1Tq6jx4aeObi/Gye7jA0j6JLKcaGmyzZ+HfRYeKzDf2iIf9nUo+XcjhKHzOtWNr+WWvZYHnIAN7rEMUI36yF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154799; c=relaxed/simple;
	bh=vrv/30XzLb1vChdJW0eL5Cdqb+rAOg+SDxBmC0p8xRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfwXudTc5TWfBDrdfjVI9DDkjDpf/4mth2mqu64IRyHxR+hc8ohFDBDIKq9bg/fS6A7hGmxwUfKgNyUn8uq1K5bRlMyfPU3w4Sqg2V9jOAe7amjl0fkjHxdntB7E9bVqXxO1SUx2Q1SXPsTXXvyunsAKfObX9nv5hAXPynBMXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O+XzCVyJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I/2PEdc7CHTMGBbIBTClV7gz3ZgRK4vf7audyH/ULUI=; b=O+XzCVyJ24vs5NERlXe0UfoMNH
	Qtk02b9Zz8+htTwaG7DaU21s7iwPrPtha804kbGuTpRKVYOLtFblEb0CQ20F7taqLhAHTYW/8zTDo
	enX70fVLCgB3AcXTiXuLMs+9ljDiFpURb69/4niww1ZnxCSMiRJS4+qLiDmldPjNzwK8zb20+wCEE
	5dZxU5hfh7yLiFbrv/Qqgdc8sd7Ej1CzrjkbV9b2bX2uYIBE77YkNi4kJYnAd7dYHi1bA3pHVhVB9
	bP0wpjjLZR5Rvq7+GrEkpYtXixinxUKIPHqnmskx0n19KeiqD4UuBuEarSZrQ4NUzi2Ty+8+J4iOQ
	oaQDwW7Q==;
Received: from [189.6.17.125] (helo=[192.168.0.55])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1scBH5-009WT0-1B; Fri, 09 Aug 2024 00:06:23 +0200
Message-ID: <24bdf1f8-4661-46d1-9f5b-3cf835e39c22@igalia.com>
Date: Thu, 8 Aug 2024 19:06:16 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] drm/amd/display: Adjust cursor position
To: Tom Chung <chiahsuan.chung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, jerry.zuo@amd.com, zaeem.mohamed@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
 <20240807075546.831208-23-chiahsuan.chung@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20240807075546.831208-23-chiahsuan.chung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/08/2024 04:55, Tom Chung wrote:
> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> [why & how]
> When the commit 9d84c7ef8a87 ("drm/amd/display: Correct cursor position
> on horizontal mirror") was introduced, it used the wrong calculation for
> the position copy for X. This commit uses the correct calculation for that
> based on the original patch.
>
> Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on horizontal mirror")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> index 802902f54d09..01dffed4d30b 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -3687,7 +3687,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>   						(int)hubp->curs_attr.width || pos_cpy.x
>   						<= (int)hubp->curs_attr.width +
>   						pipe_ctx->plane_state->src_rect.x) {
> -						pos_cpy.x = 2 * viewport_width - temp_x;
> +						pos_cpy.x = temp_x + viewport_width;
Hey,

AFAIU, this patch reverts the change in the previous patch.
Or this should be discarded, or both.

Melissa
>   					}
>   				}
>   			} else {


