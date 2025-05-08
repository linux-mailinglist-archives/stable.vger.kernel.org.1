Return-Path: <stable+bounces-142848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F5BAAFA7B
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0476C501778
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBD020F079;
	Thu,  8 May 2025 12:50:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2BFEEAA
	for <stable@vger.kernel.org>; Thu,  8 May 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708632; cv=fail; b=Sz4VYxf7kiVRKByX3MoGrFp3IFB+psSxUkrEiQZNOCKK8qRhcNssji15eoHPA66C9UudTDcGyhqdm+UjTsCWg9PVf2qTWcCKLlGk1KduWETlfYW69f97eCkiV1Ip4yOCf+OolfanTsjkJcUFGDlmInjWONubY9ncIExFzZGTwUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708632; c=relaxed/simple;
	bh=4syhZYMk6pEc8+dUgKckI3mv3b9x02pJgEvOVklGxa4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zw6RmUubvIz03SY/D6WVXRtnpcj//REIq79esGnudqKDrgIWRKeLobq7LKRDMUTYkEaHPUjoZ+Cid9mJ17/qJ7dV67wVfC94gSWBGD5sharp0+dhlfqGIfPIaVfUAYgxVJcSfOgPNKIFqk5+Hr0cmMJhc2IrDe2nTv2nNa+TgF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54856x5D007700;
	Thu, 8 May 2025 12:24:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46e430n6h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 12:24:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCI06R25zu15g7uVd+9TTVxNlOsHXglIRGIGXnKJgmw3exUvz5DupYUapVmyd7Js9e+LIz6t8Fp2tqIJjW+r/30UbkGKMPYm8PSVqR0gVXIt79yeedZQdfk3Uk75wvxWFkKo6Z7tfIrfpGIMFv/W5JRRUx/j9+eVs+Si2NS9uhBn1Fon+tMvBpPHHXU9i47ZL6nDO0+vpYwwoTJphGzGWswy8yCWcY+JMLwY+p3GB11JG9O5h7uAbUGrg/r2r6IFVv/fI6x8iI6UqFxV7Eu9mgEzHaZJUdiCxhofCK+eBSrr9lSoOm56ncdx/DTp86ZFuf4AZFkV3wVQU6TM5yOoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMTIHdV3u+sh0/oE8R7jTrmQWsvLUAfWnUtf47Lzboc=;
 b=m3f9eapwiU/q9l5XAmBII3ivU5R+Z1TqarNIeciOGsGP7w6nqJpncqbbA8UZfsFZhSJRy6mqE+AHwzNWFq9k9UKD2ay+bJRCRGpDv79O1cC2QgThQAKvt5X8v/ttm7MXAx5zh+cTPzFL+3oXke40iW1A3X33Z8M/MAAvg6MXu7EMajolw3A/sAoqOjFhz9VrnUIkfBf0qSUhxktPjiaxtZKK49pkzezlgTIkAIIm3wLX0Pdc4qYBTqN6V4pO1OslWYE+pbtgdpgCXX2vxuW+4xxh7rEQt4yXil2F0NfgyN+yzmBvO1dY+NAJjbxBgGWjRva5NhnRcovyA+Yfatj5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 8 May
 2025 12:24:19 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 12:24:19 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: boris@bur.io, josef@toxicpanda.com, bin.lan.cn@windriver.com,
        dsterba@suse.com
