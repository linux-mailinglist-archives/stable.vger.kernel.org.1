Return-Path: <stable+bounces-273327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DqJvL4FeUWpSDQMAu9opvQ
	(envelope-from <stable+bounces-273327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C773E9BE
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CcpcIIrl;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273327-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273327-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F7C30364F7
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA53358C4;
	Fri, 10 Jul 2026 21:03:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30E225A38
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717412; cv=none; b=JlebUsMHkYSN8jXlSOC4AYAeELyUGyNK9K91+klwSqsb13hVw7Yz0WUX/Oz/3TvV092R0P11Za1O7U7MwScng1+p8ctc7wh3bGI1i0IElnftUw38fHNq1nAANldIgDF7XTJoBPpUSbF3DsYVQoawRP70zl5gc8VjaVSt/EK+LVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717412; c=relaxed/simple;
	bh=sggs9wvKI7ULzqEa2iKavhPXj80VKGnlmc68dHvqO34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCucKW+pv8xcFKwef/1h1OagXdfFOht2gLcbkJdY+n5wJMSJUoO2dMebnkxDIv7f4o5yIJ/D3+xaHBQMlWeryD/GoIV7jixgSF+iJbLcAJ9z0PUiyQp9Y7oezf9lue6PpzRYuasK1VErIND1BeEPtLLgJo7JOX/8PJPArtpCBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcpcIIrl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C21F00A3A;
	Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717411;
	bh=91JQGQYSF7IV/F0KL045Nxmn+soVJeyYVB1PHP4iyvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CcpcIIrldGYXMOYfdvCiMzf3VcJQHj49/qgooXZfEHyMsstHdP0ZaK+nYL/L4t1LP
	 Kc5q4OkZFboJ80Ft3KnsoHHocCt/PKJHboRKDx7bwlsd6BiVjPksoNo+qSdfcG//08
	 yNN3BSpfKXaQFnnOb/JOhBFTXbc5lT2GdX5OvaPRDcV0zbTa8teeZmP+0NvlKciWsv
	 FscLOYgbQJlcFEU2I8/dqjEIm3fKiazAduRAcdSfVfjjqNUK/MlAb2x8YpIv/2GZnw
	 P8LC4u6BfZ6cthzTMVA74SVLwIyR+KTcSguuTAENx1O8/BdgTnKEZgIF3YF4qPWPbR
	 eAfHifgACsGHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.18.y] rust: kasan: KASAN+RUST requires clang
Date: Fri, 10 Jul 2026 17:03:04 -0400
Message-ID: <20260710163023.agent5-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709175943.129241-1-ojeda@kernel.org>
References: <2026070939-ranged-unmapped-3ab9@gregkh> <20260709175943.129241-1-ojeda@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:aliceryhl@google.com,m:gary@garyguo.net,m:ojeda@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273327-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F9C773E9BE

On Thu, Jul 09, 2026 at 07:59:43PM +0200, Miguel Ojeda wrote:
> Kernel KASAN involves passing various llvm/gcc specific arguments to
> the C and Rust compiler. Since these arguments differ between llvm and
> gcc, it's not safe to mix an llvm-based rustc with a gcc build when
> kasan is enabled.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

