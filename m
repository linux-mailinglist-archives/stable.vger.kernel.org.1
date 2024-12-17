Return-Path: <stable+bounces-104433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF29F43A2
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911B416BCCA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E12170A2C;
	Tue, 17 Dec 2024 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eT5X6Ln2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BZEVSQ0t"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517016F271;
	Tue, 17 Dec 2024 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416736; cv=fail; b=MKP1XLuPEr+ZHqc3ufqmkY9eQhk12QpCCxktScenjNCNxND42eZF78dHGBiaRTM+GmpXkuKtB6Cs2GZodynKaAHhDFzP5EVfRyJgHIGr2ty9zmF6w7AbxQivckFtQ1gHxMorwYvTaC1H4U1MPFA5cDl1wXzNnHdPX6MIOIoXqDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416736; c=relaxed/simple;
	bh=x1UNZO4zoZBql/QuZ0tN+FEeLGmcvIfCJ0sYCNMPtIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W8OhFKw3TmVH6h8kBzG8VD+VILtc5ADtMfN4qXIh3362IoHBQkxIe+VL8Cnc3DUJ0qle+hTQMPmI0cZ5XFy9TLoNUS9HlVl99SMtaTBppuBjcrIJt+mDE5l3fkFgHYT+o620zLgeeOmt2zDHNDgMEdl8b2OEpL3xcnfNxkIpnSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eT5X6Ln2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BZEVSQ0t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1txY2001763;
	Tue, 17 Dec 2024 06:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x6r6BJxchHhiG2DRcyz6gYHmVI9Jy4RiRuDZ265s4/g=; b=
	eT5X6Ln25Xa8Yetl0K4a4dksenv3GldU6EqKdYe4KhvLrEcCkJq75mnlPR2IW7rc
	H/wnEUJGYCgvEbfCZcB9/HMOo1yW2R+RQ5/+f88NWlVJglHuwwfzN1WhJlYU8V+H
	sfAxORRDrkDungOSzvQ4qQD+5FlJXA9koMiSChqnxiy+oOzQ70hK7/7MZ50uN7zw
	YA4FE4PncCQFWtQIPLZM4edanh16bT7IGe9zRgYZ84+9tFZMgl9yjz8kq1BqD0Fm
	DymDKKrraIaCPQdFrgoUA+LiaKbjiG4fEAXBL83EOGl+h0HZDn/vaxfpffaSrEr0
	P7HV3CgtEcoIKm6MM8yzWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9d8b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:25:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH5ITud006638;
	Tue, 17 Dec 2024 06:25:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8yqy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8auovXVTNdKvPNNhyXZauULh9ODdB+iqDueJ4INwcJxq8XcZiqxq5jZsh2Ru42Q+1dJSrzcysnYpBrNKcV27Oogo/WD/CIDRLLcC+2FGLFDZLB/IdO2DDRK5Sfb+HklTBOo5AeH4ZicToXv4dXQiGrru6W7QdDUbt6tavw0GQ3BsRI2RzxxAv3cM01CvCL/AdbDkoSA7VUpMfoF4zfVft5WIRdhYSvm+I+y/OboV4KeQmw0mhPVxzbyNxeDOiURZ8Ea0FDpVn5mrbui5/UMkkcs7BXziB0wZlpSxDh7zyj7aGYb4+IqCzaEdESTkLhPysSqBn5L87o2e+ie/fGYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6r6BJxchHhiG2DRcyz6gYHmVI9Jy4RiRuDZ265s4/g=;
 b=JFOEuNFspY2FOTHcvkoXY+SVEnvhcTwwiWgjo/LUHqWx/xh8AqwcHAlReg6EOBpmpDZ3nOxysFEeUeOwfMSAPyRN5W1dvJQgD5pojk3nGMUeBESpddo2OOj9Vj+ME+s3hJR/SGI2XpK723jiEjJdGYTk4jO8WPw6uOzLyOQIhNXlzVV/+sJD9T716qjAmurVQi2JQQTM17tZNp1EPdGi8q2uqYGCHPyRLqG0SJpLJNJtpjsgO4bToYnblMmnIvhv3TXMguWuIiriijiQ6N4VgzAR+g0u5Ak6hulzwGcvlYogBMSJvR32fDGXqY5tv6SEerCpEFsMcdQWNyNXARyv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6r6BJxchHhiG2DRcyz6gYHmVI9Jy4RiRuDZ265s4/g=;
 b=BZEVSQ0t0ECM4dqLA7ZnTd58JTbOXtnlMYQBgvFNprmfHNdiBwpa6m41MQkZcqB/6HZBacDWrdqrzPuuTr6e4byhvovFu6aNDlKdXDCVTfR0FIgiXw5O0t1M8qEHMAtyP9YDQv87a0fYfvjIdcr6pRju76RISd5bAATW/jW1bCo=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Tue, 17 Dec
 2024 06:25:04 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:25:00 +0000
