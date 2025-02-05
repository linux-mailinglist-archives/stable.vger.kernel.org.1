Return-Path: <stable+bounces-113979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA09A29C00
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663701691B8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761821505F;
	Wed,  5 Feb 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kYtQxviv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MZ8HiDWe"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4D214A96;
	Wed,  5 Feb 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791663; cv=fail; b=Cmfl0G5YnJ0ZY91uMPUftxlWaXqPYXez6YRfd9SWot+xgE/qHvA9lWyLLbqq5agyrNpLj1uHS+lklhPcWCeYBdqYMzi05nA1PyCAWjGWHGInwfkBtzN3LoEW08AzCm6/A8Xet0lDWFmexWSxVqNMGua2GOyFCp3XB30X+quUg7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791663; c=relaxed/simple;
	bh=ASJ1kfzG6FxSWb3pkH98it0Ug04eN/WCaRyVeJnqsIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MExuOFd2r3y5IkbOcyau+baUYbuACFVyEUgWDAvSSUQMRPLLxyw8BnVlNo2o79nisfZBzTgKTzPuYf4D/3huqm2n4JUmY7jvA2q9tbIpWtPdYLizYcfjV8lzVxUQmcCeOec9hwWVcvpBiGSJXxzZCcNDfdcx0qRk2xIA8i4OpfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kYtQxviv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MZ8HiDWe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfqrn028397;
	Wed, 5 Feb 2025 21:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ebe0T/W07QRq8Zrm54Z6mq31TS1IfOvXTZq7ux+Gs9k=; b=
	kYtQxviveZA8gieyK2DXREKHksdbYyH0bym0fbfVny92uwBXc71HLRkjM6n6i06t
	u1emjala2TMqvCW1F5lWAhLiRa6f+ynUkbqdGkhrbT/H98QxXx9D27ao+kr2c9vX
	7hnMbg1X70ObLc81wnQHT8EmBBDc6ymysuRWS+oP+vBsdAAR/fnrcowiFfEl72Jx
	MwM3MHHAkeJ3M2on2Jl8AvciwN/klljoyseaAS2WMmRlAEbsJSlfoPHO8Wy+CNdG
	5Mev/kxJzSqOJSvik0jQdW8YMluU6C6log9KThtUK50bemnXYXcukJjGTdDf01L8
	cvmMUp7GTsf7bCFa7SunYA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfch0a1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JtmW3027758;
	Wed, 5 Feb 2025 21:40:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p4yuum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKhvvDh9lrjX6LgxLfyGAX3mVn6dCGrxA6j5OWNoyHUvDBcOBZA/Zm+lRo+QDLnAiJbnyH7jOdrEkI/W4A7jOs1mXaRurJ24RcJKyfOcN1FXTg8TOAfI95ugED2qVOw3amk9aiRkJptReE3ULtE9k2dUrsYxe8X0WsX29PchWG3AE9c3/RYbtZl23tXc/zGofbTajbWR9c7Vd/UNJmD3wv/TiabtZD22JUUXlQJTykOXWFghWGpbmUWiuLDg1ibpkSevHRs02jeg9mp3fTD8uJwEFWi8Kcs0hJ4AeU9TNenCx4rcFoIl/jfK6AjVMBis/QtGab2ezJNXoY4LlW1qfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebe0T/W07QRq8Zrm54Z6mq31TS1IfOvXTZq7ux+Gs9k=;
 b=LiQKb9e2Fq87niVc4n+CNHCfqZn+tiywxLt4QLKbEBbm4NzXDS9bhPHn9bc49WhZ5bcBJRe4A6MooVOS/9RCkWkna0PttS4W6+XAgpGEyu/bkIVdTBIyASm9P2e86VtJG78cknjdEc4InztyqA/ouKUmr0EB44qbFJUg2o/AtfhjTwHwq3nkeina3k+cYCPFEfYQFnTCRQnczTyLHdTlV0ocj4tcThrbZR5fKEcZZsIbXH/kb9lDrNKvdGcD5xtNanFhsaPs1eb7Ia34XZlBUsF4KaFiu4qDabq6S+2qhKW83zQ6XpCxUT2mrLXmVB13HZvHQH2UfHybo/RxNHcpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebe0T/W07QRq8Zrm54Z6mq31TS1IfOvXTZq7ux+Gs9k=;
 b=MZ8HiDWePnHUum4wl9q3GcIBbHENFS/7r8CKx83tJl5nUxaNMIy0MudhLy8rfSlSThu4EweynwujobFKCLsUVJTIV9jsBR0OgMFWXskI475+VBZ4axzRGAO8CZg1s3//JgUQMjlR/U0Su/gO7o6t37uSYwc4TjJyg7fnvbWJR0U=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:40:57 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:57 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 13/24] xfs: call xfs_bmap_exact_minlen_extent_alloc from xfs_bmap_btalloc
