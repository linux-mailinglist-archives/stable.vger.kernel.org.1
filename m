Return-Path: <stable+bounces-238344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D2hBEUi4WnMpQAAu9opvQ
	(envelope-from <stable+bounces-238344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:54:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1A44135A5
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 738D13121F4E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B54F32ABCA;
	Thu, 16 Apr 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sUQK5ehv"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81D31A555
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776361477; cv=none; b=LrTS+Tv613wqoM+tJt3Fq/3hJRohYXt7RWTVT1Xz2n+NXHd6Qr6MQFoVd/gdhes0ViLF3P0L+dPx4PnC2nanEnU1dLFmPgdSnZaOS0uXEq05ByWb3vMe8aexsEGD2+ne3Cnr0N3zE1GZT5pd5VLXCElBQziac1I4/v21cHkU+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776361477; c=relaxed/simple;
	bh=SWuw0eG2JOjKpsGngqwJ0c15UzERWanRjp1kWwCFahI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=eGf6aIJjKiIi7IOGa15lPq2wzrh4WHElikRW4Jm9T4wK0HfWHkVuptMMF0Hiez6fiay28+Gbog09oZqcJVfVedMDbt5txvD5tEDXqFYcBRIsHW8JeuszjcumVhBscANIR0MIHmJcRaXz5hsqEyy/+mySakDgAS8WRWEGYM3PN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sUQK5ehv; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776361462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qizb2F5vN36WPUlaslzzdAVL3LZczeImG7CihO0DPog=;
	b=sUQK5ehvhbruq35/i+0ms7PQ7eBjy73yctEuB5Qka+NjzCpdO0m6qjBpEFi8yvOAyUgL7L
	bak2o+ygd6oTeNDmOw69F7RcRD5GIf3hxXYu76Se4nwWIFKBH5OZhdKYmDMcJxnfExJC1X
	XdhEEZk5dd8ZEdQCoy3qqX5a2gtEfUQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 19:44:18 +0200
Message-Id: <DHURL0DKUG4Z.LZ67XR7C6Y8A@linux.dev>
To: "Dan Carpenter" <error27@gmail.com>, "Delene Tchio Romuald"
 <delenetchior1@gmail.com>
Cc: <gregkh@linuxfoundation.org>, <dan.carpenter@linaro.org>,
 <luka.gejak@linux.dev>, <hansg@kernel.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] staging: rtl8723bs: fix out-of-bounds read in
 portctrl()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
 <20260415185501.440492-4-delenetchior1@gmail.com>
 <aeEP9qSuokAzDa5r@stanley.mountain>
In-Reply-To: <aeEP9qSuokAzDa5r@stanley.mountain>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238344-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E1A44135A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Apr 16, 2026 at 6:36 PM CEST, Dan Carpenter wrote:
> On Wed, Apr 15, 2026 at 07:54:59PM +0100, Delene Tchio Romuald wrote:
>> In portctrl(), when 802.1X port control is enabled and a non-EAPOL
>> frame is received, the ether_type is read from the LLC header
>> without verifying that the frame actually contains enough bytes to
>> hold the MAC header, IV and the LLC header plus two bytes of
>> ether_type. For sufficiently short frames, the memcpy() that loads
>> be_tmp reads past the end of the receive buffer.
>>=20
>> An attacker within WiFi radio range can exploit this by sending a
>> crafted short frame. No authentication is required.
>>=20
>> Validate the frame length before dereferencing the LLC header; drop
>> the frame if it is too short.
>>=20
>> Found by reviewing length validation in the receive path.
>> Not tested on hardware.
>>=20
>> Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
>> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
>> ---
>> v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
>>     Reviewed-by.
>> v3: rebased on staging-next; sent as numbered series with proper
>>     Cc from get_maintainer.pl.
>> v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
>>     apply).
>>=20
>>  drivers/staging/rtl8723bs/core/rtw_recv.c | 28 +++++++++++++++--------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging=
/rtl8723bs/core/rtw_recv.c
>> index 00b69571bbb83..c0a1c2ab710ee 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
>> @@ -539,17 +539,25 @@ static union recv_frame *portctrl(struct adapter *=
adapter, union recv_frame *pre
>> =20
>>  			prtnframe =3D precv_frame;
>> =20
>> -			/* get ether_type */
>> -			ptr =3D ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEAD=
ER_LENGTH;
>> -			memcpy(&be_tmp, ptr, 2);
>> -			ether_type =3D ntohs(be_tmp);
>> -
>> -			if (ether_type =3D=3D eapol_type)
>> -				prtnframe =3D precv_frame;
>> -			else {
>> -				/* free this frame */
>> -				rtw_free_recvframe(precv_frame, &adapter->recvpriv.free_recv_queue)=
;
>> +			/* Ensure frame has LLC header and ether_type */
>> +			if (pfhdr->len < pattrib->hdrlen +
>> +			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
>> +				rtw_free_recvframe(precv_frame,
>> +						   &adapter->recvpriv.free_recv_queue);
>>  				prtnframe =3D NULL;
>
> I feel like it's sort of weird to write this as a pfhdr->len < condition.
> I feel like the untrusted part of the condition is the pattrib->hdrlen
> stuff and normally you would put the untrusted parts on the left.  I
> kind of see what you're saying that the packet is too small, but to me
> I see it as the hdrlen is too big...  But, also since you found the bug
> then you get to choose the style on this, so do which ever way you feel
> is best.
>
> It would be better if instead of setting "prtnframe =3D NULL;" here,
> you just did "return NULL;" instead.  You've followed the pattern of
> the existing code, but the rule is that if the function has a 100 lines
> of bad style code, you should add 1 line of good style even if it's
> inconsistent.
Hi Dan,
I wasn't aware of that. I thought in such cases you should follow the=20
pattern of existing code. I will make sure to note that in future=20
reviews.
Best regards,
Luka Gejak
>
> It makes the code slightly better and it makes the diff a lot smaller
> and clearer.
>
> regards,
> dan carpenter
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/=
rtl8723bs/core/rtw_recv.c
> index f78194d508df..9cedca1bd83a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -531,6 +531,13 @@ static union recv_frame *portctrl(struct adapter *ad=
apter, union recv_frame *pre
>  			/* only accept EAPOL frame */
> =20
>  			prtnframe =3D precv_frame;
> +			/* Ensure frame has LLC header and ether_type */
> +			if (pfhdr->len < pattrib->hdrlen +
> +			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
> +				rtw_free_recvframe(precv_frame,
> +						   &adapter->recvpriv.free_recv_queue);
> +				return NULL;
> +			}
> =20
>  			/* get ether_type */
>  			ptr =3D ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADE=
R_LENGTH;


