Return-Path: <stable+bounces-104215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18B9F20FC
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 22:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24C116654B
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6851AE003;
	Sat, 14 Dec 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D0j0j/tu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vB5jhqkF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF931990A2
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734212500; cv=fail; b=keDCMgHU+LjItLYZoYfyu9hJtQO6g0+6XAfq7nKNxaUe9jAJ1uQfF5dwjDevWJ/njzJZcNJquA/pULGyVy072CgppOa378NWgjlBbRbh1WkjUwzUEGCpz5N8AYG1Q7w2vGAimjWt4q4LUOeSLcFMsJVTaCwseszQZg9tFcAsiSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734212500; c=relaxed/simple;
	bh=zzRY6Z84+U5K1npCRPsQ/TGbvxMmsgibQugo2SkNbyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=doXfkgIczWUu1HfjbgyeWda/zKeBMEygeN4sOraHTUnuhS9yVswcgsHVLXhS04zArKmP0oltm2Q8tnr1yTVj+9oVhcpUdYvAcXe2Qe7Kc9MLuEQJCkq13soUq+ULkJ7DxgYY4oLAfEjUOI8CPkfTwdSTv4iTBdnfBuI9Ofr1lak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D0j0j/tu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vB5jhqkF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEJMPIK013551;
	Sat, 14 Dec 2024 21:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ipReaIUEIpKuP0hm0LOBpiPdiaNLok65vV8wKJztEx0=; b=
	D0j0j/tu35JVoSDv5cy9ixFRf8ScfDd/0cw4cakjEsDe13tb5Ax5LfWq6PDu5V4J
	YGC80jUpx2xgnWX+UQLYxi5E7UiaA+/jOaG73gnPuZKwDViQIkOzEKCEvZN4enV4
	kXxBNgs6UAAjYiX82oCEV9mlp7GnWeaDWf6cKkx3a9I+3WkOqYZkznCDSFw8WlXZ
	vi6eS+izLrVrn/nFj5hN6VL/oxBcI4L56MbKnmoKSpiw+GScRaYZLchlgPT7nrYl
	Aj2+HpZrji1FGLrHY6MaVdA2fjetK0+tXQa2xpzoO0RS0mvcq/W3Uc4xKVIxeEnC
	uNcJyedFxRqhzlSKgE2vRA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt0n02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 21:41:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BELCLFP006498;
	Sat, 14 Dec 2024 21:41:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6rg8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 21:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHTT0lYPrIjy+kaZfOcnlYMuBIlWRfQ4lhSQjYRhoxpLI1I/wzfijDGKSOk/Rf9riwFVvLn9ZE1h24MINDhY3c2W+2Tk9Lead+9icrfyTt6WLJ9XUldqGnIdDH3OcECRlZhdAff7artY6QsYEI5FFjbVeCbT25mcEqjjl3ahD65nth1R2XuDm+6OegJVEZUVyH4P2Dem5CYDl+sxA4Btct4nC7RPOd200UGnJAyZ+HtsNU58pej9WmrnHA8BR9z2hCi+KQv4mm+xukX4tTisVkRcvA9TLzfdQ41jYKDk/1ax1SRJX0nrePcD/RaHQxyhD0N+kzLq4L0YqWWuvjcykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipReaIUEIpKuP0hm0LOBpiPdiaNLok65vV8wKJztEx0=;
 b=p22EQ5TVNoWALDBzn8PJCuJRf3AMjprJAwdmeq9BRuUZx4W/pKK21xIcnE9ODfR4UXFCH88sQhXf9yfGTtXkYF4EqNn2HaifUfFpv+6lEpidds9sg+ODxevNnijKr4ic2SFFzTxjklRzahF4+tqlEm+ekkAhtq1q40OyUh36LCsMtkQQrdJtmE6TU5J/PQkUm2aY0YX/Nax85YcDesVRk5rEEfy93xDUu9KKdHwa9c39KcV4GWHTeJ6EGXQwHvOuct5Yk8wnUJ3YmwV1xj3eRmLQPzwbnpx0HM7VScyxioURGF+9iLdzAhPWwliIdmenVe98Ay39ZoHQHn/tTkj7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipReaIUEIpKuP0hm0LOBpiPdiaNLok65vV8wKJztEx0=;
 b=vB5jhqkFMn826xO4Zneo4CECu8qBRl65Pi0iFKMYEfdvOieftCo/mg31f7M3P/vDqjN/f7genXl+8P/u0opwvVU7WaaubfcmecDu7Z4kK/rhCKAQ4lQmnJgTrn4wyUG3NgXAdxrrVkO1H/yhYnzRL1gCLXmUDrzDIw1SKWL7Dmg=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sat, 14 Dec
 2024 21:41:23 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%6]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 21:41:23 +0000
Message-ID: <4a77e8e8-ccf4-4149-9ccc-a33245df4759@oracle.com>
Date: Sun, 15 Dec 2024 03:11:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y, 5.10.y] exfat: fix potential deadlock on
 __exfat_get_dentry_set
To: Greg KH <gregkh@linuxfoundation.org>, Sherry Yang <sherry.yang@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20241214091651-0af6196918c18d20@stable.kernel.org>
 <CE0C9579-A635-4702-B8B3-896E3F035044@oracle.com>
 <2024121419-cupcake-fantasy-92dd@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2024121419-cupcake-fantasy-92dd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::13) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d2a6dd-971e-40e9-13ac-08dd1c880de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm9FN1ZVTGF0dndnK0ovNFpGYU5RQ09EbmVsWCt2YU42OHp3c0NZVFVtVE1W?=
 =?utf-8?B?TDVrSWNHcGg2NWhtazRkYW80dnU5VVFHQnRXZWhwSWdlUTE0WGtnT1hmekJk?=
 =?utf-8?B?K1dqMk91RS9EL0hqNjNzTXNNZUl0RjNzc2VYOFgzbndvQXBmWlF6SmJ5YjVY?=
 =?utf-8?B?Q0YwRFgxYS9WdGR6cXdaUzNkbmpCelcza011em05bjhLNnBiTVZiZlBrNDAr?=
 =?utf-8?B?MjcvYWNQWW85ZFJlODFycHRSeTRFOHVLdkhUUUN4bTlKTVNVM1RZekRLLy9J?=
 =?utf-8?B?amlMK2J6WVliSHNqY2dQZkhMdHR0Z2RoUnY0am44SXV6MlZSVTh5ckprekZy?=
 =?utf-8?B?U2g2L1ptSWJQM05COTcyd0FNZ2U5TGFCU2ZNZndhemNUZlgzSzEwWUxNcHpz?=
 =?utf-8?B?Wmh6dmNxS1Z2dmpGR1BWK1ZMK0R1akhPaElSUS9ZY2Racm5vU0hqaUFzcWo1?=
 =?utf-8?B?ZktqRzNLM0IyQ3FQWjhDUmI0dnVhWFg4V1VmSm5Za3dVbW93OWJubEc1bFc4?=
 =?utf-8?B?eGVndkZGeHRCK05Fb3pvY3RwSXRqdGNhZGN4RWcvSkNnOVhzWWVUVFk4bzVj?=
 =?utf-8?B?aVNDT2RFcWhGc3RyMUtySVU4YXhTbUJVWk92dlpvVDFuT0o5UjllQWQ0NzJY?=
 =?utf-8?B?bHN5TG56djZLUjF5cURIWWt0YXhGaURJUm9mVk5rMzZncVRxOUlWMTN5UUkz?=
 =?utf-8?B?RFRSY0dYRHUvNGZ6cWt6eXkrd3I0OXUwRGVvaUN1ZmM5aXdCSEJzQ29zdFps?=
 =?utf-8?B?a0o2NTlnczlMRERVNFFZL0o1dHhxVE0yWG9GWFFTVUtIb2JCK0gxYzEvVTkx?=
 =?utf-8?B?b0UrTTNMaEJhQ2tqcC9ZcEUvcjF0NW1oMEZuamVUU1ljRkZZNExPbHV5Rml0?=
 =?utf-8?B?RUxvdHMvKzNja2NwU1N1UGUzSVRScHIrbmpiRDlyRW1OU0JLelVxendxUkRE?=
 =?utf-8?B?RktmNUxQWTVNL0tMZDNKRWdWSDFUcDBjUUJKb1Zub2ZNWGxLanZuMUtpc1FG?=
 =?utf-8?B?dUVLL0NOZmI0V0tIRXFHbVJWb0I4dFhML1VlRTM5R0N6eXFGVUNrUUFZamM3?=
 =?utf-8?B?dEVZR0ZXMVRqRHA4QkxkQ1g2bWtCdzJjZzlnY0RHSFRuaFNwTWpGQm5hZnlP?=
 =?utf-8?B?UWYvS2JsTWRWNS8yd21jZTRiYUJqTyswRmZQTEIrTHBGZWVTU0JiSlNRR200?=
 =?utf-8?B?Q2RjOTJncHRvMzVnTzM2Y2lERkljcHlmcFEvT09nQ1Via0R2aS9SVC9oYytX?=
 =?utf-8?B?WHFaRDd6b3cySStlaklBZDI4SHQ5WS91Mi9DcGl2cE4xY3ovZjg1NzV1VXcz?=
 =?utf-8?B?V0o2TldEbVlGclE5NWpaNHVqYzhXY1ROazh5R3Q1cnZ5S2Z1U1MydTJpL0da?=
 =?utf-8?B?dHJrMEFNS1Uxd1RVYXRzekNhUkZXWVZ5LzFwVEtweHVmQVF1Wm16TSt5WURJ?=
 =?utf-8?B?Q1MrRlJyaEpQL2Z5NitxK3I1R1Vod1NyWkNXVVNBSVJkY0xZS0lTeHY4emQw?=
 =?utf-8?B?VlJMNjdndE5SZWw1NTJMMUZLT0hLejMvbzRFZG5zMTVjSysreTlaU3o4aElY?=
 =?utf-8?B?b2NzWU93WVdOeE1BRGhML2tETkNFQXNSRXR4aFY1M0dLS1k2bVpQL0xTZjlo?=
 =?utf-8?B?cXduVjEyWWw1NVRXZGZpYXFTUVN0WkdsQzlpZ0kyVDBDc08wb1l6YWdDaU83?=
 =?utf-8?B?RDFEWDFjMVZGRmFEWHY2emt4cTdxaGtTcUErc2paYWIxdUh0VnhZazBBQUx4?=
 =?utf-8?B?dHBVMmh3cW43VU1LZTJ6bXBVK0F3Z2EyUFB5WkdQam11UTFmNm01dWlqd0Ji?=
 =?utf-8?B?RTROc1JvWEdSUGVBYVdMQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzFTUjkyQUVIQkRZZXUzRDE2VVlPeGRueER0cHBKZEZ4REtrcHI3QlNEejJa?=
 =?utf-8?B?d2FwNy9WVEZCckVvT2p0bE1nM1N2Y3Jra0xpV1Z1V2xxLzB2elJNdGdRM2gw?=
 =?utf-8?B?UENreTVMamk5azc4RjdYWVoxVkNXckFRQks1NHhsa2JUTndQdkwyVzZkYU1D?=
 =?utf-8?B?QnducFR2M1hEc3pWQkRTaENIcEhpRkNsK0VnT1FsWm1ZSVIwbkR2dkJsdSsv?=
 =?utf-8?B?aXR2bVR1bnhZY0JiTUIvUjliOUgxZDVxNGtuR0tpUkpLR0FyMDNtTklOK3dO?=
 =?utf-8?B?ZjJDQ1VYNVpjRlpmdFExTTBZT09vbk5jVmxLS1llUFk4L0NnUnlUQ1djNTBO?=
 =?utf-8?B?N2plYUh3L1ZuS3hjYzh4QUFoaTlzK25WTThhSjFrZUNwV2NDcHdMdkxKcndt?=
 =?utf-8?B?WUlNZGd2bk5Ua1V1UWwwamVNYk1jQ2JXLzF2c0U0TGlxKzgzdmZrWGlGODhV?=
 =?utf-8?B?dXFGWGg1VGhhRlpzU0xwZ25xdXN3RkF1L25jSXZVbVNOcXlBY2gvdlBvdjI0?=
 =?utf-8?B?Nmg5YjBYdmxLTHAvR1UrMTlLeEFhU0QvTDRVOHJHcEtMR3VaQy9sQUZzU2RG?=
 =?utf-8?B?ZDB0ejVDencvemtpMXhURXJJMUg5RCtMWXFMdDZRRlNtL0JDZnNJLzVBYk5W?=
 =?utf-8?B?eU10eGtyRmF2c084amRRQW5MbTAyVDVwZ1A3MmRaaTVMSWVYODY5N1JIRkVW?=
 =?utf-8?B?QXpWL3UweWFiYkQraU55emtZa0NOOUtXQ2lhdjkyZ0RKd2JYazd4WTBPQzk0?=
 =?utf-8?B?aGpCRE5TUnpzVEZvOVhZM0F4UEQ4S0xmWHNCNWg5MVQ4d2pkSGlQR1FHQ3Rt?=
 =?utf-8?B?bEZITngyWGhTSHBWWVlxWnZDaDVWMzJsblFweDNpVHJ2SHJNeUdGcTl6RHFX?=
 =?utf-8?B?U0U3NlJSbUh3R1JYcGVmb1hPRDlhRXB1cXdIbGxKZTFmK2hNRjdUUWVZU0dx?=
 =?utf-8?B?L2lURWlGNW9MYVBsUVhmUTRPSWJtUDJBa0JyaFRTYVAzU2k2cU5seXdEallh?=
 =?utf-8?B?OGRzR3oyc2FUaS9NZ1hHandPL1FObDRzSmUzcDR4TzNzS1U0QWFBZ0hpd283?=
 =?utf-8?B?QmprV3J5Q2IxR2Y3WG10L3NsUWQ2bThrSGtGYVZabHB4bTYzak5EQStaZ2dP?=
 =?utf-8?B?UVVHeVZQaStXQ3RwWHlheVVBZmRYdVBrU25UbjVjVE5XQ2piR0F3VTIvUnR2?=
 =?utf-8?B?RENmbThNT2RKR1FsWGJJTUZTekRZSmhBQmV2MFY5c2NQUDNiZDY2OVN5K1dH?=
 =?utf-8?B?U2VKMVpVTFRZcDI2akErZjNiVEJYZi9MbUN1T2NrRi96dG5YZjZyeFVsMHJr?=
 =?utf-8?B?MFBvQmU1V29wMU8rcTk4YmFxeW9YNmdVZ2IvOWQ5ZGJxeWpPOFhwZ0pOZmJ5?=
 =?utf-8?B?SytZM0ppT24rWmtCTEhXc2E3d05QelBxTU1ZbXZsbUVRZE5WcjNMenlpdUU0?=
 =?utf-8?B?SVl4TUdQYnlZeU1lYWI4NEYyZ0JNYjJYQkdDWHl2Mm1FbWdmM1RCMmJQNHVG?=
 =?utf-8?B?MkdGYXg5SGdEenUrblpjd291dDhkQlJPaEZQZGZwdEQrbHZnb2dpSU9VTGNG?=
 =?utf-8?B?RHNhMXlxZi9pQmdTSUJJWEs5aFpYNWdQZElqTUIzNVlSSmhSVjZiMDZJU1VI?=
 =?utf-8?B?T2FQS2hKSEU3ZW5RM2EyUkR0NlJuOW9xV2ZlRlFCY3Bnakh4cXRNU0dSWEt0?=
 =?utf-8?B?cjcrU0d4Z0pvZENPR3BMbFViWXB4amdSbk41RWFUNkFnOVFXeVk0QTFQc2Yx?=
 =?utf-8?B?Nlp2TVNrYW1aOW10RmhaWGNvaHdiWDYrVE1tMGQwM2Q5eEJBTCs0ektYYk01?=
 =?utf-8?B?amdzQzJKcFBHRGNsK0diTFFlaEh0V2JGNVVmekxRQ2thTVo1bXN0a1hucWc0?=
 =?utf-8?B?eXVTbkMrV0h5SE1lSEIxb2pwYjl6OERXc3RqNG8rcFpJQWZvcGhTekorS2JC?=
 =?utf-8?B?SVE1cWFaUm9WNWtRRUVhUHUycXZPaTN3bkZGc1RhSW1KalB3bUJVekkxQjNP?=
 =?utf-8?B?MWx6UXRJT2VtdFdFekFITEtVL29SQUQ2Sy9hQ2xaNTRXRkp3aGJSS1JjUGds?=
 =?utf-8?B?b0RGbW9GZkVhL2hxVTFxb1pjUFlFTmVOK3dENWdVVUlQZFdFUzlCY2ErYklB?=
 =?utf-8?B?UVpXblRRb0VrZU9OZy9IaG1QVjMrZGExVnA0WXc1bFNwRGEzTC9ZVVJkdGlM?=
 =?utf-8?Q?L/mWMJXfPf2ks3HvNJJDQkU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x1JB170B9qZYEk/ODvhQ9PZOtUM8tkZBDj4Y/ig+F+Sb0KOG8ZSytcVyZN0A81mXe4i9Lijvu7pQW9cY2w3QbmXbZWWnkI3tBBGNraCB5IYUKauZQ4llZ0MHoB84ckdY2OVialTseeAGj+ETSSZ386t6TQr3yHZvulHs50d+8kQCDIOqvtPryQ8r74g4MVDiQCXKcjEV8pwbdBB0VnCJI6v21UwSVtB3J5YC5Kyhjt5qUR22sOm+A1hyMSwOVUJW0O28krYQCb6eZmiXGn774v1PbmXsbj2sKqsKQTdP7yIi+1QPsBqE6RjrdnQzItu5dYuJGMe0riNbbxs0gToq5eJ4gc4+7ITMgx+J+rcGbzR2r411kcfb/2Xqg621BGYivPmaR/zOAzDyS+BK4sAKOFfq2kMjlivlfetmeKI9vuw+1v1pk4SWG36fEn67mA6du9iWO9nL4yzqS6hZGnvcQj82KIgWrRRhezAbpBdiwmAxB+OcM8vjziXGYvhvBl61gLPCFDTloWF5N3ujGQgDRQNBVY/ThuSJA1jajah0AE3TVkbd48tbQq0M2E9oZTe77cwRNJ7l0RTj5JpUUOw4yvRAKL8a1irqkdARB8vIy58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d2a6dd-971e-40e9-13ac-08dd1c880de8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 21:41:23.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcL91ytiyC/H6e1OEcPRlGHB6GN4xYSgGEXma8cKuTf6FSEBezraZwehST56lT8xjzt1aWSrKqW/iyn0jfxPWC7nwuf0B8pmrWWVo9/eyiruN/7QLq2NvT5dSWvgFFH3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_09,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412140178
X-Proofpoint-GUID: 7CiisvsbIPbiaPU8CMaKsdYONjpedTnW
X-Proofpoint-ORIG-GUID: 7CiisvsbIPbiaPU8CMaKsdYONjpedTnW

Hi Greg,

On 14/12/24 23:36, Greg KH wrote:
> On Sat, Dec 14, 2024 at 05:57:01PM +0000, Sherry Yang wrote:
>> Hi,
>>
>>> On Dec 14, 2024, at 6:26 AM, Sasha Levin <sashal@kernel.org> wrote:
>>>
>>> [ Sasha's backport helper bot ]
>>>
>>> Hi,
>>>
>>> The upstream commit SHA1 provided is correct: 89fc548767a2155231128cb98726d6d2ea1256c9
>>>
>>> WARNING: Author mismatch between patch and upstream commit:
>>> Backport author: Sherry Yang <sherry.yang@oracle.com>
>>> Commit author: Sungjong Seo <sj1557.seo@samsung.com>
>>>
>>>
>>> Status in newer kernel trees:
>>> 6.12.y | Present (exact SHA1)
>>> 6.6.y | Present (different SHA1: a7ac198f8dba)
>>> 6.1.y | Not found
>>> 5.15.y | Not found
>>
>> I didn’t backport the commit to linux-stable-6.1.y, because 6.1.y didn’t backport the culprit commit
>> a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_set_cache”), so not influenced.
>>
>> However, both linux-stable-5.15.y and linux-stable-5.10.y actually backported the culprit commit. So I’m trying to fix it on 5.15.y and 5.10.y.
>>
>> Let me know if you have more questions about it.
> 
> That's confusing, why doesn't 6.1.y have that commit?  Shouldn't we also
> add it there along with this one?
> 

https://lore.kernel.org/all/20230809103650.353831735@linuxfoundation.org/#t

Commit a3ff29a95fde ("exfat: support dynamic allocate bh for 
exfat_entry_set_cache”) which is present in 5.10.y and 5.15.y but not in 
6.1.y is added as a stable-dependency "Stable-dep-of: d42334578eba 
("exfat: check if filename entries exceeds max filename length") ", but 
this(d42334578eba - filename length check) is present in 6.1.y without 
commit a3ff29a95fde , so probably stable-dep-of is not accurate.

Given that now we already have a3ff29a95fde ("exfat: support dynamic 
allocate bh for exfat_entry_set_cache”) to 5.15.y and 5.10.y, I think we 
should add it and the fix to 6.1.y as well.

For 6.1.y here are the upstream commits: (Starting from 1 -- cleanly 
applies and builds fine, haven't done any exfat related testing though.)
1. a3ff29a95fde ("exfat: support dynamic allocate bh for 
exfat_entry_set_cache”)
2. commit: 89fc548767a2 ("exfat: fix potential deadlock on 
__exfat_get_dentry_set")

Let me know if you want me to send two patches instead, I can do that.

Thanks,
Harshit

> thanks,
> 
> greg k-h
> 


