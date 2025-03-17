Return-Path: <stable+bounces-124575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1EA63E5B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1971A188DA89
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 04:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17824214A9A;
	Mon, 17 Mar 2025 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="piiOc7wn"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9814F9F9
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742185957; cv=none; b=MgfTnvWyHAraFPQeazHKU9Y7BRYmNW6mnbCqpDfu54qyY+PWRHQgP+QC6MDSg+EgOR+THOIQVYSmMfXKf5Ran0RMKW8hdXshoYW3tmN0RHU1pM7Y4++osqTetT95286tUKLmD37xdrmUBYVTttV1FOwj2FgitSGe3K8mAMIrboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742185957; c=relaxed/simple;
	bh=IOhGaXq1CIyRqLCk9AID5H6e1heMG9jjAvMzzoEgIIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=tX5H28QUpRxOnevhwcb2c8e1p1ZguDOflCvQa7xUQlnJFQloPlbC3ntx470xaWrC/3e4jBVMLEoVU+VqCca4rVvujTlCm8wShUgtKICkxCDFzFTyTrNjXeGVPzZrRNNRDSD2XpfnMIemhTZAnbbb+5AxGpW5gWbuN5vtXfyfCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=piiOc7wn; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250317043233epoutp04bcc741f85b2822da496cf46cfa0966d8~tfOTr_Skj2173921739epoutp047
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 04:32:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250317043233epoutp04bcc741f85b2822da496cf46cfa0966d8~tfOTr_Skj2173921739epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742185953;
	bh=CDS21IpwWqt7ZRocUWjRABgv3Dgf/G8yTwuk6a2wW7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piiOc7wnYKShbvhndy6ZzQaK1XcwfVo9WbdLPD2AsfJkML6EZPMj/Lg/6jLxld4Wq
	 mF+iKdCNL1MRtOnuDZFEEJg1+J14FOXOG2rAAMhkGGMmWYepfsUYCxwUAECGLbUIsb
	 zneFL8xfkldG5GBtFNmKvHF0DWJbMxVJ2AysE/Xo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250317043232epcas2p40964da2213e804d734c62516ca5daf50~tfOSyT7pi0713107131epcas2p4q;
	Mon, 17 Mar 2025 04:32:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZGMWz73RJz4x9Q3; Mon, 17 Mar
	2025 04:32:31 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.44.22094.FD5A7D76; Mon, 17 Mar 2025 13:32:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250317043231epcas2p2a42eecaaabed96be1d19059416ad38da~tfOR0Uqfh1582715827epcas2p2v;
	Mon, 17 Mar 2025 04:32:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250317043231epsmtrp1f7364e4452314d8f07aa6fccfc31dd92~tfORzC5XY1640716407epsmtrp1U;
	Mon, 17 Mar 2025 04:32:31 +0000 (GMT)
X-AuditID: b6c32a46-484397000000564e-cd-67d7a5df5e06
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.83.23488.FD5A7D76; Mon, 17 Mar 2025 13:32:31 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250317043231epsmtip24a0871609fea3b04312495e8d4bbc518~tfORgMzGt1487914879epsmtip2G;
	Mon, 17 Mar 2025 04:32:31 +0000 (GMT)
Date: Mon, 17 Mar 2025 13:36:42 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, ncardwell@google.com, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com, dujeong.lee@samsung.com, ycheng@google.com,
	yyd@google.com, kuro@kuroa.me, cmllamas@google.com, willdeacon@google.com,
	maennich@google.com, gregkh@google.com, Lorenzo Colitti
	<lorenzo@google.com>, Jason Xing <kerneljasonxing@gmail.com>, Youngmin Nam
	<youngmin.nam@samsung.com>