Message-ID: <92eb4af2-8a38-4075-9353-21afe34d57d9@oracle.com>
Date: Tue, 17 Dec 2024 11:54:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 5.15 13/13] ALSA: usb: Fix UBSAN warning in
 parse_audio_unit()
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
        syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com, perex@perex.cz,
        tiwai@suse.com, kl@kl.wtf, peter.ujfalusi@linux.intel.com,
        xristos.thes@gmail.com, linux-sound@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240728160907.2053634-1-sashal@kernel.org>
 <20240728160907.2053634-13-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240728160907.2053634-13-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|BY5PR10MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c785826-c45a-4abd-465f-08dd1e63870c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0RFZjhKNzdPZmdzYTdNbUxEMGxCUDhlQzFKeDZnUVo1YWRuV08vUUFURFU5?=
 =?utf-8?B?MFYzczRUQnlSR244NjRFeWFHSWxEdmhaclNLVks2Vyt4WHJRSWtJYVkxdU9F?=
 =?utf-8?B?NkdreVhqOWNLZTRPdUJ5L2ZlZDZsS2w3Y2VqWDBGd3Q5L013SHg4WTB5Mk1B?=
 =?utf-8?B?YWlkdXlpUi8vbXhiclE0TW0wRTNiVTNBVXN1L3pTM3NzbjNpN0lrZG9wb0tI?=
 =?utf-8?B?L3NkdmFLTjVTM21PY2tpV09BL05FSkRjOG54NVNGRmhFNk9lVUdZRWFYMVV5?=
 =?utf-8?B?UGd3RFlUS2Z2K2xmbVVCTXJ2NHpiU0dvcStUZ2oyb2hZYytYdzNqMmdlRVVv?=
 =?utf-8?B?Q3JsdDl6eXpITTNML1dBTXhoTWtNZE9VOGpVaXJUOGlNTXppNzNWaEYvSzVX?=
 =?utf-8?B?K2swVUxPMSt0RTVTZ0FDbkREY28wM3JxL2xqZWNSM2Y5UFl5clVFWTBQVVFl?=
 =?utf-8?B?K2JJcktWTjVCd2NEbko5VGxTeHRyYWNaUUdMRUQzZ3RuaHZmdGxhRVM3T1Vn?=
 =?utf-8?B?T0grR2lTUHoxdmcxWTJrKzhCUjRrNDd3YXd6UXpUMnM4ZWhnRGFMd3V3RVZQ?=
 =?utf-8?B?WGFJQW1PaGx5YWhWdkwwZHY4TzRmanVZZGFLUUlHT0tOYTBmbTN5RWx5SDB2?=
 =?utf-8?B?Vmg2VTVkZllFUVM3TVV5L1dWNHdldDQ3VElCU2xHZ21tWkdFa01WY21GcDg2?=
 =?utf-8?B?dGpTUVZaTWsydWltaWtQSHgwdURzdnB0QkhlTUVLeHNWN1dobUdHNnc4NTZx?=
 =?utf-8?B?TFMxditSS3cvRTVSMkhVRXFaUUs1eGlyRWpUcW5PQTczM2tET2taVWhUakNy?=
 =?utf-8?B?NUJpRFV1eW5EWVRlMWkrZE1aaXZvck80QVFGVkR1Q1hHWUFaK016ekZwbXgv?=
 =?utf-8?B?aEJpL0pTZ3c0bGJ6c2VSVXJwTjVWZU1acWlxc2xsaUI4QkJhSlJUQXc3Wlln?=
 =?utf-8?B?TDF4YU9OamlyTDVlVDJEcDZsWWxOWTd3TlZxRWlTRWk0OUJCdVRiWmlGVlll?=
 =?utf-8?B?R3hSd0xERlZ6ZHd1dFpmRVZ4S3pSVFlJb3pJb0JnRGJtOUl1VC94c1N4ZjNF?=
 =?utf-8?B?Tm54dmZvc3ZLTG1HRTRNakhvb0dKTk9qVko4UUxHZEhkOFJ2VGU4czd2S3Iw?=
 =?utf-8?B?QUVvNXhkakZxcW5IT21rdHJRTU9HVWtlcTlaeTN2TXN3Vm1FbmhBVCtmOVBO?=
 =?utf-8?B?VlNNZUdHWlBPWGpJTW81SlZNU2FmR1h1YUNMYzhsUWY4bTdzOEFyUS9USWlN?=
 =?utf-8?B?eFdTRkRqVWZURTQwUWVmRktLUkI3d212NjhXZ25IR1A1Qnh0TXlhdlBLVC9v?=
 =?utf-8?B?QUlDVlVHaFY0NUVzNjYzdHV0T0V4K3JuM0ZUYVJYbG91YzJibEt5MEJlL084?=
 =?utf-8?B?cXRnZE9COVdPcmJReS80U2I2UVp1Rkh6RXVFNEk5ZDNPbDQvY3ZsUGJVOTUz?=
 =?utf-8?B?WStOQmROem53dDE3R01TQUdJTnpNTzNmUDFsTnEyUndVZXluUGxKc3VVM3dh?=
 =?utf-8?B?cnhCWG9jWktJenJwNlFYYzZxU0dBb3M2L1o0ZnJ2YXoxd29TZERNU0diUngy?=
 =?utf-8?B?RWNCaExCK2oyNWZacy9MMVhmaDhUQXpJYkVSSHVPR0FNdkNnTGZhNjRmbVlQ?=
 =?utf-8?B?eFpDYS9Od2YrbjZwK05xVGdqZnpWZTBQTTZZdlhuK3ZwajI5bXZORGQ1SDZR?=
 =?utf-8?B?ancxejdiQkhwRUE2TjhZbS9PUGhuUkN0YlVXc1BDWmhRQTVLajAvVlZqSzBp?=
 =?utf-8?B?U0FaTVpHRWs1bzk0UXFXVGppYnpHdW9EWGlWZk5HTks1d3JxRVNDc21nK3Q0?=
 =?utf-8?B?REl0OU80RHZvKzVWTFF2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVdweVIrYU5sSmY3NDVqSnZrU3EyaTA3T3ZvbHU5ZlVvbzFscHRiN2wwTkhp?=
 =?utf-8?B?UU9DZVl2TmZIeVdKUWZHV1hvdU44bk1xcnpCTHlRclNucFphZS9sNHpwaity?=
 =?utf-8?B?WkVRdEVtZGxFVFVEeFo4NVk1dTg0azlrNW9ocjNCMzBSaTZ6RWl1QnRtK0JW?=
 =?utf-8?B?cG5ZK3FhVWtFM3kwUEJ5Umo3MTl4bEdlTXhacnVnSVBqdjBva2xTQVlFMm5J?=
 =?utf-8?B?T0ZCbzZWWVlOSzdMK0wzUzBuZUFSRDRwb09XSks4MnNONVhlTTFXMVBBa3py?=
 =?utf-8?B?QWlpTXV2T3dqN3pKQWhsT0pmQWNjQjJNRjB2bU1tT1E2ZHFxU0dJRzJ2Y3Az?=
 =?utf-8?B?TEdWM3E3SEtJekR2NGRYS2pocEh1OVFEdEV5SFcvdHVKbno3QWh2czVWZEVG?=
 =?utf-8?B?Rk9sMDZWUDBpb0J5VDFSV2V3bU5TOXNwNkMxaTQ0OUs2WnloRGxyeVBMZ244?=
 =?utf-8?B?STFwV1VlM0xYUkF4OEhoRWVuc04rS1A0aUJDTU4ycElDdzNPMEZSSkdNVWlz?=
 =?utf-8?B?ZmlsSGlFcWEzLzF5VWdueFZSaVl5b0loUkUzWVIxZklmaEJqNTlhUnozYU9I?=
 =?utf-8?B?U0RPWjNUUjVlN1ZnSVBvWDFrYkFuQkR2emt2ME1nU1hBMG9lbmVTRDRuRVpT?=
 =?utf-8?B?cVZocEJpSzUrRThCNWlyd0YyVFc5azZBNXBtSFdWeVdUZ0p0MDVjR1NtMkxa?=
 =?utf-8?B?eFV6OUdPSUpBNVhZR0taMklWcWNCKzFlWWMyZWY0cjc1enBxN0QySGo2ci9B?=
 =?utf-8?B?UUlkU2p1RFU4U0FxN05IOHZsa2JaY0d1Z0tJZnYxRVZ6L3dIKzAzZFJkV3N4?=
 =?utf-8?B?dittSjhERFFTc1NkSXg4OTAvQnZTRTV3UndGaDVNa2RuUnY5dllvK2Ruc0dy?=
 =?utf-8?B?bUJDNG9lUW92b2dyVnFta3Y4MDV3TWNISjRCRWRnd2xoMVhaclNhQ3hVUzZQ?=
 =?utf-8?B?WGhlaWExcDJpS3RxTGNwYlVabW0vQVlzQ1BDdEdLKzlLb0x6T3FHMXZzcEMx?=
 =?utf-8?B?b3RFd2h1NUo2bkp6VWVZVEg2VHlzMHZjdVZjRDJKNmVWemR3WmVlYXkycStI?=
 =?utf-8?B?T2J3cC9HQXhSUnBDREZLZlZoZ2JzelZFQnZGeW9lYjNYYUlHZGIyVE1ERTRI?=
 =?utf-8?B?MWQwdFUwcjNUZ2VuNms1QWZHMTdBOUZDWkREL3IyalVkcUVzem8yeGpXWEw1?=
 =?utf-8?B?Wlh4Q2x4UUdmaXJxUXNSR1F2V2ZWSlNISDhWMXM3c2NyaVpFazhWU0VFU2JC?=
 =?utf-8?B?RktqaWlVeTJETDB2N0FuUnlqYzFOZ2JQWTROSU1PdFR3ekFxd1RsUzRtc29T?=
 =?utf-8?B?aXdDc2VjZUFUTlZpSlI2Z1lXTUJoQzVxd0NGTEdna244UlZNYlF0OU1UQjZB?=
 =?utf-8?B?WXJ4SUNSVW5OM2FOMGd1MHVmNmtReFNXTXhBVzNRZWxRYU5IMXQ0ZHlrMXZD?=
 =?utf-8?B?QlYyZGxZNmNLTlBMbUNGTVRSUXpzd0hjMHlQZlJtRTNpM0Z6K3phMGtZU0NC?=
 =?utf-8?B?bXZDRytsK1I1ZmRnZHdwMWgxWTJXNTBHbzl1c0VtYUkwMWFWWlE0cUg4Um8r?=
 =?utf-8?B?bWMrdW1Rci9TeHgzK2hxMktTU3dpWHJHTXdYbFcrdmZpTXRQRTFwYWdTNnNn?=
 =?utf-8?B?akNoVG5uYUdDK3pHZFdhM0xSSHRIaitIcllZTkZveEFPaXE3R2dhdUlvNG00?=
 =?utf-8?B?c1NOb3RxeTFtTUpXaHhIMDVuckJ6YkdGeWRPWDRzYXBEaXd5SkZnM3kwWXYr?=
 =?utf-8?B?VE9aeHBhNlozMGxpZzlQZ2lWNDR3aVV0dUpMQkZWdkxaL0JJN2ZiZjd6ZkM1?=
 =?utf-8?B?SDU1Sk1vLytNaUUyNmduaktpcmdjSTBXQkZRUzhjVXFVeFVCWm45RGh1RU1q?=
 =?utf-8?B?UTRYQnNXL0hzL2E5MWpDb0NrNG9tT0piSzdzYnlpR3pIZnBrU29tWktGTFIw?=
 =?utf-8?B?dkloMjlxODh2bFRZSVVXdFdUL3UwUWNOaXFwemlvM2xvSXVKREI2bGVTYURp?=
 =?utf-8?B?SVBqbjlTcmNJcWZFZE9oeHlLT1ZDZkErSFJCamMwL2Z1YnVLTEc4RVVwTzlz?=
 =?utf-8?B?VkMydFBTbW5rSWYxdGdhNGhDd2NSY3gwVWMwQzFOaUU3cVRrck5hbFQvbGE2?=
 =?utf-8?B?OEZZUnliRkJxNHVaK2hJdGtHODBCR2t3MEFuOSs0aFVnaHJhT1hqUzBSY1A0?=
 =?utf-8?Q?VkW2Q3Da8zRJW9DIrbit71I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rmCnRkfycC2+rj9i5VOanYS0UN9+q9CG7TAnxeluBoxB/sTj3zgRfEkoshugOaPeOeVj3uWpWzJPds5z/A8dVm6yPP7za0bXLqX96Uz/rmhJNkjkwvUj2b1RaXWdF90VZlJNnhqoLiAo3OIXVionTDE4obHA/Jw52ZcecDylMIrHCGQKzQK/Gz6FYe1y8ZFOKzmH03N+NfVfeo3jCsiHy53ymiNIdGamFQZohVQoIlvTPBu+EDrrEvc+zMVMFala8kWmcQkqSwp5K7ELuoRfWQQdZO7sxRVnqw5qFOxG+TXdxrrxZjweJlCX2UmX3aMMSbv4rSxTr4RqXIxu6Ska8jv9Q5JAWdA/ODERpq6f2ghuiMyxeR8hvKgGXmmvCwUPlraY/FRn0QA0mHYCJ5VfV8K6bIcNtTFEfzIr3SQZ8LAe0CwIP4tA/swMe5EHqauH7GC389YBVjTeajbmgoixxIVk8OYZYf4wWkRmNP9hcc4P23CeN8CIldoyehPwU9ffpyv4dQxvshpK3KYDy1cy+ZswBF/Fw/0aSFnT1MvreBc/wh3WJXmTo93vrFkLHLhwEEgi3L7ALQHDO4ddIo139qXZIJj4xQbl/ahaOtU2mhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c785826-c45a-4abd-465f-08dd1e63870c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 06:25:00.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlt+3UHcUp8N9x30LQ5ww+ut9LT9xGF9PAKYs68Mgh/1njHHr7EQrtqwLYqmq6g+m97WfB/tIX8Y1/EwK2F2jFG/YMVG4q+f0iuQIhEoWGMqWiYor2jilmuP1dVWvJvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_03,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412170051
