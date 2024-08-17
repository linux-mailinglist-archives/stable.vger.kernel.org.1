Return-Path: <stable+bounces-69387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9348D95582D
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20987282C1B
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5550214E2CC;
	Sat, 17 Aug 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nUOdgm0k"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911091EEE6
	for <stable@vger.kernel.org>; Sat, 17 Aug 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723902569; cv=none; b=oGINsonVYdBYtVCh/S90jZQcl3mpNchzTupuF3agDzoq0WXG67aH2Y6WwQVQssNAzo/C7KsE+az1Xp2sMcxqaRBu7ISmIGYhn2WYuuf/VvVd9g3LJ8shqHNqXEB9RxnxzYzZpfMnJLjz77cYKLnEQ2w3NguloE03JWYNlkSvpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723902569; c=relaxed/simple;
	bh=Z37x7P3OUwQ57VOk02zwVc2udz2b1U+xIPjklLd4zCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rbu5xFKdmAp7O9/Am0fOqaBs8gIUnfxfEFi8wfHQP02zkrUh+lTsTJCO3BnCr/HWkVp109T3Xkx75YLDi0/RseDZZlcZ9SFwDCoYYKTxESjF0WOhuaRTGzXh1xF1GS8S2o0BfVeuc3yUmhYQiBqMit0Q503vxNXCEtI52xFryEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nUOdgm0k; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240817134919epoutp013084369c4a4fb405b3de2e29d29e9879~siD56jGm41155311553epoutp01Q
	for <stable@vger.kernel.org>; Sat, 17 Aug 2024 13:49:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240817134919epoutp013084369c4a4fb405b3de2e29d29e9879~siD56jGm41155311553epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723902559;
	bh=6OdAAhY1jmDD/qNc8iBhpCFMfmOZJ5vdix/d/18DDPQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nUOdgm0ktl34B2s0pKxb3UkUK88B4KLP1hctKHgmNtvkc/V1CHVUJakkdkU+oiNwW
	 ZhzWrCxOideaD9sI+xT3pO3FN91BhRWUqOLihsW1gznNBKxUxUlg/6/P5DkvFvc0gu
	 vluUXMvs1QpeIqkl0iFqCCuaXWz/Bs8Ucx5UHySg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240817134918epcas5p4b81041e43428e2ab9c9ce40d2c919282~siD5lhkIw0893208932epcas5p4H;
	Sat, 17 Aug 2024 13:49:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WmKwF2pmjz4x9Pp; Sat, 17 Aug
	2024 13:49:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.D4.09743.D5AA0C66; Sat, 17 Aug 2024 22:49:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240817134356epcas5p311b04d9ba86b537c871a55ae7f2e4261~sh-NkFcK82016620166epcas5p3p;
	Sat, 17 Aug 2024 13:43:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240817134356epsmtrp2ad3aba442d71ae211fca8898de870bbd~sh-NjSmU20363203632epsmtrp2C;
	Sat, 17 Aug 2024 13:43:56 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-b2-66c0aa5d535c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.6A.07567.C19A0C66; Sat, 17 Aug 2024 22:43:56 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240817134354epsmtip130a4c32a2f80ebb9ac325ba1b7b421d5~sh-LnkTaY0574705747epsmtip1P;
	Sat, 17 Aug 2024 13:43:54 +0000 (GMT)
