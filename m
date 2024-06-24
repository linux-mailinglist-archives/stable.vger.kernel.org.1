Return-Path: <stable+bounces-54978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9042C914336
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124D31F23DF1
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3D3A27E;
	Mon, 24 Jun 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bQoWLQwT"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0D38DD2
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213030; cv=none; b=SztYj9iu4YT6eYcVfFCQf8XDTMawhebBxu00x1ZBYeyFWvXvhGVBwJT01DPjUxjMW00hbxi2MY4CtBNhYLWGSFlBtinPTGVe9iGRdsarfb+bGSlJQtUJlAthn/iuxH4vzlXeaeJiBp0xXYw9MYSeyZTPWipudLBjog3zgk0xTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213030; c=relaxed/simple;
	bh=T2MNa32awk6X9QG4HCaxxmQuqYyaq446iozFUpi4Hkg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=shJyajYdlvC9E6+XecD/axloVU5gqT4zZ462ITCZwRAh3YD74Qyk8W4C9AyUA0CJi1dRqtlE57AYmioJHtSaqGFCDjWMbld8W8bc+3GifH2QrBp7iT0ASQokX8r6ypl//Jppc6oxU8T0LtjAaGwwUyqsZ+4QkKLg8/dx5tFpXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bQoWLQwT; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240624071020euoutp02e8ab22d253fa8bc6e8a37dbc8e6b0375~b3yIusUOO1159511595euoutp02T
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 07:10:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240624071020euoutp02e8ab22d253fa8bc6e8a37dbc8e6b0375~b3yIusUOO1159511595euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719213020;
	bh=kQJPx6cP8ETGgfHUlMSqBMmgeoB44+zqZLO9fBDGPAY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bQoWLQwTrrIN+cBcu9TW7VYxgld2q7WS0W9uxOv2QvHrt1cRRTA3SzkBPgz1gNJUp
	 nMy7yyhaHPE6L648dtPlgy527iBsEyVrwJ3etI728+5RnsnqgBnJhr/ZSOxw6ysiUA
	 lO9JdczArHd68Ivw7ryuZ90bJbtP7YzEv3Ft/ydY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240624071020eucas1p22b87a6b1272f896a89d8e8ae0d92e61f~b3yIYRF101207712077eucas1p2S;
	Mon, 24 Jun 2024 07:10:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.C6.09875.CDB19766; Mon, 24
	Jun 2024 08:10:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240624071019eucas1p28813f47227bf863ed6603d9d9588394f~b3yIB9-Aq0147701477eucas1p2Z;
	Mon, 24 Jun 2024 07:10:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240624071019eusmtrp19706cd34d1335c096eb8d529cd5d57f3~b3yIBSKu_2498424984eusmtrp1S;
	Mon, 24 Jun 2024 07:10:19 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-0b-66791bdce308
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.A3.09010.BDB19766; Mon, 24
	Jun 2024 08:10:19 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240624071019eusmtip2d49b501dede0bed73f519d4a1985cfdc~b3yH2KU190040800408eusmtip2h;
	Mon, 24 Jun 2024 07:10:19 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 24 Jun 2024 08:10:08 +0100
Date: Mon, 24 Jun 2024 09:10:05 +0200
From: Joel Granados <j.granados@samsung.com>
To: <stable@vger.kernel.org>
CC: <stable-commits@vger.kernel.org>, Pablo Neira Ayuso
	<pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
	Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@verge.net.au>, Julian Anastasov
	<ja@ssi.bg>
Subject: Re: Patch
 "netfilter: Remove the now superfluous sentinel elements from ctl_table array"
 has been added to the 6.6-stable tree
