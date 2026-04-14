Return-Path: <stable+bounces-237920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPxUMARq3mmxDgAAu9opvQ
	(envelope-from <stable+bounces-237920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:23:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA03FC836
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF103096381
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396763ED135;
	Tue, 14 Apr 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f4SzBNob"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF6314B73;
	Tue, 14 Apr 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183498; cv=none; b=PTJOLB4ml+BcjCuMFSAYYJaWL+2kwnaUELVmmQYY11fiMNt1vx/5J3SWJ3ssCsrLc5qoCR/jnf02JVc0UhRBa4gw8w5HH9WE1R8Ffq4nVtF1sPBTilwqeIue9pSiVu7fX3snPtmXqk7N+BGakZaBxpK8cIrXZVN6YJnUSRcNMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183498; c=relaxed/simple;
	bh=chQ/ir+f8fr+PMHwcqj8Du2QS0Gx+whnUQ2tb4QJSz8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ju5PH86+Y979We5kjgN9ZHuCtHUs24e/36OaA1Vn7eOAQUJwJKeLUq8BMqlKQ/TO8+qxbOqnfz4AnBk6zdoRgY4g8Tb34S8MfOw0A3JjJnuozdO90d3rwCIY0ENKyHXT1nLbUgDYejuqDJCcl7uu+0XZ8JJQv16SlailS5VgHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f4SzBNob; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776183486; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=aRCg1Ohq04OYnRp+wabVrBC782Swic30XU0PY1//jLQ=;
	b=f4SzBNobOD+mdcnHkZ8WKk1+UvhvZPaFcXLg3PPDoQWh0BCGGQ1TBz2p/XH6KuoJl9KX/hv8jww44AM441IdWYaB6p2w0om/n8cq5189WXduvRrPthHIGSXDNgTIEW3st/TesXEjq0IlSqQLvORcTBP2BDmIxor6cD4V5N9o6+A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X11tIPm_1776183485;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X11tIPm_1776183485 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Apr 2026 00:18:06 +0800
Message-ID: <9599562c-fcc8-4990-99e6-85b6db2f5c7b@linux.alibaba.com>
Date: Wed, 15 Apr 2026 00:18:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: validate nameoff for all dirents in
 erofs_fill_dentries()
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Miao Xie <miaoxie@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <d373198b-d32a-49f4-9044-63c7b474f2ea@linux.alibaba.com>
In-Reply-To: <d373198b-d32a-49f4-9044-63c7b474f2ea@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237920-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org,linux.alibaba.com,google.com,huawei.com,vivo.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 21FA03FC836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/15 00:00, Gao Xiang wrote:
> Hi Junrui,
> 
> On 2026/4/14 23:20, Junrui Luo wrote:
>> erofs_readdir() validates de[0].nameoff before calling
>> erofs_fill_dentries(), but subsequent dirents are used without
>> validation. The loop computes `maxsize - nameoff` as an unsigned int
>> to bound strnlen().
> 
> The issue is true, but I don't think the description is valid.
> 
> I think what we missed is to check the last dirent nameoff vs
> maxsize.
> 
> BTW, please don't "To" too many people (especially Miao Xie
> and Greg), basically I think you only need to post to people
> according to `./checkpoint.pl` but leave indivudual person
> into "Cc" instead.
> 
>>
>> If a crafted EROFS image has a dirent with nameoff >= maxsize, the
>> subtraction underflows, causing strnlen() to read past the block
>> buffer.
>>
>> Fix by validating each entry's nameoff at the top of the loop: it
>> must be >= nameoff0 and <= maxsize.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
>> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
>> ---
>>   fs/erofs/dir.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index e5132575b9d3..2efa16fa162f 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -19,6 +19,13 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>           const char *de_name = (char *)dentry_blk + nameoff;
>>           unsigned int de_namelen;
>> +        if (nameoff < nameoff0 || nameoff > maxsize) {
>> +            erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
>> +                  EROFS_I(dir)->nid);
>> +            DBG_BUGON(1);
>> +            return -EFSCORRUPTED;
>> +        }
> 
> I think the only thing we need is the following diff:
> 
> [The reason why nameoff < nameoff0 is unneeded, since
>   `de_namelen > EROFS_NAME_LEN` ensures the nameoff delta
>   won't be negative (so nameoff will increase.)
> 
>   and `nameoff + de_namelen > maxsize` implies
>   `nameoff > maxsize` so `nameoff > maxsize` is unneeded too.]

A even better diff is as below:

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index e5132575b9d3..2b8375c7d523 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		const char *de_name = (char *)dentry_blk + nameoff;
  		unsigned int de_namelen;

-		/* the last dirent in the block? */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		/* non-trailing dirent in the directory block? */
+		if (de + 1 < end)
  			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		else if (maxsize <= nameoff)
+			goto err_bogus;
+		else
+			de_namelen = strnlen(de_name, maxsize - nameoff);

  		/* a corrupted entry is found */
-		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		if (!clamp(de_namelen, 1, EROFS_NAME_LEN) ||
+		    nameoff + de_namelen > maxsize)
+			goto err_bogus;

  		if (!dir_emit(ctx, de_name, de_namelen,
  			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
@@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		ctx->pos += sizeof(struct erofs_dirent);
  	}
  	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
  }

  static int erofs_readdir(struct file *f, struct dir_context *ctx)

