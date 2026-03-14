Return-Path: <stable+bounces-225445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFstMUy/tWmr4gAAu9opvQ
	(envelope-from <stable+bounces-225445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 21:04:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0028EB4B
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEE53301D4C9
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45071378D9F;
	Sat, 14 Mar 2026 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FAw+VdnW"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB092417D9;
	Sat, 14 Mar 2026 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773518663; cv=none; b=U8aeQQbROkbuffJsHVXrCEsd2p57mC5NCjJxtkFNJnACqRILhkdzjMNp4lAv3aJ0MqR+wiSCC0QTArWYQnPwowh6PhIvGjTad95gq0lxI3NR/IvP2QJOzagn18JV1KFRJsB15/nsHQcQAat1lLDv24kCO+3nuK9om+ELRpkiWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773518663; c=relaxed/simple;
	bh=uCQT9EPIjQ/d5Ko094fvhKp1zMmZlslD3rqvN9eUm1g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YoOzsWnZD5x83C2Vm9YGLfkYA+QsWepHSyYJBtx6eJatVGPgjBD/YT8fEqvsEV100zOOvF1YXR1q2/MBgCA0G0tes1Tr2LG/AdszPn1aZ8uUuywdTL7LncgtY7LOgUcuXvb7rpmLSTCaFpCFo7exEToHYPVovdVC20XpyBvdwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FAw+VdnW; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773518652; x=1774123452; i=markus.elfring@web.de;
	bh=uCQT9EPIjQ/d5Ko094fvhKp1zMmZlslD3rqvN9eUm1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FAw+VdnW1vFnVYWNwuJf9To1psROilfpry4xcJceGHutYo/xKnQHK3cVACRjWK4k
	 XxUfb+eXTx7CIUNBMVlE9ML8Zsy/w/mRRWJj5IkSReco2wWwzdsgioqETnOfRp+0d
	 Vau9Hd4dflZelk6psWdXkC9sS9QsmiJH0j7ur3xSFNuvFUclEclWl1kvk9y/5qE9/
	 k/hFb2NXlDjnixXz+P8zuSQv4H18BANqn/yY5I1so1JinjO8mp+920dYn2IGII2AY
	 WFOdhMiJUSw4bewP/6uiaoTqw7hbC0tVywkzR/D+7pKlFJkx811KLuFvpJKSBg3ai
	 P0IPW4P/4DLj6pB2rA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxHYA-1vhbsa1e12-00taWX; Sat, 14
 Mar 2026 21:04:12 +0100
Message-ID: <bed7f0c7-4346-41d0-ac5f-f5a897888533@web.de>
Date: Sat, 14 Mar 2026 21:04:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Junrui Luo <moonafterrain@outlook.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Prike Liang <Prike.Liang@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>
References: <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7LmOM9SFWH2pSgFG1Fad4AEg+x1rZK9iw4LG0/wy8bC4UZ8e6Em
 iMQiXkc2mZTt8E+iDPLpZcoe5nfrZ4KIrabpsAbgQXUrMvSk2f7BpWXK3lO06D6JdrPpyCp
 c+jSG4E6ulccpOAdeiMWtNrnMsF55v6Mthcd7bsNUFN97KW135vYUd0Z3uJlEmIHt6HY3qD
 bx+FGNlPXno3Ca6YVjPKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gGQ7r7sVAHg=;cA34Y0/e8f+fw/q85/6WSOyI6Xr
 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
 lbc7u1rZFVeQtKwI59Ef
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225445-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,lists.freedesktop.org,amd.com,gmail.com,ffwll.ch];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 41B0028EB4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E2=80=A6
> Fix by adding kfree() before each goto free_mqd on VA validation
> failure in the COMPUTE, GFX, and SDMA branches.

How do you think about to benefit any more from application of an attribut=
e
like __free(kfree)?
https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/cleanup.h#L=
157-L161

Regards,
Markus