Message-ID: <c477fdb2-a92a-4551-b6c8-38ada06914c6@samsung.com>
Date: Sat, 17 Aug 2024 19:13:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2024081700-skittle-lethargy-9567@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmum7sqgNpBs0LhS3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9liwcZHjBaT
	DoparFpwgN2Bz2P/3DXsHn1bVjF6bNn/mdHj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
	eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
	JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZa3fZF2wSrHi49DBTA+Nm3i5GTg4J
	AROJpsUT2LsYuTiEBHYzSpxe8BTK+cQoMen+YSYI5xujxLoFN9hhWqYu384GkdjLKNF+ajUL
	hPOWUWLu3BusIFW8AnYSf/dOZu5i5OBgEVCVONuRDBEWlDg58wkLiC0qIC9x/9YMsKHCAvES
	R24vBWsVEdCQeHn0FthMZoGTTBJXly5jAkkwC4hL3HoynwlkJpuAocSzEzYgYU4BM4mptxcx
	QpTIS2x/O4cZpFdCYA+HxL4TDUwQV7tIdLbfYoawhSVeHd8C9Y2UxOd3e9kg7GqJ1Xc+skE0
	tzBKHH7yDarIXuLx0UdgzzALaEqs36UPEZaVmHpqHdRtfBK9v59A7eKV2DEPxlaVONV4GWq+
	tMS9JddYIWwPickvtjBPYFSchRQus5C8OQvJP7MQNi9gZFnFKJlaUJybnlpsWmCUl1oOj/Dk
	/NxNjOAkrOW1g/Hhgw96hxiZOBgPMUpwMCuJ8D79sjdNiDclsbIqtSg/vqg0J7X4EKMpMH4m
	MkuJJucD80BeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1M3tZX
	C5Zemrb6QcRaK/f4pXlhFp1L1aQEvRVtTirdWe776MtvJaGO3Y1vxee4Pu2ws5217NCzN3tD
	kgI9Z895Em0rU6O5XnRiRGLbp6s/JNK1uJ2v3RXeu3n58vU218QCRLeGlbPOy3z3NH0x84Jj
	9Zqv9abKVzBZ9lovmLenpF1E4tHGOrWFZ0qWf5nEbuL+NeZYe8D7iGjefV2vNae7nBKYt9j0
	1Uaj+70LRT9PUJVNrGKqnLtvTXMz17Iij63fH6aEmSudeL2gXPXnXN6S1hvdQXveXF0i+2iN
	sOHmPsXlRkb3TyraCR3NvCDz5oqAY7fUfua+6a2RbCcqk+M0rk9bz6Vy8enOez+LV3x1U2Ip
	zkg01GIuKk4EAGET9E9LBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnK7MygNpBt83aFq8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFgo2PGC0m
	HRS1WLXgALsDn8f+uWvYPfq2rGL02LL/M6PH501yASxRXDYpqTmZZalF+nYJXBlrd9kXbBKs
	eLj0MFMD42beLkZODgkBE4mpy7ezgdhCArsZJeZMroWIS0u8ntXFCGELS6z895y9i5ELqOY1
	o8SBYyfYQRK8AnYSf/dOZu5i5OBgEVCVONuRDBEWlDg58wkLiC0qIC9x/9YMsHJhgXiJ5sn7
	mUBsEQENiZdHb7GAzGQWOMkkse9KHzPEgllMEtcnzGMFqWIWEJe49WQ+E8gCNgFDiWcnbEDC
	nAJmElNvL2KEKDGT6NraBWXLS2x/O4d5AqPQLCR3zEIyaRaSlllIWhYwsqxilEwtKM5Nz002
	LDDMSy3XK07MLS7NS9dLzs/dxAiONi2NHYz35v/TO8TIxMF4iFGCg1lJhPfpl71pQrwpiZVV
	qUX58UWlOanFhxilOViUxHkNZ8xOERJITyxJzU5NLUgtgskycXBKNTDJCB9K+Bt87vlJZu3D
	0+cq/bTf+YPLasLvU584IvKnL9+69VWw7E/n2/w+5iw1uj8qqrfHf0n/Fid9Ye++GVdklhx1
	ODi3bTnXCvEHU5kOOShaSVZEXVr8JGe/dl7VTecahd7grzEbY2xNw+Jrt3PkKT4z1Nn0aFth
	gbqHeOe6aZGMZ0T3lbnon3bmbHRjkvm+7CvD5cPnbBhm79v10MPvilTd8ZPGLEq2C977lTgm
	yu+Mqrp34OGhzWtTZgf8msNwZteO72t8xF6L7RZqv2kdtStOSoCXU3JKXK1G7cIzyoveva+I
	qfl+fvlcdtZdEhufsk06f0vGkvfaCg0u2+YPF89b2v+U5Hp6PlRzQn+PEktxRqKhFnNRcSIA
	OkdZfCUDAAA=
X-CMS-MailID: 20240817134356epcas5p311b04d9ba86b537c871a55ae7f2e4261
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe
References: <CGME20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe@epcas5p1.samsung.com>
	<20240815064836.1491-1-selvarasu.g@samsung.com>
	<2024081618-singing-marlin-2b05@gregkh>
	<4f286780-89a2-496d-9007-d35559f26a21@samsung.com>
	<2024081700-skittle-lethargy-9567@gregkh>


On 8/17/2024 10:47 AM, Greg KH wrote:
> On Fri, Aug 16, 2024 at 09:13:09PM +0530, Selvarasu Ganesan wrote:
>> On 8/16/2024 3:25 PM, Greg KH wrote:
>>> On Thu, Aug 15, 2024 at 12:18:31PM +0530, Selvarasu Ganesan wrote:
>>>> This commit addresses an issue where the USB core could access an
>>>> invalid event buffer address during runtime suspend, potentially causing
>>>> SMMU faults and other memory issues in Exynos platforms. The problem
>>>> arises from the following sequence.
>>>>           1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>>>           moving the USB core to the halt state after clearing the
>>>>           run/stop bit by software.
>>>>           2. In dwc3_core_exit, the event buffer is cleared regardless of
>>>>           the USB core's status, which may lead to an SMMU faults and
>>>>           other memory issues. if the USB core tries to access the event
>>>>           buffer address.
>>>>
>>>> To prevent this hardware quirk on Exynos platforms, this commit ensures
>>>> that the event buffer address is not cleared by software  when the USB
>>>> core is active during runtime suspend by checking its status before
>>>> clearing the buffer address.
>>>>
>>>> Cc: stable@vger.kernel.org # v6.1+
>>> Any hint as to what commit id this fixes?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg,
>>
>> This issue is not related to any particular commit. The given fix is
>> address a hardware quirk on the Exynos platform. And we require it to be
>> backported on stable kernel 6.1 and above all stable kernel.
> If it's a hardware quirk issue, why are you restricting it to a specific
> kernel release and not a specific kernel commit?  Why not 5.15?  5.4?

Hi Greg,

I mentioned a specific kernel because our platform is set to be tested 
and functioning with kernels 6.1 and above, and the issue was reported 
with these kernel versions. However, we would be fine if all stable 
kernels, such as 5.4 and 5.15, were backported. In this case, if you 
need a new patch version to update the Cc tag for all stable kernels, 
please suggest the Cc tag to avoid confusion in next version.

Thanks,
Selva
>
> thanks,
>
> greg k-h
>
>

