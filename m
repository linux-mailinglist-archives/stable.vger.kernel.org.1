Return-Path: <stable+bounces-273330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4B9aKLBeUWphDQMAu9opvQ
	(envelope-from <stable+bounces-273330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BA73E9D9
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TbNNNPck;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273330-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273330-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887F6303F64D
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438938E8CC;
	Fri, 10 Jul 2026 21:03:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34232F765;
	Fri, 10 Jul 2026 21:03:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717416; cv=none; b=BOH9fko/YHRsX+DGvzyIxQft/XcGpQUa4YES+hFsLnbrQhxYVsZNc3fZlu9rPcyB7M7xx7RZ6xRuFuiKryz470E+OycPfLnAhLEhxWT6It204A1cYov/7HnxbgxqbsF4bS8lGQcTkZGRCkO/fhx869qJStDCoLk4JPhgwtdE6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717416; c=relaxed/simple;
	bh=PaUoKvrlMJsfzC7QyZ/UEAlmd9FZMCy8oyKrZV1Iqjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwMX0izJuODkmfBPe9lK6t/9QJt46uTeJWjt3VDZVpiFmww77fZ5etg+YP2CV9FkEBqxlB/2kBo508KIxmh3FoM+jTRZf9xj5gyhUwBP3Bn/6c0/o1BHC0GMchgCpmncQ7rejSmjy30rmwcvcu2CIeYzSY7K7R+0YqxE+c/n92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbNNNPck; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05B61F00A3D;
	Fri, 10 Jul 2026 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717414;
	bh=A6ZivBYGr8LA2bUO7cgwXGSWiepiPbzSVpCEbDDI1mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbNNNPckQrdYDAlUSL/va76XXbFFV/M71lQjXSYpZT/R5DWVOE9hLvDwyepCkV+zw
	 ew9ZsWbwWN3d2JL3oWsBOBLyE83y4owtF0+Eyss+Ai0jBE88hI7KMHwNyYgVLs0tgc
	 R5LE4B1uMRLduiGro3EUze2g8wiC5dBhPdAjQ/NM73CB5K0KQKdHKAEfsrl78RVPG6
	 c1ric7fIVn82IzCB6bfwmTx6BFo+538W0J9wxsGDn5F9e+dvjbVsL8qBKk44CWUlaE
	 c3IW3rfAYZ38PYZ6FJ2XJCt7tcoLdN+QSeg5ptN2Cn+4OZp0QKT8LywmIqJJEXlp6z
	 8TOdPmDMZ7dHw==
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
Subject: Re: [PATCH 7.1.y 0/6] cBPF JIT spray hardening
Date: Fri, 10 Jul 2026 17:03:07 -0400
Message-ID: <20260710163023.agent5-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:x86@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:dave.hansen@linux.intel.com,m:pawan.kumar.gupta@linux.intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273330-lists,stable=lfdr.de];
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
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 115BA73E9D9

On Thu, Jul 09, 2026 at 03:22:54PM -0700, Pawan Gupta wrote:
> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.
>
> To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
> The flush is conditional to spectre-v2 mitigation applied.

Queued the series for 7.1, thanks.

-- 
Thanks,
Sasha