Subject: Re: [PATCH 1/2] tcp: fix races in tcp_abort()
Message-ID: <Z9em2njRsaoKNBG0@perf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2025031453-underpay-gigahertz-9ba4@gregkh>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xbVRTHvX2P91pGl0dBdmXLwkpGBFdoEejdLE4jNvVXwoIxUUawwrMQ
	Stu0ZXOYTAJ0MIb8jjDEpQqOgcuQrgGkFgiFwgbKQBg/xlJ+OAaOAWsJBiPEwgOz/z7n3O+5
	33PuyWVjvFzSn52q0tNalVzJJzzxFluwWOD4cVwhXJwWo/WuERLdt5aSqGYoF0e32g0stGCs
	wtEj+xyJFjY2MZRT20Sg8gqAsjtHMDRX3E+gMcsKhiwtlSS611Lkgbptj0n0R3sNgZoGVgDa
	sC6TKH/aiiO70Q9tDCwDZGyeA8gw7yJR3uYTHK3PjxHoWV82iWq7nCTK+f4W/sYRmblhkiX7
	pfohKTOaMmSmxsuEzFhEyjq/u0nKVjvGCFmRuRHIXKajsZxP0iQptDyZ1gbQqiR1cqpKEc1/
	Ly7xrcTIKKFIIDqJxPwAlTydjubHvB8rkKYq3fPzA87JlRnuVKxcp+OHvS7RqjP0dECKWqeP
	5tOaZKVGrAnVydN1GSpFqIrWnxIJheGRbuGnaSk3J/oJTavXF1P3S1lZ4IZnAeCwIRUBf7OV
	4QXAk82j2gC0jM6wmMAJ4OTXo+SOikdtAFg1f3y/Yq3u0Z7ICmBn2W2CCWYBNNQ3YDsqnDoO
	Fyt6wA4TlAC29G/vsi/1MlzqncJ3GKMKPaBj5asd9qGi4GZR3a4blwqE5c3XPBj2hneu/rmr
	51AIWmebWUwXtRz45J6A4Ri4cPkBwbAP/KvPTDLsD5eKL+2xDmY5prCdRiGVC+Dd8UWMOXgV
	Vi/kAaahFNheOus2ZrvzgbBnv8+DMN+2RTJpLsy/xGMqg+A/FT8Dho9AS+2NvRtl0Gm3Ycyb
	dAHY7VpmlYCj1c+NU/2cG8MnoNHiJKrdFhh1GNZvsxkMhk3tYUbg0Qj8aI0uXUHrwjXh/y84
	SZ1uArvfIUTaBiqeroV2AxYbdAPIxvi+3OIfxhU8brL8QiatVSdqM5S0rhtEundTivm/mKR2
	/yeVPlEUcVIYERUlEodHCsX8Q9wv23IVPEoh19NpNK2htft1LDbHP4t1Gztd6XowX/NKSOtw
	TupIYF3YRf4z/HpHzHzrFYlXvHqg54N8fYLIWnZQeqbhWkeQivvS7+tn1+WfedebI/IcnqdX
	7E3xQQaZOVd6/mrHCdPoVK00PyG1pMkwkcAvA3AwUzWU882Ms2dViJf49WUqwbu+OY4rRaeU
	YWsfsX3/PXZm4mx88GD2QezA+WnvknNDlW/y2j8Mdl4fLbhT806vV7gx2vz3U5g38PjwxE/2
	YYltNTtGUvgQqxesxvfWuPChA2WSeoErzu7TNXEx3jA36fjYK05mGvz18wt5hmGnaYZz7LVv
	u9LGt5ekqsItS2j60t3yF2KI1gHyUEfV29gWH9elyEUhmFYn/w+S70kulwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvO79pdfTDU6sFrP4cuASu8W1vRPZ
	Leacb2GxWLerlcni2YIZLBZPjz1it3j27SezRfPi9WwWk6cwWjTtv8Rs8aj/BJvF1d3vmC12
	b5vObnFhWx+rxaHDz9ktLu+aw2ax/vQ7Rotve9+wW3Tc2cticWyBmMW3028YLRZsfMRo0fr4
	M7tF+8/XLBZfHl9ls/h4vIndYvGBT+wWzQvXsTjIeGxZeZPJY+esu+weCzaVemxa1cnmsaCP
	3WP/3DXsHu/3XWXz6NuyitHj8ya5AM4oLpuU1JzMstQifbsEroyGrgPsBd85K1pOf2RsYGzk
	6GLk5JAQMJH4sOQpUxcjF4eQwG5Giakzm1ggEjISt1deZoWwhSXutxxhhSi6zyjRee44M0iC
	RUBV4sWUI4wgNpuArsS2E//AbBEBDYmXR2+xgDQwC0xglZj25QQTSEJYwEziZ98SdhCbV0BZ
	YvLGeVBTDzBK3N63gwUiIShxcuYTMJtZQEvixr+XQM0cQLa0xPJ/YGdzClhI7H24kWkCo8As
	JB2zkHTMQuhYwMi8ilEytaA4Nz032bDAMC+1XK84Mbe4NC9dLzk/dxMjOMK1NHYwvvvWpH+I
	kYmD8RCjBAezkghv/6Lr6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5VxpGpAsJpCeWpGanphak
	FsFkmTg4pRqYhOPnHLnuGmRm/apKdxMPwxJ1s+Um4vZsm8oDfXU3T/4rqnCkLjrpQP0fRtu9
	5cGi+wperpHMt/L9yZ6/dt/yhRWTDD4EKwlYx36I3+64kuW6N+vFtN8h3mYs2zwd6mYmyzIp
	f9HicWHxLP6294By+muf5Kc+x0tuH+kLmLK18e9nsQ83LFcuWbOsO4j7o51H2KSEbXPO1S86
	vfo0m+NJwdhnW0wcr77eo3hha1Hjh3uMp93e8KppXjNKMg5pzRXRjGNJUA68NuvsH81uvxyl
	V/8CEl+alkUpCnrlrwjWufk2fFPW9w3ejZEtoosSzr+9YG31xXSKx5rwJ85xZXVPD50R/bM0
	rjpxwsyrLLOUWIozEg21mIuKEwHqvlz2XwMAAA==
