Return-Path: <stable+bounces-135265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC80A988FF
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D2C3BDB29
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E6242D85;
	Wed, 23 Apr 2025 11:57:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3322F763
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409444; cv=fail; b=Z9fvN3F+F3iPxdU17tUZCPU+1CRC2UXgLqVy/bjZ3MIR85hs8J4gn9I8CEOtD59a+tBZ1t4RKrlsqu1iFlI+kUeeNIaKJ4zwrzhXok1wpc/o6QOVrJP5+dQ3HplKNAmGOp1fprhZ+YYbfCnP+mbzhN3TDHCOnyoE0dgwdwljc8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409444; c=relaxed/simple;
	bh=o+xPMUuGqdYnSTVnl7bNO1xL2EkbKf1dzp+gtn5bei8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OvTVD7jsLLsW2Ts6dut9OpD4nDREBUlCFhHVqRQ7Prbj0BAc9b5PEhbG1ILt6KfxC8v3vBQXZ+Y2E4kzqCWxHpX0K5gNb48T4+2ZuTIWSOzu87BP6F3pggmhZYXR+9+0cAZnQ8dxmTOxUnxFs7q+oLr/z/CC3gLb8wRErIvvslk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N5Frhr030266;
	Wed, 23 Apr 2025 11:57:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jh60nxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 11:57:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQFoeo31WN3zlcoUuHrvdb/aiViM8i8fzIKfo+LfU20Gt0WHBAuR2grBXFv6XONqbkZHCo7k0RZA7Oqu3fbtM37bPvrhlZTpsC33Qh/JWs5Q+OcwH6CDdT8W4yiV/WLzdxE3vAm1Dt1nEVmit+PTdgsg3xivgZRZtsLiqYEPrhx91g6BEwNy9J+GscmBGi00oKpG5qAjaww1Y6LImHqg3fOjVTsBqf7txK4EquT+UVV4290Gz004UFkTNPgaXJsMkV/mrQwv7osKnu8l41saBB2mgty7l56p6/VQKdAg/tS0KGelp8G891g0wrIOBA0wZxgC5l620Q/7oYhHWkfVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy454lPyV6PhNqeMvHlp/rUd79Hxfr2BRYXDvpNevHE=;
 b=GVUXKVlrgVM8i4tFhhQ1BEa4JJs2/SZsv2x0BKFOo1fMneKGCCjGU20zwHSCEqf/WJR2NvLJYaXZ40SRqeLRBa/0NMgoKSMbodx5eiMXkrsjVzDz0vgC30/lECoZPTyvQITlU7hmAAw5aDDJVtsT7+ef0UJNokn0E76VbXD0r4ApOZXs8UhgVm6q695aCYF12UngvFmQ3ULN+TGwfnhtsvjIzQRht1Y/ZKn0ZZelS/UYUubder7gRP41HYkPaWPvPwL+XKT7f+++YBOaY95owoZgtZZN07el/VWwgHEKqmaToY5JxYudVX6Q5YfGZm54AnMS0IsA5r7HNvee5zwZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14)
 by DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 11:57:09 +0000
