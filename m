Return-Path: <stable+bounces-59178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B288892F4AF
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 06:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8F51C219CE
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 04:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938101426C;
	Fri, 12 Jul 2024 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyaBnI/X"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A3FC12
	for <stable@vger.kernel.org>; Fri, 12 Jul 2024 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720759265; cv=none; b=garhjtG+Y75ftLVMj849GY4azEMqTj9RRzpY9nQpzjNP0r76NA9SBbJB4cE33vqJKaEe4uiwVtEn1lKNT5tgcGhiiw+OQKpEwH57cyB57lbBRtlAA9YGgv/0k1j4ybcKHprd3iKBW4lVf+M3AbA1MHBQiwplHq5oVp0zWT6e8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720759265; c=relaxed/simple;
	bh=md/ZKfA4V3xF5vfWYrLVqKXDNLAE+F/LCCZXl7CDSzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV8fpTQCI9pOSrS2BLMFpiNIvuWc8bN3YHFwqmTE5/g4ZG8UZWP9FodYFqmGKFNWtKoCvZVnzmIRZJlTQEXX+0VDAnP2uY2FLJ6bkfnc60i+Ywo2YyCtlkp3DxFQp8cVVjPBfiDDkHJ/VO1MG+iaFogJz45nnTDOuuQ4+6sY3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyaBnI/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720759262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtVf2hI+P/r8Ht19AjUoIR958okaKyJc3A1HhEAF3bc=;
	b=MyaBnI/XOOwenh+Doksp/+WMtoQmQA3SWFh3sRMQXDFifHznOqZrOKdOm7i3MGdY5f5hnq
	62qffzAIceqmshvLNYDKqU/YQeOQ5SIa8otefSfHI7mxiib7iTT4spUuZ9U74FwxkAeMwX
	KxXGbL0sKTpat0uBZLmmbEBAoXnJGJc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-OGU5QOxjPiiAERTZg5JNNg-1; Fri, 12 Jul 2024 00:40:58 -0400
X-MC-Unique: OGU5QOxjPiiAERTZg5JNNg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so175235239f.1
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 21:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720759258; x=1721364058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtVf2hI+P/r8Ht19AjUoIR958okaKyJc3A1HhEAF3bc=;
        b=av8/DVCZbqezIB6fR2KH6jzucl/k6PjRszTLm06dIPZyCj0TBYAiVAoWzYxYzpKXAK
         20tFvr7EJEwbQ6h+DP5STEUW2y685guDT7bqw+aHj6qDdGD7Op0s2jVdLSmkRy7ciR6k
         QQFBoId/3P6pW2mFl87ycEd1WA1gRDNsXfLPwT/8Gr87bJC3r27nf2sgy0Zsp3M2wqra
         xO/DDOYv0vtfLvlT9fqYw7i7bnfMDuYPXNBlZMXxlCCxA8ufb18kIRs9ooIidGPEgQ+K
         hCfSBod5AILJNtvLfvOcKrypKgjP0eTHi7QrPyesFXSeLWVJanHqpDAmW2pGioVCQ4qe
         zffg==
X-Forwarded-Encrypted: i=1; AJvYcCXprXV3xl/b9ZDmgPHJnVSge7Hy7S2L/PgJXdleaGHmoGdIePjtzuiOIy2/uXFxO5L3mhPG2ec0VJxBZjX1tNWOLw+k8VWf
X-Gm-Message-State: AOJu0YxzXgo24FxgepMkL21q2836Zm2hUK6+17MtCt1JyLOds1xkjCfg
	RLCklrNfj+eT0JVk73YpUA8j/5A9VLJz7xdMQ0Ntf2myM+QNQgiGmZ8RN9PU++R2Cee2yvE84nB
	i0gXOW3qCXVvtQmWNuyk5qaHdvD3HSiyRBCCCw8S3DiNNWGA4pAwce0ulpkiL/or5
X-Received: by 2002:a6b:ea1a:0:b0:7f8:c0eb:7adf with SMTP id ca18e2360f4ac-7fffa120fffmr1144309639f.0.1720759257759;
        Thu, 11 Jul 2024 21:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnx0oJhpPjuAUD7Oiyb1sXi+60kUplALJfKZuwmUHeiczfn42AF7mrfilOP2b+ol+gcAOXcA==
X-Received: by 2002:a6b:ea1a:0:b0:7f8:c0eb:7adf with SMTP id ca18e2360f4ac-7fffa120fffmr1144308939f.0.1720759257314;
        Thu, 11 Jul 2024 21:40:57 -0700 (PDT)
Received: from [10.72.116.134] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438eb4e3sm6692565b3a.92.2024.07.11.21.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 21:40:56 -0700 (PDT)
Message-ID: <5f0add53-325b-4d62-9c4f-ffcc9f8e38ec@redhat.com>
Date: Fri, 12 Jul 2024 12:40:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: force sending a cap update msg back to MDS for
 revoke op
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, vshankar@redhat.com, stable@vger.kernel.org
References: <20240711104019.987090-1-xiubli@redhat.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240711104019.987090-1-xiubli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Updated this patch and sent out the V2 to improve it.

