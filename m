Return-Path: <stable+bounces-216661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i2k/Cny9kmkPxAEAu9opvQ
	(envelope-from <stable+bounces-216661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:47:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C835141228
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F581300C013
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0942288517;
	Mon, 16 Feb 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pi/3ze59"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78883220F2A
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771224440; cv=pass; b=UhHvisJ8QNmP2S0dGsm3uO/gUH9qN9ryoTAmp8jpysiCti/XNCWY0k6hENJV2PGBq0BF5a1mxwaPBIPx/0Pt6xX94pLQNu/dw3NTUsym1ZGDv6QHnZRIVMNm6goJQdfdcwHjNTAb/Zk0WAsWqbDYYI6imZdXA9ds2AlBzk/A/PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771224440; c=relaxed/simple;
	bh=IrMw2JAAG4GdCerQW2/5Gqynt2fyIX/7rV3NndN5g7Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1TPYfSqcAwgx4Jqp7ho2fskD8v9Uh8qf+4Q8tyoG3B1T0SRj4BhvB2IpsuqQAYd+nNWpDZzs1TbQUJqdD0n1fCY6G307YP/ViomcB2tOvzmv9Smdz13zjADJxdeaQ5AlR27AoyqdwW05/82hPwTIdleg24ClUhfweA66Ua5hVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pi/3ze59; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94ace5d0e39so670244241.2
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 22:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771224438; cv=none;
        d=google.com; s=arc-20240605;
        b=gsHYoSuw7aSt0WSPGrqRxb2oMubXt2Umz+fsDsXtlR96EACjtRw48mxvbCLSIQVAif
         nlZGwt+NKyjHS6b256xSDumy8CmQNTi2zGqiTQYpwjA7umzQvDTLmSqW3tl6X8aI47ei
         t4zU5hwlInRoxuRIMOWvJN+S49+nzTu+YN3ac/EL9W8SKlAPTO2i3ARlNF7MDl5iUyac
         MEdd57y9xGzf8Pnoko0C3dNfT7K8tN9ZCXUoti/xXkf/AY2CWVmsiqesgZ6vKeweydvn
         TL+Ga1MJDjhDjvzjOEFWPKm48SIGD2hOzUwdXtR5CIaSdQf8kBYw5ev3G1g7Rhsdz5ip
         gqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gf2jwk1RVqzQzmvAhQgxYmUaIaH7H8vlbZYE4E+t8HE=;
        fh=tcDZ5x+EL4d2iHi7EDU6tdMJ78diaINba4CXGKfvXno=;
        b=itwpOqFlk302qR0+XFRo0e1daPCm9cn4NnVW0ki9SsDO/AzHJAohaMLggmeT2Xttph
         htwwEQPHFVscaZVzc+SQbPAcHP/zKUS0NpXwzFrHzjQr+AAACsPB3E7dRnxRu1br9ITa
         dt/3fej8BRa4T9E38PCm6Fn+yuiQbOyCgvCVpl7CsFhwjI/6kGsmP7TAnBAMkVhUDjOL
         MfGJFAvHbHW7Q4pA3QMxTq1SVB+Ax1lOngSuFgv7hUnY/SD9GH3CNn12EPeqY8agP/bx
         PVq1X++UTxfjgSv4VV9XKYOL8dBnZ5g0v4NX1Q+79D70/l4/u7CAe91b9bUBs7ntMKM5
         YhrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771224438; x=1771829238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gf2jwk1RVqzQzmvAhQgxYmUaIaH7H8vlbZYE4E+t8HE=;
        b=pi/3ze59LsDqGzQWxR3NgekZt1yOj/RHot8ec6OmVr4S1I2Ep5ZkR9awO1tlKMXc8p
         fwQWA9RKFd1nh8rI+KhV9dNaeaqanlkLGe716/9tx3wf7mO4pEM6wiXHNt6INJ8TQGQl
         D4uhwajDxWEkO90a0ECzQlKyZmhaSn4ThmagVm8oO7IPYJmNBZ0k+r+lQuVxJkI1TOmo
         jhinekSugie8wF9fzHFdZxGhevY2SP8SHZ2kqsqJ+kaE27BvE1qd54TeIUweBa+d6ikQ
         cn2FpzhCDgi4QvG/t6ukSmKvyoJoeZwH4nlXC8ZgR8IrDYe5DqhcI5IIZqr3G33dOb3D
         r2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771224438; x=1771829238;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gf2jwk1RVqzQzmvAhQgxYmUaIaH7H8vlbZYE4E+t8HE=;
        b=PDQBRTLNd8Y3ZNjeANx9h9Xn/9zAMB7KoF3NsfCuMYzB8WVxDOH/W5AAhybJXyS9PY
         Tu9x9n9ve/XXem73r88jUtAohRyBx36Zv0HNPzNIxam9/3RG7+QO4yzYKzM5nDoUGik0
         eu9HKZJWGDc2yZwcfX+y1J/ggs4AR3YCPYPG6mBqUicmZ8sVJo/neepFr6vzV0N6085Z
         7BbPfwhvetgumAHpWIFlxd4P/vG3wmjW3ynqstyu7rFrbkgoHplvJTFpPEhS6J2fHyID
         XFc/bruZPTXJFk5YxbgLxmTOiF74rS8k+/m2+IdtKWrE/1xSY8is45Lc4N0ObBx6hxFN
         nhHA==
X-Forwarded-Encrypted: i=1; AJvYcCUzY3jJIVBDMGhnP7JyXHlLAwShn0feIS9Ep/uTAh9OwIYF55YQ6zpQppJmUgMplsLaDsdIsyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9E686thOXsN+Jqw6e52ziKwi1chdrqcelX5RZG/8D2jKOkcom
	BzTthUqA28XMgpo4xHV0IL8Z9g541VcRUavpZBRcjqYKIBFGFtYw/TOCscoln+5nZBGYzz1v9I1
	xmRhHbICtmuOZjKisDU8eGB+pd61lwL0Ge1TOxjK3
X-Gm-Gg: AZuq6aK4strY/5yPj+z7MLgEf9fHvHgm6jxXQoZ+b1bEDFASPCrUgaYYeRlPJ7KyrCQ
	C77k3almDrm75UP5HFE9TJLq2dRtMfP1O3eqf5jWa1z/lajI0QsOmSMZ+xSIrURgPBxisp0JFZE
	AjotwcYwKX4xe5YZr2bmb1O6MZw1rTtDP+EEiJstRDnRgFNHt4SK2xHinCJn0oHMGX1C7CWL6Mi
	txV53dq+dMpwi0PAtbsZzKTlL+sXC9vCRcasxb1UlLXfvy62F7WDFsAdFjFPX+OJRVnY8FVUe9n
	FGcc3V06Lcu4oyCHyv0ftua686fBFWe93cEYzgohaA==
X-Received: by 2002:a05:6102:3f41:b0:5f5:7791:c2cb with SMTP id
 ada2fe7eead31-5fe1b02b8d5mr3315567137.41.1771224437883; Sun, 15 Feb 2026
 22:47:17 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Feb 2026 22:47:17 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Feb 2026 22:47:17 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260214001535.435626-1-kartikey406@gmail.com>
References: <20260214001535.435626-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Feb 2026 22:47:17 -0800
X-Gm-Features: AaiRm52DUXynYKBSitVD7cd8pczBxhWkZgpMdc34qfLZh8F1_KvF_BSdCWVeDL4
Message-ID: <CAEvNRgE+BuLzJbF=yBvCn9D8PLsWcgq1F+KwP2QotTqC8YLo-g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: deny THP for files on anonymous inodes
To: Deepanshu Kartikey <kartikey406@gmail.com>, akpm@linux-foundation.org, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, i@maskray.me, 
	shy828301@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216661-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,maskray.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5C835141228
X-Rspamd-Action: no action

Deepanshu Kartikey <kartikey406@gmail.com> writes:

> file_thp_enabled() incorrectly allows THP for files on anonymous inodes
> (e.g. guest_memfd and secretmem). These files are created via
> alloc_file_pseudo(), which does not call get_write_access() and leaves
> inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
> true, they appear as read-only regular files when
> CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
> collapse.
>
> Anonymous inodes can never pass the inode_is_open_for_write() check
> since their i_writecount is never incremented through the normal VFS
> open path. The right thing to do is to exclude them from THP eligibility
> altogether, since CONFIG_READ_ONLY_THP_FOR_FS was designed for real
> filesystem files (e.g. shared libraries), not for pseudo-filesystem
> inodes.
>
> For guest_memfd, this allows khugepaged and MADV_COLLAPSE to create
> large folios in the page cache via the collapse path, but the
> guest_memfd fault handler does not support large folios. This triggers
> WARN_ON_ONCE(folio_test_large(folio)) in kvm_gmem_fault_user_mapping().
>
> For secretmem, collapse_file() tries to copy page contents through the
> direct map, but secretmem pages are removed from the direct map. This
> can result in a kernel crash:
>
>     BUG: unable to handle page fault for address: ffff88810284d000
>     RIP: 0010:memcpy_orig+0x16/0x130
>     Call Trace:
>      collapse_file
>      hpage_collapse_scan_file
>      madvise_collapse
>

I couldn't reproduce this crash, I could only reproduce the false memory
failure report below.

> Secretmem is not affected by the crash on upstream as the memory failure
> recovery handles the failed copy gracefully, but it still triggers
> confusing false memory failure reports:
>
>     Memory failure: 0x106d96f: recovery action for clean unevictable
>     LRU page: Recovered
>
> Check IS_ANON_FILE(inode) in file_thp_enabled() to deny THP for all
> anonymous inode files.
>
> Link: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
> Link: https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com
> Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
> Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
> Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
> v2:
>   - Use IS_ANON_FILE(inode) to deny THP for all anonymous inode files
>     instead of checking for specific subsystems (David Hildenbrand)
>   - Updated Fixes tag to 7fbb5e188248 which removed the VM_EXEC
>     requirement that accidentally protected secretmem
>   - Expanded commit message with implications for both guest_memfd
>     and secretmem
> ---
>  mm/huge_memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 40cf59301c21..d3beddd8cc30 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -94,6 +94,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>
>  	inode = file_inode(vma->vm_file);
>
> +	if (IS_ANON_FILE(inode))
> +		return false;
> +

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

>  	return !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>  }
>
> --
> 2.43.0

