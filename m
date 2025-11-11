Return-Path: <stable+bounces-194445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF26C4C147
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 08:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0EA18C0B82
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB334CFCD;
	Tue, 11 Nov 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZqcaOYDf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZF5JBmIx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC1281341
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845131; cv=fail; b=qETWa+IvT+Cf/Esv5JzHsc680hRIJZfcF3d1smVc0h18ZlrflbXO9n1CPdwisXpTzYBJRiFnrWf3zjAmsyR+1wXenZv280OFSIPoE2xHre3PqTV2exxyapmlmHAEENtfActndbHvjMQ78nTdj0xjf/V5+H07YhWaUbriCYf9S3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845131; c=relaxed/simple;
	bh=92R5kahmJ7oFkS+MMn+wM/NYea2gYlo2iNhyihFxDAw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nUzBlnpe0fEOmocHyt6RYkq3eF1HNzKRyvJGF3jVp+VyEwMfI4FBEYFucl6hTwdVrotTONHlVsZBegdJinHCR3zYZjZAwoKFZTkQXHkPihVR2OwVUjyg9LCt48eOhbquoptqlrOGC+gMuWs7vORQMFg9IZx5rL9umeP1PzjMKxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZqcaOYDf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZF5JBmIx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6sMVx027525;
	Tue, 11 Nov 2025 07:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=U/9wr9LlTxaIkVIx
	GLX03GR75xLSmCVTZKq7iWgKTmo=; b=ZqcaOYDffYlFkdMzvSz4eoT8mpTRUb3a
	6N/eEAvWEBhB0BbTP+4Fmrkf4U+I15dDwHk7jrTRIC/jb9rPH9FaxkHHmxbKdUV9
	Wljc2GD59+89wPStNKfLRqhPwYIqAOzSnrgyWp3LBw5wjmxvQMIDIOL66RBTxuuK
	h7aaMIhE96P8146M+JinUJJ6VzdA0Yx3sWZEAWqFdry0Q+sDrp24UNSh2dUQPnHC
	npkoVphhLUDOiluC1LR0sMdMvYRLd4yXECLiKBjluALtdPtN9KAXFpb5XHWlIvvs
	+rSpL3CyN/vjaK/F1f4ITOa3uctkeGltmfKjfHk+zuEsID5YzK6WZA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abrpb8pr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:11:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB50WBC007447;
	Tue, 11 Nov 2025 07:11:12 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va9p026-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix+bPtgFhWGW8wivHzlxuWr+dWYCtTabWdLqriRXtaLEioLNNzBpstYHdDkz2jUxQag5tvbn8JOUzT0VUFI1ALI7SXsP6mGGSCVEUeBzZ5hicipY8MsDpQPkmxwfYPvsuHc2SZjp6a7GdK4JG+p1qpOfiInl0xJgdnd1V54rTKQ7MHEak/E7EFJcm2wy2P87OrDaK8fLO3hACwFcApMpAziJ2+u+YaWq1fPVg2f3JFsI0DIrz4Zi/8FY/LR9ex0Cwcps01ZywfbSq3oFwvhRasCA1soi6HMe3xj/LS9PbfL4e44TpYQeOmoxFJ1JVDMM784HHVWNFuwltqMpftGC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/9wr9LlTxaIkVIxGLX03GR75xLSmCVTZKq7iWgKTmo=;
 b=GeE8D+JC1Aeypt51x+aktVodZeOKgkEpqa5BzZCD6ahWOH5NzniAgmM8U0+5H7DkCLvOxIuUVSKO6ZwWpmsGgne/oDBLxxjnEHWtvfUxnbRrRYPcmzU2YrI7deGqMs0vQtikZymWII/IIMAqWUa7CZCq/2Ou/uuyAjrZgVt4kkZPOJZEXCL2avz3c5VyCiMztuO6AN7zwTLec8ehXDzRRQkt6KfiDWle/1YkXci7cgSK7NNYil/mZGdEfEOt4fRiPj5KWgJAy3zfjHEZhEEl4ZZZq+fK7WMBVTc8pOkHn27YyGv8fyIkQWjIPjv2VV71zAjjn5sPaGT+1+rMzz5bhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/9wr9LlTxaIkVIxGLX03GR75xLSmCVTZKq7iWgKTmo=;
 b=ZF5JBmIxzJ5QkXDVpfn7xjbVQLc9sf5TTxuOLAVVocQnLXIzkxaweSyzVMXmlVuWflL9srFAvAiAbQ/HjmaR5B7k07EVl1vmf3LeqEDtcivgg1PUHja2Hhn0ZfGbFz1e92zr2XCcs1yO4fbhC4bREL7bqSbUrxCcWhcegrUC4iQ=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 SA1PR10MB5685.namprd10.prod.outlook.com (2603:10b6:806:23d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 07:11:09 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:11:08 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@redhat.com, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 6.1.y 0/2] Fix bad pmd due to race between change_prot_numa() and THP migration
