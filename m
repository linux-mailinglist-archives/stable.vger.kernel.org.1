Return-Path: <stable+bounces-192693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22980C3EEDC
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F5A18816FC
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F712D73AD;
	Fri,  7 Nov 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wLfbKMEn"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8801DE2A7;
	Fri,  7 Nov 2025 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503559; cv=none; b=lRvqWQdaRS+LOgAjcvIcpgEAmmRVFGfqh8rouUrWKMvUaiNnVIGRZOcrAJoqpuwoDjyvP9o+9WQDAUCo7MmbdobbYnJgK3sLUCeZYH6v1L3Fn04uIAti+M9x+OWG/iy2AJZyD46rDRGPK7peVZcauojnTYJgrpHPhAtSSikltKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503559; c=relaxed/simple;
	bh=igvuWLrm3Oaj4vFwhWtAgcEk43I6V7dWsGRq1ugNtPs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=s1xLMPx9Z+y59NAvVY5NKpeO/JZxm/ZuGzLOeqEoyfKvGgxKDkcs9oBp59hLVMpFA16yxdltW+l0qUc1Pi7pJwgoQGp3eaDBQhL1tM3g5RsQ0KvOeXVU3nlBpHw3E/mCOMxUu4GcVH032I4RoN9KWCRdVqIYDtcRyrmSHsXXwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wLfbKMEn; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762503531; x=1763108331; i=markus.elfring@web.de;
	bh=igvuWLrm3Oaj4vFwhWtAgcEk43I6V7dWsGRq1ugNtPs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wLfbKMEnMq225+mREsQ3/QmorvkWphPayrqAY4V9O0zktymyOk/LUiJadomtd/P5
	 vlj5e15vBhLOORiVRXkwvm4wcF8xJ9qDdepoqVoh5ItOkb8+NBaNqX1wj8jQoCyeV
	 cvOcHAZos3CmGGoe1oaihAB2Zk0SLIhJC/bf+DNm3CWfQAHMSH/LmL7LgKeW2CF1U
	 1lZe0Uk2VsEkAgAiAuodnbXpPRieLegmg08mNhnlcGAbKsg8GJKDNWVvRBQ4ue+MY
	 c1rJt5sKL+7W6edxhtygwG02MtF2A2mRAEREaPdZUiNM2jdyn5BS9PwAGhyJJHEaX
	 fVHcE2XWH9Rymr15dg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTPQ-1wCQg70FdY-00tYv9; Fri, 07
 Nov 2025 09:18:51 +0100
Message-ID: <1d0676ce-a831-41ba-ba64-492ce797eb1f@web.de>
Date: Fri, 7 Nov 2025 09:18:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-fsi@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251107070931.30549-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] fsi: Fix error handling in fsi_slave_init
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251107070931.30549-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mcha/1MCJG+PHAz38ckF1ZMQYxHS8D0eH6WjvgrBjl4HtnJJLuu
 Wn5uOUG1pastSuPzGtz/SIkGAWGFE/OZOuUcgvM3lBFYoxCLbVIwCPaMv6I1M5MwS1Srhx3
 SJnKixLusba7V7QRUtfTKha0jojsOiSrgy0ZUxUMP6dFsLTzM9pPGIafAULLO6XZYXQ3cf1
 nGIkhox5cUYQbQOBf6bcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rfvK7t5zJIA=;4aYmQlY0UbjiDCHk98XeqwrFVZU
 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
 zFU/w==

> fsi_slave_init() calls device_initialize() for slave->dev
> unconditionally. However, in the error paths, put_device() is not
> called, leading to an imbalance in the device reference count.
=E2=80=A6

Would an other word wrapping be a bit nicer for such a change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658

Regards,
Markus

