Return-Path: <stable+bounces-124576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D5A63E69
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDA3AAE09
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 04:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0311ACEA5;
	Mon, 17 Mar 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L0z+Glu3"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC6DDC1
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186136; cv=none; b=gpJ2fxbHhd8AknFjSHi7Essqnl6dRY3FqtD43cW8ZB3/K3xr1uM0vgqTIL/Ya6waSRDoeAbNUvQ0DGZqiwKU2NwouGJt1dUYk2PO8BoeKgiMPcce1V4qG3usBICtml1gPYipF7z2wft/v2axy5NAO8FqTvZmZQkV9/xK+ZXyw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186136; c=relaxed/simple;
	bh=htC2chstG2RXZKwQRcNLEg1bC1yAKoFDtn1vZBf4HKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=BlOeEcHdaJ7cHguNgdNMZeRC4B7ugtnk3pAijnLmAOUeDvV1kXjcwrE//ZQGF1ei2mk+aUh9xLrvZOFHBC+oU0xDHeq0gL0RDXriyX2xEwGr+mWo3hZSAc5ffTxSEkeC7ig36OHKiRtBIAeYS9ra/jBm7Dl8c0irGlXPnyA2O1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L0z+Glu3; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250317042851epoutp026745c41cea736101e272a63a3739b674~tfLE7wG3k3218632186epoutp02k
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 04:28:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250317042851epoutp026745c41cea736101e272a63a3739b674~tfLE7wG3k3218632186epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742185731;
	bh=QDLrWXG8pt3LkBCgSr9AF9mFXUOQFmlcoAx/9zeoh7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0z+Glu3j2F1ByjRmPGLYEirLMZ5fesE9I6zynByvXAj6iQHihyxb31mXx6gUM1sk
	 ZQnjHMedvowWqPMNtWmPwLHk3SVekKcjJdNd2SgnjisIQdUcRoExd+scx1L/b3w+HX
	 LGlR+FIzA6+Kqu5speSvdVB4kFsL1fCN+gUXGEjw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250317042850epcas2p431023dc394375c87c2a690cdb2ad1068~tfLEC-Zva2428424284epcas2p4Z;
	Mon, 17 Mar 2025 04:28:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4ZGMRj707sz4x9Q6; Mon, 17 Mar
	2025 04:28:49 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.CD.23368.105A7D76; Mon, 17 Mar 2025 13:28:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250317042849epcas2p4c48bfa439a29d8230c36c31c8bcf49fe~tfLC5AjCf2428424284epcas2p4T;
	Mon, 17 Mar 2025 04:28:49 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250317042849epsmtrp195ce9be0282a7507f0172c8b55730999~tfLC4AO5e1297712977epsmtrp1I;
	Mon, 17 Mar 2025 04:28:49 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-a1-67d7a5012c2e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.FC.33707.105A7D76; Mon, 17 Mar 2025 13:28:49 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250317042848epsmtip29da5f164d5738813e7ba22a6e5610290~tfLCixU8d1052310523epsmtip2G;
	Mon, 17 Mar 2025 04:28:48 +0000 (GMT)
Date: Mon, 17 Mar 2025 13:32:48 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, ncardwell@google.com, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com, dujeong.lee@samsung.com, ycheng@google.com,
	yyd@google.com, kuro@kuroa.me, cmllamas@google.com, willdeacon@google.com,
	maennich@google.com, gregkh@google.com, Lorenzo Colitti
	<lorenzo@google.com>, Jason Xing <kerneljasonxing@gmail.com>, Youngmin Nam
	<youngmin.nam@samsung.com>
