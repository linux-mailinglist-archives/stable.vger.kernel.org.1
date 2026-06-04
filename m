Return-Path: <stable+bounces-260251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SfoDLhb2IGq89wAAu9opvQ
	(envelope-from <stable+bounces-260251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 05:50:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF863CBA0
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 05:50:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xry111.site header.s=default header.b=QiqWUw5t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260251-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260251-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xry111.site;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE9A300EF5B
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 03:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C333F5A7;
	Thu,  4 Jun 2026 03:46:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABA12FF69
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 03:46:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780544814; cv=none; b=lzVhdl1Ln+oEuM3LFpYSO6iiVS6rwdOm/77hnh2n0/abvRzOXz1kkcgp4kHLRFROAmJZB483vLF7J9khEOA7lg3teUAYcvqvLTR6TyBvMgGDi2KjJ9DH7g5GjAW+KJTQbtlGr6Ag4e0OXbjoNttfoX5dlF/gvw1YuWkt7CRqZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780544814; c=relaxed/simple;
	bh=NdzAvkbzSnK8ce72okZ4hpPIEtGc+UZEy8YS/m9jhjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVSofraxNY3/BazPECBNqn5RJqQ/QEw1ldQ/gj2b4H0DJDqMDizjjw7+KnhPZVwSCMuoYvm0VAhgSSmpn166VQc2hXwaGoTazlhp6J8iTcTuDUOto8bLVcnQr+rSxZtEWtKq7a1BGRlGlna7nq4k8+9NqwuXSaj3aKMlzvGKwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=QiqWUw5t; arc=none smtp.client-ip=89.208.246.23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780544812;
	bh=12HlY34QlVQh1oPArLYtr7ypk50voH4GrvSqd+mmPT4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QiqWUw5tOHQCIzfTDwmLKQQgCs/NnRGqdUGizlO4to2DcPh6jh5dycF1fLnFVCLol
	 kQWkhe46bphkYyhszkgqNQvYpAVVBFOcCA72Ej5dgG2r4UAC+GnhHZ+fXJQ7CXA8RT
	 JkUI65Lsb0xZfIYlRXaRKtj7GO5inPr/VZTAGvjM=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 48B0565982;
	Wed,  3 Jun 2026 23:46:51 -0400 (EDT)
Message-ID: <6fff98f69549a9069321a727f2333d3e4aa5e84f.camel@xry111.site>
Subject: Re: [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML
 to DC
From: Xi Ruoyao <xry111@xry111.site>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Date: Thu, 04 Jun 2026 11:46:49 +0800
In-Reply-To: <20260603210831.item005@kernel.org>
References: <20260603153920.249671-1-xry111@xry111.site>
	 <20260603210831.item005@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260251-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:amd-gfx@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xry111.site:mid,xry111.site:dkim,xry111.site:from_mime,xry111.site:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BDF863CBA0

On Wed, 2026-06-03 at 20:05 -0400, Sasha Levin wrote:
> > [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to
> > DC
> > Rebased onto 7.0.11.
>=20
> Thanks for the series. Unfortunately it doesn't apply to the current
> 7.0.y tree: patch 3/8 creates dcn42 resource files that don't exist in
> this tree, and patch 5/8 depends on dml21_wrapper_fpu.c, which is not
> created in 7.0.y either.

dml21_wrapper_fpu.c is created by 4/8 (upstream commit
4bb2f0721ed8a2a70f864b9358bd6cd4d92199b3) which moves out the logic
requiring FPU from dml21_wrapper.c to that new file, so the remaining
code can safely use DC_FPU_{START,END}.

The dcn42 files should be removed.  I'll recheck if the series contains
anything related to dcn42 and remove them in v3.

--=20
Xi Ruoyao <xry111@xry111.site>

