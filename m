Return-Path: <stable+bounces-71511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723C9649B4
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40552283476
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BAD1B140E;
	Thu, 29 Aug 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="Uw51ajH5"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B018CC07
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944673; cv=fail; b=LWXXw9PnPWJ5cgLQleG++QRyjhy67mjKu8bx0E4Uxv4NzBzlPsJMLG1DIOG+nb0O2SN1+0wKv8+L1mRncKsLmwIg6jjLNVT8GPIMpoezPvUCQ5XfAmGcqbwcNh73n32115QXtXYSoMJnMCulYwYIuX+7jHOwsvOE8nIrfszwMqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944673; c=relaxed/simple;
	bh=lRyQBvdyjwlc+r+sDK/OuvHuoC0T0TVzye2FvjNn5k0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uy55FvYnbHm6LB97xS28iyqTlwPQUrlmKij0tTIRkX4h+ASsLsnaIV7hRP8cafPDGyAVGfSwE7Fj3KYKrOythpBBB+tQ0vl23I5OdJ0f12be9jJCkMblKNNczuoBDSu8rZZh3GZMLdoCZE1l3AvZA38uXn2edqJzUfP1B63Sfoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=Uw51ajH5; arc=fail smtp.client-ip=40.107.20.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHcF1SG1qyCa+RaosBzgdbd2ihtTPrMRg7bG0D4S/kVBjNMHyR7Gjx2N0p+BpwTSthHRSGiFfPeL8t6xiwLv/rEAPGvmHceNoEJcQKT7Gn/Vq+wCx5x1xSz6WGn2aj5A5mpmNSGNzWgA/y01yWi/zmdsms3aHGLq5s3W920oZyucvYiueVYJvNzTUZmW+PQYI4GjK3DUDe/1MrCEajNIDcLhDncHfPC1wUyugHOgIFsCZFiuFfC9aC8VaGrPNZlMj8D9GQ0KdxgZMR2gNkH0J32Hm97zGXh7jRKxdA0asM5iJZ9A1vor6Ykb05lmUVuvWCE8/Jyq6VjaHisXFXcVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNwv1CwUxw14wiD5RoQSeSWLOkApN0/Y987XsC1jYrc=;
 b=oI75qFNUN6x6IfxMiWYD2G4Y75kUQJbKqHE0Az+zLg5AbX19nCsfLNGAikxB780M3Sfji2awJVG6N9O14DpuEEXA52Lqw4VtgNxtose17Ybt9iIjYc3z2I5eHLyqOk30aZ/mj2mZjJmMEItobiMwKrfVudaBBkZo55gkOJrOuAHBPnlYKsrtr4u6mhgtSIJFFbGA8UZmzhvWJpIJZY55jHTp+YiGJI3XuCXMw9KkSLZnZATr3lw4gGFmav9LEvjxy9jf4Nr7ByfNnsnhT+9BaEXVMpBqUg9SaYBkCCSTLjISCD7YLO64pTT9iGUcY53ILriBIBBE7CdlMXk9iLcraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNwv1CwUxw14wiD5RoQSeSWLOkApN0/Y987XsC1jYrc=;
 b=Uw51ajH5v2qPyAYAxfAHnJKcS4KnOtoLy+btdH6rPQ3/6J/kP9Dj+RYjPTsyIvB+njLs2YEUaE/cpWiToANZtKq3DA8z3ydBJ7ek/Zn/kdbYdvYOKXJ+RhE3LMjOce3CVV9AvOROlq+z5fLS+MsmdZ2ks4HSs6ehkDuBmcA7qQxSnGvzLBHG9JvXaq7FVlByuAzkrniut4r3/MSs0X/hjETDymG0nU1H1IqLxcu7MJhKmXGEcCZ7SKUfDafhLdCov2aeX/sh9llGDSqcyrN6tqjMGLb4Z+nkilU5sSk2hixAen4fQg58jtEjXZYo2VdlSiRu2TKxTx+9TLF30k09hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2266.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:64c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:17:44 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:17:44 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 1/6] ovl: check permission to open real file
