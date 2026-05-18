Return-Path: <stable+bounces-249158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJNYDitlCmpu0wQAu9opvQ
	(envelope-from <stable+bounces-249158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:02:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74600564A53
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DC02300F52A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C11DED5C;
	Mon, 18 May 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RToyfZ8n"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE31DE3DC
	for <stable@vger.kernel.org>; Mon, 18 May 2026 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066152; cv=none; b=lM7ft9SSYUnf4bNOsiFx+pmmSlRaCLcPuSpvKb/ZhLiERf5rIQtUEy7kU4QURbvn9OyazR+8m+0RN2N4WGhENkNKEpT3oezzv9KajgbvQRNO3zbJ4SVzh2PcMR/secpHqZ7Z7Q71hLEZKVcWiH1o9yem2GdUVGX/HHdMup77tiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066152; c=relaxed/simple;
	bh=ppDo6lY4EgDm1UvbFn26ys4DZhwkX2RjDb9QoQbtrRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bdvy3gywzRrcH/pRyzWygMaLNxuS0l1EQ6nWXZKHfESB+AblNNX29HacWxKXKV1GwCWtk7/vMtD3YktSC8O7RTmof7tGKutfAB1eqZWlmL2CV+H1hZXN7OnWGVT8SF05SwCjHA2wLyS7auf8Ix0qed8yArk7Il7AaxBwl0YMJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=RToyfZ8n; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40427db1300so1639437fac.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 18:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779066147; x=1779670947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAyxR58Fwui0t3p4KL1oNmRW0W2CBG5utIFQCEI3LBE=;
        b=RToyfZ8nL4ts30PEScHdrYEWMnbXKZBkLNcJQA68Y1Rmbic3JF5uT0u0yaeSKQuPTp
         iKgdBxRvhFPfdWgT82Ch57FCpLfqjOyRXqL2PxKhYQdE0V4UgKtCx/Alb+uQtiX+Vsm5
         O+8ZYGMt0YllGZvHVbIS3ldA+PP2soobaO11/RLUEEajYZ63djv4B0A9SHJZSImGBF5x
         W2Amv+OgUsfSeDW3I1rRI/3mqGKPbJ709v5DHnttHrH6M2d7xEOWFlleuvpvGodL/Fr2
         lF2B4KNsW13yCgK+wV0yEsfwdxmChAR0c1M3/MtBbrb9KohkThywefZeUTKW1PhNH+dV
         pMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066147; x=1779670947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAyxR58Fwui0t3p4KL1oNmRW0W2CBG5utIFQCEI3LBE=;
        b=AMWhGSege4ccyMLA8TZXGnGLPHLALBNBllD0ILLx8VynTnCEM5V/aYvWqruBXPB69e
         cIRftSqvRjPI30V0u+dP9ZsFRuJjp0HiHwTlEjeZJQWa5MypX+gviM+Sr1ozk6l2l4mK
         mToVtltebaGkmKojxaZahxC8E4G9SSVd6JpWo//fk7jNOnURNnftnOrEVc9XnhzUHa8e
         xY6FigD5ZECIjA0LyM81nQ1YKqOiMndCF616tQUe2fQn2Jkw4jkCZoUYlhWCB7Vu/bcg
         Siw74LSGCF+IagNnAoBXA/IDIWZ+1yr6Trpz+s6n1l1LcNKMmoBGyn81EnSdZp7H7Qlc
         9Isw==
X-Forwarded-Encrypted: i=1; AFNElJ/6W3HuvAZOw3BU9CLRDaFzY3ZNkx/UQGJLaMusBwbQLQgt7Ve/DdjMYj1ZLaYXGx8HHM+xBoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJbbkbA3eBCJU5JcqARVE0dL7JwGDIFw7s/gIErstn6cOvsrU
	NBQyXCziqUm5OlSARw9hDKK3wQl+c5Mw14hHBi9mSOopbeTSUcu9KO4jF7YsjREy4HBivAq25Sv
	SjU+8
X-Gm-Gg: Acq92OHlt1xC8bX6oY/qdkfa8SeFcWVLz9gncDqrX+U7XxWfisKQeRnmzzKhR4i39Pr
	lN/hR2EV9FnbE1iOsdQ0rBNHwbp+BMquXwDUqLM7CR8YIM6RIxzIJ6bx7W6rzmugF4GkPbY80jY
	l6gXt+IuqeU2ZIi5ZbmyuGBwuB81EHeHqiFFrZ0NO8HF6BzTDSkIWFkdzuxpUwQHq7hRLaBl7lg
	nmsD9K//IXfscQ2Rnk8nbNFIRUvBm2dTJUXOEj4BeGQWBSvTpn1he09d6QZcndsDF4m7KRlJnr4
	8ZNZiAIsH61hHZcg8EsrvjMLJ0A8GOLvlvkIXF5iLVvJ6ocLtn7uPdi/vkhy31Zr5dYTtVtJYJ9
	TTJg+sPf7PdEI4+6WeTrHtA3l7WuJnEnilng+nQ0ep5AOGoM/066PKGevthlHkjzqWC3CSNJXjr
	D08qhEs/3aYf6WkAFTpSiNqPPlfpqSY6RCDKofRkn9j94Pnh1SwusIhGK0mjGOMGCq4b1p3ph1w
	yDi8ZDLqA==
X-Received: by 2002:a05:6820:1807:b0:696:757d:1942 with SMTP id 006d021491bc7-69c9436a31fmr7784772eaf.32.1779066147281;
        Sun, 17 May 2026 18:02:27 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94f49e25sm3012258fac.2.2026.05.17.18.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 18:02:26 -0700 (PDT)
Message-ID: <bc8ede5a-ab28-4191-9153-7e66c28916ac@kernel.dk>
Date: Sun, 17 May 2026 19:02:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 130/144] io_uring/kbuf: support min length left for
 incremental buffers
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Martin Michaelis <code@mgjm.de>,
 Gabriel Krisman Bertazi <krisman@suse.de>,
 Vegard Nossum <vegard.nossum@oracle.com>
