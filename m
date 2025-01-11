Return-Path: <stable+bounces-108253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF786A0A042
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 03:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D8C3AB087
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EAA41C71;
	Sat, 11 Jan 2025 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri7AFX2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F3610D;
	Sat, 11 Jan 2025 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736561923; cv=none; b=hcNXNVj4FQZDPKm8VO8SKEpiBX6Tg1XlKprzh/YJuLckeyjskk53x0p/6rosYFcLMB5HoqgOw0se4YVE2rs7GZ7Ric+JdqO2a9I4mwogujAI8lB4T3fz/xEULvXTMY6aGuvEKZb86P1BfusVaom5bu4zCVrl4Ko9ZRV/dluMdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736561923; c=relaxed/simple;
	bh=3e3GyF7H39P+4ZN09Y69FB6KEJg4XcRpXveQM4qKqY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNrBUVwq4QwDQcyGqfTdKwAPBXi3AbgZ3hTsjVOo5w+JhcephgYwZ3pR8sVGNYQ05PIDk2BruGDoVcj8wNMbZPs2secqLlOAPofzIkCz1AmzU0gKp0Y1HyB4tlqHDyN176g9jy8AMs2OTmrsaVh8pwxpx8TQ1H7kCm2EKQhdHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri7AFX2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA511C4CED6;
	Sat, 11 Jan 2025 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736561922;
	bh=3e3GyF7H39P+4ZN09Y69FB6KEJg4XcRpXveQM4qKqY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ri7AFX2X835DnHMH7aaiJ+5ZIPjcCPXYCs4SeIKByZnO2ROwfx9yH3rnfyYtQzrR/
	 t+1JU6F6/pqr4q40Sj2g7+wyaLsQ2g0FE04IHPUaDqOG+MwyPoMVzveu5Kbvq83wD3
	 g+VuOHKsBugdqZQn6YoofgxXLqoDxklVsZqOhDprjNhsEmgyitO46+A4kedobogmta
	 TUUgiacAmFusSuinC5P+M+TabD3MxFs0ilXnr+TjHYN81X+3vj+PNPTh7avu/aWDOK
	 IWjv6LQnhZ6SVzsp0nMzPEG5Xf00LQjFlfOol0TMPMf1Zg/Iab2LuDrRa+kGUClMtG
	 3zv3Lwzw9OzSw==
Date: Fri, 10 Jan 2025 18:18:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Potin Lai (=?UTF-8?B?6LO05p+P5bu3?=)" <Potin.Lai@quantatw.com>
Cc: Paul Fertser <fercerpav@gmail.com>, Samuel Mendoza-Jonas
 <sam@mendozajonas.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Cosmo Chou (
 =?UTF-8?B?5ZGo5qW35Z+5?=)" <Cosmo.Chou@quantatw.com>,
 "potin.lai.pt@gmail.com" <potin.lai.pt@gmail.com>, "patrick@stwcx.xyz"
 <patrick@stwcx.xyz>
Subject: Re: =?UTF-8?B?5Zue6KaGOg==?= [External]  Re: [PATCH] net/ncsi: fix
 locking in Get MAC Address handling
Message-ID: <20250110181841.61a5bb33@kernel.org>
In-Reply-To: <TYSPR04MB7868EA6003981521C1B2FDAB8E1C2@TYSPR04MB7868.apcprd04.prod.outlook.com>
References: <20250108192346.2646627-1-kuba@kernel.org>
	<20250109145054.30925-1-fercerpav@gmail.com>
	<20250109083311.20f5f802@kernel.org>
	<TYSPR04MB7868EA6003981521C1B2FDAB8E1C2@TYSPR04MB7868.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2025 06:02:04 +0000 Potin Lai (=E8=B3=B4=E6=9F=8F=E5=BB=B7) =
wrote:
> > Neat!
> > Potin, please give this a test ASAP. =20
>=20
> Thanks for the new patch.
> I am currently tied up with other tasks, but I=E2=80=99ll make sure to te=
st
> it as soon as possible and share the results with you.

Understood, would you be able to test it by January 13th?
Depending on how long we need to wait we may be better off
applying the patch already or waiting with committing..