Received: from DM3PR11MB8682.namprd11.prod.outlook.com
 ([fe80::e9e1:623b:ad18:8f8b]) by DM3PR11MB8682.namprd11.prod.outlook.com
 ([fe80::e9e1:623b:ad18:8f8b%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 11:57:09 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, justin.tee@broadcom.com, jsmart2021@gmail.com,
        martin.petersen@oracle.com
Subject: [PATCH 5.15.y] scsi: lpfc: Fix null pointer dereference after failing to issue FLOGI and PLOGI
Date: Wed, 23 Apr 2025 19:56:44 +0800
Message-Id: <20250423115644.1585421-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0202.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::10) To LV8PR11MB8697.namprd11.prod.outlook.com
 (2603:10b6:408:1fe::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8682:EE_|DS0PR11MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c153fa-44ee-4b71-03c8-08dd825df8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?16JEb3vRNEyWdz7qvKWTjGiA0X2EbMwleB3HjWsedWh2KXlMXWY4DEMTf+ub?=
 =?us-ascii?Q?5R/YFZsENe+/x8HZOpBPGfn6g7kNIaIEENZPzknQD8/UNrxxGidPbKlEowu5?=
 =?us-ascii?Q?G4GYLUopHYP4TtCVFEJ27/qDs1i3GRfbhzW4mEuvuW1aYvCAk3t5MYpcJP5j?=
 =?us-ascii?Q?C4D3ZlvQSzrVMBoSQnnh7B7Ptc3NuBqt5WoK8ljnvC+Idsho23gkLLAXz6fH?=
 =?us-ascii?Q?HlU8Q/x0G1JoFHWjjHuEuAz4GpRCKC2HUvdpT8Y4LveMmiJ/mJwjsAn8xoeF?=
 =?us-ascii?Q?iL+xLoGxSGYm/fAKvgP58MN1QIpYfh7p4P5oEQ/CFa6zAU7aRTEuEA11ym16?=
 =?us-ascii?Q?nTOATGbtOVDhQiiWAQX7yyNv5eMp8e0RR6j9cybqEe5z8C/dqaCb206hgAfX?=
 =?us-ascii?Q?SV76ctoumxzYKveeDQaifwjxFvAUoSAkl+6ZB6bRn02OWdGMh0G8M3N/yNfq?=
 =?us-ascii?Q?mCfz68FwjDLYa+wBIbp4nHymD1eN1J+0LuIKluLG9srk2j8d2eHKmfnkpgMU?=
 =?us-ascii?Q?n0or+N/q+MWdT6PnTrqY3V0okfj3lYyei1evP7+Cp+mUQ7Yh8MwKu7wAXyTQ?=
 =?us-ascii?Q?ZHvHkzBmyy9R88YxZIkOTkdLZF6IcJuKNd2DJPaJkIEEPkLFGs1UDy7UybdD?=
 =?us-ascii?Q?sCGepXzxj1drSimRjE5Z4DahHr35hSqfDljdYUI56dMmvEvS1gqAbiynRg2o?=
 =?us-ascii?Q?4ngRT0XfteIKYJcISOOs+Af2bh6TGstyDDHdRMkyJUY50Lzfm0A0CHEQG+Cb?=
 =?us-ascii?Q?qYT6Rr7AFU0VBDaBcU8hxbWUYmVjELyfKb21fPrSYXGrJIsOfNpQQGkqO4JK?=
 =?us-ascii?Q?R840W1kHcazzYdA3VnN223c3ftzXyxpsgylH0HoFam6pn8iZk6AgjfX9fF5/?=
 =?us-ascii?Q?BgmiF5BXuPL6HYKBI7a2rQX1CyC0Eqs1GgiRzR+HR11ea9ZnwfDJgUsj8Tbv?=
 =?us-ascii?Q?gPreP1sLxThbFUaGLfqgIZwnxO5UmBNJa9lxMEagI31kyO0Q7N5bHEkAxLa/?=
 =?us-ascii?Q?QQCMXQhuvh6dRtGfYuFE3mflVXRyRwb16bdIJa3TQe5J1lgx/xVb7/hciE/e?=
 =?us-ascii?Q?sG+RGdr/xTND2DBFwBJrT2qW1tnO+khA19EQOtx4qsvcK3TwhAsgtoYaPRY0?=
 =?us-ascii?Q?NdLorez6zSBmopqXQUhPtOjK6cr0oGy0k7UmvjRtPVOyclTbhHf/PVITY9fE?=
 =?us-ascii?Q?3miIT94yDRkxgBQ7S3RRMSVYBtlyQ0gvZXNxJFFYhMAdevPw5it+cyhpoQlx?=
 =?us-ascii?Q?9653u4wpkmpxgB9/1iRZsKZ7gK79DwhBruHO1ddZ2SyU/JzNgDvyy6vMPHDE?=
 =?us-ascii?Q?8HIyrLI2fjFy4fan+rxGX/xFTgrJUFlroyjn8PI7LEEYc5SmWvqrzR+S78YD?=
 =?us-ascii?Q?A+zSNDYknCfXcS+b4nWaGrLd6CYnuMbtaqmgi7Ij4gr9a4OfsudPCuK7k4q7?=
 =?us-ascii?Q?XNARneogaoXGcPTnXEW3aq89tmcErpun9NNOadYyy2hcDwiG00gsBDKFI6Ka?=
 =?us-ascii?Q?NaXiRh/8cls30ak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uDe6GXRkCoWKHc14tvtdSkmXz6a5+eWX61RhOMs1OzqH0uVY/2S9C9cZYdpm?=
 =?us-ascii?Q?mcUORzU1W79ritaWMsh0w42P8HYaPUP0B/ClUeD8wG+08PT1f4BQWMyE1bbT?=
 =?us-ascii?Q?QXPO5Nc33dmB/zEVKh1uu5lsvFVzQE3TO1SiTYfABzVjhaOjtR3u9U/RnpIv?=
 =?us-ascii?Q?An+VMXQMQ76EiSTiCq0PmiRlECuHdyu227ZK6e1NE8GQZ2TqEL3TF0tVh/Ux?=
 =?us-ascii?Q?HGh/EGLBOf/MapQo898ipvyuh9SLxMCr0kVnFNFySZBJV60Kz7ErZ/noHhqR?=
 =?us-ascii?Q?PfnuOVv0G9vIZP0RzYh666Fwo4qRJ6gvTerUvlW2feA3L0w+lvurCoQauTBu?=
 =?us-ascii?Q?Q/jtKMUa7fYpoLwY5d8hzm5ay1C0q++UZUwsau8GmkCy4pSE3YlEQD1yibR1?=
 =?us-ascii?Q?ZqTheHg1pDBPvQAARAgKPhhFyGPgNVGiNqaeAk+K2gG1Cd2QRhbkXA16cQr1?=
 =?us-ascii?Q?hsxnnUiYPzUAfsHl/BnER7qIO2f0R+5rLG2eiTsZJyfC4s1u3ERFW7nOKZhk?=
 =?us-ascii?Q?Lilx7G2mOfGv5J41aCApdRsNpY9I7dhElxV371CgqTsNG8q4JU3xX9PkkyHO?=
 =?us-ascii?Q?3IwO9EDy/uI28LxiEbjq4bfl0LBJufeZ0x5S2zxbb4LYg/ReE2c3AJYLEyLy?=
 =?us-ascii?Q?T1lAPkWwd/KHWg+4dzhkHfNAxPE8bmy2WRzfgukH37aZ0J5xRWc5D5v+KskE?=
 =?us-ascii?Q?HdXyv2MIb9Infz4MP+8DXO7LSfvaILJIB+FZ74mPAhSFJKf2F1nB/E3zk2vb?=
 =?us-ascii?Q?OR+KCkcwjeE03IYfFFXN1IwQI5/Vh1/kpD6cRffR7UVEksnkOURD4fwBHCI3?=
 =?us-ascii?Q?ow1s7afQAwXzPNmuKoseNdnPh04g5GypehQirdUZg+31v3FGFy1/7kKl1mu7?=
 =?us-ascii?Q?4hVNoRUKq1yd6Ru3W5dLE4RtFheGKcdZz45Bep7mXD3WJNnvHOC+7BRJU1QT?=
 =?us-ascii?Q?e1e0X69RcawxcGH9VuzGt6tnhlhVj4jXa0QUNVaMm1bVpUcXwMrahx5U+uAq?=
 =?us-ascii?Q?C6YT6QmshnRu36PiJoWmnAayGn7/+WImkW3XVBFSZJ0OwGQRWPNWJItmT7Ik?=
 =?us-ascii?Q?PyC4G8QgPcHmi2qdQM5dvDQyvCrrFmcK6asVAWqjo8Nois+MKfTZQeUW9Gch?=
 =?us-ascii?Q?EKVnJ7K+pBKjbPBz9s6G+og3QxBhl9V7ftOaMQqXdBSPIkfXGRkAGEZYkuDD?=
 =?us-ascii?Q?HxX6J4w78a9TjcZNIrk4MTd9gJT3Mo8UWnrGnaCqxMelDQtJR7nCVPVkw8Oq?=
 =?us-ascii?Q?34sa8ukCrN4DrOl+HXLRHQKeQrv99DM7+oiKhOjKykMvSQD0QzxsheHFEgHO?=
 =?us-ascii?Q?8abo+lNkhv0IAL4rdXCl5irOxP4xDomF1KUni2z0kPngyHJPbOjhYY1vNlXv?=
 =?us-ascii?Q?V2ZVfVO2tffKd6YHGiU9zulc9OKNyVKdqmEwocONp1zXBHKJGrKW7Vcv+ojG?=
 =?us-ascii?Q?jCLzWGjMQlX43oJvORMicbLiHBqRkQXOWOPZXRuiM4U1pewEtb8evSnLaCFe?=
 =?us-ascii?Q?Lg3QuGqMDLc4+v55HyoifuCDv0Xw1FJ0NlBvH8QZU5DiACP2Rg1CRQxIYJTu?=
 =?us-ascii?Q?DaLvM1bRvh7HDyohH8sqN3idwTPLpaSe1pi7uRvGBRvDLYZs5epsHCCTcwl2?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c153fa-44ee-4b71-03c8-08dd825df8da
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8697.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 11:57:09.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+9Hv8PtX5XoWiaN1I87OK7UmSvF6CR/U/iXXPEUG1jR+26W3O5jqpOn8yYt3Cvfw1uT3Es1vrCv8aWyFurNBymyQUYaBtvYTKHNfw7z0TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-Proofpoint-GUID: ZjRqV2DRmPD8vGmora9i3CZ52_qkrwOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA4MyBTYWx0ZWRfXwmhzDlKlY3Qi /lVAxmzrKXA+QRIs8xJu1FG9khlkLeGqTf/s8lEcmVdhbtBVRxm9RaoGVbI/OwmdS8IFIVUtZAy HoKOtSlCGa8piTiavH05foV8t97SmOrnSpqoTg6gvS+JI5tjBDK44CrI3fNszAcV8lxqFtZCEGr
 FxTrSBIDtx6MPd7EANA/tQMcd9sIaU7qtn+UT62nQdlx76e2OKfswJ7CxSG8uuTgMwcox7i0Meb PDba2hTlLLJmv9awqmTpJMUoKAcF419lzmJTKV/RzzBPaNHGWhKyZx8LctbMIARVYCP2CwcEGvX 8nkmosrkzz1yIo6sNCmyACdLlTaHdmiLktbysxeqL8hvz8PAb9YBsqNf04/Y7nfQnA+gMnp48oD
 TKNIOTyGOlLkTs74oLvWoYFUK5WZCUOXWTCUwdvc0q+oSYj/98V5TtGxYflPtOMdor7rF+wC
X-Authority-Analysis: v=2.4 cv=Lu+Symdc c=1 sm=1 tr=0 ts=6808d597 cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=aph6twYUapQikGelqccA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ZjRqV2DRmPD8vGmora9i3CZ52_qkrwOj
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_07,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504230083

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 577a942df3de2666f6947bdd3a5c9e8d30073424 ]

If lpfc_issue_els_flogi() fails and returns non-zero status, the node
reference count is decremented to trigger the release of the nodelist
structure. However, if there is a prior registration or dev-loss-evt work
pending, the node may be released prematurely.  When dev-loss-evt
completes, the released node is referenced causing a use-after-free null
pointer dereference.

Similarly, when processing non-zero ELS PLOGI completion status in
lpfc_cmpl_els_plogi(), the ndlp flags are checked for a transport
registration before triggering node removal.  If dev-loss-evt work is
pending, the node may be released prematurely and a subsequent call to
lpfc_dev_loss_tmo_handler() results in a use after free ndlp dereference.

Add test for pending dev-loss before decrementing the node reference count
for FLOGI, PLOGI, PRLI, and ADISC handling.

Link: https://lore.kernel.org/r/20220412222008.126521-9-jsmart2021@gmail.com
Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/scsi/lpfc/lpfc_els.c | 51 +++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 5f44a0763f37..134d56bd00da 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1517,10 +1517,13 @@ lpfc_initial_flogi(struct lpfc_vport *vport)
 	}
 
 	if (lpfc_issue_els_flogi(vport, ndlp, 0)) {
-		/* This decrement of reference count to node shall kick off
-		 * the release of the node.
+		/* A node reference should be retained while registered with a
+		 * transport or dev-loss-evt work is pending.
+		 * Otherwise, decrement node reference to trigger release.
 		 */
-		lpfc_nlp_put(ndlp);
+		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
+		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			lpfc_nlp_put(ndlp);
 		return 0;
 	}
 	return 1;
