Return-Path: <stable+bounces-230511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HRZMN91xWnw+QQAu9opvQ
	(envelope-from <stable+bounces-230511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:07:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2420339CBA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB96D30069AE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEC38F937;
	Thu, 26 Mar 2026 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="SUMA6XgJ"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998D31F989;
	Thu, 26 Mar 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548440; cv=pass; b=s8EUtO+RMGsB1fFN5t7zka0pw5/+ViS0JntY5QvTmwUZjkt1DQejYYfFgxJmb5Zse5B6hoLiNQATXDwzrSgwat2/VoJpxrdgUUPKef8VHvIsfJdMGHgN69oNsBeM7cmhQvtuh8j2432f4l+5DLeMVzc1lRRhIRipcA66T+zZrIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548440; c=relaxed/simple;
	bh=2x1+SdgpxNjXCigvgJHKja+fB9xjaP55bNlSq3tDwPY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DZkKuZR1CeESHARdtTeiqMYQw0FkqDmYm8h7cJ4bNbdrCheQm8a++gst5ye+lgQC/DbtVwbeFKrzM7IsyzHC9bf9oBYSzFqvOLD3N0PzD9G6qOzGyzIdtymZvvyKjHaEGBD7i0IHHHqLfLsYyfACkimkWFu6rINJuh8CaXxbRWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=SUMA6XgJ; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774548410; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=U/uLpVZEKQNNBsME7yGBCZ2mKzZ6h4dyg8CkeG6/uAypJUlZqgBkUOXiL2mNEtfqFmt7tUB9oIzwSTBBYxkPJP4o/l1bZabKUyqnDw5PUXD4+Ekg8YX17fFBQvqP4HFhh7AWmrNxpu3rx0cJXQZXTfeGFwWbHAJlHSJngK7sS5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774548410; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vwrm8PEEy1aKDNPxb3hXrJu7/P378ETeXKwGdcxqBTk=; 
	b=d5Be7Z29xPJY+e0vXrxMGh64rnkj+x0TwSgXg0H+JDz5M+C8rN4S8/EZVU0nBqt5Kni9nkCWJ5qH4QvYLhdOLHAiU5JMfWvmkykQ4y2uxjtXLAyvhLV3gVwydF9crWJxH2mv6hdDtv0e8MlJjFkBDyCjy/1Vltyym4eUOLYaGj0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774548410;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=vwrm8PEEy1aKDNPxb3hXrJu7/P378ETeXKwGdcxqBTk=;
	b=SUMA6XgJgSPiVG/zKCrurlSSaiBCHZqiK3ucjsbEuNQouxwzM8hUwnJ/fYADARIr
	HIWrd83JKBEtEBpDbEAovayR9bVa6nuFReAqJaXs+9IxOdqBFf2t96L4KrKgI3EVOSw
	aDAhjwaciW29DLy019GaCpgnU2b9Wh0rdLSgF1bw=
Received: by mx.zoho.eu with SMTPS id 1774548407941403.5931674003357;
	Thu, 26 Mar 2026 19:06:47 +0100 (CET)
Date: Thu, 26 Mar 2026 18:06:48 +0000
From: Josh Law <objecting@objecting.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Josh Law <hlcj1234567@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
CC: Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_lib/maple=5Ftree=3A_fix_swa?=
 =?US-ASCII?Q?pped_arguments_in_mas=5Fsafe=5Fpivot=28=29_call?=
User-Agent: Thunderbird for Android
In-Reply-To: <cfbe0037-00a0-4837-9a70-575010c201de@kernel.org>
References: <20260306225849.2824409-1-objecting@objecting.org> <cfbe0037-00a0-4837-9a70-575010c201de@kernel.org>
Message-ID: <12F58DE3-FB62-4548-A736-B49734111FD5@objecting.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230511-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,linux-foundation.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,oracle.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[objecting.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,objecting.org:dkim,objecting.org:email,objecting.org:mid,linux-foundation.org:email]
X-Rspamd-Queue-Id: D2420339CBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26 March 2026 18:02:35 GMT, "Vlastimil Babka (SUSE)" <vbabka@kernel=2Eo=
rg> wrote:
>On 3/6/26 23:58, Josh Law wrote:
>> From: Josh Law <objecting@objecting=2Eorg>
>>=20
>> The call to mas_safe_pivot() in mas_wr_extend_null() has the pivot inde=
x
>
>The function is actually mas_extend_spanning_null() ?
>
>> and maple type arguments swapped=2E The function signature expects
>> (mas, pivots, piv, type) but the call passes (mas, pivots, type, piv)=
=2E
>>=20
>> This causes the pivot index to be interpreted as a maple node type and
>> vice versa, leading to incorrect pivot lookups=2E In practice, this mea=
ns
>> a null-extending store into a maple tree node can read the wrong pivot
>> value, potentially corrupting the range tracked by the maple state=2E F=
or
>> a VMA maple tree, this could cause an incorrect vm_area_struct range to
>> be returned during operations like mmap or munmap, leading to silent
>> memory mapping corruption=2E
>>=20
>> Every other mas_safe_pivot() call site in the file passes the arguments
>> in the correct (piv, type) order; this is the only one with them
>> reversed=2E
>>=20
>> Link: https://lkml=2Ekernel=2Eorg/r/20260306200820=2E2819999-1-objectin=
g@objecting=2Eorg
>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> Cc: stable@vger=2Ekernel=2Eorg
>> Cc: Alice Ryhl <aliceryhl@google=2Ecom>
>> Cc: Andrew Ballance <andrewjballance@gmail=2Ecom>
>> Cc: Liam Howlett <liam=2Ehowlett@oracle=2Ecom>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation=2Eorg>
>
>I'm not a maple tree expert but this looks obviously correct enough=2E So=
 I
>won't speculate on the impact of this bug, but:
>
>Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel=2Eorg>
>
>I guess since it's old and not in mm-hotfixes, we can afford to wait for
>Liam who should be back before the merge window=2E I'm not sure how to
>handle the fact that this patch has been withdrawn [1] however=2E
>
>[1] https://lore=2Ekernel=2Eorg/all/E1A667AB-DCE4-4034-A36B-DAA458780A81@=
objecting=2Eorg/
>
>> ---
>> Changes in v3:
>> - Included a changelog detailing modifications since v1=2E
>>=20
>> Changes in v2:
>> - Added Link, Fixes, and Cc tags (including stable@vger=2Ekernel=2Eorg)=
 to the commit message=2E
>> - Appended Andrew Morton's Signed-off-by to expedite merging=2E
>
>No!
>
>>=20
>>  lib/maple_tree=2Ec | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/lib/maple_tree=2Ec b/lib/maple_tree=2Ec
>> index 5aa4c9500018=2E=2Ef82000821293 100644
>> --- a/lib/maple_tree=2Ec
>> +++ b/lib/maple_tree=2Ec
>> @@ -3279,7 +3279,7 @@ static inline void mas_extend_spanning_null(struc=
t ma_wr_state *l_wr_mas,
>>  	    (r_mas->last < r_mas->max) &&
>>  	    !mas_slot_locked(r_mas, r_wr_mas->slots, r_mas->offset + 1)) {
>>  		r_mas->last =3D mas_safe_pivot(r_mas, r_wr_mas->pivots,
>> -					     r_wr_mas->type, r_mas->offset + 1);
>> +					     r_mas->offset + 1, r_wr_mas->type);
>>  		r_mas->offset++;
>>  	}
>>  }
>


Hi, this patch isn't pending!

I may come back to lib/ earlier, I'm just refining my workflow to be bette=
r, and to be honest!


Also, thanks for the ack


V/R


Josh Law

