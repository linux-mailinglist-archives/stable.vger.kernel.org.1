Return-Path: <stable+bounces-60362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE39332EF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 22:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931F51F23CFF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A019E7CF;
	Tue, 16 Jul 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="lFC89okL"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53B249F5;
	Tue, 16 Jul 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161573; cv=none; b=Vf9nAhHfRFrLrfVrQqCK+9UFvVbuFVc02DVTV4D5tzyTn+naA8ETWchR+frSrTyt2k+zyvSD86GBCucD3UpFdQwop2T6SuvxFWLEG3BBrSCdIRskIf1XLUqmkEpyYeHGCD4lckF0KAgjkllu9VV5EUlHgySWvIEX+yapbMWFuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161573; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=j7wfzc50CE8BYOFfc3oaMt7xLhzB4x528sQIW4nLkKxu5BDyvPxi2kTYa9X8g5iQ5ulZj4sWpB6rO43v9NAQsvXrwkXoU3Rn05O26dPfZZ5Xtm0VIqd/xZ81Y20STfTrdh5dK/oBKqiZy9uJsg5DmhQW24QfS9xP8PbwmMGlxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=lFC89okL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721161567; x=1721766367; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lFC89okLcfkdzY0PvAESc8o20+l7HgVLZEKxFBAcUZadxiHHwIl0c9D5X7elIQi+
	 fQUveIeMbiBoDIPp6HybcZWtue6XZWmI0Z4tt13yFp2XfioU581UA6kiMrs++jn3O
	 R9ZGi4TnpkZhaY7p2pSgsH1xAalfFI0AKgSNbiCiApcp+J8SahNIl/bgMW4iSzPU3
	 nBs58pePGtSEhGLDnDWoC4FfHwC8nRyj9/2U1ERq/IPEc2uQxa+Dy4Z2rfbnPFAV2
	 Xy8RhcZVatw55Nu7DA+Lb3gOhbj9wXh+eTok1aB4GBJU8zc5SQ+VfibYv8Z/xmxEN
	 Js9bu6IZEQ0tENKwYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.108]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1s7JkK2kLL-00zzvC; Tue, 16
 Jul 2024 22:26:07 +0200
Message-ID: <47ab290c-b3b3-4107-b8a2-2346f43ea42d@gmx.de>
Date: Tue, 16 Jul 2024 22:26:07 +0200
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
Subject: Re: [PATCH 6.9 000/143] 6.9.10-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QL0mXEiR7FiYIaXhpbdgavibzZ+ThLByVjVAziov6TKaPNJvGdf
 Z3YVAroMfcgERSze5prglrj/hVVvfA1J4aAMO4+tjB+FnWnPdftDU1RR3bGnZQhGj7JPIer
 WJH0oel9EJ2ykcinRI5G2Sl1nvxi+8EjghXklthgEpvZFF1UhJACMvJzNyEx96Emhbd4vow
 BcRd9+ZrpH++kltpUnFNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dOWy85jbSlI=;UbRVmIpVcy0gpA+C2geST4Pt3qp
 PQDVjooYTlf/X7pZfcWHFJznJDK7YBNXiY2xiUWCJ+1NQ4Gbu7QKLnQ3zE2fUN54o1U7VrqhX
 jhUZbQB4Yf/N2Tz6UbNncrVNcJPBIrHFZnbMp1feTM10uvnv8WcecsonTCJm6wCz5RjLWEwTC
 Qt0jtTuHT2aCoqu8RKYeDShAtjZJ5/O91t9H7ghf3i3cxFxxlT9qzlerWgMp8FjJuesBeixFd
 ONZQZc+cGbCfdRLf38mOsc4Pfo3KdpwpX6p4P7I14hRJFFN1ulgtj8gc1kzAHYiZVSA8IMiOU
 6jsz2vCMQ2FElYMnTITiBjenB4fftrAH6eFY48nwD6Dk/U6ZTU6miUq1vVisqIPhf0KBAA7mu
 iStBXyOhOPDBJo+xdpRiKEBmfDrZs0qoTGr3mwxkPUM7esALBaauLj9JFb1ZRxA/7ldJEOyfP
 V9HAPKDH+K5yKMPCe/XmWZ8AO32D6bJ4F7bPGW4rDOJQnRooF+xAiQLx2T/9nIkG0R15Up2Pg
 RCx9UuqPi5ag2xNeVfnB7aI85d0fN4WQfEnvn0jKvwhSj0FJEKN2hjfmSNb8LHSSye0ru8RZb
 9If0XTn+HupEewojReQkEX6My/+FP2CTVziTy9kkrdDdtAElxe4na8ymzCHY4bK/FFtzdyFRQ
 o9/BfBF91famC4x0vDRi5hCaL4HNGNMkplxkmp1Wjfck1bjHXnQf+BOla70XBxqo6mzgBd4ih
 xOK7KgtP3ObqjZtp/Vd1OjL0i8LvjVE9yuIth0jJXTn829GTEhqyObpRKEQ+3UjyMEF+cdLW3
 O5gzyNK0hZfhD7S07U3u88yA==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


