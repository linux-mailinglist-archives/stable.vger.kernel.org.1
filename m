Return-Path: <stable+bounces-230845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHJHFq3IyGlRqgUAu9opvQ
	(envelope-from <stable+bounces-230845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 08:37:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AA350F37
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 08:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD443016C94
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09E2C0268;
	Sun, 29 Mar 2026 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k4AqkaAy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0F21ADB7;
	Sun, 29 Mar 2026 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774766248; cv=none; b=a+TheC+TYDXFmKIS9LKGIgRgDSLi9lekjVxLeY3mWmqpMqI92a5XGTyHNKeeAbMQSS0zV7ps5zFyfD68FsaRqCOWxtLn4n4JZyyBxyjPp2C7G7d1BVnaYGgapWYKba/9qjfgN6IkyjS6ZnlLcjh8n1E1ncIEnNh0JA4cYf7gYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774766248; c=relaxed/simple;
	bh=0w+mIZtubDQSCv8Zy+/6Zh06GPt46bAsnhjnl+jTm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sig0RPTfgEyAXkoQIB3iEC+oBaA5ddybEd1AOcnWMvhgMS11AunNVSbqPT5wV+aczS5anJ2rMPwXMQm8I3O2to60t9M+/3DN++8B5xFyqts2JOsb2WUlc00hYxh62NVe+bVa81XZc604YYdZMXC09O+ZETgYehqPr3g0XLelbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k4AqkaAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA9BC116C6;
	Sun, 29 Mar 2026 06:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774766247;
	bh=0w+mIZtubDQSCv8Zy+/6Zh06GPt46bAsnhjnl+jTm2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4AqkaAyo/MZXcXeMTbuHNFQs2YG1gJAIAXaJ6o2Zr2NK8mfqLNSG+eG+Qetosz37
	 CtqCQD9ztGb0OD3JVO18BD5lTLFfMEActHMRA5awakKXWDVZ6aK85+IjKFcImNC1QA
	 TkaFw4YCVYsu6oLPdyzGJG+pdtGW7UjdjwMXb2jY=
Date: Sun, 29 Mar 2026 08:37:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "driz2t@qq.com" <driz2t@qq.com>
Cc: stable <stable@vger.kernel.org>,
	"syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com" <syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com>,
	"joseph.qi" <joseph.qi@linux.alibaba.com>, mark <mark@fasheh.com>,
	jlbec <jlbec@evilplan.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.6.y] kernel BUG in ocfs2_remove_extent
Message-ID: <2026032938-shorthand-iron-e628@gregkh>
References: <tencent_20BE792225EC3654239D0B90001A911DE909@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_20BE792225EC3654239D0B90001A911DE909@qq.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230845-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,1dd53396e7124586dca9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,appspotmail.com:email,syzkaller.appspot.com:url,alibaba.com:email,qq.com:email]
X-Rspamd-Queue-Id: B44AA350F37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 06:09:02AM +0000, driz2t@qq.com wrote:
> This is a backport for 6.6.y.

Not needed here.

> 
> [ Upstream commit e1c70505ee8158c1108340d9cd67182ade93af4a ]
> 
> ocfs2: add extra consistency checks for chain allocator dinodes
> 
> When validating chain allocator dinode in 'ocfs2_validate_inode_block()',
> add an extra checks whether a) the maximum amount of chain records in
> 'struct ocfs2_chain_list' matches the value calculated based on the
> filesystem block size, and b) the next free slot index is within the valid
> range.
> 
> Link: https://lkml.kernel.org/r/20251030153003.1934585-1-dmantipov@yandex.ru
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
> Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
> Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Tested-by: syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com
> Signed-off-by: Changjian Liu <driz2t@qq.com>

Why did you take off the signed-off-by line that was on the original?


> ---
>  fs/ocfs2/inode.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index c561a8a6493e..7c99f436037b 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1419,6 +1419,23 @@ int ocfs2_validate_inode_block(struct super_block *sb,
>             goto bail;
>       }
>  
> +     if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
> +           struct ocfs2_chain_list *cl = &di->id2.i_chain;
> +
> +           if (le16_to_cpu(cl->cl_count) != ocfs2_chain_recs_per_inode(sb)) {
> +                 rc = ocfs2_error(sb, "Invalid dinode %llu: chain list count %u\n",
> +                              (unsigned long long)bh->b_blocknr,
> +                              le16_to_cpu(cl->cl_count));
> +                 goto bail;
> +           }
> +           if (le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count)) {
> +                 rc = ocfs2_error(sb, "Invalid dinode %llu: chain list index %u\n",
> +                              (unsigned long long)bh->b_blocknr,
> +                              le16_to_cpu(cl->cl_next_free_rec));
> +                 goto bail;
> +           }
> +     }
> +
>       rc = 0;
>  
>  bail:
> --
> 2.43.0

Did you try to apply this patch to the tree?  (hint, it is corrupted...)

thanks,

greg k-h