Date: Tue, 11 Nov 2025 16:10:59 +0900
Message-ID: <20251111071101.680906-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0067.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::9) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a699f12-6b39-482a-d47a-08de20f17cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW54T0VxbzVnZnR1NzlxMGVpMEoxWHZHWGtFMWVJaVFjMGN3RGUyVk9VUWI4?=
 =?utf-8?B?TGk4QldudmtHdlZHdWo1em80bnVuVGdnZDA3NWRtN1FmVHJOOGl1QitUWjBn?=
 =?utf-8?B?S29iZ1dkSTk0WTBhMW5IMDJwUUpGZTFPQ09DTldJVlhFYThyRkllU012ckpi?=
 =?utf-8?B?MENZRDVoN1NGazI2TW16OXBIWllUNEZpc2oxcjYzVlVndnJCa1lTRWk2M0RK?=
 =?utf-8?B?b1RqaFQyckJWeWxuRWdJWUUrcmFOZVNVaVJpNEFFVDFiYmhCbWN3SnlOZngw?=
 =?utf-8?B?ZHFjRXpYcEZ2dmEvblhEd1VCN2tUaUEvTVdQc3JZZmxCTzRPWERMRUtWU3Vx?=
 =?utf-8?B?bklkcnBQcGp0QjBoUmlqU2RJUHpmSUlMK3lmMWhKamFvV0tlOFR2QjU0amFk?=
 =?utf-8?B?TFNrYlZyUUtSU2h2eWlwY21xMjQvcmw1RGpEK3N1TTE2YTZUWVhhV2UyUUpJ?=
 =?utf-8?B?K2VWVE1QOVZvYUdUWGFoNUcrT2FaenVlbCtFNUR6SnVaUHF3Ulgrd3ZSSG5k?=
 =?utf-8?B?N2FrTUYrenpCbTBGVUx3VXJiV21tYXFPb0RGMFFDZzRlR0RLVjV1RzRhcEpR?=
 =?utf-8?B?S0FyMi8vWUZFYnNPZnh1am5BekZwZ3o0c2xWLzNUNndwU3VRZzJQZFdKbC9H?=
 =?utf-8?B?d0Q3dHBxbGhZZEFYeHpDT25pTy9XTmF2VGRGZ0RsaXhZeXJOWm13OGVheFFh?=
 =?utf-8?B?bFQ1aU43L1BCekQyc0lUMDNpYUdzdStKYXpnZFNEbk8vYkR6UzI2NGtxeURH?=
 =?utf-8?B?bjlrVFhITGtQMmxRaWNJQy9TaWVrK3pKOVNwQmFHZldOeGNYVzdPaDkwVFd6?=
 =?utf-8?B?UHg1ckloaklYMm5VVlhrZ1lBWnB5a3IxOEhEbkFnUDVGSHFkelVZNjVPdjFp?=
 =?utf-8?B?TjZTNHdaOStlc0RnYlNDamRDTXpvMzJ1alMwUmR1ZDlzRWUyNGFLRzRiSzd5?=
 =?utf-8?B?NWNWRDVuWGxjNFpKanFRNmRkNVhHWlZBUGdFbzhhUEtONHZnTk8vZUNwZExB?=
 =?utf-8?B?Y1pBVlF1UnZZcmVRY3JMVDcxZ0FEYVVtOWI2ZkZkenVucFRDRlpnRmQvSC9G?=
 =?utf-8?B?Y1l3U1pFQ3BsNlAwMmJFajNkVVVyeUZFWmlaZEFveEVIdEJLa0FCYjV5NzBW?=
 =?utf-8?B?dzZ3RjQrbWJMS0FZck51ZHdVRXBJTlp4N2FuVy8zWHVZS1AxMzgvK0FRWTNE?=
 =?utf-8?B?eW1IY3Y0b0RXdDBzaEd0cDlkWVNTMnFOempnZlc2MjlORFZmczV0YmZMbGxh?=
 =?utf-8?B?V3dqOVRRN3JodThZYmNvSG5nQlFZeTFON0JDckV3UXU0UC9sRVduZEhZYVA2?=
 =?utf-8?B?eHpTek1nd0FMK3hkMnBIblg5YXVjMHpzdUhUSmVRbkdDUTFYMFBBek9jdHdK?=
 =?utf-8?B?RkM0WHMxenNCZTZ5R05iM1NlTm1ZaTNxaVpqRUtLUHdvekdWeVp4U0pDaTFj?=
 =?utf-8?B?cWhHenR5cm9IdFllV0lUdGJBUzlCTUZqdVZ5QW5wa2hCbHVwbE44Si9BZHNI?=
 =?utf-8?B?eDY3QjMyNGZnUnRSakloRUhUVG9oMWVTV1hoeTJFMHZXZ2gwOERmeTV6YXpR?=
 =?utf-8?B?NHJmaW5yTHp1RlprVGhGdzBpQ2hIUGNnTCtuOHluV0F3MXVqOXBualFwc0tu?=
 =?utf-8?B?aTZQa0FPRE9tbkJJemhncmI5WFFpUmRqVlhSU1AyK2xtUzc1RzNaMWlTSkFl?=
 =?utf-8?B?ZFEwYTJwQVV2aXdZRGtCakFlNG9VRUFlN1UwOTh1KzZnTWVOeUF6dFJSZWFP?=
 =?utf-8?B?bmN4ejc2VVFSM2RLUk9XRmFWcklSSGtVZ3VOb3J5MDlZNU9aWE05ZUdNYWhT?=
 =?utf-8?B?V0lHUUlJRnJUbTNCNU9UVm1iNmFZTkRpSnJSak5lTElraVg2dkVVNlBGMkk3?=
 =?utf-8?B?TTlTV1pWREFjV2hHaEswZ0IzelNaM1MxZ3VLK0RTcnVQbGFFQzhJUzZvYVMz?=
 =?utf-8?Q?OZuTPXQll965PN7dw88VfZavLB8c30S4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXN5QWxtYS9CNEplYVQ5Y3pIaVN1aUJoOURzYjhWNis3clRVTDdQU2liT2Nt?=
 =?utf-8?B?THZ4ZmhxWlg3WXlPTVpuMEh3cVlNa0p4aytYa0dxTjFxUjlrMHNCOWkvTGZJ?=
 =?utf-8?B?K21ZaS9XM2dybUE5QTZHMU9CTW9qR3Z1cldGUjVpcEFLV0d2MUk2dVg2ak96?=
 =?utf-8?B?ZHZmRzJreTNOQkFFbHhzWXQzTUVtVGZ3cEt0WjJLMWlXd3lIVHZHSGNSOGZp?=
 =?utf-8?B?a1Zqb3daSkZjVTVoNTVHVG9nbENuTmp0bVU1Y1NMYzEzaFFyV1M3dnhSWkVH?=
 =?utf-8?B?NFNRV2h2L1hsV1V2ejY0SS9sVklvaUlGVjh0Uk82Tm0wR0FFQW91eE9GK1Zu?=
 =?utf-8?B?SkswQkw4RjhOejZvUFdHRG82L1dEeHhZVzNzQ2swd1RxR3Evb2pHeVFya1hT?=
 =?utf-8?B?M0RRdGNQUXB0S2ZwOW1ETC96ZUhOWlJzNEtQZTZhUVFKSk50VXlCbnZRLzRy?=
 =?utf-8?B?ZUhhNFZHS3FvTHpPemh3cWM0bUI5eFBlYVpxbE5NTHZYSjJnaVl3T1JIZ1lr?=
 =?utf-8?B?S2YwcG0rQXAvaEF4TEd3eFNSOEEvbmI0UnJCL0Nnd1d6YkgyY1c1ZWdvR1Va?=
 =?utf-8?B?YnIrVlRGNVNrd1FTbW9nMHk1amk4WlpwQ2JMc1pGMnFLejFua20rT0J2ODFX?=
 =?utf-8?B?S1AzSllVcGFwb05zNkRuQ1VBZTRFRVZTKzJ2MTFZSUxmeDlQbDF5VlFwRTR5?=
 =?utf-8?B?VzI0RTlDc2tocG5OS0ZQTTc0d0x6aHlKcmNISno0bk9PQnpZM3JoQk1Ib2p4?=
 =?utf-8?B?T1RIVWRZQkxXQ0VmYkdsKzk4K1JNYkpQaUY3Q0JCSGp2YU1leFE4Qm51OTFv?=
 =?utf-8?B?dlhCNk9MNjIvYjBTdjM1UmlLYk1LRUY2Z2tsbklxMHNkb0VYMldlMlAyV01L?=
 =?utf-8?B?VUJCRUZjZlliNjBrL1lPK0JQRkVXR0JsM0R3ZXUzcm10QkF6bGVjZUNxbE9V?=
 =?utf-8?B?Sk9hM2tWK0NnT015bjlTSFRuczZaMU1WUEdnVXlIa1NpRjJOZHB5ZGh3ME5Y?=
 =?utf-8?B?S0tqNzJZc1orU2t6Q0lZMTRQc041eWw5dVFwNFZncndFRUVzYnhxV290a1Iz?=
 =?utf-8?B?WDVVcXN2aTZxaXdRTFc2WWxvTW1VSktqVVpVY0M2bXJEWmliaTQrd3FyckpC?=
 =?utf-8?B?eU9VK3k5aFA4QjZwVktJM1BvRHdYSk5ncnk1ZnRlTzBSUGxPV2puS25MV2Vt?=
 =?utf-8?B?RGdvbGxwTE42aTVGWVpDTW1ybWhZeE85SC8vdXJuN2dBalNLQ05RT3NDa1ZK?=
 =?utf-8?B?VjVrK1JTcXovMW1aMWgyNktWQk5aOXRzWHhraG5RYkhCcjlWYkNUenFUbnU0?=
 =?utf-8?B?MER3WkZSRlhqbWxrQUs2UWZtMHM2bjdGTFlsL1Q2UENoajh2N0pRSFE4NXZn?=
 =?utf-8?B?eW5HUmExdEFTWElzMmt5clluSlo1U2FhdUFNcXhRbWFlaXYzK2U0TU85VVhw?=
 =?utf-8?B?S0N4U2E1VldjZzNCSkNhdmpFYytjeGRKR3lUeGFZbGplbldvaytOVWo0ZUlq?=
 =?utf-8?B?WHB0RmY3Vm9QTExpWDE5WXkwVzhFNDV4NHhNd2x4b0xIZkFmeGhpQ0ZYeWdz?=
 =?utf-8?B?RlozdDFaM0ZZdGRjQjBrSjJFK0NaRWZCQzJmTG8zVGhXQVVXZnVzLzRjdTJ4?=
 =?utf-8?B?OFRITTJNdU1Xc2Q0SmdiVXIyUGdUVmozSVNrZ0pzMmdieU5xVUxxcDAxS2Jr?=
 =?utf-8?B?ZzN2RSsvZDdVRWQvQXdRU0VKb0RXUDhtazVpR2o2cnUxMUVxUDNiRzUvTm1k?=
 =?utf-8?B?ZWZHK3RJOG9uZzk0RDNJNkk2eWR6NHJjSDgxUGxNdEo3UnVTQldZSHpHS0du?=
 =?utf-8?B?Q0h3SWRpS2NrOXd3ZUZNcklCYjVicVNxZHF2SmtITGFvS3VIUmJQWDByVnNo?=
 =?utf-8?B?dENQN0M0M1JwdDd4RGFqcE9PSG9naTdSNGtjM1YxN1Ivb2RGbXdrVEVrUTJm?=
 =?utf-8?B?N0ZjdkllZnZ1cVdkNzVhSTlQUUJOT0xjS0l6RnFYRm9hWTh6LzZ4UGEyaVc0?=
 =?utf-8?B?d2Z4UEM5YVpmVFZnSHlqc1JqSW51N2JQbXpVdEVsZmIzOGkwd3UzT0JTQldH?=
 =?utf-8?B?dWw2dnIrTXVnajR2Snd1Z1FXR0Z1OFJrSEVHVVNjejYrcU5KQkh4RVFTd0lZ?=
 =?utf-8?Q?414KtJrYOA+qlt3sGF3Cyfq1d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kyah1s4ZcD4iErVGEOZaS2HRNRdZfPNy7z8Yoe/QqWtWpJq9vpqsp38V4qmeI0QTYjnGnFTsFlpJw1yHDRxXSAcRftKxUW8l505Y+7m45JAwBMnQlohUfqUSFVD7SRNFqrHwRZPTVCF6GgxswI3jxYWCbm8z4ana/Cizmuoa3QDrlGoFNSU5WYrnMrc5AiHVLBdVvUOlM+KEIkScPu5SFRM708TEpgWN2/f+vsZfj8MH4Jrj0ZiLsH2cOERbWtfKg0tRiXJTVagbMlmIe8Jx1qiZKvceGhW4GKZg7BLKFUt+z4L7tBBKxPR7TiqBkDX/V4577Drl5s2LVOxF/5flRZ9pJtBbxgYk1mH9iXsu0gEzSq1nuvSMKcoqIWm5k772XirRFA2sTW6KuKfK1MrAIvvPNYSyqJxljy8gcEqq5kTfeT5qc/ra3J97Cf/2waRkuxxFJiog1NZLVNGKtmSALXgl8gx0WypHkIbS1XCGMFyMG6GC6YileNXHbFQu0tciKEyGXViqfKFIBvgjF7DbLVKR5Oxvbrl/flu2VwGZBK0Rt9xXYUg3TCaoUPCEWYYY0HyEFLG9EGQxpxo1t91AHUMYFxwub0z35fp185D08L0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a699f12-6b39-482a-d47a-08de20f17cb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:11:08.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daMaM4l111evREkp4DstqLnZ2n5iyHHM2sEfWj3VFdwLUHa9X39/YaTt3PHN68mQz03T1xrMHJhG2ZC083cN2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110054