Date: Thu, 29 Aug 2024 17:17:00 +0200
Message-ID: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2266:EE_
X-MS-Office365-Filtering-Correlation-Id: 554759ca-4fd1-4ea8-2f01-08dcc83dbb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S+g2V3/CqWFNruPwagQBJ3onGJ5Uf5hZdvVBkwgUIB+j3Oqf3Ph97y7ii1cc?=
 =?us-ascii?Q?2nmMGcU2AlkDC3yWobcbXuHZ20maGmtKJ8xCic9fjUYdXx8n7lpQYj+NSyPj?=
 =?us-ascii?Q?vn1aEufePJzjZruxR1uLh5jhDnkFoZWKJT5QBfl2CfpzKXmQ79rcpvlRZyC4?=
 =?us-ascii?Q?167bwfs9F1FerpwyNQHAnLCZ4NLHXa+Zo2d0NG4zcNA8/UGOEBf6LG+J/dbM?=
 =?us-ascii?Q?zer3FYRVoy9/WvY4p3BlTBx+DpDfFiE3FEd7VfR1bkJJpON10Wb/K1+qcANd?=
 =?us-ascii?Q?leDpMnjX6tsIaviybJ0Z1LuWLP3D72ddRxvZf7Fm0ZNWxaSBvgzKMNpkBkzb?=
 =?us-ascii?Q?nBOTXWFY0usx8d+417RCfixLZ9yv8b9lyp3RySAWwX3yxUXNFasK65Mq2jA2?=
 =?us-ascii?Q?0IQybB9Dr5u3RO3vJJRjGE094AO14F5IyWNo5CBMUpFc6tO0PfHdNqK4DOXl?=
 =?us-ascii?Q?rIvKdJy8ZNIZ+1O7dn+7wW5ZzMHJDZoveJmXuHrw1c132GhtQNTBn7DLk0sj?=
 =?us-ascii?Q?Rn+9xn0z81cniPVsU3MsVAPklWazSSTusr4UgodC/nKbfARtF70Ah98WhaBl?=
 =?us-ascii?Q?vBUOVQjDGN3lhvm2wLDQfH0vwtXsKZVmkwJxSGVbEKLfRjJcqHABFEl9X/7S?=
 =?us-ascii?Q?iSPT8UHKckPXJFYiHv0yVibHsDfRphdr52DLCeqP42s+WbBFY6Le25Z/ifK2?=
 =?us-ascii?Q?8CJilTWJwkOe+9wkHckydBofgWHeAfGBi11+8qO+Qn6ELVVpj3AQu9m3LCKd?=
 =?us-ascii?Q?fby8fNx5cXauUJz+EuMXvgppZYHKjWLtz/1sCZSt1kx/NdRxIO3qGXikbVLs?=
 =?us-ascii?Q?VPI16MkBgQVkpgqjcdopEap10kaQZLlT1v2Z9xhbYlAio8bvplaecsLdbA8w?=
 =?us-ascii?Q?MXTneuVUS9vK36es9svYC82D9XvnNFCzuyYztd73rmReePGX/Ck8POQASOc1?=
 =?us-ascii?Q?0hVewvpL8kPCrjOB955E0mYIvpn3bjXy1hX13CU66zK9Fd8lvlXzbnXtzSAm?=
 =?us-ascii?Q?UOcmWJ5vlXEqEY9slXG6k1c3eYuCE81VER2iP/yJH7ZOGOVPAyiCxJF5wT0v?=
 =?us-ascii?Q?dS21kT7/q6q0zYmYkeSAL/SycEUABHnzicxXywL7//hgnvP7MzBnTIdAHMMk?=
 =?us-ascii?Q?+95vXMSPX9uxpwonP6VSNwM2NoIT2mKETmud7O1uwlWR7+/sWIkclpP6r4qs?=
 =?us-ascii?Q?f9pFScdZMTYYAG0VbYzDbGuwwICskVYXlgEPApiLRbZl18edIw/zwjLGCRcg?=
 =?us-ascii?Q?OrD8ixVzRXCnk//4AEzxjk1fGgtVtuW/nln6BPq2ktJFrSvRlhbQuLcTkkQ5?=
 =?us-ascii?Q?T/zWzMk2G7DIyKA8nC37SKys0mXyYovmGQZfSaMwcHwswYmz78OMZJOCfYjN?=
 =?us-ascii?Q?gMgi7tmX2AJucK3/CUUj0h3KmQUG8IB6v8e2pC90wGoMZY2jmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WsbM3k116RfiH5gKieR/98NrhhKd7aVxpgfVX2+HL+yhkC5whzRVJjue5vej?=
 =?us-ascii?Q?vWj8aZ1/mdVLbpx1BIjQpCh/Um4RLnVZJ2BKp0GhYkReGMN4iDccqidWV1wu?=
 =?us-ascii?Q?oy9OlZGY3IKmcYQU/eSWA+CnxivlX9kHTNyBi7ia4FERr5pZkBldfA98kgIh?=
 =?us-ascii?Q?OUaAZI4uD7TzEnrnFjdgGLOsG03sHwxFk5Ys/YVvYws/laxOqU5seQHzpYdc?=
 =?us-ascii?Q?gfFZbyzgt8WvwdCBhR13Ymncm9E6Grez4b/T3sGJ8dMeMsZPcvdig/gZN7Py?=
 =?us-ascii?Q?MKV2cORpsKTryheqAtjbI8d5TLqZwuxVLKNTJZM3UCXYMC9zx4XxhLhjvcKj?=
 =?us-ascii?Q?3eSk4lk5nKjuBKi2T4gtkgRX2WcUzzaDiV1GtpdmwSxJZy+P1eiIwhea3j7v?=
 =?us-ascii?Q?TnoM8ng7Y58slbJnN9H7n+SLiT/S1PlOUKSo+8LxEL7dJTz5jBzO1aCzIJlU?=
 =?us-ascii?Q?YAkeUcga0bcWOeW9/vsS80ubxVKre6VO04Aj0S5tvfRGFJrirlWuTpCq9AMP?=
 =?us-ascii?Q?k9SlnGeK7PCUT9957azlV7d10lO6lXMJlg+98b2pJAyLKnHhG17Hdlsndcu8?=
 =?us-ascii?Q?dojarI0e/T3EES0tO8B6mbFcg1f68QCPXbO9D7kdvB/HABj+CPSzfhh73ACK?=
 =?us-ascii?Q?JYNRizqgme+3BdMSY2K4IxWHqN3z/6JuvEt1O89m05bUkoxLfzf2FeCIzEH5?=
 =?us-ascii?Q?i75ooCufZhMOaPG/tSQPiWnfvdaqh1YKy1DRarNjxFH023oPUmyyFSuFVt4g?=
 =?us-ascii?Q?kXGaRpA1U6mjuEWLL1XQWlUWrVHLZNbU9f/gQouhmuqJPHWpyn0sbHX3HwRH?=
 =?us-ascii?Q?IguEF3F4oMkjR1iM4xzvrRmfnE1IM69P7hsCxYIdl6G2C0VgYRICeOQKVnO+?=
 =?us-ascii?Q?9UCalwXfTHUygumh7vTc7T4vdRdnMrammaWLby8QHVvXoQlJWiE4SA3ES9yj?=
 =?us-ascii?Q?DO6oy819kAxsL7uz2aEoNFRzoR07QuwhrHpTblJ3NasYyQoaS26Wfx7CW/QV?=
 =?us-ascii?Q?yLCieXYq8mU4u/72h0MsHjvlb4/46BW0QpUyWKhmdrgjaa/QFYeDnObujCI/?=
 =?us-ascii?Q?Tt+cCaK9h7xpQgYLO4g9D/3ZpNoKjK4LXd8CkGTXJfN+AcCzxFI7+Yeq9ilR?=
 =?us-ascii?Q?FhZA1tyOaAAJsqbfZ1NM6t8Kb1QAk20FmpUG7cz2CP9IUHK8234TzkRcnJS2?=
 =?us-ascii?Q?QvsQ44PlsaHbJXAvli4R2BNXa2yVQvKT5eRoxNsSGO2hcDEL4ZOKmBHYomIl?=
 =?us-ascii?Q?qndFNeIfeepe7D/YYqUvoXolfw4BsG9fZFeKvkhEfzkVEYTPKgzpyRHTYeI+?=
 =?us-ascii?Q?zv0bU5XhSTL6QO3JM0UT2GapaBAWFaVqIGCgI4hkfFz382JkX4LoLIIOBRqq?=
 =?us-ascii?Q?y8K60v5z/MhNWyFyylZlX0IltFOLDs4t7qTnrG0B/PFtGJ4lO17mipRMfpj6?=
 =?us-ascii?Q?5seZT6DvtVS5CwLXsQV1hIzkyi5pVuAI7PXDU/+CYWgjqj+eAN3EjiSeDJ3o?=
 =?us-ascii?Q?K+thLjeOBJLgxKFteRDKUrul+DRKnSop/74YHxhW5bg6Z6I7PlU8p4rGuXBk?=
 =?us-ascii?Q?DF1QH/+4r5J26/2hvTUn1kgWv0wwGvaBsbOoT4KZqFKEVDiljn7WBkQpvUEb?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554759ca-4fd1-4ea8-2f01-08dcc83dbb66
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:17:44.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CD/I1T28ij7efNGex71cGChjWI91ZaIjh1dLTPEs9R+pYvb9U7w7aFZgmaa7EojyL2yI3Hdgj8wWfMVMqkhbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2266

From: Miklos Szeredi <mszeredi@redhat.com>

commit 05acefb4872dae89e772729efb194af754c877e8 upstream.

Call inode_permission() on real inode before opening regular file on one of
the underlying layers.

In some cases ovl_permission() already checks access to an underlying file,
but it misses the metacopy case, and possibly other ones as well.

Removing the redundant permission check from ovl_permission() should be
considered later.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/overlayfs/file.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 73c3e2c21edb..24a83ed9829a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -34,10 +34,22 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct file *realfile;
 	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
+	int acc_mode = ACC_MODE(flags);
+	int err;
+
+	if (flags & O_APPEND)
+		acc_mode |= MAY_APPEND;
 
 	old_cred = ovl_override_creds(inode->i_sb);
-	realfile = open_with_fake_path(&file->f_path, flags, realinode,
-				       current_cred());
+	err = inode_permission(realinode, MAY_OPEN | acc_mode);
+	if (err) {
+		realfile = ERR_PTR(err);
+	} else if (!inode_owner_or_capable(realinode)) {
+		realfile = ERR_PTR(-EPERM);
+	} else {
+		realfile = open_with_fake_path(&file->f_path, flags, realinode,
+					       current_cred());
+	}
 	revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
-- 
2.43.0


