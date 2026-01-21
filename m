Return-Path: <stable+bounces-210717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPvELDufcGlyYgAAu9opvQ
	(envelope-from <stable+bounces-210717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:41:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E15491C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79274888088
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8849D47B43A;
	Wed, 21 Jan 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vPbDs7fq"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768344D03E;
	Wed, 21 Jan 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987861; cv=none; b=V6t0TA+d2GRFfsm3fKaDpq/76PfIml1tdN6rIksGPlTwDTv7L/gSxR3iQ7ZFBTrvgIKwUzaiSgJd4M2Caot/cWUKV9CpPF5H4KA6XrR99Y6X8k+/oseCzTjmBtPY2L127icsxz1cWtEkN7/AEa7jJlcpS/i9mXhD3/tBrgqeX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987861; c=relaxed/simple;
	bh=GR+ZcQSK+ncq7M6WkQqRmrPUe6FYcY8vBUMNt+H61K0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nmNhT706fX3UzMMH+5QdR88V32qNH7QbN5LZaVWqMiXbGthIY1bWuSQN8NZwKf6I1mc8cYfqFoHXinrH5NF0Izy7AjcpKRXFWsQOD/ddxBcbHiUnod4KCl8OhpjFUZ2Up8OlimMfYT+8DzoRZfw5wxOUGf3+bzW00/ELMfGHNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vPbDs7fq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768987844; x=1769592644; i=markus.elfring@web.de;
	bh=GR+ZcQSK+ncq7M6WkQqRmrPUe6FYcY8vBUMNt+H61K0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vPbDs7fqRJh850a7d4eWprIv2BxLRLcYC83LQPfUi65gZAigMTYuV0lts2Ctic6y
	 iMByrm2RR4/t70FU3c6gHFxtD+DtYVEMzB6SgonyHVDNLafsSxqQCFqseC7ZmwsjF
	 urRgTB7Y+Zg98oRQRHAM+xiZSkMEr3dOK69Ae5m+ooYWRqBB0sW4pKP4OAN3+IbK3
	 pF33xL4HIl1wqaiQgjigK07p0Cyoeuug44u+ir4wssH3dUfqH38M3FLnHSajPIrS3
	 LMRWNbdYjrCV13+1HGGdjjdT/sn4ZxIbrz0/eS0PPBw4wR9vvQ/cal3eKWZ2JE10Z
	 iOde80JiWug2/adUkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3ox-1vXEYN0PBf-000wWk; Wed, 21
 Jan 2026 10:30:44 +0100
Message-ID: <70b3c173-34d7-408a-959a-5c8a7b1ed212@web.de>
Date: Wed, 21 Jan 2026 10:30:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, linux-clk@vger.kernel.org,
 Brian Masney <bmasney@redhat.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260121012223.186199-2-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2 1/7] clk: st: clkgen-pll: Fix a memory leak in
 clkgen_odf_register()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260121012223.186199-2-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vCi9uu8PC0mopnrY4Z4O4wkiKUxa4nahtzTJrL1xLsKwxi9XQ03
 C8xVyaoBBqTF6RrZ5QdxvKmLuZxky5Uv9u/n5ff2je+dN+xFH38yhOHg3tldmg+0QYZH7ZO
 tn+vtP1reCjr8vvLJhSXUk5D2RgSGP4PWh8mOyBd3ApcBPcS80igUD0or0ia9/R18TXBg4w
 GsKIQVeMHLFzzpNqYEFBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c7mO/7ncJJs=;m0pI8VnkIYgS3/A/JuDVaXpUJgr
 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
 oNNqpJqqk270EB8kkYGKLrpbwghXJrv3N0OgS2
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[web.de,quarantine];
	TAGGED_FROM(0.00)[bounces-210717-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FREEMAIL_FROM(0.00)[web.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 264E15491C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> If clk_register_composite() fails, call kfree() to release
> div and gate.

You may put such information also into a single text line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc6#n659

How do you think about to avoid a bit of duplicate source code here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc6#n526

Regards,
Markus


