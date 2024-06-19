Return-Path: <stable+bounces-54656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC2E90F380
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A988284BB5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638715B150;
	Wed, 19 Jun 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="HWEhxZid"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA03FF1;
	Wed, 19 Jun 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812389; cv=none; b=NbRBxAhUwqB+xIGo91B9Gvob96onIY0OvYV08zwe6MzT3e1oHdq57VPUif5hmlUSjG18nQzwpeQlH9yRGAZtEuRwgLai4pCOD9PTmZH94BtskJwKA2Qt1XBdoaorvXPNVXgV73RWpvf5liHUJC4fLtRCs3f8q62NWd2rAkWoYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812389; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=dq9dzGbczenGlIXMKjfwP+loUW8hjtFOA4sgzr9v/qj9Rk0WJpoITetkGurehGgX+MF1TXJaA02sykmFlZM0Pc5bhWwl69YWKAO10TNYB11A0xGPQm9rVjM5aTwx5WUipf6dKhNV9BJh0fiypAlad54koTYZTANnb1ZVOhgwZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=HWEhxZid; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718812384; x=1719417184; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HWEhxZidUyDb61BMCpECbxu0jmVSQcepqfEso2FHaHXFcAzj7jDvtvvE4NJep337
	 vTo9+tGXlIeYQrqGMsvoNGf41UKQ1LcqerZ/jQhSluIa2yFOG9wB6qVAt4r5Uvjvj
	 wJu2THyXBmJP89kgtgBCnI73xHl7YJ1OMDAIXnF93jouasuanpI6CpBg7BCE/YD67
	 HVFu/1exzczqmlQSer9H1SgvEMv4Awj2S0OLU6FvLRWPr55iamCscf5l/Lg/RWQgX
	 GOtwUuuYgPRmEG/h/wUwknI1do3+kiSGLLqGNbGLP3meSnNPJVgQYBmtpqHMN4w9q
	 +VOqWzAUolRKW5heCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.141]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1suewf3pr0-00cbyg; Wed, 19
 Jun 2024 17:53:03 +0200
Message-ID: <c81b02c2-9222-4f1b-822b-974c75408bbf@gmx.de>
Date: Wed, 19 Jun 2024 17:53:03 +0200
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
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KkYLWqajPsFAzWMo9i5hTzoVqT+0OLWrt4ql18tjuKF5FpasL0l
 7FLiL0im0GM/ufioxxjCE2dofI01riXsnKNa30v0isx4H7n+P9Knx/5+Ku5RIWpG9OWjXDm
 sStkGDm2LTMPP6p1CMgWtu0vL/ZOlE3m/Oq2H+mnEZ2F2yFsBD/O+7YpLXoemWPAq87WkKg
 1ni52Sa9+XroDCThcdh3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SVvc5PLfhvs=;oxMkguzMTPv2xhWtZODp/BzHDZA
 xxQfKvebN7PSZfBP0QqmoqIPyACkROxSWRaD22ZAIKI8Ajiqo13T5Q+mwHj62TdRLTt5vnwk2
 abUY7aSBro6c+ibPqH8h0DQmWTJVKH2zlv1OXrkTS36gs1SPLuP8QT6PoE5J7Yk6/tW52/2ob
 GNJej1LZGL/dVoddNqxYdEevQtZ7bjGA5qM6JGrfDj+wwjcieDTDuxI+aoRqjBVgF05106uuL
 IDUwgYy9gmTTa2HNKaHKfrGIEtdjdCDzlU+7nwz6ZSCY4rf4T+4O65N6JWNMjrBtLUEuTT6kS
 XKns/bh5Fs42JnYs3R6hD74prO+SXOXokH7HawNCfsRfxkZuLyjECHrKuy/EZ1FTgHbmAXqZB
 +oP0ocijhs/M6nJtEje3tCKr8gXZkSAwsp7zViVRFcExWXOuorInX/DrEIXOlFby/Nox4Nk1v
 TjCvbxB6eXqxFZiXpI8c/Li9081RzQWpl3qd71F47W8dv/VeHLFO3K+crD81/VaB+GEDkWkEj
 lg2QDSiSiTpZ6d7YZnGv7wbiQQWtY2JrVLr4Ajpe3OwkyIlpLG+RGByMMy+OSVxVKs0uVFBdr
 8YOSiy8+3xSnuJ8Ogt1HEK9bReVgNKDuu6B2QkhJrLLUVIE7ycuL0y1mW1lUldYAyzXZMOWPq
 S+7RiE+blMH/1wD2C6GtMIg1qi0ruuxRGKBtVOej0PUux8SVzqGn3GsRd4+OIRPg9PuHQ4Tk4
 jGxtKvSGeqMgMZN56A06qLNp3/hxPeoWmhIGjznDykJHU2oNAbHiZodwqg+vy2tVexr2OYpnH
 QucMQ1a91kflfGgGmsSAlxNDvj2xFUrCZgBItcdUf/+e8=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


