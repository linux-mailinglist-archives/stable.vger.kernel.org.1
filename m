Return-Path: <stable+bounces-93045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B19C9166
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154EC282EF5
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D218D64D;
	Thu, 14 Nov 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxirQZIZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aW4ne3/2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBAAD5B
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607683; cv=fail; b=bGdcd/BXx1hN9UfThQtd9g294CxTyvCKZFKxgiFG6hLe9qrbbVJ2izO1T4XRR0jTluXIZrBKf5qvLXyOEYW7JVO8s5fIyeWY6VUNTTymEtDKS9os3IWZAdoKvb0ZA94NdpqxqreEQAW6mFBwaFAfVpqeK/oVBxKtkl0TG9wvqEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607683; c=relaxed/simple;
	bh=aHqT3ODqIlpO1hoMGEcSiXBm8cVo9kbXd+J2NWYpd8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CJq8V060dGhd1i2BQcuRhXPUW0ShWLrb7y/rVEH1wa1KTM2Be/+wgDM3CtNrCBxY4XQtsHD3ELiLDYmkAEJbZJ2+nJs6hMSgFrPWagR8n4sibtlqQbNSo+++F1CT27J2Yfo2V+Tu9C2HFbzM83zNh1bcXS3DcBxMuvY0tpFxIbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NxirQZIZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aW4ne3/2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED2wTC024966;
	Thu, 14 Nov 2024 18:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PpuSySb3xafdhApU/tS2QcQO7B7f42FFKdHRDbgdCds=; b=
	NxirQZIZICKONa0fejM1xM1TGhEZBYZWD45HK/AgtCneUAIAcpcRslhd/PGPUujR
	bltZXlxvg4UaQYmjMx6/15abos+iAQBWjs9vTiFgFqu0fQCq4KmDM6qGI1/RoTr+
	PBHX0F3XuqVkLo11hMEOTiCtqB3SfwJVBAa3w4jxj5HNwEjWj7EMcaO9CsAYHdmQ
	wM456USv3YU/5sx6140OxlRsUdiIAt2SB/GdlHOMkUgV0p/nS9NS/WsqfYYSPhVr
	QZq1BianzB96/YtB7bOWa0ben3B1RqWshKiNHcUurD7+H6/AOcTK6Mj+HEZrYkd9
	BK0awIs5vF6u9B2xkrniXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hesrnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHISU1001125;
	Thu, 14 Nov 2024 18:07:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bhce5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH87a/lpoKDsHpNYLfHWkjKUnZiYtMCBc1ApEZlo30BWlf8V4SHWkJe3hdgaGHDUbUZFcX+2852YwG6hjQGz7S1MtMD3/Qcm259A19kH0K6m6cGDDEFs9wgTA1FxsEN6jxHJTcqizR51ohhfiBiOqB5njdzOplSMAcoZtbFKjW9haPk/4MZkArS7IbB1EQoc+/1BNmzp0UwjsHyYct/XrbTGYM2Zm66W5TKUzVXRyaSSKt9dw1lGYKdZAvKsI6iAFRgw6wQp+qcpgHYDIDYuBCrhgMwGUh6T7cram1O3OEYWeXuA14erPMorMw7f8k+xOCGdNU78hCkdDEGDWSieNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpuSySb3xafdhApU/tS2QcQO7B7f42FFKdHRDbgdCds=;
 b=fmy8Hzh5/rGSNSFqrQCiVoWIUjoXtB2FLWsTbkN8KhgJ1w/zr9KJ6g/KT3Lx9HLQK0iNXYid2+az7+zJAKY+LL/OpUH3BnLdCL6L5h16jhHBSstIBDlZEuWMEkvUU8wRXv0BP57ICZWa/nd6sIslWdmnJTJe4M/mx4sgWngcz+/yRrkwuROnLS0799x1ye7VE+HZhGBjBt5aOv3Zn7FBM5ta+c211FzynjeXWRqhwOG9jtFr+/+5aUSAj0lQCGwo7Y3y0tGKFrcdHCip1rH8don1d/S7bUPD039g6eq2Y4CDEZpPbqBd7j1TF159USa0ZxCj8a+UKWjOqA3wKqfDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpuSySb3xafdhApU/tS2QcQO7B7f42FFKdHRDbgdCds=;
 b=aW4ne3/2QxvppOEWppQ4VKgv3IcQtcZtE0A9drOG+dB3GVmDLynbqw3b32iNa8UAtM1Mt2gG5Eu+Dp8To+UmhVEe4WjlM/AYqty9UA8n0u6uILMfUkwAbGKvQj0gzGEOUUHB7q9FTCohOAWtu+ty5isJy/7NLywtKDyRpDWoHDo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 18:07:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:07:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm: unconditionally close VMAs on error
