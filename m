Return-Path: <stable+bounces-222392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB1CGGSwo2lZKAUAu9opvQ
	(envelope-from <stable+bounces-222392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:20:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F0E1CE66D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 061523037D48
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E15430B50C;
	Sun,  1 Mar 2026 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="OdN4lo3Y"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AD1F91D6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332582; cv=fail; b=rrw6BT6905IcHwexzyEctixZNaQkON8/RGwXmgYPjIIyF/nBNq6CXKMbfdjRUh8HNVb3ct8dn3x6ScU2UfOdK187F1ufRTjM0BN3ugrbta2fljF/1LbBwHe76Y5L7cjlyHBnrlbfJeLEebFMpz0Rk7ahEBPe4XZUsfl3GDIhdMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332582; c=relaxed/simple;
	bh=kTSPNDWYvnJL6CTDQxAcSsOBRHmbg7hRG3+7gfqPaR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/TBxozsP1L+2sXOxexPjJaZETikd00gasoxQLZY1/WuP7Q+Xs4P+ooVRI2iHsvDleS+Rk1IHmdOcnoQI597GVIm6K+vqTTOqwvtkblRZGAaXzbdiiZqeN+RAfcY/l/eZNM2KwlTL72pWhnJkbSLjsPWmXaLfkGJFDwtGl0OfGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=OdN4lo3Y; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SNt1XB2748973;
	Sat, 28 Feb 2026 18:35:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DZLYIeQk3k6us2OYyD96gRLlywsfwdttRgn70BL/YWY=; b=
	OdN4lo3YRjohv//fnWcPzUgEMSsjWB1EXfXnIMBYK73Cw6Shu4c6Zx9oCvlTP70Y
	2WpKDgLhj/nI+n4/9RYqv+3R9nNHNlm0Z6pEpn1u9rFFSmkpdhTeVVfy6nlK8Mvw
	zh3wFXZ5WrkMHYro5uViAe0FaXmRCdXAJAcbPCKHV1YrtQalU6z8nlpTcGcJBbci
	j76DtMc+oc1VujHOQRtb1aBT9XSdd16PXdeB3+QcD3s7a6co5fvxZheu4SosFshu
	NIG+uwD/DhkYtHZz3YCuDTJ+CmjsMhxdxvkxvANTFYgInJpyATfTjNRAo9K56tAL
	CmKrYVcdIrtHijCBPvLBWQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cm0rggn41-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 18:35:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihP8EZ/ZrQxqzfZJxic4axaRV+fIqlWRQW6+ncjHsPyrEuCLgwvTqdTesZ5iI+8xsCVVsCdSHhbtSICSomaO5FRBDAGVK3SpQVgHLe5OMnMLkBieo/VndOYXpHkjQ6uwH+6WrglSRWq1bKqaKziTuhiTfrIZox3fdRulHUfUbdTh0oyMh1QjkldVa0WFN8Sb4NsIu0k15mM7OwNGaCAQ5OBy32U8gOx+Er3b8YciGBp+p6WWLq/YYu8SPJ3OhtQ7M5c0EX4HeAnkkVHM+ctZ4R7ef2xmL4OVhjHdKEbgt7HoiW2rLZYY2eDP7M29DYlSY2e2WDyrIHSxodoKG5452Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZLYIeQk3k6us2OYyD96gRLlywsfwdttRgn70BL/YWY=;
 b=Tc6EK6DqiTFch3jj2fe0SFKaZKv7nEXcLItJnk9R30Wh5/q8NdbJPq7qa6LhgVPPoDFD51f0H7lpwI8YTNIltnyj7B4cNLp9HzmcI1EsiUnk4R3fSPOl8CPWQmdQM0edy8huAiOcUVl4d+AW3xbnSM/pdjUCIKoRDHi/0UMUH85HEjAJxsISGGXXjPmCyRcVxKnW3bpj51kCFJEmyZKd5XySy+a8VmHyJBDywhXz39y5jH8anNzNyHxH7y4ECshhUkM3bwQuGsj4YYAlAaABRSYGt/bxVC6HkZntWPMFyfyp53R+B8GVSkSrNhYEHzgj0EBW40Jfdz7sarR+v61n7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by SN7PR11MB6874.namprd11.prod.outlook.com
 (2603:10b6:806:2a5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sun, 1 Mar
 2026 02:35:56 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669%2]) with mapi id 15.20.9654.014; Sun, 1 Mar 2026
 02:35:56 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: sashal@kernel.org, stable@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, hverkuil+cisco@kernel.org,
        Xiaolei.Wang@windriver.com
