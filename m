Return-Path: <stable+bounces-271621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ym1iCMI1R2okUQAAu9opvQ
	(envelope-from <stable+bounces-271621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 06:08:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F96FE4F1
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 06:08:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SitKjRch;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271621-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271621-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E80E63084D93
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 04:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE5631F9A0;
	Fri,  3 Jul 2026 04:07:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFB313E3F
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 04:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051644; cv=none; b=dIqdV84J8f5Q/ANf3YqOWkKwBRErEycnknT2oLG4m3WhGKRoeIm5XSit2MAz7+rw22a/U9AtNwImwdo1D/LKpyKyWr0fV2+W2YQzeIblKCXrqjp8VujPjnAtYtR1b3YPeuU9MtYm66z/ao1Z9lPqoxdxkNI2RdcmtMHWW4cZjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051644; c=relaxed/simple;
	bh=VGGzqv+ChY/7GJW7+efT1k8912oIHVmxhGhaiwfsxno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5R1+HExj7RP8WKrnP47qFFtG336CKMDp3rDaLenkmnHg5Yd/8EFwcjmuCL4XzFwrX3NKEsz/84BF+Hv46PmoBMift5srMdFlfGYVDZrF4LT6Wr/OGdnDUCBJ/f+FqfK1s35bc/dN6lf2GdzwepU1mwdTwqC1OOuyItRTuvmKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SitKjRch; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87301F00ACA;
	Fri,  3 Jul 2026 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051634;
	bh=edyh5A3PDIoxlNhPtrl9DOe7oJOErCP9W/lKFC8hCZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SitKjRchdAzUMpvC3w5DGHa2ct8ltjr7MO6s774g8ZfBYYatHZOikb8zpZdTn6lXy
	 0E8XYWLaAKP//B8I8s0ObH4vZYxM4ljB3clLN2x2XoEdM/in5bFRsuNkPVePYuKQke
	 jf66M37GP6jy76I5GIBTkTXDMOfCl8SgZW3zVIgFErfbkz0DO1QpBmqc8OSIZ1C5FC
	 XOI2/URLfvDznSBZM6Cnd22+iS78aaes8u7Pm08mIkbUvise7WZS75XsyXBAbw5Aoa
	 ACmymvbcIPGUEf4FxPovxc7SgYXeyfKLjgbSDQicUfiZS1KSQtOskxNLrDP93NthNr
	 AShBZqfXRmT/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.18 6.12 1/1] bpf, arm64: Reject out-of-range B.cond targets
Date: Fri,  3 Jul 2026 00:07:01 -0400
Message-ID: <stable-reply-bpf-arm64-bcond-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702080757.98071-1-shung-hsi.yu@suse.com>
References: <20260702080757.98071-1-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:shung-hsi.yu@suse.com,m:daniel@iogearbox.net,m:puranjay@kernel.org,m:ast@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271621-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 925F96FE4F1

On Thu, Jul 02, 2026 at 04:07:56PM +0800, Shung-Hsi Yu wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
>
> commit 48d83d94930eb4db4c93d2de44838b9455cff626 upstream.
>
> aarch64_insn_gen_cond_branch_imm() calls label_imm_common() to
> compute a 19-bit signed byte offset for a conditional branch,
> but unlike its siblings aarch64_insn_gen_branch_imm() and
> aarch64_insn_gen_comp_branch_imm(), it does not check whether
> label_imm_common() returned its out-of-range sentinel (range)
> before feeding the value to aarch64_insn_encode_immediate().

Queued up for 6.18.y and 6.12.y, thanks!

-- 
Thanks,
Sasha

