Return-Path: <stable+bounces-240342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIGUGhLj6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:02:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDE4447A6C
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66450304EA58
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787113148B4;
	Wed, 22 Apr 2026 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="U453sGS9"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEE267B05;
	Wed, 22 Apr 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870133; cv=none; b=agZPFUYyh3eAbubYYgv5iGdNgumu3EcAnjFqNyihKnW49hzfV4Prl6PIEumPuklmfnLWxzuZuEWRIf4aqIG2xF0GRFUUWVny5f0nSD6tejsaE2fXifFeGaZlIdG9rzy1FbNY9WqUbsSgwmesw2NHN0voNb/1M0ggOvAYBBU8vxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870133; c=relaxed/simple;
	bh=2rxekSydO1xxPn5lDiXZJneI6gUZUYjSHKzW5MNr2ok=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hRoMPnUL/iVimCbkM9ID7gXq2UalvLPX7fszpimsovZppMBRQcbR2V/Ef3YbVMNGlWLlUT7LPzHC9cGMNobpS1jgl+JsoXspDT1o9s/foAs4mh3noSYU4b0H2BCFEAtrqP9GfbDPg4TzPmSeBgw7oCo4r9zRFgX5JotlnSLbAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=U453sGS9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net ([172.59.160.77])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 63MF1DWF2875541
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 22 Apr 2026 08:01:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 63MF1DWF2875541
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026032601; t=1776870075;
	bh=2rxekSydO1xxPn5lDiXZJneI6gUZUYjSHKzW5MNr2ok=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U453sGS9qpeR9GbgD/hyMxReCSpj8ZzGcMXfFCR3I7XfvGcOu7rn7OA/wfbf4BeWP
	 79rjjCiEZ2XHuOs03HbYp8na9rSbZLISVoBNyHHLmFge8vLmHwpsOK7QhRsfXb7HE4
	 7CJ84AUKxL7ljKb2QnHiDULauNbYWq+pBQ/RQ77pVsVbJyHcqKh6lqOXtmqNhjcWfs
	 972gexGzyucceO+AQnaD6eNvqmO7dmtedEJ+1kALS5k1IViMX58pRjAxxOEmpBD6rI
	 oPF8It7OTaxImyeKp5CNkxMiLqcBzgrH8JMn/cK2zhd9WHgp0ksC99GM320zYYvrXW
	 7/kED7dqUi8cA==
Date: Wed, 22 Apr 2026 08:01:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@linux.intel.com
CC: Gayatri.Kammela@amd.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Disable FRED when PTI is forced on
User-Agent: K-9 Mail for Android
In-Reply-To: <1297b82f-e677-4cba-9c5b-ec40b0fe0c8d@citrix.com>
References: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com> <1297b82f-e677-4cba-9c5b-ec40b0fe0c8d@citrix.com>
Message-ID: <461AEFC6-243E-4BD4-B80D-FA565155A53B@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026032601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240342-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[citrix.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFDE4447A6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 22, 2026 5:08:27 AM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2E=
com> wrote:
>> FRED and PTI were never intended to work together=2E No FRED hardware i=
s
>> vulnerable to Meltdown and all of it should have LASS anyway=2E
>
>Careful=2E=C2=A0 All Intel parts maybe, but Intel is not the only vendor
>implementing FRED=2E
>
>~Andrew

We know=2E AMD are aware of the tradeoff as well and presumably have their=
 own approach(es) to avoid these problems=2E

