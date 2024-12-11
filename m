Return-Path: <stable+bounces-100622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6469ECE7E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3AE1884C93
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6D13B5AE;
	Wed, 11 Dec 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="CySUiKWr"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip8a.ess.barracuda.com (outbound-ip8a.ess.barracuda.com [209.222.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29BF246326
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927090; cv=fail; b=XQUadh1k4ji8XTZxQfJov1wxgwCAV8OSniRLVKg65rmhwVga/01jO7tnMBC8UjJv0sU6j3Zi67LRBdqQ6copQJQ3LZMQMxLqKWinCKqdFwpKC6/3iijQ8mVA9o7v+3ZuqGIn9hfml2sXCMpKrVKK66xTxxKwkurngPU/VzV9rt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927090; c=relaxed/simple;
	bh=yJmuBfIP7XIEeBT9bCbraAbd2zVfG7IRH+BSUMHanAM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=az5NRURjD6uWacEjKRqlIqlgdgasu2BfvlosdrGb+++fuXYK57TkdTzUIV7D6huEphLwDMg8HJy/3EpZRr1FpZ2elRJn4BGXkk3iPu+Qm1CuGcFltCuHZOjQzZrE25mLIENhyRNNxVUt2ra14GtHzKvQP9XnLBKBVdnfyV9vG2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=CySUiKWr; arc=fail smtp.client-ip=209.222.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170]) by mx-outbound-ea15-210.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 14:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8DzSeHxsv6FUENYCj6jenNpEHN5bTaGaTsLLlkHLf0wTHKXrRczxqxUIS3h+lMx0b8BmVRJXk/t5OxQiIrIttvxyMEUXk082gOP0M6XeX8Hc+TPS0zWBLsYSk2wOhkUscuTGmA4taIU8nHAh4PFVEZvD/db5o2ieyX3/G+orKiUEci2JkQyY+mVy2VlC7DyHjaHw1F0s5R8whmOO8WcgWnUayV961P4GHZts2TeW2qyuJ5qzMd271k0mLO7XI+HX6xi3hTmuBR5pLuE5kwb5GykdjEqgpQIo6bs1HyfKOrvaV/hjAvPwyglW21c2IxuL/p4L/X+Gfi/21pJZw+hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbMR5Dxr2kYyVzgT3KyFsVJH7edTo38pJVwm6TVX6g0=;
 b=BOIxRdZvnPSYvArQ+v80o/YyRU5ufpwq9mjZRkHHzMazO1MW+RAyd2egZJaQsTzaFKHoxYVnfBGYA8xg1BWQ1wX9lP1n78HX3ZBoPT+f0aK2RqH62umZEWNPBeYXCVLgCoHFtXpTndOwuXc8J5otpRE7VIv6udXlvGh+6PFnL2CeuNku9DLvJdEhoDD26QyI7Y5t2Jiml1yPD2MuEHePoKEOUCFuKTGnaFk314HL22oEm9IRXTyB/LEPgVRk0Ch4W2jpqFg/4CZgfzIi/C0tIS2LhljXvxZW2lzY30A7IcqBaewOh2evJsXr8e+M+eiqFyQdkbg6VfgGSO5LUU88+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbMR5Dxr2kYyVzgT3KyFsVJH7edTo38pJVwm6TVX6g0=;
 b=CySUiKWre/Tpox7YF6WmyqQ4tJawSslPBxNNfKUkSarjqZ8/Q5dr20P//rI+3Tw2JidDRhQvZvfDOsv7+7nRO8B8z9tdt+1khlNEzK3BWGVIKHDN7mrL9Adtnxh2Xw6Nv9G3N4KERPCx2AeTuPnkgkcjotgoPhM9M0DG7ATl1IoYOlY4XxydiDXOQTvjjFYl257SeG8lYBXuDGO9EkRmjWsv6fmEtz05iPDxw+EyFhgdZjC4U2Kun594s/cGY2RwpVarrqgQTDGvS6axT1NVsFb6RNmu0eUdSqhlP9hl+3WNsS1pskK1X+ZG+PJaObWiGqp5gZvLoJ9AxwZOyZnRpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SJ0PR10MB5857.namprd10.prod.outlook.com (2603:10b6:a03:3ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 14:24:40 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:24:39 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: hodrob84@gmail.com
