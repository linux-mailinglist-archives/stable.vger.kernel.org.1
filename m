Return-Path: <stable+bounces-106382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CCB9FE818
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572B37A14B3
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074F1531C4;
	Mon, 30 Dec 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgQi6cmI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F815E8B;
	Mon, 30 Dec 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573789; cv=none; b=ecl4LfZynB/K6kwCMOCfUIugKYQnWXSWN8e+bgWo3qDPMbpnjQoZOsOYGOKCWVIiHnMaeqw9oqPsAwZrWPVq4gDWLi6XiOwitwMMp4Xq6JCuW7+icsAMHI5P1xEcyZ3OwbQrOB5lV4KCJkoB+fxvn9n2s6wQnE0gtOXSvySYqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573789; c=relaxed/simple;
	bh=Hz48ULujoQkVOjKycKgnhvjymFYqywTvoFcjxLC7z9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFXRwuzDnKowZs31xp7oew0zdRScV1Y4/9yOOkIq5CNNrhcspvG4+bQwKbP/N+p4HweEBMg5ryftpnsooenTpN0/7bd9lfPmugMZ/Tiq/UsfpVrbIeRH0UTObQKxtgKugTgahLi8gfdjjrz4B3NS0BQSF/6+y3ScyU5gz6FoYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgQi6cmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F785C4CED0;
	Mon, 30 Dec 2024 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573788;
	bh=Hz48ULujoQkVOjKycKgnhvjymFYqywTvoFcjxLC7z9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgQi6cmILcjffIEIWwjS1jcIwc4oXk16/eBU/emDR442HdiZPN//kiO1gqlTuudQA
	 pTZw/5ADdcPeWeadpMo1wkM8APMxyeNCv0NH4VB7kdVOuyOuu4TSygEiMDbwN1ZCxB
	 6qF26Wkf0xAfieJ8SrmEU4jwnAkirYpxu0XRKRUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Erkun <yangerkun@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 09/86] nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"
Date: Mon, 30 Dec 2024 16:42:17 +0100
Message-ID: <20241230154212.068887587@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Erkun <yangerkun@huawei.com>

[ Upstream commit 69d803c40edeaf94089fbc8751c9b746cdc35044 ]

This reverts commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d.

Before this commit, svc_export_put or expkey_put will call path_put with
sync mode. After this commit, path_put will be called with async mode.
And this can lead the unexpected results show as follow.

mkfs.xfs -f /dev/sda
echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
exportfs -ra
service nfs-server start
mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
mount /dev/sda /mnt/sda
touch /mnt1/sda/file
exportfs -r
umount /mnt/sda # failed unexcepted

The touch will finally call nfsd_cross_mnt, add refcount to mount, and
then add cache_head. Before this commit, exportfs -r will call
cache_flush to cleanup all cache_head, and path_put in
svc_export_put/expkey_put will be finished with sync mode. So, the
latter umount will always success. However, after this commit, path_put
will be called with async mode, the latter umount may failed, and if
we add some delay, umount will success too. Personally I think this bug
and should be fixed. We first revert before bugfix patch, and then fix
the original bug with a different way.

Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/export.c | 31 ++++++-------------------------
 fs/nfsd/export.h |  4 ++--
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index d4d3ec58047e..4b5d998cbc2f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -40,24 +40,15 @@
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_put_work(struct work_struct *work)
+static void expkey_put(struct kref *ref)
 {
-	struct svc_expkey *key =
-		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree(key);
-}
-
-static void expkey_put(struct kref *ref)
-{
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
-
-	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
-	queue_rcu_work(system_wq, &key->ek_rcu_work);
+	kfree_rcu(key, ek_rcu);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -360,26 +351,16 @@ static void export_stats_destroy(struct export_stats *stats)
 					     EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_put_work(struct work_struct *work)
+static void svc_export_put(struct kref *ref)
 {
-	struct svc_export *exp =
-		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
-
+	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
 	kfree(exp->ex_uuid);
-	kfree(exp);
-}
-
-static void svc_export_put(struct kref *ref)
-{
-	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
-
-	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
-	queue_rcu_work(system_wq, &exp->ex_rcu_work);
+	kfree_rcu(exp, ex_rcu);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 9d895570ceba..ca9dc230ae3d 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -75,7 +75,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_work		ex_rcu_work;
+	struct rcu_head		ex_rcu;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -92,7 +92,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_work		ek_rcu_work;
+	struct rcu_head		ek_rcu;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
-- 
2.39.5