X-Proofpoint-GUID: Xw5PLrjew7VIgVbnww3MB00HbVTwGhAb
X-Proofpoint-ORIG-GUID: Xw5PLrjew7VIgVbnww3MB00HbVTwGhAb
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=6912e191 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=kEnJsJGa_n3Wc8imv8EA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4OSBTYWx0ZWRfX6H72M8y3/VOp
 ok7/sD/H0/ROUiW1H850NTtL0rMfTzvixuuuCRzbdOMnNx9uwXxpHvtnyMvkIh1mgAE8ItQb0/4
 ZDjsK7eUxR41ZNERmsyvaTwecCwSNrc57Pz+TqGOqS/Xr1pnNrCqjcNit2/HprzQoJORQcb/aBg
 c1TQQKES6JqI0KPekMwHvKApvQGeUA3/RXhsAd67o0lRUjshHIGJ0csj8rtIyvKCpcSdwx5mFfu
 xZ6IgRIg8+FwFsRVYqUtkPvdM3ELAd6E1lIUWCxmIJNcmkOq3wGVM7/9fRBSWo1aBtDd1wkm1Mt
 FwuK0n8MdfWzW1Rbzy1vfy5LuUB7ZcUFOQ3wUegrckx2m3hsM4cU8EHOHkqZHVZaE0S0XVOTiO3
 jEEMh/la63flyIlfE+/Vae8SX+5P+g==

