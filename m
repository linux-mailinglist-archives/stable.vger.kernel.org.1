Return-Path: <stable+bounces-86353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59199EDBA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C036D2822EE
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17ED1AF0CB;
	Tue, 15 Oct 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="HX3Ezwaq"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895C12F5B1;
	Tue, 15 Oct 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999285; cv=none; b=VVzG6/70wBV599ueZF5TiGZ/aTa5OLA5C76aHhCaPRR/5e2lvbigByow/b8Nx//dH7vj0RMn+h6FI2x4MDDSGQeZNiiNzQZE4Qx6b36RyZp0lHPMGF+9oBKd1Y0xNs+BAHV1FRF3rd6T+x4eYAfqJ6LkVnY0E0p1mr+4wx0I+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999285; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=L8xO22sH6Vr5MCwrO2HvMZAfo0KxMgjLmYabtU3/JKn0HXEyv3t4G83zWI4LUGstkZGfj87TJb/GxGf9dNV98aN5UOdXkIsL9vs1RJ5Ce1YjahewELQhvXRAIIMBrN6wNlWDM3cl/DKk0ZNJLgXWJQcaDS/LTmg6RmJazyc9naA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=HX3Ezwaq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728999280; x=1729604080; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HX3EzwaqoMKxLrnIarfarSj484disxTNgoM2gfK7hULWjUXa9d1jFNx81eiGROBT
	 zE7WdXAX2B0yZQlIMafiwpXRphqR1/AnsxB9DsDNn2vK2K2gC/vdIA6vEbJ9rSjuC
	 O2rot8iXYmx8QAKTLcdjt/72Lb/6aObWNQoxMp4vJ08CipaDvtkmSezTr6CNoY+sa
	 +PGOgc+LIDgFQjUaT/FYAcl0JzL2ORSgi/7DZhX641ewDgqSfLsiJZqluoqGEDqJr
	 doeL0bDdiUlBtRMIjAMpxjqC8a5BBkEJSjUoHb+GawsMlkiqz95+TQB2Os0qrGoi0
	 qaIl5MgBhrbgbGYQkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.216]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1tPLHS0av8-00S7RG; Tue, 15
 Oct 2024 15:34:40 +0200
Message-ID: <3f893a75-12a5-41bd-b5c7-5eaf9bb6b08a@gmx.de>
Date: Tue, 15 Oct 2024 15:34:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.11 000/212] 6.11.4-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:A31CANymgpfQpVzbtJnPSr6TWkPzjMyMfBkPtmMTW3obOegERET
 v0+ogP4yj6PCQ8BzjLGeJFNkdjgDHoNGB566TKo7MurEuWegpRkwrglEqqEjzrcfr2akmTa
 KNZ0it/QUbDDLMPa1d5N7rJjHVpHh6kXvxP2v3ADf8g6f8GRvQ98pacuJa5ihtbDjpNDIEn
 igAiwTx35wJSTVxiMLDdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TFEWWmGK2v4=;JVke0K2oX/P/07Tr5j/OZqxoe2G
 Ge21MyUJEyeOWTIKbtnT83n+trtQq7gzYEMqtAObmA2PSe+REyJlSsV6FO9KNXhcM3qvX5b+Z
 HYemByEXJc73SDHUilDi1ZZCpO6F6/bvcTC80Cx6wR53sOYjl+omHkOrw1wRMAxWwEzcMu1GE
 NteyrL2HlbJ8vo0xTZ2lU5YF+KM+XgyvsetuePwgv1NMvgNpe89AEehvG4kz9pwpwGL7nvcAU
 kLh5D3gVNxfa63OnzTOh2IivO21O29P3492Aj4FrHvcnSU4gtMklDK37G2fNbRmJ40o+5Lyth
 2hBgZ5YijTHrVYbZDVgp9/CSBcQXpPzEtdqs8IRE64/7KUAGQ06tKBPb4cRS6yOQG8kgioF76
 VgC/VzTK4D9dLnyNnYhRP+ppxz/MXeG8iRaStCmKdd++qas99mxmM54q4e2PkWyfYt3TlRya3
 /Lf41WIS5hhGlEUaIa6pKc33PMPMp4pzW2Y9VJCXdNPgmi6mrrK/kejSl1arXND087/TTlMo2
 8/2Pt1942wjoiCydaUON+rtSj3nATfd3/riIPibG8xzJozQc1yVPOTzYm9giVSGBDgEfEhmG5
 upzAJn48ot9sXrf+t/J64Ldtei3YX+ia4XOF8oYX+HhcqY0hxQ3U7FDfr9UKVl+dUXLJrt7j9
 XiMaeyRVAGJ4Ftv0rRibA9pLlUgBGbN8nAvI1vjXDNzMoTkUbIToMSQzj1hAPYRh3lzwi+wsw
 7R+BK2a21G6y5ze2juFS03yFEZ0hWrXGI4DcG0REAu5qNABtLBa1jPYs6El5zXDT10mqKKuCF
 hDpAZUbfOm6hFsHJn28eXB5Q==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

