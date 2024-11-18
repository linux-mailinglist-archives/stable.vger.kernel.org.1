Return-Path: <stable+bounces-93766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A569D0948
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 07:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147F1B21EFB
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 06:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C513E02A;
	Mon, 18 Nov 2024 06:06:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE617FE
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910005; cv=fail; b=a7jzqXEMVRCR2NmVm2dq+c7FYII+FhX+o0U5ay0k9G197TFOHp7D7scd90Hj4jxkwwXcpI9VTBrhEE4EJMqRhLTZ4bS2zSEPRQT/ZyYHJGDnCzF2intoz5eOGnj/f32WrEwAceZVU803KdSM/B5JC/Djaj6hWnWjd204Vh0nkcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910005; c=relaxed/simple;
	bh=/+uJKN/22zjrvAk6vqGzMk4T/azcMsKyPjn8j2GvRqs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BPkW3rszkOjc8HSYCjlEZLFIfSUNU2IE2EkVA0T/UIosPuvbKkaNEZiPfxAc7lHj0OLEBz7oaFQQV3Q/9jl1o9ivyFMBzU244VGqcEyEWsc4NMhRIWeW16Dg27W0qdUIvo+oYnqeJgbeton5A5PUUlPssvMGxCcHCTfhZeWiMqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI5eWek011595;
	Mon, 18 Nov 2024 06:06:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc89cv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 06:06:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz0KZ80K+93NT5LHak7YkVdC0bCIWNsQeU6XHqVu9x5Ory3uRhR6vI908CHQ2JDS9LwYMcYkwm5/MkZ0o89zcCa9hTdNvmzRFm42xX+tPXv/6olP8wA1XxpFejCBkRGnWXHZ9+N/8mxtKKo/zU/5GL7+zkZe1NK1ohVdg7xfn8j6O318VL3t0X2nA/ObsWZmf/ph7LdUF5lSUQDc6Vck0aTW+X4hol0c8PjIPFoR4sHRyCepQ4AMaImhhXagzpH5FV162JsVcQ5J+iA0IYDmj33jqTJ4EQe7fSmIJczF26AoUQFuQ306n+SWG6uAwIJiyPsL4hREhfXxSEjCt7w7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjxK2FV2ufmhqZXTgu8NzfOhbdluljPAZ6UGt64uYCQ=;
 b=EeMoqH1GEEjtW9BeCBlwnD9BlwZe9A9atIOlS7Sot2AuSlCWLDelqCFJq9N71ydvfJQmUbD7xxtwmUyKIZaVPGBEHZAESX0V8Yps/AxLKeq2fJo+hwIXEJeXbpQXMB5N45FnzOTQTKKMcy1KMEKnU4rcvvdEf9CjPmQqxEIPIV33qBxMD7GGnX+s6hVSeAMwqgHbS6Iyk3tgJtvB7rwgUJvPaQVrFVfhyDNDiq8JORY6gduo9Gq1CCJNwXdKCFIf4rZDWy24FhTEvu/+z+OgqX358M3Wl9GfIWh1Ghfe0XVmCNyDiMEuX5T8GdrdQWxLxbPTc/euwh4KGyz+noDHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 06:06:23 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 06:06:23 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: andre.werner@systec-electronic.com, andrew@lunn.ch,
        gregkh@linuxfoundation.org
