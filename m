Return-Path: <stable+bounces-244958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CRPJoxF/2mo4AAAu9opvQ
	(envelope-from <stable+bounces-244958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:32:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709C5000FD
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56DB3036D51
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0D38911F;
	Sat,  9 May 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="n5shRwKT"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C14396B70
	for <stable@vger.kernel.org>; Sat,  9 May 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337056; cv=none; b=KmAwPOTxsLG3xc0hzIEHCRRPlvFoznDooCgVjS41tEa6tZfgOQsVE7QI83tgTM+Llb4xSjRMP2fhg9fvUNayJ0Pdqdl7cx9KsTXYNYxc0JL2KrK/5Zkl1u9Friq9yUYjyN3k8HQFrpjx9IFsPm+wonDbLu4WmqFkug76oA8BX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337056; c=relaxed/simple;
	bh=gfFLT6YEvNHvzhL3TU9BCuo8pNxFuNR/fCsp2K3YZUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhR+/sg298uAgnrCQk2z9i6ggQep1FhN8AyYsrluSzRBK+M0cP4GAaeZMdOh9DsDl9r7K92jqB6LnAvpoPkc95P/AVlzpRoi9UTdvM9vyrk7w/YXfqsX8lLsJ+7CHpmfd7SSJniOvcVVk34a2cqkIO4BL88DhDIfMPjJtflonlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=n5shRwKT; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=4646; t=1778337004;
	x=1778941804; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Autocrypt:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20from=20[IPV6=3A2603=3A7
	002=3A100=3A8400=3A8595=3Ac601=3Aade8=3A99ed]=20by=20auristor.co
	m=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=
	20PRO=20v26.0.2b)=20=0D=0A=09with=20ESMTPSA=20id=20md50010052595
	23.msg=3B=20Sat,=2009=20May=202026=2010=3A30=3A02=20-0400|Messag
	e-ID:=20<ee897c82-d9c0-4b09-86e5-e34458b6341a@auristor.com>|Date
	:=20Sat,=209=20May=202026=2010=3A30=3A39=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PAT
	CH=20net=20v3]=20rxrpc=3A=20Also=20unshare=20DATA/RESPONSE=20pac
	kets=20when=0D=0A=20paged=20frags=20are=20present|To:=20Hyunwoo=
	20Kim=20<imv4bel@gmail.com>,=20dhowells@redhat.com,=0D=0A=20marc
	.dionne@auristor.com,=20davem@davemloft.net,=20edumazet@google.c
	om,=0D=0A=20kuba@kernel.org,=20pabeni@redhat.com,=20horms@kernel
	.org,=0D=0A=20qingfang.deng@linux.dev,=20jiayuan.chen@linux.dev|
	Cc:=20linux-afs@lists.infradead.org,=20netdev@vger.kernel.org,=0
	D=0A=20stable@vger.kernel.org|References:=20<af2kdW2F1gJ9U-Gg@v4
	bel>|Content-Language:=20en-US|From:=20Jeffrey=20E=20Altman=20<j
	altman@auristor.com>|Organization:=20AuriStor,=20Inc.|Autocrypt:
	=20addr=3Djaltman@auristor.com=3B=20keydata=3D=0D=0A=20xsFNBEwLl
	O0BEACu6yWFkd1+qwsGg8ZzgslSkcAKhSegWt5j86DpaRL0W8fxg6YjxwEPvwoH=
	0D=0A=20BGa/rpSdBd1gkmzeYxD3hVZdj75r6nVS9f/mxNQzW+o1sW4vaeSxKgZS
	Qz5RqHmwPDcqQP66=0D=0A=20+ZSnjV+G88MKwZ9DIzA9AwpJhNAAlAlj3OvsQVs
	xd1ipc6C4/U3qjHL7Ih22UbPBM71ltIZx=0D=0A=20kqcrAlXPnUTeraJXtfzYbq
	4mJFJ9JC6/o1NRSjsBvRD+ADxlG50+KccZN4SS5xxdGuh1tA9U=0D=0A=20TydYB
	QB3YtJbq7CYau2kIYt/3HnyLYGo1s6Ti6cuAJJ/40iIE1xkqhvMiIz/Q+1ztmksJ
	bLQ=0D=0A=20aCtW8kF42nF8MpPdIPTSPr2uGvpRtCjRbh4lgMXgyNUx1wpCEY0X
	11xce++H8HySmFwryE2y=0D=0A=20kkxUQeMUjaaXZDHYUSyQz7riChFiZ9ax9dm
	X0wUY/A05v0qcualglpk4wJ2kcsGKUEGkLvnV=0D=0A=20wwvya8zifPwKOw5JlG
	PvzX8t2m7jB2GXKzvVAsImqOqnDBTKUXWQQZCW9Rqt7acdE8bQ2vqr=0D=0A=20v
	P+3Ykf4SrPwcuNCDt6QSgjVbhc3hA3hCtE1iW/HhuBAzKiuzJ9era+q9QjTtLPIk
	QDHRpcC=0D=0A=20MMWvK0Y1uQ34Ql1BfKRA4gc8A7CuVUY6+Ga7PuJWd+FSglvm
	KQARAQABzTZKZWZmcmV5IEFs=0D=0A=20dG1hbiAoQXVyaVN0b3IsIEluYy4pIDx
	qYWx0bWFuQGF1cmlzdG9yLmNvbT7CwXkEEwECACMF=0D=0A=20AlY2YwgCGyMHCw
	kIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRD3enNVkraaBDdzD/0XQUDW=0D=0A
	=20UWXrpapHdvZaHzPHc3xobRi4PABWfLW1jfMK5Xy4DP/x7x3I2qAqTD6vv/OPF
	Mx8gG6+Xeod=0D=0A=20Mj5vE7+7ZRd+J76J4DJH2qoaXX8qnUEABUJHZYDhw2/I
	j5AQ6ZsuSwXuURGEMi0vu1ihBbP6=0D=0A=203bt4LRIa+F60ebDvCl9po+UB7Tr
	jQCs+YV1r1YeCSv9hEHBly/W0u1OrnNCMWRcq7dmTCbZ0=0D=0A=20R5w6VJ/+QE
	io+T6paGGMjJmrNw2qUeuK+SxOOxOWS8lgdqzjcK3NsfiERrVbOWM83ZVy0/GN=0
	D=0A=20vpusjhI/3Q8lbV/p+IsJk/v1grkRzgU0frES2ANEPTpC4j2ggPOSMpsz3
	BZ8wIOg17rIWnK+=0D=0A=20gNLQe+XN7kvDwGu0jYhTIZO10jcVsRSrAJGtgBNr
	YxOjEUhpnaSJDVcjapRvRPCQumA13Zkl=0D=0A=20nm4AYjp7L2oOIeOGcKRZwbr
	GDakksa5iaSIoywpwECWh2l9V0W3SeynBgPtR4qpt4N8yKCcw=0D=0A=20suLCAK
	fBv9RcL641XZi/Fp9btSuTPUm5Lw3SIGr5U+SyezmhzlwsObIF9W624aorriWoXN
	f3=0D=0A=20GgH9ZH0Hkc6aS99pIZhh5USWRO/pS+lv5eNkEdf9LUBGX9b6ZMan0
	fpoEayqUejtZw3O2rgs=0D=0A=20zA+pTSA+/HobvtL6L3XtlPJ1NXlkgM7BTQRM
	C5TtARAA88hJdpgcg2RU/uAWfAL46XZHA59c=0D=0A=20VpPNNly1tPWCSbG6+ON
	H6nOG/NarmNVxX6Mb9YRkEU6wmrZS85inz3otdyz/zlyNSWma8qGN=0D=0A=20Ul
	MbiwFQqfXWVBAPGoRC0a0aJrd4IayLuvv1UqEwx7Otp7y5RNHtRv35/kho0Z+Uhe
	YVdGm2=0D=0A=20I06xIc+aNKW2LO7R5BNtjpADPIG+NSdsVIeamhAWPvLrwbf6m
	Ub//eA9pF0w0QixLVrH/cCo=0D=0A=20z+S27gCGJvY6zF22NgdhnkIqNz8E/LKt
	6S36ZI9Mw/ixpQTozqRmdNzVQNgTHUZClbJj4iq1=0D=0A=20EPHB7XqpxOv+awr
	xSxq2jt8GFD0rU+sAuzW+F7cBoIw434/IrxKYwcPHpHLEVQ1tLP7d3ZpZ=0D=0A=
	20R30p3oqoliGiLsWvHHxyXjuMBF4XJ6MRXmD65/qOhuo2DKduHMNlmxzgSzvWgX
	ZeNJq+OcS8=0D=0A=20jQZDt2Na2pMKjWytau7xQu2ndm0FwS48ngMrDYRQMxzL1
	NfnBnT9BCwjiU+/6NBSwcNKIqye=0D=0A=20a9IpTwsVfkF4/iui7xD9+LtzqeUk
	BAe7q5jEJmJMZhAfh7usZGT8TGxXegCaF4Jwz2nxS4Fv=0D=0A=207VRza/yUAOJ
	lc0daR11TPeiUNCQWY7PpL1AXO9vaSyjFuOzTnU8vzXvI9fGoxIxKGRQpKMU8=0D
	=0A=20PROIFw0AEQEAAcLBXwQYAQIACQUCTAuU7QIbDAAKCRD3enNVkraaBIxXD/
	4xlaBwW2TLFfMv=0D=0A=20lcY/2XDSm6NO4JaJG2Nzp35xaaBVwMVzWvI+GgTgK
	NSFot9f4jiLBNQdnq3UKoEThR2ORKVL=0D=0A=200ZJS1QYR7yyrOo0MteDSy8of
	U1FJ6xu4ND3ekOjP20BTrihDpqUdahir2uaRfMkwM+0imOlc=0D=0A=20utGMhJN
	F/LAjrhoDp9SeDMYBXZ1wfrbrEo/EEu0PbkGyzqPyEPqwN1iSJkcAnjuIA0rTf1j
	Q=0D=0A=20tJAaDov7yHsSRwUM+qTGsjOGQAN3wtYwjPpw7hI01sE+x0uq0pVeo4
	qeWTZ2TE4Vtp8FKXFA=0D=0A=20kqnP878q+kNk9Ve+DRs8UlRfa9Lgf5ETjXOTV
	GaT/UGxi9B4oo8k0lzvM/A1txexL/lLw8AU=0D=0A=20LhUeGtyS6D2X9vFi6azn
	a+o918R9BV86uXPiDOf1nMwqKchNCxmgH9vd0aQm8TKCrWAW4kU1=0D=0A=20Ig6
	aMNuZiWloVZfKrmWizbgeGKE9rhNPNqxkqBaA4lrJ8L6bdKbhAOe3NQjO2vUAXB5
	3Jphl=0D=0A=20F74GwEsh+85i9/yIbvwJVcsFYhdZz7fCAUOcnFkGnyrwIgkizQ
	3xXShPW8mqkgUk4kYMnucC=0D=0A=204kG/E7pI/4lke5X5X9vroXRHB7tkpAgT4
	6SqSM/XTwCaseXG9orDgz3duRTUp6K0++S/qsqT=0D=0A=20akGVmjD5917A1HqW
	fMmiKA=3D=3D|Disposition-Notification-To:=20Jeffrey=20E=20Altman
	=20<jaltman@auristor.com>|In-Reply-To:=20<af2kdW2F1gJ9U-Gg@v4bel
	>|Content-Type:=20text/plain=3B=20charset=3DUTF-8=3B=20format=3D
	flowed|Content-Transfer-Encoding:=20base64; bh=gfFLT6YEvNHvzhL3T
	U9BCuo8pNxFuNR/fCsp2K3YZUY=; b=n5shRwKTGHRFxQ/za64yQntgGiSUPzBZt
	3ydNwQ5cIxX+a0hE/+tEnVU4cwhRUA7Yo8P4jsGYVUTz/hi+aU3QEgZQQeR55THz
	ORBndEQ+K7JeX4JMgnEdDlfLdzYTYnyKklemjnyw93GWjLg3tbbQwoD+lX6bUbr5
	WZLfUO2BBo=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Sat, 09 May 2026 10:30:04 -0400
