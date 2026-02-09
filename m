Return-Path: <stable+bounces-214875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uALyDDNSiWmd6gQAu9opvQ
	(envelope-from <stable+bounces-214875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 04:19:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E910B5C9
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 04:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E6B93005EA9
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD202F3C26;
	Mon,  9 Feb 2026 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="goArv5QB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ky7w5adq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A4283FC5
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770607150; cv=fail; b=MRrYW1OAJUltnEFKZFCRwqEmbEfeNYWU/dUW7jRdTYI9HUR0Dlm8OdRfbyp/XrE0t8mr2JvSHZweoUewzTp1j2RAYdhuqNRBly33d8nbef5K4QGR7Pjp25vn+POzZvC1CX8h80fPb7Uf3fkXgY/gAuftZcHDPRjfX79VJF2cBrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770607150; c=relaxed/simple;
	bh=6bEk1h04JpYOlCNmhskGJd8ehkgwcLfrc026gFZDsRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kbnuv6QcJCwD3t+t03PuT9j4fLGZkSm8OD77lp6IBNVB0C3jsNXl19eMM0haN174raBR23KmqBQZ1sCBoaU5q11IM0s1kM8tkumMyzezrEaBnnKAMfcmNImjsdAZFTqFXFEAyqg9mtxxskP91wVsUwAnyOBbU7j0A0zVGxs4dkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=goArv5QB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ky7w5adq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618NecwC136611;
	Mon, 9 Feb 2026 03:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YtAsUovzPEWrQdmfzoEMaqyixwbExfZ0Pkd9skpaiyg=; b=
	goArv5QBBNSEqRpaMmLDh8D5rzs9ijsRYvVnSOyfQ12DgolmI5L23ystZfUqlvhv
	+OwmYux1K/t4oeQFJfmInBBz9HIviXg7I/AeLKlRfOs7cWeWulfUaSMYWMrVHyN6
	O/kwZJHO1ygBOdRR4fzcMFdfXzXCgGUxPLBOiR06UWU8KZIixUgEjL1VBSqoGAll
	YDTqAP2CBr06EfrfDBQ0Xul6aqO0xNrIfSYUHAtsFJ3JdaWH84gmjN9hot3Ggzsb
	M/tKNHyiD/hKMlSvUhomLBd3t2VaY7gsSFpjTF+zl7Zkj1GstrspqRGFsk1mszl0
	nmgKSjTbst68vx81RVEToQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xhu9ag6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 03:18:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618LtMIW015019;
	Mon, 9 Feb 2026 03:18:29 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uuk0j4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 03:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8TDNs3eFDzd0HSoRBab3/Db7igHMIKXOaE36Osv6ZcDUU96ycdYNBMDMw+AGarlbarrw+p8Co8iH4xfqw7XwcIOPjSmVCJoV8yIitFJBHpJInhJ1xllO/UZ9l+cTilAarpce+qFeXOrx6obwYsuec6ENJFboZ8mgWYtWoj59IEneCA69oHUpxBbZAYkIyAp/FebQ/juEH4mBANwFM+yXU7q6n4n5w/X0an7Xv1ivZuuwqTjRqxLtRXDL391ICy0hm4aWjQ+ZdlONiwUAP632TkNzlGCUbX0NSiAqwy3W0ms46k6sdHpsk4/wAjgdcIszfRa+y61EqZAme9sOsw2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtAsUovzPEWrQdmfzoEMaqyixwbExfZ0Pkd9skpaiyg=;
 b=AVYr3iIGxpB+QSLAxZMMHKFKF50+PE+i/qpSJPA4kUhbIXOhMnBuhBV3VWGyb/2cBgcgWsFd8YiMoTQKEKkErlRidIRGBws0/fgwk3Uul9U15KnLr8kOHU4WEpe5qNlWcDPNDx3b+PyIm+1aHKj7UhDX/38EuvaQsMAOG4cDVVk81bYtPX3MJHNqHnXyVudX99QCbmlTu+MgZmZnx9udxUQZvXg0aWO4K7ms+Aw98oMZhh1m51FIAk1yciMbk8dU3kKmYilCoYOhuGlxPxMTUczqgicI7DshI26iTYQWyunhAKYk6X0Mvh1uEyi/S7uEDC4w5P3LT79C7xp/EEsQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtAsUovzPEWrQdmfzoEMaqyixwbExfZ0Pkd9skpaiyg=;
 b=ky7w5adq9Ukjy5wJrEs/PK1U0v2Tr8GF8/EfN/VQD5PcejPKyxO5G/D9Rs0NL3HtvU5ZzImM1oSInoKHjuTR4bDkIDnmCQZE4SKoyFBR8v3rn4zxEqCmrUYy767VtfAMOJx9EamYvSavw6RpPLEZRRld4VUNMDBjlqTV/yGiX7g=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB5839.namprd10.prod.outlook.com (2603:10b6:303:18f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 03:18:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 03:18:26 +0000
Date: Mon, 9 Feb 2026 12:18:20 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
        linux-mm <linux-mm@kvack.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/slab: skip get_from_any_partial() if !allow_spin
Message-ID: <aYlR_KW8xj4LJaYt@hyeyoo>
References: <20260206171348.35886-1-harry.yoo@oracle.com>
 <20260206171348.35886-2-harry.yoo@oracle.com>
 <2ce1eac3-98fd-448f-8a73-01bb3cb5a7d5@suse.cz>
 <CAADnVQ+1RBXBWNQtshEfFNZEp0tDZOFKf_vedyjgdz=wqWdG8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+1RBXBWNQtshEfFNZEp0tDZOFKf_vedyjgdz=wqWdG8A@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0137.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bb291d-4974-4992-22af-08de6789e373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnI1cWRZSVFaTDRidW9KcUhOa2hjS0JUZGduOEZwSWRWczAzRVhyN0JrM292?=
 =?utf-8?B?Rld2bFdSdm5EODR0Ty9UU0p2V2tuaWdTVFdZdlVGYXZobWxkdFYzeHZLRnc1?=
 =?utf-8?B?ZmJvbVcvay9vVUEvNFZndGpCZFA1RVhhcXM3c0JlK0hPWjlxMHJncmliYitO?=
 =?utf-8?B?eWx3bUNhNDRGSFMyMWdhNzN0ZUUzZlpaMmhIMzRnNndpeHBydzRHalZ0cTJU?=
 =?utf-8?B?L2k0eU1yUkdMZzNULzh2a3N0OFppWm8yZHNwU1NPek9OdUphT250TGxHMmtl?=
 =?utf-8?B?cEtLdkRlSVFVTEVFZ0FOMXlsdnhXT3dYYVVDdGtVK3AybmJ6QzVURXpRUXBo?=
 =?utf-8?B?bjlIYVl3d2gvcVpaZDVRNGF3MFZlRkFrVklNLzAxOU1Zc1Y2YTk4WTBGSHYx?=
 =?utf-8?B?YjJ1NkgvWno1c21rMlJaK0RMbVh4bHFnRjB5ZWM5M24vZkhEOEVuckdmOWJH?=
 =?utf-8?B?UDdUUmZLamtXVmp5S2NaMURHWTJkS0F0V3lSMjZSMFNsZStDdTVJS2I4Qkox?=
 =?utf-8?B?MGdoUDNiZEQrS1B4aXpmR1lobml3YzcvanVScEJ3WU9NMUlVV2VQZWdCcitD?=
 =?utf-8?B?K1IyYkRxVnpJYS9LdVdDMng5VnZLYWo3dmNleER2Wi8vc0tnSmNZODlEWHFT?=
 =?utf-8?B?ZVNxMkNZak9qYWk5VkI5a1dob2FoWEVscFN0b2MxSzc3VGl5Y0Zrb2o5WkZt?=
 =?utf-8?B?UnRVWE9BWTIrWFkvQXBxNTIwOExINlVxUGFKQllSemlpUmF1dmNFRFdCbE9W?=
 =?utf-8?B?aTZvby8vMXFEbHBqa2lWdGRNWTdXZ2YrZXk2TkkrRFFLcGtrSHp4cTZSd3NI?=
 =?utf-8?B?NUxHVUM3Y210bEl0eWFYRWtxbzNDa0JmR25qcE9FZXRJa3hGUHVCVnNURkhk?=
 =?utf-8?B?ZGEyUCtDMURZZDhOeHVjZWtsU3h6dUxhWTlTQlVlSzBJVWl0dHBJSmZoNEpw?=
 =?utf-8?B?blBnb2xNSWc4NkdMRC81WVRENUxXL2FFUkxrTUZnZENRUTRYK0NXMTVDMU10?=
 =?utf-8?B?a0svYjdqLzd2NEZTUjE2Q0ZQTVJoVzZSVGxRZWt3T0ZMV2o5RnhTMXgvbXc5?=
 =?utf-8?B?dDVlSzNjQ1dKTnlQY0h5SUVSTTMrQ0QyWDVCZ1MxZVdwSDAxTDlBVmlFUlpT?=
 =?utf-8?B?ZmFyUHZhZ0psUnZUVjNsN3BVa3dyQTFsa0p2Z0o1MDh2SE9kTEZLdStoUkxh?=
 =?utf-8?B?dUJPR0gza2dlOGk0YnpFMCt1ODg4RzZnc2RsK0YwaGdaSlJKN25hejRVWi9q?=
 =?utf-8?B?aFNRV1FteTRRbHg3VDBBcWEvSGRISzBuNEk3cHc5NVRSTldiNDAwd2J0cGdH?=
 =?utf-8?B?cy9UNTVvQzkwSkR4bngyczFrSVgzYUlVa216dUZUN1JYMnozU3lMdDhobWRQ?=
 =?utf-8?B?NXAvUVZKTXdBV0V2ZkZyMzkrQ3ViUEF4Uklrc3RPVEJrZ2d6aXdNZlAyVkpP?=
 =?utf-8?B?YnRmakZTclp1aHI2enpIMFdCVGh2ZGpYTjNrZmhkUWw4TG9Hb1RTWmdISG5M?=
 =?utf-8?B?bGNuQkJYRTVobWVlcmtMaDBxTGFSVGFOaVRXWll6aGpNemFRMFRHL25YNkRw?=
 =?utf-8?B?Z1BZdDdnLzAxNHEvWjZVeUxmL3VOSWdTLzNWNmlIM2F5ekRRalpaalRIS3lL?=
 =?utf-8?B?ejJBamU0ajlMcFV2RE5vRWlNWCszeC8vUkNnV1FESytkN1J5UVBLZG4zOE9y?=
 =?utf-8?B?REFEeDMvSjNCTmJnSU1TajFlem9vbm1MY2Q3ajRYQzRGalhQTWRDd3lUMzlP?=
 =?utf-8?B?b21oRXNVc2JFWlk0dVZLdTZFdWJtbVdkMnJ1NFpJUjNKdHQ2MDI3S1FsenNM?=
 =?utf-8?B?ektSN3FBZEc0M1ZiclI4NE5JWDJFYlZyVHlhbGZUT0EyUTR3S3dDOURyNFpp?=
 =?utf-8?B?R0tyTGFaNHp1Um92bDhEYmVYR3h6VEQrTjZRbk5ZdExmYVdoNHVoQzRDN1h5?=
 =?utf-8?B?MEFKclZQUDl3RS9hazVRdjRwMkQ5TUhRTjZoRGpmTldtU0JsQnlaRlJaSWp4?=
 =?utf-8?B?Qk1Rcm5kSkhhb3pxbmJkeGVDQXVrelkxZGpnMzJ4aU4rcmJpZ2R6Lytid0pn?=
 =?utf-8?B?MlBTK0FSVmIxMEovVzZ0SVoxVHFnaWlGMWRyL1g4L0RhdVJ0WmlVVjd4bHZI?=
 =?utf-8?Q?b8fI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnEzN1VQZzk2b0VVRG5MMElOaDNmdy9PL3FpNTZoYTRSeGFFNEwwZ3hoU0Nk?=
 =?utf-8?B?VnVNK2RLZ1QwVy9abUtGRGd4VW84WC9paFdiK2xxY1RLVzU3K2s0Q0Ywb0Z4?=
 =?utf-8?B?eWordzFaMlZ6cSthZmhsU3BENUlDaFQ5bk14aWVJKyttWmNYbEVVZjlhT2tp?=
 =?utf-8?B?cmJTbHQ4dlkyMEprLzZGSndOSzNMZVowcGhEM0FOSXZCMGtNVVN2TGtXT0Fs?=
 =?utf-8?B?b1ZjcnA2Tk1FczJjeTcvdVljZkZhMkdBMC9PQzYwSzRZN0FjbkY5QzVud3Za?=
 =?utf-8?B?M3kxeEZuZ1gzbWJrRW8vcnRFYkhDSFg2Zm4vL096U1B2aUJFYmNCVHNhdDJa?=
 =?utf-8?B?T3d6MVRSZlIvaGsvSU1LeFR0RlZydXFCVTQra1NBcUhRQWZaWk8rRVdub2tz?=
 =?utf-8?B?ZjdqV1lEZnY0LzZIeHhzRDhkTDNwR0hOeVQxLzRqOXVxSFpYMmZFdjd1b000?=
 =?utf-8?B?d2c0NTVEOW9LYVM3RWl1bmZiSkFwbSs3UktlTDRHU0RYUVVRNzlYbWkvcmZV?=
 =?utf-8?B?SWZVSVhCRysyVk14SHZIMk5EN3E1R2l4bVc3emV0emZTeHkzZG8vVFFpQWYx?=
 =?utf-8?B?Qk1KRjViMStwUThaQ3p6SnptSXAzWnZ6SUVLZGdHaGRISG5IS0JXcUNiNXJG?=
 =?utf-8?B?UnhIYWdPOFJPQ3lVcDVMMjMySTVHUXV3a25qZjlOWW4vbXBQT0NpRzhNbi9U?=
 =?utf-8?B?SkR0TUJyYWlKbjdSRzZaaWlJSm5NVENoTlA1SmcyU1hiYWgwWFpTYmNBSkZh?=
 =?utf-8?B?cnh0bUNLc1lrMnIwdTdjcmhnV0dseGo0U1pFaDVEckVHTzZJV2UrdU92S2Vr?=
 =?utf-8?B?TXlvV0s0SnNVU0tWZnpIbHBnTmpua09KenFDR2EzN3paUG8yVGhhSzVFcVcz?=
 =?utf-8?B?K0puREF2ZTZzM280N1d3NkQ1Vlh1MW5YVmt4ZlNPcmhqejhVQ0U5ZXpzYkdy?=
 =?utf-8?B?NStNcjlmQ2VxL2ZOVEkweGFsaGsxOC9rTWdLbTdGSkFRQU1XRDJuQzlIcUFU?=
 =?utf-8?B?QlNpYmVPU1pqVUFuZDgwNm5RS2VUbE9IMGxoaVFCVi9IWVF6a1dEMmw4SE5z?=
 =?utf-8?B?VzZpeXoxVUQ5aUVwdHdjRUNrVmRPNmo1R3hxYWhITGtzT3EwakNEaDRKbUVm?=
 =?utf-8?B?cVZISUNNS254S294RG40L0s0TnVXSGpEbjhIZWZKZ1NIZHR1bVozUXcxV2Fn?=
 =?utf-8?B?dVUxVzFxQVJ5YzdDenA2TFdPMDZPN2gxNzh6NTl5dVJxWFQ5TmRTSDhzS0dR?=
 =?utf-8?B?LzZUNm9uczlIMHdkcmx5RXVxOWF1bmhLKzlrbTF3QytNQzExN2lGUHpCZVY0?=
 =?utf-8?B?QnVYK08vcmdaR2JZUUM4QVF2V3VCa1EwZzhYM215dmphYjQ2elZsSys2NnZt?=
 =?utf-8?B?SXZsQTgxaXgyOTBadTRVV0gveGxDd3d4dTdLajFTcERjUmJjajNjZWFPQ3NH?=
 =?utf-8?B?THNOZzVXQkxVZ2hrQ2JDMzNLRGo2bTRlVzRnSEhzMTEyR0hoYTAzd2RKMTVH?=
 =?utf-8?B?N1JlV0cwY1F4dnhWbDNxcnhtcTdVYU4veU9DZEhmS285NCtHRDc5aHd3RTVw?=
 =?utf-8?B?dmErMnlRaVJaUDY1TzUwZDBZYktuYWMvK0s2N0ZHd2tCL09CTGZ1K2drTHUy?=
 =?utf-8?B?ak8rVGdaMXFYMW9ibVVpb3hDMkRBTFk1MExvWENReGVIci9DUjNUU01JZ0FZ?=
 =?utf-8?B?ZmxyNHZmR3dFa2xQTCt5NEtRa3N2ckJMLysyUnhBQ0lTN0ZsWEhSK3NSNDZ1?=
 =?utf-8?B?eVdOc1RBNmozZFpJSVBRS1docDZGbW5sbFFpYnRYK1VScG1NQzJzeGUrWmZM?=
 =?utf-8?B?M3oxMGg3VXJKWk9maFplNHUzdGQ0WThscHpyQW5kZmdUSjNnMXp2ZENvaDhX?=
 =?utf-8?B?Sm8vbXRoL0lZUjYxZGpBRUNJQWVBUFhuS01meG1aMXQrVG1jY1VCa0p5TUND?=
 =?utf-8?B?UjlNNWdmbW4vbmhMY1dhWUtpbTZmdHpERUppbjlEOG1sbmMwNWo1K0VmSVVO?=
 =?utf-8?B?Z1BDcDlFczVuNzlIUER5ZkxRaWdvYXluekNiZ0NmeG51OFNRcm9vMW1ZNmpQ?=
 =?utf-8?B?Nmd5aHhvM3RBa1dyTHIxcXNKNlF0ZmwvOTk1MjJqaDQ1VVVsTkVaQVlqb28y?=
 =?utf-8?B?UjlaNk54QkIya05Gb1FWSks0a3NnSFhNWDhjeEQ3WE44d0FuZ1V3RWJqRW5G?=
 =?utf-8?B?a1ZKZmZVY0MxWTJxdWEraXQyTVhza0VEb2RvMkx5SWlCY3g2UTRPekRwbkQz?=
 =?utf-8?B?WmFXSlBJeXc0VkUvQzdodWtVNk12Y09oTCtuUWl1QTdxbWdTSldVWUU2b1A0?=
 =?utf-8?B?dnlHTmd0MDZrME9UL1JQNDJQbjd4QmtnQ0xyNXphemNVNzhlVTZxdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4msudbOqv4ssMXRKZlt9h7FwhoXRYNkVv6yfRzocnnV5/DDITgVbk8R7cF1sASPk05GXlWoSaZr4foYlatsI+2kDAibp77wz5Rj78/vwaVTaijaTKSxEO3VaZiC4GVTyyDhYGLukpzu4ocBTukJmiUUwZNJkXKhEvchmTl372jNIGanMmscV3sl+vmc0VM19FeYxIaWWYQH6rigOTTyNB9KlpJIUfIjUdWamE2FKczG7vZt4HS8xN8RgdcqOVZXKqLWC1cFbVr/YkpZXXUpWQxxDSmQo1+eixy1/TtPKPVCthrEHkByKKNwleqtpKvyEzxc7IL8tbjSmDOOzeHOHUdenZVUobOvcMNqZvbZcnE63XCOGCdnHXlLQwvJpNOXnMpWw83HjuPW34FwiDWUal88GiE5DQBtzwaLv5nPU17mPSqpCHES266jN5dKIGlmlOW11nXZEVzamw+vKKFIouOKK3D9Xlku9uicaJrtwYdqndkj2U50TBSUnR/JQ2gJFDcUCONXP0Vlsno8Mi3/YEpaCNPLrfvIg+Vh0CC2kED+XmtdMdSB5DSN1Vn9WzeEFYU5CDxC+kOl6ULeaqN0neemx1CoZbpZnM14HWDDKYWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bb291d-4974-4992-22af-08de6789e373
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 03:18:26.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+y/BQO6Lc6VeYM+ruNSuQ8FeOKlKVvZtxnVhjkMHML0Om7Px1gcO/oMP2EwVyBshmZMJ1JJ3MlUWxn2LH8lrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090025
X-Proofpoint-GUID: _AEvV-uM_cxq4CfBbOFVAPsA_JbxpV9g
X-Authority-Analysis: v=2.4 cv=FIsWBuos c=1 sm=1 tr=0 ts=69895207 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=usVUPduaKBOVpunCJtIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyNSBTYWx0ZWRfX3CLZzNX4Jyfm
 3Re6n9rBQuuMF0a0V8qU2ksRHGRGEko3lDYedN3FY+zP/r3189HJGul6Dd5gVDfLbuSmJKuNhVa
 0kz+O6MMkEXTIXH77TBBDf4CacxJLiWAqKKV8sVdmzVgZEzXNO32+N6J/rAl9ZAHj1QPSOOvq+0
 d+NF43zps20ylXT2/9MkJpvoo+PJuvXX/nfAGIymRfvZcUeSsDPAnsFxbF+Oy1iBI12EuXsSirJ
 IYVvzepas6yJYEXxglg4E8EzKrPDC5tJFIb9uKbX4p4gNv4CGgzJIFJ00GuWQTZpefLnHXKp0G9
 BGORDZzDOdPvttBqPt+xpdtyHWIqqo1dF2njTn7ovpTOyQIKekSy04RLNYXjhw+6iCV2XH3X4xt
 +UlDr9PmASv4UNpgIq198KR3rwiya4P7cKyqz/Yq9X0XWA3pw0G/WR1OVU8/FHlTJVIdvxROibZ
 r1Eq7TNmvnhoee/woZzwt/AjdzGAG2Wz+lBqcrwI=
X-Proofpoint-ORIG-GUID: _AEvV-uM_cxq4CfBbOFVAPsA_JbxpV9g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214875-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 889E910B5C9
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:19:01AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 6, 2026 at 10:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 2/6/26 18:13, Harry Yoo wrote:
> > > Lockdep complains when get_from_any_partial() is called in an NMI
> > > context, because current->mems_allowed_seq is seqcount_spinlock_t and
> > > not NMI-safe:
> > >
> > >   ================================
> > >   WARNING: inconsistent lock state
> > >   6.19.0-rc5-kfree-rcu+ #315 Tainted: G                 N
> > >   --------------------------------
> > >   inconsistent {INITIAL USE} -> {IN-NMI} usage.
> > >   kunit_try_catch/9989 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > >   ffff889085799820 (&____s->seqcount#3){.-.-}-{0:0}, at: ___slab_alloc+0x58f/0xc00
> > >   {INITIAL USE} state was registered at:
> > >     lock_acquire+0x185/0x320
> > >     kernel_init_freeable+0x391/0x1150
> > >     kernel_init+0x1f/0x220
> > >     ret_from_fork+0x736/0x8f0
> > >     ret_from_fork_asm+0x1a/0x30
> > >   irq event stamp: 56
> > >   hardirqs last  enabled at (55): [<ffffffff850a68d7>] _raw_spin_unlock_irq+0x27/0x70
> > >   hardirqs last disabled at (56): [<ffffffff850858ca>] __schedule+0x2a8a/0x6630
> > >   softirqs last  enabled at (0): [<ffffffff81536711>] copy_process+0x1dc1/0x6a10
> > >   softirqs last disabled at (0): [<0000000000000000>] 0x0
> > >
> > >   other info that might help us debug this:
> > >    Possible unsafe locking scenario:
> > >
> > >          CPU0
> > >          ----
> > >     lock(&____s->seqcount#3);
> > >     <Interrupt>
> > >       lock(&____s->seqcount#3);
> > >
> > >    *** DEADLOCK ***
> > >
> > > According to Documentation/locking/seqlock.rst, seqcount_t is not
> > > NMI-safe and seqcount_latch_t should be used when read path can interrupt
> > > the write-side critical section. In this case, return NULL and fall back
> > > to slab allocation if !allow_spin.
> > >
> > > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  mm/slub.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 102fb47ae013..d46464654c15 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -3789,6 +3789,14 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
> > >       enum zone_type highest_zoneidx = gfp_zone(pc->flags);
> > >       unsigned int cpuset_mems_cookie;
> > >
> > > +     /*
> > > +      * read_mems_allow_begin() accesses current->mems_allowed_seq,
> > > +      * a seqcount_spinlock_t that is not NMI-safe. Skip allocation
> > > +      * when GFP flags indicate spinning is not allowed.
> > > +      */
> > > +     if (!gfpflags_allow_spinning(pc->flags))
> > > +             return NULL;
> >
> > I think it would be less restrictive to just continue,

Ack.

> > but skip the
> > read_mems_allowed_retry() part in the do-while loop, so just make it one
> > iteration for !allow_spin.

Makes sense.

> > If lockdep doesn't like even the
> > read_mems_allowed_begin() (not clear to me), skip it too?

Yes, lockdep doesn't like read_mems_allowed_begin(), and thus
we should skip both.

> 
> +1
> Just unconditional return NULL seems too restrictive.

Ack.

I'll do something like this:

diff --git a/mm/slub.c b/mm/slub.c
index 102fb47ae013..cc686ab929fe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3788,6 +3788,7 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
 	struct zone *zone;
 	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
 	unsigned int cpuset_mems_cookie;
+	bool allow_spin = gfpflags_allow_spinning(pc->flags);

 	/*
 	 * The defrag ratio allows a configuration of the tradeoffs between
@@ -3812,7 +3813,15 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
 		return NULL;

 	do {
-		cpuset_mems_cookie = read_mems_allowed_begin();
+		/*
+		 * read_mems_allow_begin() accesses current->mems_allowed_seq,
+		 * a seqcount_spinlock_t that is not NMI-safe. Do not access
+		 * current->mems_allowed_seq and avoid retry when GFP flags
+		 * indicate spinning is not allowed.
+		 */
+		if (allow_spin)
+			cpuset_mems_cookie = read_mems_allowed_begin();
+
 		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
 		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
@@ -3836,7 +3845,7 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
 				}
 			}
 		}
-	} while (read_mems_allowed_retry(cpuset_mems_cookie));
+	} while (allow_spin && read_mems_allowed_retry(cpuset_mems_cookie));
 #endif	/* CONFIG_NUMA */
 	return NULL;
 }


-- 
Cheers,
Harry / Hyeonggon

