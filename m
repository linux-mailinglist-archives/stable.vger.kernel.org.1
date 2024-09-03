Return-Path: <stable+bounces-72771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF99695E8
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 09:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED85D2824E6
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 07:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E01D67AC;
	Tue,  3 Sep 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theune.cc header.i=@theune.cc header.b="9RS35FQe"
X-Original-To: stable@vger.kernel.org
Received: from mail.theune.cc (mail.theune.cc [212.122.41.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580649654;
	Tue,  3 Sep 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349559; cv=none; b=eTudpX2gqGg/c1w8tubzhkWxy9TjVVQFBU9FUPxJiJCZvsRG4fE5sx/Q6Dv//3pwKZsZges5x0HzJ2WULI61eNmgEJWzurH6LWYe4/K6d4igvcGBX6Y/NrYSxSUCnDu4dY6FzAC1Jrgkn9VbSOJHT0DUxj64yx8aKimLyXRfkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349559; c=relaxed/simple;
	bh=UQbVf6OKRCtWOwlejkZMkhRvD/SZFgavXNfB/+1B94g=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=JgkobMFxmq4kw0qw0PFdLE64t7btvvMFGqh8+MrC46D3A84dnR7Q1P7Z4U24luIEEjd/IsEthhFMbtgU9JIZrQk9i8wpIhvcFj4Yoja7mm2yJjyrCSuEBQMScfyH9UQlkDUgRviZ2co5WjNsvyLShWya4/h2+3VJXiv8dLjim8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=theune.cc; spf=pass smtp.mailfrom=theune.cc; dkim=pass (1024-bit key) header.d=theune.cc header.i=@theune.cc header.b=9RS35FQe; arc=none smtp.client-ip=212.122.41.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=theune.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theune.cc
From: Christian Theune <christian@theune.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theune.cc; s=mail;
	t=1725349071; bh=UQbVf6OKRCtWOwlejkZMkhRvD/SZFgavXNfB/+1B94g=;
	h=From:Subject:Date:Cc:To;
	b=9RS35FQe8yhCh1MeaHbIsWvYfhvtJjJYdy1rH5cMMCnCd4B6eizhnx12ko82U37ro
	 SJsuea6OoSCMypFk+dV+NZ3uCu9bpNmLWTL5Zmh91SeXSWC30DGy+RGATA6GC4+OpG
	 7W7nKOZB2arrpm0UVCpzqBYGrTwtBL4PiGfic28c=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
Message-Id: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>
Date: Tue, 3 Sep 2024 09:37:30 +0200
Cc: stable@vger.kernel.org,
 netdev@vger.kernel.org
To: regressions@lists.linux.dev

Hi,

the issue was so far handled in =
https://lore.kernel.org/regressions/ZsyMzW-4ee_U8NoX@eldamar.lan/T/#m390d6=
ef7b733149949fb329ae1abffec5cefb99b and =
https://bugzilla.kernel.org/show_bug.cgi?id=3D219129

I haven=E2=80=99t seen any communication whether a backport for 5.15 is =
already in progress, so I thought I=E2=80=99d follow up here.=20

Today we rolled out 5.15.165 and immediately ran into the same issue. =
There=E2=80=99s at least one other person asking for a 5.15 backport in =
Bugzilla.

Hugs,
Christian

-- =20
Christian Theune - A97C62CE - 0179 7808366
@theuni - christian@theune.cc


