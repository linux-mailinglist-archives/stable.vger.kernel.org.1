Return-Path: <stable+bounces-273328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZBLzC5NeUWpVDQMAu9opvQ
	(envelope-from <stable+bounces-273328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A07BD73E9CC
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PjfI33qX;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273328-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273328-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 071283038F62
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B42701D9;
	Fri, 10 Jul 2026 21:03:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AF318EC4
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717413; cv=none; b=tPGpBzBnS/7vJCXeNb46K1PBBgufauEODb9/frBmFw2zmMBMgIOPS8yTB8qe8c/UxZHlidBYit/g/vwMFqvc+UT8LellBJZcE3Upw5+DFdrG8chMVmqRY0G56bUaf3MGYJ0FUn3HSTw1FuPxJU7ValCWQwr1YILPHWZA6rtX19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717413; c=relaxed/simple;
	bh=cgiNL2CtpQw8SDZgvgndOl4sBlr8Wbuimrif+QjzgXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii8DUT/rm9nEPIH4y686Az3gLeds8G9lViXRE43Qohaw5fHfqR7QT4Bk/zHW/xT5mIw5jYN1GY7asGPbUmN5XQtQXdtNX5JCFXRR2sPyGWTtgw/Q9xTOCs4cvWRsbKAS29axTaUkzRBv9FC36ToPLtFqhm7sW/bVFKEMPY6JAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjfI33qX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD21F00ACA;
	Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717412;
	bh=a2JFM6Cr2jk9GrHLFje8y09AuqtafrU/QlUJZvizf1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjfI33qX1Z2O3n4dCIAw8Gtdw1GHpVgfxL8AEUHPVrtfGHKz21PZ0NSI0bK1vQ3dG
	 CnvJ4yFZdLNnZfHE1tQHWlkChkm0QUrm9ZiBSvKkn+QbFo/y75ZZ0wmGqzWdHD/6fc
	 MGJk2eMvruguWv5sa1TdOM6K1kyytc/8q7o0lP3WSu6j/J6JORAuJbD2CnHlNVO2F6
	 TBYGp5My1pt7iqEA8j/rSqE5lQdIthFvv6kSkfEoLr8FF20uECVZ5oHPqePfyE20Mh
	 cEjyyR7I0AuHo9ZAnQ3fiwhtKREaIsP3WhT5JiYb3qYIm1F5KQE34JQ9CyNZC1Dlf7
	 H3mq+4CrAVryA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: kasan: KASAN+RUST requires clang
Date: Fri, 10 Jul 2026 17:03:05 -0400
Message-ID: <20260710163023.agent5-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709180359.130168-1-ojeda@kernel.org>
References: <2026070939-unworldly-mantra-5611@gregkh> <20260709180359.130168-1-ojeda@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-273328-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: A07BD73E9CC

On Thu, Jul 09, 2026 at 08:03:59PM +0200, Miguel Ojeda wrote:
> Kernel KASAN involves passing various llvm/gcc specific arguments to
> the C and Rust compiler. Since these arguments differ between llvm and
> gcc, it's not safe to mix an llvm-based rustc with a gcc build when
> kasan is enabled.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

