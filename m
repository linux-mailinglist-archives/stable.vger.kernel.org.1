Return-Path: <stable+bounces-273326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A83DHnJeUWpRDQMAu9opvQ
	(envelope-from <stable+bounces-273326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:04:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6373E9BB
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:04:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Uab5EaWf;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273326-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273326-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33793033AB6
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF2113DDAE;
	Fri, 10 Jul 2026 21:03:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8A347535;
	Fri, 10 Jul 2026 21:03:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717412; cv=none; b=VgxiqsP8FjYUrIi9142UBk5MuBpNVZTvmaHCZgJ+YILrhfGZVKDLmTPvcVhviwOoTvXeRIyKCMSbUrfYiX/1dpH/IyvSA+YSUL/DlEVYmzp4N+MfwrGi3TqrLz6Sa1PYD4wgprcfvcMBkfykc8G+JSY+gdyKGIeWioh76Kf1oQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717412; c=relaxed/simple;
	bh=QblUx/ap3+o1+PyVsNXtmBYuaFLSHxR56lIoHGPqr4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlfXlLC7PKPxBxbzbQNehR5fZgdD9/fxCc7heLIF39UA74J0Gy23/PW9oJ91BxZa9d6lJyd04O5Mi3wS58SSGgavybmqI1q069n8NRYxTRVjdcH5BhIhKGXpF+YxB3WgnAIDT4Dlmog4rFZ4Z7PDE5wbsOmHIvAWzpEtwNUCEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uab5EaWf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCBD1F00A3E;
	Fri, 10 Jul 2026 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717410;
	bh=EYazxkYQmUsgPzsmOv8+UJeTiBmiNuPQux5HbSSpMH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uab5EaWfGxTu8hvbuAHR74jr8kom6DNC6kz0GRJ9mgxa2uxvX01WUmvrMwZeE6p9Y
	 XQEGuccb95krqK5z3BHJ+11bMyqow7H7UvnLKUut/XnuU1BbjkkjHwOw8WUkqgcFvJ
	 0/JYMtOWQoZCGdBAGz3T6RrXZPh18tXl/ZZAbsmbU/vMcOAaQjow9NuznopKhnk8ZB
	 jeezivJ2vXimEHO6oYTJTPtORAvuJBitfWcN0QnTPMZSziiVuAJSuCpVMRjoSGxQOr
	 pAa1BDwkQJUiAcynu+QWgwoBSfvJnbpT8jWzWkZqkUlFegZGxxcnvZgLyh20tT3QJ1
	 WSnTP3dTxP8IQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH for 6.6] LoongArch: Add PIO for early access before ACPI PCI root register
Date: Fri, 10 Jul 2026 17:03:03 -0400
Message-ID: <20260710163023.agent5-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710122613.1596480-1-chenhuacai@loongson.cn>
References: <20260710122613.1596480-1-chenhuacai@loongson.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273326-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:chenhuacai@kernel.org,m:sashal@kernel.org,m:kernel@xen0n.name,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:chenhuacai@loongson.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16E6373E9BB

On Thu, Jul 10, 2026 at 08:26:13PM +0800, Huacai Chen wrote:
> commit 6061e65f95713b01f4313cda6637dfe3aa5412b4 upstream.
>
> For ACPI system we suppose the ISA/LPC PIO range is registered together
> with PCI root bridge. But the fact is there may be some early access to
> the ISA/LPC PIO range before ACPI PCI root register (most of them are
> due to abnormal BIOS).

Queued for 6.6, thanks. I fixed up one context line in
arch/loongarch/kernel/acpi.c that didn't match the 6.6.y tree.

-- 
Thanks,
Sasha

