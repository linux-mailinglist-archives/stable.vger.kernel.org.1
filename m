Return-Path: <stable+bounces-74113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF6972996
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8FD1F25412
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA9136358;
	Tue, 10 Sep 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theune.cc header.i=@theune.cc header.b="v9BsMLbd"
X-Original-To: stable@vger.kernel.org
Received: from mail.theune.cc (mail.theune.cc [212.122.41.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C901171088;
	Tue, 10 Sep 2024 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949987; cv=none; b=tH3NMY6NGtcPtnpe0n5q5sVgMW1zSy+Q7Ehvk9g9sW74m7bH0v6CEqNP7/CtyV+hrn7WkZmzGOWwUQCXWnfd1CT/5cW6Wn51bkgadHHqI4Tkl5AKMYPai4C9+d7k+cUkP/Xbcmo4J8+6RtODKLJ9x8AUAd+nnIwUwz6+ClBbqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949987; c=relaxed/simple;
	bh=JjY69W8Ant6AxwIhWcvkeaHDnbwAevcS9ooCv5+tFak=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HfRjoXOiu5AXCXk8i83nRlWMEXaHRjGW2IPinJcXText+bvuS2+VAeL3xViEo8aUZCSeDiEbsS7iCSUGVfoasJs7PEn0GcH4n39JDNhRJUUaQdAnyimoDqG8pWTMasqQ4nq6UV05W6eQH4BTpMSyyqKYUzmbUAbL3w3gJzDKzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=theune.cc; spf=pass smtp.mailfrom=theune.cc; dkim=pass (1024-bit key) header.d=theune.cc header.i=@theune.cc header.b=v9BsMLbd; arc=none smtp.client-ip=212.122.41.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=theune.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theune.cc
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theune.cc; s=mail;
	t=1725949979; bh=JjY69W8Ant6AxwIhWcvkeaHDnbwAevcS9ooCv5+tFak=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=v9BsMLbduWWWKYlzuzVSKQ/eyj5ynKOKIKECE9eE42//4bhQxDWUjsqSpNdzTMBvb
	 BdgsNexPh3pbWQs10fXwdqHDOf6TM1+f3Cf6EaPJzYF8/tMbtG8Zp8izzBK62w7ChC
	 uRi8NF4Z+L5uOY3HFNEolO8cSgSpURCG725h8Pws=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
From: Christian Theune <christian@theune.cc>
In-Reply-To: <66df5b684b1ea_7296f29460@willemb.c.googlers.com.notmuch>
Date: Tue, 10 Sep 2024 08:32:38 +0200
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Willem de Bruijn <willemb@google.com>,
 regressions@lists.linux.dev,
 stable@vger.kernel.org,
 netdev@vger.kernel.org,
 mathieu.tortuyaux@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8348AEDD-236F-49E3-B2E3-FFD81F757DD9@theune.cc>
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>
 <2024090309-affair-smitten-1e62@gregkh>
 <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>
 <2024090952-grope-carol-537b@gregkh>
 <66df3fb5a228e_3d03029498@willemb.c.googlers.com.notmuch>
 <0B75F6BF-0E0E-4BCC-8557-95A5D8D80038@theune.cc>
 <66df5b684b1ea_7296f29460@willemb.c.googlers.com.notmuch>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Happy to do that. I=E2=80=99ve blocked time tomorrow morning.

> On 9. Sep 2024, at 22:32, Willem de Bruijn =
<willemdebruijn.kernel@gmail.com> wrote:
>=20
> Christian Theune wrote:
>> I can contribute live testing and can quickly reproduce the issue.
>>=20
>> If anything is there that should be tested for apart from verifying =
the fix, I=E2=80=99d be happy to try.
>=20
> If you perform the repro steps and verify that this solves the issue,
> that would be helpful, thanks.


Liebe Gr=C3=BC=C3=9Fe,
Christian

-- =20
Christian Theune - A97C62CE - 0179 7808366
@theuni - christian@theune.cc


