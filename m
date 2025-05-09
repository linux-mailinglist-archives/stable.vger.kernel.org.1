Return-Path: <stable+bounces-142970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B1AAB0A6D
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9693A794C
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77E26A1D5;
	Fri,  9 May 2025 06:18:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC78202C5C
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771487; cv=fail; b=Q/wRZ1GJ2MqWYspCTEOygEGbAWdVIGJGlzDl5ddI8jfEicv9TbHxFMY1Dg1TVTPi+8M0hnfA2Vw6/iOitKjWbf1Xc2R0fps2Fv3dvP2537cDxnj4IX2xKr3EfieVMdCYMI5s+Fzt40xZhX/QrvXbchB3uPpOqyrBCdiBMMvND8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771487; c=relaxed/simple;
	bh=HHqyhye5GjyMbvaeGp46zn5xlF4QhWFgXk8Yc6KGT+s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U0z3wy8wERA7hAGh7VnGervqmFQzKsib7FvzsZhUDVdQl3jyDHRNv4LMNukyBKjDvmXbnS9cB7MaLqkAr/WqavPdiQZe6cHoi3mUXuAndIBdRghZZr0QGBc8IS3JHL2ILb1ArMo0P6+vlfovztS3s+KX30V5AMXCNUDYRQah7ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494OUGj007414;
	Thu, 8 May 2025 23:18:03 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46djnjxs6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 23:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT7YUCwa5NNAdF7KQ+tKqFPu2KQ+STdIxKhQKfOWlx5adjhFbUN7uXEc79gPHsgv6ek23G1RQEl45+nN9b0X8UGffEEw525Aewz/ZygZLeGx797KDVPKt8M8VqJWTPcJ12V1Ci2gFx34Uz7gl6SVQTomXi3prmAYtxOZK5QI25EcREtztfum//dRs3ZGwlDlfJ14GMJTRIGzNpVc5vdFNlxZxAbDBweK7G1mbno9P6ewAQTXM2cvnrqjuQe40RioYTp5GxUU7Pe8/eja0Qa6A3b5FUqUEBmGzfHfTegj3fn5heO5G5C9AgE+dGLQcIueV/BLWHH91TdKdp5SjSdkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlmSkLHYxT4Elrka9Vzc+0NSXXl7Fm1IBaGVoZy9S3U=;
 b=Or7a4UzhxuaOkgxEVKgTvkghMBuCF7t6k7C4CGTVi6RHiFUhXd/mNc8GwSRD7OEv2a7kSl3+ZnsKEvKUvVpkshCx1Bt06sI6Ge6ZIfWBTfxLaskxd7lAoDhGlVOkZt/d8E2XEFOliBKMJnyIwkT6ssnl1v8z23lFwzKtK8OfQwkAa/9lKrfd+7hDEeTRTO1kgIQInw7Mz8y130qqjNFyWUSqEK+Lv8yiUGxLwIqnNTukOkv7QxLE3uLRRDI9pMRQwEQRJtEpxISeGGiRn1ULoteQCMdAXUdtc3TBVLi/JO37x4Pg5FpezTHr06gV5YW8sco4TGyVHPbWO7hccXudhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 06:17:59 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 06:17:59 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: dan.carpenter@linaro.org, heikki.krogerus@linux.intel.com,
        bin.lan.cn@windriver.com
