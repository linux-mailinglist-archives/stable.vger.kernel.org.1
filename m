Return-Path: <stable+bounces-92456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6709C5431
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CFD284932
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53DF21216C;
	Tue, 12 Nov 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NJt7QOVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC51EE02B;
	Tue, 12 Nov 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407719; cv=none; b=pR/gg9w/v8lIHrWZeAO6NDTrFvlDDy+aAQgNGWY+sQU6gTu80vRiB2twNrjFnqrLn+VkLgkKguFgHLHgTlhpFYNJylAMY7yC3mFpBtp+c1BAgtZ2NwT7OboJIKvJ13O2bBSOrtKg0noVPGc2MZnxE4X1I5yReiThCrHd9Nlum3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407719; c=relaxed/simple;
	bh=fpQN5Z4N4GeK0pGoOBYykfTN4ePE11CN6+EP8F5aDMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0jCHycfKZp81/OGbgDK4iN/uuD9sHR4CoRCQwSJ6MC6lLX0VfIY1IspIoD6crz9R+WbkSEGBgZCxJr418H0MhcyVepnDgaMlef3YONAJYRIDESiYSsHcQXPcSm53w7BRDYFtPFVXlBeOXHoXyMBbUgrqbtBzO57uGHHxoQ/4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NJt7QOVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E7DC4CECD;
	Tue, 12 Nov 2024 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407719;
	bh=fpQN5Z4N4GeK0pGoOBYykfTN4ePE11CN6+EP8F5aDMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJt7QOVNsnro4bzLledJpVL+JlsL+unrXjdjWNEsEcw7uzw4AbfFFhFDTsVKmKt7Y
	 kKacV3WviuExXnIyfTTAgY5QWUAC+IbcGhlVJUj2rkb9j8YUMOCPjZScEOXdZiSciI
	 KmmDidY/VWdBUt3sqZsFaGhRDd7SJSRE4qEPLPLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5b415c07907a2990d1a3@syzkaller.appspotmail.com,
	Chen Ridong <chenridong@huawei.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/119] security/keys: fix slab-out-of-bounds in key_task_permission
Date: Tue, 12 Nov 2024 11:20:37 +0100
Message-ID: <20241112101849.828337388@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit 4a74da044ec9ec8679e6beccc4306b936b62873f ]

KASAN reports an out of bounds read:
BUG: KASAN: slab-out-of-bounds in __kuid_val include/linux/uidgid.h:36
BUG: KASAN: slab-out-of-bounds in uid_eq include/linux/uidgid.h:63 [inline]
BUG: KASAN: slab-out-of-bounds in key_task_permission+0x394/0x410
security/keys/permission.c:54
Read of size 4 at addr ffff88813c3ab618 by task stress-ng/4362

CPU: 2 PID: 4362 Comm: stress-ng Not tainted 5.10.0-14930-gafbffd6c3ede #15
Call Trace:
 __dump_stack lib/dump_stack.c:82 [inline]
 dump_stack+0x107/0x167 lib/dump_stack.c:123
 print_address_description.constprop.0+0x19/0x170 mm/kasan/report.c:400
 __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
 kasan_report+0x3a/0x50 mm/kasan/report.c:585
 __kuid_val include/linux/uidgid.h:36 [inline]
 uid_eq include/linux/uidgid.h:63 [inline]
 key_task_permission+0x394/0x410 security/keys/permission.c:54
 search_nested_keyrings+0x90e/0xe90 security/keys/keyring.c:793

This issue was also reported by syzbot.

It can be reproduced by following these steps(more details [1]):
1. Obtain more than 32 inputs that have similar hashes, which ends with the
   pattern '0xxxxxxxe6'.
2. Reboot and add the keys obtained in step 1.

The reproducer demonstrates how this issue happened:
1. In the search_nested_keyrings function, when it iterates through the
   slots in a node(below tag ascend_to_node), if the slot pointer is meta
   and node->back_pointer != NULL(it means a root), it will proceed to
   descend_to_node. However, there is an exception. If node is the root,
   and one of the slots points to a shortcut, it will be treated as a
   keyring.
2. Whether the ptr is keyring decided by keyring_ptr_is_keyring function.
   However, KEYRING_PTR_SUBTYPE is 0x2UL, the same as
   ASSOC_ARRAY_PTR_SUBTYPE_MASK.
3. When 32 keys with the similar hashes are added to the tree, the ROOT
   has keys with hashes that are not similar (e.g. slot 0) and it splits
   NODE A without using a shortcut. When NODE A is filled with keys that
   all hashes are xxe6, the keys are similar, NODE A will split with a
   shortcut. Finally, it forms the tree as shown below, where slot 6 points
   to a shortcut.

                      NODE A
              +------>+---+
      ROOT    |       | 0 | xxe6
      +---+   |       +---+
 xxxx | 0 | shortcut  :   : xxe6
      +---+   |       +---+
 xxe6 :   :   |       |   | xxe6
      +---+   |       +---+
      | 6 |---+       :   : xxe6
      +---+           +---+
 xxe6 :   :           | f | xxe6
      +---+           +---+
 xxe6 | f |
      +---+

4. As mentioned above, If a slot(slot 6) of the root points to a shortcut,
   it may be mistakenly transferred to a key*, leading to a read
   out-of-bounds read.

To fix this issue, one should jump to descend_to_node if the ptr is a
shortcut, regardless of whether the node is root or not.

[1] https://lore.kernel.org/linux-kernel/1cfa878e-8c7b-4570-8606-21daf5e13ce7@huaweicloud.com/

[jarkko: tweaked the commit message a bit to have an appropriate closes
 tag.]
Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Reported-by: syzbot+5b415c07907a2990d1a3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000cbb7860611f61147@google.com/T/
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/keyring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4448758f643a5..f331725d5a370 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -772,8 +772,11 @@ static bool search_nested_keyrings(struct key *keyring,
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
 		ptr = READ_ONCE(node->slots[slot]);
 
-		if (assoc_array_ptr_is_meta(ptr) && node->back_pointer)
-			goto descend_to_node;
+		if (assoc_array_ptr_is_meta(ptr)) {
+			if (node->back_pointer ||
+			    assoc_array_ptr_is_shortcut(ptr))
+				goto descend_to_node;
+		}
 
 		if (!keyring_ptr_is_keyring(ptr))
 			continue;
-- 
2.43.0