Cc: Robert Hodaszi <robert.hodaszi@digi.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: tag_ocelot_8021q: fix broken reception
Date: Wed, 11 Dec 2024 15:24:02 +0100
Message-ID: <20241211142402.1406779-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SJ0PR10MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: d0723678-ccfa-450e-0e7e-08dd19ef8bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZ4qGeBfmSa1f6NxVSONQGIO++Bo7fWgzoV3P4fyCvvS/I+/kPKYP2HTG2+w?=
 =?us-ascii?Q?q+fDUlloYhjWwwVx0qjm4993wfON9f+9OOXiBvuZMiM4chgftpUIoUzx2YX8?=
 =?us-ascii?Q?UOyu2wZMOi4MD+5p7jVqxPiqx645ZkV5A1hJ1+NdkZvdUBySKS2FTem9e/YC?=
 =?us-ascii?Q?HVxrb2Q1NXLazlD42T/751DUyQ7nf0D+aIxe6u8xFMOD8QG1N8GMAbxvN/iq?=
 =?us-ascii?Q?KIX5S0+i7caIZ9iHugEAizU58MkLe2qQmVeaSYnFjlgglyvKGpK0bnaL2rn8?=
 =?us-ascii?Q?AK//ZXfQ4JNcwjd1fCVuHSyZpglO/KYzXdcciy8fqUyqLIV5ZX0CMb0QCGak?=
 =?us-ascii?Q?lcbJCJqthqo3VAQOLxmL/9WHoScoFG/XE0tCjZ9sUtU5s1hczectgEGIEv+K?=
 =?us-ascii?Q?rTbmkTVP8SAQdWgiwG7ZiGLTuHLvulrulcjweVj4kkMOSNa8GosURB1rBdmQ?=
 =?us-ascii?Q?r5S3Pj4h5XleGvYo9/ZDMVax5F07hQuDhgIWmvG0dP0coMmnZreCtROGrcuK?=
 =?us-ascii?Q?fMAZCzj0BXUU7D4z4zM0bYULmrvx4RyH++wWbe05rYbqmfIE8Jozi8K/Lj6L?=
 =?us-ascii?Q?T3s1PCDrvH6QDNiR6r9qf2jMRTr6vgF5KBvMrDR8VfvdWFl+FXDTGyhN1Tj3?=
 =?us-ascii?Q?WINZYgNxX+tgNjK+XBjIZr8bwsNinTIDSjiwL4IM/MW2LjyzfyxNJe+dfd4l?=
 =?us-ascii?Q?a68l3pH5rCTsSK1hE3QvHqgm3mLxwm2Zf1BAYPh8DsAA1H01BiRgcDUkeCUW?=
 =?us-ascii?Q?Rq46z+oFXVTv5HPwa6nFrZ1lE2faZSzMxsT+/CyWO4octg0drUAhGAM1boZb?=
 =?us-ascii?Q?bqHZ4RcPplCtOHkImdOV+zalxXOfCHx6lFz+nTpK3HHRMgHVARBKQeq1Bkqd?=
 =?us-ascii?Q?A3X5fNeR+Le4fR4mOT7J48yFq0ewAunPusI30HLkUoeClmDy9QlButWzb3LL?=
 =?us-ascii?Q?05GNnRvGg4w+fNeUZfZ0AusVABRYdGmTemwcEw9qcnQctVsc38R6JZ7DR0GP?=
 =?us-ascii?Q?znyZBVnvFqnr0TmgKKnsk6d0koI8efn5PCB9DL2VQCSjObQDUkDywXrxRnL6?=
 =?us-ascii?Q?2xmS8tn0FqHmvO8ecNzunBS1j8ouUsiMoeDrEWmWVYv1v6+hNx3vSUIKCpAK?=
 =?us-ascii?Q?rXtXhACwp6jGFqVzhVwcj8pO77ljdHVvxwDGYlMwVeeUe4fd47GZ6j2fqcAC?=
 =?us-ascii?Q?rMgaEgZOPSdnc44Uqv9FXDfUVlNmsqXeFumcgTSP1OEHhzjFh8gVPJkRcP4y?=
 =?us-ascii?Q?1PeVlMxL11wqPUrTZsEYq+3e2GqrG00DufOjraWATKdfW2WMFC00Mcd10wek?=
 =?us-ascii?Q?V5UwFB53PhpOp+YkDAKBiL00Lo1faaYrYU0GRjVYajf86ABdIOtSO6DWR6nR?=
 =?us-ascii?Q?nmOqyRnrWtvH0iOfJnXMJg8q4fnYL2x76zNMkFM3vMY3l9bqPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anEjOFnGkDXY3SBfdknj9NQJ3m+nENGS0pmxMQvDNROD9LVZiSCUR+xwZSbd?=
 =?us-ascii?Q?pWXM5VM/cmUVB26dRMCvg4LOVXDtZDp9TfGbex4L7RPOuAtfHm0y3yZms5pA?=
 =?us-ascii?Q?eENAWCJRIKiVc9q8yO+O7Ig62SCGAtbAYUwAiWMnmJIfwRZuvqnS5hX0lRZQ?=
 =?us-ascii?Q?OcQzkz4OGLa0476vCbCQuEh74ONT0sPyfkgExforZynAWEmVPw3Jd4irjCdd?=
 =?us-ascii?Q?y4W+TNdGFQD+PxLK0uRkAXNyP54TEw0naH2hYWuxPkVmjVWbvyLn6e3h3S7n?=
 =?us-ascii?Q?6j1nc/Fz/q7kuiMw+Glfn4rmEIaPH7H0j2paSqRRB/4S9Zta2YdX9qx3deZ3?=
 =?us-ascii?Q?tXtqoTnyXup5imhHdAS2r7CX5tUdD2oxrnTn/2Nb1JNkMP+XekmUIX8iTMet?=
 =?us-ascii?Q?bc3i+D4ZR2SrOSKrQVdWL8jYkULXob13JXtF7LoxVYTkMk2QnjV6ML9BZvq6?=
 =?us-ascii?Q?4VxslVbEV5YKBftpJfW6zdFhVdxYHXJULJOvsTXMvtGUbBRO1lTeekBpQ3d9?=
 =?us-ascii?Q?90K1MKUZXA98UdEDok5mHXQd4aVwq3SKk3+RHuXftlgz5NViy/Dt9WrURiyT?=
 =?us-ascii?Q?oFrddHGizOVvS6+7wvNOkwmqxoMCy282w3yKmvg/1lBVlcRdPX6oY+miY/Cp?=
 =?us-ascii?Q?oR+o9GF4tYp0sb9dSNlOJt1c1Ci7W3XHsP5nriGu7tupmsdMiwEnfA81ObLD?=
 =?us-ascii?Q?256OCrLFJwQFZvUeNMG1Z8rtk22G0t6OvpuwnvIP2+qkezgEG9/W13J7fa0X?=
 =?us-ascii?Q?FL56UHbFYVpmE3rqVQ8dQ3i0+edMEWhAEzFy1o7cTP/w5bSe+h0IEsHpMmdr?=
 =?us-ascii?Q?UklzkHCNV3bEBakVffRT2caaZibsZb12KoFMI4mFPG3IegVF+9FnjCdcpJuP?=
 =?us-ascii?Q?fJIKZjy1h342ROQqsih3ygGJRx9+JOPZ5nNqWHJqgXgjfGVpLP1emqdm7TxC?=
 =?us-ascii?Q?ZfXq2N+HWbPdFtQgiE5bHfTkkCp0OToZk+p9QmlVgVgpHSYv6KHRJHe7zI6A?=
 =?us-ascii?Q?iE6SGFh2GCQa+/p9U2Xxw3NBevyDoz9v06NACZ+f6d6Z4Cby4OnxbEp2/13m?=
 =?us-ascii?Q?/Ka4dh0LTqws2zvxXbSNwoKWlTy3NnFQ9BKZ7bLN+v24TyYYuTXSXHkJAWZZ?=
 =?us-ascii?Q?rYuX85yghWB/O6OUj0TvJ6CuarvBiS7PEGww9AEAUihqDNSFd1gjqXVz5bC1?=
 =?us-ascii?Q?wElpJ75FCurUYAO53H3hxz3N/D40F6iLj6V5lCdrPJuKwVTN1rDBAgbKb+z9?=
 =?us-ascii?Q?nLuQLg8jsCiqd/ZnRCBf9e4N0DDmQ8/VriFEQG0x+G1Ja7Nl5Ft7sTvigpVt?=
 =?us-ascii?Q?+QXpIhshYUrPE/2BSy7URgN1C9Fe1mchD3Rmbr6SaLBupf3f+DaT+jPhBrMp?=
 =?us-ascii?Q?jtyDXzAQ+iN4SrsqJIVIr5+ISmlo2XCp+Tus4K7m40nPeB3NE3vlxcKmbmXH?=
 =?us-ascii?Q?Hb4johEnNIbgXCq//5nmk6NFA+1SovG8lDnL1BbKxyRQ4vTXfqqlzV5ch7I0?=
 =?us-ascii?Q?McKCTt5ndWfGZgf4/ykaBDqh9+lEreQTeM+ZB4Czgx0ps2Of6naZdAJ2eRQQ?=
 =?us-ascii?Q?sY0XZvjzWW1yCjOAqGlsjhiiTKLrIppiNI3cQiO3?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0723678-ccfa-450e-0e7e-08dd19ef8bd3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:24:39.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaHcpbvBdGGL+YIn1feHTtos332MO9nfs8ILrrqurSGmnD4G7PdbNqYwl4jsGPYSP1uyAa9eSbiuLd90FRSk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5857
X-BESS-ID: 1733927086-104050-27602-3928-1
X-BESS-VER: 2019.3_20241205.2251
X-BESS-Apparent-Source-IP: 104.47.56.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGpiZAVgZQ0MLMOMks1cDYPN
	XA0MLEIjnRwtzUNDkxJTEtOS3RxMxIqTYWAPmWzgdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261038 [from 
	cloudscan15-241.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
absorb logic for not overwriting precise info into dsa_8021q_rcv()")
added support to let the DSA switch driver set source_port and
switch_id. tag_8021q's logic overrides the previously set source_port
and switch_id only if they are marked as "invalid" (-1). sja1105 and
vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
initialize those variables. That causes dsa_8021q_rcv() doesn't set
them, and they remain unassigned.

Initialize them as invalid to so dsa_8021q_rcv() can return with the
proper values.

Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: stable@vger.kernel.org
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index 8e8b1bef6af6..11ea8cfd6266 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -79,7 +79,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 				  struct net_device *netdev)
 {
-	int src_port, switch_id;
+	int src_port = -1, switch_id = -1;
 
 	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
-- 
2.43.0


