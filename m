Return-Path: <stable+bounces-40325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A38AB67A
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 23:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728CF28290A
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 21:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0068107B2;
	Fri, 19 Apr 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mfj+qBkG"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0213D269;
	Fri, 19 Apr 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562248; cv=fail; b=GsGFTJuJTw0hMLTt+OrjyT37NtxmkYEDsVZRyPlUOvlk5KmPobnmDOKZyxFu+6CWIsbnXmgeMOogQTIHW97n20qLsZOr43YDFv5VNojBjDjYiw0o8KctAgJoyjByly9E6jWOlCGJazgjCA4rkoA7/VjbtcfHkz3bBtnke9SVF1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562248; c=relaxed/simple;
	bh=wlNxrNZT6VtVgr+St5xHk9CM9YwyQIld5BZC051NgzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBTkc219JACyiB594nkdaQWNnZg8o36wQCl0Pp23q7oJdOVmGUjYptwPDwGWBcUzjo6KCkLWS3gyC+DH81ZFcGwjyxYcQlhdoyPnnZGTk6VEIGWrybfpuSEPdUWSuAPHMKk9bNowI3bdWCyxN6w1dnw1assfYInd3SdUlNRfbxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mfj+qBkG; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk8lzgmcGV2ooC5Z1eBYtxbSCTH0o1h0QtdMYiu7RrQ+XcFr7/6ud0fiM9nYbdcW8OmGDXYBXAac61Hwt5fhMGooFAiN1CNue+6JBjqhUa3u9KDKcrfjyeqVWkpWpubh9wQ38hCTO6sRf9dGiwLUss339QQ0RUvDuaY5nZLbOf0FRqN1BImdTnDyIyS9IoGo/DQMdt+krMpRTxx361btpEZ7kjPBSjNSvWh2ycTo+LnmwYPNil7hzEk1T2IWJTmRk/LhQP+BoeJK2UE4OfVoZSrALtys75eEPz2tzAtqL2IG9UxZXTIy/6FjMw8C4+e5thgY4al3OjDkcJDlOOxbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCTQ4Tq6NI7rX1L0FMlB2I4qV4lqKOSFAGQSBwlW6oQ=;
 b=Q4pGlPct0QzpArAE4/Z26x0lkdkIFLRvi+UlkXyUYmls5O4M04qLNaICubKRTCkL3MnGFx0Hn7YvKql7xcShgJmp+XaK9zyLEVbbQRyx+tcI1IpO1WYwIleffu4kpW4CHoQHqxUhnfiDXZrHyTz8m/JfpF18L6zpAMjpQ7lY2tgTibAxNgZ1MI0uZFAYqNvce8iWbLwdAY7+Dse3afqcRP3isODfZbQ1P40QLmCf7B9u4ew7nTbo3v45Q4NbzVzCgR00OcCWsy2wsCUOIkZCA9D4KwrDNqHTbHfQvu53ViJvrkxcA5qBc1cri0qDtJcEuEHkkTQG2bM7n7TJIJHSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCTQ4Tq6NI7rX1L0FMlB2I4qV4lqKOSFAGQSBwlW6oQ=;
 b=Mfj+qBkGggCjezNIlNOVo5k9IIlxA8+zpfChIRfO3XnKgB2GobIticmyEKpbh54ooBVsdcV8jiqVg+k4w3YDDn8gncUp7rN5W5TvD+96JDUHUnIyauGANZSqw3m0oUGYL/JB5VnUfzJgw3mnxsnDE19BH/B6+qFMXUrEybVDEJIIC4RP6Cx633nyA+C3LOSWZMA9u4RpWm9XOJijQk/Xqwbwth2fIGLIYSJtm6PRBcoe2w3wcQDCzFz7Z1E9zHj2rRRvC+SjqoqwCAkQ51evpBypdwYAuhSl6Q8W/s9bT0wFpvIknqMIeC0LphZZvpI0rQjZNocmmbH1DuJDWkynmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 21:30:41 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 21:30:41 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net v2 4/4] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
