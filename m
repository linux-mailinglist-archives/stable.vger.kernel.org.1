Return-Path: <stable+bounces-25278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A7A869E88
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079A01F27353
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B19A4F213;
	Tue, 27 Feb 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="LdPcER21"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAEEEDD;
	Tue, 27 Feb 2024 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057031; cv=none; b=d5cRm5VAcQ1er+7oodnxlHxbOCH9hXnH2iNWC0tHh2KPYIGtuEkazOlRiYRaJ4jvCAf41ydCAD2eOktnDZNz6k3Eb8AfAkkIN9HXz8lUTTLwh8nhesgfoz6n9CQCnEY4iPNBObNr9dBxpYf5Bz0BTLGIJja2xXmkZS6ZI164WY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057031; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=XtvGynPG73P+xCqITvo2PrSRiL7b7xe+xDrksh4/u5csqXD9dD0bWp7FHYvxwwuqNDRbtzhZDE7xJScQj9pA1HSIW1jttpKc1XXr/AExgGLSVb6AihJgCNmEZi70f8U7JiR8JdPkHF9b6AQg7zJMHs8Vsveg0jRyM3yqjkec9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=LdPcER21; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709057026; x=1709661826; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=LdPcER21e1OgRbRUHraPYNKN3kvMQQx1XT3prCz7AsJeDW8IYc4+DBtVnc733qQp
	 vhpISzyW/7TpUHFfJ4XvosYo7ETw1y1RNCxSZLuKuMNposGch0V3h6pNxZyKHe5/r
	 /+YXdvwZFc/9QC696rFQYn51ac3ayHzdDipI7IkEsag1a0dv9pf/7r1MqzLEwQNXY
	 k6UNf81FDHLHsaCkiWZe1/rDdEalMjNuy9tzLwlbMG7RM0OZx9TPutefCBAO7pFIK
	 ObznwIVKjyUYbOq0AeSom57ZjZPRZnhwCHdVz6Khi7+3zhyDvw/VS8NkEIkEIA/vb
	 hmSFbcrRh6Ds87Sn/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.255]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1rbjUD4AbE-003OOm; Tue, 27
 Feb 2024 19:03:46 +0100
Message-ID: <3c7a1942-44a9-4211-ad5d-53bd7f1ca7b3@gmx.de>
Date: Tue, 27 Feb 2024 19:03:45 +0100
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
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bVmj9tepv6wPyW6HA9HBKMcNO6C37FkNuoJcQNkIvsBP205SgEn
 MsoVmdeLzo77beZLT8UZ8yJOH6og79z17IYdDQWb9L9EUs+kYsuT/FssbaAr0KtH1x+ntm5
 pqTTeYFrd/Cb8vSK72yox7Z4A/ZAIdDMhWXSynX9D4MGBJI6uWJ2utiZ090+GK2O7GihQ0M
 WJvKpqwqAAityy8ohVg1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zv9euh28s8g=;yTFb0hyn3nt1PDC1OBPAHET3ETG
 qMZxiO1vhYag+pzetChTJyEUVP3QNAa0OPq8a9YvE3fE/kCW3o1J8OHTirDCFEu5rAjMKrHu8
 1ywi4oPxigWIj+1WQxGJAbUvDpScRZNxdDSwVOYQQO0+URg0ZWU/TE4FXN9NxxfJl2Kgl/dVg
 vusi+WVLy+Nk+Cv8F/SLFh9HEkcMDNsJwOg51OhFgEcUQWjUc//clXjb1amP0p3usXJar2VJd
 gnAw1V3qDvSGK26bddiGbNcDtXM+dy7AejOKROogTFYG9u/rNKJQVxEMVFMCKHk+yddux13Je
 u8756wbwLXnd3g3MLJgVD/WtIGwIN3cOcVpj9W+cZnWYFd/lmBaWAIzSIVpvSFf7Rhz2qKgq+
 6eKGBZ4Hy1BqBWfGpbPf9r/bhsQRMK72aVCekrS1/6k3GkEwLquVpZ2qhaNNxIpOELO7TAVMe
 jbTPP738KroHNRip02GgOE4/yrOYoEt0eRwqbrR69oS/TxHnjERMN0aKxgi8QUoOO/FNbKuIC
 QYXjsUeI7KWXucNZm59QHeN5M6PdcTbNYVAk8Wuxs++a2NXWgISL2z3Ne1Spj24NUiFrGDkUn
 4aAPp4nEFlnJwxDwQSPrNNo54/0ZNnKq9GQS/kJmz6Skht1LnVPomGwaTpMMMiM/m9lD8BdzG
 K1+eoJ9GojbHaAP2IyCiM2rfbSGI3VbKC41VQT+ivUhthl+Ee5auJJzDEhIUmU0AMarLejnZ6
 cbMtSKe2KUgpiIZSLVTXAY3ucE7Q7ihXJw7UaJ5TyjujzSyWmUO5ZfzU50Qo96CzHRXzE1XcF
 /UOO2l9YTh2gkhckOWgU8mkvLXCt+Htb7xPUt5Fz4Qn94=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


