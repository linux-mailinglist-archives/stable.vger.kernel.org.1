Return-Path: <stable+bounces-155740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C49AE4370
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD3E189D41E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9FE24E019;
	Mon, 23 Jun 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTC9X8TP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FF230BC2;
	Mon, 23 Jun 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685214; cv=none; b=CjyaHgJnMDEJPYCKxS3Lfj3Yzs4bApVtlB05t3tkTI4TYpdSR/whRPScbbaQT1SUjCvcc2XpHMa7KqVp69gcyur1CSzkaH5ATp1sZ5x6dcfisBu1dRlcJOGPBK5b2LIb/0qYAO9EiIs5rzAd63/lhbTRAeKDRXOP761kTq6lhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685214; c=relaxed/simple;
	bh=UO3boePjUBrdUTISFeDkssFmLf6TnXSLyh/v+JoyigA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTbDeWP6tVar5bcgDyidpDciWJ8bPjjmGdlR/f5rEBjnZsEE+81rhkn1czInJxniuUP/2kWGsXV16j/KzHiABMTcYwf6Re5dH6vUQwJ3woLEc2NF4xWdYWLsolDvsL4+QdqUgJKVM78FqP4ldwisY+fXnAZMWUJLUOc74JoTTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cTC9X8TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D41C4CEEA;
	Mon, 23 Jun 2025 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685213;
	bh=UO3boePjUBrdUTISFeDkssFmLf6TnXSLyh/v+JoyigA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTC9X8TPxAY9Eu9+wmgJkm4+rOS4mn8UIOrPPXDa77TqQBTKLE33zJrVVRPWP5V2D
	 xbMJDIPOMO+H1rcQIg9KAmUNhQ1RqFQx2G5CQG1fj1aMhxNFsluIsjzWNOVCwYFm9Q
	 AacOqR8hW54RCdR4b3wURUWogtthFvc+9cEp1f2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Larry Bassel <larry.bassel@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/222] NFSD: Fix ia_size underflow
Date: Mon, 23 Jun 2025 15:06:50 +0200
Message-ID: <20250623130614.356609849@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e6faac3f58c7c4176b66f63def17a34232a17b0e ]

iattr::ia_size is a loff_t, which is a signed 64-bit type. NFSv3 and
NFSv4 both define file size as an unsigned 64-bit type. Thus there
is a range of valid file size values an NFS client can send that is
already larger than Linux can handle.

Currently decode_fattr4() dumps a full u64 value into ia_size. If
that value happens to be larger than S64_MAX, then ia_size
underflows. I'm about to fix up the NFSv3 behavior as well, so let's
catch the underflow in the common code path: nfsd_setattr().

Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
(cherry picked from commit e6faac3f58c7c4176b66f63def17a34232a17b0e)
[Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 2f221d6f7b88
attr: handle idmapped mounts]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6aa968bee0ce1..bee4fdf6e239a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -448,6 +448,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 			.ia_size	= iap->ia_size,
 		};
 
+		host_err = -EFBIG;
+		if (iap->ia_size < 0)
+			goto out_unlock;
+
 		host_err = notify_change(dentry, &size_attr, NULL);
 		if (host_err)
 			goto out_unlock;
-- 
2.39.5




