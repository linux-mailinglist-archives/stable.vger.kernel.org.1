Return-Path: <stable+bounces-271911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pDrjDAhrSGpoqAAAu9opvQ
	(envelope-from <stable+bounces-271911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:08:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 755EF70674D
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:08:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mCymFpdy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271911-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271911-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B037302491B
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2885372EEA;
	Sat,  4 Jul 2026 02:06:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542B372EFA;
	Sat,  4 Jul 2026 02:06:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130764; cv=none; b=i86C6LnDK37h31k0IaOzxK1dlIOtHcxfmSAgbaxGvfKjkajcct8K6/dhSg9pNBlIobIKNhVthufPq0m5VszEldatOeK3EI1E3dp31u9cNoKvNuBao73EX1vePjUTUMGrqkZagZGNyhjNwWWscv0lu6fRdwyQJrR3kooGAk6XNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130764; c=relaxed/simple;
	bh=TObkTKyeHlxvkEWg54CrQuc0EBClQ3LxMCykHlqEKCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lydcabVc5n1OjqMTG9Ke2vH+LNeAwTGqXKCr+ZL3X7/kL7qNrUMuf3DfgMxDt7DlihFFk9AutquoOStkO0y9xqXP2PkzLyVtGPXiAopuQeQP1eAh56sWWqWDTCzeZZ/v6P37q8iG5jRpyyMcMaU38bbHSc1eARKr3npZR/PQp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCymFpdy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5841F000E9;
	Sat,  4 Jul 2026 02:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130763;
	bh=QwJOkaKz4b3D76JlG67IrJh8qpMMgQb5aqeXaQhKbFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCymFpdygGrn2bTTE6GMzgGa5yMK3QmE7HSTFQwAdq305Z3X30Ow+018AtNfEvlUy
	 hKsDIzQ22b64Ggop3z40GK7ChBlfgqk4mWYTTkR4sWM3B8PCyn5fF6bWV+8LLwahGy
	 VUa0r0NauVGg6FGvujaYlYswv2EHZeG2JCcKCxv2rTj0xzOPIx3hevYR240zaq8Edl
	 dpEIIXq3YQmjH1c54xwQ1JHlCcDL+ZpZXVQ3PGeOerwDeqJ3zBWqz7+utqqdvFWfNA
	 2WICpdN/J+AcXqkXzWEjyig4IMfNjgQJhzSFoodsb2IqP1CzrXKFBImnctcEDQUcjf
	 JwuO9FABCYlng==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.12] bcachefs: avoid truncating fiemap extent length
Date: Fri,  3 Jul 2026 22:05:22 -0400
Message-ID: <2026070315-stable-reply-0028@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703114813.113406-1-mdmitrichenko@astralinux.ru>
References: <20260703114813.113406-1-mdmitrichenko@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271911-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:mdmitrichenko@astralinux.ru,m:kent.overstreet@linux.dev,m:linux-bcachefs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 755EF70674D

On Thu, Jul 03, 2026 at 02:48:13PM +0300, Mikhail Dmitrichenko wrote:
> No upstream commit exists for this patch.
>
> bkey sizes are stored in sectors as u32, while fiemap reports byte
> lengths as u64. Shifting k.k->size before widening performs the
> conversion in 32 bits, so an extent of 4 GiB or larger can wrap before
> it is passed to fiemap_fill_next_extent().

Thanks for the patch, happy to take it if we can get an ack from the bcachefs
maintainers.

-- 
Thanks,
Sasha

