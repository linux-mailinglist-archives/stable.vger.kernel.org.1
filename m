Return-Path: <stable+bounces-43167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66E8BDDFC
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407421C21849
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B8414D6ED;
	Tue,  7 May 2024 09:21:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985C14D45E
	for <stable@vger.kernel.org>; Tue,  7 May 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073671; cv=none; b=DlLZf8HvtIzez+vRd3/n65ynkCFKySgdAwk95eB34yHBwyeXo/vyw74+TrlMXYCQaMYTdxwuP1Sq9x9ieRspbtaSW6oYReukH28NQ9xrmfWYXML/1hqW/ntAGFE/RPn/e0gaEs903W1IlcUEE2mTvYcYRTFErpANLOHPab/u/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073671; c=relaxed/simple;
	bh=UagoAZE4E2SGR8YxKUiociLFVYBd1Sxq6tPr29/X+1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNpHzE6TWMAv8QDNYwDHguoxOsnA8QSXEucYfYIY231Mv2V3SAjvRiU4UIHx4TeXaTDV/7ryubZX2TYTF3elMWZkKLIo1c+tr9AgMcLxsUGTVT4yhNIwZEofvl+WHdWK6QCt3psT0iQAkoSsiJ5dKFzKai8mBAZxB0wWc+ZXUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 19ab15bc0c5311ef9305a59a3cc225df-20240507
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7cb91a48-580c-45fd-b745-6b6479f00317,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:18
X-CID-INFO: VERSION:1.1.37,REQID:7cb91a48-580c-45fd-b745-6b6479f00317,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
	release,TS:18
X-CID-META: VersionHash:6f543d0,CLOUDID:e85b107809a4de1fb5583c17657e9ca6,BulkI
	D:2405071720553NKPW3V7,BulkQuantity:0,Recheck:0,SF:66|24|16|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD
X-UUID: 19ab15bc0c5311ef9305a59a3cc225df-20240507
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <zhulei@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2053745088; Tue, 07 May 2024 17:20:52 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 27B67B8075B2;
	Tue,  7 May 2024 17:20:52 +0800 (CST)
X-ns-mid: postfix-6639F273-976737860
Received: from localhost.localdomain (unknown [10.42.176.164])
	by node2.com.cn (NSMail) with ESMTPA id CA145B8075B2;
	Tue,  7 May 2024 09:20:50 +0000 (UTC)
From: zhulei <zhulei@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: ap420073@gmail.com,
	davem@davemloft.net,
	jbenc@redhat.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: 4.19 stable kernel crash caused by vxlan testing
Date: Tue,  7 May 2024 17:20:49 +0800
Message-Id: <20240507092049.1713953-1-zhulei@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024042356-launch-recapture-4bb1@gregkh>
References: <2024042356-launch-recapture-4bb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By making the following changes and using our own 4.19 kernel
verification, we can observe the output that passes the test
in dmesg.

When using the 4.19 stable branch kernel for verification, the
dmesg has no output, which looks more like the test program is not
running. However, the code of vxlan.c is the same.

May i ask if the changes made to the maintainer are reasonable?

---
 drivers/net/vxlan.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 704db80df38b..d3000c58c0f2 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -657,6 +657,14 @@ static struct vxlan_fdb *vxlan_fdb_alloc(struct vxla=
n_dev *vxlan,
 	return f;
 }
=20
+static void vxlan_fdb_insert(struct vxlan_dev *vxlan, const u8 *mac,
+			     __be32 src_vni, struct vxlan_fdb *f)
+{
+	++vxlan->addrcnt;
+	hlist_add_head_rcu(&f->hlist,
+			   vxlan_fdb_head(vxlan, mac, src_vni));
+}
+
 static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 			    const u8 *mac, union vxlan_addr *ip,
 			    __u16 state, __be16 port, __be32 src_vni,
@@ -682,10 +690,6 @@ static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		return rc;
 	}
=20
-	++vxlan->addrcnt;
-	hlist_add_head_rcu(&f->hlist,
-			   vxlan_fdb_head(vxlan, mac, src_vni));
-
 	*fdb =3D f;
=20
 	return 0;
@@ -758,15 +762,15 @@ static int vxlan_fdb_update(struct vxlan_dev *vxlan=
,
 	if (notify) {
 		if (rd =3D=3D NULL)
 			rd =3D first_remote_rtnl(f);
+		vxlan_fdb_insert(vxlan, mac, src_vni, f);
 		vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH);
 	}
=20
 	return 0;
 }
=20
-static void vxlan_fdb_free(struct rcu_head *head)
+static void __vxlan_fdb_free(struct vxlan_fdb *f)
 {
-	struct vxlan_fdb *f =3D container_of(head, struct vxlan_fdb, rcu);
 	struct vxlan_rdst *rd, *nd;
=20
 	list_for_each_entry_safe(rd, nd, &f->remotes, list) {
@@ -776,6 +780,13 @@ static void vxlan_fdb_free(struct rcu_head *head)
 	kfree(f);
 }
=20
+static void vxlan_fdb_free(struct rcu_head *head)
+{
+	struct vxlan_fdb *f =3D container_of(head, struct vxlan_fdb, rcu);
+
+	__vxlan_fdb_free(f);
+}
+
 static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb =
*f,
 			      bool do_notify)
 {
@@ -3265,9 +3276,12 @@ static int __vxlan_dev_create(struct net *net, str=
uct net_device *dev,
 	if (err)
 		goto errout;
=20
-	/* notify default fdb entry */
-	if (f)
+	if (f) {
+		vxlan_fdb_insert(vxlan, all_zeros_mac,
+				 vxlan->default_dst.remote_vni, f);
+		/* notify default fdb entry */
 		vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH);
+	}
=20
 	list_add(&vxlan->next, &vn->vxlan_list);
 	return 0;
@@ -3278,9 +3292,11 @@ static int __vxlan_dev_create(struct net *net, str=
uct net_device *dev,
 	 * destroy the entry by hand here.
 	 */
 	if (f)
-		vxlan_fdb_destroy(vxlan, f, false);
-	if (unregister)
+		__vxlan_fdb_free(f);
+	if (unregister) {
+		vxlan_fdb_destroy(vxlan, f, true);
 		unregister_netdevice(dev);
+	}
 	return err;
 }
=20
--=20
2.27.0


