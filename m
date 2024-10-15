Return-Path: <stable+bounces-85778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D399E90A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6C81C20CAC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6579C1EF956;
	Tue, 15 Oct 2024 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brUqiGXd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232281F7084;
	Tue, 15 Oct 2024 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994269; cv=none; b=VgqdJy19+w4m63G9u9nHn3d+3EVsLSi1DQrYNQkpiXRb/+y/JGx2mrFew3AAzuHo+M88+he0ikjF+b8GcwbXwXAJtkdjHe8TZpn3yiAjrnV+a7DhdRAHA93JshT+ssiqt5eY85UKg3Rr+P7FDZ5J+cBr0NQvwVdxBKOckcuvYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994269; c=relaxed/simple;
	bh=p1tiDKKmTR931nAKX9j5BzcWqPo/7phbEEHYACfidkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0Fky2s/3dw4TgcJ7GqopfedFGCiBWECeCsBAwnwHxV/HryEsksKivzG1NMedvGcI7TVBuVv9XTllgQ1ZiYHyWfeUc4ciJtPdCKTEVCioCP3WoWPbeRGVuWGXSUKDwxUqJwQdb/4LkENpdyvXZ2ZM1nzqu3fn8bB7MszX7M96ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brUqiGXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B2EC4CECF;
	Tue, 15 Oct 2024 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994269;
	bh=p1tiDKKmTR931nAKX9j5BzcWqPo/7phbEEHYACfidkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brUqiGXdjDRwSt+n7+at4H+/xmNeSQRdeKR74xjfgKxf/dvTgkJxRzR15U8i9Wr2a
	 69f2CJ8UGyoQt79IHHKsKriJL1MUTR3Nw+Zcwe/pPOHcVu8GtkJnQso08D0Ynuo5ID
	 1tGzuj8y46rrvdUuYmGhtYN/sQvikVrkOTq8DwwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 624/691] NFSD: Mark filecache "down" if init fails
Date: Tue, 15 Oct 2024 13:29:32 +0200
Message-ID: <20241015112505.098134904@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit dc0d0f885aa422f621bc1c2124133eff566b0bc8 ]

NeilBrown says:
> The handling of NFSD_FILE_CACHE_UP is strange.  nfsd_file_cache_init()
> sets it, but doesn't clear it on failure.  So if nfsd_file_cache_init()
> fails for some reason, nfsd_file_cache_shutdown() would still try to
> clean up if it was called.

Reported-by: NeilBrown <neilb@suse.de>
Fixes: c7b824c3d06c ("NFSD: Replace the "init once" mechanism")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 31169f0cc3d74..585163b4e11ce 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -717,7 +717,7 @@ nfsd_file_cache_init(void)
 
 	ret = rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = -ENOMEM;
 	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
@@ -769,6 +769,8 @@ nfsd_file_cache_init(void)
 
 	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
+	if (ret)
+		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
 	return ret;
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-- 
2.43.0




