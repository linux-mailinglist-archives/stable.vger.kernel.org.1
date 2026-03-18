Return-Path: <stable+bounces-226938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKYzM/P1uWnnPwIAu9opvQ
	(envelope-from <stable+bounces-226938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B419B2B4AF3
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478353095337
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD50288D2;
	Wed, 18 Mar 2026 00:46:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ag.fintek.com.tw (mail.fintek.com.tw [59.120.186.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2BEED8
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.186.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794799; cv=none; b=L2BINw2TthikGRwAgf/eGPYf2QBptYXFOb5XZNepDI6uIEeOII4A4EKiUvw1DOdKCR275cScp7FHwuq9cBVVuDXxrjYFQKNPK0pV9+QZfxh2zjKkqEsBC1S6AFjggkCncOJclxi8wJ2wdMaLEF734Vs1n092Q0/lD9JXDUvTuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794799; c=relaxed/simple;
	bh=EHXA0rEU3xtQrylKoMO60rbXr6bKCtzKdE+PLkuqPOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA9bhKOEyCZm2Tcs8MPHyM8Jv1PncGK5EZ5U8OuhxKka+/8MOusFMCz1FpfCeMadlQh+aCds+BdjHI9PU/D2i1n5VPET+QGJeVp8FLZozG/EnA1MNDitDl34WC+EjS64hPtAMw5F+gxFG1WNGK9Ylc0iPkKA9577Y0w+qLG+Y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw; spf=pass smtp.mailfrom=fintek.com.tw; arc=none smtp.client-ip=59.120.186.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintek.com.tw
Authenticated-By: peter_hong
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62I0kRDa93086104, This message is accepted by code: ctloc85258
Received: from [192.168.1.132] ([192.168.1.132])
	(authenticated bits=0)
	by ag.fintek.com.tw (8.15.2/3.23/5.94) with ESMTPSA id 62I0kRDa93086104
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 18 Mar 2026 08:46:28 +0800
Message-ID: <fa0765de-68cb-4bac-b7d7-e2b47946aac1@fintek.com.tw>
Date: Wed, 18 Mar 2026 08:46:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Post-facto backport request: USB: serial: f81232: fix incomplete
 serial port generation
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org
References: <5bcf02b5-3fe5-466e-a1da-0e5a2e62fd5f@fintek.com.tw>
 <abkBUCw0BTh4wfqs@hovoldconsulting.com>
Content-Language: en-US
From: "=?UTF-8?B?UFMxMCBQRVRFUiBIT05HIOa0que5vOa+pA==?="<peter_hong@fintek.com.tw>
In-Reply-To: <abkBUCw0BTh4wfqs@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_NO_SPACE_IN_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226938-lists,stable=lfdr.de];
	DMARC_NA(0.00)[fintek.com.tw];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.868];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter_hong@fintek.com.tw,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fintek.com.tw:email,fintek.com.tw:mid]
X-Rspamd-Queue-Id: B419B2B4AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johan,

Johan Hovold 於 2026/3/17 下午 03:22 寫道:
> On Tue, Mar 17, 2026 at 10:21:17AM +0800, PS10 PETER HONG 洪繼澤 wrote:
>> Hi Stable Team,
>>
>> I would like to request a backport for the following commit to the
>> currently supported stable trees 6.1.y, 6.6.y, 6.12.y and 6.18.y
>>
>>     cd644b805da8 ("USB: serial: f81232: fix incomplete serial port
>> generation")
>>
>> Reason:
>>     This patch fixes a stability issue where Fintek F81532A/534A/535/536
>>     devices fail to initialize all serial ports during fast load/unload
>> cycles.
>>     The fix involves a dummy read to clear the device's stale internal state.
>>
>> The patch should apply cleanly to most recent stable branches.
> My understanding was that this was only something you'd hit if you
> unload and reload the driver which isn't something a user would normally
> do. That's why I didn't add a stable tag.
>
> The diff is a bit on the bigger side but it's all straight-forward
> enough so I'm fine with backporting if you think it will be useful also
> for older kernels.

Apologies for the resend. My previous email wasn't set to plain-text mode.

Typical users are unlikely to encounter this, but one of our customers is
currently facing the issue. They have requested that we submit this patch to
the stable tree so they can utilize the mainstream driver without needing a
separate vendor driver.

In theory, applying this patch will improve the product's overall stability.
We would like to see this integrated into the mainstream kernel tree.

Best regards,
Peter

-- 

*洪繼澤 **Peter Hong*

精拓科技股份有限公司

Feature Integration Technology

Address: 302新竹縣竹北市台元二街10號7樓

TEL: 03-5600168 #813

FAX: 03-5600166

E-Mail﹕peter_hong@fintek.com.tw





