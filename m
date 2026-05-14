Return-Path: <stable+bounces-247189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO1PMiDBBWrXawIAu9opvQ
	(envelope-from <stable+bounces-247189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:33:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C718541AC7
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74DB93010C30
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057E2D1F64;
	Thu, 14 May 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll5KPs8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C226D4CA;
	Thu, 14 May 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761910; cv=none; b=QwhKyUGcxTbQh2oF5CkqpTcZmGsWyjTPnDzJa87n8wC+GcKGjFrk9oCveBZPO4uPCkTQN//zR9oNssJakcalYg6TqcCjVttxYUH9r4xBVxRWLEWYafuAC3pRKbF7L/447+/nfivFhqkvDXLr6cMwTxaaRFplWf74Q0yEAlS9S+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761910; c=relaxed/simple;
	bh=Kdy4Mftwo1hwWK6xhLBVe9sc+CM809ZEf01+zkfD+l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwN1E++YJT6YGrVUH05oo0+emAFX4ESqU2RCK2VbAdAhxKB+gkTywCASt/HNaU4Ml2PiDXQBtZiTiaDRO0tM1OVGtVkPJzN2mmuJ0+PN0i3mqOwVtbTyM0/NYKSOEoAA8SPPl0BscgHDBOc7WlpWw1G2cLv00tWV6JhHY1XRDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll5KPs8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39900C2BCB3;
	Thu, 14 May 2026 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778761910;
	bh=Kdy4Mftwo1hwWK6xhLBVe9sc+CM809ZEf01+zkfD+l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ll5KPs8EigMKyfqLr5aJO1zLLI5YxDq8sO+s9E9e3SyEZ0LiyiKO0RQHrBMr9+G/7
	 9dN4UiSK49VQOE/wyhDLOeWOAzPW0vWDda7ia8mDV6kewJsO77ciY2dNDJ7ztCyqL/
	 qaMKLOgwe7oL7rROSfnjIbFHBszCOs6Ump/4HdM5eaZ1SD1fLUqyyIIkJ+9vT0U1/c
	 CNRpS4KYNyVZ06G6eiWgm9MiICAT95Bv0IuUxIZ6QzHTi4H1+WRe9iAhGn/4ZfBFh4
	 KQzrVTBusdfdbYPpzqbi9HiXMkzyQ2NKcsOm8u/2R/n+VKTn8nqnSK1MspCBcVe8Cr
	 iLoLLDP3njWMg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12 000/202] 6.12.88-rc2 review
Date: Thu, 14 May 2026 14:31:39 +0200
Message-ID: <20260514123139.417098-1-ojeda@kernel.org>
In-Reply-To: <20260513153743.326058350@linuxfoundation.org>
References: <20260513153743.326058350@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C718541AC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-247189-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Wed, 13 May 2026 18:17:18 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 15 May 2026 15:37:24 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

The pin-init Clippy warnings I reported for -rc1 are gone, as expected.

There is another warning that will go away if these are applied:

  https://lore.kernel.org/stable/20260512201618.304954-1-ojeda@kernel.org/

Thanks!

Cheers,
Miguel

