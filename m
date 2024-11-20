Return-Path: <stable+bounces-94425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D409D3DC8
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5971F23D27
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FE1AD9EE;
	Wed, 20 Nov 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="QfcO75i0"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382C19CC1C;
	Wed, 20 Nov 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113775; cv=none; b=A0s8XHICpa5HHlWc9l+pJMYCKojcURR1s4xo8t9AnRMyyFbWWN3Mz5cEhcu2yuPk5H4CC7aL65ENOvuo9/nO5q8v4HyEuGaNWbwTUWibZKzrcbjYQ9G1Np5RFtdG/WLrPk+ZTLOJuc88RaCyPKUQEE3m3OXt5Opm7AGb7gxD5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113775; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=jUqTuN7dR0TIWK9wF61glk3ofVyAQIs94kR0/q6a+d92BaGDwlBBtJ6WZRYG2kXydT6RswheH52xycjcdXyA9kh25M/xDQhuZpN7jWg3VycuVqFnaxC+Yq3OKQxqAAzslG9lRoSGCNXCx7ohIZz6NVMVx1n9DmNPxkyPZCD8EQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=QfcO75i0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732113770; x=1732718570; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QfcO75i0A3szhrf0bBdIcfSzGJluIg6/P9NXQlHHJmESh99/MoUYzC3HbzeI44V2
	 izvBv86ZsvyiMhoE9oCOUUqKslNKQMXzteVeoI5jGXtRqkmQ9a+bbO066THJ0YnpV
	 B9rr+XfcYTDl1o7m64E/QSuto0bRdAQOQ6gn0MpdriI9PPK73q4bHnYO0+TJh1E6u
	 17s7B0oGC5L/jX7baDGuFo30dOSGt3J8c6uB4qPI1ARUPFqlRFx+GFNf4RANrKzDx
	 NUa8iT0U4Hrxp41RPGtfRvoKVJseqM1E96rwQRcXpSqbKNwacxmfRg+xeIZaAvwqR
	 L6BPC8hCig1XugZKeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([87.122.66.64]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1t31Sz1nYp-00ClPL; Wed, 20
 Nov 2024 15:42:50 +0100
Message-ID: <61e345e1-f31f-42fa-99d1-b07fb97b4ab6@gmx.de>
Date: Wed, 20 Nov 2024 15:42:49 +0100
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
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OB0exUhYnpH2BxYfOpppEmOcepbwKQXdIrZDdNrNkqsWe8Zb2QM
 d548ztk7vttpXW8a4dIg9X+J4q7AuJWhIlOM8+U6P6vPafK+IWD7Urnhja7sT5uB8atGZNO
 RphfRqLlgNFpPLQfSzOVZjgU8DaVGpMVZmxampu8ZyOH0DoETqkuQqy9zIOGvOlc1PO5177
 XAuW8rssjajfvqFdSMd5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jbvzid1BgMA=;op387Z+/GV2kFZQ3IG9JrTTukYv
 /iTA0h238zglF7FhehwISfp9lelcZhXR5yM/ANFcMu+xTZSOQ5yICOqY1kedBxPYFSZTJmBsl
 OKN9wXJ/SGsF5Pb4N8U3gNrWBnSa12CFI6hK/280ntDbTW9zJDGe+k5Hs6juTOJewwFmrSVr0
 lDRw0bBJ38lOvIehCe849Fz4bZ63pJKCo75RhZidMjG0pst+/yUwCYtBI5uQatnhrU6yj32x3
 GDeiza8ZETf3VS/sFcND/sa7wNznG0t0D3yjHiTTvAgKtFlrBiOSYOm7kyW9r0aGxKYiRVmQN
 +YYZncJnHu1PaG+oh8HYNH17DhnNGW+itXHL4YA8yzxWl/pPFD9BdegZl6aGY/uIJIaWHSjBw
 8lmmMm7HeYIrYRD99GLbqH+l46xl/mBGy48VeApSgF0TtYbAhqk13ysytONyXaS03tVV96TE1
 7CAAN6RsB0QsDkybUNnWEptQx9vllUngx0KsYP1XzVxgznX/dDH2Qm3W2bfY/3qFGarOrTJfd
 YRH0WZY6FsGbxguu1N/mEs8PLW66hc3NJzNp/gi3vjUYu4zEqsDnaQxgvHKEvXT0fx0xfNAQ+
 oINLz9e7fiQ9C1XHNkGzffhoqwhDSF64kvMLwzCpR9B9sWVqlxqhMTNb04CPSA/61nk2pztow
 S8xtXFuAaCNtu0tw2mkOcUQykqZlBNIWtinV7w8ZWiIN745bOj2sRXVDeevTEhlkcsk3z/Zvb
 KrHoYDakjxISunOD74AYOm4AjqYNY06768rM3r4FcszZ3WCL+eVFtq/h7garF6qo4wHVTAf3B
 Gg1bT73fGxg5dl8FUD+OMxKygHeuWMhOI95vVXMhJM+/RDaBpLBKs6hITby9sXn9ZtPT0bmDM
 qeao6OBhUygeiFbBLnGmrKrXLAprwjkSzT3HTSdCsjMVu6zsL0pVvaMWSMa4vY2yWdUgROclB
 QoTyHZZxOc/dxe+DxLWwRLCERzdZOR9mSfFy65AdNvGsi4PT1QWwlso3EhYzSSfjqnzBDZloA
 LiZQ27GQrme2tLq7QzbihFlNsUBl/Mm1IsBqMolASwLpmo15a8phdip2y9X1e5GSygpdzZVFL
 kNlRONfDA=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

