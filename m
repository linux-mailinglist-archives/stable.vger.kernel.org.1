Return-Path: <stable+bounces-17667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C7846F0E
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CAA285B26
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046A1353E6;
	Fri,  2 Feb 2024 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="RH8h24c0"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2136.outbound.protection.outlook.com [40.107.220.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84E651A2;
	Fri,  2 Feb 2024 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873870; cv=fail; b=Udh56eMp+wCXu5fpbeWnOOfNsTaL8O1LUiEquw58Aw0JQZ1eznI27so38y7hiPum1L9BB23j9loT0VNtjXmdloaH7SJmtQl0UgpcsX+zlKsqQyBc038+zjc9Kex9dkUq6KOrir0Ale80Dj3EUst6kR8OWc8YcD5Js0lv6C/3SS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873870; c=relaxed/simple;
	bh=FsYyM4zWULMUFTCajOCLwzD1LuVPQAGerOxDQ8nICSw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R/KFfMp2FGPZEv2bIoZhruW0lVB5o4zcHjumAJWjByp3okj+3gT9wnKPuMg3u5IHnoj7frS+/sJ2c+0wIGA2bRI1Ai6yXOPkU4Bk3N9NXymitd65LOPEodaIVqRfoc3BS8tqZ2xvuDTV9AgQfdOZXwnZ/7SOP3y805mAnnvuh4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=RH8h24c0; arc=fail smtp.client-ip=40.107.220.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUWmSvj6jyqcJnuqToqgrHXQzuYNte8+IP34ZNoxbfAXcccvDyT/pZbNCJ5x4NlTlBB0iuOseEBAhGJNDPq3jngGAwWurAzsJhDV3fY/vIUrKuDlK8LidviPBOTeOY19y/joE/UtbBdROXFjPJwFyD0h9jCGUba6u0t7W6ZeKH3ZDYiWmydQMXhX+zrdmpWbTihhbcOvEO+v0YmycgTxIIJRYtIa6ILaRiWCeGu/jnx0xPkoaLXHdrWuIR2r0R0Cb1jSDOLBTx68khRfG8aaV4PgZbBi6STfBxfNbvw1tr5meNd5ElkzmolwwZL6+FZBcUYCDPNkgNZb1jKIEU8FkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEJwKZbxrFUE16ntCmaBsaCCsr7nO71hcdvij5RDmyU=;
 b=MQ3uoO7fG+MaxemYhqZWwZhK2ZD89cDO0nwtZqhzoVrEwuprSXUs65xoYxetAXlzYpzvyU/hApTqyEg8E8GCsiF+1xgcQPHdMg32H/2agpzRmE4gQGhJHX6lp29StdfdtSF37aeyZTqadezwRJEp3qvboJBSrRu3ZCi71nzwX8FW7+8OmTJutv16SICiuLv9dEXnbt6oJDOP9CRIHOZzZGI2yOU3aBUfZ9Wn9pvv9SFYfB7wPNupJushFVO6QVrid7f8S22kGFg/M8wX/kGxRm0mQfsE+8MVAv2jOL60sUs4s7mZ6d/Cnpo167iAP7Cut1b47CBLwW0HXpCnRXPX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEJwKZbxrFUE16ntCmaBsaCCsr7nO71hcdvij5RDmyU=;
 b=RH8h24c0hezJwn0z5ih+kn0VdvT+HRVdGjCd6XkzWtp9YsGYlWoqGv5dZD0MJkIRpDnRrfG9y3Cuk4+Xj5JpbVAqjW7r252DRIBsqyaedAcRc37ZXu5+IoYVus9ECNFfdOViTvoYQMrp2zgywb1LVObVnA3rDxAfD9KdkBGless=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by MN2PR13MB3853.namprd13.prod.outlook.com (2603:10b6:208:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 11:37:43 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:37:43 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net 0/3] nfp: a few simple driver fixes
Date: Fri,  2 Feb 2024 13:37:16 +0200
Message-Id: <20240202113719.16171-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|MN2PR13MB3853:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e78eae-5bcd-4df7-e914-08dc23e35eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bxkRgE9jN5DXABxoV4CK8/SqSDE2NhAoegIeeBQZRG+QZp5q+pxJfMZzgY3Tsp4LpyW9FedVbxaxdsEtc6lILj7y6Be0IU51sc178tqfETr/EeonFOm69j2a3Cg0P7FGYUbiBh5MJ02zBZT8Kvgde2SpI9B7HjjTWA7DdVlb99uVx5XK1UHSj66xfBoUKCA16N86LTYlBVujSk57gxXsEi/SU3tk09qUKw3tBRZQbjhwAORM1x4TY0zkkNBz6kWxkjPXJDXuLKEbwYz/9XeKATVfmt4wMYLlukh/gNBrX1bqNs5Bq+Q7UL9SW8uksujKnfSPz1yOBZLPYDnwuCIn9CYWhqOCGzSsht2N12iW5UnBTCAl+BK7nlDss+MDOqZaN57mRRTnOf521A7WcGxwtb97XiJaWHd/8jGxyNCl3y7HIqUqSXxnPsQEd3ChWEly+IlIT0C6ojugGxnRomFL8CAG4z5vmwbimMZ54ZOnqVZmFlusZQqoDVGtkDhqu7+FB5Vp0coOjR0ye0/Hy05Zp07aLolODms6HsB8dIpXpq4Ls8gNGWU2RH1Wbs9mZpEYHKQdiu11MEp487BroCWU1DIhW1CsMPm0N5cNhLL0VXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(110136005)(8676002)(83380400001)(66556008)(6506007)(6666004)(8936002)(316002)(54906003)(6486002)(66476007)(26005)(2616005)(6512007)(107886003)(1076003)(52116002)(41300700001)(2906002)(5660300002)(44832011)(4326008)(38350700005)(36756003)(66946007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nFQg3b/KMBt+MwLPUyMNKZxt+BuScZ/ewzpAjp6p4Emc+qqfuV8suai02Ghk?=
 =?us-ascii?Q?BOvfP5g+Z0vK0yCAzW9NM09PNr/V9mjzKMr4vLNwFFxInYabtIOpzDvU3H5y?=
 =?us-ascii?Q?8z5urAWk0L1A5Zg3DxHljBfGBGYy4RYZxPmsUQTnvuz50Y5tI61mwe/K8/h5?=
 =?us-ascii?Q?wSGVOsgPpH9mAvWZKffB2TolPl6qNtu42OIacjrJW8FpJUbKew8HBiTejZZx?=
 =?us-ascii?Q?oJ9VqWZThZzQuSdJSGgREM4SrMcd1j9jn1KNtcaz9SUaTXm4RBtBawS2ytJ3?=
 =?us-ascii?Q?OsJ9VJoXhFtFgr+CZ4Ybf1+/WCKAYqr7gvlsvsqzkzpeobLpDCIuLQiX6Owx?=
 =?us-ascii?Q?3rXpjwFHjPvRn+PwVWkYy/1io8/3yM6H7/g03fxjFPsE5z0UXGGxK7Nhba/x?=
 =?us-ascii?Q?kmNR6npUFEk3izXBnl9cCMeMvOVofvHhdaLlr40L4oGOaoR/yjqVDAkYsI0V?=
 =?us-ascii?Q?6C74FRTNH6atRdH32N8/iPLTDg7QleSG2PL0xDUOKmM0nsKFpqmVYmyB7+6I?=
 =?us-ascii?Q?poutmQKRws+Oidq+sBxyQ4b/KQSclqk8w4dsMLJo4QZutXSxK4SehfWms8c7?=
 =?us-ascii?Q?5sxVyqDOR2t/9OPLsSJXl5SsBQOaRBZAgBubyKTUN/GKOqUR3uKc5HNKRnjm?=
 =?us-ascii?Q?6j5554DIcBVCMrQVEcWTDo6a/8qNGNX0qWmF1D6afOuvjKhZN2zVfESwj4AB?=
 =?us-ascii?Q?03YgMW1A5Sns3QLOaAh0OQoyk2P7a1SkFFSNyTCzOl2l75+YqcZBcGKIONnx?=
 =?us-ascii?Q?Q/0Q18Vw3n8CkYwP746eo8DqqoWJqf9FyyeqoxtA8gpZwFyag5O8Fc9AUZ4b?=
 =?us-ascii?Q?5fdTdayhMB4ilTqC4r5JN/YovO7OIx5lYpV4PkQEdXGgpiE0VN+d1mh219j+?=
 =?us-ascii?Q?OP5TxUsRXw3aGGPC7OAZDhuWC4cIROryxStq5Gi2BWuPZIfYztQhbD0rxzue?=
 =?us-ascii?Q?XpTtDsr9V7GFrI8c/4EQORXLfreOtm7x8tsRRWeC93Pe9HIUM9xHy9ul475V?=
 =?us-ascii?Q?GF/yXYnjW/xCWy+IfyZf6xuHqQUancLi3l3wMcqxraCBqy6elBhWE9TQ+g2D?=
 =?us-ascii?Q?d5MM22bGh8Ed/dxuEM1Ba6/DclZ/A165MRp7+g+3Xgp3y2DoBQ7EzCNyjDUF?=
 =?us-ascii?Q?5+lZGsuERr348XVOCaPVudTpRH5hx12tJ7zMuv9OWyVLE894VWTNyh/ChG4L?=
 =?us-ascii?Q?sMpB0AcCPYBbI9PT3xTmjO9kWuODGdH/jnLxphPcLtpThdQbZ0+/hHTPLl8b?=
 =?us-ascii?Q?JjZ2K175oWn9tXnHXzjffswVC5t5izg3avQCU2bvxJwd2uD6jAL9OpCskJ2V?=
 =?us-ascii?Q?yIsR3aGBRlM+KLsrpM1TjQdagn/45/4eoE9du/hxtuDC/RMIrFPeFtX8KXCR?=
 =?us-ascii?Q?NQOLdv3zMTf0kg0PiZFpbkb1xkHJ1479Tr0E7ptKI+j0XBN2REnGw/aBK+Sh?=
 =?us-ascii?Q?LaJ/XQN/jTgd9DuAj4ksaGn/jL5UVKFOKBIv4VeM1trsf5cXlJeEd3/opiOc?=
 =?us-ascii?Q?fr+240d47Svl/1ZrwaD6UPLBFYWf7E58pQLUVw4V2N4Ifv73A7lDCx9C7I7U?=
 =?us-ascii?Q?cd8RpdMPKtc6npVet1KHmri47anmkvxeZz/O7vNKl38GDKd9oJhPv4xT5l0h?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e78eae-5bcd-4df7-e914-08dc23e35eac
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:37:43.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLKRvkRj73380VvbcnqiBRyUNAV3c8oO1szFA7lMjWIT63e1w1TiAsWK373yMZPyn7QEet4032xR71x86xLYYdc0t3q7fUoVXwrHreITyxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3853

This is combining a few unrelated one-liner fixes which have been
floating around internally into a single series. I'm not sure what is
the least amount of overhead for reviewers, this or a separate
submission per-patch? I guess it probably depends on personal
preference, but please let me know if there is a strong preference to
rather split these in the future.

Summary:

Patch1: Fixes an old issue which was hidden because 0 just so happens to
        be the correct value.
Patch2: Fixes a corner case for flower offloading with bond ports
Patch3: Re-enables the 'NETDEV_XDP_ACT_REDIRECT', which was accidentally
        disabled after a previous refactor.

Daniel Basilio (1):
  nfp: use correct macro for LengthSelect in BAR config

Daniel de Villiers (1):
  nfp: flower: prevent re-adding mac index for bonded port

James Hershaw (1):
  nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag

 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c   | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c       | 1 +
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


