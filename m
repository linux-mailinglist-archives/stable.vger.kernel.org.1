Return-Path: <stable+bounces-203056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76360CCF322
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4B7B3024CBE
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421E296BA9;
	Fri, 19 Dec 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Hdtr44RG"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F761F30A9
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766137629; cv=none; b=tUI3nLSROORs/4JKxUJI3aQxSyh3pajm7e1793HU5hwGZQqETCV9bRUDlizNlqj1C0fw6/FQ19pAsoJvZ5g/UpDuXEUgpd0c85lwdsaxOEWVDp84vBEw9CgNyYAMLFUpOsYfGz5vIUkptPPcyPmYyxO+K0N5cGUi75B4cpm5V1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766137629; c=relaxed/simple;
	bh=as5IWJeu9MlH+M3RLigDWOdTnY1fPt7bWkdU+2Wy8zc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=GPtUoZ7NObK39wcYeuXijARii79CeAyy5wU1LrkgqWFJAph+BJmxO98IuOpvhxCycXBNleuWs7zWIg4jRl+D0IXfMOEghlxpowTPA2xjkQSkvg1MinfHqekRglb+W7N1fHqZbPxLLpXTYtgZX7jmFB6eZckdlC0KH/5QA5Lk/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Hdtr44RG; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251219094702epoutp01711bf58502574a30d044c43f582d7a28~ClM_GhiC50256802568epoutp01L
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 09:47:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251219094702epoutp01711bf58502574a30d044c43f582d7a28~ClM_GhiC50256802568epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766137622;
	bh=5NTyHC//MBd7D9ijLQKV44JJ85QmkJb66DX6ik8hBo8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Hdtr44RGneFeDnVlEkKYN5oZRa3FyCFUh/U8I753wS/tU91r6pBuJfIDqtrEXK/l1
	 XTazeVdY/TH8YLl/JsNc2Gmo6WfVj3Gj+SyI9um2Cnq/NqyJGOZ5ywL03wJS92nmx9
	 fYZRATdTYOg52urZvWChWWZkiXdnFTbal03qHwCg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20251219094702epcas1p1fe96c7eb9cee5124f4f0d995e0e0468c~ClM9xIfQv0732307323epcas1p1J;
	Fri, 19 Dec 2025 09:47:02 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.194]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dXjP22Mdwz6B9m7; Fri, 19 Dec
	2025 09:47:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251219094701epcas1p37f0febda668d0f243aae2cfd3110f51a~ClM8_2oq33127331273epcas1p3p;
	Fri, 19 Dec 2025 09:47:01 +0000 (GMT)
