Return-Path: <stable+bounces-241082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC2vMRoM7GnmTwAAu9opvQ
	(envelope-from <stable+bounces-241082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:34:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6E46444C
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41841300D84E
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038DE1A9F82;
	Sat, 25 Apr 2026 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsK/AXOM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3B19CC0C
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077268; cv=none; b=H+4Sm74FIqperKQ3JNCciBf1DwnH5zCE9eBF02q19z1KSGdiI3sBv2qY2Vm0vIBvoo6ZkalGlELY7x6aG1KKYl9qD+ejvUK7WUBlm58W86LfcfYXiIg7YxMgmHQsmwNoSYLaWlkQE2WylTYysJxyTTCasNs69Xp4UG624eP+4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077268; c=relaxed/simple;
	bh=x5qSm5xIP+b0YijJnQ3EAn2k382Bn6thPE3QMobbIhA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=du+aCIwsc7GEZdQY3qCp8vjhad5/qImRDjfaPtld5iUt5/ao7bDDf6C9FRCyRBBKVySAi3gAz6+p/QjdJ3fnY0kWdd7YAhC0jHVjmqmuLDsrcyGWY7jqOzT8wqbYF1C9dh/bFtE70ZdO6GhVHyJv74YsvTnai3li47pOmQ6jYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsK/AXOM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b24fdac394so81652255ad.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777077267; x=1777682067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x5qSm5xIP+b0YijJnQ3EAn2k382Bn6thPE3QMobbIhA=;
        b=SsK/AXOMPEVxaAF2b+gnvoEYPmzQXnn/j/Nz8vgpKXRMhpau5aBZx89MYQiJjnkfBP
         GDGkmjs7jMN6UBRx3qhlSS9bPWNQwPEu1fPNBh2xPtvD712vRr+dI+kgw8R4SfzmX/rG
         DZ/8KXlsxONuYy/8ml/Z860lMdiwbSKLxkhVYqL9t5dXtAFPDBp74NiQbaFUytY5HLLb
         xj9sI5IxnUciTBVn5AoZzBUReF/Jc8AdO32b+55Cy2h0OCuVLB5aLNMmne57et1XF4Ot
         mhbfbO1WcZGTrN7Fz+TNbZZ+KwOz6rAjJSQkhZmeMdoNTRzjgQBXctM/0pX3QFRY6gt5
         ie1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777077267; x=1777682067;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5qSm5xIP+b0YijJnQ3EAn2k382Bn6thPE3QMobbIhA=;
        b=T9v/PM84/Dn0yTgMI+e76Y4XAyZGoe74Ah0F1n/FTICmJfysmo4J1g03ZBLttMBK9H
         nmrqvGSJ9n/8GwdGdvcPnz0MGQxn2yq9mbA6lGmIWeGNwqwcB2FkTGdDEg1LqzKmxjNu
         oYl9Vum22/7DTbAJVCidzsxlEqt1QS56L4LRdjAQ5/xmP17AY5QuYM2aTrddguYIAZYL
         ilkRdpKqdh7QH/W/IUK++0RVOl6UWkDjxBLUkSAeNn9ljOpZsHacrRlPdFHb0GK40Yyj
         swa5ypcvQLWa7XyUJgvpilXdSS8SR+6KIivBbQwCYqtzAtypXJw7wMOPl6z26tv5tQBg
         7Bmg==
X-Forwarded-Encrypted: i=1; AFNElJ/O6D32+UvjXddIHzn5BWvjGFczCEZMVCeE5EABM//eXiWG2gAQfuaeLyCDhbgO4Rix5q9SsEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnuKdxyhSpeaTByoBXCMmn+OFIf0ukmMrwBFUJjT4E+HykFe7
	TqXtAdZdoZIEQeH2FlLr5trrPX5XX8bgUzX5CejXOgrQt5Qzy/iAVRIF
X-Gm-Gg: AeBDiesJRlVc972DwIvKyXyYIZCLCRyi/ON3k5pmlH+GW5FWA6stOezoHve635zsqdO
	YmEWyQm9JId3DKg7cpkSxTCIkWK+7Q83hAbxdXh4BOy4ZIFrHm7L4c3WCgB7rgOU1yI/UVzqIcF
	LpuTxb0YH9pmJioHsViAh0SxsfWIJiCCJ7rEnQSUGVxcIIMsDMhbB3DwKkd/qk3AeFvEGL3Rv5d
	rQwcfI6NLp0f1/9vAcypDu0g+Bx7f3u9fZDjI6hZ5dOoqhXzQ8+hWqe/c4PCfM3AsmW+ftaT3g3
	DOvO/GmTWFhvDni5HknBtVBptDiFYSYt/LynzvufhHVHGVoND4VFP7En6eDnA5+W5nfqF6c66yp
	GohYYLKce01IyQXoIOIHScVYLxmS+M+Vbwt1XFAhproLTtZ/bURoCg0tAImKEDNrRFwomR7R5lf
	AK2/e9p000D3FrWOpNV5d4ogQPVf7s360DOG8ioiXoqzVsZtJQaeM=
X-Received: by 2002:a17:902:e746:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2b5f9ef6877mr405510205ad.14.1777077266996;
        Fri, 24 Apr 2026 17:34:26 -0700 (PDT)
Received: from ehlo.thunderbird.net ([203.184.33.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff8d6sm227843465ad.1.2026.04.24.17.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 17:34:26 -0700 (PDT)
Date: Sat, 25 Apr 2026 12:34:20 +1200
From: Brite <brite.airgeddon@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, fjhhz1997@gmail.com, oscar.alfonso.diaz@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_wifi=3A_mac80211=3A_restore_monitor?=
 =?US-ASCII?Q?_injection_when_coexisting_with_another_VIF?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com> <20260424120807.25005-1-brite.airgeddon@gmail.com> (sfid-20260424_140854_559281_CA03D57D) <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
Message-ID: <D87EEEEF-E514-4A6A-BF15-83EA706EBD86@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 55B6E46444C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-241082-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briteairgeddon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On April 25, 2026 1:55:46 AM GMT+12:00, Johannes Berg <johannes@sipsolutio=
ns=2Enet> wrote:
>I don't believe that all this complexity is necessary, and the code
>changes have are fairly clearly LLM-created w/o such disclosures=2E
>Dropping=2E
>
If it helps in any way - just tested your v2 patch which causes VM freeze =
but adding the 5ghz surrogate patch solves the freeze and also the issue wi=
th 5ghz deauth in ap/monitor mode coexistence=2E Tested working on 2=2E4/5g=
hz standalone and 2=2E4/5ghz ap/coexistence mode using ath9k_htc and mt7921=
u=2E Also tested side by side ap/deauth coexistence mode running evil twin =
attack using airgeddon multi instance mode including channel change monitor=
 and no issues at all=2E

Brite

