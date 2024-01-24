Return-Path: <stable+bounces-15721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496C583AD0F
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 16:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA09284143
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA87C088;
	Wed, 24 Jan 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="MqBn7XgU"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2127.outbound.protection.outlook.com [40.107.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857B7A72F;
	Wed, 24 Jan 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109577; cv=fail; b=f5AyteDpqV17Yv14iKTcNIJfjaRcjiiq9wgF81m88Nir+/hZ/ZQ6KZvFVK7nri/PeVxC5aGTsBXvV96KGALlxsMmVDVCFVDtLLkHFoJHRASsz01k+hUGMMZudMRPCTUtglW6tV9hpq7mtUX9YF2+CTLgtUNfA9etaGk00S0DqAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109577; c=relaxed/simple;
	bh=Io1rQLMKPM0qz0lJ9tyIFKnOBSH1B/UdOAroifxCwE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCWtcmYvPw2K01Jjpt3DmGyoqHYcjSrrcew7yb8KUI8kPHRoQqbki4/wcby2M9xZ1QzfbvPUQDy1fEujc7itzY2xa5gmVPQXl7XlB8vv9OEb+as5t+girPDbQgJ9fOb6joZNEDDbt/2HWzzTbT6ZE79MjFbO6SSAf+cEsJXV4Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=MqBn7XgU; arc=fail smtp.client-ip=40.107.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7A/leO8QY3X7G2I+Xz7e0JYMIthUTNbccWO+roJ5V8E4H7GW1beY2CfPiBhG5WFYeTB5IenkCtZ6hei4HzGzsAIhF2c1WEbhriijFANnsX8SCUVYnuzrhHlHoVjQbCuEX3K/shhH3FF6BsN7XusVxa0LTSHk6639sexz1ohJSL/40jNGsQEOLNu5pYF84Bgn6ynomnOG/aZ9oivo/M+7SJVi1a2nj7Zjs9XcoEud1Csd5WdiUh4plO2Aiu+wXZ1Eqhw/HDUSVYSIyrQVbNqpC5uv9ivL5ynDVq5ukbycYiYGlnFKVxrY3IqEqv6P5L3GKNPzfEziQvvOEmrC6Kzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iT2c+p51U9vMAFkNBlBHqu6TJ8OkRp3TONAioJMr54=;
 b=g3uP2Km8F02C8auUTriDccQK3XbMY9O1hW6smVq9XtidO538wD46Shh/SKNsJdx6qlu6A/Yf7fqQpPbf356H0q6OysLUW0rarrem8NNYI6hhjPhi/6J2WHMuASrvn9nIE43e54ucLfejQeT6fLojUwGLdkpsi64vJV4NtuM1H4LW1t3YhOd2zMxrzP8Nly/hLHEmseLnIDh2zssTD5s/BVIy3rZxs5zouFLUTR2T/tuNNBPLspo+RV6liPBjSwP2+b1dOUa4FxeaE5crpz61+1UjijxjvHgRW7yP5pYqgT/sNtRR7LjKmibfPpbR4C5LD8xAaRsEPcaJFw0x0Gad6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iT2c+p51U9vMAFkNBlBHqu6TJ8OkRp3TONAioJMr54=;
 b=MqBn7XgUOmlzCtjoeRUTl1g1Vrv47pEkArhrLtfliLFEgSU+BO3mzISaf++4oalVEQhHBAfdYUlZcGEvyct1aTWihoZo+8Mz10otZLURE6HS5WUb38ur1gPzVswUer8TqibHkpHQDWGAmmQVVSZSuTBsF7YlDwRsByCe8fod1jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DM6PR13MB4132.namprd13.prod.outlook.com (2603:10b6:5:2ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:19:34 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::8d5e:10cf:1f9e:c3aa]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::8d5e:10cf:1f9e:c3aa%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 15:19:34 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hui Zhou <hui.zhou@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net v2 2/2] nfp: flower: fix hardware offload for the transfer layer port
