Return-Path: <stable+bounces-227566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JLqF09uvWnL9gIAu9opvQ
	(envelope-from <stable+bounces-227566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:57:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5762DCF53
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A93C63056677
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94053C3447;
	Fri, 20 Mar 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="bn3Bg17/"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C33BA25B;
	Fri, 20 Mar 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022197; cv=pass; b=KRXkgDz6iMSWBJhQ6cMXmA/lK2ndHkjtj9uv9tlnfjUkk6yVTkCyXnni5w0NEDqX6lwjDMCp/lGy1csYdwxmA94SHSddzRsUenSr+2BBJFB1sYfjci3vOGDSZFLEEp2yPcgpbpKOhNpCIm/eWWYMLqMC5q6iFHTsyWhly/M9uGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022197; c=relaxed/simple;
	bh=MsqlglhAyAGTJ9sZddHtacas1qnBNBYlWQoicPPBv1w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PmWPimQmOyPZDW/siVvLF+1BfOWJq1zPwH07vuY5INaEPxJdHAG1ScR+Yx0q8awJZvOjcRXxoIBpIkjExY5RErdjXwyPy7idwHKx7SaE4kSM8hEy430E60fDw/X7LWhabkxzfO7WH4DUcYVNZg8kdwPB/pFzYA9ZOk8zOubJpo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=bn3Bg17/; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774022171; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GvM1y9O7vXkIlcCHrvTBJtnv9HCQV4Gc/c0zB74+2dB9SSYoBC18N/JP6Rtz+oK+2jvH00Bfv2IguP5GkWiYHAGZnbmdVzsITZ7U4PfuuZJ4hKl4yZnspmLxhaof3Dkc3tjB7oXNdeQzAbOwMXXHdGSVQ4HlcE8pzS3oGBiWnc4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774022171; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CA+8hnD1UcyY5V73KLuUWNPdACXCtzhVUU8X6g3h/pI=; 
	b=kQ0gDcoQsX9q9f+AhuNhazwq8AHv8/Oe1nZaAQYnV8uBDwWrlMjadBB820LR0NxpyVb310A/Endhty1pcD4JpFpY6kK1Z/BjtLqxhZhCQ2os6B6ctqF1pKfkn1hvIk3VIYDDE+e7zfJYlQt3Kh87LL5rWWbEDbLesFmHEKllF6s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774022171;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=CA+8hnD1UcyY5V73KLuUWNPdACXCtzhVUU8X6g3h/pI=;
	b=bn3Bg17/9HkWaxtWz8egaSn05oV6OjxGB3ufD6xBy4RG1mT4kMZ8YhAyagwBNebZ
	FXv5c+17OnuT8rlXwXR6eYdyNzrCIc06Y50QrPNmYECUh9F0zl5vDTfrq0NKLh8wKsM
	wzCdTrQjBatcthNN2D/2Mc//3nFu9tz0MokOrQkg=
Received: by mx.zoho.eu with SMTPS id 1774022169790495.36152178791474;
	Fri, 20 Mar 2026 16:56:09 +0100 (CET)
Date: Fri, 20 Mar 2026 15:56:09 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_mm/damon/sysfs=3A_check_cont?=
 =?US-ASCII?Q?exts-=3Enr_before_clear=5Fschemes=5Ftried=5Fregions?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260320155115.101025-1-sj@kernel.org>
References:  <20260320155115.101025-1-sj@kernel.org>
Message-ID: <E4735091-5CE2-42C7-BAF8-B74E49791829@objecting.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.95 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[objecting.org,quarantine];
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227566-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.025];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[objecting.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF5762DCF53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20 March 2026 15:51:14 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Fri, 20 Mar 2026 15:14:54 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>>=20
>>=20
>> On 20 March 2026 14:47:40 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>> >On Fri, 20 Mar 2026 07:06:48 +0000 Josh Law <objecting@objecting=2Eorg=
> wrote:
>> >
>> >>=20
>> >>=20
>> >> On 20 March 2026 02:13:17 GMT, SeongJae Park <sj@kernel=2Eorg> wrote=
:
>> >> >On Thu, 19 Mar 2026 15:57:40 +0000 Josh Law <objecting@objecting=2E=
org> wrote:
>[=2E=2E=2E]
>> >> >Not necessarily blocker of this patch, but seems all the issues are=
 in a same
>> >> >category=2E  The third patch of this series is also fixing one of t=
he category
>> >> >bugs=2E  How about fixing all at once by checking kdamond->contexts=
->nr at the
>> >> >beginning of damon_sysfs_handle_cmd(), like below?
>> >> >
>> >> >--- a/mm/damon/sysfs=2Ec
>> >> >+++ b/mm/damon/sysfs=2Ec
>> >> >@@ -2404,6 +2404,9 @@ static int damon_sysfs_update_schemes_tried_r=
egions(
>> >> > static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
>> >> >                struct damon_sysfs_kdamond *kdamond)
>> >> > {
>> >> >+       if (cmd !=3D DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr !=
=3D 1)
>> >> >+               return -EINVAL;
>> >> >+
>> >> >        switch (cmd) {
>> >> >        case DAMON_SYSFS_CMD_ON:
>> >> >                return damon_sysfs_turn_damon_on(kdamond);
>> >> >
>> >> >If we pick this, Fixes: would be deserve to the oldest buggy commit=
 that
>> >> >introduced the first bug of this category=2E  It is indeed quite ol=
d=2E
>> >> >
>> >> >Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
>> >> >Cc: <stable@vger=2Ekernel=2Eorg> # 5=2E18=2Ex
>> >> >
>> >> >
>> >> >Thanks,
>> >> >SJ
>> >>=20
>> >>=20
>> >>=20
>> >> Hello, did you give Reviewed by you? Or not=2E=2E
>> >
>> >Are you meaning Reviewed-by: tag?  If so, no, not yet=2E  I want to ge=
t your
>> >answer to above question first=2E  Could you please answer?
>> >
>> >
>> >Thanks,
>> >SJ
>> >
>> >[=2E=2E=2E]
>>=20
>>=20
>> Well, two is in the same catagory=2E But seperate fixes may be best=2E =
 Because patch 3 dont call that function, so it may be screwy, i mean, if y=
ou want me to=2E Ill guard it=2E But its a bit on the hacky side
>
>I agree there could be more cleaner way=2E  But these fixes need to go to=
 stable,
>so I'd prefer a change that also easier to backport=2E
>
>So, yes, I want to=2E  Thank you for kindly accepting my suggestion=2E
>
>Could you please re-post this series for the first and the fourth patches=
 as
>they are, after adding my Reviewed-by:, Fixes: and Cc: stable tags, and a=
 patch
>checking kdamond->contexts->nr at the beginning of damon_sysfs_handle_cmd=
() as
>I suggested?
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Absolutely!

Will do

