Return-Path: <stable+bounces-111957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB5A24D47
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 10:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0773A2957
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C81C3BEA;
	Sun,  2 Feb 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="AWic2DSP"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97FC8DF
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738488384; cv=none; b=I+net5guTUOSiZSfk0ta+erLc+y8HcSQAcVi2bKoJ3GpLS+LTXvz/qpzsXUco+pLeaeAyaBgCuvxVkysiOfUQid7CDmdjRtEDgZtIE33T2AEKN7roDV78ktIHE4qH8drE5Fw1XjCz72C9hAdYXxnHCl7Unea2IQbYEAWBo5EHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738488384; c=relaxed/simple;
	bh=NmrvxdzU+MQV4GnadywgkZ32wh2zvHFYd+mUzrkc+84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ1FVs8VKgbnOiKbajrAk4UVySkvdzWQT2XPF35LColNzHVo748Lg/3c5nKPIJcHsAtLJIq6AanAf4W1cAnyKT4uSBaR94MZVE23IKwu3wQwvqprA9RSt5H8+7+dhfxtxLGJKCeU5ORXUcx826EG/l7VjQm42O8Bgmd4/OWW6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=AWic2DSP; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1738488372; x=1739093172; i=christian@heusel.eu;
	bh=NmrvxdzU+MQV4GnadywgkZ32wh2zvHFYd+mUzrkc+84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AWic2DSPfCmZybiGsEtE6xQsfqI2m1i1GNf9Da89Dfd49OVijry0cMd/l3fMnktf
	 x0bpdwUUwtB/0wzguQkkNPTUUUBe7+HvdFkXy59PbTbqnxZX0b6TBzeH8bjwlT0Qc
	 PpH/sC3WyT59tmsTLODVi2dky/UmIBD7cKhG/BxS1BaxHNkOym6bGC8qFRJo+enpb
	 hwHEeQvurnMSgPV7OvwxJ6l+JOZlxZfbFDtbRVYc/bHxDrz560dcNfAqVbDiR3tRo
	 lWYNCwIsIQUXy8FjYY4ksL5ZYrtXoQ2DCywOCsb8yNDB2OpFM+cwfK4FBPj0XI1zv
	 +PTWT/Z2kq1KyiezXw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([85.201.80.150]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3bb1-1tV4A301ad-011GSW; Sun, 02 Feb 2025 10:26:12 +0100
Date: Sun, 2 Feb 2025 10:26:11 +0100
From: Christian Heusel <christian@heusel.eu>
To: "Ahmed, Shehab Sarar" <shehaba2@illinois.edu>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: TCP Fast Retransmission Issue
Message-ID: <f86dd0f6-6a2e-40f3-b0be-d9816ccb20cc@heusel.eu>
References: <DS0PR11MB77682EBD149E7965F1D8E8F1FDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
 <DS0PR11MB7768A5B80C9BF2366CFEC89BFDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="25a2463gtnrp5jed"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7768A5B80C9BF2366CFEC89BFDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
X-Provags-ID: V03:K1:D3e9cmTh4XJIz1ugBU7wH8ciOobQIUwoXw7KdGrxSSskSiBf3h7
 teEIvbNy3bGFMr1xYjrzvZat393ZKIucSPjUP48GBw+MsB90cngEFPDKitDfZ2WiKZbT7oD
 t+vM+Gkoc1gg1wYE0793xbTSTEkC0G7U5b6YZrXKHekGTjkMg9t3/54D7LCrOGb6POXpL3S
 4J2yBIZRYLWmm0JoiAD1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IIIaJSILXZk=;g3lkRFMqUBRVwNE/LtSapNC1+zO
 Vx70IcjCD1/EZU47cXNjPFB/J0XmQd32KoRIWuGIxfNWrp2z0xxy7akqrz4Oes2M3clRYRLDo
 9evoDbrQlpcXf9sCGuHylE0gbESEvvwTO2u4tqeSSyFA4MrKJjyn3fsYD4HHSnkbJvXuFI/Fk
 giWSeLf0ezVCx4Zvn6ryK7EmanMg3VG0B3ZqjCOyiB/l1maiwkQ/CTgG5P6eZE0H7AUtlDoB1
 0kUCZb9LnCYDfHUioRVSJklqLZftvYcR4iaUZTVfJbfSzNOmYH44C28FY064FIDhdBJEPisNS
 BsJ43WFljh1e1Pd617HzP37jJdGhsAEAdLHdF8nI2Nd/GhbL3+dNVETuYoFpxC/DxpkkPLlEA
 dhC6GwbbCRTm6xfvWlSpu01KGDy74Jgv7GO7hYYs8DA3VBzOSY6W+Na74o8huEN9ayYxcsfZm
 hKSjU1q+5hbyVarVaPQ7HvdhhJGbHiX+fXCOwi1ppm0W0BTbX+RQKzpxpu3C8zwdgoY97T3hi
 UHGTKeNP+RqBkOCYA3XoHykVj1DgWR0jyYWcaR5wO+IAacZJUanBeArWxYh5+UJW68SkiF++f
 nqzjbXllDwM/v1tB5l1b5Y5fmTny/HUaKi9mBZ89ZeYD30Mv4qFS9dPDMTwjnMMjkO1aPjHKV
 0lnHPJkpmtS09gmQs3x66JV1f1iW4B7yQBg4tf7KW+cZPj4vzSg0lDlTKO57+aPTr9LIW3FSC
 HexapMvpxCgFSfcXFujcR3mLOgf9qY7RlTi3V6ZqhUBftRqJnz9Ax1l6z7JuAq5j/nrlI9tWt
 zl+NyfnZMw+8Jlb6kFjyGQXyX6qytewE/S7LTxbfhft5z7FAXlTqAxCx8et/NZnXvG+GmjHto
 HuLpBHqY8cXFAyubjIcPSQv/CU65V8/FmQiSIpDneGJ2SSI58OtYOlin8jue2ahcvPB76xier
 Lq5A8greu8LaKizmQsPp3LwXlc2vTcEDQwUwmeWcNf4VOqsZN/O/LghJ2fdXWX1POr2rgpVdm
 OmLoL3uRfwzZ3YEFdQIh3JS2bj21crBVTwlyFupAN+XFb4cq+GLijMhhf8JIp+qoLl2fmw3jh
 TDS9mLkiZBlj8qGK1VSWvUcVvSupRVBxKAauGSUXrYJiKb2+tk4wrli5aKld7T4OpiOKMLL+I
 IbN2kymjzZmqxJ68vqFR2Bd/YRfW45KVlQoLbiWxm9I+rRQxS2xYqZa1A/HO773K7ehjAtGIn
 9hz5L67wUUwUMqUNjZiavToHoAhtFZHG8w==


--25a2463gtnrp5jed
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: TCP Fast Retransmission Issue
MIME-Version: 1.0

On 25/02/01 07:09PM, Ahmed, Shehab Sarar wrote:
> Hello,

Hello,

> While experimenting with bbr protocol, I manipulated the network conditio=
ns by maintaining a high RTT for about one second before abruptly reducing =
it. Some packets sent during the high RTT phase experienced long delays in =
reaching the destination, while later packets, benefiting from the lower RT=
T, arrived earlier. This out-of-order arrival triggered the receiver to gen=
erate duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup A=
CKs quickly reached the sender. Upon receiving three dup ACKs, the sender i=
nitiated a fast retransmission for an earlier packet that was not lost but =
was simply taking longer to arrive. Interestingly, despite the fast-retrans=
mitted packet experienced a lower RTT, the original delayed packet still ar=
rived first. When the receiver received this packet, it sent an ACK for the=
 next packet in sequence. However, upon later receiving the fast-retransmit=
ted packet, an issue arose in its logic for updating the acknowledgment num=
ber. As a result, even after the next expected packet was received, the ack=
nowledgment number was not updated correctly. The receiver continued sendin=
g dup ACKs, ultimately forcing bbr into the retransmission timeout (RTO) ph=
ase.
>=20
> I generated this issue in linux kernel version 5.15.0-117-generic with Ub=
untu 20.04. I attempted to confirm whether the issue persists with the late=
st Linux kernel. However, I discovered that the behavior of bbr has changed=
 in the most recent kernel version, where it now sends chunks of packets in=
stead of sending them one by one over time. As a result, I was unable to re=
produce the specific sequence of events that triggered the bug we identifie=
d. Consequently, I could not confirm whether the bug still exists in the la=
test kernel.
>=20
> I believe that the issue (if still exists) will have to be resolved in th=
e location net/ipv4/tcp_input.c or something like that. There are so many a=
uthors here that I do not know who to CC here. So, sending this email to yo=
u. Sorry if this is not the best way to report this issue.

does this cause problems for real applications? To me it sounds a bit
like a constructed issue, but I'm also not really proficient about the
stack mentioned about :p

I'm asking because this is important for how we treat this report, see
the "Reporting Regression"[0] document for more details on what we
consider to be an regression.

> Thanks
> Shehab

Cheers,
Christian

--25a2463gtnrp5jed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmefOjIACgkQwEfU8yi1
JYXRmQ//fNZlSzgu2xmzXKCfFq9LUU9bUdIDbAZkgvfsWTi5zV960Fujo8K3RORT
gUGVEdnC3ARC0xHFYY5DMB154H6SbSvWqaGtOqZLP46r4QOz9xZNzadWsFNSPXrQ
uXHF1+TGBT6iy2fZNjql6pnWdHQa06C0uRIKpoNOw8YWK8t4Bmb2vRZ2uPCqIfjU
hdt/XiajVexy1LK2bqR5XG8FlPpin1AZYb5C0g7zUauJxnlkA0oAB3cRrTeqR9If
gEwRJBZA/ktJ1GoYrPcL3R9Lz4B5RMsEw/mVFMmWEDGNOQqrCOvRugtt6JAmnih3
YDJkWY3J1jwHwft3l1C9MVF4lbXPQUSQFjABFETjYdyfld8SHs+qnyAEZo44a91W
cFT7FSlKRMU3oINnzEgZRyhYQbNCPlgXY5kbzoRN7lCYXdZjFcclOorqFKZyWPB0
lvluVQBMD0mFSbqxf4jLb5eeEdwQT7nqLGsko+IKjNFnAo9cs0pA91TeYlqL3bZk
Uk/OyFn23AwePGla+z2+DHRmHuh+F9Y714Ty/hZGYqDH/NhOHXLw9S6Pe3tcVD+t
Id1gpLoEBP1le3TlSX3MN7Paa33KR41SaoAUuEz0/OObLfBlW182mGR5F0aiCIWt
YesVghZdTEpPg51Y9XJV5TpAgVsEwMPssYfZfSLZ8lZNQa4GgE8=
=vy/l
-----END PGP SIGNATURE-----

--25a2463gtnrp5jed--