Message-ID: <20240624071005.tnijkj7b36bvztks@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240622234538.197608-1-sashal@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7p3pCvTDOat4LOYc76FxWLdrlYm
	i6fHHrFbNG/9ymjxpP8Rq8XMrmYmiwvb+lgtvp1+w2gx/c1VZotTX/4zWXyeo2FxeOlVFosF
	Gx8xOvB6vDt3ktFjy8qbTB4LNpV6bFrVyebx9vcJJo/e5ndsHu/3XWXzmNi6h9Fjzs9vLB6f
	N8kFcEVx2aSk5mSWpRbp2yVwZWxYuoupYIFgxc9bX5gbGM/wdTFyckgImEjsnHiVsYuRi0NI
	YAWjxPn7t5ghnC+MEn92HmaFcD4zSrQcvssK0zLh9D82iMRyRonNnX+Y4ap2r9vIDuFsZpR4
	tb+XCaSFRUBVYnr3SmYQm01AR+L8mztgtoiAjMT01r1gNcwCB5klrrVKgTQLC3QzSlw7ewCs
	iFfAQWLe04esELagxMmZT1ggGnQkFuz+BHQHB5AtLbH8HweIySlgIXH6giXEpYoSXxffY4Gw
	ayXWHjvDDmGv5pS4viMYwnaRmPn5HBuELSzx6vgWqBoZidOTe1hAzpEQmMwosf/fB3YIZzWj
	xLLGr0wQVdYSLVeeQHU4Sky718AIcoSEAJ/EjbeCEGfySUzaNp0ZIswr0dEmBFGtJrH63huW
	CYzKs5A8NgvJY7MQHlvAyLyKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMLGd/nf8yw7G
	5a8+6h1iZOJgPMQowcGsJMI7vb4sTYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJ
	anZqakFqEUyWiYNTqoHJb1Lfz1dCl7Ir9J/s6w1IZ4y7kd5gndFRnvKN+cL0RrPGc0+beqV4
	41e+2Zd9o5BD6Jj0gpp9DC+1XQQnfLo9IZK9yNqnJSirtcDcYN+rA5+uVZmy6i/at+NPWcRh
	22OmgQ7LLiWdeTQ3vVeEVyIvqWlbwC52/2kRC99/6+PfzOfdw5r46UhazgtmnYkhLpPzd1pK
	lZ1TF3DMbnnV2Jnyad2KufcM6tNSIs7PtDm0XvzJzZNFN2I993tJLfx4QEDc++Ri3yy1tD+Z
	0hJfHq2Y/XD1Zw7XnAlyP/8IinZm3wksP/Pz6L/gXQcyToSVnOgJPrVrq4DLJ1FHCbMbVe+f
	Xfg578KuJf5f14RG+nErsRRnJBpqMRcVJwIAXui2NNsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xe7q3pSvTDE4eNraYc76FxWLdrlYm
	i6fHHrFbNG/9ymjxpP8Rq8XMrmYmiwvb+lgtvp1+w2gx/c1VZotTX/4zWXyeo2FxeOlVFosF
	Gx8xOvB6vDt3ktFjy8qbTB4LNpV6bFrVyebx9vcJJo/e5ndsHu/3XWXzmNi6h9Fjzs9vLB6f
	N8kFcEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
	ZWxYuoupYIFgxc9bX5gbGM/wdTFyckgImEhMOP2PrYuRi0NIYCmjRNP8FYwQCRmJjV+uskLY
	whJ/rnVBFX1klFix5AwrhLOZUeLrreVsIFUsAqoS07tXMoPYbAI6Euff3AGzRYAmTW/dywTS
	wCxwkFmiZ+JmsG5hgU5GiVknDoN18wo4SMx7+hBqbDejRMesDqiEoMTJmU9YQGxmoLELdn8C
	inMA2dISy/9xgJicAhYSpy9YQpyqKPF18T0WCLtW4tX93YwTGIVnIRk0C8mgWQiDFjAyr2IU
	SS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM8G3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeKfXl6UJ
	8aYkVlalFuXHF5XmpBYfYjQFhsVEZinR5HxgiskriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
	TyxJzU5NLUgtgulj4uCUamAyL/FPzqltv1+Ye6UmlMF+puDs7nTWK+vXWLF/lHqVcErR0J/z
	+TPH8mv/Dn59Y3+FcfYKW5VTX963TCwOFm/afengnMJH3J3muuf+fdfeEJyha5PZUfI1zFay
	LTO5Tefgrcw3/Fl500X4ZE8Ef0pvW+gzq+TLxaJ9fFwCSdXF+0wfC7EnlgqGXz/c43tKkOXK
	+11WSpPenUz86PyRkZVLO/DD9z2l7BZektmeJhZ7YhlFr53PObNt1uHAUqYXgb/NxapeWedP
	NTj8iU99z04Vnik3Ym67rq1NfRcpWbk+qpL3aZZTqPvqp48N0mfZH/px9e9tldppFWYbmlgV
	yu5Pd5awFnP9W1F5fmbULyWW4oxEQy3mouJEAD1VYFB5AwAA
X-CMS-MailID: 20240624071019eucas1p28813f47227bf863ed6603d9d9588394f
X-Msg-Generator: CA
X-RootMTR: 20240622234558eucas1p2a6211f0643e368f34541573847b7105e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240622234558eucas1p2a6211f0643e368f34541573847b7105e
References: <CGME20240622234558eucas1p2a6211f0643e368f34541573847b7105e@eucas1p2.samsung.com>
	<20240622234538.197608-1-sashal@kernel.org>

On Sat, Jun 22, 2024 at 07:45:37PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: Remove the now superfluous sentinel elements from ctl_table array
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      netfilter-remove-the-now-superfluous-sentinel-elemen.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I don't understand why we are putting these in stable. IMO, they should
not go there and this is why:

1. This is not a fix.
   The main motivation for doing these sentinel removals is to avoid
   bloat in the boot and compiled image (read more in cover letters for
   [1,2,3,4,5,6]) in future kernel versions. This makes no sense in
   stable IMO.

2. There are lots of moving parts and no "bang for the buck"
   If you are going to bring one of them, you need to bring all of them.
   This means brining in the preparation [7], the intermediate
   [1,2,3,4,5,6] and the final patch [8]. This is not only prone to
   error, but there is no real reason to do that in stable.

If I'm missing something, please let me know.

Best

Joel

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=archive/remsent_net
[2] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=archive/remsent_kernel
[3] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=archive/remsent_misc
[4] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=archive/remsent_fs
[5] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=archive/remsent_driver
[6] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/log/?h=archive/remsent_arch
[7] https://lore.kernel.org/20230731071728.3493794-1-j.granados@samsung.com
[8] https://lore.kernel.org/20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com


