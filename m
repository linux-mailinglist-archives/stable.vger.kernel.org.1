Return-Path: <stable+bounces-241248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEqvCm8S72mU5QAAu9opvQ
	(envelope-from <stable+bounces-241248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:38:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8246E720
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A87F300AC2B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889203890EE;
	Mon, 27 Apr 2026 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwEJEVGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B80388E74
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275497; cv=none; b=PQm5qqawnM1lVP8+g1U+dpF7WwVnK1iN5UeLY/bSue0jwnJkrty6IEysrcYH0GIJTlo9s2WPCbLcAYnzMYuv9Q65HI2X64TC2GIAh2rGGbZxR7EqHkpHHVvxSfgchABN+WVh6iQQKqw+QlzYUM/SzCsvzHXiIg5BnrsDZLBiVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275497; c=relaxed/simple;
	bh=aGc8FNBDqefHeaRp2lzT5Pr9RmzOIch4aJ8kcMZPXQg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qrx3C8VPnOjBTOKkzaeZr70wATyDLeWQwKk7fY5Z0xsfzZDv4m233EiIpUXUWVT3b3LEqUVv3ddF2I+LFyQJNA4EJ2LZ9hMBI1oNZZVqWfMlTsbfxLto2Bli+v8Jz6RGO4WXg4B2JqDd6HtwT476w9byu6YdJirZsRLwnrGXjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwEJEVGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB71C19425;
	Mon, 27 Apr 2026 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777275497;
	bh=aGc8FNBDqefHeaRp2lzT5Pr9RmzOIch4aJ8kcMZPXQg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TwEJEVGaZLtSy1HPXGx+tgFmcMqn6wQDdgEa3YGzJ4YZ+6/OuCJZ0JcN6bp90iwy9
	 oZ54wC0jAu0/B+3zUuqnYeXsT/Gn6HDRYN4RWssZYSqpWwi9lmHYR/6wW9bQc+4/M8
	 I10XoSoehyMJAT2VGi0VTEeJPO2STFH4UiH6VuySm0Zb4FkwOVPbHlDvjdQ7qZ7BEh
	 mbD2OY0hI4ponS0CGIj0V26/LO+7Llqs0uaRHkIoMXYGnobOkJdr3Ex33VIqOSlzF9
	 fpXA23SvUm03TQwETljTAxYB+T2b38bwFMeS34e+2JGbyT5U3XRv9MPem90UfZHfqj
	 dc0P4UE1no7pQ==
Message-ID: <3550618a-4a16-4f1d-b8cb-4d7ff96f6ed7@kernel.org>
Date: Mon, 27 Apr 2026 15:38:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incorrect FI_NO_EXTENT handling in
 __destroy_extent_node()
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260422073525.2063784-2-monty_pavel@sina.com>
 <206a897a-2860-40b5-bbb8-829954d7e568@kernel.org>
 <8f3dee76-6094-421f-bb32-a059815b405c@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <8f3dee76-6094-421f-bb32-a059815b405c@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90A8246E720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241248-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xiaomi.com:email]

On 4/24/26 17:45, Yongpeng Yang wrote:
> 
> On 4/22/26 20:33, Chao Yu via Linux-f2fs-devel wrote:
>> On 4/22/2026 3:35 PM, Yongpeng Yang wrote:
>>> From: yangyongpeng <yangyongpeng@xiaomi.com>
>>>
>>> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
>>> not reset the length of the largest extent to 0 and update the inode
>>> folio. Since modifications to the extent tree are disallowed afterward,
>>> the cached largest extent may become stale. This can trigger the
>>> following error in xfstests generic/388:
>>>
>>> F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent
>>> info [220057, 57, 6] is incorrect, run fsck to fix
>>>
>>> In the f2fs_drop_inode path, __destroy_extent_node() does not need to
>>> guarantee that et->node_cnt is 0, because concurrency with writeback
>>> is expected in this path, and writeback may update the extent cache.
>>>
>>> This patch updates __destroy_extent_node() to avoid setting the inode
>>> flag FI_NO_EXTENT, and to remove the check zero of et->node_cnt.
>>>
>>> Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node
>>> destroy and writeback")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Chao Yu <chao@kernel.org>
>>> Suggested-by: Chao Yu <chao@kernel.org>
>>> Signed-off-by: yangyongpeng <yangyongpeng@xiaomi.com>
>>> ---
>>>    fs/f2fs/extent_cache.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>> index 87169fd29d89..3adbead27953 100644
>>> --- a/fs/f2fs/extent_cache.c
>>> +++ b/fs/f2fs/extent_cache.c
>>> @@ -645,14 +645,10 @@ static unsigned int __destroy_extent_node(struct
>>> inode *inode,
>>>          while (atomic_read(&et->node_cnt)) {
>>>            write_lock(&et->lock);
>>> -        if (!is_inode_flag_set(inode, FI_NO_EXTENT))
>>> -            set_inode_flag(inode, FI_NO_EXTENT);
>>
>> We'd better revert all change lines in "f2fs: fix node_cnt race between
>> extent node destroy and writeback"?
> 
> The others all check whether FI_NO_EXTENT is set. When it is set,
> inserting an age extent is disallowed, so nothing was removed.

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 87169fd29d89..0ed84cc065a7 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -119,10 +119,9 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
         if (!__init_may_extent_tree(inode, type))
                 return false;

-       if (is_inode_flag_set(inode, FI_NO_EXTENT))
-               return false;
-
         if (type == EX_READ) {
+               if (is_inode_flag_set(inode, FI_NO_EXTENT))
+                       return false;
                 if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
                                  !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
                         return false;

...

@@ -691,12 +688,12 @@ static void __update_extent_tree_range(struct inode *inode,

         write_lock(&et->lock);

-       if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
-               write_unlock(&et->lock);
-               return;
-       }
-
         if (type == EX_READ) {
+               if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
+                       write_unlock(&et->lock);
+                       return;
+               }
+
                 prev = et->largest;
                 dei.len = 0;

Hmm, I'm not sure I understood you correctly, if you want to keep above codes, what
about changing in another patch w/ correct commit message?

Thanks,


> 
> Thanks
> Yongpeng,
> 
>>
>> Thanks,
>>
>>>            node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>>>            write_unlock(&et->lock);
>>>        }
>>>    -    f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
>>> -
>>>        return node_cnt;
>>>    }
>>>    
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


