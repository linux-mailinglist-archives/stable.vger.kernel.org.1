Return-Path: <stable+bounces-233186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIKaLw3Mz2m50gYAu9opvQ
	(envelope-from <stable+bounces-233186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:17:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2072F39517B
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC561302C6E5
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2DA3BC68D;
	Fri,  3 Apr 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lgAuP0Rg"
X-Original-To: stable@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster1-host9-snip4-7.eps.apple.com [57.103.76.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE533A6E9
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225438; cv=none; b=UqzqCgFv8E5wuels3ePlSLCLikWZ5s2QZc9+tx9tulRpRTQB/K84iiJewJ2wzcB2JUyV6hQ6CV/jMh/8aO4MzSzaa6oNkrR1LGktDl2xaGIFSAMMSVCqp+nLNH9K2C0JUgMbWSqIRjdItKTVWeLQ2vwJqcngl4C2l9KJAZZxCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225438; c=relaxed/simple;
	bh=5x1rUE/SR/8IUOFq1NWYYeRZ7EcXQq4O0weSD5h/Gss=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=VPnA1RCLyIm/ha6qlCr8vDW5UVUtmK75W/mPPx4YQAlPAHgbE8a6OiiPkbX6ZbEVCzeb0USspP5G8FXeou0zz6/ZQ5v2thAOWQ4PDZ9ntxXUXU3AsBDoVV7h5mtI3yOpCWxYB/5LctkH7BykFGSjEdTt5pgtrKEUmiCAvvUXXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lgAuP0Rg; arc=none smtp.client-ip=57.103.76.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPS id 80C1D1804660;
	Fri, 03 Apr 2026 14:10:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775225435; x=1777817435; bh=bYl3xgbCnlPDqyPPDRhNg28lS+mPZs/UC9R/WWTC9PE=; h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme; b=lgAuP0RgPgEagdmtENCLTya8Z3EFtKqfUbhW8j7SjNrBwdMnVZS76lLQlWgmA4/O5mMx98yJxjmXOZ4BlJzxutDzNoNQToqXiHDiEQm5Pzj3uSkEnogOJO9CMbq3DStSFeKdP7SsNfdKcm0F+6oHFa8eMUIAIIiH6GhOGPHmxaf3CpnGEoN0nLBxJpXZJ+xXyM+VSMISSh60eelwLrXhtez4Be8peev9SCBQnjEsuHdXIJvMLuNIMnk26bV/kFkFNRYkSNjB/1iKsD/tPIUa/RVy8KHUajyryAzaZ5U/DPbaQojaywxXVaFb7m/hw9bA3uPtEj/xpS0rkuKgVhUFDw==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPSA id 3C41B1804657;
	Fri, 03 Apr 2026 14:09:33 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Vincent Cloutier <vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/1] usb: typec: tipd: Restore generic TPS6598x contract interrupts
Date: Fri, 3 Apr 2026 10:09:21 -0400
Message-Id: <7B01DE2F-5066-499C-A718-435D84F0DE0C@icloud.com>
References: <2374707.tdWV9SEqCh@pliszka>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sven@kernel.org,
 Vincent Cloutier <vincent@cloutier.co>, stable@vger.kernel.org
In-Reply-To: <2374707.tdWV9SEqCh@pliszka>
To: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
X-Mailer: iPhone Mail (23D8133)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyNiBTYWx0ZWRfX1dJWCm1O3FVz
 BwqcF4OIS7EHOBsGXZ89wXo+x/2Lcuh26rEqQ4vdMNJBVS92KtebM548WaNyqAseEzlx4hWvcy0
 gJueo8wmIWl+Y1Q1U1au3Na6CGSSuls4PvJURoGYRtyPq0eUOjX5A7aB+pF27/uX689l7BtdckJ
 EYD70OGf4ZmpH6hObS1swgCTkX7r5h3wXMyW508pIxte2BO2zaPtuhAeDHaFAU7T004XhYPLNyt
 4fiz9e3AZJgKodq2Uo2zN337q/jDPDjVj05xS/Jhp+9MGqdk7WfkmrXyuFDxIjPJFMoWcWL3kNK
 c1sEfF6/pANtWFOtiRLf7iT0n6ApKhe8BBYeDKUx2ebt076x4X4KrNhrkn6BSs=
X-Proofpoint-GUID: FIHvblxWOxKo0eLSlg2DzhKCQQsjMoJo
X-Proofpoint-ORIG-GUID: FIHvblxWOxKo0eLSlg2DzhKCQQsjMoJo
X-Authority-Info-Out: v=2.4 cv=I4lohdgg c=1 sm=1 tr=0 ts=69cfca59
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=rieTZprS84gtqHSEIzoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030126
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-233186-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	APPLE_IOS_MAILER_COMMON(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.cloutier@icloud.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com]
X-Rspamd-Queue-Id: 2072F39517B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> Le 3 avr. 2026 =C3=A0 06:25, Sebastian Krzyszkowiak <sebastian.krzyszkowia=
k@puri.sm> a =C3=A9crit :
>=20
> =EF=BB=BFOn czwartek, 2 kwietnia 2026 02:09:50 czas =C5=9Brodkowoeuropejsk=
i letni Vincent
> Cloutier wrote:
>> From: Vincent Cloutier <vincent@cloutier.co>
>>=20
>> The generic TPS6598x interrupt handler still relies on
>> PP_SWITCH_CHANGED, NEW_CONTRACT_AS_CONSUMER, HARD_RESET, and
>> STATUS_UPDATE, but the irq_mask1 refactor only kept
>> POWER_STATUS_UPDATE, DATA_STATUS_UPDATE, and PLUG_EVENT in
>> tps6598x_data.
>>=20
>> On the librem5 that leaves PD partners stuck at the 500 mA fallback
>> because the active contract is never refreshed after attach.
>>=20
>> Restore the missing interrupt bits so the existing handler paths are
>> reachable again. This fixes USB-C charging negotiation on the librem5:
>> after a replug the TPS6598x source power supply reports 3 A instead of
>> 500 mA and the BQ25890 input limit follows suit.
>>=20
>> Fixes: b3dddff502c5 ("usb: typec: tipd: Move initial irq mask to tipd_dat=
a")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
>> ---
>> drivers/usb/typec/tipd/core.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.=
c
>> index 84ee5687bb27..83f2fec6e34e 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -2395,7 +2395,11 @@ static const struct tipd_data tps6598x_data =3D {
>>    .irq_handler =3D tps6598x_interrupt,
>>    .irq_mask1 =3D TPS_REG_INT_POWER_STATUS_UPDATE |
>>             TPS_REG_INT_DATA_STATUS_UPDATE |
>> -             TPS_REG_INT_PLUG_EVENT,
>> +             TPS_REG_INT_PLUG_EVENT |
>> +             TPS_REG_INT_PP_SWITCH_CHANGED |
>> +             TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER |
>> +             TPS_REG_INT_HARD_RESET |
>> +             TPS_REG_INT_STATUS_UPDATE,
>>    .tps_struct_size =3D sizeof(struct tps6598x),
>>    .register_port =3D tps6598x_register_port,
>>    .unregister_port =3D tps6598x_unregister_port,
>=20
> This driver has never handled these interrupts (as seen in the commit you
> referenced), so these should be added in patches that make it handle them.=

>=20
> You likely got confused by the patches that still stay in the downstream
> Librem 5 tree. We should get them cleaned up and mainlined, but until that=

> happens this patch doesn't make much sense here I'm afraid.
I=E2=80=99m afraid that=E2=80=99s exactly what happened=E2=80=A6 I have lear=
ned a lesson here.=20
>=20
> S.
>=20
>=20
Sorry about this noise and thank you all for your time!

Vincent=

