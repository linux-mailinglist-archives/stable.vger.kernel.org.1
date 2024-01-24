Return-Path: <stable+bounces-15719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC183AD1F
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617FAB26136
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1635F7A707;
	Wed, 24 Jan 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="RNfLMBJw"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2127.outbound.protection.outlook.com [40.107.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609841745;
	Wed, 24 Jan 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109573; cv=fail; b=EDewFAxRAiQUOLEXbKK1WJi0M6AbkpW5dIgOpU3m9uPqhfZ2mm3Y61iC+6xXfWcAbwDxdU4Mp8Pu4fDDNeYPbxWRD4kHdpL70+PLk6wMjGAcp1nClemOiDE2iq0lTuK2uMlik4uHfmvdgWvfQcJ9KOs35J8Utt6SOjdqUgPOzCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109573; c=relaxed/simple;
	bh=aFccSWN4iFkIadDIqIFb8vBEpSUK5gyn3ZClDgXoNz4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h0IFiGGq1uRS4Slh+L7aw+qIFPXILK7w1Csbm4hp+YcdCISpWJPi+x+LUPJ3ol7Rj3c+H+3WIA58+8af9+KHGjMeKqvyfMXy6n9qrGRPS1czDGkdsX4MmcrwHm3UIaYIjxwx1313dg12syMYDSgOkI2R0rRMxFvYpLl8afV17lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=RNfLMBJw; arc=fail smtp.client-ip=40.107.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY1EWidPDTKbNEV8JYBwAKcHYxsDbdLe166i4dRaltfXY0fyU3YLSd2waTj6xCGWw2ynlrGiyhRKe2Hq5L4xq/Mt1lEdo47HFeJKJ0OwpK7uPd8Z8Fy0kDvh8gltjaMmLVmbXgca3hpQc4E0L8LKi6rF4CH/gUons8z3K6EXm0dk0UoztAGUnKyX7Gfvrw5JMsdRU7UmMYv2V2q3dxVHikVNwJoeKCGPbvjjV24XwGHHjWRq30clejCxhXtWaaC8EcfDA/5hal2Zb+5JSVSxUD21l2sN0FJKUMuFee/p8u85qG0OWXyoAbMrnB03RoRp+21U/brtXsaVRnJSa1kYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw/6ix/X0FwYCd09KTVlADFvneW00acd23a/y9oqc4o=;
 b=Oj6vLVpMVoKmrn9i+AIShwXw9pngz4345YYfnT+v97wU0uYblRh1OW2CvzLW2nf0IkmZ5Cfxhg8JJVyLnker5HLPZWy+MKch1PL0V/1t7HruTu+nIDMSsa4ejSfRRDKTQmB0OU5BuMRJdyCWELUonQV6epdVVSlab/rf7/ch1xh2OKxrQrr9Rvae4M76Ls/EB/oetuA/57dNxK/9ufPPDjUa19jd+vglEwpL5WYn5ENJjZjqMSpFCGNIta92x4XzJyI7nLW7ZqV9tOXEDZSTaVYf4hCYYm7e7LocqX7R5NIPoLs/lnCWk2cXpCfWc9cmjiR6Gs3Vws91WIhy+3MmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw/6ix/X0FwYCd09KTVlADFvneW00acd23a/y9oqc4o=;
 b=RNfLMBJwGdtrZQVYpR5Q31TFBnS3pVFZYKXBMWlQTm6vKZ8MXpk3eLpl44pobmoh+GywFGISLT0pHViXT9hKWInY5zzMoc9KVFwdrD52j8LDwD8RnTvq+vjfQb0J7hqRbnYSJi8aU1yxK63lIOqAjPQjAELWm6QoHrDE4XTKdtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DM6PR13MB4132.namprd13.prod.outlook.com (2603:10b6:5:2ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:19:28 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::8d5e:10cf:1f9e:c3aa]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::8d5e:10cf:1f9e:c3aa%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 15:19:28 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hui Zhou <hui.zhou@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net v2 0/2] nfp: flower: a few small conntrack offload fixes
