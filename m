Return-Path: <stable+bounces-98262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576A9E368B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 10:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DAC280E0B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C919DF66;
	Wed,  4 Dec 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T+QOU5D3"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B36194A6B;
	Wed,  4 Dec 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304507; cv=none; b=DWqsfaei378/Xqi+2cGX2RkXaPHckjggZF12/Bt3Iyc35UeVhEwOVDWbSuOcRWnKgJbXJ+xyZgv2DyZNlio31KXcn1eN8HkF2WTXU+rG7daj38TPDnt8MmJiqRWWHzLxoHS7S19ItwIDyMLr/Yt34Z1X5vJRfBPm1Oxg8LyUQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304507; c=relaxed/simple;
	bh=fPb+gUHArRImFSZ3m6ISTguhGQqPll9z5HPNIukmekw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsyFPllcioxXshhqT59AHjorPQDuz/YPkaz1kzqM56wsYTZ/HGy9NlxhpCCg/cWjN9PKJ6YHPoHeTLC5PZAY/eoxyPVW62XkoA8sRhaCy6iy3ldAOaz1t4k/HJ1L0cPQL21j+VhakPTbo456ZaYESdFhN5SnMuXi5ywmkpamzhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T+QOU5D3; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733304501; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LYNxVVdDu3mDoogCRWHhH6OyBB2KS2rM9Mj6Zju1qdk=;
	b=T+QOU5D3PEzRWptzEnWJOAP4zx0MXiRJbMgBgON7gVdgohxYPQgZFtyJke0+nIpHzMiwjSTacOmaD3fYVvWOgxF9xD9d1MoSpKy2p1uzcLJlANOV8FP/G5TbpMQIkdGEN7JsHwmOzOQx0dcGL1ifZCDvsQ5tsOLlhW+ce5HZHuE=
Received: from 30.221.128.184(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WKpgXsc_1733304500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Dec 2024 17:28:21 +0800
Message-ID: <58618b80-f1ab-4b22-a3fc-9d29969615a0@linux.alibaba.com>
Date: Wed, 4 Dec 2024 17:28:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, stable@vger.kernel.org
References: <20241204033243.8273-1-heming.zhao@suse.com>
 <20241204033243.8273-2-heming.zhao@suse.com>
 <6c3e1f5a-916c-4959-a505-d3d3917e5c9c@linux.alibaba.com>
 <79b86b7b-8a65-49b8-aa33-bb73de47ad37@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <79b86b7b-8a65-49b8-aa33-bb73de47ad37@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/4/24 2:46 PM, Heming Zhao wrote:
> On 12/4/24 11:47, Joseph Qi wrote:
>>
>>
>> On 12/4/24 11:32 AM, Heming Zhao wrote:
>>> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
>>> unmounting an ocfs2 volume").
>>>
>>> In commit dfe6c5692fb5, the commit log stating "This bug has existed
>>> since the initial OCFS2 code." is incorrect. The correct introduction
>>> commit is 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
>>>
>>
>> Could you please elaborate more how it happens?
>> And it seems no difference with the new version. So we may submit a
>> standalone revert patch to those backported stable kernels (< 6.10).
> 
> commit log from patch [2/2] should be revised.
> change: This bug has existed since the initial OCFS2 code.
> to    : This bug was introduced by commit 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
> 
> ----
> See below for the details of patch [1/2].
> 
> following is "the code before commit 30dd3478c3cd7" + "commit dfe6c5692fb525e".
> 
>    static int ocfs2_sync_local_to_main()
>    {
>        ... ...
>  1      while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start))
>  2             != -1) {
>  3          if ((bit_off < left) && (bit_off == start)) {
>  4              count++;
>  5              start++;
>  6              continue;
>  7          }
>  8          if (count) {
>  9              blkno = la_start_blk +
> 10                   ocfs2_clusters_to_blocks(osb->sb,
> 11                                start - count);
> 12
> 13               trace_ocfs2_sync_local_to_main_free();
> 14
> 15               status = ocfs2_release_clusters(handle,
> 16                               main_bm_inode,
> 17                               main_bm_bh, blkno,
> 18                               count);
> 19               if (status < 0) {
> 20                   mlog_errno(status);
> 21                   goto bail;
> 22               }
> 23           }
> 24           if (bit_off >= left)
> 25               break;
> 26           count = 1;
> 27           start = bit_off + 1;
> 28       }
> 29
> 30     /* clear the contiguous bits until the end boundary */
> 31     if (count) {
> 32         blkno = la_start_blk +
> 33             ocfs2_clusters_to_blocks(osb->sb,
> 34                     start - count);
> 35
> 36         trace_ocfs2_sync_local_to_main_free();
> 37
> 38         status = ocfs2_release_clusters(handle,
> 39                 main_bm_inode,
> 40                 main_bm_bh, blkno,
> 41                 count);
> 42         if (status < 0)
> 43             mlog_errno(status);
> 44      }
>        ... ...
>    }
> 
> bug flow:
> 1. the left:10000, start:0, bit_off:9000, and there are zeros from 9000 to the end of bitmap.
> 2. when 'start' is 9999, code runs to line 3, where bit_off is 10000 (the 'left' value), it doesn't trigger line 3.
> 3. code runs to line 8 (where 'count' is 9999), this area releases 9999 bytes of space to main_bm.
> 4. code runs to line 24, triggering "bit_off == left" and 'break' the loop. at this time, the 'count' still retains its old value 9999.
> 5. code runs to line 31, this area code releases space to main_bm for the same gd again.
> 
> kernel will report the following likely error:
> OCFS2: ERROR (device dm-0): ocfs2_block_group_clear_bits: Group descriptor # 349184 has bit count 15872 but claims 19871 are freed. num_bits 7878
> 

Okay, IIUC, it seems we have to:
1. revert commit dfe6c5692fb5 (so does stable kernel).
2. fix 30dd3478c3cd in following way:

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 5df34561c551..f0feadac2ef1 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -971,9 +971,9 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 	start = count = 0;
 	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
 
-	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <
+	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <=
 	       left) {
-		if (bit_off == start) {
+		if ((bit_off < left) && (bit_off == start)) {
 			count++;
 			start++;
 			continue;
@@ -997,7 +997,8 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 				goto bail;
 			}
 		}
-
+		if (bit_off >= left)
+			break;
 		count = 1;
 		start = bit_off + 1;
 	}

Thanks,
Joseph



