Return-Path: <stable+bounces-238036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC8OC4wf32kjPAAAu9opvQ
	(envelope-from <stable+bounces-238036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:18:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DF4006D9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC2F630417BD
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65141C71;
	Wed, 15 Apr 2026 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csqYJoeP"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD414AD20
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776230264; cv=none; b=dLrkBZADnBRSNAmeqjAiWO2TDRhZtj97VO+anTh7bFOavaIIFdTv1Yyte4Mdd4NpeY9OHNDJKEU7WGYemOf1mtmpH56TKSGSH5iRryna8bqsuU08bfsWgE9Awoc+KMXZh49KyZ+63FDElvz09ndhNrbpwf8B33duZGR41o9ZdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776230264; c=relaxed/simple;
	bh=aIRxkt8SC/2qifL8ZU5joDZZdZE89aLeXY/QhisBKB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ikO4ZDvMFtW9mJk7tXmPVnZ0JOSJLOedWWlPCJ38jJrXXlEROhlLbyMWoqZKxVS0tQ8vQP/kRkTR/A9c6sUV+sR7jT7m8ocZ+I6ohrQf8Q9tWPLmenr8HKJxp1uFjSzsQOdgjssNAyJXuGaVFZ56d2fLIUf+ldxgU4FvU2KuPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=csqYJoeP; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776230249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SIwtVvysZZrbirPh1XryQmJICXsT8rEQMfslmazm0A=;
	b=csqYJoePiu+5qSL3CEOu/zd1oITBMlre/JDI+pDxzjRJakIblPDh3wXj6eA6S5WWVDcRuv
	vqS9C28O/GPEIVyEcPsmIeBwX9l2YGTMiJ/b/tRT2PqtuJM1mMCVTWCc1V2o4Mi29t7FyQ
	yhBgx7dVEkryE4fQYX0nMGsqwQCGjlE=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 07:17:21 +0200
Message-Id: <DHTH2K84AB7M.2SFGF9CAOOH3N@linux.dev>
Cc: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <error27@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix missing frame length checks
 in OnAuthClient
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Greg KH" <gregkh@linuxfoundation.org>, "Alexandru Hossu"
 <hossu.alexandru@gmail.com>
References: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
 <2026041526-resonate-overpower-e45f@gregkh>
In-Reply-To: <2026041526-resonate-overpower-e45f@gregkh>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238036-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 760DF4006D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 15, 2026 at 6:56 AM CEST, Greg KH wrote:
> On Tue, Apr 14, 2026 at 11:39:59PM +0200, Alexandru Hossu wrote:
>> OnAuthClient() accesses pframe without first verifying that pkt_len is
>> large enough to contain a valid 802.11 management frame header:
>>=20
>> - get_da(pframe) reads bytes 4-9, requiring pkt_len >=3D 10
>> - GetPrivacy(pframe) reads the FC field at bytes 0-1
>>=20
>> Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
>> unsigned subtraction passed to rtw_get_ie() wraps around, causing it
>> to scan well past the end of the buffer.
>>=20
>> Add an early check against WLAN_HDR_A3_LEN before any pframe access,
>> and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
>> offset to guard the seq/status reads and the rtw_get_ie() call.
>>=20
>> Suggested-by: Dan Carpenter <error27@gmail.com>
>> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
>> ---
>> Changes in v2:
>> - Replace incorrect Reported-by tag with Suggested-by: Dan spotted the
>>   missing length check during code review of the heap overflow fix; he
>>   did not file a separate bug report
>> - Add missing version changelog (the initial submission was incorrectly
>>   labeled v2; no v1 was ever sent to the list)
>
> So this is really v3?
>

...

This would actually be v4.
v1: [1]
v2: [2]
v3: [3]
v4: [4]
Best regards,
Luka Gejak

[1]: https://lore.kernel.org/linux-staging/20260413202824.740653-1-hossu.al=
exandru@gmail.com/
[2]: https://lore.kernel.org/linux-staging/20260414100804.871764-1-hossu.al=
exandru@gmail.com/
[3]: https://lore.kernel.org/linux-staging/20260414145350.903996-1-hossu.al=
exandru@gmail.com/
[4]: https://lore.kernel.org/linux-staging/20260414213959.1028301-1-hossu.a=
lexandru@gmail.com/

