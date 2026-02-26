Return-Path: <stable+bounces-219850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Le6NImhoGlVlAQAu9opvQ
	(envelope-from <stable+bounces-219850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:39:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 912F41AE883
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B65B6301A2C8
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A944D69F;
	Thu, 26 Feb 2026 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="J71sPmO2"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E162DC783;
	Thu, 26 Feb 2026 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134748; cv=none; b=EQ669zpL7TQctoVOu3/kUQ285RdxL2VqHhyPCi8dc5Vvkh5r79GvxHuq9ztoBl3BUOPf1qujSvRdBHJCa0JlMGVyXZQ3nm7x+4HyLTPHtGnz43ZUqLB1bNUYQaNxtfTwVPfLJuczBqEqHnI+Yr38FQ2X2sgduOaBEd5oyZ1W5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134748; c=relaxed/simple;
	bh=rMkea2JnyZCn8rVpcC6hcz+tOUmcORF1AWS3BIyvSrs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a8IUNG2y8Pq/3ZWBk8St5LX9GgL/ZJbb9pyLDTYyTDMRyPmYe7R2cX9bjMftPLBdXhiyY9+1gAoFpu3pMpFoim6gC53WjjS2vt3NtNnPE0ObTU/ujMYAUg90swm2koODbkvVUzizmmbWoaVxFBDmBX7PUu4Iw6XGr9cpTFcxGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=J71sPmO2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A909840E016E;
	Thu, 26 Feb 2026 19:39:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tvYhATfKZZqI; Thu, 26 Feb 2026 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772134739; bh=rMkea2JnyZCn8rVpcC6hcz+tOUmcORF1AWS3BIyvSrs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=J71sPmO2IUpO1UkMNJaZhJMJx9/T1r+wm4WMOZss26+S9H70G5ViqBw2T6gHLkPjZ
	 ChvQRl9eE4RnHzK2xQjNh6KWYKul+AW2Xplk8WU497SvN/kN+Mn4XYS2U74sLolTLS
	 h3IZScrxDils8/tv0oWWyOCbu/EK5Iuzkeql5EOotcQKAhwl+3epG1g9AYSt/OBOGn
	 UtzY5nzWKWV1vF6iVU25oT93LmWlSlCvWVrUplM+9+TQe2QwopB8y4UWwGY5hGO5Hk
	 x2H5zAXSn4A7p7bVl7kimqRzDcxhU5bxqf6XYDvjl53LzmVyXoCVJsiSV5DA+RgZyi
	 yqssoVugZLadFWZFyQm7X+GBdKVcbM/ifkdmqJaBmnFvdsLYxUi/BHFi42AlMGR4Pz
	 FtnvUeafF9b7tCYqW6tKwiUnbYskFcILeG/0w25Q6U1MqFjkedriOk/oCOSmrA5SW2
	 TYMUNLRYaFEbwtAAgttwhhzZZ9Z9VaO+kv2n3/D0O9Osm3gvobjfvyrVaGYI97qqL5
	 9fW7KWRDc05IDTfxrvu4phzbM2CJ1ANwemYdJSzEjmAmgw+FRiy4Lzt0Ntsm0KTqfk
	 vwgMHyPr0v/tqWrU5OE3RooeNU/Esez4Q1e9ItAIIDNTtCo/dwxfpYpKL73fMB/WQ7
	 /DPK6cMd7pH6xaoC4cSl6qa0=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3033:6db:bde8:b104:c2ae:3935:ab76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5133740E0184;
	Thu, 26 Feb 2026 19:38:49 +0000 (UTC)
Date: Thu, 26 Feb 2026 19:38:44 +0000
From: Borislav Petkov <bp@alien8.de>
To: Changyuan Lyu <changyuanl@google.com>
CC: thomas.lendacky@amd.com, ardb@kernel.org, dave.hansen@linux.intel.com,
 kevinhui@meta.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot/sev=3A_Move_SEV_decom?=
 =?US-ASCII?Q?pressor_variables_into_the_=2Edata_section?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGzOjsopYTEoNqdtO3w58wyuDcqW4QjJUHH5K0niEfj20bZBMQ@mail.gmail.com>
References: <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com> <20260226191612.1962381-1-changyuanl@google.com> <19F7B76A-8DC7-4CA9-9646-90931AF78CD7@alien8.de> <CAGzOjsopYTEoNqdtO3w58wyuDcqW4QjJUHH5K0niEfj20bZBMQ@mail.gmail.com>
Message-ID: <4D33D340-F46C-4744-90F8-7B71C72FEDC8@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	TAGGED_FROM(0.00)[bounces-219850-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:mid,alien8.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 912F41AE883
X-Rspamd-Action: no action

On February 26, 2026 7:29:56 PM UTC, Changyuan Lyu <changyuanl@google=2Ecom=
> wrote:
>
>I rebased this patch to e3c81bae4f282a6be56bc22e05e2ce3dd92ae301
>and tested with the steps in
>https://lore=2Ekernel=2Eorg/all/20260226060714=2E1636773-1-changyuanl@goo=
gle=2Ecom/=2E
>This fix works for my use case (direct kernel boot without UEFI)=2E
>
>Tested-by: Changyuan Lyu <changyuanl@google=2Ecom>

Thanks=2E

--=20
Small device=2E Typos and formatting crap

