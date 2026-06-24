Return-Path: <stable+bounces-268177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ROWjOJvwO2pSfwgAu9opvQ
	(envelope-from <stable+bounces-268177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 16:58:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCFB6BF5FB
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 16:58:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=Iqg2ldxM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268177-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268177-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB1530B945C
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF593D7A0C;
	Wed, 24 Jun 2026 14:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E87080D;
	Wed, 24 Jun 2026 14:55:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312922; cv=none; b=nKX56vsAim/Rq7gD58DqygXqCcyjrQQuMaYlB3vxjwJX0ekZ5awIY+s0lKcTq+8WyGk+WLB1la+ADIPPb4elXQdGKq2/JIDysS2Hg1cxl4ZBs62PKapGDfr7V5+OiLrLnmbSl71VpjLlKmt1bBHx6UIXSo54C5lDXvdv7gEQF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312922; c=relaxed/simple;
	bh=4nd3yqcYNi3f7qm94r9ycstMdmmR5xlz/Ot0GPRN/SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtMdXF7TkcxmQJzmJWRg/KTm5XgOIi6hQp25ckIM3WRmgK8gRxmAUBb1tOPicYpAHN6iqBXyVy3cjEl/jX2qx9lveEVYDPtBWMEHvF+gj29e449ewL+FjsYuhT5FEg553BXgiLD3sU50OacbSICeWWyM7YDgMQSwEQByB08xZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Iqg2ldxM; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E923540E0031;
	Wed, 24 Jun 2026 14:55:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GRNam2NP54VA; Wed, 24 Jun 2026 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782312908; bh=Ieg4mv/KoDtt92MiGbXazKY3j5Ot+XMJxqgH9tTjzDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iqg2ldxM+Z01crie45EqthIKw1UF3KgTxKOYHIbYF2E9A7T1zmudjmLsCT48q0Kts
	 iaOTgxNtakIFqNsLXLDxSySAMFvPQBWwNLEMwzq/XoMUk59EIdQbHqWE17N0z9zKQf
	 +3Poio93ljCRBouOJSF+fkMpA+8anpg+P41UoNV2gF8JoG/gfw5VgiH8BTGdTK+LBo
	 mAJv2KSVsUDnm0fBh6Z7l6gM6+gJ+MgqTNkV2zHXQtwCLyrMKlGafw3NsJJiRd5/SJ
	 zjuUzeT9eH0nJOwbtpj6TrGXnr7zlBslQcEVLN/tWgXOSvLcVR8aAAtZGbuK6Unl7G
	 QI+oCfTvTiMTTe+3F0fJPFo3sAgsXr5xZ2JeU0mxKSBw/lkZJqGOhSws2n0UXD/aKF
	 JZw/IfZkdFQwavyFBzSZIK0qcW+U5VmeVpYAdDaQY3bW/KZLrC2gmeRL3nrP12bAob
	 HGWuG4yd4g4EUjiScSwt4VkBINb5m8hAo8BPAO2ffoK3mr8q558rVImuKTLLlFPPuh
	 rRD1B8eVcf58iW5Z5+tmJ5RMb1lu2zjl8pzRTZH+BMIwChmreSfwv1gPDaJnr085yV
	 oskvtuM6wpYtFZLqglE8mFbDGNDn8njFfwbXPNU4HQ6zz2fHUU4DCZ/gClrPqemAtW
	 bZe/26cBUX67yBdDOyID8gBQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5055440E00BF;
	Wed, 24 Jun 2026 14:54:55 +0000 (UTC)
Date: Wed, 24 Jun 2026 07:54:51 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
Message-ID: <20260624145451.GAajvvu2eLMa8yUDcK@fat_crate.local>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
 <ajuhrzRodTlLAiIe@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajuhrzRodTlLAiIe@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268177-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bp@alien8.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:jason.andryuk@amd.com,m:mario.limonciello@amd.com,m:yazen.ghannam@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:penny.zheng@amd.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,alien8.de:dkim,alien8.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DCFB6BF5FB

On Wed, Jun 24, 2026 at 11:21:51AM +0200, Ingo Molnar wrote:
> Why should we not go back to something similar to the pre-40a5f6ffdfc8

Because this code obviously cannot run in a guest. See my other reply.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

