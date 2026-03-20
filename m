Return-Path: <stable+bounces-227563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P67LPlovWnL9gIAu9opvQ
	(envelope-from <stable+bounces-227563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:34:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2392DCB6F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78E9A3077AB2
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338E3C73F4;
	Fri, 20 Mar 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="YlBD0JrE"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C33B961D;
	Fri, 20 Mar 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019760; cv=pass; b=tspKSJVFDpaa62QwA1sXNt9y518sHuTb344oZaQ2SaeCXyphka3Q1zRQ5dVY23FGwvUd00P8fZD/5Xrq75mdg+/EACto9SJZmUtBlEnwxxbmSii+wcvRV0BM5MpP9hyfSnxTDxtnK8ODVbXM3DPDlD494is2obCqLHbRNGKJezc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019760; c=relaxed/simple;
	bh=k9QMKRTZCHbMS+5BvOoFr2WFf3TJGGcVMCIhJrYIPzo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=h4deM9OcKd8IBc+QnDrMBn1cKxnbzfzXwDWmTGzvKSFuzLxP8Cbhx16Dcr1ToihD6QYpsr+4P3f9QlQNteoeAKpLjf6aLJs3EdH4bl431HF8eWqGYVRzTYGJBR2Z5uMO7t16jlMlv+iGAvxG1nSzUAtF/7WxOu1YQlywx/Cm8us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=YlBD0JrE; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774019742; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jI0rj2fx+zrHYx7AJcLDpMawOsI9Ht5Bkv4AgQZfVyIHbjXBKwb/Ow77g5FLiojVmWw7EM3HVa/sI/1Ye2z0poWiPNsV8HbDOPmUelvkRjw3QFIbx0U8SH6CEP2k2G2+K2u6j8nz3wg6BsptzHm3FIOfyQ4GN+H8QZpMQ7l3kao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774019742; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WZoIGVlxoqgpVwZ++hA+mPWqVSD5mS9s8EZM+kwCgTs=; 
	b=Rbh6t5u7MzJUSab3rDCaWAzB2ygceu4QcwnaW+O7yzkNFhfISnQY6XqNC0mr/EP2uuj6oQlrRtUgTFXH0J/X0ciLbXr5AWA6XCLlzKgiIvcJkc8v0Atx1w6WgUPjuLvvBwKlNQ2fXa5Z6AqY6XtN/B/OEZnVO/eWNIA0f32h8WM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774019742;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=WZoIGVlxoqgpVwZ++hA+mPWqVSD5mS9s8EZM+kwCgTs=;
	b=YlBD0JrEdze4SqlLpmbsPbnVW3QhDIdBcSuVU+He6U2UnmwPt6B5ODJ2yjDVa3pV
	Ky1/M4bNqzcpb8i12HN+ACiMNzRULLcC4i1NVgkEw7UncwHasw6qvEyIVIbXQIDs/Tp
	9RjSIpYKOH/VrOTn3pwgQ1zecwW3uo8RXcTlVKJY=
Received: by mx.zoho.eu with SMTPS id 1774019740177737.6191439933341;
	Fri, 20 Mar 2026 16:15:40 +0100 (CET)
Date: Fri, 20 Mar 2026 15:14:54 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_mm/damon/sysfs=3A_check_cont?=
 =?US-ASCII?Q?exts-=3Enr_before_clear=5Fschemes=5Ftried=5Fregions?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260320144741.91848-1-sj@kernel.org>
References:  <20260320144741.91848-1-sj@kernel.org>
Message-ID: <C65E16CA-8D81-4B88-96EA-59DB554494A0@objecting.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227563-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.324];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[objecting.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[objecting.org:dkim,objecting.org:email,objecting.org:mid,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE2392DCB6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20 March 2026 14:47:40 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Fri, 20 Mar 2026 07:06:48 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>>=20
>>=20
>> On 20 March 2026 02:13:17 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>> >On Thu, 19 Mar 2026 15:57:40 +0000 Josh Law <objecting@objecting=2Eorg=
> wrote:
>> >
>> >> The CLEAR_SCHEMES_TRIED_REGIONS command accesses contexts_arr[0]
>> >> without verifying nr_contexts >=3D 1, causing a NULL pointer derefer=
ence
>> >> when no context is configured=2E Add the missing check=2E
>> >
>> >Nice catch, thank you!
>> >
>> >Privileged users can trigger this using DAMON sysfs interface=2E  E=2E=
g=2E,
>> >
>> >    # cd /sys/kernel/mm/damon/admin/kdamonds/
>> >    # echo 1 > nr_kdamonds
>> >    # echo clear_schemes_tried_regions > state
>> >    killed
>> >    # dmesg
>> >    [=2E=2E=2E]
>> >    [63541=2E377604] BUG: kernel NULL pointer dereference, address: 00=
00000000000000
>> >    [=2E=2E=2E]
>> >
>> >Privileged users can do anything even worse than this, but they might =
also do
>> >this by a mistake=2E
>> >
>> >So this deserves Fixes: and Cc stable=2E
>> >
>> >>
>> >> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> >> ---
>> >>  mm/damon/sysfs=2Ec | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>
>> >> diff --git a/mm/damon/sysfs=2Ec b/mm/damon/sysfs=2Ec
>> >> index b573b9d60784=2E=2E36ad2e8956c9 100644
>> >> --- a/mm/damon/sysfs=2Ec
>> >> +++ b/mm/damon/sysfs=2Ec
>> >> @@ -1769,6 +1769,8 @@ static int damon_sysfs_handle_cmd(enum damon_s=
ysfs_cmd cmd,
>> >>       case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
>> >>               return damon_sysfs_update_schemes_tried_regions(kdamon=
d, false);
>> >>       case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
>> >> +             if (kdamond->contexts->nr !=3D 1)
>> >> +                     return -EINVAL;
>> >>               return damon_sysfs_schemes_clear_regions(
>> >>                       kdamond->contexts->contexts_arr[0]->schemes);
>> >>       case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
>> >> --
>> >> 2=2E34=2E1
>> >
>> >So this patch looks good as an individual fix for the individual bug, =
but=2E=2E=2E
>> >
>> >Sashiko commented=2E
>> >
>> ># review url: https://sashiko=2Edev/#/patchset/20260319155742=2E186627=
-3-objecting@objecting=2Eorg
>> >
>> >: Does this missing check also affect other manual commands?
>> >:
>> >: If a user writes UPDATE_SCHEMES_STATS, UPDATE_SCHEMES_EFFECTIVE_QUOT=
AS,
>> >: or UPDATE_TUNED_INTERVALS to the state file after setting nr_context=
s
>> >: to 0, damon_sysfs_handle_cmd() queues the corresponding callback via
>> >: damon_sysfs_damon_call()=2E
>> >:
>> >: When the kdamond thread executes the callback, it appears functions =
like
>> >: damon_sysfs_upd_schemes_stats() access contexts_arr[0] without verif=
ying
>> >: contexts->nr:
>> >:
>> >: static int damon_sysfs_upd_schemes_stats(void *data)
>> >: {
>> >:         struct damon_sysfs_kdamond *kdamond =3D data;
>> >:         struct damon_ctx *ctx =3D kdamond->damon_ctx;
>> >:
>> >:         damon_sysfs_schemes_update_stats(
>> >:                         kdamond->contexts->contexts_arr[0]->schemes,=
 ctx);
>> >:         return 0;
>> >: }
>> >:
>> >: Could this result in a similar NULL pointer dereference if these com=
mands
>> >: are triggered while no context is configured?
>> >
>> >Sashiko is correct=2E  Privileged users can trigger the issues like be=
low=2E
>> >
>> ># damo start
>> ># cd /sys/kernel/mm/damon/admin/kdamonds/0
>> ># echo 0 > contexts/nr_contexts
>> ># echo update_schemes_stats > state
>> ># echo update_schemes_effective_quotas > state
>> ># echo update_tuned_intervals > state
>> >
>> >Not necessarily blocker of this patch, but seems all the issues are in=
 a same
>> >category=2E  The third patch of this series is also fixing one of the =
category
>> >bugs=2E  How about fixing all at once by checking kdamond->contexts->n=
r at the
>> >beginning of damon_sysfs_handle_cmd(), like below?
>> >
>> >--- a/mm/damon/sysfs=2Ec
>> >+++ b/mm/damon/sysfs=2Ec
>> >@@ -2404,6 +2404,9 @@ static int damon_sysfs_update_schemes_tried_regi=
ons(
>> > static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
>> >                struct damon_sysfs_kdamond *kdamond)
>> > {
>> >+       if (cmd !=3D DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr !=3D=
 1)
>> >+               return -EINVAL;
>> >+
>> >        switch (cmd) {
>> >        case DAMON_SYSFS_CMD_ON:
>> >                return damon_sysfs_turn_damon_on(kdamond);
>> >
>> >If we pick this, Fixes: would be deserve to the oldest buggy commit th=
at
>> >introduced the first bug of this category=2E  It is indeed quite old=
=2E
>> >
>> >Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
>> >Cc: <stable@vger=2Ekernel=2Eorg> # 5=2E18=2Ex
>> >
>> >
>> >Thanks,
>> >SJ
>>=20
>>=20
>>=20
>> Hello, did you give Reviewed by you? Or not=2E=2E
>
>Are you meaning Reviewed-by: tag?  If so, no, not yet=2E  I want to get y=
our
>answer to above question first=2E  Could you please answer?
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Well, two is in the same catagory=2E But seperate fixes may be best=2E  Be=
cause patch 3 dont call that function, so it may be screwy, i mean, if you =
want me to=2E Ill guard it=2E But its a bit on the hacky side


V/R


Josh Law

