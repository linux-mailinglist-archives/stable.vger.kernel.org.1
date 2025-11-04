Return-Path: <stable+bounces-192417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C097BC31DA5
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 16:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FC384F3D29
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0736263C8F;
	Tue,  4 Nov 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BzRZPo81"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDAF261B91;
	Tue,  4 Nov 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270224; cv=none; b=CMhbnPQDMIBPNdU4LQdy4TDTQt3tGGHJ9j8p8BVdpr4J1e8QAt/lYWc2TGNanzsE+nT9hQWjFJjBYAixz8OQiEn30hJEkL0uOBwMk9eUhxNsat2ZrQ4XEKRoI40JENdIklUO8MCE0jQQc2MQjWKAp618ymGtoDt8v19gQJ3LDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270224; c=relaxed/simple;
	bh=Y/JkedRMHCQZWNVQLDIcpU/wLoogPEVG+3sV0MWLqL4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=puyYmr4MrbYttdRn6opc+ZK2UHtXltVpay3iMUVfcKZnrZYGjo/Yvolqu5GbQnDuUIhme0uXQsL/XgAu6L3j6ZqL9Bs52xvTfTvLbJEOuyx/Nk5ibTGMmp3ByNdzBlVJYaIwXGLkDoS3N/IqGr1qKaxKsaLG25a6CKo4gNIxmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BzRZPo81; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762270210; x=1762875010; i=markus.elfring@web.de;
	bh=Y/JkedRMHCQZWNVQLDIcpU/wLoogPEVG+3sV0MWLqL4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BzRZPo81NZoaSB531e7ll+oQAY/EfF68C0N58P5XABZEGbNSKvuKPZBcxIRKfZv1
	 i6vmBnw8iUKNS016rIvEnewWH4IIDC4JpsJFxY/zIqa3nPwrce6VHp/fM2N5cV3de
	 iGaMbcuz+RBbDsGCiDF9dwobQCr5/WXUApM31Dso7s6ZMTtLFyr58N9C+SEWhI+rn
	 HP32PStWOz3FhAqFQt6kiRF+msfz1MWAxBx7f5fW7EDwusKaY0wJHW4qIpw2GaM6V
	 Jnw05kdbKTKVQ1JvbnJljA43kWi+dUL5b89Tf02qirIBEXbTcDrxBV0yOMoux/c12
	 LOyRc5pi4UdsK/Nwtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuKF-1vX8W4411h-00RtuQ; Tue, 04
 Nov 2025 16:30:10 +0100
Message-ID: <906553df-10c3-45f9-8f27-55bc61948b95@web.de>
Date: Tue, 4 Nov 2025 16:30:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251104020133.5017-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] mei: Fix error handling in mei_register
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251104020133.5017-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bcBJzGrxNmA7LuI0/Hl8oYfzbTTI/SEY1fLcCL+Rg75jMRi4gU4
 yv/bvHXhiVn/VBgbSlQf2n8ehMbHA2lWBLg5uYaoLrzawGv3fgkVZ3gK8OUu7PAnAnuHA6O
 Yz8ukKaFetq2i4mQ0/cEr0WMyy1H3dIGjU3PsTC5BbPSyJPQhCIinOsGEZtpdGmv3wEF6uK
 JtY/0UdflBgdn2iXQMVHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c/qgox00DZI=;xig72IMrZexYPiiu5D81n2obyFX
 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
 Os5cA==

> mei_register() fails to release the device reference in error paths
=E2=80=A6

Would it be helpful to append parentheses also to the function name
in the summary phrase?

Regards,
Markus

