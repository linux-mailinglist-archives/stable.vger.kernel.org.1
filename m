Return-Path: <stable+bounces-220489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP/SFxc3o2lh+gQAu9opvQ
	(envelope-from <stable+bounces-220489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D71C626F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18D3D31B0000
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130A3C6C85;
	Sat, 28 Feb 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG+toGzk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF83C6C7E;
	Sat, 28 Feb 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300375; cv=none; b=PnTZ0Lcsubgp+fBioTjrEWE8Io70OjJl1IMdxve6TeD7nOld2cZBumoyzitXXBa1o+JilXvbZTL9dpn1ul5hmRe+223k0ZhpiDzWddLhg2oiOJb49hiNpt+7glK0tfmvHZC21ScrFuq+vRNcrT/n0jDQrTkPgmKqnvUiey2st8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300375; c=relaxed/simple;
	bh=+LFFS+stI+uOU1fATjaA1Y4zF0vcSj1p8FCwZJMkMoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjT8fvIxWmAnGnFyjmJMoeLyjVQMyOcamRUNi1g9VmfehSJKMGxVLVIdISqpwP1v+JJnmk42EfEwYw2CTi5+hzLuOnFUF3PThBQYZ88JxNMexQ98iecNNFYEIHbyiMNz6M/S05dYGNRgEvJ3zAPIXUf3odv7i+tp6+N8Md6I5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG+toGzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC77C116D0;
	Sat, 28 Feb 2026 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300375;
	bh=+LFFS+stI+uOU1fATjaA1Y4zF0vcSj1p8FCwZJMkMoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mG+toGzkYE2YW3/EKOVcabil79ZRL8/46incGPlzIEiWTz8YpzIw9bV50XDPabK6w
	 RVBhCzZ8Lk3bvO8/nXWK43IJeWhRHcpBC92GMMWybQVKug+60aJbZfy9cIY4+TVSRh
	 egpvWx8cJ6/sIMvt8sXT9fYurOzNRdHstYr902whcfuH8CQAEVY3wTzxs+tJShBnsF
	 lGB0C+d5H+j9so3IbJGueOjtFg9s+7p/1SSF9ufORQEfbFCd+iiprO6JaIIOQyepvR
	 IKt4WzAiK/ZZGNRYXK1eR4pFefZV8Qv/MSxgltoK2pXicnfeEssWvAzohTMI+MKRCD
	 PMcRTCSUvFRTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ethanwu <ethanwu@synology.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 410/844] ceph: supply snapshot context in ceph_uninline_data()
Date: Sat, 28 Feb 2026 12:25:23 -0500
Message-ID: <20260228173244.1509663-411-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[synology.com,ibm.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220489-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 038D71C626F
X-Rspamd-Action: no action

From: ethanwu <ethanwu@synology.com>

[ Upstream commit 305ff6b3a03c230d3c07b61457e961406d979693 ]

The ceph_uninline_data function was missing proper snapshot context
handling for its OSD write operations. Both CEPH_OSD_OP_CREATE and
CEPH_OSD_OP_WRITE requests were passing NULL instead of the appropriate
snapshot context, which could lead to unnecessary object clone.

Reproducer:
../src/vstart.sh --new -x --localhost --bluestore
// turn on cephfs inline data
./bin/ceph fs set a inline_data true --yes-i-really-really-mean-it
// allow fs_a client to take snapshot
./bin/ceph auth caps client.fs_a mds 'allow rwps fsname=a' mon 'allow r fsname=a' osd 'allow rw tag cephfs data=a'
// mount cephfs with fuse, since kernel cephfs doesn't support inline write
ceph-fuse --id fs_a -m 127.0.0.1:40318 --conf ceph.conf -d /mnt/mycephfs/
// bump snapshot seq
mkdir /mnt/mycephfs/.snap/snap1
echo "foo" > /mnt/mycephfs/test
// umount and mount it again using kernel cephfs client
umount /mnt/mycephfs
mount -t ceph fs_a@.a=/ /mnt/mycephfs/ -o conf=./ceph.conf
echo "bar" >> /mnt/mycephfs/test
./bin/rados listsnaps -p cephfs.a.data $(printf "%x\n" $(stat -c %i /mnt/mycephfs/test)).00000000

will see this object does unnecessary clone
1000000000a.00000000 (seq:2):
cloneid snaps   size    overlap
2       2       4       []
head    -       8

but it's expected to see
10000000000.00000000 (seq:2):
cloneid snaps   size    overlap
head    -       8

since there's no snapshot between these 2 writes

clone happened because the first osd request CEPH_OSD_OP_CREATE doesn't
pass snap context so object is created with snap seq 0, but later data
writeback is equipped with snapshot context.
snap.seq(1) > object snap seq(0), so osd does object clone.

This fix properly acquiring the snapshot context before performing
write operations.

Signed-off-by: ethanwu <ethanwu@synology.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d2142102..faecd9025ee9c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2199,6 +2199,7 @@ int ceph_uninline_data(struct file *file)
 	struct ceph_osd_request *req = NULL;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	struct folio *folio = NULL;
+	struct ceph_snap_context *snapc = NULL;
 	u64 inline_version = CEPH_INLINE_NONE;
 	struct page *pages[1];
 	int err = 0;
@@ -2226,6 +2227,24 @@ int ceph_uninline_data(struct file *file)
 	if (inline_version == 1) /* initial version, no data */
 		goto out_uninline;
 
+	down_read(&fsc->mdsc->snap_rwsem);
+	spin_lock(&ci->i_ceph_lock);
+	if (__ceph_have_pending_cap_snap(ci)) {
+		struct ceph_cap_snap *capsnap =
+				list_last_entry(&ci->i_cap_snaps,
+						struct ceph_cap_snap,
+						ci_item);
+		snapc = ceph_get_snap_context(capsnap->context);
+	} else {
+		if (!ci->i_head_snapc) {
+			ci->i_head_snapc = ceph_get_snap_context(
+				ci->i_snap_realm->cached_context);
+		}
+		snapc = ceph_get_snap_context(ci->i_head_snapc);
+	}
+	spin_unlock(&ci->i_ceph_lock);
+	up_read(&fsc->mdsc->snap_rwsem);
+
 	folio = read_mapping_folio(inode->i_mapping, 0, file);
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
@@ -2241,7 +2260,7 @@ int ceph_uninline_data(struct file *file)
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 0, 1,
 				    CEPH_OSD_OP_CREATE, CEPH_OSD_FLAG_WRITE,
-				    NULL, 0, 0, false);
+				    snapc, 0, 0, false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto out_unlock;
@@ -2257,7 +2276,7 @@ int ceph_uninline_data(struct file *file)
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 1, 3,
 				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
-				    NULL, ci->i_truncate_seq,
+				    snapc, ci->i_truncate_seq,
 				    ci->i_truncate_size, false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -2320,6 +2339,7 @@ int ceph_uninline_data(struct file *file)
 		folio_put(folio);
 	}
 out:
+	ceph_put_snap_context(snapc);
 	ceph_free_cap_flush(prealloc_cf);
 	doutc(cl, "%llx.%llx inline_version %llu = %d\n",
 	      ceph_vinop(inode), inline_version, err);
-- 
2.51.0