# TL;DR

previous discussion: https://lore.kernel.org/linux-mm/b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com/

A "bad pmd" error occurs due to race condition between
change_prot_numa() and THP migration. The mainline kernel does not have
this bug as commit 670ddd8cdc fixes the race condition. 6.1.y, 5.15.y,
5.10.y, 5.4.y are affected by this bug. 

Fixing this in -stable kernels is tricky because pte_map_offset_lock()
has different semantics in pre-6.5 and post-6.5 kernels. I am trying to
backport the same mechanism we have in the mainline kernel.
Since the code looks bit different due to different semantics of
pte_map_offset_lock(), it'd be best to get this reviewed by MM folks.

# Testing

I verified that the bug described below is not reproduced anymore
(on a downstream kernel) after applying this patch series. It used to
trigger in few days of intensive numa balancing testing, but it survived
2 weeks with this applied.

# Bug Description

It was reported that a bad pmd is seen when automatic NUMA
balancing is marking page table entries as prot_numa:
    
  [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
  [2437548.235022] Call Trace:
  [2437548.238234]  <TASK>
  [2437548.241060]  dump_stack_lvl+0x46/0x61
  [2437548.245689]  panic+0x106/0x2e5
  [2437548.249497]  pmd_clear_bad+0x3c/0x3c
  [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
  [2437548.259537]  change_p4d_range+0x156/0x20e
  [2437548.264392]  change_protection_range+0x116/0x1a9
  [2437548.269976]  change_prot_numa+0x15/0x37
  [2437548.274774]  task_numa_work+0x1b8/0x302
  [2437548.279512]  task_work_run+0x62/0x95
  [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
  [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
  [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
  [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
  [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b

This is due to a race condition between change_prot_numa() and
THP migration because the kernel doesn't check is_swap_pmd() and
pmd_trans_huge() atomically:

change_prot_numa()                      THP migration
======================================================================
- change_pmd_range()
-> is_swap_pmd() returns false,
meaning it's not a PMD migration
entry.
				  - do_huge_pmd_numa_page()
				  -> migrate_misplaced_page() sets
				     migration entries for the THP.
- change_pmd_range()
-> pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_none() and pmd_trans_huge() returns false
- pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_bad() returns true for the migration entry!

The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
by checking is_swap_pmd() and pmd_trans_huge() atomically.

# Backporting note

commit a79390f5d6a7 ("mm/mprotect: use long for page accountings and retval")
is backported to return an error code (negative value) in
change_pte_range().

Unlike the mainline, pte_offset_map_lock() does not check if the pmd
entry is a migration entry or a hugepage; acquires PTL unconditionally
instead of returning failure. Therefore, it is necessary to keep the
!is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() checks in
change_pmd_range() before acquiring the PTL.

After acquiring the lock, open-code the semantics of
pte_offset_map_lock() in the mainline kernel; change_pte_range() fails
if the pmd value has changed. This requires adding pmd_old parameter
(pmd_t value that is read before calling the function) to
change_pte_range().

Hugh Dickins (1):
  mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()

Peter Xu (1):
  mm/mprotect: use long for page accountings and retval

 include/linux/hugetlb.h |   4 +-
 include/linux/mm.h      |   2 +-
 mm/hugetlb.c            |   4 +-
 mm/mempolicy.c          |   2 +-
 mm/mprotect.c           | 125 ++++++++++++++++++----------------------
 5 files changed, 61 insertions(+), 76 deletions(-)

-- 
2.43.0