X-Proofpoint-GUID: nuP7ziyMtPQPrp_YYqZinZ85F2bzse78
X-Proofpoint-ORIG-GUID: nuP7ziyMtPQPrp_YYqZinZ85F2bzse78

Hi Sasha,

On 28/07/24 21:38, Sasha Levin wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> [ Upstream commit 2f38cf730caedaeacdefb7ff35b0a3c1168117f9 ]
> 
> A malformed USB descriptor may pass the lengthy mixer description with
> a lot of channels, and this may overflow the 32bit integer shift
> size, as caught by syzbot UBSAN test.  Although this won't cause any
> real trouble, it's better to address.
> 
> This patch introduces a sanity check of the number of channels to bail
> out the parsing when too many channels are found.
> 
> Reported-by: syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/0000000000000adac5061d3c7355@google.com
> Link: https://patch.msgid.link/20240715123619.26612-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

FYI: This 13 patch series and similar AUTOSEL sets for other stable 
kernels didn't go into stable yet.

Thanks,
Harshit

> ---
>   sound/usb/mixer.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index d818eee53c90a..f10634dc118d6 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -1985,6 +1985,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
>   		bmaControls = ftr->bmaControls;
>   	}
>   
> +	if (channels > 32) {
> +		usb_audio_info(state->chip,
> +			       "usbmixer: too many channels (%d) in unit %d\n",
> +			       channels, unitid);
> +		return -EINVAL;
> +	}
> +
>   	/* parse the source unit */
>   	err = parse_audio_unit(state, hdr->bSourceID);
>   	if (err < 0)


