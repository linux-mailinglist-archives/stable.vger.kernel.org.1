Return-Path: <stable+bounces-244727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGWBAKu1/WmAhwAAu9opvQ
	(envelope-from <stable+bounces-244727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:06:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 877EB4F4BD5
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F207D305B2FC
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F63CE4B9;
	Fri,  8 May 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="bgrKKWaI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D13CA48C;
	Fri,  8 May 2026 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234510; cv=fail; b=LnSdOhg9RBdmcK3zckvhiZ//yJhYWsSJGAz/5tlfMUTEn7Ry11C9Lp3yaaPGAkgPRy2EB/MMhgBkY3r6QLx+XOQCH0Pq+5SFpdJz9h7rhyA6p3mx8TinqarLdeUYSvgqlBSeAR1Cuog/I8PcLUlMWrdlB/eKz/LD7Bzbjl+7TK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234510; c=relaxed/simple;
	bh=CuQ6Rx37Q3AD7X6b95bzyDiPnTEVh+kKcO+wFf4Anxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rcOeRwtxXp2YEo9zPjZA/hNm7X7mRzd8wYMjCKGSdtYTa+It/Q5p28BJ0hAXVsP7GGjBs76W883HgGmvhlRd0FiWgCEZU1KNhSZ4+NOFteQTjvSva/zWd70LMnAGFr3l8zRS3+ifw53cA7hCbsEpixy2eD93LZCCUCHG9WmykME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=bgrKKWaI; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6488T6gO203826;
	Fri, 8 May 2026 10:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=VWJaBp82KGAsYvmnr6kBlMWRjHQ9RZ7xZMhnNF3tQ4A=; b=
	bgrKKWaIv8LImJLI2geU78bqjEEjiqvYkBE6KwJsY2f/IyoM2cbklwnMSxQ7jRpV
	zlEKemI7Z6Wn/pvIhgwwUs8nxC/8oLMZz3bOZ/CoFNTf1OvkRT8rvKrDtQqfGE4o
	O1CzP/ClgQqnitidv+tVdF6jjnvSo5r2YpKBtpTVqPnkV6BOSoBc4VRj2s1ieAFl
	uRxcU6r8UJ/nG2sJa34bk2mETNslnGtfm0RzJrCy5je9YY2sAUad0qxDnnbtqi9J
	272rVcK7G4tDK6Kes/aJ1qea3ZTElpqCx+WleMbuYvfpLfGgxLopm0GYuCMz5HKq
	Btay8Bx6wZGOLgC1KqLVcw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1cbvr2n8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:01:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFhhqqCLwuHpIyLe4tWsjVQPjiYMwMhSFeHOhcz1dWoM9ptxmigVQcpdcsZ/M2rkilg72fuF4qb+NYsOL+kQmgu/XJ7xfJzsxAM6KqcJJ76ZuMfdp8CKKcr7aRUYvxN96Np9kyQC6ZVOQL4+AumeT/wBcENF/+QrKxsYJfIZQ+mYARQdQ3g+gQcVJQuLnbkOMkHdxDhLZZeD4nr1BqEBOHmVp0+ZyUqpwWmrtuDwONWQJIR3wTNM7VuoN4JinmVWyfTuVxADJm7TKvXXfc5Uxl+ZOVpKPIdYS4GUwmvTyYIt3rhB0E9PmlRBwNjMFA6A7OBICeZ4nsHePou8bEZJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWJaBp82KGAsYvmnr6kBlMWRjHQ9RZ7xZMhnNF3tQ4A=;
 b=Mbqn0Uq3U2paTKggYLzgHN6GAQVPRBfk+U9ppiazrjWafqA34PNFo9v1rxjQwLH4wZhnI8so31ArNQ57auWk/RuseOvCakCqtq7w7u+qlmKVJZxypXVjz1EpVvF7EAP8zlOcrx0hoPdDsoWf4eM0sqOdykA6+XhLx7hhLIUn11fQPVvcq7jKJ5I1X1EY++w2sQoNTJ9780HBdxRH+WCxqCPVEAdpoCZ6qqut2XpOq3779UXRtsR5ViVKY3uKYJU4u8qlPmbCdRUFTDW8PajlH/2DqzDFMiCt+Zt9Ho1e5WXSVPw2hKqkUolTHkPEh7C2QtDB6XI7up97i7xQvuPN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) by
 CH2PR11MB8835.namprd11.prod.outlook.com (2603:10b6:610:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 10:01:10 +0000
Received: from DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68]) by DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:01:10 +0000
Message-ID: <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
Date: Fri, 8 May 2026 18:01:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To: Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com
Cc: leon@kernel.org, kbusch@kernel.org, jgg@ziepe.ca, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
In-Reply-To: <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:820:f::19) To DS0PR11MB7736.namprd11.prod.outlook.com
 (2603:10b6:8:f1::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7736:EE_|CH2PR11MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed4255b-9ac3-402f-c4ed-08deace8baac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uG4lD+BgMzHNJEKK0Piw8ALtbYsptGT1D7GpiOjaeZNR8DjQBB3KMgMhjRkBjfjIjkXlZZTgKhKf9x0eHpE4OjhJxGHPhY5za3eNbj0jynnRtfjTDF7R3EW4lWdaXdP8Ki97wLrInv7EXYjREyYDjLJasagLylv0RYJigjeI7O1yd06PvapQ6IWxwJnKf+FmbkZA7tAasGu1og+Dh6zuqzyq2n6GUKmo8Y3tZ0ovS5C0kFjqHpQ08R0+KlZiDXZXvxciX0lcpOBVG0Ehth3AVhPRk42RQxrKcBmuMgUnRVnjrIe+a9VSTR686EKLsSRP13hFw55wXNgpANVrST1st3ytDZje3gaaa+li7BTvRuT+guM3KbNBMiwAQkjBVOW9HdtUQA51XmjhPihtBU3JP+JbgZR0gqUBUGX0AyotfAsaf0LO6UHCqfHPdoF8dMI3jtHod0EMjZIFjCecK7IPuhJ1YLiRPnmU9Lwhvbj4qL0NQNoAptaU5Kuzqn8vByVuIJuRRQlS/A5lv+LpChEt7H3y+/zbbwta5VDWRC7wwMMOK5zIy62/IhSG8xWLrk7NVTmPLDFTXFhUIETS+wOt1zBhOfhvzF6fe7Oag8dqjHEMI2VjPoZf1UnrMnPXcftXG31IU1I+iVMHjSfAUVuweEka+nChdXEhEg5RwqViDPVxjceOc4YVE4Rl1TsdHtqu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3JHTUJFUVVQRmErQkpTQmZZTHZTRVgweDNGZmJGbTNyYXJGR3RQOU45YWFy?=
 =?utf-8?B?TEQvdUsyV1dmclFTSFRiMHo4YTlYaHV4TjBvMGtmQlRkOUxuYmpTQnlvVHNY?=
 =?utf-8?B?WU9MZDIrbWN2WGdPVFprWGlsYU85T0JvR3hFMzVLVTZYV3ZVNXpQZ2JmakJZ?=
 =?utf-8?B?U204NElYcHc2cWEyYTQxLzVUUTMzVTlaeXlNMk1lQVhqRWtuRHkwbzgyVVFO?=
 =?utf-8?B?ai9vN1JPZ3ROcDFMOHdURE1IeTJFWWg0MkRJUWJ0S2I1ZjJJS2VId0pHN3hw?=
 =?utf-8?B?YkkySHR4UjNwTURTa0NDU2t5OGdnWUxXOGRKeDh3Qi9wVmNmbnRCQk9pMFF0?=
 =?utf-8?B?YVpUN2VjN1JpcVAwV1lPVDdjczZmZnVGS1hDdnpoN3JEUms3YXFDQ2ttb01r?=
 =?utf-8?B?NFhzcTVJU3l5cHRULzFBTDJkQldoUmYrb0d5VDJxMGYrYUxNenMzR2xaVUhG?=
 =?utf-8?B?S2MzZmJiYXRZc2NESSt5NjhZZm9ua3Yzb1ZxanJFbGRDcGh2Zlo5ZDdPRm96?=
 =?utf-8?B?eGdZbmM2Q2lsZk5jQnpCN01IbU5zeDFYODBUZEhrbjFsaXhoUmxHckd3bVpo?=
 =?utf-8?B?WTE4Q3hCK0xhQ0tYL0hDdkloMnVBWlMyS29NZ0IyNE5tUWdHVk5rZGExU25m?=
 =?utf-8?B?OEhDWktCcWY0NmdJQm5YYlBPL1JwUm55cGpaN1JSQ0Nnbk96NVV4V3BJREJz?=
 =?utf-8?B?c2hWNThaMkFqTytKWm0zZzhFTE9TVFk1OG9UYWNidGRCbWk3V3I2TzN3dURh?=
 =?utf-8?B?cmJMSlFUanBhV29TZDc0UHc0Yk5PWVNDSHZ3YlA2NUk3NytjNFhOSWdvQ1ZM?=
 =?utf-8?B?dE5rRVU1cTNLbm1YbkU2WUhyd3BmdnJ1ZkU3cXNJbjRSZE1kSGFiUkRVMXVm?=
 =?utf-8?B?cUE2SEdCLzhNcFAzK0p0YzBmbzFBTlU0VUtsQjA5YWw0akhSd0lSU05xc1pE?=
 =?utf-8?B?TmFqQVJ5cGgvWGdxdDRta0M1SWVPclNoRUlveXlQR05rbEpYYTFGd3BlRU5T?=
 =?utf-8?B?Nld5cTlxY0ZQcGY2TEh5b01pdnQrRUJVczNSbTN6MG1HdDVSY2tYcEVMWmpR?=
 =?utf-8?B?VFZtbHpMTGN5bjlVaEhjUHUrcVhUcmtVVkJjRjJLeVErOW83Z2V2M0hlRzZ6?=
 =?utf-8?B?Mk5rMEwrKzBORnVFVm9KUjV4a0xCY21jTEQyZERGRVJmdE95VVRmeGtkUWxP?=
 =?utf-8?B?MTNmaU1CUmJQZWJ3U01xSmY4Sm52bGtCL0dJak1yUVMzZkppa2NxUG5aZ29a?=
 =?utf-8?B?KytrZGozNkwyNWZFT1QrYXJkcnhRSVdUOWpZbDBudVdPUEhFZkNzaDlRY0k3?=
 =?utf-8?B?Um9WSXFrTFoxdTk2aVo5MmRQS0d4cGp4NVhEQ0RtSDdnS3YzYU9zQ1cwd2pP?=
 =?utf-8?B?cFhYaWxUTnBnNWJ1eUp6NXF6dGs3TDI5R3lvS1VISW5XNHMvRm9uM25BaTJi?=
 =?utf-8?B?a2JRT1liZ0puRWVRYUJMOGJLY1dYUFRCclR4VXhCOHZ3TzJiN1NkSVpqZ1B5?=
 =?utf-8?B?UlRaUnFZam9TdXdQamM0TThlVEtUM2wrcE9SV1VkNTRod2Y1NG5ZUlZ3ajhy?=
 =?utf-8?B?UnRMQzNobXBuVk42M0E2enl5UmhIbzdnWFBTYTdDenJ1S1ZhMVRFN3lJam5i?=
 =?utf-8?B?cFFPRGNnUGNFVDJuTGY4Y0dXMG9HQmE0VjFSbmNicnN2d1hiM3ViUmZtN0lT?=
 =?utf-8?B?dzIrQkhTRUd2QkJTK0d0NDNsa1RDWW5wenZkSXJwVnlmYldDYmVsYjFSWjBx?=
 =?utf-8?B?dHUycTRtR0NWVVdUYVJaZURGazcya0hwck5QdkFsN3FjZjlzT0NRaytUV24v?=
 =?utf-8?B?UEZnaXlLTEhNSnZxamI3NUNxUHBwMWcxRGJHdjJPWC95dnJEMjhjdGRoOEs1?=
 =?utf-8?B?L1Z3NGx5ZXd4bmVtUWVQRVVWcWc2ZDVGbTFFWS92N3p6Ky9PMGcvNmlydDJP?=
 =?utf-8?B?ZXU3NnR3anZleDIwZFpSalRJNDFublpkTDZaZ0ZRN3NWVlBEMnRGcGd6NHRr?=
 =?utf-8?B?Z2pPR0JLZDlTbzBYUGZEOWxGYnozRlAzd2hjV2NabVN1aHdMbG5uNm5xZ1hN?=
 =?utf-8?B?ZlQ5eTkvT2VvYWlOWTZxdkNEU0tPUGd6ZnpUL2pNb3g5cTV0R1VWTVFZclBx?=
 =?utf-8?B?MHJWWUNzTHZJbGZEUGphNXFxMDdvRmV4NlZjaTB4TGlVU0l1NDJBd25XOThC?=
 =?utf-8?B?b0NSMHpWcVVuN05EYXdXVG9WRlQ5dlZvRWlCS21LM29lWE9QbEZsN0dFR09W?=
 =?utf-8?B?Q0xkR29RbXJ0dmFJU1dpUXROMlZ0c3BTQ2pWaXFkSVV4bUtLT1diMitNbEw0?=
 =?utf-8?B?MHgvVWw2Rk10TzZXTnVQV1NFYVJieFhiOVVSYklyZGRTa2pCdmZzS1lNcGR2?=
 =?utf-8?Q?L1wxuJY0URU8Xi9I=3D?=
X-Exchange-RoutingPolicyChecked:
	TIyIHa2V4ofVXlrn222yvITDO6bbXCZdFHqcVePXk17K035gYp8z5yijJEqKs2aEoQzkQgqk8wVAFydCyd2hseZX9WabEgLnYsKKJ64N9YiR3ILdyppYkzryMrT99TB8f3dT1cfMVQpc2UOglSbsA1qmn8/5MASJn7v0emDchuqNIy5OoAuDHvfTr1MNYsLb6SDO7/aq6tMjVzb80sHHCWuGhm03beRaREeHgLCPGNiovq+sleo3JXGw5J1k45cUJbvaJz32GNOWSXWX1qgi1p5oJTNAiWr94LseSA0XzPMNs0pAaMaNCsTUp7HQr0w2DYIYFF1CYK+LVeo6wUrrSw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed4255b-9ac3-402f-c4ed-08deace8baac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:01:10.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYcPFbeck/irCUMF7jfEWx/FKJhGwleZun2X7lf2AGI76S18IBTRrUsNUwA7YQF0sNQ8S5RsQzSsNX3GfM/oS4WfvblxUOfC/Ligvjmn4LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8835
X-Proofpoint-ORIG-GUID: 6LwMlYeMefpiPpQs5R9U9v30NP7zw_-9
X-Proofpoint-GUID: 6LwMlYeMefpiPpQs5R9U9v30NP7zw_-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwMSBTYWx0ZWRfXwlq/VNl548vE
 WkuDWU0/9lTueIOplkM0IK3R+1Ftl6HrN0QKXAGDqCMTINiiLtJ3X+SqewbabsEHIdZUJG/AI5z
 Zum01onOl1NtMVoZSWEt2O/kdipEjUV0qtHWUno5dSYhyc1D+JnKnPQskqcFpNGvDL/bDHkwhFW
 q9b6PXfgC2lTTe6QeaoILemL4d1eSy9YC0R6XK/t2hDCrR5nF7VcMjHrSwLEe72lts8+nMt6Asr
 1qsZmeLP6q3lXpVOhmIZW0PN7K6drL2Rset7KxpHGpwJPPVEmXPjwt1QD+7odPRhmREy0l4ocNY
 zwyFyQjQohOi97d6mKTAFU1ajoFaY2rCggWD/4grCLChQPanORPNukI0v1hMD4OVGWn/MYtLMmO
 2rPmr7ERomQ+cRPb8w7pXZk2zsSorw1kmSGPqReK8cV2z2SJDvSO66yMJkdyk/NJR68FlqNG+Xm
 CSs0HRJNDMr2DyfEWdw==
X-Authority-Analysis: v=2.4 cv=U9iiy+ru c=1 sm=1 tr=0 ts=69fdb46b cx=c_pps
 a=guboMCJq5DUNhCsQxgR9jQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=23wbk4N_KxE_iVXtykIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080101
X-Rspamd-Queue-Id: 877EB4F4BD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244727-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:email,windriver.com:mid,windriver.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianpeng.chang.cn@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



在 2026/5/7 下午9:18, Robin Murphy 写道:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
> 
> On 07/05/2026 4:21 am, Jianpeng Chang wrote:
>> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
>> However, pfn_valid() only checks for availability of the memory map for a
>> PFN but it does not ensure that the PFN is actually backed by RAM. On
>> ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
>> share a section with RAM will falsely trigger the WARN_ON_ONCE.
>>
>> This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
>> the SPI FIFO register (0xfe204004) falls in the same sparsemem section as
>> the end of RAM (0xf8000000-0xfbffffff), both in section 31
>> (0xf8000000-0xffffffff).
>>
>> The pfn_valid() check was originally removed by commit a9c38c5d267c
>> ("dma-mapping: remove bogus test for pfn_valid from dma_map_resource")
>> but was accidentally re-introduced by commit f7326196a781
>> ("dma-mapping: export new dma_*map_phys() interface") during the
>> refactoring of dma_map_resource() into a wrapper around dma_map_phys().
>>
>> Drop the pfn_valid() test from dma_map_resource() again.
> 
> As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
> would be enough for what we want here, although now it's strictly under
> CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
> might be less of an issue. Either way though, now that it's all
> channelled through the single dma_map_phys() path, it would probably
> make sense to consolidate any MMIO sanity-checking into
> dma_debug_map_phys() anyway :/
Thanks for the suggestion. Move the check into debug_dma_map_phys() is 
indeed better, and I will replace pfn_valid() with pfn_valid() && 
!PageReserved() as you suggested.

Thanks,
Jianpeng>
> Thanks,
> Robin.
> 
>> Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
>> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
>> ---
>> Hi,
>>
>> I found the WARNING in dma_map_resource() on Raspberry Pi 4 when using 
>> the
>> downstream kernel from https://github.com/raspberrypi/linux, which calls
>> dma_map_resource() in bcm2835-dma.c (mainline uses the physical address
>> directly instead).
>>
>> Although mainline bcm2835-dma does not call dma_map_resource(), the bogus
>> pfn_valid() check can still affect any other driver that does, so it
>> should be removed again.
>>
>> Thanks,
>> Jianpeng
>>
>>   kernel/dma/mapping.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 23ed8eb9233e..e6b07f160d20 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -365,10 +365,6 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
>>   dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>>               size_t size, enum dma_data_direction dir, unsigned long 
>> attrs)
>>   {
>> -     if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
>> -         WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>> -             return DMA_MAPPING_ERROR;
>> -
>>       return dma_map_phys(dev, phys_addr, size, dir, attrs | 
>> DMA_ATTR_MMIO);
>>   }
>>   EXPORT_SYMBOL(dma_map_resource);
> 


