Return-Path: <stable+bounces-58101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA0B9280E5
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 05:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9362B28529F
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 03:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0465374D9;
	Fri,  5 Jul 2024 03:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jksFuCqt"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18371643D
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720149931; cv=none; b=bQInv06ecVuZctxsT5B7TdC5q2UR06s/GyXae+sXSA6z1cGPKDHF9WSoapw2hEslD2KYZze5Mek6KB2MpgB532JrN3JIgO7pLB9OrN6TRxs1JsSnCPab0jAEr9bluJgd0Vc9OcnCsvJpm3yOike/7WM+m7ujH4SiijTf6itP1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720149931; c=relaxed/simple;
	bh=zc4AYFqRgcIvQwIMU5h9ij793SIqxwM85rq2HsyS8lM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=S8i/lPL5KrWVbJ8tIKf/Mi0ZxDFLuEvfgvxwOfk8NWMYzUzCIjySp2MhhMtB70PYX8cL0J3tKdcNnb2wAO8jVDv9gu01cLN8mgeqrpgMJ/4SCgrXXduHGubs2aV1/1loRurkoMHc5NMHsDoL8VJrzm/c1+yCb8H8F4+RTY+NQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jksFuCqt; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240705032526epoutp0169af48e78f19f7748576f65b20b13603~fMz6eCZuj2760127601epoutp012
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 03:25:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240705032526epoutp0169af48e78f19f7748576f65b20b13603~fMz6eCZuj2760127601epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720149926;
	bh=c2akXWdwizOakaqRvB+3LJRxsd3egtycp0Se6+3BgO0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=jksFuCqtAHoHIffnyfKOJW+DZnd1BxNRiiXqWKfeyLDptZqdCsnhPhOTIrIdyh6h/
	 ARNpzppaL1pEDZazm8pmHARdyElKarSVGmvmC35FcLFHY6hV4XHrIhf9p/QDQmLVmi
	 57jsUQz0eEBZmAHF7MCAXv4BJYE4fY0OrufZ5y/g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240705032525epcas1p3e838bdd625cf176d03741edbab501e63~fMz5moEc91149111491epcas1p3e;
	Fri,  5 Jul 2024 03:25:25 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.241]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WFf6F2rQRz4x9Pq; Fri,  5 Jul
	2024 03:25:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.5C.09561.5A767866; Fri,  5 Jul 2024 12:25:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240705032524epcas1p2ae7bb5095870e55148997ce06f8695c6~fMz41MwdF0215002150epcas1p2I;
	Fri,  5 Jul 2024 03:25:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240705032524epsmtrp23b3144e21a7fc2a20454c6ea05a70adf~fMz40jQp41750017500epsmtrp2D;
	Fri,  5 Jul 2024 03:25:24 +0000 (GMT)