@@ -1563,10 +1566,13 @@ lpfc_initial_fdisc(struct lpfc_vport *vport)
 	}
 
 	if (lpfc_issue_els_fdisc(vport, ndlp, 0)) {
-		/* decrement node reference count to trigger the release of
-		 * the node.
+		/* A node reference should be retained while registered with a
+		 * transport or dev-loss-evt work is pending.
+		 * Otherwise, decrement node reference to trigger release.
 		 */
-		lpfc_nlp_put(ndlp);
+		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
+		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			lpfc_nlp_put(ndlp);
 		return 0;
 	}
 	return 1;
@@ -1967,6 +1973,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_dmabuf *prsp;
 	int disc;
 	struct serv_parm *sp = NULL;
+	bool release_node = false;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2047,19 +2054,21 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			spin_unlock_irq(&ndlp->lock);
 			goto out;
 		}
-		spin_unlock_irq(&ndlp->lock);
 
 		/* No PLOGI collision and the node is not registered with the
 		 * scsi or nvme transport. It is no longer an active node. Just
 		 * start the device remove process.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+				release_node = true;
+		}
+		spin_unlock_irq(&ndlp->lock);
+
+		if (release_node)
 			lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 						NLP_EVT_DEVICE_RM);
-		}
 	} else {
 		/* Good status, call state machine */
 		prsp = list_entry(((struct lpfc_dmabuf *)
@@ -2269,6 +2278,7 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp;
 	char *mode;
 	u32 loglevel;
+	bool release_node = false;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2335,14 +2345,18 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * it is no longer an active node.  Otherwise devloss
 		 * handles the final cleanup.
 		 */
+		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
 		    !ndlp->fc4_prli_sent) {
-			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+				release_node = true;
+		}
+		spin_unlock_irq(&ndlp->lock);
+
+		if (release_node)
 			lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 						NLP_EVT_DEVICE_RM);
-		}
 	} else {
 		/* Good status, call state machine.  However, if another
 		 * PRLI is outstanding, don't call the state machine
@@ -2713,6 +2727,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp;
 	int  disc;
+	bool release_node = false;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2771,13 +2786,17 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * transport, it is no longer an active node. Otherwise
 		 * devloss handles the final cleanup.
 		 */
+		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+				release_node = true;
+		}
+		spin_unlock_irq(&ndlp->lock);
+
+		if (release_node)
 			lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 						NLP_EVT_DEVICE_RM);
-		}
 	} else
 		/* Good status, call state machine */
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
-- 
2.34.1


