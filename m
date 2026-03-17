Return-Path: <stable+bounces-225851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF8rNcg+uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:45:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A42A922C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74233301C6A9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D93335BDB;
	Tue, 17 Mar 2026 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iR91E5MB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="o+eoIrmj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BA3AB284;
	Tue, 17 Mar 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747904; cv=fail; b=j8ecs3MDTDKbB0HrbXxDF6oSRZXtBf1QMkP07heIqZF00PWz+bstMbzNQ+WvKssJFANzNud7C4Xbz1C8Vi6kcq80d9JfHrwJ9f8OXEbfMwlWj6cO8rHmudlQ/MlhLN95XiBjgCgDLX3/w6VY7JyVHU7fueoh7nBSP/gyywGeAuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747904; c=relaxed/simple;
	bh=jk9c+xZuvdkUob/fNG+y87+NSgvzt+x+0QethtsIKnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzzCOQ63BU+/+X6o3egS+q1u9+/HZQgrxfkPm4CoJKVrmsFxWssj4ma2JY9L2t9IK/d1ZlTiLNKfRYijsr1q7zp5DT/vAJxOZT/nJ826lMhQbrdu9UjZ1EXvd/9Aij3oPGC6Hy8KifL22KXrvYMlvxjARVgs+LkC6k2omqiKM6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iR91E5MB; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=o+eoIrmj reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H4oAAb2847607;
	Tue, 17 Mar 2026 06:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=YKkqsaO0hLN7ebicIbglkkzjTwNQ5sH5s3guG6h/n3I=; b=
	iR91E5MBmJbFCg+K+o+RGQHWYCXYhT7qhlxAyP52jr/0zC14Fr4LbKthOluVWViI
	NRALG/i4I3/NdPJuy9tB3S1jejjcSAFh30iq8TDTQ0PW+1TPU5eZr1jNcBP4lrsT
	pyfvViLlKc8LgNIunZ+jGGah9Vx0dbxU34BJx5TZsuiXqMMhLnA2fj7ojpAVDRVM
	EnnMliwRfMmomPeW09jJCZrok5JmYwqKEzRticVNB+T3rsmQ8BN/P14R+B9/ekbD
	koYlKE0Ipn5UpES675/4REo8TbVyzzsxw/EiBEdvsQ33xJYqp4R4/5Cb4ar01asm
	hDabZqJIa6Fw3VMLdE1Jmw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022129.outbound.protection.outlook.com [40.93.195.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cw52v3fe7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 06:44:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgiCooQiiKFied9kN/Y7M007PDLP8A7Wzsv+IDF8rygAwf9pYGbZnUfwuWNk1koM0JsG6EJ7lQ9XjZKrhs2gjnnf1vR1I6m7m9ygFaZ4yQBzYH6q+56sDSBJMpzWbfvlLAK98pw/0LuXAtbg7r1OsmXNj904xNMsyS8D8+ekLZN+2RiyOUt98L/ek45LcG9/BlrPT5lMMUyz1kDqJTExS4h7kWi2MC9yxr9i3R0Ei+cJAc9M4PHm+YyRKtOVWcHqaYKkwJFR6JWmmDDCj9MnA66zo6hU9FwPAX4rg7E15wF016jS4BUi0LLJ21mt10AxKANAuwDsgsptmjLq4+5adA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayymNoym7UrqWMeTztLgB+CCInNuU8lSprM+3uitXHE=;
 b=j84WknJBsMf0f/n1qyPZ24MTzkHO9ptvXoyiR3HaZ3T4rO6KM/zKD524kcs7e3pGGpGdxYO8VUuYFVLx0hZR9l6UVFXYSNMx3S5SSHmNgJrfemTmUSdbCiPAe2w/nVz0NxKI9ab6fiM1N/YPF6ECdEgyNekbHQfLoViOHWvstKUXaqwvCMn1F24E3SVCeUqsV+k+dieKulPRnGjjNijIqM97pEGHAfMColkWx2vnMk2NKxe9rclVGNKfjdbChiU8i6ruv6KVhCOALfO68qowEIK+uGl8cwg5Z4a2NfYPDbb57hPe5J7uDZ8mhCd9Z/ICMxZD1jOAcznxYKSitC/rmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayymNoym7UrqWMeTztLgB+CCInNuU8lSprM+3uitXHE=;
 b=o+eoIrmjDENB3vMB92CXswdcVTBF5SSCXzlONYo9TIHIxDgfj7CxoiX6ZBvosRVGEQX4LSZ8rs+i0ze0tbChPcaVsSLEAXdEN29whPAiGY3dabh8aU8ddUQJ2BLdDdlhuyIE3hjKy9vUVLFf2N6rouF/UUAQq4BleHxRbQhAHFo=
Received: from CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::20)
 by BN5PR19MB8989.namprd19.prod.outlook.com (2603:10b6:408:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:44:38 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::2c) by CH5P220CA0023.outlook.office365.com
 (2603:10b6:610:1ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 11:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Tue, 17 Mar 2026 11:44:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5E59B406540;
	Tue, 17 Mar 2026 11:44:36 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 489EE820247;
	Tue, 17 Mar 2026 11:44:36 +0000 (UTC)
Date: Tue, 17 Mar 2026 11:44:35 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime get/put
 from tip_sense_work
Message-ID: <abk+o6ZpLRt86K+M@opensource.cirrus.com>
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
 <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
 <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
 <abgyboHV1jaWDUul@opensource.cirrus.com>
 <f461ba8a-4208-4dfa-aa70-e2c85ec2050a@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f461ba8a-4208-4dfa-aa70-e2c85ec2050a@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|BN5PR19MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: c23f2f91-6ec9-4dab-7a65-08de841a916c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700016|376014|22082099003|18002099003|16102099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Sa402H+4tF7j1yJzcdqQsS3JgWtX0JJQDgc9bssypDcWGBx5PMGmYC2rD+u1VJPXfhc525DNWumKz7m9BBhaGgSOzeIx03ftjPJz+M9ojp590eXHJcvXI5wJFoofLDtu/j7kfwSQVMTPDqQoBz4gmPOjpicMbmQm/WZPItR9LblDx7RmAQaU72H9uwwqhBpo+KKGOFXawANRitJARTIJ5XUcdhuuzB8nus7dwzEp5yiinjg1AGzJQqw6z82HtqhPaC/ZukcWrcAIvxmqRdz6dxrC4LmRK9xezMG2C8Dz7EtWsjXIRVyBBEMV0TQVYwx/PXpnjUzqllnFgRiSM/ut0T5UR8CkO/VFqf8eynzjwIlCDHSG+0ZA0rZlSSX4MKPFzJf80MEs7gxNvoojxIRo0CA5mte4cUk7bTC8xmiDBfvc8M7WdLNKa9aBBKPZMCsaKbUyTqQe3lsAtKCd7jJJj0iEWtXuROj7pAnmHkEbD2YUqnfJUwy78k4xMkkl+m/vKs6nQ0b2ao4VH8pa43nl82ugA+XWZtgzNaPBgtXUPbApCFIxnAaR/I1gCu5Imd46igl/NuderPj1qODr31nCJhaNqVXUBmdzuBsF7LrKwEmeBjBEjZmhOBrnsOVe+3ZuFox28i5ZmneugNEhL2i7ktcwm8UOSr6+J8uhLfxa1Tzr1SaWo79r2M1y4F/FU8tiyPSUZLDlDikgem5oSQHIRXMrUQ4Tv2/bDa3SgkKcxgTEF0SpqCo9mR1z1pMh9VlWEYeKQHyuTXizvQPTP+o3NQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700016)(376014)(22082099003)(18002099003)(16102099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N97DOYIjl3LTgTCQX8HOhCa8drkQpb+za9j1R/jW8cXEl/s8qVL94nj7MS36G6srD0LaR8Xs4Ja7vyqXQB2bCOpxR+i8C/CwQvc9YPQQpxySgZP8aTgDrcPbBgTOXiD4gRG/IYObwWWYpZoQOrH8D+cSHDx0n0JOL8a8TIgJipJQB8VqRSIkJ1sUrZTX6zfeUEDMZJlT/30gpUGZzZAKIqpXaa6mfxes4+EspFEMRRGVVQwW94Omz2USh9s18/9xk3qpSR8aftcqoRh7inlEZXnHCCemVKBF5s7YzEzg2sRIQEEgoG9PeVZqtGMgAbt5zsO4FZsqVFi+iEmYQ8wiD+zDSdhr7eDJtVQyP925lHko62dn7GpezcQId8cjEnWYUfcRmHbgbPB+v7XwhTEQMkQwqEeYc/9TbRluAg8I8m3ij3NvCjTQBCBlTh5RkoMz
X-Exchange-RoutingPolicyChecked:
	QdZdrmi37ajIrThDdeEAqmjDpPC/8dfyzcNAnhm+moCa/5DU/2EwC8r1Kz3EODwrOvcb75PpjxwyjUH7HxBtriLgAkgzVVYwR0etaVtNThJvgXFC0wVRQXEVj9yUIU01xwDH9KtaRkd7Dj06nUKSd+FQib+AZYcUX6xUMgUyRe+xB3/Jruh6YqEe7qCHm6JEr+b82oA++FPzCiUVZk3iKMcDH4qA7EX0A+J0oF3rkXcphhQKd0+3p++K0P3/JCSx3zMObh2/I65+7E2HGa7IncPi7Jz4Lofrb3aXe+dmoNRG0/gJwQ4MFF2RR+QdUIoofZxy0Cz8uAIkmhwCHcu7GQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:44:37.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23f2f91-6ec9-4dab-7a65-08de841a916c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR19MB8989
X-Proofpoint-GUID: 1viOzyhymwaZ7CQPzJksRe8wOwqHw9T2
X-Authority-Analysis: v=2.4 cv=MpZfKmae c=1 sm=1 tr=0 ts=69b93ea9 cx=c_pps
 a=+AD+TCgY8d24af2vGjQMRw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=dJM9XmAqQ9X4eAPl5skA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 1viOzyhymwaZ7CQPzJksRe8wOwqHw9T2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwMSBTYWx0ZWRfXyqQxoJ8XQq2c
 MrMEy0235v96lEOOxTJIDjppEqr0ph9K00xE5pitZsj/GY9C8ZA5uQeiTVVcxPDLZmJs3ud1ujE
 oFr2Wdc/L9dqHNYuGOdeE3cfeB8Vsb7kRH4Ru8IKGz88EqL1Tbj4dYloqm69W6B+ScmFyRQ1EaD
 cIB6EXM4fz02COsyv8kmgrqDo5PfDpylaVRBgDvCMGm4RqOYNQKuDl4RqCBjvPo0rJATbFVcHl8
 NS6rFxpDtV3XDITrjXTaKW00gbVZ4UvCQuxFQ2VFeeo2DIxrSPht86lm1SV19zGiDG7/tI++PvF
 t/CfSQxK46h2eZdtwoUZOrDa/b2A8dH4i0cWJRndUcJ0ZNKdbI4q4J+N1ORJOXHMUPqSvFsYJS9
 teAek2KG70/jC13sDhE5mSmQVx4UFWwsVRwYPEbngA3ZLXajw46RRMXGWyMH5GDURYZwUWufCHF
 9pxHCqct9OvJRdD4VMw==
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[cirrus.com,reject];
	R_DKIM_REJECT(0.00)[cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensource.cirrus.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-225851-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B40A42A922C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 08:21:12AM +0200, Péter Ujfalusi wrote:
> On 16/03/2026 18:40, Charles Keepax wrote:
> > On Mon, Mar 16, 2026 at 04:37:28PM +0200, Péter Ujfalusi wrote:
> >> On 16/03/2026 16:27, Charles Keepax wrote:
> >>> On Mon, Mar 16, 2026 at 02:49:24PM +0200, Peter Ujfalusi wrote:
> >  1) The one already in the code.
> >  2) Stop the host from reseting the codec.
> 
> The issue with 1 (how it is atm) is that it is done in a completely
> wrong place. I think the cs42l43 can be used with other than Intel MTL,
> let's say Qualcomm or AMD?
> If there is a workaround needed for something on the platform, it has to
> be done in the platform code.

There is probably a discussion to be had here, its far from clear
to me this is the wrong place to do this. Generally the codec
controls when the codec wants to mark itself as runtime active.
For example on our phone devices where far more of the chip
powered down in runtime suspend having a jack in would always
keep the device powered up so the button detect could run,
as the lowest power states disabled that.

It is also appears the specification doesn't prohibit issuing
a bus reset when coming out of a mode 0 clock stop (which seems
bonkers to me, given literally the only difference between that
and a mode 1 clock stop is that the mode 1 clock stop resets the
device). But without the specification prohibiting this then
the device can't rely on the host not to do it, so doing this
could be required on any platform.

I can however see the argument that it would be nice to only
force the codec out of runtime suspend on platforms where this is
necessary but its not obvious to me what the sensible mechanism
would be.

Thanks,
Charles

