Return-Path: <stable+bounces-249748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c9pMByJCDWoAvQUAu9opvQ
	(envelope-from <stable+bounces-249748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:09:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1633D587B3E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79A943026009
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A1D346A0A;
	Wed, 20 May 2026 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/DWnFDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B312749CF;
	Wed, 20 May 2026 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253784; cv=none; b=X+8hah33HfYQq6FwYDDhbb2pn5HNd0qJwZa2zULCK6fjUig6tk1AQxrSU8fD9jJS43wgWR14z2gv1oibOkN0YNSkWhqV2yOwVyRiKbrg9Uv3kH+cT+1s8f8M++TIYiDJknQ5wdaraKDDplUvljZm2PpoXunmAIm59YePYfcMaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253784; c=relaxed/simple;
	bh=OWHKOrdblIpLs4J13itWhTkOaE29xb0S9GX/3PfJzfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpSfL6RLJtfp/vtevmBPJYNIS7/cCWlUSNYGss3bhOc2WM+qa1Ewdz3ZmZvN8E1B64bH/sa7SCSGOw4IYR2zf8DHn5Wxj9N6H6uZN/fKghalkv3indb+IeXGZMmKW8HxgVZt7FZW9XFLC8sV2YsCp9eRMDa8RSasXoY+CybyT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/DWnFDf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E478B1F000E9;
	Wed, 20 May 2026 05:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779253783;
	bh=7/jZW1N9MI/xVxMIZT7q6FGbksoc2YLmCYf5xpAjm9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/DWnFDfeVPs6tLar6fdfdg7BrzlH3ea97UPQmkAHb07Irdej/Mq8D1gq90TU4oU2
	 I6RvfgNnKkNiHQG+reepBNBDRoq9Htwo6TWcEXda8oEOUIF+AD7all8JDsqMS8MLNu
	 pM8Ork79MF8VciT07zLXLI1B/+HV1y3IrLD1nRdHVg6G4m/eA7tkqB+hgsDkifWcys
	 bmwwp7E3YwSHR+A4/KL/nC2szgUuEJu3/CUmEJt4A/McTcpHCpDp0nEJmk/lHaaHgb
	 WESlMs4MMvAv5nCZEsF5xvchPkLEf+di6+w+2Dr70gxaVgyBNUW2l9TwmYL7ddGPMe
	 7ryaAnUAOXalg==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Date: Wed, 20 May 2026 08:09:26 +0300
Message-ID: <177925371880.3535040.4659421700056655477.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519133332.2498092-1-pratyush@kernel.org>
References: <20260519133332.2498092-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249748-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1633D587B3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 15:33:30 +0200, Pratyush Yadav wrote:
> Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
> NUMA nodes") made sure preservations from kho_preserve_pages() do not
> span multiple NUMA nodes. If they do, the order is reduced and tried
> again.
> 
> The same logic was not implemented for kho_unpreserve_pages(). This can
> result in unpreserve calculating a different order than preserve, and
> thus not actually unpreserving the pages.
> 
> [...]

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: fix order calculation for kho_unpreserve_pages()
      commit: ec4084bc445027a52f600e30a976928be1ba1950

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.