Date: Wed,  5 Feb 2025 13:40:14 -0800
Message-Id: <20250205214025.72516-14-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fd5d47-325b-4690-f9a4-08dd462dc671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?deFNymuaTMpHTa/ASdhbYYqjUu/yEZDMcXe6aLSX4SuOPC+yuYqg7qeXLPhq?=
 =?us-ascii?Q?64Q6MXLK7HQ6rd7U7Xl+JLfSbyL/zaGW9Q8z1B33ckFzqFIDgTHZSJr4/Ntk?=
 =?us-ascii?Q?68cXUKL+UuC3dpMEt77klx0HUqbeyFO/CJvA/v1RasZQxE+6JLEsxmbf9NNz?=
 =?us-ascii?Q?TlAObV5xwleXsJ7NR1qlgSp2nZXQoNnlq5DVxI1bEYCYkd5t51K+16yndCeb?=
 =?us-ascii?Q?UFhSJZIIccpGxwVRoVGxtfq8R51kMR+viCQj7TsU7yE20oV4PO8ay+wUdabN?=
 =?us-ascii?Q?kOYYVYkrVBB9sxuxoeCksw7x2hSGXX7B5ZwwOZ43M5a13+udNfNAL1BvSVJ7?=
 =?us-ascii?Q?rNPyR9uNx9aGZBjtsIMwNSdNWvTUxh/m3yTN1oOFOPBQQ+V21Ktgmfwhfzj8?=
 =?us-ascii?Q?I66uqyigx+3BrBW3N56m/bhV8mDedhUCwzQGCUUT68jjyc/PcIRQOkzBbKz2?=
 =?us-ascii?Q?Wby+mjT9MkAfXGwgTplwxiOYg0JlhioTBvjMzXqA3Iczn8LT8KPRfsruYIDc?=
 =?us-ascii?Q?UQ6PI5mt+pEcq4u7oUifFuTNPGQFixDSJIVm0X/YVECn2X8/AoFesW7h06Ck?=
 =?us-ascii?Q?Js/7bLKuLxkS/9AIr5k/ZQa638LQQbudoh+zJSSUVxnu+zkp/kZBr8QLeTgS?=
 =?us-ascii?Q?/ckf0YtIz43DRbEF1yqkqChR6KFZ+nPBh68SyuzoT0kghJZJtJSmTQpoBiF7?=
 =?us-ascii?Q?rUmaTX+tz90zQzOylbi1mtfnmqLmhgbAmxkBcNRFBjc/Rt7r0MTdPrKukCww?=
 =?us-ascii?Q?0a5cy9+8sKsBvT/houoy108E/Xq3ymXc3BakX/h+7yn+GXzrS9/926mctIH8?=
 =?us-ascii?Q?uJTiU9XfwkGwtLig62MPGzp4YtH9h8v/mb2UycxJ3+ipaSz3OP60SwPIEmoY?=
 =?us-ascii?Q?xVEiEOYTfQmKXIh+1w1RN7Lrq9zaQoY8LEBXnQKHkWSzIXWlAyboNc5bVSFQ?=
 =?us-ascii?Q?uOlC0pm1/dsZmaXw/x5tYzdM8uVhbl4dpGiOLEvyhpoizvEIxEqZmLZeXM6+?=
 =?us-ascii?Q?42A8Ib/gdFPLHZhrc/NE7kH2ZJymxA4Ayqg+RrxJWBaKp0rqdvhk3Mf3ts3W?=
 =?us-ascii?Q?wfxrc/BjnXWP2OyTPLsz/1FlKhwxW5am9hh8FjfHYDBEO6IHrpqAAGOwY1LE?=
 =?us-ascii?Q?Jt/67+JxV4U+brMT92+bmjw+3yDEmfJXkOfyj7M/MbYgpKaoz0N1ntwZ+uZL?=
 =?us-ascii?Q?wQVjdmX4mX5HQ1xf9fOWXcHCCqhK8522XF7iH1zANl5OVdFBXPo5duvgV295?=
 =?us-ascii?Q?0piWQ9NSHDuj4XJOd/0CggM01FwRUhZRLrwVXDb0cOVgu7WNivSFXV9aXd8u?=
 =?us-ascii?Q?0TnIbu4tDH8RdYQ0AQ3ffk493+vCE0jbOlj9uCVDtON8UMyk0n51zGmirJqC?=
 =?us-ascii?Q?IITH2/dxG2O1DbiZY5nNOq1ZnhbW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQxevm33OV6HCKTSLdKPVcGiY6MDcq0uLjcWdwpONVqiwnon4o9PXJvhmVPc?=
 =?us-ascii?Q?P87aZn/oWoI4/6BrkFWok5T2S8Aw1ozNh1eWJAay9gXcHYaPgGSTBMi1u6Cd?=
 =?us-ascii?Q?zGV5b2fzLG6ieALCaz9vjIBWrQCRvki6DfNLX9sQ7B0IaBGL87YVTaSl0B5k?=
 =?us-ascii?Q?GGxbPD9Y/OQn9dN8OfBRnNCmVF8E87WU57hf8q5pU9yO8lREIrPJ+TJ6G7zw?=
 =?us-ascii?Q?/zQXRhPVnK65CQ60nZPb/bdR0DIw94kTP9W2BHGXDNlvadrRFoG7oLO52/f4?=
 =?us-ascii?Q?eK2JjX+VxOoNTWWHQ5uZt1Z7KBgvgGTxxjxhBuXRhqLCEDZF3oUi2OWiQclQ?=
 =?us-ascii?Q?GwDblNkmyGqFWlp3jU2UURl3UzyqHTk/AukR62v0PAETyqtNSSEtnrFb6Aut?=
 =?us-ascii?Q?k+tju4ekQVWYmXIV/uIGoqV+q5Pmj9sERqAIBgVVRie/bimi1BXvp19It1gU?=
 =?us-ascii?Q?22T8ovOGq+wPy48W6EPalZqWjNsrGZdjBF0F4W2UxIH8eipht7EzTEx0Rzkr?=
 =?us-ascii?Q?LPAhgYqhjGsShZlWw1Czw/ciRz88x9iIG59zAQ4BSDT2CWzjw6cDUER7tUsC?=
 =?us-ascii?Q?NeNDYFz5FByghb/G1rmTl7wqv3i7ZChEJ+NWAj7xmNJj2SdaoPhziRZkGcuk?=
 =?us-ascii?Q?vYleIdMGjuvqGqeK17d4CLoO6qvBeV7XIgsQfUMPtPQGpwXSt/OqTuxZLAtU?=
 =?us-ascii?Q?+7hNiQEJk2FOHKDK7xp/PXXKRZCwbF0MGI7Wc8h6lvRNrgpdzL/wfeWWykFO?=
 =?us-ascii?Q?0Ax/0v1xHiuIb2A5B4TmCh7OBuNzyhuKZGJRRckPUsOws9bQ+mjp4H2dk4Bv?=
 =?us-ascii?Q?1Y2npCIA72rf6DSh5dU+8a4zzAFQkYMFWfPolnVhccc2d77gn5EqjsyzoSGB?=
 =?us-ascii?Q?J3j3DT+GVbv6r9FBksyvgpHv+l/ajMSlLgaH++29tyyzEDGgXdVXqrR7KkR4?=
 =?us-ascii?Q?dPyx49d5/WUJMatbO90abJI8UCUwZ9dmf+jVsuaaNdT0CoCvBTmwaO4+1Sj5?=
 =?us-ascii?Q?UymbHOmUo560c1gUNIm7juOgK0emxHUtWdTsDVGjwhSyTkx433C1sgSsvPlz?=
 =?us-ascii?Q?SlDspAnu6miI4DV36HwGBliAhEfdPSs1dS0FF/5jpYKRy4vcYJwFhjwK4gsq?=
 =?us-ascii?Q?asFEvwhFxfbLoPM3vRfvNcl3QnaZC+zW6exO52o0snP6O6TM2gpBuqEYNBRk?=
 =?us-ascii?Q?RQM+uH9n7BJ92LbFikTO1qqVdXJr9poRUUDzMoF2LATPLY3cb2F6l/fIXgpq?=
 =?us-ascii?Q?yMIk4/eVDbPNggyfSY/lsfVM25EuNUH886EOlZ5Yh4RrG99CW3+hJRMgL856?=
 =?us-ascii?Q?zoiIElGZ2q5o2b9+tNLOEtbPoCL7Wn1zuvruytOYSVXphLurCbvH125QvcQu?=
 =?us-ascii?Q?bAE40AO1mNndTPWS4ImlLD1Zqja9nt82197fAKLwBitLPaWFpQ4dQRjyv9wE?=
 =?us-ascii?Q?CU4XXu6MQRguErsRL5VbmCkl5ZFYfer7wS/OBOL12dQrJChUyezfzz/nK/hL?=
 =?us-ascii?Q?bd0pxo8IT1YBnQObpXy3QN/D9yPCwH0cKEXe4fiCHNb0AH7cChj3SFZyJ7Y3?=
 =?us-ascii?Q?B/TN5S1OF9FKHtOJQ8GEfQ8LkG4Adimr7KpEY9+T1PRi29F/iVC0W28HhYEd?=
 =?us-ascii?Q?ewVR1KfQ5rBwU/x/0aNVT9i5dEqEEYnuPtg6ru0UmZb9DOIiaVTmoNrbvYHc?=
 =?us-ascii?Q?+Ud44g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3hvP+z2JxeRyrv8E0iwfPviKRcqJJWxT2JKI0/Brp9hUmOz70Ubk5O95qPOqRvrIOw3dsl/l8oPWxCyv9nze4lVv6if+FKwdbYYDcrJRyjBQXwRzEajF1xY4EyODbKzjOgYSxW5LpZbG+kTP1l2xatpQapTnw+A1jzNUPoeqdLq5KZvul6U5mZ/LgD9Ekok2/Hn0PcyaXc6JfG1qCmcHEdAdlIrHYY6CGLIf+cuGIukibpLX/oJLbCQSlJo3mu6v2aNOoU47ZBOmDHFlv54K+kaLBPBPBAFmhe6Xj1QTE1IepDuURQQdIylj1/+COVMrVkzTJ7g0oWch3RW3ZJ8bv/lar6WQ6y97ZvOQGtvcS1OT5Dwa9YCFM/NrcmxoZzgGT/OpMNNpGQv4wUQhD892tpQQuktx+0riS6Gxa3+lvmGAo9W8gC4AeAmzIK2DPu8DkysdMg53WZk0hlxgeeq3jgTHKASg51zg53oVebx3MOdGms5LI1Tt5kgKmzNqbVQehk6Vor/3/vtexKiidIYU9UDV8YzU7bpQxenorftb/ZXwHJ/k5pg5/gIqx+9CFvuLcJWq+70MbEBSSIyS6lLcNcZI/qmwQqn8a/OnbW0zlvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fd5d47-325b-4690-f9a4-08dd462dc671
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:57.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMczUXE3SlDMyhNL3S56JyBCX1c2zk/sxeDgQ9evj/IWZBC00YwOopAjI90qKcoDiVwzpBGJqHE7EAaZRv7/KmTUCF16OBctRaLc7ny+fM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: D1klFPtDGAygnM8lg6Wh54snUKpfTjbG
X-Proofpoint-ORIG-GUID: D1klFPtDGAygnM8lg6Wh54snUKpfTjbG