Subject: Re: [PATCH 2/2] tcp: fix forever orphan socket caused by tcp_abort
Message-ID: <Z9el8JIHMsRbFRSd@perf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2025031411-sandbag-scabby-eb1c@gregkh>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUybVRTGd/u2fdsmmA4Y3HVkwc4RmZa1WMoFgYgiK+syMLrMj2T1lb4W
	QmlLPwg6zSof5cMJQzZBNmaBLGNVxyRYO0oHFgYMTNSR0oxtwYFjogVGx3DFMGxpmf73Oyfn
	uc859+QwsNAynMPIV+pIjZJQcOksqmUgVsQD51xy/siQCC33X8fRhL0eR2d+Lqeiiz0VFDRr
	aqKiu0PTOJpd8WKorL2TjhpOAlTadx1D03UjdOS0LWDIZmnE0S+WWhpyDNzD0XjPGTrqHFsA
	aMXuxlHVLTsVDZki0MqYGyDTd9MAVcw8wFGl9y8qWp5x0tHScCmO2vs9OCprvUh9KUrcfeEG
	RXy5+TYuNnXpxV3marrYVIuL+1q+wcWLV5x0cW23GYgfdO3MYb5dkJJHEjJSE00qc1WyfKU8
	lSt5XfqKNEHEF/AESSiRG60kCslUbsaBHF5mvsI3Pze6mFDofakcQqvl7k1L0aj0OjI6T6XV
	pXJJtUyhTlTHaYlCrV4pj1OSumQBnx+f4Ct8tyDvZt8CRT3PKWlZclMNYDCiBjAZkC2EI5Wn
	QA1gMULZVgDv9U7jgcADoPfvNsqTYGW0gr4pcVrNQcllAL+oHg9K7gBY7bYBfxWVvRt2rd2i
	+JnO5kHLyOONfDj7WTh3dZLqZ4x9nAanFo75OYwtgRP9p3A/h7B3QavlRpC3wmtf/u6rZzCY
	Pue7P73v94Ls00x4ybOMBTrKgK3TV4LdhcE/h7vxAHPgXJ0xyFpomJrEAuJyAEddfwTFL8Dm
	2UrgN8DYeXDcxPIj9PUwuNnmU7BqYA0PpENglTE0IIyBqycvgQBHQVt7R/BBMbS7vbTAlywB
	uLj4CDsBdjb/b5rm/8yaNxyehyabhx5I74DnHzMCGAs7e/aaAM0MIki1tlBOauPVgif7zVUV
	doGNa9jzqhU0zN+PcwAKAzgAZGDc8JC6Npc8NERGfPAhqVFJNXoFqXWABN9m6jHOtlyV75yU
	OqlAmMQXikSCxPgEfiI3MuSotVweypYTOrKAJNWkZlNHYTA5Boqd83I1PVc0qD1SZD5u321+
	rXHLpLrxmTfOlxQlPaR+4s2spzVxzKWHt6UVJxLf1qjckaznXMKi+z9c3b76aF9TgbC4KHn0
	yL53vjLu+Lq3o6Mn/WFP1Ge/UiRnixUVFXf4Mc7Kp5syRPah9SnJcLzUS6TE1Xa+d3Dr8YT1
	gZIfcz6KUWw5PaMs1/MstwFwhOnWkz+VxMR/DscPWX6jrTLGeJRd4MXea0SsMXvh+yxmlq1l
	RLCWb6C8acg68NY/jWNpxqNVN/nGaklr5LGqbOmFiY8b1p2y/FVW+UBmN8twsDQtfP/a4SVP
	9nyDy7W94myMtfbQ/tE2jwzrdJxLn0sXcqnaPEKwB9NoiX8B9hof45YEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHfXeOO2eD0Wmzer2UNRNipSkVvKCoFNUpi6L6IF2oUzuucpuy
	qVRQWSk5P5iZpi2jlaVpOmnoZpelTXPLkkpbNrMkzUs2FS8tLbScFvXtx/P//x4eeEhM2ID7
	kEeUiaxKycjFXD5urBP7B4HbrbIQ8wAPjdU2E+it+SKBCl6m4kj/II2DenT5OOpu6CRQj2sC
	Q+cKK7joUg5AZ2uaMdR5wcZF9oeDGHpozCPQK2OmJ7LU9RKo5UEBF1U8HwTIZXYSKL3djKMG
	3Xzkeu4ESHevE6C0rlECnZ/4iqOxLjsXDVvPEqiwdoRA527o8Sg/urLEwaHvaz8QtM6QRBtK
	NVxal0nQNdfKCHrosZ1LZ1aWAnrUsGg7bzc/XMrKjySzqpURB/iHdRmNIKEcHmssD0kB17wy
	AI+E1Gpory4FGYBPCikTgF8z7oPZwA++L2nxnGUR7Eit95wtdQD4vuXMTAmnAqFhsp3jZi4V
	BI22qZm5F7UMfnnahrsFjMryhJfHbDMlERUN39bmEm4WUAGw2uggZrcOA3ilqedPMBc+u/IZ
	dzNGSeC7qS/TMjnNvrB4inQjb/rs7hexWYDS/ido/xO0/wQdwErBPDZBrZApDiWEBqsZhTpJ
	KQs+FK8wgJlXS3ZUg6KKyWAL4JDAAiCJib0EF262yoQCKXP8BKuK369KkrNqC/AlcfECQYBc
	IxVSMiaRjWPZBFb1N+WQPJ8UjnStg7xlkytrhDU3GP8cuS3TldMnt+5avmLkjli0Q3mV/2nd
	nJPWuM6+cf1wd20dMTlwrzU0Gezd2k59FKX8NMnKDi553WsSxWcvmrfUf1Xx4pg2QXaJCQ4Z
	FnRdjZFefJS7oSoxum1P10QhP8yh+diadTQyd4tEP2JqDFdXRpqUeczrIV36lHTz+fxX1/d7
	kY6OImvzidhtdm/zar3r3Zv6/jVrs8OqPBQ7CcuP+A+afU1O17foXqfHwbDvRRK/KmeEdmBT
	X/Iqx90XHtaKtoB9SwMNT6J+ucjRPSPF+UgT4h0Rd5pz6tfC9P6mfL5/7JaXJyc2hprX9+eN
	pzBOMa4+zIRKMJWa+Q3GYDWJWQMAAA==