Subject: [PATCH 5.15.y] btrfs: do not clean up repair bio if submit fails
Date: Thu,  8 May 2025 20:23:55 +0800
Message-Id: <20250508122355.99249-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0017.jpnprd01.prod.outlook.com (2603:1096:405::29)
 To CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a8bf89-1983-42cc-dc59-08dd8e2b4174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9yId7rEQSldCRO2tWKDTs1aci4G5yxIuCGdALJdHM7AIk5M2xx3jmRSbDD0+?=
 =?us-ascii?Q?zlgkM2N+B2Ail7brxgtzuQgzGpEILQhThyq9TIoO/HxRFMdc6L9bNzMpIu72?=
 =?us-ascii?Q?Lspjw/mTPlKV1JFIEKpbdJ0oPDwO0yM/2l7Vgt2Kc0zth1XDXQuI6fcdKA4e?=
 =?us-ascii?Q?FS2YsGIYhXIdImqefoK+ygYUcwsV6nvsZiAflJSFI962sDf1Pr4x03jKcIvx?=
 =?us-ascii?Q?zwGk/KLB5gBmjWZ2hhwRamNOvnqblb7v9obrLerI74ij0Y5wuBuQ8E9g50c6?=
 =?us-ascii?Q?GTQKRUlx5maiUSSLp97NlpnOAhFK2u7VHd5Y2bg33qR1DjhycdMd36fDRnH0?=
 =?us-ascii?Q?1Hl8l9kiYS8YgfnadRJ9R/pFVWn7GJrV6YUh+DeHfpcZCtBdQLUqOWxoTKFy?=
 =?us-ascii?Q?yOLm5+NDh9np55FVZXyy4nmRvKuFuCYWaKa9+CEKbg1HHBO1RY5DBiXKp0lb?=
 =?us-ascii?Q?CMYK+8tIXUOiQze7riNwAjyhV07/c8BqF9buuN6RtF2vlx0x5VoSGKmp56JU?=
 =?us-ascii?Q?BpN3vIA6F5+1lMyxwxZWThb2RO1JJk1gCR8g1kbd5HsE6+sPPJogNAiNndd5?=
 =?us-ascii?Q?mQKJayt7IscNsjhXC+IQhtLQBavKe+Hv8KjwP1Jyfwg+F0WZkwJV5eADvjCq?=
 =?us-ascii?Q?k1woT2t5vZM/DveKwMKV980vgCybxeyKjZILuxUipc2cI4jxaAAWvk8BGFIi?=
 =?us-ascii?Q?+Q5f2Q/qG1TE8kXWoiLgFZDZJFYeAYfXv5obcdD8dtBbwqqrEhcokgPVaYl7?=
 =?us-ascii?Q?n/xl9J2QZgKT4pAdZxKgMdUZEMuqkuyx4VaZAEmi8wC8vYV09gVAZVqAOKU/?=
 =?us-ascii?Q?t1MCGqqj0kIzq715/KnviC23TNM4TwhHsSNHl6UcskLMCFUDzwUfj4bRIeBF?=
 =?us-ascii?Q?sV8hAziHLm2kM07JthEawFW4pztni9reN9JOY8rLrsrxi+rkkJ9FL/qVKLwM?=
 =?us-ascii?Q?tjoJxTGH4TRR1UOh1NDLWv4UdqFxv2NiVmkpWAtWVD2SXMUmxQCqX76X52Kx?=
 =?us-ascii?Q?9BXbx+xqZE27p81HCedWB3yXCAiswoultFQgPGvB/PhjE0VEj2V8bgoOaOSw?=
 =?us-ascii?Q?paijqMMXyVNxctucCPlrlZHqq6zhjn9icuS7qyQFv/y8obF00qjx9nu7+60O?=
 =?us-ascii?Q?f957R7RNJljOR6qQrFhvzrwQWJXB2PJyY6GG/+1KIbXwzOwPuhSSZllQFReW?=
 =?us-ascii?Q?03j24jFqUTPJaGIvK5P1uorlGWHA231EnGat6xZSONr19U1eJZfl/BdRZ2gK?=
 =?us-ascii?Q?gUQmE4YaIdKv2+XkWJuu6Go2a2dYHWemKCOQ+TC/B4J//RcpTl7US6FBz8y5?=
 =?us-ascii?Q?Ub4gPtEHqBlH5Z+3btgLSKFo7CNuDQeCJf3DrGGs9bWVh8uCCVqnC12hPIp0?=
 =?us-ascii?Q?/pOZ5s+PkNSU3K2z8fEP1QCTzwpnrYal68wcEqlXucB8BB1daOuK2y+NAnj7?=
 =?us-ascii?Q?8QDX8eJ1lEpG0QtALwE+SeWNaL5G+WzQpepp/AgfBYw48gZJb+k/tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zsfs9Vrodrt04kR/KOXps7qll+cUTne5ZNlYyb3trUoiXrR92LKA18jPP4PU?=
 =?us-ascii?Q?YCJA9T2crhKANx366hKOV4bZxTq4X1zFsLY+TM2pLMVqLo2dwf1ckMm/pHlp?=
 =?us-ascii?Q?3Hvuizgf55HBL/98idjuxtz5IBORo9MoC3I1WfNWNJjCihp+6bO7unIO3soB?=
 =?us-ascii?Q?Yt8I4FnOiNSvGSeSsn0QRUz6z5ywJeR65szGAyppw5HfoK9JUPaORz3Bs4Rt?=
 =?us-ascii?Q?OpFG+l9odCaT7kqvqaGzhcx0f1TwsJzqXYqhztnEJgSzd4OSDOg33PqF6swY?=
 =?us-ascii?Q?foJBDF7o30KDHfVIpaJuZQzv7eVmUekl14iAxxgJd9cgfLpU4GKqD+8s17BR?=
 =?us-ascii?Q?3bSLHL51AatVt+djh3v4Wbgcw4nW+OKgWTd44Jk9cesiyhVkzPJThXvYI8HA?=
 =?us-ascii?Q?QsHn8IIankN3RvWwTzZSwZDSFqWrx04k1OQTY3BW9gaMouEPQFXK6wC229aL?=
 =?us-ascii?Q?JDkjX9+iecrs2+Uf2aUJIfakR33ILdEvesC6ZWLyog2BRnH3BFv8F8v/oaQW?=
 =?us-ascii?Q?B5mcZjXwwEnYZnpmiCvP5xXpZWG2+f+H5fV+WP4tvUMys3yRgZpWjBQrul7y?=
 =?us-ascii?Q?kDmk9AO3l6PJBtnRjIBEoNaHXzbTpspL9kFC3QLG/CCD+oSZ5PCtK3Bj4DUn?=
 =?us-ascii?Q?SFHaD7s0zW5VNzzd1cUIqXhqxkcE5MAKmhIcS9PCnbN0t6WEYoArszeQUGwI?=
 =?us-ascii?Q?Ppw7/tLIk11VlSd2RDuZ3EtnPCCbBAlpvVffKoDMD69mnJtGt2XQK6w95HwT?=
 =?us-ascii?Q?IPoBdPVWJMW+y/Rj6UBPDMe1EM5xwM7uNdKfVpcQuYupeEKYYR1r23vQ+rIW?=
 =?us-ascii?Q?mf17mxz8VhFSaN09Pk0NC+kZj/6ydKLk8hOkXhcvslBlvoOLPw9oM/8YvHWs?=
 =?us-ascii?Q?bpoJArkPVc4mMOpQJ+GqOQjmW++qHhNI/O6TYpVIqATP2X9fY61wVFW5EjYr?=
 =?us-ascii?Q?4Qwxtf8a6Q1rdvcRpXdJIm+UQvFtYlYYS09XmUo3wsNoOPpsl6YVSde8HMnf?=
 =?us-ascii?Q?shP6eBK5dynYRIFMmNHwpCIlOLsSrCFYdbiUktzJmOCJOqmZTAkEErrhVGLk?=
 =?us-ascii?Q?dT+GU/0mV9eo5PueCcEPMbGb2Nxxwmz5h1YiIy6SxfklcAJA8njm7WWuGWiD?=
 =?us-ascii?Q?hcKFXTqcjsu2iBJ+jy255YfNzHR7+qTcOdgDUxCK8D7Qwh9RsFO41G0esjvX?=
 =?us-ascii?Q?Y7r7YOGeK2t+Lm/4E4Ze6ITApkiITrSJsBfAFX7uE9+C3CosNvZJBVEjsc9G?=
 =?us-ascii?Q?CyutnNoEWspgS4sKIu3zcLWImdjFQYLiOfplIllfzMvdV+X5zeK/bwTWrIy4?=
 =?us-ascii?Q?kRQPXZjg5D87BYRrZ6rJNbj8lb/nvUaCaNlegav1nqL226qjcv83+q4+1+e5?=
 =?us-ascii?Q?VbNz6w7LX1N5BWArPZcybZ/HhjZ3blnHgSEHD2GU+OyAm5jxRk6vH1oaI6rC?=
 =?us-ascii?Q?RqBwU88A+v8SUQ+ZR+sJGbXBYz+OyWgXpCHgLSzqsKEpYu30KsRhoixIV100?=
 =?us-ascii?Q?p/HR+W9WACf20NYwQvcuwYMJUA1l3UEUVfY9whGcHcd2iMW18lAuj0pQXcT8?=
 =?us-ascii?Q?89Eenw3yUX+j9+dXGyMPvaC0IuumZApXZwhq0XrELZmbiCUPHlJlAUe1HSoF?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a8bf89-1983-42cc-dc59-08dd8e2b4174
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:24:19.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf41a9Tlmt/E11yL/u9J4y88FA5PHKRz3hIZ/Ojwm1KD6cTpe5Xw2Tis3U8lJTHfK6i7U9zOjPeoM5AnAzddVHTV9nzBwZk9oenl5jWkz/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-Authority-Analysis: v=2.4 cv=BajY0qt2 c=1 sm=1 tr=0 ts=681ca279 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=maIFttP_AAAA:8 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=huzlxyssQPFI5TbvvIgA:9 a=qR24C9TJY6iBuJVj_x8Y:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8C0qqDigg3W2t2wRXm40YA-p7EhWlmRe
X-Proofpoint-ORIG-GUID: 8C0qqDigg3W2t2wRXm40YA-p7EhWlmRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEwMSBTYWx0ZWRfX/5fJc/l2ReCK V5CzIC4tDxDK7gSySIwsb7qOJptsqYYa+yINPH7oc1fNFg0fdG4MWU/d1kJ7nPiyvm3ugwrdXpL +h40K/5m+8hZNtZ6AxYg4QfjWRwXRt9D/EyhT0k0yQ4l835+ME0PwlWPkzmzvWgAGl8EuV/9Qim
 plb+9Kk53EJ0iCmhO1T8LGWgfCoUidvGKaH+iCE8WrEo3PKzfFCHLQAF/cNkZ24XG64rU1mlFkd Rn7AKbbx3UmmVOpBVtxLMrj5v9O0eOql3NGh8gOP91S54LJtmizkevG5XLoJc+gfIb0NKtZs3LV xJDf506WrMl+xXg4DuAjOTFSHxYZVL0JceP3hb7il8IptRECpihgqmZJ81wpTjjtYkfv2lNnGiz
 L6xqFDEOQeym1HnnF3YZwa0vCeAsB6nguWgXzwT3uDa1jHqsben4LYBnU5kTDQAJUpLv9d39
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505080101

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 8cbc3001a3264d998d6b6db3e23f935c158abd4d ]