From: Christoph Hellwig <hch@lst.de>

commit 405ee87c6938f67e6ab62a3f8f85b3c60a093886 upstream.

[backport: dependency of 6aac770]

xfs_bmap_exact_minlen_extent_alloc duplicates the args setup in
xfs_bmap_btalloc.  Switch to call it from xfs_bmap_btalloc after
doing the basic setup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 61 +++++++++-------------------------------
 1 file changed, 13 insertions(+), 48 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 38b45a63f74e..8224cf2760c9 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3390,28 +3390,17 @@ xfs_bmap_process_allocated_extent(
 
 static int
 xfs_bmap_exact_minlen_extent_alloc(
-	struct xfs_bmalloca	*ap)
+	struct xfs_bmalloca	*ap,
+	struct xfs_alloc_arg	*args)
 {
-	struct xfs_mount	*mp = ap->ip->i_mount;
-	struct xfs_alloc_arg	args = { .tp = ap->tp, .mp = mp };
-	xfs_fileoff_t		orig_offset;
-	xfs_extlen_t		orig_length;
-	int			error;
-
-	ASSERT(ap->length);
-
 	if (ap->minlen != 1) {
-		ap->blkno = NULLFSBLOCK;
-		ap->length = 0;
+		args->fsbno = NULLFSBLOCK;
 		return 0;
 	}
 
-	orig_offset = ap->offset;
-	orig_length = ap->length;
-
-	args.alloc_minlen_only = 1;
-
-	xfs_bmap_compute_alignments(ap, &args);
+	args->alloc_minlen_only = 1;
+	args->minlen = args->maxlen = ap->minlen;
+	args->total = ap->total;
 
 	/*
 	 * Unlike the longest extent available in an AG, we don't track
@@ -3421,33 +3410,9 @@ xfs_bmap_exact_minlen_extent_alloc(
 	 * we need not be concerned about a drop in performance in
 	 * "debug only" code paths.
 	 */
-	ap->blkno = XFS_AGB_TO_FSB(mp, 0, 0);
+	ap->blkno = XFS_AGB_TO_FSB(ap->ip->i_mount, 0, 0);
 
-	args.oinfo = XFS_RMAP_OINFO_SKIP_UPDATE;
-	args.minlen = args.maxlen = ap->minlen;
-	args.total = ap->total;
-
-	args.alignment = 1;
-	args.minalignslop = 0;
-
-	args.minleft = ap->minleft;
-	args.wasdel = ap->wasdel;
-	args.resv = XFS_AG_RESV_NONE;
-	args.datatype = ap->datatype;
-
-	error = xfs_alloc_vextent_first_ag(&args, ap->blkno);
-	if (error)
-		return error;
-
-	if (args.fsbno != NULLFSBLOCK) {
-		xfs_bmap_process_allocated_extent(ap, &args, orig_offset,
-			orig_length);
-	} else {
-		ap->blkno = NULLFSBLOCK;
-		ap->length = 0;
-	}
-
-	return 0;
+	return xfs_alloc_vextent_first_ag(args, ap->blkno);
 }
 
 /*
@@ -3706,8 +3671,11 @@ xfs_bmap_btalloc(
 	/* Trim the allocation back to the maximum an AG can fit. */
 	args.maxlen = min(ap->length, mp->m_ag_max_usable);
 
