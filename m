Return-Path: <stable+bounces-230275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOmGOqiMw2nJrQQAu9opvQ
	(envelope-from <stable+bounces-230275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 08:20:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2D0320972
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 08:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8B53034671
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 07:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5279291C10;
	Wed, 25 Mar 2026 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xXO1hlCO"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18F234984;
	Wed, 25 Mar 2026 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422929; cv=none; b=P/AQXdRdP78qfcRaXzQ8/L4pKCYQDcHg1YPc52p8lAO5VNCLtUgaY6Xf4gnod+P4FYs1IfAT65LEOQqIJ05D+ltvngV8TUs0cusFpmZIMiFh9suSZ45cFJ7CK7AWQt11JvnEdSCioeeQzgyVxFo1+dn9jNXWlp98uCjYPX13VQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422929; c=relaxed/simple;
	bh=5hxyyJzeF5TPiJINbzaJ1X7s6AP4a+tNXOcQkWSBSes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCrPW0QdPYaalxys04MOXoF6OGp5KNCB6+2L/MkqAVwPebGpqmRym2V+rxsw3B4XlP8wkcCgvzc8DxCJHLS/coUr0WBs6LPqDh05TLsH+aTtQKhHXxRGitizDaSYPBtOXqjhTmPZhtEDK1y89lzOjOsb6rRD5FO+rM8F5EMSA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xXO1hlCO; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774422924; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qd6WqezgwAV4gZZq0dBkIdEIitvF//h4rUdyQasOat0=;
	b=xXO1hlCOJGYkVFfOYQn/0q5RwmLnwKp9kNqtcmkYnQuIcQ0GmezunGi6OwJrZ9wf96yw+2WFxa2I7ml6V6j0OD9T3uMAD8wa0Tm2h0aZHaCtW3p4IKQfsc+pNoti5Oq3YhIR1/0kZUnmRO+CI+DiPmNUntABDNmbCubwjcpvxy0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X.gv7nM_1774422922;
Received: from 30.221.132.80(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.gv7nM_1774422922 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 15:15:23 +0800
Message-ID: <ce0839b2-eb90-4139-9745-157e3f2701d8@linux.alibaba.com>
Date: Wed, 25 Mar 2026 15:15:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] erofs: get rid of z_erofs_fill_inode()
To: "driz2t@qq.com" <driz2t@qq.com>
Cc: "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+016d861797fd718491a8@syzkaller.appspotmail.com"
 <syzbot+016d861797fd718491a8@syzkaller.appspotmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <tencent_9245CADBF1A8EA39C72025351E3BAE7F130A@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_9245CADBF1A8EA39C72025351E3BAE7F130A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230275-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,016d861797fd718491a8];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,qq.com:email]
X-Rspamd-Queue-Id: 6C2D0320972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/25 14:57, driz2t@qq.com wrote:
> This is a backport of upstream commit 4fdadd5b0f0c723c812842454f8cca1619f2e731.
> (erofs: get rid of z_erofs_fill_inode())
> 
> Reported-by: syzbot+016d861797fd718491a8@syzkaller.appspotmail.com
> Tested-by: syzbot+016d861797fd718491a8@syzkaller.appspotmail.com
> Signed-off-by: Changjian Liu <driz2t@qq.com>

Please follow the stable patch style.


> ---
>   fs/erofs/inode.c     |  12 ++++++++----
>   fs/erofs/internal.h  |   2 --
>   fs/erofs/zmap.c      |  18 ------------------
>   scripts/extract-cert | Bin 0 -> 14608 bytes

scripts/extract-cert | Bin 0 -> 14608 bytes
What's that.

Thanks,
Gao Xiang

>   4 files changed, 8 insertions(+), 24 deletions(-)
>   create mode 100755 scripts/extract-cert
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 3cbef6318b7b..484572504b4d 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -280,11 +280,15 @@ static int erofs_fill_inode(struct inode *inode)
>        }
>   
>        if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +#ifdef CONFIG_EROFS_FS_ZIP
>              if (!erofs_is_fscache_mode(inode->i_sb) &&
> -               inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
> -                 err = z_erofs_fill_inode(inode);
> -           else
> -                 err = -EOPNOTSUPP;
> +               inode->i_sb->s_blocksize_bits == PAGE_SHIFT) {
> +                 inode->i_mapping->a_ops = &z_erofs_aops;
> +                 err = 0;
> +                 goto out_unlock;
> +           }
> +#endif
> +           err = -EOPNOTSUPP;
>              goto out_unlock;
>        }
>        inode->i_mapping->a_ops = &erofs_raw_access_aops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 126970932805..1a4d08a93339 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -423,12 +423,10 @@ enum {
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
> -int z_erofs_fill_inode(struct inode *inode);
>   int z_erofs_map_blocks_iter(struct inode *inode,
>                        struct erofs_map_blocks *map,
>                        int flags);
>   #else
> -static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP; }
>   static inline int z_erofs_map_blocks_iter(struct inode *inode,
>                                  struct erofs_map_blocks *map,
>                                  int flags)
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index d2d7fe826091..ff84533da0c4 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -7,24 +7,6 @@
>   #include <asm/unaligned.h>
>   #include <trace/events/erofs.h>
>   
> -int z_erofs_fill_inode(struct inode *inode)
> -{
> -     struct erofs_inode *const vi = EROFS_I(inode);
> -     struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
> -
> -     if (!erofs_sb_has_big_pcluster(sbi) &&
> -         !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
> -         vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
> -           vi->z_advise = 0;
> -           vi->z_algorithmtype[0] = 0;
> -           vi->z_algorithmtype[1] = 0;
> -           vi->z_logical_clusterbits = inode->i_sb->s_blocksize_bits;
> -           set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
> -     }
> -     inode->i_mapping->a_ops = &z_erofs_aops;
> -     return 0;
> -}
> -
>   struct z_erofs_maprecorder {
>        struct inode *inode;
>        struct erofs_map_blocks *map;
> -- 
> 2.43.0