X-AuditID: b6c32a39-dd5fd70000002559-ee-668767a58a48
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.86.07412.4A767866; Fri,  5 Jul 2024 12:25:24 +0900 (KST)
Received: from sminjeong05 (unknown [10.253.99.183]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240705032524epsmtip2699116c87a795532fd09e4ccdc1f3db2~fMz4oV1dW1112811128epsmtip2Q;
	Fri,  5 Jul 2024 03:25:24 +0000 (GMT)
From: "Sunmin Jeong" <s_min.jeong@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc: <linux-f2fs-devel@lists.sourceforge.net>, <daehojeong@google.com>,
	<stable@vger.kernel.org>, "'Sungjong Seo'" <sj1557.seo@samsung.com>,
	"'Yeongjin Gil'" <youngjin.gil@samsung.com>
In-Reply-To: <5d8802d6-0132-4986-8238-9385d1758719@kernel.org>
Subject: RE: [PATCH 1/2] f2fs: use meta inode for GC of atomic file
Date: Fri, 5 Jul 2024 12:25:24 +0900
Message-ID: <000001dace8a$f97d2d30$ec778790$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEZTfcOKL6689m8bwnAn2Uwn8IfUQGex/DPAyyu6GKzRBicMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmge7S9PY0g8V3+S1OTz3LZDG1fS+j
	xZP1s5gtLi1yt9jy7wirxYKNjxgtZux/yu7A7rFgU6nHplWdbB67F3xm8ujbsorR4/MmuQDW
	qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAjlBTK
	EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZ
	GS3nzrMWPFeqODXrBGMD4wnpLkZODgkBE4lvJ44zdjFycQgJ7GCUuNT3hAnC+cQo0fzvNSuE
	841R4vzmDlaYloczLkIl9jJKLPnUCtX/klFi+Z+vjCBVbAJ6EtNX/2MGsUUEzCX2LH7FBlLE
	LLCbUWLph4tgCU4BO4kd744BJTg4hAWcJZ5/kgcxWQRUJGY/NgOp4BWwlPhzegsrhC0ocXLm
	ExYQm1lAXmL72znMEAcpSPx8uowVYpWTRG/TbjaIGhGJ2Z1tzCBrJQSmckhcvv+WBaLBReLr
	mW/sELawxKvjW6BsKYnP7/ayQdjFEkfnb2CHaG5glLjx9SZUkb1Ec2sz2M3MApoS63fpQyzj
	k3j3tYcVJCwhwCvR0SYEUa0q0f1oCdSd0hLLjh2EmuIh8XfpfJYJjIqzkLw2C8lrs5C8MAth
	2QJGllWMYqkFxbnpqcWGBabw2E7Oz93ECE6gWpY7GKe//aB3iJGJg/EQowQHs5IIr9T75jQh
	3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA9M4Xkl8YYmlgYmZkYmFsaWxmZK4rxnrpSlCgmk
	J5akZqemFqQWwfQxcXBKNTA5pO3SE745wecjW/uK24uNsgT/zs/Zz5VZvMD5LZufo2ly3rsy
	1sNqJxpe6BStyL+iqLTW1cBKcKWid28m3/6TooE7999vS05yPavDtqFph39w6gOnasHbYV84
	oz2YPkss7trAyHdp0tzbz61WrDZszL4ivK7H014j3ar/uvuaH70yd4VcpBOE/LLn5tz88erK
	cTa1X6cfPH/+RO0vbzObf7r9xiOy3MfvLysoP2tlYr7Kr1dLkutfVGNefbZfVEEt37/FGetW
	MVVe7PCe/Eg/aXawScw314rfxyrVrJjLPyzes8nbRz+067LqaQW7+E1nXiS6r+Tjrs+/pOtQ
	VBa4xO+zj9qEW/b3o5XXKLEUZyQaajEXFScCAFeIqKopBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvO6S9PY0g1kNxhanp55lspjavpfR
	4sn6WcwWlxa5W2z5d4TVYsHGR4wWM/Y/ZXdg91iwqdRj06pONo/dCz4zefRtWcXo8XmTXABr
	FJdNSmpOZllqkb5dAldGy7nzrAXPlSpOzTrB2MB4QrqLkZNDQsBE4uGMi6xdjFwcQgK7GSVm
	Xp7M3sXIAZSQljj2pwjCFJY4fLgYouQ5o8S5E6dZQHrZBPQkpq/+xwxiiwhYSiyYdY4FpIhZ
	YD+jRPeSvYwQHQcZJXoPfQPr4BSwk9jx7hgbyFRhAWeJ55/kQUwWARWJ2Y/NQCp4geb8Ob2F
	FcIWlDg58wlYJ7OAtsTTm0+hbHmJ7W/nMEPcryDx8+kyVogbnCR6m3azQdSISMzubGOewCg8
	C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYLjSEtjB+O9
	+f/0DjEycTAeYpTgYFYS4ZV635wmxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU
	7NTUgtQimCwTB6dUA9OEXeIbnfRiVP9nVfXVBk89UmrNd2p94tojaWzFu4oXlbqfzb2fOO/c
	9Rlbyl4XnLp7vE/fev87o/JtwbvYSmc+1ju1rdwhYEPNBLHPvlX3jeLdHDpeWjuHtfxp6A9t
	bX2cds2fwz3Bzt9/igD3Z2n9WXGX2dp6Y1wF0rimyqndfbrvyvTHmn8uM9q1dIXpr4nheWR4
	Ye+BG4w88yb2mjY+dL55+Nqf+4Xtl/ftYvUOZNl75+HOF27nl1p++7X56emmvy2P/SZ9uPFZ
	rsBl6sWjxTwpRrw2rkfj1d6bdwpciNL5a7GU74n2lTmu1Q3hhQtCGLtNWyb8DUqffohhPfvt
	hUlKh1c80HY12KxRs1mJpTgj0VCLuag4EQBtvIKmEgMAAA==
X-CMS-MailID: 20240705032524epcas1p2ae7bb5095870e55148997ce06f8695c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99
References: <CGME20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99@epcas1p1.samsung.com>
	<20240702120624.476067-1-s_min.jeong@samsung.com>
	<5d8802d6-0132-4986-8238-9385d1758719@kernel.org>

Hi Chao Yu,

>> The page cache of the atomic file keeps new data pages which will be
>> stored in the COW file. It can also keep old data pages when GCing the
>> atomic file. In this case, new data can be overwritten by old data if
>> a GC thread sets the old data page as dirty after new data page was
>> evicted.
>>
>> Also, since all writes to the atomic file are redirected to COW
>> inodes, GC for the atomic file is not working well as below.
>>
>> f2fs_gc(gc_type=FG_GC)
>>    - select A as a victim segment
>>    do_garbage_collect
>>      - iget atomic file's inode for block B
>>      move_data_page
>>        f2fs_do_write_data_page
>>          - use dn of cow inode
>>          - set fio->old_blkaddr from cow inode
>>      - seg_freed is 0 since block B is still valid
>>    - goto gc_more and A is selected as victim again
>>
>> To solve the problem, let's separate GC writes and updates in the
>> atomic file by using the meta inode for GC writes.
>>
>> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
>> Cc: stable@vger.kernel.org #v5.19+
>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
>> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
>> ---
>>   fs/f2fs/f2fs.h    | 5 +++++
>>   fs/f2fs/gc.c      | 6 +++---
>>   fs/f2fs/segment.c | 4 ++--
>>   3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
>> a000cb024dbe..59c5117e54b1 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4267,6 +4267,11 @@ static inline bool f2fs_post_read_required(struct
>inode *inode)
>>   		f2fs_compressed_file(inode);
>>   }
>>
>> +static inline bool f2fs_meta_inode_gc_required(struct inode *inode) {
>> +	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
>> +}
>> +
>>   /*
>>    * compress.c
>>    */
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c index
>> a079eebfb080..136b9e8180a3 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1580,7 +1580,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi,
>struct f2fs_summary *sum,
>>   			start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
>>   								ofs_in_node;
>>
>> -			if (f2fs_post_read_required(inode)) {
>> +			if (f2fs_meta_inode_gc_required(inode)) {
>>   				int err = ra_data_block(inode, start_bidx);
>>
>>   				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> @@ -1631,7 +1631,7 @@ static int gc_data_segment(struct f2fs_sb_info
>> *sbi, struct f2fs_summary *sum,
>>
>>   			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
>>   								+ ofs_in_node;
>> -			if (f2fs_post_read_required(inode))
>> +			if (f2fs_meta_inode_gc_required(inode))
>>   				err = move_data_block(inode, start_bidx,
>>   							gc_type, segno, off);
>>   			else
>> @@ -1639,7 +1639,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi,
>struct f2fs_summary *sum,
>>   								segno, off);
>>
>>   			if (!err && (gc_type == FG_GC ||
>> -					f2fs_post_read_required(inode)))
>> +					f2fs_meta_inode_gc_required(inode)))
>>   				submitted++;
>>
>>   			if (locked) {
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
>> 7e47b8054413..b55fc4bd416a 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3823,7 +3823,7 @@ void f2fs_wait_on_block_writeback(struct inode
>*inode, block_t blkaddr)
>>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>   	struct page *cpage;
>>
>> -	if (!f2fs_post_read_required(inode))
>> +	if (!f2fs_meta_inode_gc_required(inode))
>>   		return;
>>
>>   	if (!__is_valid_data_blkaddr(blkaddr))
>> @@ -3842,7 +3842,7 @@ void f2fs_wait_on_block_writeback_range(struct
>inode *inode, block_t blkaddr,
>>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>   	block_t i;
>>
>> -	if (!f2fs_post_read_required(inode))
>> +	if (!f2fs_meta_inode_gc_required(inode))
>>   		return;
>>
>>   	for (i = 0; i < len; i++)
>
>f2fs_write_single_data_page()
>...
>		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
>
>Do we need to use f2fs_meta_inode_gc_required() here?
>
>Thanks,

As you said, we need to use f2fs_meta_inode_gc_required instead of
f2fs_post_read_required. Then what about changing the variable name
"post_read" to another one such as "meta_gc"? 
struct f2fs_io_info {
    unsigned int post_read:1;   /* require post read */

Thanks,