References: <20260515154653.469907118@linuxfoundation.org>
 <20260515154656.529062291@linuxfoundation.org>
 <876ac528-b2db-4d52-afff-2a44f13a6767@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <876ac528-b2db-4d52-afff-2a44f13a6767@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 74600564A53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-249158-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mgjm.de:email]
X-Rspamd-Action: no action

On 5/17/26 12:39 PM, Harshit Mogalapalli wrote:
> Hi Greg and Jens,
> 
> On 15/05/26 21:19, Greg Kroah-Hartman wrote:
>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Martin Michaelis <code@mgjm.de>
>>
>> commit 7deba791ad495ce1d7921683f4f7d1190fa210d1 upstream.
>>
>> Incrementally consumed buffer rings are generally fully consumed, but
>> it's quite possible that the application has a minimum size it needs to
>> meet to avoid truncation. Currently that minimum limit is 1 byte, but
>> this should be a setting that is the hands of the application. For
>> recvmsg multishot, a prime use case for incrementally consumed buffers,
>> the application may get spurious -EFAULT returned at the end of an
>> incrementally consumed buffer, as less space is available than the
>> headers need.
>>
>> Grab a u32 field in struct io_uring_buf_reg, which the application can
>> use to inform the kernel of the minimum size that should be available
>> in an incrementally consumed buffer. If less than that is available,
>> the current buffer is fully processed and the next one will be picked.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
>> Link: https://github.com/axboe/liburing/issues/1433
>> Signed-off-by: Martin Michaelis <code@mgjm.de>
>> [axboe: write commit message, change io_buffer_list member name]
>> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   include/uapi/linux/io_uring.h |    3 ++-
>>   io_uring/kbuf.c               |    8 +++++++-
>>   io_uring/kbuf.h               |    7 +++++++
>>   3 files changed, 16 insertions(+), 2 deletions(-)
>>
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -758,7 +758,8 @@ struct io_uring_buf_reg {
>>       __u32    ring_entries;
>>       __u16    bgid;
>>       __u16    flags;
>> -    __u64    resv[3];
>> +    __u32    min_left;
>> +    __u32    resv[5];
>>   };
> 
> ^^^ let us remember this. More comments below
>>     /* argument for IORING_REGISTER_PBUF_STATUS */
>> --- a/io_uring/kbuf.c
>> +++ b/io_uring/kbuf.c
>> @@ -47,7 +47,7 @@ static bool io_kbuf_inc_commit(struct io
>>           this_len = min_t(u32, len, buf_len);
>>           buf_len -= this_len;
>>           /* Stop looping for invalid buffer length of 0 */
>> -        if (buf_len || !this_len) {
>> +        if (buf_len > bl->min_left_sub_one || !this_len) {
>>               WRITE_ONCE(buf->addr, READ_ONCE(buf->addr) + this_len);
>>               WRITE_ONCE(buf->len, buf_len);
>>               return false;
>> @@ -727,6 +727,10 @@ int io_register_pbuf_ring(struct io_ring
>>       if (reg.ring_entries >= 65536)
>>           return -EINVAL;
>>   +    /* minimum left byte count is a property of incremental buffers */
>> +    if (!(reg.flags & IOU_PBUF_RING_INC) && reg.min_left)
>> +        return -EINVAL;
>> +
>>       bl = io_buffer_get_list(ctx, reg.bgid);
>>       if (bl) {
>>           /* if mapped buffer ring OR classic exists, don't allow */
>> @@ -747,6 +751,8 @@ int io_register_pbuf_ring(struct io_ring
>>       if (!ret) {
>>           bl->nr_entries = reg.ring_entries;
>>           bl->mask = reg.ring_entries - 1;
>> +        if (reg.min_left)
>> +            bl->min_left_sub_one = reg.min_left - 1;
>>           if (reg.flags & IOU_PBUF_RING_INC)
>>               bl->flags |= IOBL_INC;
> 
> 
> I have run an AI assisted backport review and it spotted an issue: I
> have taken a look and the issues goes like:
> 
> Backport updates struct io_uring_buf_reg to min_left + resv[5] but
> keeps legacy validation that only checks reg.resv[0..2], so resv[3]
> and resv[4] are silently accepted.
> 
> Upstream has something like this:
> 
> if (copy_from_user(&reg, arg, sizeof(reg)))
>     return -EFAULT;
> if (!mem_is_zero(reg.resv, sizeof(reg.resv)))
>     return -EINVAL;
> if (reg.flags & ~(IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC))
>     return -EINVAL;
> 
> 6.12.y still has:
> 
> if (copy_from_user(&reg, arg, sizeof(reg)))
>     return -EFAULT;
> 
> if (reg.resv[0] || reg.resv[1] || reg.resv[2])
>     return -EINVAL;
> if (reg.flags & ~(IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC))
>     return -EINVAL;
> 
> So we are not checking resv[3], resv[4],
> 
> This commit is needed commit: 172484907285 ("io_uring/kbuf: use
> mem_is_zero()") to fix this. It is a clean cherry-pick, so I think the
> best thing is to take it for next cycle. this commit is present in
> 6.16-rc1+ so newer long-term stable kernel releases than 6.12.y don't
> have this problem.
> 
> 
> Jens, please correct me if the above understanding looks wrong.

Nope you are right. It's not an actual issue, it's just future proofing
checking. So it's quite fine to just add that commit for the next stable
release. I'll check the others too, as the mem_is_zero() commit landed
in 6.16.

-- 
Jens Axboe

