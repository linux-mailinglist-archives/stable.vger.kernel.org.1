Return-Path: <stable+bounces-227442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VGaWBi7yvGmD4wIAu9opvQ
	(envelope-from <stable+bounces-227442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:07:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7693F2D66B8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6629D3075951
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D17358363;
	Fri, 20 Mar 2026 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="NOt+Fn1o"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150E355F56;
	Fri, 20 Mar 2026 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990442; cv=pass; b=lAiL+aGFJh39cDtpxnSYlKITRn7BOfJP4KU4WU8tQ/TodjFOFRVa6JQruOp1v7xhnMTqw6MCvAEvLYovpHofuT8S0ters8WiQK5VcLVJOcAmrBU66tRgOVKppkjftD86I1tYrXNkGkcKrAlllhq4upfrWE3fiGiZZO3l2ZsnhEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990442; c=relaxed/simple;
	bh=Y2/1U6ee1g2tI+ylgxSX4ipvzpcTSO0ejo/jam+TzfI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=d8wWt9TpFB4uF7LiE4wW8dBYctnRNIRqQc+Gy2OS3s/zRE9uYLxP8ukBr0Jv1ZD17nS/IIqK64e7GWWo6Th3jjdEVSnh0JYrFWixqT0NvI05tzKPSJfBkpYS0JYInh8pdeO9el0PJbKEzZRm89Vug+1EISdfJBzMHoP8NVDxZ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=NOt+Fn1o; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1773990410; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=k5CguAlxOCS5xMApFoTv9ZuoSWHIB+mQjjSdXJIZ1gd55C3xW8Y0QVjukOmN/Ee4tWKV1aWCHfFMhDFdLF8JGWeQN8F1N4WmmjE6830Upv33kPQuVhhGqVXjW6Vh1g9NdzrfwFB+hpRSJ/xJo7Tk8Ea8aS4/uRzV+jPDHxrLY8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773990410; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z8oK5RCe9uCIwAhJ1Bo5VEmx8tjlc5XR8v7u8F6fzXM=; 
	b=hmrmdKrFf1z4EBOrKhyNvWubCIeqLqhyyRGhK0/fZ5fjHii6weFmUzg4tMkq9M/RUALNCm+C4NvGPvZBumVqePXQXleOsvF1ZAwWjXkicCiv5/vgo9yPD9CMbTC9FvvpVeuFQTQ9wl9yua53MHaGtdlNxdfVX4efVRI3zpxIb90=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773990410;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Z8oK5RCe9uCIwAhJ1Bo5VEmx8tjlc5XR8v7u8F6fzXM=;
	b=NOt+Fn1oBhfhfW0ws0Q/WT60QDumBxumtZ5mJgAmUPXFd+jl3VYpDLB7E43xA9A5
	PHVwB8tL6XM4pmT2uV19RFRay6orZV9X3dZlmh/Y+eJx4pxLaZ9V1NN4rMQRktHj24R
	wWO2XkAGYi+nFigDnR87WEKdyGUUNW58QU69MbSw=
Received: by mx.zoho.eu with SMTPS id 1773990408143822.1742080429242;
	Fri, 20 Mar 2026 08:06:48 +0100 (CET)
Date: Fri, 20 Mar 2026 07:06:48 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_mm/damon/sysfs=3A_check_cont?=
 =?US-ASCII?Q?exts-=3Enr_before_clear=5Fschemes=5Ftried=5Fregions?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260320021318.1117-1-sj@kernel.org>
References:  <20260320021318.1117-1-sj@kernel.org>
Message-ID: <8F30B2A1-240C-43D3-B756-20E327F5BCF3@objecting.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227442-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.309];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[objecting.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 7693F2D66B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20 March 2026 02:13:17 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Thu, 19 Mar 2026 15:57:40 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>> The CLEAR_SCHEMES_TRIED_REGIONS command accesses contexts_arr[0]
>> without verifying nr_contexts >=3D 1, causing a NULL pointer dereferenc=
e
>> when no context is configured=2E Add the missing check=2E
>
>Nice catch, thank you!
>
>Privileged users can trigger this using DAMON sysfs interface=2E  E=2Eg=
=2E,
>
>    # cd /sys/kernel/mm/damon/admin/kdamonds/
>    # echo 1 > nr_kdamonds
>    # echo clear_schemes_tried_regions > state
>    killed
>    # dmesg
>    [=2E=2E=2E]
>    [63541=2E377604] BUG: kernel NULL pointer dereference, address: 00000=
00000000000
>    [=2E=2E=2E]
>
>Privileged users can do anything even worse than this, but they might als=
o do
>this by a mistake=2E
>
>So this deserves Fixes: and Cc stable=2E
>
>>
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> ---
>>  mm/damon/sysfs=2Ec | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/damon/sysfs=2Ec b/mm/damon/sysfs=2Ec
>> index b573b9d60784=2E=2E36ad2e8956c9 100644
>> --- a/mm/damon/sysfs=2Ec
>> +++ b/mm/damon/sysfs=2Ec
>> @@ -1769,6 +1769,8 @@ static int damon_sysfs_handle_cmd(enum damon_sysf=
s_cmd cmd,
>>       case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
>>               return damon_sysfs_update_schemes_tried_regions(kdamond, =
false);
>>       case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
>> +             if (kdamond->contexts->nr !=3D 1)
>> +                     return -EINVAL;
>>               return damon_sysfs_schemes_clear_regions(
>>                       kdamond->contexts->contexts_arr[0]->schemes);
>>       case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
>> --
>> 2=2E34=2E1
>
>So this patch looks good as an individual fix for the individual bug, but=
=2E=2E=2E
>
>Sashiko commented=2E
>
># review url: https://sashiko=2Edev/#/patchset/20260319155742=2E186627-3-=
objecting@objecting=2Eorg
>
>: Does this missing check also affect other manual commands?
>:
>: If a user writes UPDATE_SCHEMES_STATS, UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
>: or UPDATE_TUNED_INTERVALS to the state file after setting nr_contexts
>: to 0, damon_sysfs_handle_cmd() queues the corresponding callback via
>: damon_sysfs_damon_call()=2E
>:
>: When the kdamond thread executes the callback, it appears functions lik=
e
>: damon_sysfs_upd_schemes_stats() access contexts_arr[0] without verifyin=
g
>: contexts->nr:
>:
>: static int damon_sysfs_upd_schemes_stats(void *data)
>: {
>:         struct damon_sysfs_kdamond *kdamond =3D data;
>:         struct damon_ctx *ctx =3D kdamond->damon_ctx;
>:
>:         damon_sysfs_schemes_update_stats(
>:                         kdamond->contexts->contexts_arr[0]->schemes, ct=
x);
>:         return 0;
>: }
>:
>: Could this result in a similar NULL pointer dereference if these comman=
ds
>: are triggered while no context is configured?
>
>Sashiko is correct=2E  Privileged users can trigger the issues like below=
=2E
>
># damo start
># cd /sys/kernel/mm/damon/admin/kdamonds/0
># echo 0 > contexts/nr_contexts
># echo update_schemes_stats > state
># echo update_schemes_effective_quotas > state
># echo update_tuned_intervals > state
>
>Not necessarily blocker of this patch, but seems all the issues are in a =
same
>category=2E  The third patch of this series is also fixing one of the cat=
egory
>bugs=2E  How about fixing all at once by checking kdamond->contexts->nr a=
t the
>beginning of damon_sysfs_handle_cmd(), like below?
>
>--- a/mm/damon/sysfs=2Ec
>+++ b/mm/damon/sysfs=2Ec
>@@ -2404,6 +2404,9 @@ static int damon_sysfs_update_schemes_tried_regions=
(
> static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
>                struct damon_sysfs_kdamond *kdamond)
> {
>+       if (cmd !=3D DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr !=3D 1)
>+               return -EINVAL;
>+
>        switch (cmd) {
>        case DAMON_SYSFS_CMD_ON:
>                return damon_sysfs_turn_damon_on(kdamond);
>
>If we pick this, Fixes: would be deserve to the oldest buggy commit that
>introduced the first bug of this category=2E  It is indeed quite old=2E
>
>Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
>Cc: <stable@vger=2Ekernel=2Eorg> # 5=2E18=2Ex
>
>
>Thanks,
>SJ



Hello, did you give Reviewed by you? Or not=2E=2E

V/R


Josh Law

