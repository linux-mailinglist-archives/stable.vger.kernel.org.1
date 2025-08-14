Return-Path: <stable+bounces-169603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E22B26CEE
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1969A5C7867
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584492040B6;
	Thu, 14 Aug 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fS99bdOP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818241F12E9
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190126; cv=none; b=tkgisv12eSSZqhEAwHGSH3pBRR3eFMybYAiHQS5+MGyHoi4nrb1+EGysCVNWvTz+eGPUiP4XEDirpKWvpce2+43cye32jwnHp675DIuzpSPDrpVtsqyuyWn7vJONlJ0C6BGLXCdpzi/RD1Jta73GS3iloKLxgyE6oarboYo561U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190126; c=relaxed/simple;
	bh=tVKL+/Yjf2KxImxtdGHgBxGggO7ero82B3waqfogm88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNUAwlzluXO9NqcX82Kn+JFZN5eQvdnvGwsvO3oqqXiOJnQJGW9ZaFa/Eo2ZM2gqG0KSfaAD6Pe9YsgB7ifcZMntzTHJQJ0DWbpCoEiVqeWHptjCQavB6laIyZ0NTcfFJFUDIaTjnurPbxKLTUNHzZWTwPElCTssKhK2gBgV0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fS99bdOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755190123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xcn7WZZ9rtpg+5znsVUFXh3dhp0KkS8czeLHYJeNEjg=;
	b=fS99bdOPKMWm283lBdxeSu7zRwrg+TYCDMSFEwata5cry5nUzfhXhB4iYpprAAerVahNeT
	AuwRU/XxNTTNEOAiKTcys+XOKl8to8H1OK6aWc2orsraaKl+CqjWSQoLH8jIYu8VmTzfey
	seh4cbVySv9Vyjy9irlkzzDjmEquXC8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-unyGbn2POnqIxFpPklvTNA-1; Thu, 14 Aug 2025 12:48:42 -0400
X-MC-Unique: unyGbn2POnqIxFpPklvTNA-1
X-Mimecast-MFC-AGG-ID: unyGbn2POnqIxFpPklvTNA_1755190120
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e56ffd20d9so32343525ab.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755190120; x=1755794920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xcn7WZZ9rtpg+5znsVUFXh3dhp0KkS8czeLHYJeNEjg=;
        b=J9oWrNql7OcQYHxvJau3yzwp+KrljqQEuCe/0UGwnH0N0Lw1n1qPw24HU/M3Slg1wd
         g5KHruoNird+G053kOOCo0uUlKereDZMQa/3JeXc6vNWRHIwswjZ9lKrj+ABe5WcNMnc
         3SgslXTCxKuy6Spq4arN8OHOQucjHtCf9YPa91ydswjUJnLax5NH5gLo6gY8RVw6MGoV
         EdQbpTWzl2G/DC3B63OW0iFzL/leLnV3BPS+CpgYdD3Z2tSR/JPQJrNaU8xuQCzvbMI0
         mytlcg0df3IStLSAbhZHVDKGPtJLMGHiqbXXcAbf1wYFTOAXgShx/4jBN7jzHEOKHcOT
         RCbg==
X-Forwarded-Encrypted: i=1; AJvYcCUiZ612lpqmJnYAWAakEsBXhCjxzRJLVRIBblLcLSBzjKqmvpV1MiR8LURvRFNAw9iFvd/x/zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlJ2jSCzV+Jg+IYK4YrOaIHVkToAHt/p1vChePxjb9w63j2iV
	4JsE8GUO8ozNjlxYWYR64MliN8tGaXzGlKaYdlcBarzZO3iMkFDO7H1oZnct+NjBk2jHlQf4YOU
	PEGG2hs7M2koLEWSN8aRAjsrJ+iunWOOKQY0T0dnJM+ra+kUXPqn/vs6YHdxDz1esRdKo
X-Gm-Gg: ASbGncv59NAefksH36MyAdU890HITQ7ZlNOiIWrMKzlIMoro92rj7w9elOsuPGGiWUl
	4PS9x7p0Ab4evWExZw5f2zyoH040zpSbch/+Rd4yx3rP6UjpFmE4vG2/PtpEVvqE5RguOcakWxW
	9Roh9bzRjPHyeb0SSUA0oQbzxer9WJ4PXu/p4n+SLfAsUYBuX9/PAjuVEhYasOrm6KyicvAPjyd
	y1QOmP5lRkMXQ7/Ew9xom0uNUueHb9tpX4DXn930i0O/IyAOoWfb0pvpH0UD7rRI0GZEOfGKJnx
	E4bNDWlxei2Z4IQGbKBaUeeTp7YpyZu04+dWXfLHZP7cA6uP7jOZG9P2ZeGFPAKX/+C0R8Ygflh
	T
