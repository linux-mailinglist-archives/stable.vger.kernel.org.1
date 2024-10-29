Return-Path: <stable+bounces-89151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2EF9B4010
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57111F232E9
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E364EB51;
	Tue, 29 Oct 2024 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="BglMeqjO"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88C1863F;
	Tue, 29 Oct 2024 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167253; cv=none; b=oQqHLZRHpGdWtsHyLmZHBtaf8TmK+YXmYYXRNSJfJmvs4MBk35NrhR1iRNL4iv+i0bvhISQ4cNm0JdXqvRZnbnORcE/KY4384CQPAw0SrwLN2ErPL0ndoBCo1bc8oUtwp35p+NL9kMyFpGKkkAlWdgZeojYpTIEKKFwfUOTDp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167253; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=t+R3NxfyVbOX7bW0d2CNL9ZfgbV8e7Xo5K8dBAP1LjtWUN7VuXqtfuW6nNmlRkw4KSQfTsmd8a/LV0NbJjhKjqeANdyQeeu8bt1hUANQKl2yQLTT3mkOpseJ/ulsLRn2IxDRma1AgI7AJeLwyHKq1dq/n7UNNPpgLU186kaEYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=BglMeqjO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730167248; x=1730772048; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BglMeqjOPZcxsAADA/VSoRqak3gzVsmMkXme5iGKRtxZ+/LhV6zv3cFA9Jd3BuYp
	 qu7NKvaqVBlUh2SQ/pq3rPAk0tlYD8STieJVPJfIQdE4QN+RXcSiPdUt1GJAmL3sa
	 nfzGnEJLE3sWXeszzjd7T78UhmmLvAJId+LZKkvEkAHixtFVzGd7yadFZlwdLin98
	 yyUB4hneeYTr3GsrO/WAL3l62zv8hgKTv3iHMzY9fwGBzLKYIpazw/YVtsJzELp3L
	 tXxe6L2oUFhaxsE3T5HS6owce/gfpAfiBXBKTUTKL5CFWSVm0NZTFE6H3h7REcijK
	 LeOFKtmjugwctKN4Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.5]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1tHP6R299f-00WrOp; Tue, 29
 Oct 2024 03:00:48 +0100
Message-ID: <e5057671-2c98-48a8-816e-c644e17e9184@gmx.de>
Date: Tue, 29 Oct 2024 03:00:48 +0100
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
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ejoD0ztnRC322ZK5esjv8BQ4y79/n7trpz7bvb9sjInUmzuYocF
 D+ojzdccl6um0W/kC4S3bnEAEXWfGjPMHi97kIVX9jN1V9sPrP8K+nrD3k241wWEEdG7lzW
 VfZN9FHmJSfYjw+vLfKQnqIce62rmEz8iCTHqlb1h8KsauB7HN9t2VtiFfmxKNiK07H3I1G
 3H6tn57tNoqT6QAMACTrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+wZuekbK5kI=;0IlG4dAfaW5DCP3cNj67vB2gQwk
 1KXe+08HAaCqHcBlWAzywXEpj//uGFlKTtK6lvUZ/pgAahht1JLnR4bgAoWXeoT3UFESoTZ7Y
 YtkV0LafgJsnnaMK4zj96lODtfMjBzGILqO7Iv/tVPVT3rKZ6YkyVH2aDEJHSV2O32Zc5Keve
 D61XZuzrcCkhUMx8GmlZoRyamVW5ql+E5N/CyZuh1JPbglMX1JGDRnu9l6FzTRn5pVlpkj16e
 0EK34AyHAXiqnhlkbYt8Z3NrInPI8WEvnB1sKxC/BQ3bLT7hV8fifz2KhZshUy0nhPoXgqwf1
 90tx7fiawmN1y1JTmjrR0BpqTAo4qoJ2xmOPSJGLAjJBybc/exlNetNg64dVXBYR6R+o4c5Kg
 7ZMEX0+09wjvZmQTp4hOQrZp/NYTKEfXQ3cL6tPrM+kTq/A0E2hE3V6DTryRaadwgEUMG8qku
 m5GuLE1DAzR/xmCayea20wjp0RdJCpi4HKuBTaHzf+dCXD5aiYBrAf7icGDteMUAP4GNpU02H
 Y7jAf0bEu8y/xwpwAe9dUixKdWSuT46t0zLTxZ5N+RNccvU7KybMfKIuwjt3qxITEXnOcW1sb
 LCk7P1YUnR1tEYj7ntWgSoOLEgNcu7HBH95pl5Kba32UDj9OYPj5aSQB4GHdoQN91085xppP5
 Tuj8TP6KjVyEjUjc3ueu+wkyLW5sMlRqr0DyjGVJ8D3WjkG3aZAadzXEdEmGgbCFO4w/KohqE
 oyQP6VposCPbf6n9jpoDIBg6Z0kwfTDozH9+uNgRyucEQIDc+h5MxgWHGUKdEQsXq8D+3jptM
 fQArsjUBxOfOHBFKAT8WO9vQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

