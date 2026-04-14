Return-Path: <stable+bounces-237915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAADNHVl3mmxDgAAu9opvQ
	(envelope-from <stable+bounces-237915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:04:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0343FC4D0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1807F308F309
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3E3ED103;
	Tue, 14 Apr 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sCxxHwsL"
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160A3ED134;
	Tue, 14 Apr 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182462; cv=none; b=dlMGr4NAUMopDlM5v4+F8sAtOkktW28veyrDJDhUZcUrN3t9i6tCMyM7l3rN0GxYIl8DX1hfblQ5yo4tB289UkGEhqXi/rCOYcfZZB1J3h6nSttj27TPh0OVXoyh1rVMDtpAxIFmUSr0ShiX17xzUMVKqAuqunChEeTTFCYToY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182462; c=relaxed/simple;
	bh=Nb9E54j7JyxXwYaQivc4l1ZjfAyBVLqpdSCtzLODBSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6qyNnr1PpJyiGTu/cPtBvEZVnelAIdY7VNO7GS/8p9aMG1M5c9zHkdRpfD/jSHcoM49cPmHHVrXaZWPyljAr0uYO4u9hYYkmAxLiv+cBfQwVCpo3Xy2uO7K/YjvTpFiMAZ71qhy1s38hrBKVYkKPbZuTgLQPje5+ipJr2OgMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sCxxHwsL; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776182450; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lISCl8I5Buw+OwTlgs9srKojhMfaMOl9ogFWa04xFyE=;
	b=sCxxHwsL+8xReDxjhdtuhgxOIFlHCiN6v12jZMSPvZFLdn2usxuj2vPbkmzxaJU+STOQHMAr6+WyyQHs8IS4aLhvzOFcUrxxDAnRQR4mO01LEGgy05HLZ45tndxO8ZxV+Ma7fl7GiQLQQb2eiw/OhkuJ+5VSChB9dMlnshDHhp0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X11pYal_1776182448;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X11pYal_1776182448 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Apr 2026 00:00:49 +0800
Message-ID: <d373198b-d32a-49f4-9044-63c7b474f2ea@linux.alibaba.com>
Date: Wed, 15 Apr 2026 00:00:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: validate nameoff for all dirents in
 erofs_fill_dentries()
To: Junrui Luo <moonafterrain@outlook.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Miao Xie <miaoxie@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <SYBPR01MB78819C794EC3532E5E7FCB3CAF252@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237915-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E0343FC4D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Junrui,

On 2026/4/14 23:20, Junrui Luo wrote:
> erofs_readdir() validates de[0].nameoff before calling
> erofs_fill_dentries(), but subsequent dirents are used without
> validation. The loop computes `maxsize - nameoff` as an unsigned int
> to bound strnlen().

The issue is true, but I don't think the description is valid.

I think what we missed is to check the last dirent nameoff vs
maxsize.

BTW, please don't "To" too many people (especially Miao Xie
and Greg), basically I think you only need to post to people
according to `./checkpoint.pl` but leave indivudual person
into "Cc" instead.

> 
> If a crafted EROFS image has a dirent with nameoff >= maxsize, the
> subtraction underflows, causing strnlen() to read past the block
> buffer.
> 
> Fix by validating each entry's nameoff at the top of the loop: it
> must be >= nameoff0 and <= maxsize.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>   fs/erofs/dir.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index e5132575b9d3..2efa16fa162f 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -19,6 +19,13 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   		const char *de_name = (char *)dentry_blk + nameoff;
>   		unsigned int de_namelen;
>   
> +		if (nameoff < nameoff0 || nameoff > maxsize) {
> +			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
> +				  EROFS_I(dir)->nid);
> +			DBG_BUGON(1);
> +			return -EFSCORRUPTED;
> +		}

I think the only thing we need is the following diff:

[The reason why nameoff < nameoff0 is unneeded, since
  `de_namelen > EROFS_NAME_LEN` ensures the nameoff delta
  won't be negative (so nameoff will increase.)

  and `nameoff + de_namelen > maxsize` implies
  `nameoff > maxsize` so `nameoff > maxsize` is unneeded too.]

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index e5132575b9d3..e0666d6da9af 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -20,19 +20,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		unsigned int de_namelen;

  		/* the last dirent in the block? */
-		if (de + 1 >= end)
+		if (de + 1 >= end) {
+			if (maxsize <= nameoff)
+				goto err_bogus;
  			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		} else {
  			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		}

  		/* a corrupted entry is found */
  		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		    de_namelen > EROFS_NAME_LEN)
+			goto err_bogus;

  		if (!dir_emit(ctx, de_name, de_namelen,
  			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
@@ -42,6 +41,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
  		ctx->pos += sizeof(struct erofs_dirent);
  	}
  	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
  }

  static int erofs_readdir(struct file *f, struct dir_context *ctx)


Thanks,
Gao Xiang

> +
>   		/* the last dirent in the block? */
>   		if (de + 1 >= end)
>   			de_namelen = strnlen(de_name, maxsize - nameoff);
> 
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260414-fixes-ae20cd389f52
> 
> Best regards,


