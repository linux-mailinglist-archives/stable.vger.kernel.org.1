Return-Path: <stable+bounces-17668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC6846F10
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 12:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16196B23ED5
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC113D4EF;
	Fri,  2 Feb 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="ob2i8ZI/"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2136.outbound.protection.outlook.com [40.107.220.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E017A729;
	Fri,  2 Feb 2024 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873871; cv=fail; b=C9hyDWMpG16ytUWxCs5kW2qpTUw1iZUb8Nz3f4GFRpni1JJB2B6HUvib8phzUHCiJiQAQrhT/dYwoic31/vIG9FBGR/ohROHNDUdSGFdGuzNFISjcfp8u0q6WFJRlDmJTcse2tMLaHuO1WAVb1KdECcCzY8eLsZSatEh73X/MjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873871; c=relaxed/simple;
	bh=T7dLewuFeVHtoBtsLAFRJi4WBkDwBrstTfQLDJN6ax8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmlEqLTydHBcABBXhGOdRqFQBtUkNvwa5YnIZfJVkMosLWYDe18/7d6yJk1yYH6jzIoqMfKPSP0h8i2x7VJlAs7HU+oIioozzqH7HN9ps9f+0gwLpe00hUtbYNIjifwvpDoAVQroLL16CH1Crab7Zh5w19NzHAXv85V4rmsoB4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=ob2i8ZI/; arc=fail smtp.client-ip=40.107.220.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAnPN4IZ0roPGbjTcOQ1c3x6gmq4lkwC+k3mWmSymqEQZNpdk4K1y0/YX0WO6PUGmCm8atva38bEf6acADqf2RWu5b9Hhsb15/EUnEHdm3RX0jYa+TrdsYtqykHcLCxeU0TRTfiS7/rKP/a00KoE+733gmLXzonnKmMyu0zSJ2bdwOUf+JA6C0WRUBRINv/2dlsUVgqQW0e2Se9CXXAmK8hnAU6pKHZZAsKyTH3uXeCOIHSenY2XHihNThTZIbFqad1g1OvG+h3iYWRJFIxsw5KOx7Gk1DuvxFA8Gd4F/GAPiPqGhwSwdmp4aeM9l4KItLtUaGwH8am8SIb6R3uheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUuH8Fj+KNpMuo0516R3jNK2NTY2LouYrDACzrG+SCQ=;
 b=mPb01odmDubhyLlj5NuW+SqRMYhCsu8CKqkwIt80Z0RRWRlDQ+bMM0qowVtJ76pEOqzgP2yaoXPm55hKP/XgPQZOnmljq4wO2ORnC290hCGnfe+ethfZ7Nm1zWkQOh+q0+k64lY7nIvVoVvVYAgho9nQWEex0yujE3XgKjUvZ7WCAP7DLhalnDmmbMmFfnZ0NLfsJ7txR5W+QgEojbEa7R9XKMUcIyFFn68Sox6/AnFPyMDoMlsg6iP4QFdx4tenL5TcdlXq9JQ4rd1TKr7YAlppHJHsCmAeOJyGBoebapA38XM1yeyL6+0rJim9UmljjQInVQ86PGGjsCx4HsaH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUuH8Fj+KNpMuo0516R3jNK2NTY2LouYrDACzrG+SCQ=;
 b=ob2i8ZI/lQhcT9BknVLKMeKW4AxFHKIXaCFLbMtvExyLVtlQZl07zG9WQrwMmy6skNBVSre1yhYpSqVN4mTVWCv0ObFaVIVYC/nbZ+0ffXk4QLEnrvZ8/KCjJ4v0tjXx0+1QqFJyPzamNjPe6MZGgpMpj8u0Vh03oRPlUaIQgf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by MN2PR13MB3853.namprd13.prod.outlook.com (2603:10b6:208:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 11:37:46 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:37:46 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net 1/3] nfp: use correct macro for LengthSelect in BAR config
Date: Fri,  2 Feb 2024 13:37:17 +0200
Message-Id: <20240202113719.16171-2-louis.peens@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66e05c84-686c-45a2-7c43-08dc23e360bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3kE/Uwr2JRwX1CvgdBt/BBPp6y61kfVN+I7qYZ0YtBD7anFJk9mRmRsby59sB5tDwOo55ew3o1xjhsk6WH+FL7SKsjGbYV5hAnODZEVG2i6T/FwAWKHnYChw3aOOw6meJ1GfkM+387Bqn1glQqBLlcr6zgEBjf0Z3RFCsehZPTO90bv65pItCiGS6m8DF7wL5zui96XXyhr4yQubfAQmYH534GEwJC9MjW8t5ogljN07QzbH4lJgOtkrKR5bVTxSgh7NgclqhXuHg7RyHzhzUnT7IFKidOf25fsTIDoiL0nEOzeHmuPtiKMrF2mFK72a+pac9f0XPVOWOYblOzIyfbEg0AABs7pnafVm29sRvlVYtjRqB7fv7lBK1R6VzfHERdc/c57xT2L4S7pvmUnLLELzekoeNcisDYQ/EgCTZx+xONPWd4uLoeK8naO4FXQ3sPWhwSfHd20iUJfwZkB1EzRdkWzFFCi/cFvRu5Gb0Y895xJcz1Aoq5NAQGftgK3loRZ6fch09UMuPyJCP2CKzZIuoDv8qYsZAVqtv+KuWcbFMSi3pWDMFOOmQdBdbuAo13pjHyrRrZwHCknfgGo+iedyoOOGMliR/8E3A98SgWCXNjHJ1T4uC9EFtbhtleFH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(110136005)(8676002)(83380400001)(66556008)(6506007)(6666004)(8936002)(316002)(54906003)(6486002)(19627235002)(66476007)(26005)(2616005)(6512007)(107886003)(1076003)(52116002)(41300700001)(2906002)(5660300002)(44832011)(4326008)(38350700005)(36756003)(66946007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?no36oFlSr5IZmYdNGgz32e8e/qWd3rUqklIdc8q0YAfqLiSdrZ0BpWd2ojvE?=
 =?us-ascii?Q?UAQJ3HAcTr/QYVCoCoHO26P42i4kxWpkeT9dEDAZ1Vc6vtd2xFHIXf525vWF?=
 =?us-ascii?Q?cpOXyYlW78BGKlnKWY105hi3UoiBqBazWC2zjxeyJiZjHA44cHZVc/ZoB5RN?=
 =?us-ascii?Q?YDx5NA6DazEqR5ca8NkBwcDJfd6sWr2NNMCh45Y6xsYun1p6D4cNoRlUCjO+?=
 =?us-ascii?Q?jU5rUyZqgQePxhvv4hCgNljDBD/3kxMlGjaJW6A4Q20zMgpOL/qO3euald3U?=
 =?us-ascii?Q?2qORFrTr0815ni4LllZpFtPpjrsesLslFnjCcBv98I0QDTVM1fTJrvW3fLR+?=
 =?us-ascii?Q?/E0r22uN1sOp0qe6tFkJxXeJJI1gVIx5zkxxvHSUoXfDSQ4hvODZGE5nA/SK?=
 =?us-ascii?Q?FDRH8d2+L+VGEW3SiRJFliX3QcoW82myopLDMoUqdFV61rzAXMvW6Df5bg4T?=
 =?us-ascii?Q?deD7qMbIJUX1JT2bN9lO4pafDB7bSxR9id8Tt+PUqrBTNeXHPjc0ART/hKb+?=
 =?us-ascii?Q?MxAyPFnIswBVAVGQLp3+MiN3ZTwJAymcb1uxaZ5K2YAR8b2F9qfkP/Eh7w4J?=
 =?us-ascii?Q?YJQyRFp+d//h930FVp2DzKsDijAo9hbborc9gOjUWXMZ9js4qtQ0keXDUf+c?=
 =?us-ascii?Q?K+SK07znRUGUQrsTrkYsvbkkKS79gDFSdaSoGe1qYbjfAc3BjydjOlAUqwAk?=
 =?us-ascii?Q?ZTETk0fSDSDk9DYbRaeFd5dCdexK3rXWjbpwN/odzFEO2m4uQdTM8XC14PuF?=
 =?us-ascii?Q?VRmygt4Wv7fubSBADaxaQ1+pyCijS5MuUFOVyyyY5wDBvv9oYx1v1wT27LVb?=
 =?us-ascii?Q?GdXoPPFR8fEOXKfuGLtXzKOjCRTZt8RnJEzHysWxPgqFi6abvt6vmV6DqH7q?=
 =?us-ascii?Q?Quf3izWhfpUHZ//UiVvheXCb67d5K2gTHMSJrGyUObJEyy/DSMkrXusz3Pai?=
 =?us-ascii?Q?blpB/n1U21nODxHBaL6Ud7GHyq1YFujfuVR+18zlrnzWb0c1diS0tp3m264M?=
 =?us-ascii?Q?EieQbp3VD/DS6hoQK1t1G4eR0FAVl4J3R97mMybQYy4skaAwqC3kzhZiwvD1?=
 =?us-ascii?Q?GVyUvZ3+lMuXOnjwCfsXZLKGCYKhO33WSXK7bZlSaGVmYEOu5p8kHV9S4N8g?=
 =?us-ascii?Q?M6qEvgwWIYYbpC/OF2IjYI2ZnYuWkAiRXf3mKNYhN4eS7miu7kWhQnOj/ZhV?=
 =?us-ascii?Q?vTyjdW83uFXfxsG5FUTW2VLMqnwfYx6H1FGondSJdGqy2sm2DjluTnNONbHA?=
 =?us-ascii?Q?yiaUfwKd5SYZUokiS7aoyX/sgJkHAxIuqq4keAD6I+rRTBCAqxjqI7zK0qSp?=
 =?us-ascii?Q?KnDZ8df2w0oHY5bR6vs49/uFDXDN304MzJf0qVdB43hjgBCMfK0Y/gNSPsbo?=
 =?us-ascii?Q?c/0KaikIzl4LVqZs3Z2xQgmHR2oxYMedtLy59InL8RxeHiOaM4hoZFIxcWlL?=
 =?us-ascii?Q?Py4705vPB4vuoaG9C+esmN7OFCi6+986Yi3jzL6aj9xcNkIw++w01t3b6FGN?=
 =?us-ascii?Q?LgpbI7efcd4/XwKmhWO602QeqjQWOt4ZF3ZCAOBUK8zfji/pwgD/4sNdbsxy?=
 =?us-ascii?Q?WWyX0BIBtsxNS7KjLhFn7ZZSN5iqwAVfvszXslc4SPAK10eV13If8zZayjwd?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e05c84-686c-45a2-7c43-08dc23e360bb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:37:46.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUiObwS68IwrMDG1pzdvh9ODalskO0XkKqjMc1fKfIARvuJxsXwXe6R+Kri7kblw2qM+oODObgaUbPwoX3+9UosHYM4tQPKQYrYKYwFu76Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3853

From: Daniel Basilio <daniel.basilio@corigine.com>

The 1st and 2nd expansion BAR configuration registers are configured,
when the driver starts up, in variables 'barcfg_msix_general' and
'barcfg_msix_xpb', respectively. The 'LengthSelect' field is ORed in
from bit 0, which is incorrect. The 'LengthSelect' field should
start from bit 27.

This has largely gone un-noticed because
NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT happens to be 0.

Fixes: 4cb584e0ee7d ("nfp: add CPP access core")
Cc: stable@vger.kernel.org # 4.11+
Signed-off-by: Daniel Basilio <daniel.basilio@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index 33b4c2856316..3f10c5365c80 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -537,11 +537,13 @@ static int enable_bars(struct nfp6000_pcie *nfp, u16 interface)
 	const u32 barcfg_msix_general =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_GENERAL) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT;
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT);
 	const u32 barcfg_msix_xpb =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_BULK) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT |
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT) |
 		NFP_PCIE_BAR_PCIE2CPP_Target_BaseAddress(
 			NFP_CPP_TARGET_ISLAND_XPB);
 	const u32 barcfg_explicit[4] = {
-- 
2.34.1


