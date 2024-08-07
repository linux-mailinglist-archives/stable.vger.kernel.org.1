Return-Path: <stable+bounces-65935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB594ADC1
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B892824B2
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47966136E23;
	Wed,  7 Aug 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="eq1G66Yf"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0D135A79;
	Wed,  7 Aug 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046984; cv=none; b=REwlDPy8yaiQM+nVDOGqX5F8uI2Xj4pAJYByDhlU/Pz0j6qMDrZbtHSg+pcCRFPiUeUJFbi0CMyie2eQFkfi6nWOPEEi2upaMjTHKjrocBYRLK8dNxgr+qn0U1TcphdZxECJLlXgFO3+a+6oBxihQMBLOvkKAhhR7YSJXHKAzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046984; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ExNeIncm23I6Yeidbftvi6m6TGIL3ia1Uka7670yBMOlfEqlIWwvN6cDZ2CSUbpiKKgJgZAN11z7R3860+VtyziuSwSfnPaV9Am4lRTgl9MDAre1y93PiV6oM2V+MrM1ouH6ADSBLoB2vPIoBH+i2miW0QcPfF+pkIGT4AHqkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=eq1G66Yf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723046978; x=1723651778; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eq1G66Yf9rx8UEnZZ4vnI1aAPlpfvBHsqe2y403UtJEqh7+0JqXNNbSDsuicpo2d
	 VHPgNx1I8pcD4CWTx29zH2orAjWXo/tvOtwsPCGezp09hHB7dnXQyxY6oWwebjrzv
	 +VsvB1ZVjpVzfD/pmE6LWYNapruvq42bqiOcXDXJ8k9uFAmCx42Vs8PRxIhfAFbHn
	 zHYpe1Ui+S056091eG5oTRMGIBxwk+M21pil1BnZ260HqgX0AIx7Ve6pC8HQ0UGoJ
	 ssYgufLCIJeZCgTzX9MTQWO7oSdP3OsiXv2Ci26J4kTz/JUUSD7Vcw0cBNxM26FRI
	 Q9G20HfJ5d9iw6MzLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.118]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1rqa7d3PMR-00bKtN; Wed, 07
 Aug 2024 18:09:38 +0200
Message-ID: <fecde35a-fe75-4e98-87e9-e9da0f959924@gmx.de>
Date: Wed, 7 Aug 2024 18:09:38 +0200
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
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PO1vJhdbewxo9sCb5CnicpsXevP9PvtVbroX2ZKNcXL7THZ5OkC
 cV/YGAvkVnmMX+RvPFqcNU3Ropi0ga562FMKtvDVpTUOAnKhuiOH+JGUFkUizil78iKBp9W
 ZSCwfOWOrFpR7S3c7vzU4jg21sRR6F3yhgexF4ZIijgpCQ04gNPdqVY6a0m6zgDpTMpt6oz
 ZhksNTqj2v9asng0t7SUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MRmqLaK4zmw=;/t0VchD8at4atUD+l6h1dG3eXzX
 oa3iDggUlXzBGPVAXqGTJFwtQf0fNp2eVgeEBzjHUQzLQ3P611TK4vg0Cy3SEYHUHj5FhILtv
 t3QOvTZdvBjjeLf3xjNfPbHafKsu9lO0EzbB1pyFWpqmT6nxxH3scIlO/Z1v/eBlDFN9QLExs
 dythDAD4CtNQ9RhxIIRRLlLryESnqouBEbdGulKCBSdd65gbjJnTsfUnVjXnGvr4+ShCcdzMx
 7z0PU3bdRHGCoPjnrL7qroxdjUZVPCXWDtlzEIPJ99+x2nyil1B+ysJRlNE8pBSkdfs4fx2Q0
 MOL1uN/7XkLKUXT4MsELWZ+D/sIJSpJGOkB6V2ohTagDggiFLwBXIh4uZ3ZlVIRO3eBY4mQc3
 tChXUMvTWyWiZjHMv9jngBN4EsT/WcVrtlSP6u8ayNXuF/eX7J94ELyyw6jD24Hhevf3k5VWv
 2mmsXegYiE7bDYtXwK93Eh9KZtRW/GZ26bvlcO7/xt3q6lRYwwjhA0ehNeL42WDnK/LuQp8U+
 WzQU5oBgNBT5iKywXMO6baX0pvh8DUbfOWsP5+2sVFLVC2hwVsSe2hLVj5JbdIz6MLuqWkhKb
 CTyEOvFmmRfEYfaDH7JoNEY1Km4vYOIjPg96r7j4Agn90f1+hhQattG/BQhC/9GIEmQaOs8Zj
 fElPEXGIXfRLOYOf9oHRu/nUFUNg5Y74GntHWHmopK8a43wUCxsCOeeKeyBTeWp7ZHywMMkZp
 NfCsi0ptN9OQ1tPmOKKudalB/dkfz+nAKnyzWBrfQz19LKe3Zy9x4BI6bNIbiK4KPnvBp0ADR
 H5+peo4eKa4+Y/P/wJLycxHw==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