The submit helper will always run bio_endio() on the bio if it fails to
submit, so cleaning up the bio just leads to a variety of use-after-free
and NULL pointer dereference bugs because we race with the endio
function that is cleaning up the bio.  Instead just return BLK_STS_OK as
the repair function has to continue to process the rest of the pages,
and the endio for the repair bio will do the appropriate cleanup for the
page that it was given.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 346fc46d019b..a1946d62911c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2624,7 +2624,6 @@ int btrfs_repair_one_sector(struct inode *inode,
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
-	blk_status_t status;
 
 	btrfs_debug(fs_info,
 		   "repair read error: read error at %llu", start);
@@ -2664,13 +2663,13 @@ int btrfs_repair_one_sector(struct inode *inode,
 		    "repair read error: submitting new read to mirror %d",
 		    failrec->this_mirror);
 
-	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
-				 failrec->bio_flags);
-	if (status) {
-		free_io_failure(failure_tree, tree, failrec);
-		bio_put(repair_bio);
-	}
-	return blk_status_to_errno(status);
+	/*
+	 * At this point we have a bio, so any errors from submit_bio_hook()
+	 * will be handled by the endio on the repair_bio, so we can't return an
+	 * error here.
+	 */
+	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->bio_flags);
+	return BLK_STS_OK;
 }
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
-- 
2.34.1