Cc: xiangyu.chen@aol.com, stable@vger.kernel.org
Subject: [PATCH 6.1.y] net: phy: phy_device: Prevent nullptr exceptions on ISR
Date: Mon, 18 Nov 2024 14:06:25 +0800
Message-ID: <20241118060625.937010-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0044.apcprd06.prod.outlook.com
 (2603:1096:404:2e::32) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CO1PR11MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9593fc-ee4f-4c0f-6fb7-08dd07972100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LcbV3yjZP5A+vP8UD7+6fPfqrft+LpFV8ZFNfT02Xl8/BNqHsu3dVlBj21AS?=
 =?us-ascii?Q?6dtNTWa0JBRRWTbS5nXhGv+Mqz+rgZUg3LNhfxj4yZuALCAijugaM0128cw9?=
 =?us-ascii?Q?UxAcpeMa4B/g8422qezCdqDKruy8CEcpHGff0Mx/+s5VgNBYBPSUrof+Rovp?=
 =?us-ascii?Q?GU/cFNqlx4nWE8HGyLNPQLSV1QUcLPjOG8kjUxz7ZedT4qkjKGXk68x9vxIf?=
 =?us-ascii?Q?hsOvP9Ccid3t68uT/wOHdW13f0hKLotCQb7ddgXxHAUhS87dU+1Ocvmt2vOl?=
 =?us-ascii?Q?x8WpE6OoA5MgjZrHnUyMa4dQdu2rnW97BVfWKr7YVvl7RUA+ATqHis5/UQrA?=
 =?us-ascii?Q?Sg1amBkKmQYs3yeKLrep43J4l60UYqw0Ehn1/ZcJwd/l6KZToVQbbc+bf97y?=
 =?us-ascii?Q?DJjyDEbKIb0Mw4sjPGy8V8D9bTH11MaBCQCPFHILW3F52fdHuf1VR1jXiQNS?=
 =?us-ascii?Q?oknWL5rrk7efn7WL7oOwhj/8/LG20LAfAd2Qrlb0YyWM2mVUx2gPLeVSNt3m?=
 =?us-ascii?Q?3Bf9+Q5CMCkvh4814Ak1nH5xt2J49OFA0Kga7g1aPdSJL56vz5vC5QtlCzu1?=
 =?us-ascii?Q?nxmDzIoycp2tjqBz+iwEKtkrrg3gCLABG7HUYaGhDpUXVVeKGB9nInpkWDc0?=
 =?us-ascii?Q?3kSnT/X5R6ntAVL3ARQKEFmjowYgTvOPWrvymXKooFE4FtgVPEoh2R7wOVyi?=
 =?us-ascii?Q?9mB1BEJk38demNzKn+i1ybiJC+8CtywHPlEWG3qz1SZJ34pM9Dw5SBdW5etd?=
 =?us-ascii?Q?ZTKYa7hhAsWQukjPZcOVwV7o9f9FVBmWrZR3z599oTVFtTBDHGxblNBXxXtQ?=
 =?us-ascii?Q?oV4sXoYfaMxwb9BLiv2nsp2sYG1JnUTvDwX391l1ejP9dWLpFNIB45ollC0i?=
 =?us-ascii?Q?gZnJy5a6wdXieJYM01JwBv+eOk4sWV7ND/PUsw21R+uENDpEz8HzYHkjf3XG?=
 =?us-ascii?Q?0jf73dpkvH+tDKg2PADJHm6UhxhxnO7NSSdtOjZnyVgZELQi+r7/Elu7NzXU?=
 =?us-ascii?Q?d+ZR9p0YA2gp+dS7utOavvDwJRcMnRiapBRu37TNojCsd0xfJE7zxX/coMrL?=
 =?us-ascii?Q?s/p9ltMIf5tOTp6Z6VA4ppfNNErPgF56OEztaqbTnjuReILx7cLChu5RziLY?=
 =?us-ascii?Q?xssMiQzj17MUG4O+w57C3V7be1+gvrnAn3xmABWRKngKlLpCh5iz/HF5XBzD?=
 =?us-ascii?Q?lmx+2TSZkU1HPNlmxZtT9aFLHXauYMEJWJ/oMOqOOalsZtULOP086ZIPvHUy?=
 =?us-ascii?Q?QPe6WiwiI5eOk8jB9zapE3S38Fv4uSVjoVCyZpRTxdOHptN3yauLg0Q2S21h?=
 =?us-ascii?Q?e/R+t3OfQCcpQ6stFayQU6kV6NpBd/2wROBL9A5QI0UyNGmyozNuN6NP6+Oe?=
 =?us-ascii?Q?upQnyC6Lp3Ixv0ZnYeolK+wRHfao?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fk3G+FmQfDfUjP0LbctSZlqxl+MBMBrOrFMl7s8eUv1x8rM0YdFlPedOLUiN?=
 =?us-ascii?Q?qdlygvsOWN7K+F6gdpSUhdf2qDaanKhiOyU1zqeGPhgRPjTtzgUcJdBUs3mm?=
 =?us-ascii?Q?zjtwvSdWE3qW1oEFI/MbY9Zo9eIsOAg/LH/TruWaomJcq7FIUxu1Wku66BRk?=
 =?us-ascii?Q?LZSX2IInemCfzxFbyXMiq0IdbJ8/RtLUp/gBCLaW14BexDWo0kxfWzqHbogT?=
 =?us-ascii?Q?tjLSYtvB1L+jtYNdKVhySYnZKDXo9YbwOGNR6VZdDkeEQsaUWSl+uYcXjr/u?=
 =?us-ascii?Q?dupSa3JfJafvta+DNWgTdMzDUKLWR5NaJRY1ldUUgI7i3WVCoKpeYOmBLu7Z?=
 =?us-ascii?Q?RnMYJzm6iEyIRUuthrBm/VGcETW6dWa82LlMAxF9WMmWqOVWxLikG14YVge9?=
 =?us-ascii?Q?zJqvud0TZQCmsOPYHL7jp/Ghb50YMON4aFcQEAQeRSEJE9XLLTD53j9RXffm?=
 =?us-ascii?Q?9PCuGYwSWn0x6BQpwS1U8xoCPX23cGJsYUVHaK32cf10W5E9H8l68qbttC2O?=
 =?us-ascii?Q?5miZDJOLlVO7hAO3kTefgBHoP8dMnfTuJQ/sTTAedt1xj4jlc32J07JInoEt?=
 =?us-ascii?Q?APfxnb77qCl59NVDslMHsHtMM34FJMBC5BD3Xw2X3D80637go+Mjwt0r1/G4?=
 =?us-ascii?Q?EfuRBm60krKvVy3e9MNkVoidmXxcuiEGYrQPBtS3/4uQkEV5E8ncG8txl1Or?=
 =?us-ascii?Q?xuscjvhSaVRQLpnEhhGV4N4U5PQW/BI7KALJKA0fx1XxjWgMHSoTqxK+If9i?=
 =?us-ascii?Q?oJjHZb9FiSkTLCvqK9ccrQqSIiiYtzFqS9bLhzs6Nac7u58g+Kq7xSuoyXy2?=
 =?us-ascii?Q?NG8PLIit6nYpLm+Aikg5PULHgkuS3MXIruQU8NLPNws8hRP1W5QeOoF5qB3a?=
 =?us-ascii?Q?d+PYnNoDrL08/pSla3q8c8frC8D8RRF3lWOB5nqb5GYlOdIC8AzMLd6U1biR?=
 =?us-ascii?Q?3BaFnLKq43/EbAZf7hWPNULFi6Is4cSyLLVTvJhZqzKifYzajNGJNCci+Uau?=
 =?us-ascii?Q?WwUXocQDiIWbqfFcEOvprPUEd6THuh5xMEAazk/zhA+kz98b7TL2VGAChzpE?=
 =?us-ascii?Q?kp+Eu/XEIlfRMOvBxaVkZdCYxlVO91dUue+1d8/ymm7qgmtenIagXQNTgsmF?=
 =?us-ascii?Q?IGGhdL2NWwP2uVmtC+7dEbgF4mQA6dfa70dXGaScnsYy2LeSYJ/O3e+g5SnH?=
 =?us-ascii?Q?lbRQ54ONGVts5FHiEanl6WzMYK+Is07cHAIs0uCM793x1SUn0xtHac4WerRz?=
 =?us-ascii?Q?VBc2R8dPqS7ok6h8lF49N1cyhD1jVZs9Mr/CBflRv7CP1BTUtON9QqVq2+t0?=
 =?us-ascii?Q?9TTAzhqvwhkdGjOzYJRz3zqIvN49yUOgAkmxZnLMfHdDqdnxLpYI1QJVZDHa?=
 =?us-ascii?Q?VfUWUQfUIYcrw/Zuw4elSyxlrRwoQmClE1FKMli1XpLbA0UsAS3nckb4wVgB?=
 =?us-ascii?Q?Q0TCziEXbesdvRcV7kifsazuhgNf8T2D+Cc2PBfrXH5nupt+7J7xDJXkbkBj?=
 =?us-ascii?Q?sWGrlZ4tKnmxynlf0HSV6y+I1P/MOk1gQMUxMJIM7sGCyl85Qnaz7flR4lJH?=
 =?us-ascii?Q?gGy+pyz2MnqcT02H8tOKRPPx2tCGf5hZVFdoGPjjii5meNma1EyLPQYmSkaO?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9593fc-ee4f-4c0f-6fb7-08dd07972100
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:06:23.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z59ycVXvNQUNz0MEWu2Bxu1VJxSSDDbnoZ+TzkhyU4ED7rIic1+aTV8qczp6I0GYKXvWB4NDJdzSWHvRlgiveW4Hq/48tXrhMs0OstJdRks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
X-Proofpoint-GUID: rKSZlgk4FjdQpDSuf0BYm85ipcStgP9b
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673ad964 cx=c_pps a=F+2k2gSOfOtDHduSTNWrfg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=rSCAxNCNAAAA:8 a=t7CeM3EgAAAA:8 a=-MB37Cf_dW2RCP4BnbQA:9 a=5Ne0ADHCvXQD7w03ko0Y:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: rKSZlgk4FjdQpDSuf0BYm85ipcStgP9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_02,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411180050