Subject: [PATCH 6.1.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Fri,  9 May 2025 14:17:39 +0800
Message-Id: <20250509061740.441812-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6185bc32-ed1a-4800-5492-08dd8ec13ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MTHSJMumdorggIcIGvzY1Og9CKz6ldegUv7m8E9f1+0/M9K7gKg99xzV5NjL?=
 =?us-ascii?Q?yG0oLtkiPIDfsVHuDYjdtVckxIdkWS/xR1e+fpfkhQU05UdGhRQGMtkfWkdL?=
 =?us-ascii?Q?V26zTMh17kQqyYYDv2unDMa2CGjUBjDQCrdLHyqT+eAShcEUj1hmYmX+rVhm?=
 =?us-ascii?Q?VJmUj6c6u1EGeDA2eS/02G2n/6mBdHhGaGGkkiXBC8ccV6oBgVr0VYhEsiuF?=
 =?us-ascii?Q?pGt2PzF/RszSJcxORrh1EzAa8c3fCEcmLwqaiif0ENX7aNgCvCvZgY0P329a?=
 =?us-ascii?Q?9yhFbegcWvsriR0Wn/npJZXhS3eOCeKCz7HCopuRyb+UuTYJwncz63Enmdmi?=
 =?us-ascii?Q?aeslnACq1bBnnJ2Objg2p6Lu0iLjvUxilwGo6mRBlKMUGP+AjSOiHVD1uuI0?=
 =?us-ascii?Q?ebe7W5BKFiVRm2wSrOPEv03w6/TSUwH2cTQyNi2xjxhqaO0E0O9FW5hWPJA3?=
 =?us-ascii?Q?YF3UE1EZcoEn6xKdY6D0V0VkgJ6RzPPHoMPxDR97jiew1JzgF4HExy5Ru3yE?=
 =?us-ascii?Q?ZrVaRPXO/dA+yGYJmBkYWlKVC3Ve7dEViWoFsLeLKJgiHMuY2CeKQN3h+cz8?=
 =?us-ascii?Q?liElXo+iRWf4k+bRR8Io39FQDCLaHPRgCD8XY0H5c7SVC9L0VN9/8ya5/oMA?=
 =?us-ascii?Q?+2+dSwV5VbWNy+LAz7IWUjRbcqRwVtxQRSAAiveJhEa+c+Cn1xMut6imqzsZ?=
 =?us-ascii?Q?AO59499vvWIT8VokJ1VXJpJpHwXeZyI5kMYOJhR1OGQaw3SJAkAEpeCOr3DI?=
 =?us-ascii?Q?Wyo8I8RCFYfZ4eMmHcRz+zWSyy51PXkn8DLabayY28xS+4I8uuW8eQDzO/Qn?=
 =?us-ascii?Q?SHtTbMyMK36ZhCKuHJL2t0uURJA1PZGarCuAEHBSty9ze4ww31ZX7fVsk8JI?=
 =?us-ascii?Q?0+X4PvCoCDMgJYLef488Uj73Xz1Auip7pW0jmgvyGULB6feT1RLfl2GdpGvB?=
 =?us-ascii?Q?W1a07i7INZTY688f1x6q8sjMozdk2O3UaIpBkVr33yZaHlNcwaWvw2R1D0d7?=
 =?us-ascii?Q?ukKmqM6sHU5oGpOZ37ojqL9gOv9ekfUG4WSl7jSuhnT1cZ/x3qAiUBklwJx/?=
 =?us-ascii?Q?n5/qJ+P4pKtRmfoPdRQ/dHMoLvMB7MHg/yw3PIPO4jjlLtEoxsfGl0kSvVJl?=
 =?us-ascii?Q?iKksJ+2Fcc7/hXUKZ8WmQzfwUFRnmHWFMh/0cnPmssMncvY1gXB1GuYnWVoE?=
 =?us-ascii?Q?vjQ9F1zY0AoLd4lIvK85aEmKvgPHjj2qtky+8QMkx1rDU3F5ayeh9NeppAJK?=
 =?us-ascii?Q?Am2bKQvHnAAClUloF93gtCcmXPiWdB2qPvsnUZisgxwWXN7uk0k3x/2ijxo8?=
 =?us-ascii?Q?RloP3/KlVX0KlAjV4Kua27WMbMv+IwfH97tRF6HfpOxwQgTNgyPCix4qzqWz?=
 =?us-ascii?Q?yT9IPYKCYy435HL/pXOLNXQCBEkazIAOQN4dFk4Ajw1AtnUotl3s3ZAOkG9w?=
 =?us-ascii?Q?l11twbID2x07wmn4l9BSitbVpt68bDEZ+ZGJKY1kosdpP6x0uxxx5hXYykq5?=
 =?us-ascii?Q?FVz/Y1W5ZzkDKU0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RcHGOq15mbOcAHY7aWgdtk04R33sRbyqGM8d2w/m9fB59+H8fagdARVKJQxh?=
 =?us-ascii?Q?zYS/L889Mfjk9eu6PVZWalZlSXCTraDDPp39NDFt6CbmP4BEGlc929jH9wW1?=
 =?us-ascii?Q?aj/p7ROtvZXA/Dn4isMJNwU8ZIg16VV/6oJDa2ScXaNk7VPKr71n7w/IoOsC?=
 =?us-ascii?Q?5id8PYqXiP7GFHd+wPGSYQMoStve6YV+/RbhRca91sCBbgqMf/+mJ/1GC6as?=
 =?us-ascii?Q?pmbMpsgIV0duJDerJCDPJ1OBGmf+QaXI2VcqAZb4P9jr7TSACbj70fD0TuWR?=
 =?us-ascii?Q?oQ5ngIyEnB8xEnRXxopnvpf2VW3kkQpR9RvQ9max4dgHIC9Sdl5ZoyVF6pDg?=
 =?us-ascii?Q?iYrkONH9e3vYFEdHFcWarCpXpsrtHPrnQLYY/0AR7sXS25q0na2kl2gxRIO0?=
 =?us-ascii?Q?K2lhLez9gkRqK/wbSYBuC7njA+PlBXQ5JDn9auDHjrS2fNhhoj7mGQKNDMPN?=
 =?us-ascii?Q?fOufIzQXdd9/10HLUaonZJRjHJN/fZFm9CuWKmLJsAMOVQ9zZqCcXF4QeFac?=
 =?us-ascii?Q?y8ldWVIbVuKX+LWLEEBcDRZGFcooPf5rkoKxyjZAY6c9mE6Nnm3yDkLd/i1Q?=
 =?us-ascii?Q?QP6hlM7td2w6txAkGvCR29P0ybrrNiqxeUVUIedJIzuEl0/5P7E1al4F5Vel?=
 =?us-ascii?Q?QT5QHEC3zL3fispbHnhkbzQNO6K9Ooiams0f3DifBK1tZGemOwFfNH/C9Nug?=
 =?us-ascii?Q?3d7anxIobrry3npBz3iOG6Z4Z4U4rMFfoB8eNINHpn8/62D6ADvXImPEoF4o?=
 =?us-ascii?Q?rw6Z2YBSU9bpSN94cM9Ku9DTVclUt19NzKLX5coRzlup8GYNkDYVXbUzHMug?=
 =?us-ascii?Q?VgOmrceff+egVQ+9jJc20x2Umujd/gRrau6slEAvISYUVM4/2TlcnisVLYkI?=
 =?us-ascii?Q?4UD20vkpO4Mh5CFOwzOffOSNmjeZE6YxnMEmKly2Ykziw4Gafyf2vuJtPl3I?=
 =?us-ascii?Q?a7XrUAJENk4CMKC9ytJ2FBvYRcVavHw70oOyXTIVY/tgXLPqOLJe6IMIwdAV?=
 =?us-ascii?Q?eYwFk6hs+sk/07aaH88NdsAiWXaB9lc2UPrt7G0GbkRqI84CFp/y1k7QVR1L?=
 =?us-ascii?Q?01QpfgYTKYFO8m3/+rAGI8YUBhvBjvNxdROyQXMNZKMFNpUUZn7OriqpSI/a?=
 =?us-ascii?Q?2tPZ/gM+fqjG7aHa/UWdUOf3CwTC/TB9Yh5v2cryIoIq72RzGr3dEwaq17lr?=
 =?us-ascii?Q?K/K/7vRFrIjYQ1mqDT47eWQtVpDbe9qYROEl3bCyaC5yF4D8Z3Q7iLP7Ink0?=
 =?us-ascii?Q?7/vaEzqSOGGCvla83PbZ/H4+A3PFrhvAtfi/FgmBuWF8c5m+tyIRa/UKYBS0?=
 =?us-ascii?Q?3py7zaKdCCp8G88MPKWaezDl+e67Fw44oR/PRu/iPnGKqKO8KQKxOj0ADBbB?=
 =?us-ascii?Q?53PAS2iYxvqIaUuIGiIY9sQKj2TYY7yBlf1+uXbhOt4rVtTHD9A4VkOC2jG1?=
 =?us-ascii?Q?42lmRtHK3dAICZiSdYKDGWJNh/wmO6wN2Lcc7URPzE4JvQy20zMixhEIDfaO?=
 =?us-ascii?Q?fMgqJ85OKoPw+i/0WxD2CKKGpxZJllSu13svVXkVY4wtPoVRAMKLKUvi0u2d?=
 =?us-ascii?Q?XlCVYyDz+7JuVPeLrjnAGj0/zmrQUS7cm/A6FcT58Ihs1u3qg1Oe38tztlth?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6185bc32-ed1a-4800-5492-08dd8ec13ea5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:17:58.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dwrc3cM0jg6COqfHVTeTyHFA3JXUGCiHM7LP+nqBHPzalB9+Qhe0ZADz1gfH7gyvwimYibhYovOGi09n4jPiDu7PzduzFABljNmMi3gY+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA1OSBTYWx0ZWRfX5VGsD5KVZi4k 2mHnjzzuTl7gXDGYtGwfTCUGIJXJR0smCch7Tw0wmJcIa+j9iNnkLeMkQNhXWM3qTcW6lj8LMgW MclzdgHZ3L0y4wCxx7bL+m9l00Z0bF4gzvKG5w5J9ZuEkUQymT8BDstjBRIOC234Jbv+/UTyoK1
 9ie7Vtw5Lt2APak9rmyMkV74DagS6RUH6k3zG09bxNIgzVIjJOh96jcNzckgIox2t8+Y1U50WlF 3bOas1Hz9TncEUJEHqeKmPY9HEGYIgW6j37OmLieOZeDKAVabpCqRpnDx03TT8/rfaiBWXmj8kP +/53g7z6Vygg4LtHVXF4/zulhqNb4EelQBMKS0wfs3gA2XdvOxa2h7ZWkcbd9meOkZ6mB67j3KE
 tbm3wIWpPXVEOMwutGeb+iS6SDTCnIy/0JS50F/3puQVY1lmuBH2T1JSkQ2cO642MKKi5qLt
X-Proofpoint-ORIG-GUID: IqmIs0X3-3y5xm32NCfKUO853qmkhx5n
X-Proofpoint-GUID: IqmIs0X3-3y5xm32NCfKUO853qmkhx5n
X-Authority-Analysis: v=2.4 cv=KdHSsRYD c=1 sm=1 tr=0 ts=681d9e1a cx=c_pps a=DnJuoDeutjy/DnsrngHDCQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=uc3al3VmiIQHG6Bas5kA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090059

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e56aac6e5a25630645607b6856d4b2a17b2311a5 ]

The "command" variable can be controlled by the user via debugfs.  The
worry is that if con_index is zero then "&uc->ucsi->connector[con_index
- 1]" would be an array underflow.

Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/c69ef0b3-61b0-4dde-98dd-97b97f81d912@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[The function ucsi_ccg_sync_write() is renamed to ucsi_ccg_sync_control()
in commit 13f2ec3115c8 ("usb: typec: ucsi:simplify command sending API").
Apply this patch to ucsi_ccg_sync_write() in 6.1.y accordingly.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 8e500fe41e78..4801d783bd0c 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -585,6 +585,10 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 		    uc->has_multiple_dp) {
 			con_index = (uc->last_cmd_sent >> 16) &
 				    UCSI_CMD_CONNECTOR_MASK;
+			if (con_index == 0) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
 		}
@@ -600,6 +604,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
 	pm_runtime_put_sync(uc->dev);
+unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1


