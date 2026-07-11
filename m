Return-Path: <stable+bounces-273357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +UFrKeTOUWqAJAMAu9opvQ
	(envelope-from <stable+bounces-273357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 07:04:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24574057A
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 07:04:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273357-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273357-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04EF4302CD3C
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 05:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4227271A94;
	Sat, 11 Jul 2026 05:04:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8614EC73;
	Sat, 11 Jul 2026 05:04:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783746270; cv=none; b=AF+mFbRfT2CYahX7/vleMbicZXb6Lyrr4GLHgLAqClLiV0NXv6GCH6ACCbOaheGbJpgecexH4a1wN9g0vsCQtfdrEGH8RPeERFJ8Mt90Di0K4wE7L7NwWuX1V26gKlUfePso5h+ZBPq8iF/vx35RGPJHJJHeCf6QPB48dhDBRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783746270; c=relaxed/simple;
	bh=sMujRkzP+0svfJnmRczxcQ7AePeemebynXdWZ0h9VGE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KVhC9Agh5btIIduBqBcyYBr0LkreeISB5odDr5I3VnOaLeeauI+uwxYt1tyV2uDuHYP57w+M/sR9WocKd9y6YK6Yqux+nyYvUaXw5iCcaNovZ0ja7zvl8PvHl6FMozGmPsxvMkPWwBKFT/BDQlYqhoK4VF99ymhnh5zY5KA8XNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: f88789647ce511f1aa26b74ffac11d73-20260711
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_QP, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_MAILER_MTBG
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR
	SRC_UNFAMILIAR, DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1281cd33-2b67-4854-bbd9-17ee00ce8ccf,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:1281cd33-2b67-4854-bbd9-17ee00ce8ccf,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:2c71dac5849ae06242c1f1c11ef34077,BulkI
	D:260710221752NO56G64A,BulkQuantity:4,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f88789647ce511f1aa26b74ffac11d73-20260711
X-User: husong@kylinos.cn
Received: from ehlo.thunderbird.net [(223.160.130.75)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1252713203; Sat, 11 Jul 2026 13:04:18 +0800
Date: Sat, 11 Jul 2026 13:04:12 +0800
From: Song Hu <husong@kylinos.cn>
To: SJ Park <sj@kernel.org>
CC: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] Docs/ABI/damon: fix typo in intervals_goal sysfs path
User-Agent: Thunderbird for Android
In-Reply-To: <20260711002127.32005-1-sj@kernel.org>
References:  <20260711002127.32005-1-sj@kernel.org>
Message-ID: <C8C472D0-9818-4569-87EC-1B95BE9667F2@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:damon@lists.linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[husong@kylinos.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273357-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[husong@kylinos.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B24574057A



=E4=BA=8E 2026=E5=B9=B47=E6=9C=8811=E6=97=A5 GMT+08:00 08:21:25=EF=BC=8CSJ=
 Park <sj@kernel=2Eorg> =E5=86=99=E9=81=93=EF=BC=9A
>On Fri, 10 Jul 2026 07:17:37 -0700 SJ Park <sj@kernel=2Eorg> wrote:
>
>> On Fri, 10 Jul 2026 12:47:34 +0800 Song Hu <husong@kylinos=2Ecn> wrote:
>>=20
>> > The ABI document spells the DAMON sysfs directory as "intrvals_goal"
>> > (missing 'e') in four What: entries, but the kernel creates it as
>> > "intervals_goal" (mm/damon/sysfs=2Ec)=2E  Following the documented pa=
th
>> > therefore yields a non-existent directory=2E
>>=20
>> Nice catch!
>>=20
>> >=20
>> > Fixes: e2b23dc62369 ("Docs/ABI/damon: document intervals auto-tuning =
ABI")
>> > Cc: stable@vger=2Ekernel=2Eorg
>
Hi SJ,

Thanks a lot for your thorough reviews and ongoing support=2E

I will strictly check the complete recipient list generated by =C2=A0get_m=
aintainer=2Epl=C2=A0 for all future patch submissions=2E

>By the way, hotfixes and non-hotfixes usually take different trains to th=
e
>mainline=2E  Having those in single series therefore makes maintainer wor=
ks
>difficult=2E  I understand this is not a hotfix but just somewhat worthy =
to
>eventually be backported to stable kernels=2E  So no problem for this=2E
>
>But, from the next time, please clarify or use different series for Cc: s=
table@
>patches=2E
>
As I=E2=80=99m still figuring out the correct timing for =C2=A0Cc: stable@=
=C2=A0, I will consult with you prior to adding this tag next time and sepa=
rate stable-bound patches into an independent series=2E

Thanks,
Song
>
>Thanks,
>SJ
>
>[=2E=2E=2E]

