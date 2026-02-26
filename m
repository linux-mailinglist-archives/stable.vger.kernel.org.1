Return-Path: <stable+bounces-219743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIyAHuiln2mHdAQAu9opvQ
	(envelope-from <stable+bounces-219743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:46:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB119FEB6
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17153025915
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1610371067;
	Thu, 26 Feb 2026 01:44:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AC4C81;
	Thu, 26 Feb 2026 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070249; cv=none; b=LauOA8dWj/jnh2s88apNbM2M34QfSVTfEfWxB71mqOrd2VE3NUeXsy/v7pnxzzoHdoA/mVUBF5o4bLsb8Di9K0x4MyJF6PH3uij8IrnyRcxaRdkjCVYP7xcE8MJbBM+aBADW0CuD5+9u6l2YnmuY9kcvQs11yxkgf7UaML6d/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070249; c=relaxed/simple;
	bh=mOiR9z4zzE5tI/yoyfPnX7sL3vgpbAMXx8SQypu1v48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOXp/AnZzjLhkaiB7Rq7ErGwDvCvahIi2P2CG2xsEYnxNi/CU69Id/9lka2K5cZWWdHG1hvtiQaBnO+qtIvFk8rjVzG7pTL4DK9+IL8a1y52KnEfoSlhoUphLte10SIVfsYg/eyaFwlzohDpg5kxkPtLtiU9u74fO9J6fdQdUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b300e8012b411f1a21c59e7364eecb8-20260226
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:c96f9365-1a39-45ba-9b9a-bd52d1b672ba,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:ead962309c554e0364c7908400c21514,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|898,TC:nil,Content:-
	10|-8|-5|14|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9b300e8012b411f1a21c59e7364eecb8-20260226
X-User: zhangheng@kylinos.cn
Received: from [172.25.120.76] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 164723633; Thu, 26 Feb 2026 09:43:53 +0800
Message-ID: <18b43378-0bbc-435d-93ad-370e051e8416@kylinos.cn>
Date: Thu, 26 Feb 2026 09:43:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/realtek: add quirk for Acer Nitro ANV15-51
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com,
 kailang@realtek.com, chris.chiu@canonical.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260209134149.3076957-1-zhangheng@kylinos.cn>
 <87bjhy0xd1.wl-tiwai@suse.de>
From: zhangheng <zhangheng@kylinos.cn>
In-Reply-To: <87bjhy0xd1.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[zhangheng@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-219743-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: D3EB119FEB6
X-Rspamd-Action: no action

> Can LED be controlled dynamically by writing to a sysfs file in
> /sys/class/leds/*? e.g.
>
>    % cat /sys/class/leds/platform::micmute/brightness
>    1
>    % echo 0 > /sys/class/leds/platform::micmute/brightness
>
> If the direct write changes the actual LED status, it's not about the
> sound driver problem, but possibly some plumbing in user-space via
> UCM, etc.
After testing, it is normal, so there should be no problem with the 
driver. Therefore, I think this patch can be merged as soon as possible.
>
> thanks,
>
> Takashi

