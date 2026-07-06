Return-Path: <stable+bounces-272288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zDf9GgfbS2r/bQEAu9opvQ
	(envelope-from <stable+bounces-272288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 18:42:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA85E7136DF
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 18:42:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ilvokhin.com header.s=mail header.b=n05q+EyZ;
	dmarc=pass (policy=reject) header.from=ilvokhin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272288-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272288-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF5BC3001D67
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418A433BD4;
	Mon,  6 Jul 2026 16:42:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E335AC24;
	Mon,  6 Jul 2026 16:42:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356162; cv=none; b=ZWsSeVaf5pHiUiaxSlsORATi/EOLKW+ijWU+YaTWKaxxDeotndzNTej3XNkAjcrb85DycLDD8MoVhvRLn9z1tHOcboBOeusOxW91juFiZL1DptSoHR4Wnfm8q1i+YpZaebFGJg/bp/Vdm5nWOVrquZdCsHWcWHPASp10hFTkcPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356162; c=relaxed/simple;
	bh=bVtZtEZQnukQ8K+sG26vI4ygd12KkZjhfOKN+ZLwyus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLI7smrqXgSrE0CkiH7vKhsGOYI3Pmm2zlhEWSJTJ1DTs+duSf7jteYlje8fjFPXbvvZER6dzf1wYVMbqywtr4ZobdZgiAfiEkqjh1wmRhJwUAPGAeGF8v8XaRJyqi4w8amMU9IE93BsDbeim9kPim+4rPViLYWnP9LmnR8Pl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=n05q+EyZ; arc=none smtp.client-ip=178.62.254.231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1783356152;
	bh=EkJihMH0cOwClfnoZCmPH0Z78iMJRlERl2mGpDOQTd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n05q+EyZnOtRvl5j3UKfHbhCsQopprWV470/XS0KoR/SxSfzMHB5s/CeS1VuHDLhf
	 KDPx/e/7vXRhplEirRubzqwKVNsOogj6u44u0ndiPqWWyzd/HCBgDiQemd+REE4hQ5
	 rgQrLhZt6uBKqa4SXBtEJZtWOKguM8KhCxpF+cn4=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 70168DB4EB;
	Mon, 06 Jul 2026 16:42:32 +0000 (UTC)
Date: Mon, 6 Jul 2026 16:42:29 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	kernel-team@meta.com, Farid Zakaria <fmzakari@meta.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf record: Fix multiple PERF_RECORD_COMPRESSED2
 records per push
Message-ID: <akva9VhWFUtGzRMP@shell.ilvokhin.com>
References: <cover.1782743187.git.d@ilvokhin.com>
 <079503c01a3e28d3775947f3449cadacfa1f4117.1782743187.git.d@ilvokhin.com>
 <akk98zIfF08BoADo@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akk98zIfF08BoADo@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ilvokhin.com,reject];
	R_DKIM_ALLOW(-0.20)[ilvokhin.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272288-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[d@ilvokhin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:namhyung@kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:terrelln@fb.com,m:dsterba@suse.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:kernel-team@meta.com,m:fmzakari@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ilvokhin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d@ilvokhin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,shell.ilvokhin.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA85E7136DF

On Sat, Jul 04, 2026 at 10:08:03AM -0700, Namhyung Kim wrote:
> > diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh b/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
> > new file mode 100755
> > index 000000000000..42efe7260def
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
> > @@ -0,0 +1,64 @@
> > +#!/bin/bash
> > +# Zstd perf.data compression/decompression of multi-record data
> > +
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Can you please remove the blank line here?
> 
> Also, this series cannot apply anymore.  Please rebase onto the latest
> perf-tools-next.
> 

Thanks for taking a look, Namhyung.

Absolutely. I'll fix it up, rebase on latest perf-tools-next and respin
the series.

