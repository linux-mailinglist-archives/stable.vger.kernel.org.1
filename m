Return-Path: <stable+bounces-216291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONFhNQ1tj2mNQwEAu9opvQ
	(envelope-from <stable+bounces-216291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:27:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46D138EC7
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 001CA30333F3
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B15283C87;
	Fri, 13 Feb 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="iQjwiILc"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7427FD43;
	Fri, 13 Feb 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007218; cv=none; b=lAT4vZCkaUxDubKJQpe7jo4GPu4kNRWdAgU9xid8+VilpwA2oNnQtrqNqwMHzRs/qKkdj8SIiJau9waWjgdcNQiSA6o13GZdRkj96Y3VQcui9hYUcAQBjfxvAcjjl7SOJzDUG0aGPANESHYBMZBNxbnkyv7eDw/A5ngmF13VqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007218; c=relaxed/simple;
	bh=1R+q0brxT5FCSRMOO/LqKS2K1GLvRDjYnI692aiflvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnA7bAhodU3BaGEH9JFUQKxhm76NahWLTTVggUcmAZIobyvdfU2w4ui0Codnq+SvgtY8suh8ehHK+vs6AInDeDHcjbqOxJGzLqI2phrWpDF5VQve2/SNtEU9A7I4JprFBVAFLX7Qy+V1ROQ8zQYJq8N9Ml441agU8rZmhEyQgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=iQjwiILc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771007202; x=1771612002; i=rwarsow@gmx.de;
	bh=1R+q0brxT5FCSRMOO/LqKS2K1GLvRDjYnI692aiflvw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iQjwiILcOJ/rJZxx1k+dfaO0fw70TqCSMgxYHNep8Rxq2jbQUFmvOU4AkqnGlJU0
	 7q04cpyBexXCIE70FMko0BDSmkVt0W6qsbRarhtb8FwzXW8Z5br85pfuAE2OlA6Bq
	 StvSeHk/6N9NE5LcGPj/Rvu02bFQX+5k9A9sOu0sySDCxYgziRREOtN1VsF2qDxTt
	 8ucOV8wxAF++WY1o1wAIDsnm3JuDgUsDWi89jeEDNXndjCUTXnWX4UDn05jWLPBpU
	 6U5hmHz7VkdmX6fP+4Cc1AokxDkdfIzN8UgL2pG0mIicgPsL5la1DtL0Nd26anddc
	 0xJPDxtVDasGZShWlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.226]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDysm-1vycq60ftk-00E28k; Fri, 13
 Feb 2026 19:26:42 +0100
Message-ID: <9f1f51d2-a880-4f34-83ee-dc48557d4778@gmx.de>
Date: Fri, 13 Feb 2026 19:26:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260213134708.885500854@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i1wlTkCjn9HPfExDv0LqhCV+MdJ7/sjXI80rcztSYBND87VSeaC
 U3uj6Jyptz15K4iNdVUA1mGnIh7hDB/3CQPKZY6nZl9zA3uPSUn5RiQFXV/5IhhH9wP4n67
 sg4iEQSKGZMJT4Cf8mTk2FvAse3FqNgkXbuMSulASWqiHctddLgY+XENpWwBja49kKM/5e/
 9cWLlO1FHOoPMHqti+aaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e6FCX3+tdRw=;62OogSegWYggmOIcR5pQXT75c/G
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216291-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rwarsow@gmx.de,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Queue-Id: 9D46D138EC7
X-Rspamd-Action: no action

Hi

no regressions here on x86_64 (Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

