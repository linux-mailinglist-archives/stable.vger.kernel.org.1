Return-Path: <stable+bounces-106055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885359FBA3E
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 08:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF8C1610A1
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2B16F0E8;
	Tue, 24 Dec 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i3vbaqmA"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E56129A78
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735025471; cv=none; b=mLM3o7n+xJOhsv2nN8PY+kTHgGJTOZ3+HRuh8YYDnmuQaEIVN4JFYRr1WhZZcjfOhbPIUBhfkz4mmxO6P+rx6Iltes8ZLdjPIApZQdN2Mg1wzoTaJeFw3J6lm0OAdsFdc4qhMlx5rCVcgyZ6XOpkw97TIG9JgJm7UICIcWV8CI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735025471; c=relaxed/simple;
	bh=vyXEO3T23SWpdUZOwBM2ExxJ1g/SfdC+adZF21CnxPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jr18L62z9yR+TX5bju3mn0U/O3Q3sZ/fMuxvASKx2xOaWtPn7xDmVppwDakucGKQX1B/vKk7la19SsCuqnV4TTstRWG4vM/TVxaTFecbIdwn7yfbSSQHgTVkkMecNgzVBm6pkYPxmquTyXx8gpeMeS2tz/fCZN8ovHd340VZBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i3vbaqmA; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241224073100epoutp0319b42f149641cbe4fdeb4d099741aa94~UDHahyE4V0058600586epoutp03g
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 07:31:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241224073100epoutp0319b42f149641cbe4fdeb4d099741aa94~UDHahyE4V0058600586epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735025460;
	bh=Qa6Qh0gLXzAaNr2t8CyZ7prTde6LFTe5csM82T4eUiM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=i3vbaqmAxSNFYHl6eBfOzHN525BEGJIYWHYvawtxAXOsheUrqcVvX7Kruykb9xBa7
	 O+aIKptLzpmg4uiJXWMeomc+ChbqutV/o8qtiAKPObwu6lLHXnyqaQJagGjo0sPD5H
	 JeoMe2m4lWniCcT2zz5ZCZreX7XIixzkEZ6O4NoM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241224073059epcas5p3fa1e6710c0b7668b637801d14553454a~UDHaEPpUc2176021760epcas5p3A;
	Tue, 24 Dec 2024 07:30:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YHRQ96ryRz4x9QB; Tue, 24 Dec
	2024 07:30:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.A8.20052.1336A676; Tue, 24 Dec 2024 16:30:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241224064253epcas5p178262f60c05d40e50113fdf6995d987a~UCdaDjGgU1268912689epcas5p1e;
	Tue, 24 Dec 2024 06:42:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241224064253epsmtrp110a76d4f237aa727e6b1e63f0ea4d22b~UCdaBcgO01278212782epsmtrp18;
	Tue, 24 Dec 2024 06:42:53 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-67-676a63317e44
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	68.3C.18729.DE75A676; Tue, 24 Dec 2024 15:42:53 +0900 (KST)
Received: from [107.122.5.186] (unknown [107.122.5.186]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241224064250epsmtip167462c80a5d4aea84a907d037aba0aff~UCdXPR3s23103831038epsmtip1X;
	Tue, 24 Dec 2024 06:42:50 +0000 (GMT)
Message-ID: <0375d572-4c88-40ce-af24-62a8b38fb7bf@samsung.com>
Date: Tue, 24 Dec 2024 12:12:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_fs: Remove WARN_ON in functionfs_bind
To: gregkh@linuxfoundation.org, paul@crapouillou.net, Chris.Wulff@biamp.com,
	tudor.ambarus@linaro.org, m.grzeschik@pengutronix.de,
	viro@zeniv.linux.org.uk, quic_jjohnson@quicinc.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, alim.akhtar@samsung.com,
	selvarasu.g@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Akash M/Akash M <akash.m5@samsung.com>
In-Reply-To: <20241219125221.1679-1-akash.m5@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRzveX9sQ2/e62DwOI6AtwywwL0I610C5Qm7UUp4dpllzPfY2xiM
	be4d9kPj5EwICgjL4rcTLA0ShQM0oJBpRwieAzk7wdkU7BJGAkpx5yExXij++zyf7+fzfH89
	jwiV3BfIRHqjlbUYGQMpWIW1XgoLCadS03XymY5I2lXdKqDLpoYR+pbta4S+cuoEQh+uPSug
	j3a0YLTzzixGX2+rFNA13x1B6ebcQYSe/mUep4trBzA6p9mJ03X5lRh9+dQUQl//50eUtjXe
	BfTRLik9PZRCX5vrxl/xUd/5zCFU1w/kCdS3bnQI1J1VPwjVxXNydUlHtrqouQ6oHzY9rW4a
	nUCSvd7OiEljGS1rCWKNqSat3qiLJV/bqdmqiVbIqXBKSb9IBhmZTDaWjN+WHK7SGxb6IoP2
	M4asBSqZ4ThyY1yMxZRlZYPSTJw1lmTNWoM5yhzBMZlcllEXYWStL1FyeWT0gnBvRtoTVxFm
	Lvf/oD0n8xBo8SkAXiJIRMGJiq9AAVglkhDtAE4N1As8AQkxDeDxRwF84G8Aa+1TyLLD8f01
	jA/8BGBu6V8Y75gAsGt4vQeLiTjYfzkfLQAiEUash4MXQ3h6LewpG12US4lA+PtQqdCDvYlE
	eLf5G9xzpw/xCMCR2dnFA0oUI3DePYx7VCjhB4dGjy9WISBegIPDbuDBXoQSttSWobwmEJ6f
	qEQ9ZkjkecF655iQLzse9kx8CXjsDce6m5d4GbxfnLuEt8HTbWdwT9WQ0MLHxw7w9Muw3ta3
	SKNEGDzbtpGnA+CxKw0In3YNLHw8ujQgMbxQvYxJWP3JJM5jCD/tsgH+djWs6Nv3BQguXzGW
	8hVNlq9opvz/xDaA1YF1rJnL1LFctJkysu//t+1UU2YTWHzzGxIvAKdrMsIOEBGwAyhCSR+x
	XaLXScRa5sOPWItJY8kysJwdRC+spwSVSVNNC5/GaNVQUUp5lEKhiFJuUlCkn3j8SJVWQugY
	K5vBsmbWsuxDRF6yQ8j2hCYKS/IGDZvu3Rg/uabxge9MTHxgWI077019HPFM7lvBjkLVefxz
	dPfOzT3mGZiAFDINiLhxvgDP7zoYuSNBKA3YMv5bqNCVjBcl+ffW3CR7n2O364NUzrluV5nk
	0ni6A1dppDF7Et71TTTdfAjOyZSOn98bHrXfSwrdqwho65zn3FsC+kJSTA293mO/Vkw+/+ra
	3TmDfzqedaTvKvE1rdunHEmJPPDGmV32KuqkVRbq2uPXbvjYNP+H5qns6WxbyP53WmtinKfZ
	1TN60B/9evAJhST2qtGtnLsqu5h7ePPqByMt/qUHqVB4+/a3T+bcqgYmYse5/q4Ov61D0k4S
	49IYagNq4Zh/AerDd4R8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSnO7b8Kx0g3MzeCwezNvGZjHz420m
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPF4vKuOWwWi5a1MltsabvCZPHp6H9Wi/7Fl1gs
	GrfcZbVY1TmHxeLI8o9MFpe/72S2WLDxEaPFpIOiFp9uxVmc/3uc1UHE42H3BXaP1Zfa2Tzu
	XNvD5rF/7hp2j/6/Bh4T99R59G1ZxejxeZOcx6Ynb5kCOKO4bFJSczLLUov07RK4Mv496GMp
	mCVdsbsxt4Fxq0gXIyeHhICJxIWV51m6GLk4hAR2M0qs23WHHSIhIXHn5002CFtYYuW/5+wQ
	Ra8ZJfY8OQBWxCtgJ3HxSCdzFyMHB4uAqsSVA+oQYUGJkzOfsIDYogLyEvdvzQArFxbwlHi0
	ZToryBwRgS+MEpuWrmAEcZgF+pkk1n75DrWhh1Gi5f5bZpAWZgFxiVtP5jOB2GwCOhJXbr9h
	BLE5BSwlti6eCVVjJtG1tYsRwpaX2P52DvMERqFZSC6ZhWTULCQts5C0LGBkWcUomVpQnJue
	W2xYYJiXWq5XnJhbXJqXrpecn7uJERzbWpo7GLev+qB3iJGJg/EQowQHs5II7yGhzHQh3pTE
	yqrUovz4otKc1OJDjNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTNEenxUX9pabtq9o
	f7Dp7kXHKkWxF89FTxmEW+e8duwxusrF+unfEh627vxzli8SuQNeb+6YeIxFtPvwRK74t0q9
	5/7J58w7wFlRVbzv+ISVXzZu/nD/o8GUi8aips90ekxL319VCg1nZqg6balZlr5oq/2dxy+r
	TNOOBu2JWLTeRZNx1Vzu4CwJx0kyfi5Pc3n/v/Te90m1mKcwMDzPYNn3fvUlx0t+f9bbdKn3
	jOXdxKRPO+cwyVs2lMgubGauudVRzlTjyrMiVs/4bvvqX/NmzHvnLpX9Tiz636wViZmHVdZ0
	MvK0uWquyrCXXqbuOvHatpfXTEp73OtmMGn84U7aLiTNyGoQeunP5BlqSizFGYmGWsxFxYkA
	Wp5KlVwDAAA=
X-CMS-MailID: 20241224064253epcas5p178262f60c05d40e50113fdf6995d987a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241219125248epcas5p3887188e4df29b7b580cce9cfe6fed79f
References: <CGME20241219125248epcas5p3887188e4df29b7b580cce9cfe6fed79f@epcas5p3.samsung.com>
	<20241219125221.1679-1-akash.m5@samsung.com>


On 12/19/2024 6:22 PM, Akash M wrote:
> This commit addresses an issue related to below kernel panic where
> panic_on_warn is enabled. It is caused by the unnecessary use of WARN_ON
> in functionsfs_bind, which easily leads to the following scenarios.
>
> 1.adb_write in adbd               2. UDC write via configfs
>    =================	             =====================
>
> ->usb_ffs_open_thread()           ->UDC write
>   ->open_functionfs()               ->configfs_write_iter()
>    ->adb_open()                      ->gadget_dev_desc_UDC_store()
>     ->adb_write()                     ->usb_gadget_register_driver_owner
>                                        ->driver_register()
> ->StartMonitor()                       ->bus_add_driver()
>   ->adb_read()                           ->gadget_bind_driver()
> <times-out without BIND event>           ->configfs_composite_bind()
>                                            ->usb_add_function()
> ->open_functionfs()                        ->ffs_func_bind()
>   ->adb_open()                               ->functionfs_bind()
>                                         <ffs->state !=FFS_ACTIVE>
>
> The adb_open, adb_read, and adb_write operations are invoked from the
> daemon, but trying to bind the function is a process that is invoked by
> UDC write through configfs, which opens up the possibility of a race
> condition between the two paths. In this race scenario, the kernel panic
> occurs due to the WARN_ON from functionfs_bind when panic_on_warn is
> enabled. This commit fixes the kernel panic by removing the unnecessary
> WARN_ON.
>
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> [   14.542395] Call trace:
> [   14.542464]  ffs_func_bind+0x1c8/0x14a8
> [   14.542468]  usb_add_function+0xcc/0x1f0
> [   14.542473]  configfs_composite_bind+0x468/0x588
> [   14.542478]  gadget_bind_driver+0x108/0x27c
> [   14.542483]  really_probe+0x190/0x374
> [   14.542488]  __driver_probe_device+0xa0/0x12c
> [   14.542492]  driver_probe_device+0x3c/0x220
> [   14.542498]  __driver_attach+0x11c/0x1fc
> [   14.542502]  bus_for_each_dev+0x104/0x160
> [   14.542506]  driver_attach+0x24/0x34
> [   14.542510]  bus_add_driver+0x154/0x270
> [   14.542514]  driver_register+0x68/0x104
> [   14.542518]  usb_gadget_register_driver_owner+0x48/0xf4
> [   14.542523]  gadget_dev_desc_UDC_store+0xf8/0x144
> [   14.542526]  configfs_write_iter+0xf0/0x138
>
> Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akash M <akash.m5@samsung.com>
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 2920f8000bbd..92c883440e02 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -2285,7 +2285,7 @@ static int functionfs_bind(struct ffs_data *ffs, struct usb_composite_dev *cdev)
>   	struct usb_gadget_strings **lang;
>   	int first_id;
>   
> -	if (WARN_ON(ffs->state != FFS_ACTIVE
> +	if ((ffs->state != FFS_ACTIVE
>   		 || test_and_set_bit(FFS_FL_BOUND, &ffs->flags)))
>   		return -EBADFD;
>   
Hi Greg,

I realized there's a minor nitpick with the patch I submitted - 
specifically a pair of extra brackets not removed.

Do you want me to proceed with sending a v2 to address this, or is this 
something you can take care while applying this patch?

Looking forward to your advice.

Thanks,
Akash


