Return-Path: <stable+bounces-225465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDZCLRqBtmluCgEAu9opvQ
	(envelope-from <stable+bounces-225465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 10:51:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A972905C6
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 10:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCD59300463F
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6033223DD6;
	Sun, 15 Mar 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hxGHp9so"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B813A3ED;
	Sun, 15 Mar 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773568273; cv=none; b=oDLhkfI0nC/PsJisV+jOWnlvcp8ETag+YK20qn5OkdD5y6zjY+sMncMN/wMWQ/17goAM4JOwnHDNS9mmdVovS69/RV++cbl8TqSoTYUmDk95fFE5oOrb3EANpv+4ZxSpJvlGeLCwJ0J1fXw8D8UZmEitCeQNBMiI+xg3l5W+KnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773568273; c=relaxed/simple;
	bh=ERTci3cLC+ElVakmPaGexKA6SpnaBFzbp42qOCgi7pQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YAcQX0BR7BqxXx6zCLyJiMVr5exoK4DRNw4VptRkVBiWFNIZPBIX7HryyOa/FOh/G1aQ62dub2VPfDWIRfMN7wIZsYKi1Lvu+p+yPuN1FUNKWW5gvjKSp55UBN4jOU2Xn0Fg4Iq/iGfxKWxuis8vcxDNuFmRxg2eEc5cT0s3/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hxGHp9so; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773568253; x=1774173053; i=markus.elfring@web.de;
	bh=ERTci3cLC+ElVakmPaGexKA6SpnaBFzbp42qOCgi7pQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hxGHp9so5fLOTzauu9iA8BmdW9jjyWwNLSJRTQPseiwvWTwVcNI3L5Uz4GjO3x1W
	 XdzxZlWxR54W6DatHZEzyDnFDDqD1dv/68yXu8fU4y5Gt/7SxYlq6tGUdw/sZH9Xc
	 LceuUqa0fsZHMrMsoROZjJqyJFho3nOj8RXlvjD+vdU2n5KQTyFbQy8EmrQHMFldU
	 7524kY6TCCRCG+Hrn5HJTsyuO3Y0XQMcuiYRzj1ZtrTrXCJ4c7fXzb7HEI4EH7Gc6
	 0/XaoDRL5r5tZt1X7jFNOCo/WgJPWmmlZldDeiemM5/EdWbi5DWa0fjf+aKrHtDme
	 Qp07M1mNgly/uqo9gg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CQT-1vaSQC21zh-00rYey; Sun, 15
 Mar 2026 10:50:53 +0100
Message-ID: <c505bc0f-28e5-406b-acd6-3c1f20c70c5d@web.de>
Date: Sun, 15 Mar 2026 10:50:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: drm/amdgpu/userq: fix memory leak in MQD creation error paths
To: Junrui Luo <moonafterrain@outlook.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Prike Liang <Prike.Liang@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>
References: <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <bed7f0c7-4346-41d0-ac5f-f5a897888533@web.de>
 <51CF1DD4-7CB7-4B5B-BDF9-3411B921B5D7@outlook.com>
Content-Language: en-GB, de-DE
In-Reply-To: <51CF1DD4-7CB7-4B5B-BDF9-3411B921B5D7@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:raQnjTdJ0UP7CGBa+juRuJInl0ZhDjfo6QI0Nr1lPqoevBxHWzx
 i213qIEB+8Nc2VUFgFuN2U2tO5HLTiCtsu0bVLRU8rthDNspW9Lor3kCeqYiPJ0CjbQOzJB
 BkD5fC6jM7MW2p4Vw4IficSYdNdY2IG4tXDzmexzSXvSyFBSY4LCVta6LRLIbtMZDk15Lav
 DHSy3+levER+5Ivh8Lt6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cAnQlNwmqQ0=;TwvmfDiWcH3O/xdLhSRmt+avY8w
 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
 Hinq0BzvNmFkWwmcj2XM
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225465-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,lists.freedesktop.org,amd.com,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[web.de]
X-Rspamd-Queue-Id: C2A972905C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> A full conversion to scope-based cleanup would require restructuring
> the entire function, which seems beyond the scope of a bug fix.

If you would like to stick to the usage of goto labels so far,
I see further possibilities to avoid also duplicate source code for
the affected implementation of the function =E2=80=9Cmes_userq_mqd_create=
=E2=80=9D.
https://elixir.bootlin.com/linux/v7.0-rc3/source/drivers/gpu/drm/amd/amdgp=
u/mes_userqueue.c#L275-L434

Regards,
Markus

