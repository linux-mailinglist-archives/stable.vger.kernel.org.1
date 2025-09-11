Return-Path: <stable+bounces-179301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938EB53B5A
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C61CC590C
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01273451DF;
	Thu, 11 Sep 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="WeeGD9P7"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC561DA55;
	Thu, 11 Sep 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615310; cv=none; b=LqsG2nN3GbEjnkvzajGSZDFHgWPOdL+ugc/DpOpocw4lcJORO2RugwFY1JMKoDhchcLJttf7URoKYRIU/hxpSYUUK/UhuSpQRoo6qWrNSDMBjTSDAwp6Pf9sD+q6qb+kLPiEul3/SHicdlE6dXwLUL+mtCaq7fpCbPQGbii4+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615310; c=relaxed/simple;
	bh=fU17BlJqP+JTf2WgZvr+C25w0Q0fI9ElCxG01p6OgIQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=OAQR30QHOoMvgOCmJfcQKvCog4bezi26QEEf1QQNudTWln0AZHwIYq2zEAvsKiYkm9Cd1pA+C8WOwq0CC8+xjvalItxUqBFWMKitdeK30bvAaTPebQjkb6YxueOgPa8obPkhNG6NKXPormrpeEjFRxyY38mRsiDXbO3oZzA4rbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=WeeGD9P7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757615306; x=1758220106; i=rwarsow@gmx.de;
	bh=fU17BlJqP+JTf2WgZvr+C25w0Q0fI9ElCxG01p6OgIQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WeeGD9P7imVjeZRCnx4UB1JnDvrro1kwzAHz09qwaFHOd4O0Jb11Gi23/HQIpOwB
	 zBpMc1nkiPk5ncBwivzJ7XZoyoF3bEwf8ztXW+uyyRaXTsPFZnvKzr11PlSikDwh4
	 i+6oOojLyqtE8cEpvTfZZdIhz4seCDAwbZF/euz76770/uwS4sfqPSbXiy+Sk4tn5
	 A3LXhawKkhft8hfzagqnQNOde5yEvBFaFWeoWcgdE4EVuevUqUrycfdQcFzxqDgnV
	 H+GaQ8o55jbUqCGU83MwaUWdrhwDusAqK0NufpsiwsMrOupvW9u8crJwvqGGTANA/
	 PPBqrFbKnNhi7nnnrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.32.170]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1ulpmz3Pw0-00KbAe; Thu, 11
 Sep 2025 20:28:25 +0200
Message-ID: <63e8b619-beae-42f5-a79c-62537b84a5d5@gmx.de>
Date: Thu, 11 Sep 2025 20:28:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
Subject: Re: Linux 6.16.7
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3jWUavsTV+V8W0gmvbgN1zmcxxg6+Be8DDM2RNdnVYGsOGhh32h
 p6cHxFmOczoZOAK1GoKTGOcENbX1Vq9qSxMTEsMPaB+rzANhheiMnJn/0GHxPMpStEr+eyy
 +DtQ3Y37En+BC1WvHMNdu+JTCSq122BgUhuraq+UUXNOMcFDd0hVQKcMrMqQax62DR4G5RW
 meIPEhtUlkS9u++m+ZzKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5U+vG4/RV1I=;SBUKKj8qd2H2bB0UwMs/rd5huJL
 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
 2QcmpQT3R0xYkyIYYis7tfQSANcdOLS3J4=

Hallo

...

Urrggghhh, fetched the wrong kernel (6.6.17 instead 6.16.7)

sorry for the noise


=2D-=20

Ronald


