Return-Path: <stable+bounces-97130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA29E253D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9B9B37D41
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F81F7550;
	Tue,  3 Dec 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwlFoUE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D01F7071;
	Tue,  3 Dec 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239606; cv=none; b=YkasRDriALPcJITH8IF5yXaZ/UQIEn2iVaWQ4/DhzHOkm3MuqJ+RdyRsuz2He2JD5JGbTndMQDLOkwKUKEm3OPGmYcXX8DrSyqhZ+VqGmdMna4U5fdgZcZhAjqorQsnCcLZCdQuYqdgFtEyDmE/roIHN+MJEIeTpdQo45EjbMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239606; c=relaxed/simple;
	bh=kVKD7EzxuF514vNRISNx7ZtVCooCDlOCObCS4HyV0hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB6MlZ4IzGbN5Iq2CXOWEcbSH1vm0I4HgrAHZG/dx1ItzHfXzNdt4rrInVQMf7z7XqJ6NuzvMFOaWQeI2Z9rmEA3Ln8oJH2aIv5zyiVD8dJj16CJRA2Sl/zT8j2mkhwXDB/oSyboMVHOLKeTrrT8KSCPPJUnraCpxUn2TcKuZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wwlFoUE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7F8C4CECF;
	Tue,  3 Dec 2024 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239605;
	bh=kVKD7EzxuF514vNRISNx7ZtVCooCDlOCObCS4HyV0hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wwlFoUE0vYOFKKhgogFKq4IeWOT9dOSWorlviNpRWV+HxXIdYYOa52gMOIzt4TKFU
	 9MRlgsStVDAXqp7K2bFl+gAqzgp/MkmLjkv1N6Kl8l1yedY3Axp44uh1ooR4DUpaar
	 n60m1soXSA3V4WSU5ZQKBzcnis6fWCl8WsfAf328=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.11 671/817] exfat: fix uninit-value in __exfat_get_dentry_set
Date: Tue,  3 Dec 2024 15:44:03 +0100
Message-ID: <20241203144022.149073290@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 02dffe9ab092fc4c8800aee68cb7eafd37a980c4 upstream.

There is no check if stream size and start_clu are invalid.
If start_clu is EOF cluster and stream size is 4096, It will
cause uninit value access. because ei->hint_femp.eidx could
be 128(if cluster size is 4K) and wrong hint will allocate
next cluster. and this cluster will be same with the cluster
that is allocated by exfat_extend_valid_size(). The previous
patch will check invalid start_clu, but for clarity, initialize
hint_femp.eidx to zero.

Cc: stable@vger.kernel.org
Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
Tested-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exfat/namei.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -345,6 +345,7 @@ static int exfat_find_empty_entry(struct
 		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
 			ei->start_clu = clu.dir;
 			p_dir->dir = clu.dir;
+			hint_femp.eidx = 0;
 		}
 
 		/* append to the FAT chain */



