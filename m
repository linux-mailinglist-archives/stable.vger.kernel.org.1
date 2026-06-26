Return-Path: <stable+bounces-269290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hvApNMDMPmqdLwkAu9opvQ
	(envelope-from <stable+bounces-269290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 21:02:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32F6CFD5D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 21:02:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FstiwF0N;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269290-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269290-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BE9B301F4B3
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AF73783C0;
	Fri, 26 Jun 2026 19:02:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137D78F2F;
	Fri, 26 Jun 2026 19:02:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500540; cv=none; b=h5xsAz9TOLDuS2gO3u71J0+7b0GvfLTnhPM77o9eR+9iJ5n8ufncU6utIpiByEiWx/MrK0ZwN3ZxpAAaYg28Vr/lWH40vPzSWHpvkHe1QYmntflZ8m3oqYQHysefba1M85JOwMe2lBIUufHkuF+zpMtziFXtydZyCD0cfEc1xN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500540; c=relaxed/simple;
	bh=4ulhjQOPoFSOF5+tIsxC8bCDVBvg+u6gurSEwkxYMnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDDqIIhMz9wTY0Nqf+MnBAE4XOxOGeopO2GXgwTzCSoMBMktC1RuvA6JzDxgbAFDdChHAUJBnygoHk7BWnY9NXQKjmtrxGf7b9R3eFUgFCv4gBvHclwfFHP5Ap+hOlv/1iREX8VWKQAeuVzCQbBzylM20s8AZCKTWmOjeEyEgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FstiwF0N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02B91F000E9;
	Fri, 26 Jun 2026 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782500539;
	bh=UUIgku0dEeTkAIbEWbmP2c4kgTyRAbCcRnpJ75y3OUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FstiwF0N2TKXY0zUW6qxHZC2DhJ7UIsuxklD9FRC7G5Ub6nedrarR5rIBl62qwf81
	 DAzynZykkyWrvW5K7JOzHlBQLiTqUUaBhY17H9d5DsRO1PjBifTpMzGM0OxuLlJ/FG
	 3m7PYebotrPF7kBpbtauyfrSxcbJ3FLCxiB1bQQPoe14IHV5tbizpn8RPexr6OImz8
	 CN4L3Ve3hxRFNYHDsWNoi9XykmXOopwmIhQU/q6KoqMQUrVX9f6gYm4CAE2dzcM/7g
	 bzb00ieDYhxGq1puMyvJkrkAwRWfMqRR2GTqqKQUJwv/IOMJ0MGU9ZTxFoS4+sQtHg
	 mOku3Cru3MR1w==
Message-ID: <9b3b135c-0e9d-4439-bbe7-877ac9824249@kernel.org>
Date: Fri, 26 Jun 2026 14:02:17 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: drm/amd/display: detect_link_and_local_sink: DP alt
 mode timeout path leaks prev_sink reference
Content-Language: en-US
To: WenTao Liang <vulab@iscas.ac.cn>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: siqueira@igalia.com, alex.hung@amd.com, timur.kristof@gmail.com,
 wenjing.liu@amd.com, Relja.Vojvodic@amd.com, Derek.Lai@amd.com,
 srinivasan.shanmugam@amd.com, clayking@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260626124555.36910-1-vulab@iscas.ac.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260626124555.36910-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:siqueira@igalia.com,m:alex.hung@amd.com,m:timur.kristof@gmail.com,m:wenjing.liu@amd.com,m:Relja.Vojvodic@amd.com,m:Derek.Lai@amd.com,m:srinivasan.shanmugam@amd.com,m:clayking@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:timurkristof@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[iscas.ac.cn,amd.com,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-269290-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[igalia.com,amd.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A32F6CFD5D

On 6/26/26 07:45, WenTao Liang wrote:
> prev_sink is unconditionally retained via dc_sink_retain at function
>    entry, but the DP alt mode timeout path inside SIGNAL_TYPE_DISPLAY_PORT
>    returns false without releasing prev_sink. All other return paths in the
>    function correctly call dc_sink_release(prev_sink), making this the only
>    missing cleanup.
> 
> Cc: stable@vger.kernel.org
> Fixes: 54618888d1ea ("drm/amd/display: break down dc_link.c")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied, thanks.

> ---
>   drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 794dd6a95918..03bb210ebab8 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1069,8 +1069,11 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>   			    link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
>   
>   				/* if alt mode times out, return false */
> -				if (!wait_for_entering_dp_alt_mode(link))
> +				if (!wait_for_entering_dp_alt_mode(link)) {
> +					if (prev_sink)
> +						dc_sink_release(prev_sink);
>   					return false;
> +				}
>   			}
>   
>   			if (!detect_dp(link, &sink_caps, reason)) {