X-CMS-MailID: 20250317042849epcas2p4c48bfa439a29d8230c36c31c8bcf49fe
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eH2_J4jYqvRXP4eDI3fJMDII8MgNqIHEmJE4NX.asT6eXmTC=_21c3b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250314092130epcas2p34e60b23ff983fe03195820a38fb376c5
References: <20250314092446.852230-1-youngmin.nam@samsung.com>
	<CGME20250314092130epcas2p34e60b23ff983fe03195820a38fb376c5@epcas2p3.samsung.com>
	<20250314092446.852230-2-youngmin.nam@samsung.com>
	<2025031411-sandbag-scabby-eb1c@gregkh>

------eH2_J4jYqvRXP4eDI3fJMDII8MgNqIHEmJE4NX.asT6eXmTC=_21c3b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Mar 14, 2025 at 01:24:26PM +0100, Greg KH wrote:
> On Fri, Mar 14, 2025 at 06:24:46PM +0900, Youngmin Nam wrote:
> > From: Xueming Feng <kuro@kuroa.me>
> > 
> > commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4 upstream.
> > 
> > We have some problem closing zero-window fin-wait-1 tcp sockets in our
> > environment. This patch come from the investigation.
> > 
> > Previously tcp_abort only sends out reset and calls tcp_done when the
> > socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
> > purging the write queue, but not close the socket and left it to the
> > timer.
> > 
> > While purging the write queue, tp->packets_out and sk->sk_write_queue
> > is cleared along the way. However tcp_retransmit_timer have early
> > return based on !tp->packets_out and tcp_probe_timer have early
> > return based on !sk->sk_write_queue.
> > 
> > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> > and socket not being killed by the timers, converting a zero-windowed
> > orphan into a forever orphan.
> > 
> > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > reset to peer and close the socket accordingly. Preventing the
> > timer-less orphan from happening.
> > 
> > According to Lorenzo's email in the v1 thread, the check was there to
> > prevent force-closing the same socket twice. That situation is handled
> > by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
> > already closed.
> > 
> > The -ENOENT code comes from the associate patch Lorenzo made for
> > iproute2-ss; link attached below, which also conform to RFC 9293.
> > 
> > At the end of the patch, tcp_write_queue_purge(sk) is removed because it
> > was already called in tcp_done_with_error().
> > 
> > p.s. This is the same patch with v2. Resent due to mis-labeled "changes
> > requested" on patchwork.kernel.org.
> > 
> > Link: https://protect2.fireeye.com/v1/url?k=f1caf90b-ae51376f-f1cb7244-000babda0201-1111684dae24e0cf&q=1&e=32bd2804-1687-48c6-945d-f20eded99c42&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fnetdev%2Fpatch%2F1450773094-7978-3-git-send-email-lorenzo%40google.com%2F
> > Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> > Signed-off-by: Xueming Feng <kuro@kuroa.me>
> > Tested-by: Lorenzo Colitti <lorenzo@google.com>
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Link: https://protect2.fireeye.com/v1/url?k=66416ec8-39daa0ac-6640e587-000babda0201-21346ca5121765eb&q=1&e=32bd2804-1687-48c6-945d-f20eded99c42&u=https%3A%2F%2Fpatch.msgid.link%2F20240826102327.1461482-1-kuro%40kuroa.me
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Cc: <stable@vger.kernel.org> # v5.10+
> 
> Does not apply to 6.1.y or older, what did you want this applied to?
> 
> thanks,
> 
> greg k-h
> 
Hi Greg,

Sorry about that. Let me resend these patches for 6.1 and 5.15.

As for 5.10, it seems to have more dependencies for the backport.
I think the maintainer should handle it to ensure a safe backport.

------eH2_J4jYqvRXP4eDI3fJMDII8MgNqIHEmJE4NX.asT6eXmTC=_21c3b_
Content-Type: text/plain; charset="utf-8"


------eH2_J4jYqvRXP4eDI3fJMDII8MgNqIHEmJE4NX.asT6eXmTC=_21c3b_--

