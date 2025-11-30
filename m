Return-Path: <stable+bounces-197660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C30C94B0C
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 04:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EE09346C47
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E9221F2F;
	Sun, 30 Nov 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T9GgRzQa"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB92139CE
	for <stable@vger.kernel.org>; Sun, 30 Nov 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764472173; cv=none; b=dottZkSmJ6h4X0DgGmAb4sI/lcwe3faCgobzK8WgDi05RREfJVtS+Lu8ImAFkyzeyYkyoyUm3VL6vrlb9DDEdkE43uKJ9cUyleqwOkKrqb0DFIOwufhuPuCwBzPjZHdBxDlCBwWohT/QbSTmpwDUuZ9RRvN4HAGcDOSOSUR0oWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764472173; c=relaxed/simple;
	bh=oQWar6onaNJAQBuC9BezdrakiUnM6RqCm5OgOJmWMv0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XGyWXutm20AQis7gMK3Nj5NQrQ7Ow7kCdL/V+mamaMVBWVnyk1Yb/Iq5NFlJaPU4fAbSjrJwBCiJvhCuiPMYwvSWVoY4R0x6E1qKSmCzxlGQIEzVBeKSdd8pKQNlhWxYGKzhUUoZFVSBN/cPvcCdq6+StVhnyEMp4Cj+qJJkozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T9GgRzQa; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764472159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/61guQPl+0JPBC31qNOsQVgN5ueVOOhWuwuMasymtc=;
	b=T9GgRzQaQ/P9GFgmbVrdW3ovQPgv0UmRrhcelp4f/80Frg66mYk8j1J+xEHFpejXj8lij+
	hsZIx5wRT+vXQ8ycUF66sCXf+nyDgBmL+IhQOCjc1rRwaJyPDulR35hGIEgcFfJCQpdBWI
	0c+izRh6Aa/Q/uzGSOcZlk0SnLLIGuQ=
Date: Sun, 30 Nov 2025 03:09:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <33fba9e2d4707f711fd1d477a07d427e684e2f07@linux.dev>
TLS-Required: No
Subject: Re: Patch "mptcp: Fix proto fallback detection with BPF" has been
 added to the 6.1-stable tree
To: "Matthieu Baerts" <matttbe@kernel.org>, gregkh@linuxfoundation.org,
 sashal@kernel.org
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org,
 jakub@cloudflare.com, martin.lau@kernel.org
In-Reply-To: <9e6ef98f-12eb-4608-aece-cf321e0a38d7@kernel.org>
References: <2025112711-frigidly-unruly-4a72@gregkh>
 <9e6ef98f-12eb-4608-aece-cf321e0a38d7@kernel.org>
X-Migadu-Flow: FLOW_OUT

2025/11/29 01:03, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@ke=
rnel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrot=
e:


>=20
>=20Hi Greg, Sasha, Jiayuan,
>=20
>=20On 27/11/2025 14:41, gregkh@linuxfoundation.org wrote:
>=20
>=20>=20
>=20> This is a note to let you know that I've just added the patch title=
d
> >=20=20
>=20>  mptcp: Fix proto fallback detection with BPF
> >=20=20
>=20>  to the 6.1-stable tree which can be found at:
> >  http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.=
git;a=3Dsummary
> >=20=20
>=20>  The filename of the patch is:
> >  mptcp-fix-proto-fallback-detection-with-bpf.patch
> >  and it can be found in the queue-6.1 subdirectory.
> >=20=20
>=20>  If you, or anyone else, feels it should not be added to the stable=
 tree,
> >  please let <stable@vger.kernel.org> know about it.
> >=20
>=20@Sasha: thank you for having resolved the conflicts for this patch (a=
nd
> many others related to MPTCP recently). Sadly, it is causing troubles.
>=20
>=20@Greg/Sasha: is it possible to remove it from 6.1, 5.15 and 5.10 queu=
es
> please?
> (The related patch in 6.6 and above is OK)
>=20
>=20@Jiayuan: did you not specify you initially saw this issue on a v6.1
> kernel? By chance, do you already have a fix for that version?
>=20

Hi=20Matthieu,
I=E2=80=99ll send a separate patch for v6.1 immediately =E2=80=94 the iss=
ue causes a panic in v6.1.

