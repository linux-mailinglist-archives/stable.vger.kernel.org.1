Return-Path: <stable+bounces-260582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xuQsA5L9IWpzRQEAu9opvQ
	(envelope-from <stable+bounces-260582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 00:34:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6A643CF6
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 00:34:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ePGtOeki;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260582-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260582-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F187A3019463
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F13264E9;
	Thu,  4 Jun 2026 22:34:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143612EEE7E;
	Thu,  4 Jun 2026 22:34:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612491; cv=none; b=Mzuiivw81fyBYAb81Ix1j6EPfB8nxe60vGZuFdI7AxmztHWc+uZCU6t1di4KneMrzEKw4yvgu+vvsCL+JKleqK8VYw/g4H0VXeCncj6uDZP5kZ/0Ueaa7FFQ95SmJpxLnxJTfJUVQyVIdn4b8/7gwL3d0AaHHEFJwnnkUDQ85BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612491; c=relaxed/simple;
	bh=VP4F0xkWxj5tzT5CrGC3RlsXfd3mjrEUhES754xvRqE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AbD7+6KEs7GzVWBdIgBmgN4Itt4PHBCAVzVjca3mm7ZxhR8myAldZT4hRXhpKy/b5dAkS71ReL1xeDxptJkAJq4uHCJRMMq3m6rFt5+nf2t1xDtfenyEjjzx2MEtnVj5x3+5w+yds33jZNOfRz5totYFlKn1CVJxju0GdWIhJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePGtOeki; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CA61F00893;
	Thu,  4 Jun 2026 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780612490;
	bh=JCXTt6z5lOY2aU+SzovpRo0xKYfFek/tfWbXMiJfMpY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ePGtOekiJ6cUK8KCaa1gyw75Vbg+ynihsGTH/E7ay4sa+vxdr4c++WjuNuT6lwvYO
	 Z5ENf3sMNFbkSyuW5iNztvQ6aPGRdwsdFu6aI64WMGYa0AJw0JbCic+xAParmxZzbV
	 BUNTo7qyUMg1GikLM3uJVrsjLrQdt/tdyAo7J/hhSMn6QRoGcUOmYIwlQmw6DB/MIx
	 PR9t3U/DYcMYrIXdT9z61/QKcotJx1R0CxHo/1CEzUgWPkEqCLMxY+ryc/P2zdspra
	 RFJkKw80rutpwAd6CTiVNri8QiDG0k3HVQLR7LKwGpszQ8NLkBQggnr/0MT/Tz6KFM
	 e+DTRECKOc4OA==
Date: Thu, 4 Jun 2026 16:34:49 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
    stable@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 2/2] riscv: mm: Define DIRECT_MAP_PHYSMEM_END
In-Reply-To: <20260309-riscv-sparsemem-vmemmap-limits-v1-2-f40efe18e3cd@iscas.ac.cn>
Message-ID: <533b4094-e97c-1661-1ad2-4e7aea683f4f@kernel.org>
References: <20260309-riscv-sparsemem-vmemmap-limits-v1-0-f40efe18e3cd@iscas.ac.cn> <20260309-riscv-sparsemem-vmemmap-limits-v1-2-f40efe18e3cd@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260582-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wangruikang@iscas.ac.cn,m:pjw@kernel.org,m:palmer@dabbelt.com,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sophgo@lists.linux.dev,m:stable@vger.kernel.org,m:gaohan@iscas.ac.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57C6A643CF6

On Mon, 9 Mar 2026, Vivian Wang wrote:

> On RISC-V, the actual mappable range of physical address space is
> dependent on the current MMU mode i.e. satp_mode (See
> Documentation/arch/riscv/vm-layout.rst).
> 
> Define the DIRECT_MAP_PHYSMEM_END macro based on the existing virtual
> address space layout macros to expose this information to
> get_free_mem_region(). Otherwise, it returns a region that couldn't be
> mapped, which breaks ZONE_DEVICE.
> 
> Cc: <stable@vger.kernel.org> # v6.13+
> Tested-by: Han Gao <gaohan@iscas.ac.cn> # SG2044
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Thanks, queued for v7.2.


- Paul