Date: Thu, 14 Nov 2024 18:07:29 +0000
Message-ID: <20241114180729.807194-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111155-roundish-obituary-8322@gregkh>
References: <2024111155-roundish-obituary-8322@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0040.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baf2128-aadd-4a32-2b57-08dd04d73a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWxlb5pOxe3/IZCgDxPp/JbVijBjmqKCELqFQTebFixyK2f3r9WUpNBECm6Y?=
 =?us-ascii?Q?nRMBbOa+LVk1b6Q/Nwa0FgZ667HDxqkd4ngcYe1ZLgCDOJg4/7gMmN/hdUQU?=
 =?us-ascii?Q?TiWSodc3BA2HeTsDI9i2ZXfOTYkKluAwkZXfDyQFQ0HIOWcRPOwfHiukIuKl?=
 =?us-ascii?Q?GvM75w97Ce0h1zVSgH0+HCv7DO/3ObaPUVsx+dJy2hlMfFjsf12Rqn+9Gyu+?=
 =?us-ascii?Q?yxV9b9vUcDmf3npr8Bkb3f0qFWElFKgAAFdI4ZAceJknZ0blsBTBJ6cnjPHP?=
 =?us-ascii?Q?/ch55EJ1N1hRRkcpLV9mCTwf3YqBoInxsc+I+8bqPHIyKtf/QxCUqVYOIOTg?=
 =?us-ascii?Q?TSUwLoEhjr3eJaXEnXm1vmJ8xtj2eXP0mvn4WbDd4UGw+gx64xrVVL3MkNL/?=
 =?us-ascii?Q?c4iTOGYaoj/LRwHWpwAi+qvtgazCm2EEsoev3QIsJxGs6sof9CWcdBUN45LJ?=
 =?us-ascii?Q?X9J0kz3zrnMuTdckxuINeGBmpKhgG79x6ZZjd7glSgPp9TfKkLMtziiIC/lX?=
 =?us-ascii?Q?UonyHz6v/Xwo27fSINQwmTSdvLK8y7R5DoFk76qXVuYzXHnmklKoyzUd/wkB?=
 =?us-ascii?Q?5yUiw0zlSepNH62ujFrDJPK+m2Kygg+iNCZ3A7PYkTB/Mp4+30GpXn+XWnfc?=
 =?us-ascii?Q?tIjzGWq+WGnonVE5Fus38YyB/XVKpL4xe1ESizZVTF+qRICxvxw6W2avxYpc?=
 =?us-ascii?Q?03KM4pODEYOguD/13GWss/T1LgOff+oHYBWFGT9qbORGfapRA5IY32R7wzQI?=
 =?us-ascii?Q?xB1fPfhZIOnWCHvAruxASti/emVI4JAak4DQLakXMqf5tZfPUnNKOdwO/AbT?=
 =?us-ascii?Q?SQZ1JtU1Pwmz+Xi/syLhnG9ZktjaacNKW07Nl65LAayLW8sqxhKQsjema9cR?=
 =?us-ascii?Q?AAZTcrIehZei1puV9UlmkDNqKkkJcT6jo01+vwqBxNaWwjTxp7psqdpE4lBD?=
 =?us-ascii?Q?KxSaD1kIazyA2EH2O2QwcbY8aNeGiB8AZ60dTDDIKIEuF0RBplYGij6wlqhc?=
 =?us-ascii?Q?mXce4oic67Z2o8+4CZAY7iu1jVYgMuUAT3KXb4Q5rwohELw4ORLAbztCLpnf?=
 =?us-ascii?Q?bOYbwwIWsm13wPQEjsCwpCbA4Dv1/h/vVw4OzESEaJhBs3aTb7YwmhQugtws?=
 =?us-ascii?Q?ETcSfA6FvDQKvO0AtbpcrH25xlrvuvCj9eNiynmJ+OKO/r5vaytGvSWuoGzu?=
 =?us-ascii?Q?NABISgAPU+I5GuPTNjtcjkiEqsKYO7+b7Xgws7Pu8F1wDKsF9yaxWJs7NzVl?=
 =?us-ascii?Q?3/KBnh0XX2t7kMYUet8f6yEkavuMhK9oH0E6Q/GzyJa/BortZ00LumVvU39F?=
 =?us-ascii?Q?bNi2NVIWrt8kA2v/wjDdtSjx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZkgodtVfh1hJHIcAeWEu4zhqN33l1RbCi31zrf9MNUue2BHCK9Vo7OLjk2SV?=
 =?us-ascii?Q?8TZxhFYulEq8bSIW6eQZzS0CIZL13b48sY5Ams1kEqrKJFpjQBuC/AgfBdSl?=
 =?us-ascii?Q?KEgtKKR7PWPyRUIF9tMFaGaT45rUktl8Caz+MhXF3WD0Mb86yPb1s/VRGQjQ?=
 =?us-ascii?Q?zKzo+9BmgytiAhdIAXklIkHTuq45JA6QaJlfGxLB0OUh6xiB7ir+YD22efOw?=
 =?us-ascii?Q?wShYFdIKz131NL7hKf8WAxBclIPf8JgLOMog/ZNTx0wW5yyy8raYowpA8PeQ?=
 =?us-ascii?Q?9UKHPyiNDvlfhmo9BAVwq2IucArrXBWLOuX37saLr99rmbgmM2f9tbFN6qZ1?=
 =?us-ascii?Q?9iv/XfuXcEkqZ4gxE1wZZGjlML+7scGJrqwypoMKNsA/r/p3oRP5WsRBXP6o?=
 =?us-ascii?Q?3kiC9ZC6Q0u/ahpvUIp7BVjCpBNpQtxsGYX7q2H5JS0x2kbRlPT0dZyQDx10?=
 =?us-ascii?Q?zl9OXrYuqZ62OKYk9sZque9BEC1TJYGB12d59wf14Ecf8dGU3T/H8Ayiq+OO?=
 =?us-ascii?Q?pYGKE9ccpi47lhO0bO98CYay2wRHrhbVA0JEXSZWAMxqiJO/j3Mavye99uR/?=
 =?us-ascii?Q?BPFSuhPtzJWmxzE4humn3PjsVqSZEUi/uNThDBXdZKMkL3cLsaHAEsSBWqDV?=
 =?us-ascii?Q?yuiU7nPuopqVfGQSxGwNBt+33ZL2uTsV75zW6jy7N9y1WP8IS38W/6Gd9bTl?=
 =?us-ascii?Q?i9ixWajFHKbSB5JVbFhuJxGKmqqfzq7wFnJyDHaUvAFpzcuohNLMFmXwP7DY?=
 =?us-ascii?Q?1u30cSDfSjrDDHubb1IE+hg8AIZeC/m58OZVVm74yJiGZm6687zPgYI68jtx?=
 =?us-ascii?Q?rFJJZOOqdjp2lf2wlXUMqc68dg13cGMyXfhgvIc8tDEcfDLfi6+Vv65giuzi?=
 =?us-ascii?Q?V/ZXSldLImQ1Up/5LGRYEjJM4aNXVqMY6yUumfu6NIAFVAzKv9IHDy0nL6at?=
 =?us-ascii?Q?2xwYW9vADzdfgg4BH1xR4k7jtSInWiV+mHDuAZsSTNsJ5ZAKPWJDlCbCC6Ga?=
 =?us-ascii?Q?kkHcIkRCYHiyFlKsSXrGOMP/nJ5NsEEZf5AfOJjEa6fFVexIu2yGUO7EWfjE?=
 =?us-ascii?Q?nVFAbxbhIIfB2LbbS4mX5GlM7zqKtR7dk3PGelzLSjQAKZeJmdGGFPzLxCq6?=
 =?us-ascii?Q?i6PHBMKgVQNldsXBmHsLmaEfAbA9vtwMr5wT75Q2Kz0vJ39qUY97g1YDHNyL?=
 =?us-ascii?Q?XdpMo+iidvBd4JQrp6yndPXEw83GpFrnOo6pqoCQ67oVA8PyO66Tmqs8Ue9D?=
 =?us-ascii?Q?tMR8JCzPooUh0P0zyCbBrHhUALD8bx4PLdhKfgVLVzUX51efMXEKw18FkyAW?=
 =?us-ascii?Q?y9eoOLczIESqyZO7Lh2fShV5gD6jSMU5ywKjdf73Z1EWOQwoSwayc/yMwmHI?=
 =?us-ascii?Q?Qt+CGah3iV6Mnoh8kzuunD2HoSKpnr93rBNCgFJXxTSHJR4ZqIaodQfXvJvD?=
 =?us-ascii?Q?tkylu+elhVSnh6mp7TTbt0q4+2p0Vt71iatr+bZpZWzh2nVVhyWvGM3wMIiy?=
 =?us-ascii?Q?BweK79pS2wP7xxTsHuBKhqMJ7/joc3Giy6Vr4KqBKIbIbvpLX4QbbL0Xg1Xk?=
 =?us-ascii?Q?wfTMUIndraFoFmhGCH0+Y8OAfHXYNTwP+TuxIKLTZVoPKBcDsmhpQWiSEhMl?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DN0YWV39I+D8qN1WypY/b6XYgGnj0vflG3hq5+NSwcyhBUhUo/aFZqoLw6MY2YYsnaJj8TT1c5egQn2sFbKaWT9svAA+lwrUVdw3WNgy0qk0wJpAlo2ZCtD3iPDwVOUm7Ct5tKDnbgbmOxQOMLadIq/P2/IwpS7vxJqQ6Nzavd5sgDsXkcj846O4UsPulz0YT3Q9Pzrpf9w4mBSzaMCSW+88hUitouzA0IsvR4jWDYAB7TayMMOtkeMzqWgtk2cr04TW2i2NxzX2qN9oCMG9TOQ8ekdbVlA1N7t3pmO3CtIUN7P9bq/pTSrLIZPRXImnsM9+waS+Xkb1V1uAtcHt4Q2RNarvJ8FlKrIkgfyWlMceGXgICDFez72Q+QpbkM6pVweLepGJ8E5wB9nP4cTFTP05xYDRfVR4dYh3Y1/mX2O2DV1FW75GB4Oxfy/szH/7gY4iHjc3HlrlHzqaQUga7HdkwPIexcHb7nFkr/B+6uWmXXy3eHHBv2vazKKcAg6zEC5m3rGRYLgsuKX10jlKXizS52hrM5clsEZIbchmL+pqpvjMwuQ09Pluu6hTprc5tzQGMeNNAUMz6Pgd5eJpFYiyiprHhgKxMfklFLbcBbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baf2128-aadd-4a32-2b57-08dd04d73a5e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:07:40.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu8UhkcaCJLEPHW9Zkg7Fn568BEN/v0BTyHQdlDwnezF8zHAw/boEcd9SA8EOdLd/ku6+5s34YpHdMGo6TWnSiOW/tgXCGNVJSXHDPaAcAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140142
