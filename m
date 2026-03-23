Return-Path: <stable+bounces-227899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFy9AGTswGmROgQAu9opvQ
	(envelope-from <stable+bounces-227899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:31:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7562EDA1D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B066D301E3E1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312935E92D;
	Mon, 23 Mar 2026 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rhqTGzCT"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB431F1932;
	Mon, 23 Mar 2026 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250961; cv=none; b=arZukjL4+LgPpiLlgM9nsQywZN+EjhLMqEm6fqKWW1VijZpo+9CBvw5MSRtEobhmmNETObdwE2x47znRXj5eex7cPkkgX9DeiEh8jLf0SO1Yl9XXcSQHmOXMLux/mczMq55ERx1NJMlozmaMZVFz0zbSnPH00Eu53FzSiHLBSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250961; c=relaxed/simple;
	bh=OMfdXeN8AuW682Iluc+EJuXACQaUg4XWh33Wt0DHC+g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VW4PGyhABVG3QOAypcS/Gs3IcocgaHMBrPTNBBwO2kKboXgCvarvGd1xJWXQiW4zU06Eqn0LN22GbcbtHZ4k0mk3Zln0yVBza36r3bgURyEyhY2tGNrarsLB4aWLmIkNNCsH1h9wuAlJJ7FdFkxShaV29SyN/55jPxHPHyv+eCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rhqTGzCT; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774250951; x=1774855751; i=markus.elfring@web.de;
	bh=OMfdXeN8AuW682Iluc+EJuXACQaUg4XWh33Wt0DHC+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rhqTGzCTbHszF4/Vg5ZeHtKoOqVBTBK9FUZ62voWdz5gSa55VZ8e868WqKpRJyVX
	 hHayHTtfKOYhs4ZhW9Vyuqg/hb0TXGPsDm1W4yLnbl+OTL69NVB9YXS2yS8tBt9oz
	 jVTnu2C4KhK7ZaVeODCQaQj97vvFlSUwLoo7a1h+06RQTTEV5ym4dkwR0On4JIwDW
	 U/jT7iS20i8HozFk5swpqLa70SACKOrxwQdAnOFNUIGuELwjbQritQABqQnIdVbQX
	 CoPY0PaIEWG10Swnpa8H8/NAtn6j54SuNMOsLbIHfLZS2MNATfsYK6Z1qPRuzvPli
	 bN2vadfLq+ISg60zZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNOVK-1vu3zR29gQ-00YRgc; Mon, 23
 Mar 2026 08:29:11 +0100
Message-ID: <89ab7e7b-ad61-4881-bceb-781481857d3d@web.de>
Date: Mon, 23 Mar 2026 08:28:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Josh Law <objecting@objecting.org>, SeongJae Park <sj@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260321175427.86000-2-sj@kernel.org>
Subject: Re: [PATCH v3 1/3] mm/damon/sysfs: fix param_ctx leak on
 damon_sysfs_new_test_ctx() failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260321175427.86000-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6OJEwpy3qc+Rn+XsWnfXay5amnaHZGwsa846VslKOX9QthrTc5v
 6Doi0FNpva9WaEc1qztuFCFJ4SGGsF/xlBT6ElQJ22C3HDAO7SkLjojUDqD4GuAsiPYcLPz
 0wNY8bvO3s9SnrjSp/3fjYSkvM2ZrEyGOcW1NGfmO5uMovoO4dHAVqW1g+pu+HWUub+4fwz
 CXC3uQn/hkZnUrOjnvrSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kdgVpz69ssw=;I55zE1M2dtkv0kJiu9LAnZwmlEv
 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
 6tZEpM+C7E4csq1bHyGK
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227899-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[web.de]
X-Rspamd-Queue-Id: 4F7562EDA1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
> param_ctx is leaked because the early return skips the cleanup at the
> out label. Destroy param_ctx before returning.

Will it become helpful to use another label accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.0-rc5#n526
https://elixir.bootlin.com/linux/v7.0-rc4/source/mm/damon/sysfs.c#L1506-L1537

Regards,
Markus

