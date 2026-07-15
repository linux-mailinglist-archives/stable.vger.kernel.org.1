Return-Path: <stable+bounces-274630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 22MaMNPQVmoRBgEAu9opvQ
	(envelope-from <stable+bounces-274630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:14:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415047599F9
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:14:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CMYw2Fig;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274630-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274630-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865E331294F2
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511888003D;
	Wed, 15 Jul 2026 00:12:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384D249EB;
	Wed, 15 Jul 2026 00:12:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074377; cv=none; b=dNlGF6HT7XMnOpVeWddrPLa7q4BEgK9CR7N0hf4KNgKDf/HgH+m8XXtnrjGT6rWV6qXEWNtEB3gzyfjn1B3hX0CRe+VoGAUKn5/ohmCV7QkZTuTYLLx516k2H64wKa6WRnmtgzNHlu++QwAJBpzNRwde58tXHTlZ7WSYaf6cJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074377; c=relaxed/simple;
	bh=6jc+yjp1RQ5OnSkF89Ts/Jm0d9pCxfFq87zIRlLRKY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAzM5k89wx2Ovy6FUOdxPHe6i3xAG8ChDcIt7pQfPwLqhigb3f04MotVZhxsCMbVITmifsLH4KaU2ZBIsW+krjTvl2Lalqrj4OKoaV9uAtEsNIIO6FQyHwIXHcYUSZ7Es6ULqUWBCPuxu+OxFXB1tVNZfwx1QruGlroV17uQHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMYw2Fig; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E381F000E9;
	Wed, 15 Jul 2026 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074376;
	bh=SDbonQLIoOSfVB1dApPM6LkzNs1SHNxOM+rrSsaUBBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMYw2FigPP7WfHBpvhgZlAhmWy0bpTPXB0dWdx6Sf2hHBsld1RyoxLlCa++abrtsP
	 6EV4GohitQfVk2wKCr8O71Tk0CdeD46bXWbAd2OqoAUCZQKX4FEbqODHs0l9VZXgHA
	 iRubQs5iHitl98Xt++qJSvdKnk6DPP7t4j7rCfrbbuns2ri1g0rNuDJt2wPVOI5RQC
	 Gkks8B8BofuZ3kPdXy6OKqse1ZB5GzONMooax7IYKIEDgxmK9JfdyAwMg8UBJjWMwL
	 te64+fdolGgdSWPyG5+w2q0ZQPCiYtxCHLkkE2gxADmGExi2IMa1LU+wdk/ZFNBGYW
	 n+XWGFINNchSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.18.y 0/6] cBPF JIT spray hardening
Date: Tue, 14 Jul 2026 20:12:40 -0400
Message-ID: <20260714200600.stable0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:x86@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:dave.hansen@linux.intel.com,m:pawan.kumar.gupta@linux.intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274630-lists,stable=lfdr.de];
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
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 415047599F9

> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha

