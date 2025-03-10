Return-Path: <stable+bounces-121665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF33A58C82
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 08:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0383A74DB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467781D63E6;
	Mon, 10 Mar 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tf1nj7fF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xnnbCFnO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F791D5AD9
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590672; cv=fail; b=GiZeUZu14H9KH7IsarJwaCGK3wUK102wNBy3amicguY2iYRUu3CXFiNXfhVY3b1DKnsLjqL7/xjxbem0OJEwHGGyie2k2xjp8fH7RkrQh9SUymNVzuofAaNbVtOYrATC3d2WZgeqBksGK631qtRCEF3ysWtrrdrz0wGWjUHDTag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590672; c=relaxed/simple;
	bh=IgUwAKXewMpQpuNEoVhEf0URwdQ5qxu+dnZSm3WpaQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQg9vP/ams8vmRUG57WAeoNMr6AsVlBXj5yTDcWv4ZQ26RQXAEfKTWkT2I/J1Y3L5Z3V5a1HR0cYt/rGOBjikSUV2qScTEsS5JM+SLWmfVnu0dwAplI3sUesNiDlIHlLfOHPC+wTxMMnXcP9Zm6EETmFEz6FrwTPX7e0CZVLbiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tf1nj7fF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xnnbCFnO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A6fhl3031347;
	Mon, 10 Mar 2025 07:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GKjW/LIU/uOCCgmwwgDkHRvlkH78ZzCwTTa6sZx812w=; b=
	Tf1nj7fF44bdHlIc6VQqt7WV+3N0RI77fD59YgQTi7Xz+0gpZ7Er2oeRw+nLWm8v
	83afRcfUEiBQXdpzXwYHdH7X/cvece6foExwrukOi4CMDJm06R6JBDx+u+VHGteE
	i5ROznquDvVHW4LJQaJajWJPvmkZHaXkFNgjadntDELoqc/RkLlJV+j53+jiZHYv
	vVaIlVY06mZp/c+iHPLDwOdfwrHlRWH9oD6gpjNeizUYX71CHWORyQpPNv45ip8v
	CitmG0JTJpiUdbpgHne0iZcUWSXPv+Bjicme4uqS3wTH+ZFYkbE7E1JEfVwwUEt9
	16ahatbvQ0KA7YVS9jh5DA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt1vjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 07:11:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52A60He6026274;
	Mon, 10 Mar 2025 07:10:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb76ntj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 07:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBKCqUCsc+ofRwdIVbBONnKvtS4Iy8aVMyBqpzSI2n99JpOIBSIZA2mc+2YvXro2tqHlMEhi7HJzuw+Yaf3tJxQqaC2UQa78wFfFqH/aw4VjC3D4DzJjBIQlP32zF5Tt7jpcUeo1urSEp3n5+0QKoVaHFamD17bcOlGr4MRruSLcz1OjI3BMQgOQ9M/pqtTycVKCyy0jojnGqDz9vFnxfESmLige6hYNFuB1G9Oji3wSZ6BWMDu8C5+l509SubGjcM9L4j/QVEJqistli/Bp5JXqfcKGuMc/EkKRukXKBDCS4qxP85622a77IXPiB3T/ywGJmVeNZVtwzWW7pkyQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKjW/LIU/uOCCgmwwgDkHRvlkH78ZzCwTTa6sZx812w=;
 b=QBdgw6XpPfXObyLXigDec8fUq9HLnU94HGI7OQzN0ac7Rk6rV5pdS2uDIfcIEaih4P1tY3TXIpEH40BXhoDIv9XPPUCdzDLOknp5oFz0BknXjllgJJxIdozBd/dHQ5SZuZ19nudJfsXApPj5eACb4lol7SWxjmxgkXOkjkce20fBlrqd/zAtkI3JAQsyR66N8mhlXu6bEuWo470iOnYYkSBky+LMKJWosYQSFvODC899bVnvAgWlynmikvhT2lzisD6dL2+lCce7gdfPiQ60sh/XGjarI8VxGIQBXHkHryFJbTNOCY7+nkLwIccjQIPOsW/vZkJR6BZsTsqGSVeKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKjW/LIU/uOCCgmwwgDkHRvlkH78ZzCwTTa6sZx812w=;
 b=xnnbCFnOfkVco2kkX5Pnr0YVx0aYRUxf+FwmQlwRZ9JMZ2+GtTM+mcxsnoCnIjIEde0bwRi2H/iSaJ/VUy1rp9w5MnBSd+tTvykhhg1oKwru1Fs6bJamzFeQNntQq/BkPIlEZnNUeh2P20Iy4w1eKTlztCXkP+xmb0L/+Rk2yic=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by IA3PR10MB8417.namprd10.prod.outlook.com (2603:10b6:208:573::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.18; Mon, 10 Mar
 2025 07:10:57 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:10:57 +0000
Message-ID: <f03b7bbd-20b1-494f-a35f-657ea04eac30@oracle.com>
Date: Mon, 10 Mar 2025 12:40:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] sched: sch_cake: add bounds checks to host bulk flow
 fairness counts
Content-Language: en-US
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>,
        syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com,
        Dave Taht <dave.taht@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20250305110334.31305-1-hagarhem@amazon.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250305110334.31305-1-hagarhem@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|IA3PR10MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bb764e-65e8-4761-6781-08dd5fa2b410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHlYckFnZGRscGs0cDdZc3lYMFM0bWdPV1pxZXRleUkyb3hoNU1XMGlJVlhs?=
 =?utf-8?B?RWFhZEVvVzFnNEZNWUhObFB1NkZiMjBOZC9Pc1JqU0lSVEJuejBhOHdaQmV3?=
 =?utf-8?B?QTE4R3RpdlpEY1JHOHpyd1dtcm5VTThBUjkvVGEwTTZDWk0xWXBNaTRIREZJ?=
 =?utf-8?B?YjhJcDRGWnM1VTB4eVkvRlFrcjM5YlZXQXYxSVhmaFdLUTNyVWl5T05Wc1ps?=
 =?utf-8?B?TGJPeTdiYmxSSHR5NnNtaFpJQlNUR1NMVTlBdDVITElMRnF1UlQxWnZKTEE4?=
 =?utf-8?B?MkN1ZlZMRlBsNmNpUERMcUlSTDYySWJZVjVlLzNDVWh0SVZUcEdSMElCUnEx?=
 =?utf-8?B?L0N0VXZCSDVnT2syV3h2dlF2Sk9ieEFkUEt6a0Z2S1E4TkYvNUpaejE1dFE2?=
 =?utf-8?B?RmxPWktmNm01OVhvVms2Q0gwWkRwSWRJWXNpbXUwYkF1ZFR3SGRiaDhYaHNr?=
 =?utf-8?B?WTdZQzF6R1ovVjE4RE1ZWjQ3TThWZ3pxL1NEcFgySGExc2ZhckpESWtxNkl4?=
 =?utf-8?B?bEY0aVI4TmVmRjZGS2FVQnJRU1NLOU5IbHNQbmF4OW1hRlo1dUVCd29TNjdn?=
 =?utf-8?B?UFRnQ3NuUEdWczdBaEtSWTdOWHIwQ090bUVKZVpsOFhxYWNVSVRORjYvY2Np?=
 =?utf-8?B?WWF2S25lY3JFNE5pbDg1Y0d3MVBJY3BNOHFZUVR0ZTRQREU0aFY1Y0x3dmYz?=
 =?utf-8?B?cFZKMUt5R05JYzdLWThFNUpJSXk5STNxTUh2Y242S2VFdjE4MG5mSWdYbXVC?=
 =?utf-8?B?YS81dldEQkswYW5DOXRWcldBM0dqZkFMa0N0U1BrY2IwTlZwbWs0TmVOaEdC?=
 =?utf-8?B?MHN0bmhuYmwyTGZVS0dpK2xnNUx3d2xoTVJ3akt4L1RSTzJHcU9Nd0FJM3R6?=
 =?utf-8?B?Y1RzVnJuQVkydUZTNktCcGFld2gwMExELzY1N29jdzFlWHpNS0VFeDhWWUNm?=
 =?utf-8?B?NkZPcDRVSXlPRGt5V0tiNWIzVWRFK1hLM20wVkJzSEdsQjlHdEhQd215elJO?=
 =?utf-8?B?VGpiYWhPQTNkZGxxWTRXQll0dlAvRGdXbkJyb0ZvMnozWnJlSkJCVkw3ZnBp?=
 =?utf-8?B?YWhNY1N6YjRIaFhYa1RCMngzellOM1M0WVc3NmpJN2EvMW1jQStRdkl6Z3lr?=
 =?utf-8?B?RDhiN1RsQTFqYWFVckZkdGljT0RQb2lpd0h2YkpwcVBrNEVadXJ1bEhqckgr?=
 =?utf-8?B?bGJVQWFXbkxGWlpZZHQ0MjZ4UGwraDhFK3YvbFYwSU1mbGNrMzdEOW9oZnFo?=
 =?utf-8?B?NEhFeWI1UUw0d2ZxL3h5L1JPc2Q3b2p4dW13QWEyakI1aWNtU2txUkhqMmtU?=
 =?utf-8?B?Mk5XUTU1c3RCNlYrdkNNNkFvdzNFMmV3OFhmQXpIZVlHaS9qaGhXa3EyMlU2?=
 =?utf-8?B?UlhpYW1OanRwUzQxUHVHcjBaQU1EWnBLWTlabHp0bk82aG4wOEphYktSTGxH?=
 =?utf-8?B?VGhROFdLUGxRL0dsOXZ1OVptbVQzY3N1akhGYVRSc1EzQit0ckY5elhuZ08z?=
 =?utf-8?B?TkZNQkJRNWpTeTgrYUFtWjlNdzBWNXpseWE2MnlrbXgvQ1BEdUUxa3VGNFdm?=
 =?utf-8?B?cHRCVFpGbUdjVW5PMm9SOGFxRlU1NDREV0llQWFtZEswdXZxVnAydnV4dDBq?=
 =?utf-8?B?ekh2b3F3aUoyWUFNenMweEpBYWpTZWk4OFc4aWFPZEw5U0RoMDg1ZWkwZ0R2?=
 =?utf-8?B?K1FrVlBiSzZmeUliZExTcGY5cmNUUVEySER6RGJyaGhxQWJBcE5oZ28rNUJC?=
 =?utf-8?B?Zm02YzhDSzB6Tnp3ZmZ5dHdPT2dqUnZHR05WUU1aSFlFQnI0dThKUXlrbXFY?=
 =?utf-8?B?WUoybHBQUmZjaXh5QklmZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S256UEtDd3dqYW9abnhSRC9kS3ZwRVVmN3VKd0N0djNyYVppYVR1SGVtZTll?=
 =?utf-8?B?Z2c5TStublJ5VHhRM1RZdVlvVVdud3RvV0lzeVNUTCt5aSs1ZmtuQndLVmEr?=
 =?utf-8?B?Wk5JWXRQTFZpa05hTVRGZGpVTW0wSXlYYzYvWFpoM0hDeXhGQXNpQURIQUFB?=
 =?utf-8?B?MnpsYlFubFU5S2xudUxTK1JTWW1saWZSbDVXK0puRXRUcElqKzREWHpkT3RN?=
 =?utf-8?B?Q2ltNW00eE92OSt5amdUSXFJU3QzWEFIMTNadFRuNXNRbDhTY21RYzlLVmg3?=
 =?utf-8?B?SmdzZnJxQUZydUNDMDZxYUtJQ1Zwakk0K0xBKzB2cTlrU1l3WFFzWWdybmpB?=
 =?utf-8?B?b0ZLQ0s0ZVZpTnBQVDFpa3piSzMvK05RUXlVS0kyeEFOUFRhdEpQN0V3MjFk?=
 =?utf-8?B?VTlHQVFSS3djVFYvckQrTGtlSlVXcDJaRXg1VnpDVlpVSUJPSUFLYm9wcWJa?=
 =?utf-8?B?bEMwVGJTd3R3OWtxbGFWY1RLVjVjYWlkbDBIY1Z4aHo4MVZ6V0ZRaHMzclN6?=
 =?utf-8?B?RG5aTG5JaWNLUkE1QzJpdFdCUU52amFuMlNKdEZQUktqUlFBaW84QkVlazFu?=
 =?utf-8?B?cndRMEZ0MWNOTFhZUjFLSEhMdlZlaEo4VUJwTDdBdzUwTUt3UHZtYS8zaU44?=
 =?utf-8?B?NnVXVSsrZkcrYjAzbnRZZ2o1WVhYOEwyQ1l6Rmx6UkI3MFl5d08zNStZbzFY?=
 =?utf-8?B?dTNoMkVKejhzS0dEMlFCRU1xWjAwb0srMDhJV2c3SURlamRTVkJEaU1ha0ZX?=
 =?utf-8?B?UnZ1MVZRQi9tY3pzVXF6V2NpL0greXp1S3ZUbjFSYXluQTN1aFFwSjRVS1BP?=
 =?utf-8?B?bmlOb1RBZnlxSUxpeXNJVGdsRitPeXVLZmVEQUhja05xU2UyMmhFUS9weFhz?=
 =?utf-8?B?VkxLTW43RGxmVENVNk9VMUQ0L2pHNDQ1NjZRY1I0QU1jRkxpNWxQWVFBS0Vl?=
 =?utf-8?B?bENPMU5NV1hXK003NW85OGJ2anRzeW1Ha2ZVNFZqa0o0VktWWkgzanhxelNT?=
 =?utf-8?B?U3RyL2VMQ29kN204SUtldzFRWlFxdE5PZWdqeHIzNHBsaUIxWnMvUnQ0cGkr?=
 =?utf-8?B?TENXYTlpek5zZmVoYkd5Y2FreTAwTXhKaHNoNnpyc29sL0JnUnFIWU13cTdL?=
 =?utf-8?B?YjFGZmpmUkprdzNoT09aMmpsN3NrdTJmUlRJTkR1RlhWUThBSmdiM0IrY2ZM?=
 =?utf-8?B?SEFmRitXa1I5YXo3ZE51bkdpZi84QUZ4TngyZU1jcU8rUTh1YytOV2RubTNY?=
 =?utf-8?B?d3RERzE2Q2NPQUZGaEJFeTZVWlVQRVc0VlhTYjZQNlIxZThHRmZGbG4zY3p2?=
 =?utf-8?B?Yk1OZXlWOFFsSGlmUUtCTkxRaUpvMzg0YzVYejZGWjhua3d5M0I3OGlOZmp2?=
 =?utf-8?B?OUVQVlpzK244RS9RSHFGOEx1b3BPSzBYbjFOL3gwSE93S0haUHdRNlRnT2Jz?=
 =?utf-8?B?YW9zRHg3ZEVGaDhnektMemZIZHFLSVNOcFRNRGpyU29pdXROSDZ5akh1OURi?=
 =?utf-8?B?dzdFbjNVSVd0cGltNmFNS3lWdGE0NWI4NW1pZE5oMDgyZHA3MEQwb092b1Bn?=
 =?utf-8?B?eEFkczlXMEZsY3RJbkw4ZmNkQzRTOXBWdklHbzNqVjg0UWNsUXlYOGRPWEM5?=
 =?utf-8?B?NExFNzRmMzhqamR5RnBVK20yOHM5b1JzTkdOSmEyaytFWk5lNEJKMjhaOC9q?=
 =?utf-8?B?VUpLZ08yQ3ptSkxseCtYNXhOVTgxQk9jNVdWdXExWnZacGlEemsyNEF4RVZK?=
 =?utf-8?B?RmpxRXp1dkVkQXpPaXdOTkExMTN1T0YxeHE5Vzdrc2tOc0hyVnpJcHAwd3lh?=
 =?utf-8?B?OU9OMVVDU3FrWjhVbzlnR3ZFT2xkUjNWdldJWnlhRWlXc2lodVAzazgvQmQy?=
 =?utf-8?B?djNIcnpIMW05NHMzd0t2VnlPb0NuajQvZjJtTXNST2Njekg0WFVvV3pyYk1o?=
 =?utf-8?B?MFpxSUtqT3U2dFpaS1RMK0p3dTkxRlNLdGMyZ3ZVT2FZbnM3SHZmS0gyL3hu?=
 =?utf-8?B?Z2NkVnYwZVRiZVloYllXbklKVVdadWRjY3FUN3JEcWZzMG1waFFTdUVXU3F0?=
 =?utf-8?B?Tm8xSloyRE9JRnhwcWdXMnJMV1lJa1VhTXRDLzc5bVJNQW9QNHVtQTV2UUV5?=
 =?utf-8?B?ZC9HOFN2d0xtajdFZmhmN2tTUGU5NnV4NTI2VXJNcThWY2RBeVJCN2l1b2pI?=
 =?utf-8?Q?zb40Bcoga21rSXGwWUxNWSo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l650TjLdv3+s+tCvJk7PiDhBEdx1VZ6WocsSospr81i98r6o2bWEnMNzMraYccdgRPXPwFq+qNCUhCAVIB9Y/RYHyjqtsfO790s6Pnm8byn2Elx99oP1H0P/+zfB6uW9inRn4at25NrStZMTPh+ghIrGOsMbx82tIy7UyDEmuZQ5IBmw4T93XmxDfccGnG+6k1VVCHn8rlJeedrIJgrUXeLOcim0KXxfCF6mICkAmJefq5FgHgPHER6tIUY9DZjS5cnuVPx7IM9LFCa6jFwx65y99OzD3t3dEl53erqOQpwBWYewvoEYTxpCO5jIWOpxSUaih1yXhBdY5EPcRkKhEp8G2cwWgQC/mdO4R1ISDG5mo6La0zREdTUx2toxPu5QHfpBECl48oyLTJSfyRuQ1tvjJIVhBOwZGiZnrqULGUZOeE5ab+U21+u1Km4qiUXhSFuc6hN24zOkfQ5Y7pgSYrlIY71SyMYSM3EeZxJtXJpuMj2zujCbgVV+ZZitenBW6KMSZQZ0psJLf+i2P2tu5KzDyIM6pqfAkq1zvUzZZHfu8XV0huRbPQvCStzjzy1JRudIluVPQk3GYfV5J8Ib6fwROYoWZpPzuyaz+DZSfRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bb764e-65e8-4761-6781-08dd5fa2b410
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:10:56.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLvCtUV3TBFWavDl7uERSuexXdrKMYrI/VV/yGWDkMXtREb418uMhElQibZQsdFBNJlwpcNzZn+pAx3iKS/4PXaCF7w4ZvQ3y5kxMTH3KdYGTUkEQqZ4xWpvv4x/n6X5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100055
X-Proofpoint-GUID: 1MgtafBT_qDYe-dYaZKXQWGX7wflbCts
X-Proofpoint-ORIG-GUID: 1MgtafBT_qDYe-dYaZKXQWGX7wflbCts

