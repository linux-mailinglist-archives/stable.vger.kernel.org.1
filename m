Return-Path: <stable+bounces-113101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4FA28FF4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D331884AB9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85D7E792;
	Wed,  5 Feb 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="cCrFcTDA"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1CE7BAEC;
	Wed,  5 Feb 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765827; cv=none; b=OfOut4HgbRldNQdUMmzWHq1uZDxWjLqhJRJJN/nTEIlznHRAl9f2CarT81LmGBj/pQVfBxgFuBFLsAY4RYrtsF4cddnYK5mINAImSneroO87w5axoGKoHoHKBG77EEk6bE4+kzPXz6lD9gR6pdmtzDrv2OTfW1QgDS26P5L2q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765827; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WwFCVPucBhSPtNwd2CQjjuCQz09uKnQg7QxtLBFbLWh0zaZceB610EjHNJ96V4IoOKja9cosiGDBxkRXBZd2XaxEhxLB5Q1btaLwEeGt8YCrvEJbfoPOIOhyxI+V2WE5miiPvaY7lUPAIr4i+hu72Vh+thJjmXBeBHakWMeV8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=cCrFcTDA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1738765822; x=1739370622; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cCrFcTDAEGRBJh2TNJrRW5rNT3+t5g3eBMc3xn6lNCh5DQ4QD6CX9Wb0NVAJCdZC
	 NNSY0BNxeLygDUf3NhZwRq+IKnv1AAWd/X5Z+lcEd87hra4RWlmLyCaFJvwRH1Wrf
	 9RvVqmbcTSxDgfuFVlySjHcRICTNbPp9fnPEEP8Q0nw+jkpBy9Eja/WdnR2K0iGgZ
	 GqpppLfdxwdNYRepq+FPSrY6XLSFUX1SKPoeuevrIuNokasf/0TH04ezfehEFleS6
	 jLTA9fA+ZLtDVaMG/5SFzjsP0/zx9tu9WdBO3AbqtDwtJyQaQErA1vmCGe/H0LBh9
	 rzUG9FHR7163CAHZrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.34.104]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1tgENk1xCw-00F3Bk; Wed, 05
 Feb 2025 15:30:22 +0100
Message-ID: <f9f936a9-1a55-4b4f-a093-7b94ab726a51@gmx.de>
Date: Wed, 5 Feb 2025 15:30:22 +0100
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
Subject: Re: [PATCH 6.13 000/623] 6.13.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YO+z50rx9oBFRQTW6llk4tATg29xkVCXlF9fx1B+Ca1prNIJa4+
 26g7R3TiBVP5dQHvFk9TIaSx9o6Cgvbe2rnzw7i8+KB2drcX/diurNbWtuwj0mg1GmWUjXa
 hnRCjGgQ6mcy082grU2HDR140FYquEem6XMwYy/qQ+7hTXN3fYLBOX3P2XQFXqdishUunCu
 66kDmUEIKl4FZY2mZzIOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b0b1eIE9X+g=;ozl6l71yTyyqppiD2fZ0GLiCZ3f
 dpihhv6YlBZyLTDckELZ68r9SNjWCoyF0aBQjaNEf6X0np+Nwio8Oc3kAcbi70R1EIPvBQpgN
 Mq4mitfCYahhXP7y+gnO0q5zlxKltW8cIUC40gDkWU7qUgif7ddLcVHOR84/nVba6PLfFm/xO
 l1ixAYb6uNJIpROibRjrOCiQA0/QPipYezRQm6IVbFfKGiupg1gvGICxiVRqFxDp2gJna0r/L
 lJePjPzgcZwsznW23azvO6Wyb33vJGfDYPv9GCk92NPkhJUnByJsJJTE0aPFKbA+1ZN/1XXQW
 ZcMvQCcHxRrkuxRRsJ2UK/OLbf0vmWmugGtwFvx1zEhJIG/nLiJISYApkg51QtcKyGZHeSR9V
 t7eNYJomaPmw3HZg7GqzePxdLBZpJNLpCLPt+GfIf0tD0GT1sm7Pp1fQ6fWWSZV+jHQP8f8Lr
 mOQIXnQbS8ueqNkRU78S0Dn8y0/imI77ITQ6anA4GFKybermonGrGkCCAwBKkU6xhXDJ/JgRR
 kv02cQy8CBL/va+7rYGpWhdNqHhxp1kaM5aopSS3Rliek4kYx7ZxoqrfR16ON4FRlYFhwKYqS
 QCzmnXLwDFLzLQCHL4h/wUq/jPNPqrGesGTuUaCWoaTJkhaRBt9xFCqSIIFgyAlRU2oovx09B
 5aMgCay5tyeA0kuKkhzXt82XdG8U/TdymHGtuf4OEjTLeYvnLGbfmdN9ighBHW8+0ZBePQL2N
 MOHQ+6Lq5VjNCYjbTrDhSWuIhmD/WSrAmWOvAkEU0f1hpE537uNc8aXxaobp9UHxVF+NBDDhL
 3qg7DL2uXdl6uz3nXbOMB/3EleWpBqofJgpkM3xoCAwwFNk8wY34pIluj2mtWp0JfsS2KAx2L
 /ITtwlcZRRg22dThMjB0uTCloh8MkglE0aPXpX0E44/HNfWDKHWtYGM45vIFq8gSeCvRvPV4a
 0/3dHP45J6EJ/MDlku8PBIDkJOSYEK/ZC0/dGeqlIctxPeo1JBx3KHtS/Q1ZqBkydumQ13n6A
 NBZH+yCU0y9Zfo9WKHLSYFoMDWusUYCqKMcsamo9kXsZ7/gHr0W0ArHuXt1355EQYN0yyWLtB
 jqFhKQ/7Qj+TutvsoXNRSseDY+65g3rYGC87oRGBujhDxOxXT4qxsJ6OtjFrF19XWv0lCfj1z
 X0nUYpGXI38HhStWDE/RVd153wM8y58tO5MbyIwJjyc1bJ1ADoYzTKcpEkl1cqW20jqnYTwkd
 0xC6gX/IrFNgBtdf6Ij3nirFpjY5Cg/kHFvk2tcSYPIb44IxTjmgZwDR+wqLe9G74MeNgJbC8
 /Vg0MIktoweLyHEVMdUk90CID7oOQ3QZYyl9Tul5KigLUM=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

