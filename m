Return-Path: <stable+bounces-82473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B2994CF9
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6411F22077
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29851DE8B1;
	Tue,  8 Oct 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyvoM2cU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA56189910;
	Tue,  8 Oct 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392380; cv=none; b=CkKf6VwUtBB7KfwuVEkQ63gQpACgyF7Oa1yu8FTvTCaoRbTZ0T+R1MRTJJr9d5uSvuOQvNjjQIxLVbmI+TeXF8JnZZJAIQwJ/oJZwjEbqYAKiTyIgGCS0nyOORA4CTZWZcYsjcDzb19omZnEGOe3tiYA63LFY9YAePy2Rb7oXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392380; c=relaxed/simple;
	bh=Oh2RgEcExS9TNbqPmaPpEwIEjilyXX1fsdXEq2Gcn9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpL+OI/x3i1ztMDNL6rWrBkpWwOYszisFyMG0lhm/GqEsqHBel7o6lyvHHF/KlqciQ+dg5WcrGTE4X/Ln7Equ3MAk/sToJwNQ7pxd0Ftvspyix4hpYJkz5iQhcuqSr/+uamQj+h3oHMipixafc2lSPkW4hnNk3ja8x1CasR1CYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyvoM2cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F9CC4CEC7;
	Tue,  8 Oct 2024 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392380;
	bh=Oh2RgEcExS9TNbqPmaPpEwIEjilyXX1fsdXEq2Gcn9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyvoM2cUwoWnjhbpp7sX1s6y1MFFZGNZKFsgggWnEI2kEG7K23kmrEGzrPJSaZBIs
	 u0lynWDOihojobd1UAgW+ap9r5TFDgbr9Ih68t51ehzA8Vogifu0TCo21EUTx7Ps9P
	 oedXJpUvQ/vsYs6PyYI9jL7+msehRiK7lf7qSdAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wesley Hershberger <wesley.hershberger@canonical.com>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.11 398/558] ext4: fix off by one issue in alloc_flex_gd()
Date: Tue,  8 Oct 2024 14:07:08 +0200
Message-ID: <20241008115717.942227519@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit 6121258c2b33ceac3d21f6a221452692c465df88 upstream.

Wesley reported an issue:

==================================================================
EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
------------[ cut here ]------------
kernel BUG at fs/ext4/resize.c:324!
CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
RIP: 0010:ext4_resize_fs+0x1212/0x12d0
Call Trace:
 __ext4_ioctl+0x4e0/0x1800
 ext4_ioctl+0x12/0x20
 __x64_sys_ioctl+0x99/0xd0
 x64_sys_call+0x1206/0x20d0
 do_syscall_64+0x72/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

While reviewing the patch, Honza found that when adjusting resize_bg in
alloc_flex_gd(), it was possible for flex_gd->resize_bg to be bigger than
flexbg_size.

The reproduction of the problem requires the following:

 o_group = flexbg_size * 2 * n;
 o_size = (o_group + 1) * group_size;
 n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
 o_size = (n_group + 1) * group_size;

Take n=0,flexbg_size=16 as an example:

              last:15
|o---------------|--------------n-|
o_group:0    resize to      n_group:30

The corresponding reproducer is:

img=test.img
rm -f $img
truncate -s 600M $img
mkfs.ext4 -F $img -b 1024 -G 16 8M
dev=`losetup -f --show $img`
mkdir -p /tmp/test
mount $dev /tmp/test
resize2fs $dev 248M

Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
to prevent the issue from happening again.

[ Note: another reproucer which this commit fixes is:

  img=test.img
  rm -f $img
  truncate -s 25MiB $img
  mkfs.ext4 -b 4096 -E nodiscard,lazy_itable_init=0,lazy_journal_init=0 $img
  truncate -s 3GiB $img
  dev=`losetup -f --show $img`
  mkdir -p /tmp/test
  mount $dev /tmp/test
  resize2fs $dev 3G
  umount $dev
  losetup -d $dev

  -- TYT ]

Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Tested-by: Eric Sandeen <sandeen@redhat.com>
Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
Cc: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240927133329.1015041-1-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/resize.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -230,8 +230,8 @@ struct ext4_new_flex_group_data {
 #define MAX_RESIZE_BG				16384
 
 /*
- * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
- * @flexbg_size.
+ * alloc_flex_gd() allocates an ext4_new_flex_group_data that satisfies the
+ * resizing from @o_group to @n_group, its size is typically @flexbg_size.
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
@@ -239,25 +239,27 @@ static struct ext4_new_flex_group_data *
 				ext4_group_t o_group, ext4_group_t n_group)
 {
 	ext4_group_t last_group;
+	unsigned int max_resize_bg;
 	struct ext4_new_flex_group_data *flex_gd;
 
 	flex_gd = kmalloc(sizeof(*flex_gd), GFP_NOFS);
 	if (flex_gd == NULL)
 		goto out3;
 
-	if (unlikely(flexbg_size > MAX_RESIZE_BG))
-		flex_gd->resize_bg = MAX_RESIZE_BG;
-	else
-		flex_gd->resize_bg = flexbg_size;
+	max_resize_bg = umin(flexbg_size, MAX_RESIZE_BG);
+	flex_gd->resize_bg = max_resize_bg;
 
 	/* Avoid allocating large 'groups' array if not needed */
 	last_group = o_group | (flex_gd->resize_bg - 1);
 	if (n_group <= last_group)
-		flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
+		flex_gd->resize_bg = 1 << fls(n_group - o_group);
 	else if (n_group - last_group < flex_gd->resize_bg)
-		flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
+		flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
 					      fls(n_group - last_group));
 
+	if (WARN_ON_ONCE(flex_gd->resize_bg > max_resize_bg))
+		flex_gd->resize_bg = max_resize_bg;
+
 	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);



