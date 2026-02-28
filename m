Return-Path: <stable+bounces-220845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA0TJ6ZGo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF311C7633
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98D5430D3E9A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A641996B;
	Sat, 28 Feb 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhsCasab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD0419960;
	Sat, 28 Feb 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300732; cv=none; b=Zv+aNHqjf3mI1Tls/lGE5eue3nsSrENUPF0FEy+3FLFoNiygF7w0yIf5cRgUlV2Lp6Xtyvy6pYPa+wlPTJT/1BaUdOWy7SVT2EJpDfuUDWefWUOgEnlA0hbNR3vJXflwy04QVHBjEwlqwhU477i7ucG/UQZOUxLdjwcOighY9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300732; c=relaxed/simple;
	bh=Hlmh0opQC9HK0eY7nsrWlsivURzKe8R1G54uAobADrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtuDBxnK+LL05lkdSHx78BDCINJezSOY9xQXEK2DiuIzh8rXSq5WBvPdD+pvs9h0P1EslZyBc5thNXIV1qu/AHWz2ijqV5k+0pQSz6jNY8L4ibKF+eVeCMSJQ6+lez4DGNcnDPAxTzcUOVb3WHS/U9ZV4yKLDQc3HFwuBIEBG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhsCasab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD10C116D0;
	Sat, 28 Feb 2026 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300732;
	bh=Hlmh0opQC9HK0eY7nsrWlsivURzKe8R1G54uAobADrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhsCasabwh+5YoY15talFuA/xIdPYeq2xlUxTIeeUKVhyrZ1kGBcwp11xgsEE+QzY
	 2R7FjhQrFQBch+owQ0LKQQTcPtZHMGfSqRZc9DvODCYLq+myYXV2riw/g/46EvI9lC
	 A7DCl2KmTPkeLjNOfq1W3Pe6sB27PltA0n5Flxt77T7GEAxYli1AY6P92Xwi8vISXy
	 LgEfc0K+2im7JH2np1biwZr30nMbcj2sRUsPnpcvadTAw2zbH9j36x9IhJwgEwJkWm
	 BQKvZ60yXa8SKIZynQu8LCPCZwUFwG3AdtHGSbuVia8x/pEgedLJiHf9OXh7AdR1WK
	 GK7K650sT8mPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ethanwu <ethanwu@synology.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 766/844] ceph: supply snapshot context in ceph_zero_partial_object()
Date: Sat, 28 Feb 2026 12:31:19 -0500
Message-ID: <20260228173244.1509663-767-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[synology.com,ibm.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220845-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCF311C7633
X-Rspamd-Action: no action

From: ethanwu <ethanwu@synology.com>

[ Upstream commit f16bd3fa74a2084ee7e16a8a2be7e7399b970907 ]

The ceph_zero_partial_object function was missing proper snapshot
context for its OSD write operations, which could lead to data
inconsistencies in snapshots.

Reproducer:
../src/vstart.sh --new -x --localhost --bluestore
./bin/ceph auth caps client.fs_a mds 'allow rwps fsname=a' mon 'allow r fsname=a' osd 'allow rw tag cephfs data=a'
mount -t ceph fs_a@.a=/ /mnt/mycephfs/ -o conf=./ceph.conf
dd if=/dev/urandom of=/mnt/mycephfs/foo bs=64K count=1
mkdir /mnt/mycephfs/.snap/snap1
md5sum /mnt/mycephfs/.snap/snap1/foo
fallocate -p -o 0 -l 4096 /mnt/mycephfs/foo
echo 3 > /proc/sys/vm/drop/caches
md5sum /mnt/mycephfs/.snap/snap1/foo # get different md5sum!!

Cc: stable@vger.kernel.org
Fixes: ad7a60de882ac ("ceph: punch hole support")
Signed-off-by: ethanwu <ethanwu@synology.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/file.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 983390069f737..9152b47227101 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2568,6 +2568,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
+	struct ceph_snap_context *snapc;
 	int ret = 0;
 	loff_t zero = 0;
 	int op;
@@ -2582,12 +2583,25 @@ static int ceph_zero_partial_object(struct inode *inode,
 		op = CEPH_OSD_OP_ZERO;
 	}
 
+	spin_lock(&ci->i_ceph_lock);
+	if (__ceph_have_pending_cap_snap(ci)) {
+		struct ceph_cap_snap *capsnap =
+				list_last_entry(&ci->i_cap_snaps,
+						struct ceph_cap_snap,
+						ci_item);
+		snapc = ceph_get_snap_context(capsnap->context);
+	} else {
+		BUG_ON(!ci->i_head_snapc);
+		snapc = ceph_get_snap_context(ci->i_head_snapc);
+	}
+	spin_unlock(&ci->i_ceph_lock);
+
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 					ceph_vino(inode),
 					offset, length,
 					0, 1, op,
 					CEPH_OSD_FLAG_WRITE,
-					NULL, 0, 0, false);
+					snapc, 0, 0, false);
 	if (IS_ERR(req)) {
 		ret = PTR_ERR(req);
 		goto out;
@@ -2601,6 +2615,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 	ceph_osdc_put_request(req);
 
 out:
+	ceph_put_snap_context(snapc);
 	return ret;
 }
 
-- 
2.51.0


