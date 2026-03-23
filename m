Return-Path: <stable+bounces-230006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GiUG5OWwWkuUAQAu9opvQ
	(envelope-from <stable+bounces-230006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:37:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09C2FC66C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F9F73037496
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EF332EA0;
	Mon, 23 Mar 2026 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pNr69tbB"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250F2E62B3;
	Mon, 23 Mar 2026 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294628; cv=none; b=MfmDJmOqz2XUd774CLkDvSWQ+q5f+CJporkX4UqrsQP7MfNYXW4/XaB6kgF9hdx07dKyfWOprWNcnxaUus6R0+J2rkg1GOrv+7gFbWjD9T00OxnYDGVuXriHVP3I2jC3pjSudePp8vqCy4lxnUiCbzbRtzUjr+Uc/kaffXDSPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294628; c=relaxed/simple;
	bh=5BGRcdA36LVVKtAvAJ9aNHJv8AVUrsJIiR0mMu+qOvE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Qe93OAviIwe3vYFG6udIVSsEvh4coYmrWZS8k+m/TG3CFgUQGl04fIM15V3x7pwy6g5R8nVJt+Ksl+BbWFijC35SyV/8bgP8QBvmfZ3123Kmcb8SUzVD7u6CA5acJ9oY1sE2ctQHdUrl1j/wm0AmeJPuW9ZhPpVzj/vgqpRTcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pNr69tbB; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774294617; x=1774899417; i=markus.elfring@web.de;
	bh=5BGRcdA36LVVKtAvAJ9aNHJv8AVUrsJIiR0mMu+qOvE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pNr69tbB3/OOivG7FZ33Rh3Tj9AFoHUqUC7S4VVyZ1ufpqhbAlIwaNr2aviUSrJP
	 oIUNjY3zFqCaCo4lTTkawY4ZTjrB+Cyc6d/Uk+Zekja8kvm7/O7ILJqWeghS7X6b7
	 DFuVCggolcigx08qyzTL5+yFz8b1Eci66rIxyby6y29ddOO6arWXgldBzJQrdQMxq
	 eLejpHNb3+0vURdnjmXITrBigBEJ6foVPbuE7Nsbu5PNUwoAfDVAL6GjlwmIdQ3eO
	 IroBYuTZyFiLkZpj3NnR1FORqBcc2M5shgxb9oj4iUWx85nVgwRVSyRKHjJgBX7aH
	 xBFHdjIhALwhP/StJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCz3-1vwKss1YOJ-00Uy3r; Mon, 23
 Mar 2026 20:36:57 +0100
Message-ID: <f4fba38e-c2b8-4e08-a958-ea433a7cbe05@web.de>
Date: Mon, 23 Mar 2026 20:36:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
 Atish Patra <atish.patra@linux.dev>
References: <20260323115957.38348-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] riscv: cacheinfo: Fix node reference leak in
 populate_cache_leaves
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260323115957.38348-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CQVB+hFlhabYUDW5vlLRbBoHdaQuObik5nMXbbjjSFzLGBUjRSd
 nol6OqL+8vKR4Cio7t23jxicfcdwwbJIIZj/MbtIWyqL6Ca7qoY+ayZ80HClgc6vTWna9tk
 +Mqi8I9TvmGZjdLeb8y/CaUX387EDGGCtyELf1OoAMAWVEzxvHNWklJeC+Cruo9FPp29Ja9
 shLtMHSGIFaxBemaIs9HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Tkw9uzrKYE=;Cw8vSLP8bjcw3BmegK/oimulbj5
 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
 DH1HvRfttQsPYi3WQMlb7jzcxWLj6t7Cw==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230006-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: DB09C2FC66C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E2=80=A6
> Fix this by changing the final `of_node_put(np)` to `of_node_put(prev)`.

How do you think about to use a wording approach like =E2=80=9CThus replac=
e
the passed variable np by prev in an of_node_put() call at the end of
this function implementation=E2=80=9D?


=E2=80=A6
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Can further clarifications become helpful also for the safe usage of
the Developer's Certificate of Origin?

Regards,
Markus

