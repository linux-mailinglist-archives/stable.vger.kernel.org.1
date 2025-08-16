Return-Path: <stable+bounces-169862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C426EB28E66
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545467BA842
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3412EACE7;
	Sat, 16 Aug 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="m9vCKHyK"
X-Original-To: stable@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AF2EAD00
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353599; cv=none; b=a4Q4UrZSdWOVA1rnKYT4ZAZQxfzkvN1h+GmpXX3h/UoWxChmoLgsK1lB6BQbn8czwPmrO8teFNVpLR6a3LHXdQ6aNJbZU1366bHtSjdnTD46Ryy9nHxSjihpREe+WMN50Vz+TT8FBzBcVSSZfvnVgJ8P8ATZXmkEZ5boEilTHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353599; c=relaxed/simple;
	bh=m9P48Ohs96Wlh4Ls9H7JsnINbOQm56N2LA6GI1qW/pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cdiSq0CCqw7hOjQabybzEnz+yslBCbr9yT2/jT9QicjliFR9MLbqdkBwf3jOLXGJt8k/cMJdc98J1ANeLuFpjdURm5fN2H7HP6HuBgBaDIQXVr9qqYpfDsBZ6eRxF7oiTTdYWc6VNJvAzwyjWa0ipGe/ZDUyRfzDYiBNoJJCsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=m9vCKHyK; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 7B040240027
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 16:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1755353590; bh=QVtoCaM9dNujyJoQTU+vTVDlVfr9CLInFCfLU4dyJ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=m9vCKHyK23a/y+Ju68xmhpgCEWaeXsPNI3cgkj3crrPrsf68nJCqbR9NkZl5fSvIT
	 aiOrk1si5T4OOaLDzDTc0Dsi+xAH4VYIDPO9vMYNYihv5A9ahO5Hex9neKo2DOxpY+
	 ze3P9Lp2cWX7B9Lk+nA6v00e5jhbubpxQMV4KKBKgiWtcj89QVJIJ3UEgdJIwYMX9M
	 EHEl1sz08NVsQbErpnHnGYgcilDz4Nl6pcQq3NJv8PPYEc7WkOn+iLmYn3Y1H3wQn8
	 yKeJrbBuTNtb6vpn9C8qd9vDlpwAi2ZO2B3eg3Im1su76DiWwn/FbrWsi9RUxwaOem
	 +81KdVExN42IQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4c41Cm74cyz6twQ;
	Sat, 16 Aug 2025 16:13:08 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Christian
 Brauner <brauner@kernel.org>,  David Howells <dhowells@redhat.com>,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] debugfs: fix mount options not being applied
In-Reply-To: <b169faca-fef9-4099-920a-c34cc9a985a8@redhat.com>
References: <20250813-debugfs-mount-opts-v2-1-0ca79720edc6@posteo.net>
	<b169faca-fef9-4099-920a-c34cc9a985a8@redhat.com>
Date: Sat, 16 Aug 2025 14:13:10 +0000
Message-ID: <87a53zuzgr.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@redhat.com> writes:

> On 8/13/25 6:55 PM, Charalampos Mitrodimas wrote:
>> Mount options (uid, gid, mode) are silently ignored when debugfs is
>> mounted. This is a regression introduced during the conversion to the
>> new mount API.
>> 
>> When the mount API conversion was done, the line that sets
>> sb->s_fs_info to the parsed options was removed. This causes
>> debugfs_apply_options() to operate on a NULL pointer.
>
> The change looks fine to me but I'm a little confused by this paragraph.
> Is there something in the current code that will lead to an OOPs of
> the kernel on a NULL ptr?

Ah, sorry for the confusion, I worded that poorly. There's no OOPs in
the code.

Sending a v3 for it.

>
> I just don't want to generate CVEs if we don't have to ;)
>
> As for the code change itself,
>
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Thanks!

>
> Thanks!
>
>> Fix this by following the same pattern as the tracefs fix in commit
>> e4d32142d1de ("tracing: Fix tracefs mount options"). Call
>> debugfs_reconfigure() in debugfs_get_tree() to apply the mount options
>> to the superblock after it has been created or reused.
>> 
>> As an example, with the bug the "mode" mount option is ignored:
>> 
>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>>   $ mount | grep debugfs_test
>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>>   $ ls -ld /tmp/debugfs_test
>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
>> 
>> With the fix applied, it works as expected:
>> 
>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>>   $ mount | grep debugfs_test
>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime,mode=666)
>>   $ ls -ld /tmp/debugfs_test
>>   drw-rw-rw- 37 root root 0 Aug  2 17:28 /tmp/debugfs_test
>> 
>> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220406
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> ---
>> Changes in v2:
>> - Follow the same pattern as e4d32142d1de ("tracing: Fix tracefs mount options")
>> - Add Cc: stable tag
>> - Link to v1: https://lore.kernel.org/r/20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net
>> ---
>>  fs/debugfs/inode.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>> index a0357b0cf362d8ac47ff810e162402d6a8ae2cb9..c12d649df6a5435050f606c2828a9a7cc61922e4 100644
>> --- a/fs/debugfs/inode.c
>> +++ b/fs/debugfs/inode.c
>> @@ -183,6 +183,9 @@ static int debugfs_reconfigure(struct fs_context *fc)
>>  	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
>>  	struct debugfs_fs_info *new_opts = fc->s_fs_info;
>>  
>> +	if (!new_opts)
>> +		return 0;
>> +
>>  	sync_filesystem(sb);
>>  
>>  	/* structure copy of new mount options to sb */
>> @@ -282,10 +285,16 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>  
>>  static int debugfs_get_tree(struct fs_context *fc)
>>  {
>> +	int err;
>> +
>>  	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
>>  		return -EPERM;
>>  
>> -	return get_tree_single(fc, debugfs_fill_super);
>> +	err = get_tree_single(fc, debugfs_fill_super);
>> +	if (err)
>> +		return err;
>> +
>> +	return debugfs_reconfigure(fc);
>>  }
>>  
>>  static void debugfs_free_fc(struct fs_context *fc)
>> 
>> ---
>> base-commit: 3c4a063b1f8ab71352df1421d9668521acb63cd9
>> change-id: 20250804-debugfs-mount-opts-2a68d7741f05
>> 
>> Best regards,