On 7/11/24 18:40, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> If a client sends out a cap update dropping caps with the prior 'seq'
> just before an incoming cap revoke request, then the client may drop
> the revoke because it believes it's already released the requested
> capabilities.
>
> This causes the MDS to wait indefinitely for the client to respond
> to the revoke. It's therefore always a good idea to ack the cap
> revoke request with the bumped up 'seq'.
>
> Currently if the cap->issued equals to the newcaps the check_caps()
> will do nothing, we should force flush the caps.
>
> Cc: stable@vger.kernel.org
> Link: https://tracker.ceph.com/issues/61782
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   fs/ceph/caps.c  | 16 ++++++++++++----
>   fs/ceph/super.h |  7 ++++---
>   2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 24c31f795938..ba5809cf8f02 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2024,6 +2024,8 @@ bool __ceph_should_report_size(struct ceph_inode_info *ci)
>    *  CHECK_CAPS_AUTHONLY - we should only check the auth cap
>    *  CHECK_CAPS_FLUSH - we should flush any dirty caps immediately, without
>    *    further delay.
> + *  CHECK_CAPS_FLUSH_FORCE - we should flush any caps immediately, without
> + *    further delay.
>    */
>   void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>   {
> @@ -2105,7 +2107,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>   	}
>   
>   	doutc(cl, "%p %llx.%llx file_want %s used %s dirty %s "
> -	      "flushing %s issued %s revoking %s retain %s %s%s%s\n",
> +	      "flushing %s issued %s revoking %s retain %s %s%s%s%s\n",
>   	     inode, ceph_vinop(inode), ceph_cap_string(file_wanted),
>   	     ceph_cap_string(used), ceph_cap_string(ci->i_dirty_caps),
>   	     ceph_cap_string(ci->i_flushing_caps),
> @@ -2113,7 +2115,8 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>   	     ceph_cap_string(retain),
>   	     (flags & CHECK_CAPS_AUTHONLY) ? " AUTHONLY" : "",
>   	     (flags & CHECK_CAPS_FLUSH) ? " FLUSH" : "",
> -	     (flags & CHECK_CAPS_NOINVAL) ? " NOINVAL" : "");
> +	     (flags & CHECK_CAPS_NOINVAL) ? " NOINVAL" : "",
> +	     (flags & CHECK_CAPS_FLUSH_FORCE) ? " FLUSH_FORCE" : "");
>   
>   	/*
>   	 * If we no longer need to hold onto old our caps, and we may
> @@ -2223,6 +2226,9 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
>   				goto ack;
>   		}
>   
> +		if (flags & CHECK_CAPS_FLUSH_FORCE)
> +			goto ack;
> +
>   		/* things we might delay */
>   		if ((cap->issued & ~retain) == 0)
>   			continue;     /* nope, all good */
> @@ -3518,6 +3524,7 @@ static void handle_cap_grant(struct inode *inode,
>   	bool queue_invalidate = false;
>   	bool deleted_inode = false;
>   	bool fill_inline = false;
> +	int flags = 0;
>   
>   	/*
>   	 * If there is at least one crypto block then we'll trust
> @@ -3751,6 +3758,7 @@ static void handle_cap_grant(struct inode *inode,
>   	/* don't let check_caps skip sending a response to MDS for revoke msgs */
>   	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
>   		cap->mds_wanted = 0;
> +		flags |= CHECK_CAPS_FLUSH_FORCE;
>   		if (cap == ci->i_auth_cap)
>   			check_caps = 1; /* check auth cap only */
>   		else
> @@ -3806,9 +3814,9 @@ static void handle_cap_grant(struct inode *inode,
>   
>   	mutex_unlock(&session->s_mutex);
>   	if (check_caps == 1)
> -		ceph_check_caps(ci, CHECK_CAPS_AUTHONLY | CHECK_CAPS_NOINVAL);
> +		ceph_check_caps(ci, flags | CHECK_CAPS_AUTHONLY | CHECK_CAPS_NOINVAL);
>   	else if (check_caps == 2)
> -		ceph_check_caps(ci, CHECK_CAPS_NOINVAL);
> +		ceph_check_caps(ci, flags | CHECK_CAPS_NOINVAL);
>   }
>   
>   /*
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index b0b368ed3018..831e8ec4d5da 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -200,9 +200,10 @@ struct ceph_cap {
>   	struct list_head caps_item;
>   };
>   
> -#define CHECK_CAPS_AUTHONLY   1  /* only check auth cap */
> -#define CHECK_CAPS_FLUSH      2  /* flush any dirty caps */
> -#define CHECK_CAPS_NOINVAL    4  /* don't invalidate pagecache */
> +#define CHECK_CAPS_AUTHONLY     1  /* only check auth cap */
> +#define CHECK_CAPS_FLUSH        2  /* flush any dirty caps */
> +#define CHECK_CAPS_NOINVAL      4  /* don't invalidate pagecache */
> +#define CHECK_CAPS_FLUSH_FORCE  8  /* force flush any caps */
>   
>   struct ceph_cap_flush {
>   	u64 tid;