-	if ((ap->datatype & XFS_ALLOC_USERDATA) &&
-	    xfs_inode_is_filestream(ap->ip))
+	if (unlikely(XFS_TEST_ERROR(false, mp,
+			XFS_ERRTAG_BMAP_ALLOC_MINLEN_EXTENT)))
+		error = xfs_bmap_exact_minlen_extent_alloc(ap, &args);
+	else if ((ap->datatype & XFS_ALLOC_USERDATA) &&
+			xfs_inode_is_filestream(ap->ip))
 		error = xfs_bmap_btalloc_filestreams(ap, &args, stripe_align);
 	else
 		error = xfs_bmap_btalloc_best_length(ap, &args, stripe_align);
@@ -4128,9 +4096,6 @@ xfs_bmapi_allocate(
 	if ((bma->datatype & XFS_ALLOC_USERDATA) &&
 	    XFS_IS_REALTIME_INODE(bma->ip))
 		error = xfs_bmap_rtalloc(bma);
-	else if (unlikely(XFS_TEST_ERROR(false, mp,
-			XFS_ERRTAG_BMAP_ALLOC_MINLEN_EXTENT)))
-		error = xfs_bmap_exact_minlen_extent_alloc(bma);
 	else
 		error = xfs_bmap_btalloc(bma);
 	if (error)
-- 
2.39.3


