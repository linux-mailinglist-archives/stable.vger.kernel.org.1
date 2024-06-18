Return-Path: <stable+bounces-53580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559C90D275
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C16628611E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B91A1ACE8B;
	Tue, 18 Jun 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tG+BpoEF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5ED15A853;
	Tue, 18 Jun 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716751; cv=none; b=P0Kyy5d2nV5plUuI/3H2xUE8Ga5/ojC9akOQOw/mOu8+KUdCF/kSnb8fKX2WPx7ve618Pr//DxNNYd++KVsy0JqCrA/FEtcQNlO0BWG0mC0P3X+yz29eOnDrKuL/Ua5vSOIlNuMd/SJ9JTWfoJI/ykeetGcrk/8ptH9X/3VpTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716751; c=relaxed/simple;
	bh=kURpm2AYaKzAZiDH17lEy0bj/Ytfd/TYeUvGp1gpblQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcN2GlQLQVpuy7SIDnufubmjnSSzluEIT7gDNcL9MLFJmlTdLiPtUbvUbs22NZliumwHni5ooBQLzhtKXDLRsG7JuLR2EAMnBSFPUDmLI9zlBeT3UMH5YDz7Bv3gesxpymYymmjDNJuulmIhO8eVFEen87RwPIM12XiiKZY2M4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tG+BpoEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944F9C3277B;
	Tue, 18 Jun 2024 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716751;
	bh=kURpm2AYaKzAZiDH17lEy0bj/Ytfd/TYeUvGp1gpblQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tG+BpoEFTeSdTfDddbohKMofNMbMVyOjOvLvmM3OpPU98njcyn+J1D/mI81+HMCJL
	 ikA0NtVyH7lQI6A3DtYaWW05Qi8TQV6KHbYsqvBX+GI5lsakNMbqa5JWwPZijslSAq
	 yq1n6CGIl8bde5aSzxabK0QjN3msRqYg0/BWGHV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 749/770] nfsd: dont take/put an extra reference when putting a file
Date: Tue, 18 Jun 2024 14:40:02 +0200
Message-ID: <20240618123436.182869654@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit b2ff1bd71db2a1b193a6dde0845adcd69cbcf75e ]

The last thing that filp_close does is an fput, so don't bother taking
and putting the extra reference.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index faa0c7d0253eb..786e06cf107ff 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -381,10 +381,8 @@ nfsd_file_free(struct nfsd_file *nf)
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
-		get_file(nf->nf_file);
-		filp_close(nf->nf_file, NULL);
 		nfsd_file_check_write_error(nf);
-		fput(nf->nf_file);
+		filp_close(nf->nf_file, NULL);
 	}
 
 	/*
-- 
2.43.0