Date: Wed, 24 Jan 2024 17:19:07 +0200
Message-Id: <20240124151909.31603-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::16)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DM6PR13MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b3b333-5204-414c-f9eb-08dc1cefdb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QoPuhOeqYkxDVbHguYQr02aX23Q1dvL7XBLjYgW4kyfyE/CwOp9ImBCLuKQAhJkFqriBpVrEekuuyiIuAtulxkkpHVhKKexJrz8CvNrOpdQ797khebSvF422ZjrNMV7fjfoRl/NxkqtCkZZv1gtxl01pW15BPPqQRGAYEohw+DE1U0RV3cxi6RpWd5vBJIdlODiB7A7E/mqBs/GTCblpTDwQs8G1ByihuDI8J138itfusyMv0QSrJthJEN95W1hIK5/HKAa34e2yrM8r69/k/z4Gc/BgTk6VWCpvHq0Uq8eZIRV8POgJ4tJ19+JmwFYrPm0/znChllYmbv0peLl0LaqMBaYLb89PVtzd15Jrz78OJ263M/qcHTtW2O3MQnmuYtLRPLKaZvGYnfGttWYdkFqwJy+XVvJ+gaa6Mm9qwbIhM67qCmgcoV66mhaBGR2l3BpG6e/YcncnMdAusc5YggoCTFUIz+UqYStSebuS7lx3JEXPeNfXXCs5J5CLHuiKZjRLtYdAnxhh7i7xnUIDIUvKNiepaFCzGozR0CZMea9s15FCJZts/GNQQ5GlClNu4FqMpeE73GNpItDSURyEvnQiS6EtmK5pedf9VPKFNx5BcfHfVhGhcH/uv7Xtd8NM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66946007)(4326008)(8936002)(8676002)(6486002)(44832011)(5660300002)(4744005)(86362001)(66476007)(316002)(2906002)(110136005)(66556008)(36756003)(6666004)(38100700002)(38350700005)(52116002)(55236004)(83380400001)(6506007)(478600001)(6512007)(26005)(2616005)(1076003)(41300700001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbt9/Lfde9bzmWWKjyX7xFdksbi/odZ8yhqfsIR3eBJBDcgx1HtoLJjXk4ha?=
 =?us-ascii?Q?hlXA/Xn5+zNecKSYUTBwtAjYdy48WKlnxlBIq0j9QkKP6bP48+KPpon20RdB?=
 =?us-ascii?Q?oBAdIYQS6LlfWEBCtWdwRDf27HiktWZqa8m86rWEEC7safLMOyvD/6xXARHt?=
 =?us-ascii?Q?wZx40nOw7do8aPUURjdLh8BSxm3yJp2cgf0t9O+e26N07HaXHD0rde4r4aqk?=
 =?us-ascii?Q?/JFMXztk4OLm5uSNzcwaJo2I+Pn+gpsiEQCFw4jRlf6Pv9L4pC7b5VVbVMyb?=
 =?us-ascii?Q?ENRu1A0VpeGxuAlwAY7AgvYpKG399OWo+2ZqXMFbMzjLXGrcmk7H9Wt2yCp+?=
 =?us-ascii?Q?S/kynvfnFVz9cek+l+KKvx7FAPfA64fP86eNm8UspSj4c65gRPLRd/kPbsFk?=
 =?us-ascii?Q?EfvWyx47vKC68nYQ00sPKnsqtRKbxo08dDuwGlHtbTd/atIA5lzTclksh1h1?=
 =?us-ascii?Q?ZpRQk2Ota5KGR2MDFkgda45q4Rg69Rs75mjAs1Vd/HoURoIhzhcTiupd3t+8?=
 =?us-ascii?Q?UPOwEFHlb1cKEyOcnsjA92mqQh/Iwz18g//HnKiMuQAb9sqzlRhZgZTeGh+T?=
 =?us-ascii?Q?zaeUnjQvSVol5T8l2Xa1+YCB4Sk+bNrN26uHpaJqXaQsfVIzhMrfRqL0xl8o?=
 =?us-ascii?Q?0zgXNsouZg3NMHSCKYdii8lS3+kSUreR7eDDUPmzFt2C46ijRJdKcBymNEPb?=
 =?us-ascii?Q?/XIH0mR6B/++Kt/ZWmg/+D3ZcGQ6lT4BnIL+mT8vGaEwxeaQoLR7Y8PT0Fje?=
 =?us-ascii?Q?64tMLAn56gnM59s1U9y1a0yGitcX/WrVHP+wdPdViJMskA05hise0iM2i8RG?=
 =?us-ascii?Q?x9imCTLyOYRMwhVRnJLk0Ejl2hNVuDfLSxwe06fL7Z0N2zFJgEt7bp/iqHKW?=
 =?us-ascii?Q?VWPymccfhPKzyKS6f4ZfC6YmvzU35XpvczPw87iztHk4kdTH5Jm5/S//NtWn?=
 =?us-ascii?Q?AywKr3XahEeK1zYFK0Zk/o5I4q5sYwwrdmWXw4IDd0uu9PL9YDiZ8xRj0qPs?=
 =?us-ascii?Q?G3GZCVYIBKjps1xprgRmzBw2F3c7sV2btrx8S5j4v1NPfUrc3AHGuK9FtjdV?=
 =?us-ascii?Q?KYuVxB/mHxIayKA2Sur335bpVYZc1UWPluSmPDMhFL1qdEmLdcPg6PJD2u7c?=
 =?us-ascii?Q?KZf5cClF6er2zYHW5JuwJSgZ7GryIxYrX3BPupf215q1OMy7Kt40x8ACxzSA?=
 =?us-ascii?Q?3TRG2Ir/oMx66ieIX/pNPFCUO/wvvOfG/vZY4Ze5dAIVKTb93AgXs4mdkWf2?=
 =?us-ascii?Q?tUtyMJvQkXGUFJEAqE8VRJyPgKEOoFVVfD5kgnxypkU5NA9/pb6vsIYR8QlN?=
 =?us-ascii?Q?lHZv7brnN0eWswaAHWRoPR6PsaikinHfO5L2Bw9ETAnAhmih5Qvl6jPM30qj?=
 =?us-ascii?Q?6QLBSe/WbnWmdFQ/20wJIJWLkga+n0WA2QgZRc0AAZbOQPoDCUkvw80/LCg7?=
 =?us-ascii?Q?6SnVVc30ZnFvKnP4YB+Nb+0cYuV5f5pB66aITMTfnQm96U5UoR4qxJ32R8lD?=
 =?us-ascii?Q?HLaBaGDb9BGXikJ/uuSXon9YfgQvNdybpFgyuPFL4z6PhhXr+LNPX3YTZNLV?=
 =?us-ascii?Q?GM54VexvicSto+MurIVNe+b2PPEOp0CFw5zYHXDOHdQq5GCjLhcZsdctMDfZ?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b3b333-5204-414c-f9eb-08dc1cefdb46
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:19:28.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y61FV/GbYB8o2ifZbVkemEHSnBeNHPmVXgbJv15zPcYgkPfj1cIQlTH0vV8pMgTOHSWjKWvShDJPOiy29SfMNZuSRLpQ5KyOe/Davk89cjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4132

This small series addresses two bugs in the nfp conntrack offloading
code.

The first patch is a check to prevent offloading for a case which is
currently not supported by the nfp.

The second patch fixes up parsing of layer4 mangling code so it can be
correctly offloaded. Since the masks are an inverse mask and we are
shifting it so it can be packed together with the destination we
effectively need to 'clear' the lower bits of the mask by setting it to
0xFFFF.

Changes since v1:
- Added inline comment to the second patch
- Expanded the commit message to better explain the mask setting in the
  second patch.

Hui Zhou (2):
  nfp: flower: add hardware offload check for post ct entry
  nfp: flower: fix hardware offload for the transfer layer port

 .../ethernet/netronome/nfp/flower/conntrack.c | 46 +++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1


