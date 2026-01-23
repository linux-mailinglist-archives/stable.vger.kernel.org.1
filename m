Return-Path: <stable+bounces-211393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICtcA5uIc2krxAAAu9opvQ
	(envelope-from <stable+bounces-211393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:41:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD7C77300
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A90E301F33A
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3A31352F;
	Fri, 23 Jan 2026 14:41:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA623D7DC;
	Fri, 23 Jan 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179284; cv=none; b=gAsYfgOOGXhbspE+AmuRhR5irlnPsZR3J/7ZErQwWjGFvuQzTkLE23QpMOhJF4HHLKgd0h5w6PmDG7QIBoMB03UhJMRvDU6i0VtVbs88IyTI0N6o9piOWTwp8e1URDHxJCm4SGRAGOnGXJ8zFnyvveU2WV73tHVxYvesQqXbPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179284; c=relaxed/simple;
	bh=uv1CtOsiJc6r4s8Pfj+sLjNth3vSmN60bqHdaQ5XL3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqZqckQI3mdcuRnFf5tqMd0NMLGIF84B0/BPAunTvAS8N7ldfs3PT8tx9AjArsUXmfvETc7e8oyQ9jrZkfoLwPFQRRumx/4vRSyxD3nm+TUQzhGkfhbjPrG1RTz+L7V/enzqVKf4dFjtYEqsEqstbIf6BtEtUVlYEIYqzo0xbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B34E11476;
	Fri, 23 Jan 2026 06:41:15 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1B93F694;
	Fri, 23 Jan 2026 06:41:21 -0800 (PST)
Date: Fri, 23 Jan 2026 14:41:19 +0000
From: Leo Yan <leo.yan@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: James Clark <james.clark@linaro.org>, Thomas Voegtle <tv@lio96.de>,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf arm_spe: Fix bitfield dependency failure
Message-ID: <20260123144119.GC40455@e132581.arm.com>
References: <20260123100218.233246-1-leo.yan@arm.com>
 <705c0889-ffb6-4758-941c-ccfdb367d9c8@linaro.org>
 <20260123120847.GB40455@e132581.arm.com>
 <20260123140317.4bd85cdb@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123140317.4bd85cdb@pumpkin>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211393-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,e132581.arm.com:mid]
X-Rspamd-Queue-Id: 5AD7C77300
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:03:17PM +0000, David Laight wrote:

[...]

> > bitfield.h is a common header so I did not change it.  I digged a bit
> > and found diverage between kernel's bitfield.h and tool's bitfield.h.
> > 
> > 1) The kernel's bitfield.h includes asm/byteorder.h, and finally it
> >    includes linux/byteorder/generic.h, cpu_to_le{16|32|64} are defined
> >    in this file.
> > 
> > 2) The tool's bitfield.h will includes asm/byteorder.h, but this hooks
> >    to the headers provided by the toolchain.  cpu_to_le{16|32|64} are
> >    not C lib API, they are defined in tool's kernel.h.
> 
> Perhaps cpu_to_le16() and friends should be defined in the tools
> asm/byteorder.h rather than its kernel.h.

This will override the toolchain's asm/byteorder.h.

Another issue is:

  $ git grep -l cpu_to_le tools/
  tools/arch/x86/include/asm/insn.h
  tools/include/asm-generic/io.h
  tools/include/linux/bitfield.h
  tools/include/linux/kernel.h
  tools/include/linux/unaligned.h
  tools/perf/util/intel-pt.c
  tools/testing/cxl/test/mem.c
  tools/testing/nvdimm/test/ndtest.c
  tools/testing/selftests/arm64/fp/fp-ptrace.c
  tools/testing/selftests/kvm/include/arm64/processor.h
  tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c
  tools/usb/ffs-aio-example/simple/device_app/aio_simple.c
  tools/usb/ffs-test.c

I assume these programs include kernel.h for calling cpu_to_le(), if
move cpu_to_le() out from kernel.h, it will break build for these
programs.

Thanks,
Leo

