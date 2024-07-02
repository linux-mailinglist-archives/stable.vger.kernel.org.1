Return-Path: <stable+bounces-56886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8272892474B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C811C22BEF
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39D1BC077;
	Tue,  2 Jul 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="VENatuot"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D811DFFC;
	Tue,  2 Jul 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945072; cv=none; b=fHiPzbS7+YPPfqEH8AVtGh1bJGU1RzaUOU6gghplqoVfgE6lry+3E5JnzbsprzyBgRuDvibIOiwyl+a/tSHzPVJMWY42+3+Ek4h6wm2jEfA4sJq7R15bNWbuo/eti0cFf32pK+20M9yStjfUPBHJvFy0iXQT8spwI8isa6WjBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945072; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=OHL6VhWQYIMdnnD1VsWbmg2C5CZIn2m+InmmmdLdRALcAIobI3P1qZMKps5SNY4fWAWggOUD5ndPJ/TXA75EVP4HswkA8k949KavoAKnDEy6jzuBBgI8DWnQISfZe7TyCxjD9Gmx/2ucQHgMd+WhtOS2YD/OBxWpMM8AdneZvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=VENatuot; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719945067; x=1720549867; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VENatuot4QSq+5PzY2kYnX0DMhL8YtgBp2kwlLsdttUo9po+vmhbPsl3HLI+nB5W
	 VBWKBVdhaJbmNlKxBvTzTxm6TBkF39EfqkHoP7Or/7YH7gONClMYLP26E4O6T9Abc
	 zRbASHqkU4CX8b4EabTTLDEobAV9T2I5KMZLFqGQHGrASQol2Fy4BlYTENnKFwiUO
	 WUQivDlMtHheNgxcmSMTKmWL6X0SWeHS4rZ5nRyjz0nGu7KMQDHA0+EsOQ/onWdR/
	 6wvHwvVf57I4XwtKqTk4Ip9c0b3LjuM99zFE21WAOc1SP0hDf4Mw5skOZhc6zUJcX
	 FWh+NjhySXjTHwWP1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.216]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1s4HYs0XTp-00bHSd; Tue, 02
 Jul 2024 20:31:07 +0200
Message-ID: <bfb8cc56-c5d5-4ff0-a5ac-aa88b457ec51@gmx.de>
Date: Tue, 2 Jul 2024 20:31:06 +0200
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
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/TGTn60IyYHI8P5OxPSfdFIm4ef/rir2nyzeR53PFXPpl9pW/lk
 vgKAWeW1vngoDvsaprg9zzEERDUoUuyrcqHjtBgVpvm+weV6BbHP6q6aPFAmXKv+zNzof9l
 tYGc+hp2QSfzl2CeoYig+fcGZhenKxsMroKmwKcqoncYkuY1jIuokdPZIFmij+Np2VZUgif
 co90nZw+dq+x71coywqqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j4fI4vAFgE4=;2jkU7NbtmSx+6+M4W7AnxiglC4/
 oEDPMB3Ppwlni47hL3mQ9IrbNEktONPcRuuwriZkmJDKdA1aZ5b3Ni0oz0VpHwIkNX1Fr3BV9
 5cLAUNivOfH5lii9czuskZ2mfjN+Oyu8I+xnLNf69EckxfNf4b5blqnBNbIBDCuit1h/ESkzZ
 BIdILd6jgK1z8y9yrS1Hv/3RpfJVbleFqfLVjlV684OaWvF458dPdCXJt4KVTfuIaIuwgUp0R
 MeDxdetpqBCi3XdMXBJzmEGf70o5SAQsx3MUwPSY6Kdwpdd//hWAwN62uEw9l+i/nn7YfXf5/
 BNXsEgDNbXbWqlVPNXsnO5EVkJc4M/nSNyuAeOz3YFx/mV6e2AVgP1aNt74AlaCunfuTV5Y01
 LNtWA7WWkC865/XI6PFMtwYyOA4AVLL0lx7ieDX82GTNRwAjUMQSCrGW/bWaHumRO8zoR3LBv
 0PHTV48h8ZM5LYO8WQRndkBj2EkzH2PJBynQfMySlLSmznV+EUyEtumk0E3HwUrr24AivDYqC
 laiLU8JutWIMP2Km5VA/64NbYLscETDbZG4mnlYAA+uAdpFrBHPzpOoP+fWX04fvOWTi4C7Eq
 cF7iadMqNoWN/yFpujwmZV3L28N/hSQEOcWEFQWfvfNN39pte9x3eWgNE0tMfXb5ND7y+hyBv
 tVsHKqPQdSZoDUssYvfJ7clfGRwawkh7ZkmQyJ4y9sJEwqdXu94I9UiCFI0UwbTps+lTYLLu+
 t4/My4uZO+oXWRA0LYYPoQCyZCUd345Ytwsx/JMmSbyuZq56ITkivyGW1ZGCrb7rTBikS7Usg
 AHDf4nO9hXIVZSZubRgFpPQBAWfi/rBLjoelbFi9Z7yV4=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