Subject: [PATCH linux-6.1.y] media: i2c: ov5647: use our own mutex for the ctrl lock
Date: Sun,  1 Mar 2026 10:35:34 +0800
Message-ID: <20260301023535.2438766-3-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301023535.2438766-1-xiaolei.wang@windriver.com>
References: <20260301023535.2438766-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0038.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::6) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|SN7PR11MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c9a851-c4f9-4c14-da28-08de773b43fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	0pR1hLGwhzVqwAvuEt4GcMhX1iY0lak+jnMndKS806OiFhNDBdAZ7gO/RPRJqfbl6tO/48rh/CBtxWADBXKEmzkJ9dd5a8uKjVsg/YF+DcrXszl2oVpQ4rxunrs4HvtFRkjVw1ARZiRDJlZl2a3qmsFyPW6HDFa7O4KimfMVMEOlcoTyQwRQ33QkkFRUZTl4R0F7pXVCdZYhxA8eTW/lhp3lftgVJGX2ukGhn3T4fiQjWXeAl5msvBxQK7UHOXCrkfscx2fQ9opE93y09YkI1Pda/3r6GWLeJHpwR99y65LikeE6tVUOBMVy4eLtyoFf6xfdblegQmcz9+gB4e9NyGgRMYhQObqkZGpebf+ZTZQWV5s6u+ZWAQDefvul1IImBwKOMWmpkkv+BeMzeGTHVob2jUzGuPxo1E0EOIFVLDrBueTna3W0qnmLyz6KWGllTB6kUHsUvedNc2rXO1V47BEpREy699yi37dfpyh1vVF1s6lc4Ke9PjVnIQkujX3xb5Rk4FbtxgGLFEVMd/UIDQ3E0E8fQb/hG3wt3sOrQkp8zSZFDRLePHlNTY1H0tGwjDGg4oi/gwO8ZsfTsh+k/sRSYnda5gDsux+gADHH8SDNcoHj0YUEPAAEAgXebvqQSRCVFukKPWUWTCrwNi1hGQmguJVUz2pAhlgMmZ+UEOvZDHmGrL9SUKjsVQEwZehhroToqdo8rB2k7JggkwPgCD9DZPMn3vAOncApXDNbP1s2biHHIqFR8WPM+BJgvM5chaKnv7KAlVK5pW73txBRB3vE8KYneRNRfZRwbSsauhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBdwNq4qAGencOrfGfIAvsquqlQx5pl+ZWk1X+xCAG/QifRLbyn7FESjOnBz?=
 =?us-ascii?Q?8fyt+8HJJ3VIjY9gz+EhWac7rrZ70M8/0d9S1dkqO9aDl4kBaj8WGwj4kneF?=
 =?us-ascii?Q?3zbkoq5r8bbuPQIVGu09dMbysT2zY7aeDxL+3yuzsCThb4qR7diBRDkHOvXZ?=
 =?us-ascii?Q?Ln5bD9lft3WDUOLbg2iPiQO6wlHuDhso8sKxvuwlHZ9UgZB8AvOr3BurVhA3?=
 =?us-ascii?Q?SPLM4991nYjDmACMKz6kAzoiJ1jcU/J9eKRBK/UGgfWy+Cymg93pqgkFfxCa?=
 =?us-ascii?Q?VnRriF2JKJxc1aapuaeHEuO5wFK6w2vqBlNFe4Mqii2vJA7FkKWmhP0wVuCU?=
 =?us-ascii?Q?eckwDG30T4w7xIWyYmd5hAUeT/Uymmlgn15JNavev9X3ObXlYUajCTKLsv9I?=
 =?us-ascii?Q?Qj5e01d4/7aMQv50SAgnan6indxKnizpSCD9nbGam2LNbP6ZJJJqME6eiEHZ?=
 =?us-ascii?Q?EG5w4zgGJViKzwkooAc9jM/W7XXpvCCuOnexR7soc95ZEnWhvKc2679uF4Zh?=
 =?us-ascii?Q?LDzOKuj19UsrLo5r0EVcbWJT50ki2BjGXpNQ8c5RU0TK2KkReHN8q4aqIFaC?=
 =?us-ascii?Q?AxotEDnm0SMbj//fsOpchLUheiaRtS6sInXEoux4fFaJ4Qx2nd3G0GET7/02?=
 =?us-ascii?Q?QkeTRipl1NicSh/r6z80VjXZrhVuHC8GXcr6wqcuCyLSEF+ufph5pwWkU67u?=
 =?us-ascii?Q?fhLx4ArLIMTRFWGu7CneoQYZW4McMj0o0SUrRnLWKUqPSkDeHFcoJaQsaFUt?=
 =?us-ascii?Q?JDhJ108KM4C2J1iF6DQVNVDMiv+oT60Tfmah9u/FrOncYOFfy2hqJjWFhi7x?=
 =?us-ascii?Q?SPhRA+bK+agfq/bQaIZ9obTTS0VlVw2kSPNvCIeucfVI4xjSFI5ELJFJvdJW?=
 =?us-ascii?Q?QkrHCIT79CtodLL0mMK82DIKzJrFthc42Z4l069KJZg93PAFNUGKbaF9lzYV?=
 =?us-ascii?Q?hRn927ozX8nfJy+sSj7oZ/niBoyttap+f3u3XPNx0VM+OryTjmNpcWrEpfBw?=
 =?us-ascii?Q?09reA2rWhtmqto/1VySK8LTRSyIn1oC5LkGPuAoseUfX/at9ZJ26EK/eGey3?=
 =?us-ascii?Q?gk+7DkhXfG/GDj39SRORPuE8ZltzfdWZfpWkAKVvL5+peTiz9MBxTFTrYUzu?=
 =?us-ascii?Q?rhFBpj2RsU9zRrsnWk6IA/qEPyK5ST27aea2h4LOrvNZBc/Xhqtv6KL2Do47?=
 =?us-ascii?Q?K2HvncWltGwxPlEjFX0StQousjMWCw0NB1Xe1QFWiN1A0sMK8VSwzH7IlIwa?=
 =?us-ascii?Q?Pigh3mv82sdISvAll3iQW1MP6iidJzZswZpSV3+OplBsVAMmLUFi7mAGDZZn?=
 =?us-ascii?Q?Mc62Ns8O9naUEfvkTXJVhKfbb7eYlTDoSvy2Q/23x6q2idEaRrdXOS5loAJb?=
 =?us-ascii?Q?inut2ntEETJKz98S0BZvuf+efrFPmZ4NIH7ans+njVX3oDjsImgMock/9HJK?=
 =?us-ascii?Q?GdrdjqHW1+LqDxnwHoHx9GxkISEx4+YV4vLYyJok/bT6UH1AF1CNLiVnht1L?=
 =?us-ascii?Q?ba6/p/ubIOgEPj9c/C8VMUdcMEfX4GDesGcXRieg7+9YHsFiaLmARQU4Cktw?=
 =?us-ascii?Q?fQmZcZ2J8a85uDwaRivEqoySNLHURz63VsNc1BUmR2jNO2IlFUB9s3cIUS5B?=
 =?us-ascii?Q?v7UZYmYK0LjwoC79pFuq2nT7BrVSQJeC5sGDIiomEgQh8A5/EAQHHcINYQUv?=
 =?us-ascii?Q?AXuetbVam39olv9aSXIbi5ka5kNrEbix6T1w1eitbiwyOnrDnNIppuGoAdxr?=
 =?us-ascii?Q?oBG3aglNIjk572vbIMj54XM49gpGvdI=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c9a851-c4f9-4c14-da28-08de773b43fa
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 02:35:56.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU2G1Pnhj4eNdRx4BdtOYpKKTHFxyXaX7n9pOae3S0myU5iqLenmsGfU679yzBw4Omw4wemmUel1qY3fX+UKIXU0GYEh0DH8fb4EVznNSQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-Proofpoint-GUID: Z2h3MEkxviAjdHcNSzsHVQ2Jb8IIY_bR
X-Authority-Analysis: v=2.4 cv=Of+VzxTY c=1 sm=1 tr=0 ts=69a3a60e cx=c_pps
 a=4Gx/Bq66bxzCWlClXrtOjA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=wk0Ph_KwOMu3z5TwrfMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Z2h3MEkxviAjdHcNSzsHVQ2Jb8IIY_bR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDAyMCBTYWx0ZWRfX7Wz2oRK2E/QO
 +clEfERTQM/PxjUZeY340vNlVAZHSidNRNwd68G5ORk0jLFgRp8QLS/TQjZqWOzmlj0lWKCHwKm
 3Fgmqx6OP9LiguTUe3UJr4g99SmDQwcgeL17tr4Ohnek3Rr6CV78KjzAax+zyM0RKsIBSq/NDH5
 uMdj4tNhpEpNTdgLiM2rMBBDwZKxsnU1RNujNqNc8DZh+HVr+FA7Wt2cCyl1QAYmoEY/AH0GEOz
 fWYsmPQxCCumhHUAVAlAR1ExwN3w250iYBIQllnf6pLMZvaAoB7IZlR3KC4dYsmLGixaGUS02c2
 nDbsrhhoYnZsYZy7CjTm4webPCYuj8lCy7IKx96Hd9WCJBobLNtCZ2mSISqQBQnBOeTwuE/vADn
 dj6zBWsyLX21BGgQE1PNTgrz1rw+PXy9N5N3he8DE8uRhXO2LuQ+PNcKTr7tJ/AS8x6ZkLyYf8e
 xmVBRxRPcPT26YrEtaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222392-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaolei.wang@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:mid,windriver.com:dkim,windriver.com:email];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09F0E1CE66D
X-Rspamd-Action: no action

[ Upstream commit 973e42fd5d2b397bff34f0c249014902dbf65912 ]

__v4l2_ctrl_handler_setup() and __v4l2_ctrl_modify_range() contains an
assertion to verify that the v4l2_ctrl_handler::lock is held, as it should
only be called when the lock has already been acquired. Therefore use our
own mutex for the ctrl lock, otherwise a warning will be reported.

Fixes: 4974c2f19fd8 ("media: ov5647: Support gain, exposure and AWB controls")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
[Sakari Ailus: Fix a minor conflict.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/i2c/ov5647.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 847a7bbb69c5..cf8a84fa3100 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1272,6 +1272,8 @@ static int ov5647_init_controls(struct ov5647 *sensor)
 
 	v4l2_ctrl_handler_init(&sensor->ctrls, 8);
 
+	sensor->ctrls.lock = &sensor->lock;
+
 	v4l2_ctrl_new_std(&sensor->ctrls, &ov5647_ctrl_ops,
 			  V4L2_CID_AUTOGAIN, 0, 1, 1, 0);
 
-- 
2.49.0


