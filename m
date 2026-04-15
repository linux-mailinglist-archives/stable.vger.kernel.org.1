Return-Path: <stable+bounces-238096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOSTJMtu32nqSwAAu9opvQ
	(envelope-from <stable+bounces-238096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:56:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBEB403727
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57A3E3046F05
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7FA33FE1F;
	Wed, 15 Apr 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gEwwa1xK"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21F54774
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250566; cv=none; b=V9dzyh1kMQbKv7DV4wBJywOMX5+XzyowfAjjeDYYFaDW6ko/qwEe/2SkzgnY9AQlg+ivmM7+MYsfuTgIOEHGa0ZstpwfMh+CyYeDuJRU4ZIM9ledreS82z8KvBJfuiVreIN7EZpgPO7uFB3AYotZ7OFQ51oGevLBSDv/z+4y2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250566; c=relaxed/simple;
	bh=6ZA2LcSk3QReERFIlOsuFJ0xn3JrVBgbFbT8X+w75Cs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dnLPrxPfFXw8sc6XMof5YXc2VuKYiMtl/dmpht1uj7EisIdwaOzY0bUzJN6JOcxvdc+YtJPnAYPAyGttAvb+PdnhAGBLzfqLr3f6o4sTzDCMePK4vZ3Iliv2xQrK/f/cOUmMhVNoC/iH3Uh97bUf+I7vMeWZTV6KA37e9jgcYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gEwwa1xK; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776250553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPLefkgOLZaU5Vrj9t+NYCjOZkZjnCgC8OJdP8PSA+g=;
	b=gEwwa1xK1kon4vxC10jYEPEeFqdMQWcmBsUu9dDf5j4+GADPqZYaBNmySRvAwPTcMWM3LQ
	/rLMxbYWWjAKbIpX4gFh0jD9YkPzo8TW+jxN4B9DsCEtSEW6XEgHtoMWQAUjDK4aZtGwGM
	JbicM5Ayy221JgxwxFjJYAZWCW7Dxr4=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 12:55:48 +0200
Message-Id: <DHTO9P2GULIP.2VT8AWTTKPL8W@linux.dev>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix remote heap information
 disclosure in issue_assocreq
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Dan Carpenter" <error27@gmail.com>, <luka.gejak@linux.dev>
References: <20260415050302.9934-1-luka.gejak@linux.dev>
 <ad9TKjTLxDRwDyIy@stanley.mountain>
In-Reply-To: <ad9TKjTLxDRwDyIy@stanley.mountain>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238096-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 6DBEB403727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 15, 2026 at 10:58 AM CEST, Dan Carpenter wrote:
> On Wed, Apr 15, 2026 at 07:03:02AM +0200, luka.gejak@linux.dev wrote:
>> From: Luka Gejak <luka.gejak@linux.dev>
>>=20
>> When building an association request frame, the driver copies the
>> ht capability ie using the attacker-controlled pIE->length from the
>> ap's beacon. If the ap provides a length greater than the size of
>> struct HT_caps_element (26 bytes), it causes an out-of-bounds read
>> of the adjacent heap memory (HT_info and network structures).
>> This uninitialized or sensitive memory is then transmitted over the air,
>> resulting in a remote heap information disclosure.
>>=20
>> Fix this by clamping the length passed to rtw_set_ie() to the actual
>> size of struct HT_caps_element.
>>=20
>> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
>> ---
>> ---
>> Changes in v2:
>> - Refactored rtw_set_ie() alignment to follow "open parenthesis" style.
>> - Allowed the line length to exceed 100 characters for better readabilit=
y as requested by Greg KH.
>>=20
>>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/sta=
ging/rtl8723bs/core/rtw_mlme_ext.c
>> index 5f00fe282d1b..08e597bc0345 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>> @@ -2954,7 +2954,9 @@ void issue_assocreq(struct adapter *padapter)
>>  			if (padapter->mlmepriv.htpriv.ht_option) {
>>  				if (!(is_ap_in_tkip(padapter))) {
>>  					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_ele=
ment));
>> -					pframe =3D rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->length,=
 (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
>> +					pframe =3D rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY,
>> +							    min_t(uint, pIE->length, sizeof(struct HT_caps_element)),
>> +							    (u8 *)&pmlmeinfo->HT_caps, &pattrib->pktlen);
>
> You're being conservative and trying to work around the invalid
> pIE->length, but in the case where the original code corrupts memory,
> we're allow to just give up and return a failure.
>
> There are two other cases where we trust pIE->length in this function
> and those need to be fixed as well.
>
> regards,
> dan carpenter

Hi Dan,
should I keep my approach as is or just return failure. I will fix other=20
cases as well with whatever approach you consider correct.
Best regards,
Luka Gejak

