Return-Path: <stable+bounces-52089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B0907A5E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4214A1C24E48
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9314A093;
	Thu, 13 Jun 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mfE5XQXZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C514A0B5
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301382; cv=none; b=u1fT59YNo/ak4thzlCzbTx0BB+fIBMlStg7i1nrw4PDKGM6gIJ47LpXgE3/oEzKsdz15q1Z0O31HyDsdXjjxL6j4PmNsztI6DNnL2FwOfl5XFT0BKFX9LzSzodQ6jlDgCdvM4Y8iS90B1teOWD3xiAILlYGq9rfmVzsDvcHJuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301382; c=relaxed/simple;
	bh=E7beql6PZ0QHFCiY6sxUPNYYViiurX0BbV/IRCAJHPE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kwDAaPLTK85MD3WLSFV3OiQm3BScNyDo/iecafvfmNrNr8/dzOOptMYOU247NQacO0cqIhjE1rhNg4PPB37dL1jDLxSx0OU370HqQG818V3huVhGXS+uwTbfG0Z6bU2L15/k6tHdOmstyBjA+Q2dvLD7Obh3s9QBhyaCi1/iEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mfE5XQXZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD80F20B7001;
	Thu, 13 Jun 2024 10:56:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD80F20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718301380;
	bh=vVT4FVOu7dJJQlTZG+GRIiExAW5hC8kw2gMNGmlxg60=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=mfE5XQXZPJUZW/RPBiDZEvUlHewYr04Ia3w8CBVjL1LvUIX5UtiCV2/ylAB2fBMr7
	 xUCkrNrFy//+W6a/ldl40uyxAa0ymuQCheJ+bhXZAVnxgZUreVa6ZerpL59+1rvmkt
	 xc9Ja2w+LZRu18hbs4+O+tY7Dlo66baKMdK+frzk=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: Regression Impact from Commit dceb683ab87c on Kubernetes Hairpin
 Tests
From: Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <2024061212-reliance-cycling-66e4@gregkh>
Date: Thu, 13 Jun 2024 10:56:10 -0700
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B304D01A-7DBC-4576-8B9A-A8F2CD418BB6@linux.microsoft.com>
References: <AD9EB3AD-7A36-4E54-9BEC-02584A4DF11E@linux.microsoft.com>
 <2024061212-reliance-cycling-66e4@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.600.62)


>> Hi Greg,
>>=20
>> I hope this message finds you well. I'm reaching out to report a =
regression issue linked
>> to the commit dceb683ab87c(v5.15.158), which addresses the netfilter =
subsystem by skipping
>> the conntrack input hook for promiscuous packets.=20
>>=20
>> [dceb683ab87c 2024-04-09 netfilter: br_netfilter: skip conntrack =
input hook for promiscuous packets.]
>>=20
>> Unfortunately, this update appears to be breaking Kubernetes hairpin =
tests, impacting the normal
>> functionality expected in Kubernetes environments.
>>=20
>> Additionally, it's worth noting that this specific commit is =
associated with a security vulnerability,
>> as detailed in the NVD: CVE-2024-27018.=20
>>=20
>> We have bisected the issue to the specific commit dceb683ab87c. By =
reverting this commit,
>> we confirmed that the Kubernetes hairpin test issues are resolved. =
However, given that this commit=20
>> addresses the security vulnerability CVE-2024-27018, directly =
reverting it is not a viable option. We=E2=80=99re=20
>> in a tricky position and would greatly appreciate your advice on how =
we might approach this problem.
>>=20
>> Thank you for your attention to this matter. I look forward to your =
guidance on how we might proceed.
>=20
> Is this issue also in newer kernel versions (like 6.1.y, 6.6.y, and
> Linus's tree)?  If not, then we might have missed something.  If so,
> then please work with the netfilter developers to work this out.

I have not tested 6.1.y or 6.6.y yet. Will do that and if the issue =
persists, will reach out to=20
The netfilter folks.

Thank you.

Allen


>=20
> thanks,
>=20
> greg k-h


