Return-Path: <stable+bounces-215549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOgwCK8zimkPIQAAu9opvQ
	(envelope-from <stable+bounces-215549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:21:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 696AA1140B0
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EDC2300A8DD
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0A641B34E;
	Mon,  9 Feb 2026 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+oemZp2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0F2DCC08;
	Mon,  9 Feb 2026 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664874; cv=none; b=sMmAJcCaF2i7pNAEFSsOayvFfeb+syfRqqv7i3zfMaqvpUIoqrmtDhPH4mHsQ+ed5e+TsLyLhd/MUIYN8/Y2CNAfhUuHHS8z453Jjgknw3Gr6pjOvszJbyOSpt4rnwfZiE0flNp1Ufoj7r4E/x4UbbDQcy8feLvEfOgB/l27TH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664874; c=relaxed/simple;
	bh=bNNc1gC8Fvpeez2ln8nJObv6BmiQ69v4dNG9XL1OiFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4S33vIAej2f4eiCTxWKIpipBVWOp3utEpwij706fx34CsmVPd2Aw9c8oJmGcXp3pZcse9hhoULSpStMW13DgLJzVwNXmfznAP9QwYPM5igPZVbleNRp+ejvAdqSWPsPE+Wckzi4/CQ62mMbnabV1bUgdiqI+1PNEFlTqmEuHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+oemZp2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770664874; x=1802200874;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bNNc1gC8Fvpeez2ln8nJObv6BmiQ69v4dNG9XL1OiFI=;
  b=N+oemZp2QZPewUoUthYlYhs5D+QWjFnTeBN0qTHzTD7LGQI0g1IONV5r
   deuE+p9e1r6deBAriKNmGJu43omHnDzoIoexQZFZlEgwhomfehQO2iJAt
   zSrtD5OAf5N97ZIm6q7PSgl33cRemYHB9vhdqw/HvV7hzHTxGfBO4bS2j
   IwkJwnotQ3ABlRVkh70s9zcfjYsaWiieWezytSvJ7BGSi2CLe2YfJno4O
   p+CDGaysPS20DThPCB/DpjL+pRQtnxakLBFCfqiDzGCawZLBqCfSRnjmp
   3dDfag5jqB9lDBtwSM0yGVznQZu1FENUzju/BQVmTOdxs94pldvzC0kGa
   w==;
X-CSE-ConnectionGUID: 8cqK1V/TSKaP87poPNL1tQ==
X-CSE-MsgGUID: Z3+xLWJZRsSQKWdFSFtkmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="74388846"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="74388846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:21:14 -0800
X-CSE-ConnectionGUID: mxJsSv7oQKCTosTOaXZ31A==
X-CSE-MsgGUID: JIshv9ZQSHmpMaZRJgVJJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="210816971"
Received: from unknown (HELO [10.241.243.83]) ([10.241.243.83])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:21:13 -0800
Message-ID: <b5e9109e4be90f596da9c12cbb2e6bf0bf55a0c6.camel@linux.intel.com>
Subject: Re: [PATCH 6.18 2/2] sched/topology: Fix sched domain build error
 for GNR, CWF in SNC-3 mode
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Greg KH
	 <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar	 <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann	 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel
 Gorman	 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim
 Chen	 <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Len Brown	 <len.brown@intel.com>, linux-kernel@vger.kernel.org, Chen Yu
 <yu.c.chen@intel.com>,  "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Zhao
 Liu <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
  Arjan Van De Ven <arjan.van.de.ven@intel.com>
Date: Mon, 09 Feb 2026 11:21:12 -0800
In-Reply-To: <f391338d-49bd-4383-a8cd-0dd8073da764@amd.com>
References: <cover.1768948644.git.tim.c.chen@linux.intel.com>
	 <741531fc98d3c3d364451113b26c4900a868348a.1768948644.git.tim.c.chen@linux.intel.com>
	 <2026020701-ether-wieldable-f250@gregkh>
	 <f391338d-49bd-4383-a8cd-0dd8073da764@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.c.chen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215549-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 696AA1140B0
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 09:29 +0530, K Prateek Nayak wrote:
> Hello Greg,
>=20
> On 2/7/2026 8:59 PM, Greg KH wrote:
> > This breaks the build:
> >   CC      arch/x86/kernel/smpboot.o
> > arch/x86/kernel/smpboot.c:548:5: error: no previous prototype for =E2=
=80=98arch_sched_node_distance=E2=80=99 [-Werror=3Dmissing-prototypes]
> >   548 | int arch_sched_node_distance(int from, int to)
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >=20
> > How was it tested?
>=20
> I believe this build issue was fixed by upstream commit 73cbcfe255f7
> ("sched/topology,x86: Fix build warning")
>=20
> (Full upstream SHA: 73cbcfe255f7edca915d978a7d1b0a11f2d62812)
>=20
> P.S. It cherry-picks cleanly on top of "Linux 6.18.9".

Pratek,

Thanks for pointing to the patch.

Tim