Date: Fri, 19 Apr 2024 14:30:19 -0700
Message-ID: <20240419213033.400467-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419213033.400467-1-rrameshbabu@nvidia.com>
References: <20240419213033.400467-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::32) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cd5250-fd12-45a1-18dc-08dc60b7f669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k8v4AnUavNDmPoaaqlGGL2eo7b4Sa0+n+f+AfPeoOfPSusrkY2OkxD8nHwt3?=
 =?us-ascii?Q?8UNTGJ71E+uCttuP3d+4eTRVjhs3tjUVY+HR8RW3WtKW43N48RdjQSzq5RN3?=
 =?us-ascii?Q?/I/Oy4YPXr4Om3G/IKGZz3bDVNw17eQK3Pzaic8AbC0xSvMibxFNmby4kbF8?=
 =?us-ascii?Q?x9Fq6MtgE+wF8OnZUU50k0TZYX5v9turptuHKOxGJO2lqX/IQ4nbvtXBtKRi?=
 =?us-ascii?Q?LOAMXV7vQH4cNYv0oon5QsaE8h436pU7b5rLLrJZOfk/rpkeQQ590AqoLM4I?=
 =?us-ascii?Q?xGzXtUW2sONohz9N+H5Raxputcx5r3c/Q3BPBvmkyl4q5GDXi3XsNz6nPlER?=
 =?us-ascii?Q?XihILUwE5sDmv2N9/F2wlJPtbiobE5caz9U2FQJ0m3SoUnvMZ1Tv2VQm6F0t?=
 =?us-ascii?Q?a1npbo0Ly9Fl4fM3Zz1647AyuhlavFCjsDrQMfCnrLwu1CCHem/JcDF/15Ry?=
 =?us-ascii?Q?eMdFwAfiUsDHluJlO92OetiW2RJ/MENEeuBVZFuzfZZXpp7eKwfAjD3vPs0t?=
 =?us-ascii?Q?mmFiJo/QlYhwPPbSaf6j/jk9nGUq2GbtAvdmHqXAmuIbnYUHlnhvc1Cihc0J?=
 =?us-ascii?Q?kOcn61wOOwBwXxwzhERSFQMun2mXbCzWfSIZ9t1jD3pRG6qVVsIf+kJGErrO?=
 =?us-ascii?Q?eISBUy9p26ntiggw5PkyzQJZxpzQeYgNIV475cB19RhgBK/6btciedNzC+wz?=
 =?us-ascii?Q?85dymtZtRDsKu5cUtG6wJtldSnXwm8w0/v9OlZ354opnbCFtjTn0qCZc5t+5?=
 =?us-ascii?Q?FKbuF32OkHW95B+Oeo4FH2i/xywSa+S1udOyJKVGBDI9AmJDQCBT/JBpHEXr?=
 =?us-ascii?Q?dj0f5LmWYj/HMsOR3yJ6uW3LGIX34CQCqHB3XKD2jlJTuvdSvo4mBlPDGvS4?=
 =?us-ascii?Q?FDTakJ404ujLYGN2V02m06P44uObCxaafy+6U+ouFdFmhCAzDM+NgscK2YY7?=
 =?us-ascii?Q?oG3RStZyalAg1vI/HUlGGafsuwY8UmIwWVtTYGM2fWc4/V2sZ9KzOnLXXih6?=
 =?us-ascii?Q?qDInuLQz+F9lsoCQT5y558tkkmIbDOSxFfe8qtnHstVForpMB3rV383nmXY/?=
 =?us-ascii?Q?YWRogsu3KN/lGJ/N6t5gicZX+sLTcIyUnN7NZ9HOvd4+sCgva78oqW+4RfhB?=
 =?us-ascii?Q?wpgbz48exfpgKzrcLbr/+NmYXMAKCD/q6x10w4SJB4J+JN6rXisCLciVpFhP?=
 =?us-ascii?Q?YmKFy6UFcUNhojeBIq25VDGUDe7+ylwaWbMPK3txjLtFd8Qa1sYlVzIBFEwu?=
 =?us-ascii?Q?+sESqO06Uq+8t9/Xgg8nVCK+PHXQVBJACy5yhBC6SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1JZZn5qYUdjRjKLzk6wQlseZ/lK8f9btE3P4xdcRtYbnrkNoTYrNgunhDXI?=
 =?us-ascii?Q?uV/bjKqU0GcdWKUBR2uRgv/RuFJqiemMCG8866s3FJEGIV13jnXOHjHH3kCi?=
 =?us-ascii?Q?JBzutpWP2LpF0hgb2wvFzADyB9X1scdMw/1ZIzrPKNh2H31zQ06Sh86LPjm0?=
 =?us-ascii?Q?KJtdE25awQPgshHcp+BhG8GMpTqEm6WQQHHWrgcKsEyDA+k5gbIoFJK/Pu5e?=
 =?us-ascii?Q?IYM8xCDbpy9tD9oR468nCUXfjv4/m9mgI+FvgrgLuHOJlgm+/utPJmTXsmbA?=
 =?us-ascii?Q?rEj2TLhzSmmPvtecls0UHN4KVH6qMFjRvf0gMCrYk4zAVjZqc0PrnHfRz6on?=
 =?us-ascii?Q?LCn/T5EP/iDrHskkGp9TqevbyoZS0GfWCiiMXiyLCtcqitBXFUs+qS7SoBrg?=
 =?us-ascii?Q?wJdoXMYd2wcEfjHa5kERe7mMRidM+jpRi0FIuV++Wa+rPgyDbAj9zJgdYk9D?=
 =?us-ascii?Q?rg+vgp4k5+r8oR2Oo4ZI7IJHODm5vejROUABhH5tIUwXcQOpU+sgVzyZ2Z5O?=
 =?us-ascii?Q?mU4gWC6rgFIriB7nDS0F00o0/uayaMXhiMESHw2DTAWTXkFk0+qx4wGfWHN8?=
 =?us-ascii?Q?ZvdbXw+zViteHt3LOPW5n8f7cuj3WiWsoTPTLy07DmwPJ50v71fb8TgsB2X9?=
 =?us-ascii?Q?JID/uE7ymRrpBhI7jVYX29MNqxgGtL8x7zBtFduK5UX0Jyl80E/LHl0S2kSa?=
 =?us-ascii?Q?PhGQNUyoh0RTP15w17kaDwbqGw9/xh99rLSbMME35s4MtSFKxB76PZzp9P4C?=
 =?us-ascii?Q?DBpdJ4stEjzD9l2bjt3ET503tGC19aQWRgOsOY+0Yd5WvC7zr9yT8j0GmJj7?=
 =?us-ascii?Q?HJfUh1Gxg/WsO29tPHAyjmvXyyxe446eyvSMpoVphreM/LE+KFHgujyz3X/D?=
 =?us-ascii?Q?vnGAiwT+trKFrDg5nkAUmIA6b/4sThgnUOu6H1H64RjI9HYNY3ZfvKoODsAj?=
 =?us-ascii?Q?l2DjbB6ldsQZkOxRrmHAFcysbEhzKN1HjdDJhSK5Pn7UzTxC/mwDFLoMSIIZ?=
 =?us-ascii?Q?F+LshIXUSkIenYv5KIdkuQ1E19jLQL7lkt8jylfmgtzx82hUCP8PIbYV29ge?=
 =?us-ascii?Q?sAbWrDVSiKhPGMTomNqdbhBcX6Lsboi0HebZyuL5XuOFYNiZQFKxtSfhxWij?=
 =?us-ascii?Q?tyUoZeY7qdQDMSr/PblfCmx++gH5H9encSdx4JeyGheToovNMVAX/wCHaljJ?=
 =?us-ascii?Q?u9OqVh4VSWnt0yujEYsIU0QAyzb1DENYeonhNaK9Q5z24KF7RGTW4XIlhtJz?=
 =?us-ascii?Q?izg8LtmDKEMO/JMDKztXF0xczxq7+secaEkhcwnPBpdtQmaLq9laDBRqO0xj?=
 =?us-ascii?Q?c4iYSRWJVpDuPk6oxFHlFTQ3koAals1jyfIL2l79BxUujKj2p5Ni4jpHS7XX?=
 =?us-ascii?Q?76VNaqfdJjztP7bC9vvx64qaI1DTQ1tjxE8KejfwdjC8Tn1X4RzyonESBMtf?=
 =?us-ascii?Q?3zGRjzF6UNccMx+dK8CgwRB89eeRMQMuwdzBARz0MvePaK5Lp1ug1fDljLUC?=
 =?us-ascii?Q?xYlBvxx1XmAEgVoLtqVl18v7twLlso4gFweDNSPvDefOP+8V3F/+kdOH6HGZ?=
 =?us-ascii?Q?+W3MsZau4QYOr08XfCaABf24D9M/sRH2FLwZTF59J5V3E5DVsPMqt3c0GnVm?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cd5250-fd12-45a1-18dc-08dc60b7f669
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 21:30:41.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH5j3qZ75TlI33+GFrTA7eaZFt+vtowgPhRpr/g0bXFUtnvtR3zwpKA3D2J81+wsbqcLaYXVSlvlMoa3uva3WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

mlx5 Rx flow steering and CQE handling enable the driver to be able to
update an skb's md_dst attribute as MACsec when MACsec traffic arrives when
a device is configured for offloading. Advertise this to the core stack to
take advantage of this capability.

Cc: stable@vger.kernel.org
Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index b2cabd6ab86c..cc9bcc420032 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1640,6 +1640,7 @@ static const struct macsec_ops macsec_offload_ops = {
 	.mdo_add_secy = mlx5e_macsec_add_secy,
 	.mdo_upd_secy = mlx5e_macsec_upd_secy,
 	.mdo_del_secy = mlx5e_macsec_del_secy,
+	.rx_uses_md_dst = true,
 };
 
 bool mlx5e_macsec_handle_tx_skb(struct mlx5e_macsec *macsec, struct sk_buff *skb)
-- 
2.42.0