X-CMS-MailID: 20250317043231epcas2p2a42eecaaabed96be1d19059416ad38da
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_21b24_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250314092125epcas2p418cd0caeffc32b05fba4fdd2e4ffb9fa
References: <CGME20250314092125epcas2p418cd0caeffc32b05fba4fdd2e4ffb9fa@epcas2p4.samsung.com>
	<20250314092446.852230-1-youngmin.nam@samsung.com>
	<2025031453-underpay-gigahertz-9ba4@gregkh>

------K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_21b24_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Mar 14, 2025 at 01:24:09PM +0100, Greg KH wrote:
> On Fri, Mar 14, 2025 at 06:24:45PM +0900, Youngmin Nam wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > 
> > tcp_abort() has the same issue than the one fixed in the prior patch
> > in tcp_write_err().
> > 
> > commit 5ce4645c23cf5f048eb8e9ce49e514bababdee85 upstream.
> > 
> > To apply commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4,
> > this patch must be applied first.
> > 
> > In order to get consistent results from tcp_poll(), we must call
> > sk_error_report() after tcp_done().
> > 
> > We can use tcp_done_with_error() to centralize this logic.
> > 
> > Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Acked-by: Neal Cardwell <ncardwell@google.com>
> > Link: https://lore.kernel.org/r/20240528125253.1966136-4-edumazet@google.com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Cc: <stable@vger.kernel.org> # v5.10+
> 
> Did not apply to 5.10.y, what did you want this added to?
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

Sorry about that.

As for 5.10, it seems to have more dependencies for the backport.
I think the maintainer should handle it to ensure a safe backport.

------K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_21b24_
Content-Type: text/plain; charset="utf-8"


------K-Xcka4Xsim0K0-JuHAa3VmVr3oPR9my9iMvsSsU8QXUQUBj=_21b24_--