Hi Hagar,

On 05/03/25 16:33, Hagar Hemdan wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [ Upstream commit 737d4d91d35b5f7fa5bb442651472277318b0bfd ]
> 
...
> Fixes: 546ea84d07e3 ("sched: sch_cake: fix bulk flow accounting logic for host fairness")
> Reported-by: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Acked-by: Dave Taht <dave.taht@gmail.com>
> Link: https://patch.msgid.link/20250107120105.70685-1-toke@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [Hagar: needed contextual fixes due to missing commit 7e3cf0843fe5]

 From a backporting point of view: (for 5.15.y , 5.10.y and 5.4.y backports)

Looks good to me.

Notes: Used (prandom_u32() >> 16)) instead of get_random_u16() in 
cake_get_flow_quantum().

Reviewed-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> ---
>   net/sched/sch_cake.c | 140 +++++++++++++++++++++++--------------------
>   1 file changed, 75 insertions(+), 65 deletions(-)
> 
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 8d9c0b98a747..d9535129f4e9 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -643,6 +643,63 @@ static bool cake_ddst(int flow_mode)
>   	return (flow_mode & CAKE_FLOW_DUAL_DST) == CAKE_FLOW_DUAL_DST;
>   }
>   
> +static void cake_dec_srchost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_dsrc(flow_mode) &&
> +		   q->hosts[flow->srchost].srchost_bulk_flow_count))
> +		q->hosts[flow->srchost].srchost_bulk_flow_count--;
> +}
> +
> +static void cake_inc_srchost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_dsrc(flow_mode) &&
> +		   q->hosts[flow->srchost].srchost_bulk_flow_count < CAKE_QUEUES))
> +		q->hosts[flow->srchost].srchost_bulk_flow_count++;
> +}
> +
> +static void cake_dec_dsthost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_ddst(flow_mode) &&
> +		   q->hosts[flow->dsthost].dsthost_bulk_flow_count))
> +		q->hosts[flow->dsthost].dsthost_bulk_flow_count--;
> +}
> +
> +static void cake_inc_dsthost_bulk_flow_count(struct cake_tin_data *q,
> +					     struct cake_flow *flow,
> +					     int flow_mode)
> +{
> +	if (likely(cake_ddst(flow_mode) &&
> +		   q->hosts[flow->dsthost].dsthost_bulk_flow_count < CAKE_QUEUES))
> +		q->hosts[flow->dsthost].dsthost_bulk_flow_count++;
> +}
> +
> +static u16 cake_get_flow_quantum(struct cake_tin_data *q,
> +				 struct cake_flow *flow,
> +				 int flow_mode)
> +{
> +	u16 host_load = 1;
> +
> +	if (cake_dsrc(flow_mode))
> +		host_load = max(host_load,
> +				q->hosts[flow->srchost].srchost_bulk_flow_count);
> +
> +	if (cake_ddst(flow_mode))
> +		host_load = max(host_load,
> +				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
> +
> +	/* The shifted prandom_u32() is a way to apply dithering to avoid
> +	 * accumulating roundoff errors
> +	 */
> +	return (q->flow_quantum * quantum_div[host_load] +
> +		(prandom_u32() >> 16)) >> 16;
> +}
> +
>   static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
>   		     int flow_mode, u16 flow_override, u16 host_override)
>   {
> @@ -789,10 +846,8 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
>   		allocate_dst = cake_ddst(flow_mode);
>   
>   		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
> -			if (allocate_src)
> -				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
> -			if (allocate_dst)
> -				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
> +			cake_dec_srchost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
> +			cake_dec_dsthost_bulk_flow_count(q, &q->flows[outer_hash + k], flow_mode);
>   		}
>   found:
>   		/* reserve queue for future packets in same flow */
> @@ -817,9 +872,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
>   			q->hosts[outer_hash + k].srchost_tag = srchost_hash;
>   found_src:
>   			srchost_idx = outer_hash + k;
> -			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
> -				q->hosts[srchost_idx].srchost_bulk_flow_count++;
>   			q->flows[reduced_hash].srchost = srchost_idx;
> +
> +			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
> +				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
>   		}
>   
>   		if (allocate_dst) {
> @@ -840,9 +896,10 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
>   			q->hosts[outer_hash + k].dsthost_tag = dsthost_hash;
>   found_dst:
>   			dsthost_idx = outer_hash + k;
> -			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
> -				q->hosts[dsthost_idx].dsthost_bulk_flow_count++;
>   			q->flows[reduced_hash].dsthost = dsthost_idx;
> +
> +			if (q->flows[reduced_hash].set == CAKE_SET_BULK)
> +				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode);
>   		}
>   	}
>   
> @@ -1855,10 +1912,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>   
>   	/* flowchain */
>   	if (!flow->set || flow->set == CAKE_SET_DECAYING) {
> -		struct cake_host *srchost = &b->hosts[flow->srchost];
> -		struct cake_host *dsthost = &b->hosts[flow->dsthost];
> -		u16 host_load = 1;
> -
>   		if (!flow->set) {
>   			list_add_tail(&flow->flowchain, &b->new_flows);
>   		} else {
> @@ -1868,18 +1921,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>   		flow->set = CAKE_SET_SPARSE;
>   		b->sparse_flow_count++;
>   
> -		if (cake_dsrc(q->flow_mode))
> -			host_load = max(host_load, srchost->srchost_bulk_flow_count);
> -
> -		if (cake_ddst(q->flow_mode))
> -			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
> -
> -		flow->deficit = (b->flow_quantum *
> -				 quantum_div[host_load]) >> 16;
> +		flow->deficit = cake_get_flow_quantum(b, flow, q->flow_mode);
>   	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
> -		struct cake_host *srchost = &b->hosts[flow->srchost];
> -		struct cake_host *dsthost = &b->hosts[flow->dsthost];
> -
>   		/* this flow was empty, accounted as a sparse flow, but actually
>   		 * in the bulk rotation.
>   		 */
> @@ -1887,12 +1930,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>   		b->sparse_flow_count--;
>   		b->bulk_flow_count++;
>   
> -		if (cake_dsrc(q->flow_mode))
> -			srchost->srchost_bulk_flow_count++;
> -
> -		if (cake_ddst(q->flow_mode))
> -			dsthost->dsthost_bulk_flow_count++;
> -
> +		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
> +		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
>   	}
>   
>   	if (q->buffer_used > q->buffer_max_used)
> @@ -1949,13 +1988,11 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>   {
>   	struct cake_sched_data *q = qdisc_priv(sch);
>   	struct cake_tin_data *b = &q->tins[q->cur_tin];
> -	struct cake_host *srchost, *dsthost;
>   	ktime_t now = ktime_get();
>   	struct cake_flow *flow;
>   	struct list_head *head;
>   	bool first_flow = true;
>   	struct sk_buff *skb;
> -	u16 host_load;
>   	u64 delay;
>   	u32 len;
>   
> @@ -2055,11 +2092,6 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>   	q->cur_flow = flow - b->flows;
>   	first_flow = false;
>   
> -	/* triple isolation (modified DRR++) */
> -	srchost = &b->hosts[flow->srchost];
> -	dsthost = &b->hosts[flow->dsthost];
> -	host_load = 1;
> -
>   	/* flow isolation (DRR++) */
>   	if (flow->deficit <= 0) {
>   		/* Keep all flows with deficits out of the sparse and decaying
> @@ -2071,11 +2103,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>   				b->sparse_flow_count--;
>   				b->bulk_flow_count++;
>   
> -				if (cake_dsrc(q->flow_mode))
> -					srchost->srchost_bulk_flow_count++;
> -
> -				if (cake_ddst(q->flow_mode))
> -					dsthost->dsthost_bulk_flow_count++;
> +				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
> +				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
>   
>   				flow->set = CAKE_SET_BULK;
>   			} else {
> @@ -2087,19 +2116,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>   			}
>   		}
>   
> -		if (cake_dsrc(q->flow_mode))
> -			host_load = max(host_load, srchost->srchost_bulk_flow_count);
> -
> -		if (cake_ddst(q->flow_mode))
> -			host_load = max(host_load, dsthost->dsthost_bulk_flow_count);
> -
> -		WARN_ON(host_load > CAKE_QUEUES);
> -
> -		/* The shifted prandom_u32() is a way to apply dithering to
> -		 * avoid accumulating roundoff errors
> -		 */
> -		flow->deficit += (b->flow_quantum * quantum_div[host_load] +
> -				  (prandom_u32() >> 16)) >> 16;
> +		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
>   		list_move_tail(&flow->flowchain, &b->old_flows);
>   
>   		goto retry;
> @@ -2123,11 +2140,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>   				if (flow->set == CAKE_SET_BULK) {
>   					b->bulk_flow_count--;
>   
> -					if (cake_dsrc(q->flow_mode))
> -						srchost->srchost_bulk_flow_count--;
> -
> -					if (cake_ddst(q->flow_mode))
> -						dsthost->dsthost_bulk_flow_count--;
> +					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
> +					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
>   
>   					b->decaying_flow_count++;
>   				} else if (flow->set == CAKE_SET_SPARSE ||
> @@ -2145,12 +2159,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>   				else if (flow->set == CAKE_SET_BULK) {
>   					b->bulk_flow_count--;
>   
> -					if (cake_dsrc(q->flow_mode))
> -						srchost->srchost_bulk_flow_count--;
> -
> -					if (cake_ddst(q->flow_mode))
> -						dsthost->dsthost_bulk_flow_count--;
> -
> +					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
> +					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
>   				} else
>   					b->decaying_flow_count--;
>   