X-Received: by 2002:a05:6e02:1c0e:b0:3e5:4351:ad0a with SMTP id e9e14a558f8ab-3e57078c28amr63158645ab.7.1755190120015;
        Thu, 14 Aug 2025 09:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdtHQNwYKftMjv31bt6Xhy+jYj7TUkTpGtuJW8D1frcxzCIJ4grETv14fTwyxGkX+q4p7b4A==
X-Received: by 2002:a05:6e02:1c0e:b0:3e5:4351:ad0a with SMTP id e9e14a558f8ab-3e57078c28amr63158195ab.7.1755190119572;
        Thu, 14 Aug 2025 09:48:39 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cd3f1csm66809205ab.45.2025.08.14.09.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 09:48:39 -0700 (PDT)
Message-ID: <b169faca-fef9-4099-920a-c34cc9a985a8@redhat.com>
Date: Thu, 14 Aug 2025 11:48:37 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] debugfs: fix mount options not being applied
To: Charalampos Mitrodimas <charmitro@posteo.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250813-debugfs-mount-opts-v2-1-0ca79720edc6@posteo.net>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250813-debugfs-mount-opts-v2-1-0ca79720edc6@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 6:55 PM, Charalampos Mitrodimas wrote:
> Mount options (uid, gid, mode) are silently ignored when debugfs is
> mounted. This is a regression introduced during the conversion to the
> new mount API.
> 
> When the mount API conversion was done, the line that sets
> sb->s_fs_info to the parsed options was removed. This causes
> debugfs_apply_options() to operate on a NULL pointer.

The change looks fine to me but I'm a little confused by this paragraph.
Is there something in the current code that will lead to an OOPs of
the kernel on a NULL ptr?

I just don't want to generate CVEs if we don't have to ;)

As for the code change itself,

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Thanks!

> Fix this by following the same pattern as the tracefs fix in commit
> e4d32142d1de ("tracing: Fix tracefs mount options"). Call
> debugfs_reconfigure() in debugfs_get_tree() to apply the mount options
> to the superblock after it has been created or reused.
> 
> As an example, with the bug the "mode" mount option is ignored:
> 
>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>   $ mount | grep debugfs_test
>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>   $ ls -ld /tmp/debugfs_test
>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> 
> With the fix applied, it works as expected:
> 
>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>   $ mount | grep debugfs_test
>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime,mode=666)
>   $ ls -ld /tmp/debugfs_test
>   drw-rw-rw- 37 root root 0 Aug  2 17:28 /tmp/debugfs_test
> 
> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220406
> Cc: stable@vger.kernel.org
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
> Changes in v2:
> - Follow the same pattern as e4d32142d1de ("tracing: Fix tracefs mount options")
> - Add Cc: stable tag
> - Link to v1: https://lore.kernel.org/r/20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net
> ---
>  fs/debugfs/inode.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index a0357b0cf362d8ac47ff810e162402d6a8ae2cb9..c12d649df6a5435050f606c2828a9a7cc61922e4 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -183,6 +183,9 @@ static int debugfs_reconfigure(struct fs_context *fc)
>  	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
>  	struct debugfs_fs_info *new_opts = fc->s_fs_info;
>  
> +	if (!new_opts)
> +		return 0;
> +
>  	sync_filesystem(sb);
>  
>  	/* structure copy of new mount options to sb */
> @@ -282,10 +285,16 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  static int debugfs_get_tree(struct fs_context *fc)
>  {
> +	int err;
> +
>  	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
>  		return -EPERM;
>  
> -	return get_tree_single(fc, debugfs_fill_super);
> +	err = get_tree_single(fc, debugfs_fill_super);
> +	if (err)
> +		return err;
> +
> +	return debugfs_reconfigure(fc);
>  }
>  
>  static void debugfs_free_fc(struct fs_context *fc)
> 
> ---
> base-commit: 3c4a063b1f8ab71352df1421d9668521acb63cd9
> change-id: 20250804-debugfs-mount-opts-2a68d7741f05
> 
> Best regards,