From: Andre Werner <andre.werner@systec-electronic.com>

[ Upstream commit 61c81872815f46006982bb80460c0c80a949b35b ]

If phydev->irq is set unconditionally, check
for valid interrupt handler or fall back to polling mode to prevent
nullptr exceptions in interrupt service routine.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240129135734.18975-2-andre.werner@systec-electronic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/net/phy/phy_device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f25b0d338ca8..b165f92db51c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1378,6 +1378,11 @@ int phy_sfp_probe(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_sfp_probe);
 
+static bool phy_drv_supports_irq(struct phy_driver *phydrv)
+{
+	return phydrv->config_intr && phydrv->handle_interrupt;
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1487,6 +1492,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phydev->interrupts = PHY_INTERRUPT_DISABLED;
 
+	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
+		phydev->irq = PHY_POLL;
+
 	/* Port is set to PORT_TP by default and the actual PHY driver will set
 	 * it to different value depending on the PHY configuration. If we have
 	 * the generic PHY driver we can't figure it out, thus set the old
@@ -2926,11 +2934,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 }
 EXPORT_SYMBOL(phy_get_internal_delay);
 
-static bool phy_drv_supports_irq(struct phy_driver *phydrv)
-{
-	return phydrv->config_intr && phydrv->handle_interrupt;
-}
-
 /**
  * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
  * @fwnode: pointer to the mdio_device's fwnode
-- 
2.43.0