Date: Wed, 24 Jan 2024 17:19:09 +0200
Message-Id: <20240124151909.31603-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124151909.31603-1-louis.peens@corigine.com>
References: <20240124151909.31603-1-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce29f297-79d5-4ff3-dca6-08dc1cefdf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xATZ/Ep66TR1zeLZNypJ/JEnFWeaVJzfhDD4Xwi71rW0PAJTqp1nXL94p4DJIg4PHncjSAWOcoEq8UpgU1iDw/w/qnNduuzq1ErI/OeShrvSshxxmX/JpXRIBo6z+iFgX3ef96jqwmUH+NYGq5ym6r+w4YASBs9fgWElSBv5f2AOMa5G/KmUjFWgTRlsV3nic85jHLv5cU84BI+vOvOw+MfR1AWhg8/keDDK/j7XJH+45gY5Xwr/NFExo1kmSwZiuhoCkmu1womcP/aMFUQhL2TXAra150NoFL/9dIPh3PYA2eTal1to0sW3hIk88RAUNFJ8G0KB4jNg3SZPVT8zQ467KFruu8cA41UMJMG2y3MbOPjNvegyNzxt7lLW4EVo7OcXmH6QusfE6MoXsqRfltGrQzJqBSROdc6J4T7P2pr0gu1EMAd/0Ar/waRJQyD/zdfxFnomGGhitD2Hfx4e82gisSp+AL1PLLdCu+J6LdJTqrEdsIZppBCzCR7t0KtDb2EQ6FvG7lBXQauJZ4c60OzT7fPxhcgj5bkNUf6IGox9AYfEIAUqwROgBAsSC+SXMdhV7YuoZpAMn3Z4PR+8cqqaNC7GRmmGogZLyK7nXDC9GWZ8yDvXbwsq3c+juKQh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39840400004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66946007)(4326008)(8936002)(8676002)(6486002)(44832011)(5660300002)(86362001)(66476007)(316002)(2906002)(110136005)(66556008)(36756003)(6666004)(38100700002)(38350700005)(52116002)(55236004)(83380400001)(6506007)(478600001)(6512007)(26005)(2616005)(1076003)(41300700001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwCF+kDCX7J8I06rElXBp4MsGohA787T1Mh2SlXGVC6PvPmiC3QYjxUsin0h?=
 =?us-ascii?Q?9G+9Qj8p9GbyUra/SihjspqUTTwE7ozXnE0WriairmHmczipBnUflDPRnCeV?=
 =?us-ascii?Q?hRSXxFwklh7+UgIMTKAuuv+xcmgEMsegDwpQUd8wGVcjMOC+39N8f7L1bLIw?=
 =?us-ascii?Q?aHVameglBTPeaqMn7ahMYOffLo5Gw0gHZLnjMnqLR32o8Or24RjiMS83Xi2F?=
 =?us-ascii?Q?RncdAZ4+H1oEtrrE9OpYyBNaxDl+u2aHOEG7rmC0pXnqdbLPKwq0ClVxbSFT?=
 =?us-ascii?Q?J7bTE73UYtjeRUrbJgGxBkx8dvxO+4Q58IKORd8eOW5U6GwTZaSYToKcQtFe?=
 =?us-ascii?Q?IZvvargln7PzP1j41HgyZLJjoWEoKurkLL9Xqoyov+OrHewAWhXSllXT9/Gy?=
 =?us-ascii?Q?HH9szmubJQyT8BzjTRXW4FELYKq8f2EHzyGfEeDz1WMAiynx8JbFf6dYj254?=
 =?us-ascii?Q?IyvJa0HFoYhIcSKrrEcPDwzNzhn3oLhnr1mF3CLaM1XVZ4rqk0tYL+oR4Gy6?=
 =?us-ascii?Q?1qZ0Tem71gnxaV2iepFZxcPq1hhiwUu+39t2SIHXbV25Pf9wOyA1ulZksvOw?=
 =?us-ascii?Q?XWetHp53bWTYtCbyXlISNjp5GN1rbqT7ETXAiiE2iAyGTgMsmYW4guAOKqxT?=
 =?us-ascii?Q?A1pqjbIDLyDip5eeuY2d4Taa9kUOnp/TJOyyc757B6K1/NZemfzCGEn1vdSU?=
 =?us-ascii?Q?f+L/sO/xr5a1bdlM0GJ8jeSoqmxgqapZLHqcoeCezbIdSQqI6cr+fnFChwHE?=
 =?us-ascii?Q?r+GYX8DSVSfhGwF3Ruj+OCXPcclIntCh1PMplw7Cnikt3naM3iQWTAWt72nD?=
 =?us-ascii?Q?rZtGIUU1qSXmrMbdAgsWar+y7U8tm5dDzgAhhOkCKKCQMT8eMwF53Pv4w1dn?=
 =?us-ascii?Q?xOVvShUWBZOZ4AC2W+fIpJNWHO9dIgXU6dxcpSN3hTccqF0cnukgMrcCohRz?=
 =?us-ascii?Q?zleInRDdUAbepLK3Fk3Dn8znNTAJKYnfYQknCqnWzXoJv3VDwvrO+Vi8bviT?=
 =?us-ascii?Q?AvZLj8cn7RPUOFd/hRQM2bYNlqEqENrN6M/8LHHMrxIqgGhfKhW/NQtDb+lS?=
 =?us-ascii?Q?IjX2AYQzbj0JL9r3+PfeA6xduBpNfJ3S2YSpp2UYZbeIyPB5gHrhIS4Buiym?=
 =?us-ascii?Q?VYIxUgJonFX20Rr1Jf4NUp5wAaYf1W5ChT2gpMPxQJt+a4xfeqayon8BQbsX?=
 =?us-ascii?Q?hEa0ANAnbd/K/JJaE48H/1jCJ0ELRxvq9RzpwtkCOHdbgHKhI4H39U8FT9xM?=
 =?us-ascii?Q?OozBtl65UFT0ghTJc1tAZl4azHNAeY24IWgRM2wynkwhoiQg9Rm78gYKIbYw?=
 =?us-ascii?Q?wBEnhGjcXue76YWxASgibl9NSc7I46y1FyuxzeK6/U8+Qk4k75i3ZoCMPPuZ?=
 =?us-ascii?Q?o3E+EuBysNVtOJ3iAqUYvrypimrXSuWjqfJn6R6DS7eWKJLubER0JzxrxB72?=
 =?us-ascii?Q?CPeC1ih1uRU2NAhLLhIC/r1pPbjIGyXy0DwpzjhPhFfpMp7PxcJKqtLqhNg/?=
 =?us-ascii?Q?j6chHo2Leq7xOZ0kgmFMlPEidld0cWyc+AnzeuKmhwGD0rHdWZawph0cmeFP?=
 =?us-ascii?Q?A+ZcleSCobyO9t62XQd6nlxD+5Fdc8ztCplqmrPB2MbFssvHasuTE4xRuWEy?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce29f297-79d5-4ff3-dca6-08dc1cefdf1e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:19:34.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Xe6EFkSQQtZlY2yt1gSdN15oyVnCrXqBnomzUFoibCD+3HlgK9400ZAQ5Ni+/cglnRlXEFZsnJuFGeF6gUc6+3Oqc81I+WjC/X3r4RQgNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4132

From: Hui Zhou <hui.zhou@corigine.com>

The nfp driver will merge the tp source port and tp destination port
into one dword which the offset must be zero to do hardware offload.
However, the mangle action for the tp source port and tp destination
port is separated for tc ct action. Modify the mangle action for the
FLOW_ACT_MANGLE_HDR_TYPE_TCP and FLOW_ACT_MANGLE_HDR_TYPE_UDP to
satisfy the nfp driver offload check for the tp port.

The mangle action provides a 4B value for source, and a 4B value for
the destination, but only 2B of each contains the useful information.
For offload the 2B of each is combined into a single 4B word. Since the
incoming mask for the source is '0xFFFF<mask>' the shift-left will
throw away the 0xFFFF part. When this gets combined together in the
offload it will clear the destination field. Fix this by setting the
lower bits back to 0xFFFF, effectively doing a rotate-left operation on
the mask.

Fixes: 5cee92c6f57a ("nfp: flower: support hw offload for ct nat action")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Hui Zhou <hui.zhou@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/flower/conntrack.c | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 726d8cdf0b9c..15180538b80a 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1424,10 +1424,30 @@ static void nfp_nft_ct_translate_mangle_action(struct flow_action_entry *mangle_
 		mangle_action->mangle.mask = (__force u32)cpu_to_be32(mangle_action->mangle.mask);
 		return;
 
+	/* Both struct tcphdr and struct udphdr start with
+	 *	__be16 source;
+	 *	__be16 dest;
+	 * so we can use the same code for both.
+	 */
 	case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
 	case FLOW_ACT_MANGLE_HDR_TYPE_UDP:
-		mangle_action->mangle.val = (__force u16)cpu_to_be16(mangle_action->mangle.val);
-		mangle_action->mangle.mask = (__force u16)cpu_to_be16(mangle_action->mangle.mask);
+		if (mangle_action->mangle.offset == offsetof(struct tcphdr, source)) {
+			mangle_action->mangle.val =
+				(__force u32)cpu_to_be32(mangle_action->mangle.val << 16);
+			/* The mask of mangle action is inverse mask,
+			 * so clear the dest tp port with 0xFFFF to
+			 * instead of rotate-left operation.
+			 */
+			mangle_action->mangle.mask =
+				(__force u32)cpu_to_be32(mangle_action->mangle.mask << 16 | 0xFFFF);
+		}
+		if (mangle_action->mangle.offset == offsetof(struct tcphdr, dest)) {
+			mangle_action->mangle.offset = 0;
+			mangle_action->mangle.val =
+				(__force u32)cpu_to_be32(mangle_action->mangle.val);
+			mangle_action->mangle.mask =
+				(__force u32)cpu_to_be32(mangle_action->mangle.mask);
+		}
 		return;
 
 	default:
-- 
2.34.1


