Return-Path: <stable+bounces-381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB77F7AD7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B681C20C59
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907F39FEA;
	Fri, 24 Nov 2023 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhqqiVgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730739FE7;
	Fri, 24 Nov 2023 17:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A79AC433C7;
	Fri, 24 Nov 2023 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700848750;
	bh=xSYtaafWu1nN7zqonkHuEnT7hsbaTuB39iFxzBLS9xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhqqiVgL6eIAgZPVVGy5liaMx2kwTIv6K0/So8s/N0xrym+3Fvbj5RJTH3l+RNSRY
	 bQMNASuyewRv+kIgPpcEU+7AlsPY99ABR3o5X1R0baOUU3s4XAthBzWfnWO/DvJcH0
	 CRsXsz5Q/wPpXRLiekB4+C/nLXs5YMDe8es+nG7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@google.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4.19 66/97] quota: explicitly forbid quota files from being encrypted
Date: Fri, 24 Nov 2023 17:50:39 +0000
Message-ID: <20231124171936.602246182@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171934.122298957@linuxfoundation.org>
References: <20231124171934.122298957@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit d3cc1b0be258191d6360c82ea158c2972f8d3991 upstream.

Since commit d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
fscrypt_master_key"), xfstest generic/270 causes a WARNING when run on
f2fs with test_dummy_encryption in the mount options:

$ kvm-xfstests -c f2fs/encrypt generic/270
[...]
WARNING: CPU: 1 PID: 2453 at fs/crypto/keyring.c:240 fscrypt_destroy_keyring+0x1f5/0x260

The cause of the WARNING is that not all encrypted inodes have been
evicted before fscrypt_destroy_keyring() is called, which violates an
assumption.  This happens because the test uses an external quota file,
which gets automatically encrypted due to test_dummy_encryption.

Encryption of quota files has never really been supported.  On ext4,
ext4_quota_read() does not decrypt the data, so encrypted quota files
are always considered invalid on ext4.  On f2fs, f2fs_quota_read() uses
the pagecache, so trying to use an encrypted quota file gets farther,
resulting in the issue described above being possible.  But this was
never intended to be possible, and there is no use case for it.

Therefore, make the quota support layer explicitly reject using
IS_ENCRYPTED inodes when quotaon is attempted.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230905003227.326998-1-ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/quota/dquot.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2385,6 +2385,20 @@ static int vfs_setup_quota_inode(struct
 	if (sb_has_quota_loaded(sb, type))
 		return -EBUSY;
 
+	/*
+	 * Quota files should never be encrypted.  They should be thought of as
+	 * filesystem metadata, not user data.  New-style internal quota files
+	 * cannot be encrypted by users anyway, but old-style external quota
+	 * files could potentially be incorrectly created in an encrypted
+	 * directory, hence this explicit check.  Some reasons why encrypted
+	 * quota files don't work include: (1) some filesystems that support
+	 * encryption don't handle it in their quota_read and quota_write, and
+	 * (2) cleaning up encrypted quota files at unmount would need special
+	 * consideration, as quota files are cleaned up later than user files.
+	 */
+	if (IS_ENCRYPTED(inode))
+		return -EINVAL;
+
 	dqopt->files[type] = igrab(inode);
 	if (!dqopt->files[type])
 		return -EIO;