Received: from junbeomyeom03 (unknown [10.246.23.239]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251219094701epsmtip15e8aeea997098f5807c613bdedecbe5f~ClM8xjpEN1850018500epsmtip1H;
	Fri, 19 Dec 2025 09:47:01 +0000 (GMT)
From: "Junbeom Yeom" <junbeom.yeom@samsung.com>
To: "'Gao Xiang'" <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
Cc: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, "'Jaewook Kim'" <jw5454.kim@samsung.com>,
	"'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>
Subject: RE: [PATCH] erofs: fix unexpected EIO under memory pressure
Date: Fri, 19 Dec 2025 18:47:01 +0900
Message-ID: <000001dc70cc$6cc150c0$4643f240$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKJQSbFteedIs8/ccFsZ8lv+FLO8QLYU4qmAjUmpUOzpqlOQA==
Content-Language: ko
X-CMS-MailID: 20251219094701epcas1p37f0febda668d0f243aae2cfd3110f51a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251219071140epcas1p35856372483a973806c5445fa3d2d260b
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>
	<20251219071034.2399153-1-junbeom.yeom@samsung.com>
	<6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>

Hi Xiang,

>
> Hi Junbeom,
>
> On 2025/12/19 15:10, Junbeom Yeom wrote:
>> erofs readahead could fail with ENOMEM under the memory pressure
>> because it tries to alloc_page with GFP_NOWAIT =7C GFP_NORETRY, while
>> GFP_KERNEL for a regular read. And if readahead fails (with
>> non-uptodate folios), the original request will then fall back to
>> synchronous read, and =60.read_folio()=60 should return appropriate errn=
os.
>>
>> However, in scenarios where readahead and read operations compete,
>> read operation could return an unintended EIO because of an incorrect
>> error propagation.
>>
>> To resolve this, this patch modifies the behavior so that, when the
>> PCL is for read(which means pcl.besteffort is true), it attempts
>> actual decompression instead of propagating the privios error except ini=
tial EIO.
>>
>> - Page size: 4K
>> - The original size of FileA: 16K
>> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
>> =5Bpage0, page1=5D =5Bpage2, page3=5D =5BPCL0=5D---------=5BPCL1=5D
>>
>> - functions declaration:
>>    . pread(fd, buf, count, offset)
>>    . readahead(fd, offset, count)
>> - Thread A tries to read the last 4K
>> - Thread B tries to do readahead 8K from 4K
>> - RA, besteffort =3D=3D false
>> - R, besteffort =3D=3D true
>>
>>          <process A>                   <process B>
>>
>> pread(FileA, buf, 4K, 12K)
>>    do readahead(page3) // failed with ENOMEM
>>    wait_lock(page3)
>>      if (=21uptodate(page3))
>>        goto do_read
>>                                 readahead(FileA, 4K, 8K)
>>                                 // Here create PCL-chain like below:
>>                                 // =5Bnull, page1=5D =5Bpage2, null=5D
>>                                 //   =5BPCL0:RA=5D-----=5BPCL1:RA=5D
>> ...
>>    do read(page3)        // found =5BPCL1:RA=5D and add page3 into it,
>>                          // and then, change PCL1 from RA to R ...
>>                                 // Now, PCL-chain is as below:
>>                                 // =5Bnull, page1=5D =5Bpage2, page3=5D
>>                                 //   =5BPCL0:RA=5D-----=5BPCL1:R=5D
>>
>>                                   // try to decompress PCL-chain...
>>                                   z_erofs_decompress_queue
>>                                     err =3D 0;
>>
>>                                     // failed with ENOMEM, so page 1
>>                                     // only for RA will not be uptodated=
.
>>                                     // it's okay.
>>                                     err =3D decompress(=5BPCL0:RA=5D, er=
r)
>>
>>                                     // However, ENOMEM propagated to nex=
t
>>                                     // PCL, even though PCL is not only
>>                                     // for RA but also for R. As a resul=
t,
>>                                     // it just failed with ENOMEM withou=
t
>>                                     // trying any decompression, so page=
2
>>                                     // and page3 will not be uptodated.
>>                  ** BUG HERE ** --> err =3D decompress(=5BPCL1:R=5D, err=
)
>>
>>                                     return err as ENOMEM ...
>>      wait_lock(page3)
>>        if (=21uptodate(page3))
>>          return EIO      <-- Return an unexpected EIO=21
>> ...
>
> Many thanks for the report=21
> It's indeed a new issue to me.
>
>>
>> Fixes: 2349d2fa02db (=22erofs: sunset unneeded NOFAILs=22)
>> Cc: stable=40vger.kernel.org
>> Reviewed-by: Jaewook Kim <jw5454.kim=40samsung.com>
>> Reviewed-by: Sungjong Seo <sj1557.seo=40samsung.com>
>> Signed-off-by: Junbeom Yeom <junbeom.yeom=40samsung.com>
>> ---
>>   fs/erofs/zdata.c =7C 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c index
>> 27b1f44d10ce..86bf6e087d34 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> =40=40 -1414,11 +1414,15 =40=40 static int z_erofs_decompress_queue(cons=
t struct
>z_erofs_decompressqueue *io,
>>   	=7D;
>>   	struct z_erofs_pcluster *next;
>>   	int err =3D io->eio ? -EIO : 0;
>> +	int io_err =3D err;
>>
>>   	for (; be.pcl =21=3D Z_EROFS_PCLUSTER_TAIL; be.pcl =3D next) =7B
>> +		int propagate_err;
>> +
>>   		DBG_BUGON(=21be.pcl);
>>   		next =3D READ_ONCE(be.pcl->next);
>> -		err =3D z_erofs_decompress_pcluster(&be, err) ?: err;
>> +		propagate_err =3D READ_ONCE(be.pcl->besteffort) ? io_err : err;
>> +		err =3D z_erofs_decompress_pcluster(&be, propagate_err) ?: err;
>
> I wonder if it's just possible to decompress each pcluster according to i=
o
> status only (but don't bother with previous pcluster status), like:
>
> 		err =3D z_erofs_decompress_pcluster(&be, io->eio) ?: err;
>
> and change the second argument of
> z_erofs_decompress_pcluster() to bool.
>
> So that we could leverage the successful i/o as much as possible.

Oh, I thought you were intending to address error propagation.
If that's not the case, I also believe the approach you're suggesting is be=
tter.
I'll send the next version.

Thanks,
Junbeom Yeom

>
> Thanks,
> Gao Xiang
>
>>   	=7D
>>   	return err;
>>   =7D
>



