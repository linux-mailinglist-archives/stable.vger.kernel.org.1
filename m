Return-Path: <stable+bounces-17670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002FD846F15
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D48A1F285E9
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223313D4E0;
	Fri,  2 Feb 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="klN0MR59"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370A13E20C;
	Fri,  2 Feb 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873876; cv=fail; b=FtbTz79SCgIr7ZpgC6tz5c/m8hcnGNjozvy9mAaoPLMUuRnkpj2FBCz+pRsc61G/uOvbZqzOLOsgqAwaJeXZcVgMdvbFBc7779doaZz3aQxSmRYG6Esypm7zsWpgeO0VzBlq5+cT11JEYvwqoUtcGWx7LJuTIgSB1AuvIcHXawg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873876; c=relaxed/simple;
	bh=Z8NZsRoUCgtNPmcp3sVNjQgsDDfXTCXEs38kvtlRWmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sF3Q5sOhfEp9AUtqXSX0c5G4WssxU3nYfz+O8A9sxtPBa5ntZ2FrL+1tPNq7cpP5vGYmhshiofDGSXGK8xKuN7nvl+AanucOKx52gjdNThdvDYxgPJLp44Cxpc+c2L1WPjAou9RGdBfE9A3/Aotgextxu25gvltWbYgolX1OApY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=klN0MR59; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF0hx/bJNbV6pn9T5jUkIsoB5CpG5s+1Awt1ayftEjI9K3SwnRAsXDTiHjO+LZhQq0Gq1xhCdG6JCHms7g4QZHhVz4ei0vElnL0GF1cY/97rlxu3Fo6/3lVNCUfWTuV+GYoN6s8NR9D3mlz7GuOzpEuDLYwD5N20hDmGLXb+nM2mtgpwQNsoDjVXEQcyzrTRn/dW1wQNj3Iyx/A30cuFryEVX/tZ2lztBUw2fPoLHK/wEQ9GKPrjchMFHS+Vg0pChShWez/EPN1hgbqo2kG6if4RuXSiMQ9PtXQJNAYOg7eOEaj47bSVn01yLAD4FwPzo4Bp0z4dTIWSKJMloK3GEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ1QQTkGl4jr+HAoQdgVTbJO/HVLpnMoHJ07RoKN9as=;
 b=RPamo38UrbqXG1ego5/wHiNzqyOjyiM66jizgRHlwfloYABs/KfJ4oY117QfRIZJgV3Zm3UUa2c1Qrk1fcD5t1Fc0d8LQrVlyMvzUkcvyggVZYOrZEABR+C0cK8u62tur7bF3FMpiC7/oWrUhSjut+WbtBfO6AFQ36av3L90KQmP8L2lhLn6cPiBYPNOd78DTe5a+i9FUbf1Z7F2VaWmRpaZcwPO80Ooo9dHaNEVN0YbGGgcxHJqilX0v9OPySn240I1QVelMB2jxys3lFw2pBuvut9OM4jJEVfObixgUW1ArYndBHy8McIT1CwuDkJ6ZDV1oSppOQV13soWhkSDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ1QQTkGl4jr+HAoQdgVTbJO/HVLpnMoHJ07RoKN9as=;
 b=klN0MR59aSmeXg4AWj5p7vW2P98xMu7yP5GYkCrtkzUH8fQoAcrB+GAnJp4fcW4r1ScqE/1ABLr0GdmJTjx7H8cmUzO1jaq3SYdufdDTOhsm0WTUp6rxs+v/MAofOJllN1Of63+kgdkh7zN4ivzVX/ROXvdyEuHTFJfUsMZGfK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by MN2PR13MB3853.namprd13.prod.outlook.com (2603:10b6:208:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 11:37:53 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:37:53 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net 3/3] nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag
Date: Fri,  2 Feb 2024 13:37:19 +0200
Message-Id: <20240202113719.16171-4-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202113719.16171-1-louis.peens@corigine.com>
References: <20240202113719.16171-1-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f247b5a-b541-4b1b-4a3b-08dc23e3646c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vppZHRLRv2ZwBmLtgmDsEWJX3wT83ZL//09Qxr3wrLxaosFU3UnjiGbE+D4JVZdv9grvM+AIgeZpXu3loA/6jwt2kmaGijRozHz1VlP2bVjZ7fvtAZFexYJZIwZF3bsmug2RO2wIW2ziMfbRmPEWtXFGxtntqwIpJ2XTabUExmf2U3wLg0W+nEff9Z5kW5DWvRTnOJ68p6hiboLuXyPZtsMMnE/UbKFz/WK3gFEHbD25B1w1a3Ql08kC3SzmfWUWE+xonUcY6zGpIlfJS/E7OYUZwaKAeJqIJwKeH53DZHrpyuLonJQv67KCGF5OoqHm8JTcpfqQ5i2MYbFvaWQvORwIME5tQtXdwDsKtHaPs/N/vxoC4T7G/OeFAouWsUfCPZTjyAUifkQ0k2sBRhIQx+Mfa7+RCTINDYe4JS9U5hz+LvigYPucT1ubfL67rNCldGDa0/WZ8EvjDaSVOYqbkKvizeU3ca5qO/ALDcAa3v4hFsZVxIczwj1q9RyX1Nml6VFEz2qds4W+lhAZtOj2THQbr0D4dHtcouLhDFXCqt98Vin2eh7JAYLctHr/jTW8rSuhOYM0RtR4riyHnUTaRvsoqsMPW4H3B2GTG6ChXzmi3srS7kxD3zL1+VAwG4dY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(110136005)(8676002)(83380400001)(66556008)(6506007)(6666004)(8936002)(316002)(54906003)(6486002)(66476007)(26005)(2616005)(6512007)(107886003)(1076003)(52116002)(41300700001)(2906002)(5660300002)(44832011)(4326008)(38350700005)(36756003)(66946007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lGwMxFgNH96CtvxgmsApLroQ37m7zLgoDbza0Ny956f+dLZ9CSsI9z1jtgtg?=
 =?us-ascii?Q?AfQakczpIYdHKpAteZAybAxMM8y1SgIZJ4nEwL0i5XbvjSkJMSvgCyQfm137?=
 =?us-ascii?Q?JsSWB+MB44hsJueFGPQovlQXPmoINzb6rOpwDUYPz9np9czG6HNEpmA15suq?=
 =?us-ascii?Q?r4/KA8h2iWn6dRthNdRaaxLNHJl3mTR5xQ5fsXJ/w3ajIM/gX91MSx53X41L?=
 =?us-ascii?Q?649it1I/SPpZcf5Y1YQEM8/nTvfQeFjxxLICrh96jU88aKaj53r9+u6bLNhF?=
 =?us-ascii?Q?y1l4V/1hxa+VCTAAsJyJBc0Im4FVThOD2EzHPuczNroQVaxduhxinpNSf/bS?=
 =?us-ascii?Q?MWLvr9H23Ssx2RJ8VCDJCIxrX5Bbbq34id/L3dbQNifuthi4uzGJpiOzXt8e?=
 =?us-ascii?Q?gRyJoR8jGzAhZ4Hv5r/lifI2LZE/8BmQ30hLks6DPAJZgozPLtXuzIN7SJcM?=
 =?us-ascii?Q?1TNVf9BhuYnMXIAhdGW6SjgOHl46IeTD8BtUvBYQ94C4OSy25FAOGq0LejqX?=
 =?us-ascii?Q?r52k9Pj/ouMsBDeEASxZYWFhB3WnYnYGkkZLZ7R5fOr3DuFJlqi7kHJVHa2o?=
 =?us-ascii?Q?5cqDSS7dwq83ptZjzWKIuLysM2EIqlrV/zGSoP7fL7aA8bbUjyj/u0+kTKdS?=
 =?us-ascii?Q?wrFXnHDvMjZMGDCjtcORf9WqLfwXpI0/KXyjPJkii8wkjy8TYX2XjwTvvb89?=
 =?us-ascii?Q?uaArlxiQ6VNG+P49PzgW1pVP6pKBLCIJySDtAa5aazVXx7jpo91g5nC1H9If?=
 =?us-ascii?Q?p7rsnHlcRvQzBU+mbR322fTPVcDZfeF4SjIaFoC4KittuIe9dDQv9hyAE2p4?=
 =?us-ascii?Q?dMr/4K2vCK2lGv/NTCB65rKeyp1CwJRb44ucUpyo6zIXJFIh/XEWz24n/Dsq?=
 =?us-ascii?Q?MVCJPM4q0+gBpw6nHgkEkxPzuc849jk57m4HTokw2AgKNxCGXRte73eEdTyB?=
 =?us-ascii?Q?zFJyJsbaCIUcK0P2ctq1cf0F/RvhLd5oMaTZRP5L2ZCwRAnKnmjjEsdpyTFo?=
 =?us-ascii?Q?503c5GvSFf4JdqH4dVGwpq8c6BBn6kaRazdjslgBYrWEzZpBzCamUc7J/Mu6?=
 =?us-ascii?Q?Sby7mlU2oSF5o2ZMSsv02zgYkK9N/kKqIjMnef01siBjJR/TjT1kmCaJNxNc?=
 =?us-ascii?Q?nvWWoittY5DFhRjj7tBaJVnfPUAoS6LBFN5IhhKxvPvlNcIIaibH/woWvlYj?=
 =?us-ascii?Q?Hdlo5xPz/OIy+/rU5Ony+7YKeuiAdoELFedKHgz5uKkP7/FKRENHJNGgEa0T?=
 =?us-ascii?Q?Hw1nW8xSQKUtkQJPbV+EH+C1U9OIuueskICzFfcZv8Fnx0E/5XoAaAobp5yp?=
 =?us-ascii?Q?vFix6APIcp1pAiJbFLfYWGcfRupuNxZT3L28lo8Z9iq9zkZX0BX94flB9uuj?=
 =?us-ascii?Q?od2Te1I/i03Ma6mAGe6b7GacX4yS+9fKcUbJyOujx+nL57XrD+xFr38+o4HB?=
 =?us-ascii?Q?iDBBI1KwLm3gl7BeBwAW1iFQnnPUXl2UaNrBnLVkRPH10tG/1DZgQwWZPmAd?=
 =?us-ascii?Q?s7px5mkyo0h5a3k3HctQaBWYiv8tA/CaQg6iGs/IK8YMX7/59/XmSgmgg+6P?=
 =?us-ascii?Q?OT2DPB0//IN8tdzU9QVZa/VtONzTa/cBOmzsHvTdiBdIeb6rDyC85HU9DdRS?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f247b5a-b541-4b1b-4a3b-08dc23e3646c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:37:53.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWhiF3f5V9TFANRTFN0GkNk1MZPuMzqk5oI6SeDudWu7uVhXv52Go93PeLAyu+l29H2EK0c/xWyM9lInzoi0Aw8N/enwPBzHu3GynZcCEbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3853

From: James Hershaw <james.hershaw@corigine.com>

Enable previously excluded xdp feature flag for NFD3 devices. This
feature flag is required in order to bind nfp interfaces to an xdp
socket and the nfp driver does in fact support the feature.

Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
Cc: stable@vger.kernel.org # 6.3+
Signed-off-by: James Hershaw <james.hershaw@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 3b3210d823e8..f28e769e6fda 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2776,6 +2776,7 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 	case NFP_NFD_VER_NFD3:
 		netdev->netdev_ops = &nfp_nfd3_netdev_ops;
 		netdev->xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
+		netdev->xdp_features |= NETDEV_XDP_ACT_REDIRECT;
 		break;
 	case NFP_NFD_VER_NFDK:
 		netdev->netdev_ops = &nfp_nfdk_netdev_ops;
-- 
2.34.1


