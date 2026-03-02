Return-Path: <stable+bounces-222602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF+XDMCXpWmuEgYAu9opvQ
	(envelope-from <stable+bounces-222602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:59:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA7F1DA42D
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8293301FB89
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290B3FB045;
	Mon,  2 Mar 2026 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDgve3Nl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B03CC9EC;
	Mon,  2 Mar 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459963; cv=none; b=OupJeYVgercg2efhhIgkFwcaYVy9iiDaCUCV7MYlT/tK9tnLTO3LBNjhVnk7fMJbwtQPi+IrCj7QM/0LUpqgXVD9oPXymoPDV1DL/Drg8k1iVAG2q8F+pY8CMvLY4najsKDWVjrVuRP2eu48BrzwnYX/iGSKOAMgm+0AUgDkHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459963; c=relaxed/simple;
	bh=9dgLhuDOrdcxNTJsG12/1BBo9vbQ4htM+BYe5ywJfWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsOY/Jh6ZcJHnN253GtGUXrKP4Hdpul3EslLLpYdjfiFg9Uijwv8aMa8chWQAl+6AsAUUN73V0JiWKdmFyr/bBlfFX/1+Mr4qruz6tplf1MiqyEv1qmfCte/3E8HgeCuqwF7BYj6Glqze1uprJL7DiLxbNUX8JPs9uOPP3Baml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDgve3Nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EEFC19423;
	Mon,  2 Mar 2026 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772459962;
	bh=9dgLhuDOrdcxNTJsG12/1BBo9vbQ4htM+BYe5ywJfWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDgve3NljtUg/BBfb/XyU+OM3vVwjSoRx3H/T49LfXgHM9WZXnMUqYJxof0Kopjw5
	 YNNX6GIgYRCH+dRR0TQY++rtqMUWub3lyvmEhOyl/qT/he3Tn6q3rtCzqthEVkDpJq
	 u1jqRolfzeNnEqmmzsSW8brK9ieg9XYqGMuNpaXbm03u8LYKhhZkH0e92o6KYDkTRH
	 vVkh5KjaTSgy1u2MA6DwSV7nwyLMSRBvDaOUsOAmhd3trHOmWPhb3QMBuN9KfsrnWb
	 7UZvo5/NIRCdnHFlBTQjmd3vO0wBVZFm4syux2pbQfC7FMgz8uJcK9LKYvX+dMaKn1
	 uveTNFp7vsNZg==
Date: Mon, 2 Mar 2026 08:59:21 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 6.19 030/844] perf stat: Ensure metrics are displayed
 even with failed events
Message-ID: <aaWXuXYqkGZ1qQSJ@laps>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <20260228173244.1509663-31-sashal@kernel.org>
 <0e06b461-8c81-495f-b096-cc833e284995@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0e06b461-8c81-495f-b096-cc833e284995@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222602-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FA7F1DA42D
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:09:11AM +0100, Jiri Slaby wrote:
>On 28. 02. 26, 18:19, Sasha Levin wrote:
>>From: Chun-Tse Shao <ctshao@google.com>
>>
>>[ Upstream commit bb5a920b9099127915706fdd23eb540c9a69c338 ]
>
>And finally, this one needs the below to fix the test:
>ff9aeb6bd14d perf test parse-metric: Ensure aggregate counts appear to 
>have run

Queued up, thanks!

-- 
Thanks,
Sasha