X-Proofpoint-ORIG-GUID: 9zOWRwQbPzhRKGlYNnXYpHyTis3ou5YH
X-Proofpoint-GUID: 9zOWRwQbPzhRKGlYNnXYpHyTis3ou5YH

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4080ef1579b2413435413988d14ac8c68e4d42c8)
---
 mm/internal.h |  7 +++++++
 mm/mmap.c     | 12 ++++--------
 mm/nommu.c    |  3 +--
 mm/util.c     | 15 +++++++++++++++
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 85ac9c6a1393..16a4a9aece30 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -64,6 +64,13 @@ void page_writeback_init(void);
  */
 int mmap_file(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+void vma_close(struct vm_area_struct *vma);
+
 static inline void *folio_raw_mapping(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
diff --git a/mm/mmap.c b/mm/mmap.c
index bf2f1ca87bef..4bfec4df51c2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -136,8 +136,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
 static void remove_vma(struct vm_area_struct *vma)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -2388,8 +2387,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	new->vm_start = new->vm_end;
 	new->vm_pgoff = 0;
 	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
+	vma_close(new);
 	if (new->vm_file)
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
@@ -2885,8 +2883,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 unmap_and_free_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
@@ -3376,8 +3373,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);
 
 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/nommu.c b/mm/nommu.c
index f09e798a4416..e0428fa57526 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -650,8 +650,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/util.c b/mm/util.c
index 15f1970da665..d3a2877c176f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1121,6 +1121,21 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+void vma_close(struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


