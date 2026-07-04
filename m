Return-Path: <stable+bounces-271897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D5RDCYdqSGouqAAAu9opvQ
	(envelope-from <stable+bounces-271897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:05:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC87066C8
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:05:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A+4DfPkc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271897-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271897-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD18E30191B8
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5626A374178;
	Sat,  4 Jul 2026 02:05:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C337372EEE;
	Sat,  4 Jul 2026 02:05:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130743; cv=none; b=QT0/Hp7ZZauuNjyurMJb6V8Bc00q17u2lmxHQNHH64NTLQTeQny95d219exN9kDZ5A14xxBGQF4jvsVCOHLX14U5yz3UQMi5hwuA+tyXOtDTzt7i3ov060agoNdMgsvJShBBkYYCZj/o2EH+65O/6gdkA9mymtoS5hbLC7qxVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130743; c=relaxed/simple;
	bh=yZ+9M+CnYuoI7Kw3ysRahFXQZmqCzdJ5r+NQmuMdeyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+z62oeO23pE8fr8aWZQpEbfM64m5JlF737eA07kv0Xu5qlh4ZDKPaTF3gTFGfw3dU4PWuqWTmH+P02UaQyGy/O68YH6ECBJuMHkYqz3pKjrAqDXtRZ0XZHJeLUNCctFMVl0bzSCiJmMS4lxCe/RA0NT1Hx+PxupV0wfrMTGM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+4DfPkc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EB01F00A3A;
	Sat,  4 Jul 2026 02:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130741;
	bh=R3EV/PBn8kUz2nBJMZlaUuDi6000cvpEZ7oEuepNteA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+4DfPkc+V9jvGZj1GBEvjpRVvAw+N7VFT8Fx1HAE69h0VfaDq4j8kKJdbmd03odi
	 NHKTfe1p5Ne5H3pAJrevGcR47BQv5Z4B5ZoGYGzYba0m3CL3bheRFassccXEY5UIEC
	 FzoVeuWcTYK6mxHhpCAJvef6OVQeLcvHn2qLXKpd7kXQQf79g+jGr4vWTmU135Fsag
	 aiP8vfzwUDmPw5c4Xfp1BNzMe0R4RI64kSt+dEupyDynJGVppkvsdtbQATnXI0eo+u
	 d94L3UJmA39ElcE+Q6AWgzHEvyBwQ/sjVfcSBY3A0oirAfaYHml+dHphLvRz09VFoj
	 txbg6tI/kDvrw==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 6.1 & 6.6] LoongArch: Report dying CPU to RCU in stop_this_cpu()
Date: Fri,  3 Jul 2026 22:05:08 -0400
Message-ID: <2026070315-stable-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703032401.857553-1-chenhuacai@loongson.cn>
References: <20260703032401.857553-1-chenhuacai@loongson.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271897-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:chenhuacai@kernel.org,m:sashal@kernel.org,m:kernel@xen0n.name,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:chenhuacai@loongson.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5DC87066C8

On Thu, Jul 03, 2026 at 11:24:00AM +0800, Huacai Chen wrote:
> commit f2539c56c74691e7a88af6372ba2b48c06ed2fe4 upstream.
>
> This is a port of MIPS commit 9f3f3bdc6d9dac1 ("MIPS: smp: report dying
> CPU to RCU in stop_this_cpu()"). smp_send_stop() parks all secondary
> CPUs in stop_this_cpu().

Queued for 6.6.y and 6.1.y, thanks!

-- 
Thanks,
Sasha