Received: from [IPV6:2603:7002:100:8400:8595:c601:ade8:99ed] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2b) 
	with ESMTPSA id md5001005259523.msg; Sat, 09 May 2026 10:30:02 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Sat, 09 May 2026 10:30:02 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:8595:c601:ade8:99ed
X-MDHelo: [IPV6:2603:7002:100:8400:8595:c601:ade8:99ed]
X-MDArrival-Date: Sat, 09 May 2026 10:30:02 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=15896d4e26=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <ee897c82-d9c0-4b09-86e5-e34458b6341a@auristor.com>
Date: Sat, 9 May 2026 10:30:39 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
To: Hyunwoo Kim <imv4bel@gmail.com>, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <af2kdW2F1gJ9U-Gg@v4bel>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Autocrypt: addr=jaltman@auristor.com; keydata=
 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
 akGVmjD5917A1HqWfMmiKA==
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <af2kdW2F1gJ9U-Gg@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: 0709C5000FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244958-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,auristor.com:mid,auristor.com:dkim]
X-Rspamd-Action: no action

T24gNS84LzIwMjYgNDo1MyBBTSwgSHl1bndvbyBLaW0gd3JvdGU6DQo+IFRoZSBEQVRBLXBh
Y2tldCBoYW5kbGVyIGluIHJ4cnBjX2lucHV0X2NhbGxfZXZlbnQoKSBhbmQgdGhlIFJFU1BP
TlNFDQo+IGhhbmRsZXIgaW4gcnhycGNfdmVyaWZ5X3Jlc3BvbnNlKCkgY29weSB0aGUgc2ti
IHRvIGEgbGluZWFyIG9uZSBiZWZvcmUNCj4gY2FsbGluZyBpbnRvIHRoZSBzZWN1cml0eSBv
cHMgb25seSB3aGVuIHNrYl9jbG9uZWQoKSBpcyB0cnVlLiAgQW4gc2tiDQo+IHRoYXQgaXMg
bm90IGNsb25lZCBidXQgc3RpbGwgY2FycmllcyBleHRlcm5hbGx5LW93bmVkIHBhZ2VkIGZy
YWdtZW50cw0KPiAoZS5nLiBTS0JGTF9TSEFSRURfRlJBRyBzZXQgYnkgc3BsaWNlKCkgaW50
byBhIFVEUCBzb2NrZXQgdmlhDQo+IF9faXBfYXBwZW5kX2RhdGEsIG9yIGEgY2hhaW5lZCBz
a2JfaGFzX2ZyYWdfbGlzdCgpKSBmYWxscyB0aHJvdWdoIHRvDQo+IHRoZSBpbi1wbGFjZSBk
ZWNyeXB0aW9uIHBhdGgsIHdoaWNoIGJpbmRzIHRoZSBmcmFnIHBhZ2VzIGRpcmVjdGx5IGlu
dG8NCj4gdGhlIEFFQUQvc2tjaXBoZXIgU0dMIHZpYSBza2JfdG9fc2d2ZWMoKS4NCj4NCj4g
RXh0ZW5kIHRoZSBnYXRlIHRvIGFsc28gdW5zaGFyZSB3aGVuIHNrYl9oYXNfZnJhZ19saXN0
KCkgb3INCj4gc2tiX2hhc19zaGFyZWRfZnJhZygpIGlzIHRydWUuICBUaGlzIGNhdGNoZXMg
dGhlIHNwbGljZS1sb29wYmFjayB2ZWN0b3INCj4gYW5kIG90aGVyIGV4dGVybmFsbHktc2hh
cmVkIGZyYWcgc291cmNlcyB3aGlsZSBwcmVzZXJ2aW5nIHRoZQ0KPiB6ZXJvLWNvcHkgZmFz
dCBwYXRoIGZvciBza2JzIHdob3NlIGZyYWdzIGFyZSBrZXJuZWwtcHJpdmF0ZSAoZS5nLiBO
SUMNCj4gcGFnZV9wb29sIFJYLCBHUk8pLiAgVGhlIE9PTS90cmFjZSBoYW5kbGluZyBhbHJl
YWR5IGluIHBsYWNlIGlzIHJldXNlZC4NCj4NCj4gRml4ZXM6IGQwZDVjMGNkMWU3MSAoInJ4
cnBjOiBVc2Ugc2tiX3Vuc2hhcmUoKSByYXRoZXIgdGhhbiBza2JfY293X2RhdGEoKSIpDQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEh5dW53b28g
S2ltIDxpbXY0YmVsQGdtYWlsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0g
VXNlIHNrYl9oYXNfZnJhZ19saXN0KCkgfHwgc2tiX2hhc19zaGFyZWRfZnJhZygpIGluc3Rl
YWQgb2Ygc2tiX2lzX25vbmxpbmVhcigpDQo+IC0gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9hZjJGMUZVNWQ0UV9HbjFXQHY0YmVsLw0KPiBDaGFuZ2VzIGluIHYyOg0KPiAt
IFVzZSBza2JfaXNfbm9ubGluZWFyKCkgaW5zdGVhZCBvZiBza2ItPmRhdGFfbGVuDQo+IC0g
djE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hZktWMnpHUjZycmVsUEM3QHY0YmVs
Lw0KPiAtLS0NCj4gICBuZXQvcnhycGMvY2FsbF9ldmVudC5jIHwgNCArKystDQo+ICAgbmV0
L3J4cnBjL2Nvbm5fZXZlbnQuYyB8IDMgKystDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9uZXQvcnhy
cGMvY2FsbF9ldmVudC5jIGIvbmV0L3J4cnBjL2NhbGxfZXZlbnQuYw0KPiBpbmRleCBmZGQ2
ODMyNjEyMjYuLjJiMTliMjUyMjI1ZSAxMDA2NDQNCj4gLS0tIGEvbmV0L3J4cnBjL2NhbGxf
ZXZlbnQuYw0KPiArKysgYi9uZXQvcnhycGMvY2FsbF9ldmVudC5jDQo+IEBAIC0zMzQsNyAr
MzM0LDkgQEAgYm9vbCByeHJwY19pbnB1dF9jYWxsX2V2ZW50KHN0cnVjdCByeHJwY19jYWxs
ICpjYWxsKQ0KPiAgIA0KPiAgIAkJCWlmIChzcC0+aGRyLnR5cGUgPT0gUlhSUENfUEFDS0VU
X1RZUEVfREFUQSAmJg0KPiAgIAkJCSAgICBzcC0+aGRyLnNlY3VyaXR5SW5kZXggIT0gMCAm
Jg0KPiAtCQkJICAgIHNrYl9jbG9uZWQoc2tiKSkgew0KPiArCQkJICAgIChza2JfY2xvbmVk
KHNrYikgfHwNCj4gKwkJCSAgICAgc2tiX2hhc19mcmFnX2xpc3Qoc2tiKSB8fA0KPiArCQkJ
ICAgICBza2JfaGFzX3NoYXJlZF9mcmFnKHNrYikpKSB7DQo+ICAgCQkJCS8qIFVuc2hhcmUg
dGhlIHBhY2tldCBzbyB0aGF0IGl0IGNhbiBiZQ0KPiAgIAkJCQkgKiBtb2RpZmllZCBieSBp
bi1wbGFjZSBkZWNyeXB0aW9uLg0KPiAgIAkJCQkgKi8NCg0KQXMgcG9pbnRlZCBvdXQgYnkg
SmlheXVhbiBDaGVuLCAiZnJhZ19saXN0IGlzIG5vdCBlbXB0eSBmb3IgDQpTS0JfR1NPX0ZS
QUdMSVNUIGFuZCB0aGUgc2tiDQp3aWxsIGdvIHRocm91Z2ggdGhlIGNvcHkgcGF0aC4iwqAg
wqBUaGUgY29weSBwYXRoIGNhbGxzIHNrYl9jb3B5KCkgd2hpY2ggDQpyZXR1cm5zIE5VTEwg
d2hlbg0KU0tCX0dTT19GUkFHTElTVCBpcyBzZXQ6DQoNCiDCoCDCoCBpZiAoV0FSTl9PTl9P
TkNFKHNrYl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgJiBTS0JfR1NPX0ZSQUdMSVNUKSkNCiDC
oCDCoCDCoCDCoCByZXR1cm4gTlVMTDsNCg0Kd2hpY2ggd2lsbCBjYXVzZSByeHJwY19pbnB1
dF9jYWxsX2V2ZW50KCkgdG8gZHJvcCB0aGUgcGFja2V0Og0KDQogwqAgwqAgwqAvKiBPT00g
LSBEcm9wIHRoZSBwYWNrZXQuICovDQogwqAgwqAgwqByeHJwY19zZWVfc2tiKHNrYiwgcnhy
cGNfc2tiX3NlZV91bnNoYXJlX25vbWVtKTsNCg0KSXMgaXQgc2FmZSB0byBwZXJtaXQgYW4g
c2tiIHdpdGggU0tCX0dTT19GUkFHTElTVCBzZXQgdG8gZ28gdGhyb3VnaCB0aGUgDQpub24t
Y29weSBwYXRoDQpvciBkb2VzIHRoZXJlIG5lZWRzIHRvIGJlIHNvbWUgYWx0ZXJuYXRpdmUg
bG9naWMgdG8gcHJvY2VzcyB0aGUgcGFja2V0Lg0KDQo+IGRpZmYgLS1naXQgYS9uZXQvcnhy
cGMvY29ubl9ldmVudC5jIGIvbmV0L3J4cnBjL2Nvbm5fZXZlbnQuYw0KPiBpbmRleCBhMjEz
MGQyNWFhYTkuLjQ0MjQxNGQ5MGJhMSAxMDA2NDQNCj4gLS0tIGEvbmV0L3J4cnBjL2Nvbm5f
ZXZlbnQuYw0KPiArKysgYi9uZXQvcnhycGMvY29ubl9ldmVudC5jDQo+IEBAIC0yNDUsNyAr
MjQ1LDggQEAgc3RhdGljIGludCByeHJwY192ZXJpZnlfcmVzcG9uc2Uoc3RydWN0IHJ4cnBj
X2Nvbm5lY3Rpb24gKmNvbm4sDQo+ICAgew0KPiAgIAlpbnQgcmV0Ow0KPiAgIA0KPiAtCWlm
IChza2JfY2xvbmVkKHNrYikpIHsNCj4gKwlpZiAoc2tiX2Nsb25lZChza2IpIHx8IHNrYl9o
YXNfZnJhZ19saXN0KHNrYikgfHwNCj4gKwkgICAgc2tiX2hhc19zaGFyZWRfZnJhZyhza2Ip
KSB7DQo+ICAgCQkvKiBDb3B5IHRoZSBwYWNrZXQgaWYgc2hhcmVkIHNvIHRoYXQgd2UgY2Fu
IGRvIGluLXBsYWNlDQo+ICAgCQkgKiBkZWNyeXB0aW9uLg0KPiAgIAkJICovDQoNClRoZSBj
b3B5IHBhdGggaW4gcnhycGNfdmVyaWZ5X3Jlc3BvbnNlKCkgYWxzbyBjYWxscyBza19jb3B5
KCkuDQoNClRoYW5rIHlvdS4NCg0KSmVmZnJleSBBbHRtYW4NCg0KDQo=


