Return-Path: <stable+bounces-216486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WATcF/R5kGkBaQEAu9opvQ
	(envelope-from <stable+bounces-216486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:34:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F613C1FB
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CE14301487D
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5310217723;
	Sat, 14 Feb 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YSXQqgeQ"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA31F92E;
	Sat, 14 Feb 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771076076; cv=none; b=K6TlF9+fp9Eo2FME9HbNvd2d1/sHCUEIWnXqjJa8k5bPBGU2k/lHDAzDcIkawG0UYOMPgIsoZNB3sa8iQlqUg2zZjEcUJeEgwHe6l24Y9mYS/Vka6gbFmfZoRki4UjKLnZDjaCIOdAcyYVHtI5SNAJwi19zrtG+6cIGNIQCb+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771076076; c=relaxed/simple;
	bh=nfIw8bz+oIOcdvawUzRdHtUsgVWrahMw1SqKbJX28ug=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=khMQOyXMHJ94rvXzO8vE9EOsc2ZQk22YjF56lsDVrPV/mFuGzoCiYSbCxOs7PwBkYe8n8Fx8BGV3FOrpYVk6AdDpsLo3HVaLvuNQsV2i0tsEc82PJYj+UFU1XiqZ5qtnHpBvtwSmssACzJa2Zy8mdOZQn3KyxR7/9ONJ2dQqkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YSXQqgeQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771076048; x=1771680848; i=markus.elfring@web.de;
	bh=nfIw8bz+oIOcdvawUzRdHtUsgVWrahMw1SqKbJX28ug=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YSXQqgeQW3dEvv0EBdNVR4HTyZ5NrdMV3TwjYcuKEg93xBgGdzF2WG79r7NVj1wb
	 PVT2x4lIy/mFoagYbxR09EkbhCH33rZ8zLNfhIMEeAAUfGNny+9MRBSqIVKO356Qz
	 4NQifvSm3NTPnX9N7+dUQcat0meKVDsm63X3kntbJGXaSUkSrW4UqpBPAMFeEaEm5
	 SAc8b8MA/G/z2sUwfQOy0wKCs+O7u0wUex1qFdasJnVQYpGhvMDrsgpEOMWhSjIVp
	 j2010fsPJkTOK2OiHpzh0+6a8gdtsaKMugrOgsBPwWhDw2ykXvdcNwHVnsnuDk0WD
	 ckBMDynhL2JfdKpFjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.241]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlLE7-1vUWlR2R9Z-00ixym; Sat, 14
 Feb 2026 14:34:08 +0100
Message-ID: <b0728085-c93c-4869-ac71-209d1d5889f0@web.de>
Date: Sat, 14 Feb 2026 14:34:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Fourier <fourier.thomas@gmail.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Dariusz Marcinkiewicz <reksio@newterm.pl>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260213164340.77272-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH net] net: ethernet: ec_bhf: Fix dma_free_coherent() dma
 handle
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260213164340.77272-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x8AZmwnUPlL756ozHIpuYKlAd/LvWMKvW6oCTeVh+jekdQcgHAZ
 uHWs30Vtqwt/OA9QkA/BkVy8kM2PikznkismMZr+I8So8VS5FRJ71HhP26lPyDa6owU2nMN
 qcZMA2R+/SQLTLKe9EZClaJK9ZAAtBaz+oCMyMxWHqddpBiCPCpYYAPfypLmh6wckF1mhWa
 L6gx1E3MguhlMlyTSIaAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2iK6HSpGPjk=;pq9DzA0vtwKwBgGe5IHzrzxyGb2
 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
 ldAFA2Qw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216486-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD7F613C1FB
X-Rspamd-Action: no action

> dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
> the dma handle. This would lead to improper unmapping of the buffer.
>=20
> Change the dma handle to priv->rx_buf.alloc_phys.

* Were any source code analysis tools involved here?

* You should probably specify message recipients not only in the header fi=
eld =E2=80=9CCc=E2=80=9D.


Regards,
Markus

