Return-Path: <stable+bounces-71062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C6F961179
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC6B1C2383D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F421CE6F9;
	Tue, 27 Aug 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wb9Ww2VY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F21C688E;
	Tue, 27 Aug 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771973; cv=none; b=q/gfvA7vDh7XZugPYjJsx6CisIVdJojsgyUb0VGpYuprH/RdMsnWel/G5J3pU9DFB1lz0fZvT66vbvG43fJrhoLsL2722MW0Jbbrl5m3NtpysunP6UmZk28zsdmIFSZnqd//puUy6hALozMg0DB4I7IJn3+tFWvBttSH7CpZby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771973; c=relaxed/simple;
	bh=U7GoDk/nTpOTpei5RacmQhIbA/9IX6Hv8sEeoBIqUEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMrqQoZ0sdYnFNUogAnJHSmLeVGAHadknFPYnX9FJE/xL2d6zRH6X/DQUAwf6Y+gEmR/GLvuaxVdwWdGRmIApLVxkF+3lYOteGsHhkp8b2OdRvAQO6VgBIeX48/YzckJLX4URij1lAHK/atJRZvZjn4jI/6XY2ZHd6AmYyEB/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wb9Ww2VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1946FC4AF68;
	Tue, 27 Aug 2024 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771972;
	bh=U7GoDk/nTpOTpei5RacmQhIbA/9IX6Hv8sEeoBIqUEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wb9Ww2VYNMeQUbCllOBpw6fwo4N3to1HqxlOfn3G6RQa2jcwrCJ6wCJdj12K0R19q
	 ro0gC/IMhfxAoeqmP4jNWtaHJ00OGAiE5Z/e4W4HvymjgPANIiQMVDcTzCyNq5bv7Y
	 CkPFSohNlzuop9vEqHpuzuD28F2bZHWYBUBtl29Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 076/321] udf: Fix bogus checksum computation in udf_rename()
Date: Tue, 27 Aug 2024 16:36:24 +0200
Message-ID: <20240827143841.134617538@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 27ab33854873e6fb958cb074681a0107cc2ecc4c ]

Syzbot reports uninitialized memory access in udf_rename() when updating
checksum of '..' directory entry of a moved directory. This is indeed
true as we pass on-stack diriter.fi to the udf_update_tag() and because
that has only struct fileIdentDesc included in it and not the impUse or
name fields, the checksumming function is going to checksum random stack
contents beyond the end of the structure. This is actually harmless
because the following udf_fiiter_write_fi() will recompute the checksum
from on-disk buffers where everything is properly included. So all that
is needed is just removing the bogus calculation.

Fixes: e9109a92d2a9 ("udf: Convert udf_rename() to new directory iteration code")
Link: https://lore.kernel.org/all/000000000000cf405f060d8f75a9@google.com/T/
Link: https://patch.msgid.link/20240617154201.29512-1-jack@suse.cz
Reported-by: syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/namei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7c95c549dd64e..ded71044988ab 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1183,7 +1183,6 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	if (dir_fi) {
 		dir_fi->icb.extLocation = cpu_to_lelb(UDF_I(new_dir)->i_location);
-		udf_update_tag((char *)dir_fi, udf_dir_entry_len(dir_fi));
 		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
 			mark_inode_dirty(old_inode);
 		else
-- 
2.43.0




