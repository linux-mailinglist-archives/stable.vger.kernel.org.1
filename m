Return-Path: <stable+bounces-223282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBVlHnEIqmmVJwEAu9opvQ
	(envelope-from <stable+bounces-223282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 23:49:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3321913E
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 23:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 934CC301D96B
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 22:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4E35F166;
	Thu,  5 Mar 2026 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AlKYvPb5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rlkqzmfh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF875334C08;
	Thu,  5 Mar 2026 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750956; cv=fail; b=lZ9zlQ3H4MJ1eBJgfsR8gxVL6J+fizRrN67WS3gAjmqhWRh9v9GNuIKq/TOlKVto9cujAHvtUMj2jAyxilE4D1a51TOeVvTLwO9L+Tl+YxnUlJRJWnlGpwHyj8wMPgZJgA8jM0cyS+Fgcf5hYQcS8+VUV8Il8CGQ2OxcB/UER5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750956; c=relaxed/simple;
	bh=6xTL28rnwhwEBD2wOE72SD3QC0Cg3iTXQqYXZ84dIP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sH1x+FmgbkyT2f89poBpRyfamYx3Pgl7QRnNYWDljfD+UcbR4mrSWkyk21xgQ0+LK+DGWvdYcpsza7v8xFUpgH1frjAVgUBJeS6ngRdkDO8QlHey2UnTDezXAgtSsZxnNlznrQ9n0zjoR9WkAXauUI3EdX+UphR/h8bq9OFhh6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AlKYvPb5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rlkqzmfh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625MfYed1295551;
	Thu, 5 Mar 2026 22:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qhsoFdTFgIZvy+nkAJh4r0Rz8ZGoO9tqDd0pfPgRMtw=; b=
	AlKYvPb5EmCxtzs1uTwLP25CotOOnvUC04qeXBf8ENezayepwIkQPnyTJhiLBBqw
	nwSMd49YiFiAHnn3kE74pDVdEvAUx8qtG9qBB2kd11MPFkbm9FC+UcmKPpS07ynJ
	OuxMZNmR1/RNqJcjr25fiRFpUP+99ugd7afrCHUuD9z14ymZPDW3NOY/CmdwhQBa
	QC3qG1Nn0Xl+Kqupco0dK79T6QbKJsHuR2ody0R1yosids4J6yXQKmxerR1LStmh
	4qwQN0GiXuf79ZdJvK+A3BZDbBVIS/a7Ue/RI2T/0Rf9OxIPDQVFV6WrCXiriNYh
	BbLNOxKxtxyNa11cRsMH6w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqjupr082-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 22:47:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 625MYk1h001461;
	Thu, 5 Mar 2026 22:47:16 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptj6q7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 22:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMN+8wH6dS3bPWZwy9NvhsXOKLjQm4StxvOJql+zIn8i7gqEsz609/VIbRCcLkwG7up1ETVTv6K7CMhIiJm6F5wNzSICUvpoVdTFEgBgOfVJjuS3uQpFJP1Rx06fR84lIaLcoD0QnO7DodII76nAtWmn9Tn82TC4R2cwG9V4eLf4yjOq7oflkJv8eqZYKBNQohLaPdIvnOcLl7HY2utN/kJ4Wi9q/xLbi6c0DVyBg6Lp4WOLGTGkSI2R7NUfBjBHJY2R9EufyNko/lHFgJBM0HIfzOpc4yzE3Ph89JM3RrzIWqOHgUBFD2EdXDDHPzWadG4Fcjj81hzrhypOXoTcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhsoFdTFgIZvy+nkAJh4r0Rz8ZGoO9tqDd0pfPgRMtw=;
 b=qypXt/HMOBOl2S59W26X0+t/1RFNJVThZ/u5DzAtJL7X41uK5/ltdtUfYOp7DqTG39NYu4wST5BwBq2A0o35tL8wYyCmVzkzUN0DNu36lcLWt8YHxY8aQab0YAbF0mQ+yUkaDV5dHIokgESZI6889mABHt9o7QEKmTxVMLkeZGldywbhKWuocNBFEmafgbPzeDn5qeLI1lOoz0o3ZjXwFLHmp8LhZVYZZdWIcIB/4OrgOoD/ix2gx5sjWTrcQHIy3wL/C/Wrs44xbYH+TQS07B+s57LHeVEx5f8GQYTLTlS8BGhWtUkDQ+NIrtBNHQD9Q8ZHGdhcm3AHwPIx2UixBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhsoFdTFgIZvy+nkAJh4r0Rz8ZGoO9tqDd0pfPgRMtw=;
 b=rlkqzmfhDPVXgnPx9ehD8ME0OpAqacOK4RqtyNOVQJcqW9BZZsDCy3E1PH05RM3Wcgpc0Y+syaRbrjBTR8CxEkhOF8KrWQQcfSEI3z9J10JvCbMas6d0F1Zbp946Kl5tl/4ipQnU9dDYz9l10obB88opPdf7csrxvOVxcxcIWVg=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by IA0PR10MB7545.namprd10.prod.outlook.com (2603:10b6:208:491::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 22:47:09 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 22:47:09 +0000
Message-ID: <2ffaf154-3b5d-4e49-a0d3-4aedef3501d4@oracle.com>
Date: Fri, 6 Mar 2026 04:16:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
To: Peter Schneider <pschneider1968@googlemail.com>,
        Sasha Levin <sashal@kernel.org>,
        Brett A C Sheffield <bacs@librecast.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Garg <gargaditya08@live.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "graf@amazon.com" <graf@amazon.com>,
        "guoweikang.kernel@gmail.com" <guoweikang.kernel@gmail.com>,
        "henry.willard@oracle.com" <henry.willard@oracle.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz" <jbohac@suse.cz>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "joel.granados@kernel.org" <joel.granados@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "noodles@fb.com" <noodles@fb.com>,
        "paul.x.webb@oracle.com" <paul.x.webb@oracle.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org"
 <x86@kernel.org>,
        "yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
 <aam_-Y7q-c3gmfGY@auntie> <aanlzq-RqDF9xkdI@laps>
 <6f42cb43-c281-4565-b968-afc34502b9fb@googlemail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <6f42cb43-c281-4565-b968-afc34502b9fb@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::31) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|IA0PR10MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2fa415-6946-42d4-6698-08de7b092232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	c9kqEH9SJflvK15kiT+jhtqeoh/rR9fpURDK8s+T4K1dQ97+cOECMr+zxE+sLosgxkfpONJyTm6MraVwOkje8fpWhlN3PCF/A78pJrq371gBwmpDH9TzdIgWTwqtB5AlE64m0g1gN16FUgJkffBlaGRMhAGgXLfvTX8PkaT7SR2KiAMuyUru+3GAPOEntRoHW7cM51CAeBvJ6E+1REhvnhZVICawb1cWfXgsvKFeeL7crQV3QTePdNYxyUXlvysyzR1AvFwm4x5oVmqEkhoZAiUPG0vOQOzawl0wE6gy/NaTJ3U+51Md5/wn4o2v4WnxoObL/h7aBY2ut7My/INaSWAeQbqqNjXdL5mzIPwYX+oEbLKf3OE7UxoOQa54fURjtylORuyS8+gPx7XAOLz8sSbNOWxOwqii0hmV2mVsbxO+GmGgEI/ZX4kvR91J961+4QKlbPqFywQtYpFT80/Dyt0XTxm5jN5/PeQUOci3e36XNX4FHVExZ8X0McCmtWGrb/KqGBtdgug1bPgyPA13oGbRH89K+lJoXQ/IGo1yYji7AxI9irSR0j5riv/oEGTswrf1tc8ry+iR9w67xqTL8EruZAcfaEQggJNukipHKLKvDch6OKvewJVNQ6wlKwfwR1sSGsDO1Z3X2wcPJ1BuNInC8B3+UKTs/VGmkO3ZaTq/B4nhArwPEduFDMOuaZriRF3xKuqdWotsY4XVUIGar18ThiAR6pTfXM0synO8wg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2FkK20ycVdQT3FJMWJIdkVyQUtQQ2RDUksza2lGRWdMVTVyU2JJdUpKTHVG?=
 =?utf-8?B?THN1MCtPbWFsOThlNzV0cmRFYjNtNlY0K05IQnhtQzVkZXhhQ0EvaXVjaHRZ?=
 =?utf-8?B?aTZYTmZRMUxCd0FXV3hiZUpkVXVuaUI5SHl0N2ZKU3lGNnd1bDJPeFpWdjdP?=
 =?utf-8?B?VjcvVWp3b1ZNNHlYSFc2Y1JQeE4yRzVzRVI1WThkdzVOR2hNempXbVhkWGdX?=
 =?utf-8?B?NS9WbFprbkF3d2ZyMkFlb3RxelI0RzFKanVnbjgzREg3M1REc05IZVczZmwv?=
 =?utf-8?B?aUR0TlVaaXhhU3o3MGJhSzJ2dmxsZlNEdVI0VGZLME5wV3dmN3YxR0Z0aUV2?=
 =?utf-8?B?OFlxV0xSTGs5bGhaWWkwY2ZSUlpVSXYrOEpUT3VmMEQ2aVVUSGZDeCt4WXZS?=
 =?utf-8?B?S1pkWWhtQkJCaHo2T1prWHcxVkJnczVncTJRR3RoQlVGM1RQd2lsNkJ2SWFO?=
 =?utf-8?B?VXNXVDRzM3RMK01BMEN3YnFTWXRBaHNLRzRYcGppQnZIdHlOY2M0TC9jNFVn?=
 =?utf-8?B?MGtpS1ZTYXYyWkJGMldrK2R5WDhhU0FReXhLNG5OVEVwUkZTMlFxQWorOFl3?=
 =?utf-8?B?K3hwYWd0UjR4WnBxZk9mOUo2dXJWSnhVemU5VHQrOWQ2STVaM2Y0ZHZqR3hk?=
 =?utf-8?B?T29Qa3FETVRxcjZMR0lsUCtXdWIxUDN1UXNGREtzNDl4Rkg3YktJaEY4Sm11?=
 =?utf-8?B?RU83Ym84cHAvTVI3TkI1YXFuNVhmbmxtWGZNczlMYWpLMFp6U1N3S2liQmJD?=
 =?utf-8?B?OXBLT0d0VGZ2cWJvL3p5MGZBQVJuRUNncXdpV1FCWjB4TUZtZmhLTy9WUldB?=
 =?utf-8?B?QTlMUyt1RVZ3S3h6ZTE3bWJBUmZpOU5nRGswV2JKUlB4UlpuZC9lMnpYNlpk?=
 =?utf-8?B?amZzLzA1Q3hLTk1pTWY5Y3A2OE04c2U1K3NRNXI5MW5GMXFEcEh2eVMrcmNG?=
 =?utf-8?B?VitQcStSNWtUZnhQcWlaWU9aRnhHa2RVV00zaFhNWloyL29sQm5pa1ZBd0NE?=
 =?utf-8?B?bTNObEl6S08zT2xWTE9oYzhkQWR1bDgrNkl0Zm1uUHVnbUdybmREbnovVlI5?=
 =?utf-8?B?bW9jcmRWbVQvdExFYlYvNkk3dHpiSjNBTTdzZmFjVExKeWxRSitQaUd3ZFgv?=
 =?utf-8?B?d1d3clZySTlXQ05IM2ltU2ZZZXhjUEd3dmNFNkRpc0RhOGJhd3NlM25UQnZV?=
 =?utf-8?B?Q2V1b2l3TFU4eWFuUVVraTUxNnpnVDJ6VVgyeGxEY0xKdXVOR3pNN0dqY0FM?=
 =?utf-8?B?eFdPSTF0aHRZNnZJN2xYcHpaSTdpL2ZRdkk4aHk0S0RSMVJQajFtSkVNTUxv?=
 =?utf-8?B?UXZOamlSODdJYmlqRGR0Qis5eEgvcWhERmw3VUxuZURnN3pGMXdUL2ZUSExM?=
 =?utf-8?B?TmZjNXQxK2dLaFhXSUxzaWYyN3dSVFh2Q0pscjg3R2FaR2NKeE5nODc0cENs?=
 =?utf-8?B?dnNxQit5OW1GL3F3Tis2dWJHMlRjTjlyRzlOT0t6TnBINHJ4Mld3ckh0OWtn?=
 =?utf-8?B?UkhnbWFTbEEweFl5ZnF5SWQySk1iR0JLQ2t3cWcwc2VTUWkzN1FONElMVm1z?=
 =?utf-8?B?b3ZRMFVLVE15L3VjTklocTFhd25CVm9PRGxPdHQyUE5LMW94dlJ1T29abWtH?=
 =?utf-8?B?d1Y3WmlPMHEyQ0l3ZFNQR0NIeEJqaDBDTWFOOTREOW1yclVnaUZFMEh0SE1C?=
 =?utf-8?B?MkVBT04rUTZ1WXFHY0VvWU1YU2o2QU1TZmdLZzdxZ3ZEazh4czNFTUtUaWt3?=
 =?utf-8?B?MjZ6MmxYZHMxM05LUVVRSDVDbFFRUDJ2QnZvMEozS01jSDd2WTlwMkp4QTI3?=
 =?utf-8?B?clpZSWNnYmV5d1J0MzI5dktrQnc0YVVrUFVOWWpFZEVBRHBoUW5pNVZSZjYw?=
 =?utf-8?B?Ynk0V3NMakY3U2ZpbHdoWWNBK3BMUmxRRWQyMG93Z0pkamJzaTdza1pCRWZC?=
 =?utf-8?B?WVZWSWUxc0NTd29sQmJJMklKdXB1bFlLTTRkQTlDYUFGL2MrR0NRMDJvSXpG?=
 =?utf-8?B?cENrZmkzUXptd2VlcTNiRmxxaDNXMTQwZ01FZG5sMWdFR1VhMXNLM1ZyY09s?=
 =?utf-8?B?SklJOVRCOUhBdGdWY0NLanBjU3BpSFI4bi9ZNDhMNE1iTStmWWpodnVYckxC?=
 =?utf-8?B?NUhpNVhKYXRkd2VzTE9pYXIraWRPd3pWZ2N0eEM1QitvckFUZkl2UnFYeWRY?=
 =?utf-8?B?MjArdHZmbmdKd3FIUE1JNk1qcjJRM0hydkhhZFVEV0dYTVg5YllsdVVKcUVa?=
 =?utf-8?B?SlJINEJCWExCMC9oZ2ZmUVNpYUJEdlVSVmJJR1Q1c1cwaXZTemNIRGlxRExm?=
 =?utf-8?B?L2ZHb1FaSytPWEJNYklYZnlkSUxENW0xbzd3ZjB4c2t4QUZMWjBjRm10Ylpt?=
 =?utf-8?Q?Ml5VbuVNUg83vBA6XDVay7SjW7s6WdF/oIceR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g0eKVD77JvWTyA/qKjz/tx8OqJ7WWN5osLzltBYsDZqABt/kEb8RBZqpv7NtnoSPKoJaO9ZPQ0qSbWPTrhp83l65NCsu6UUIHrFuO5+/xzK3TWacUqcnqb8k9CHwh8cO2bdsoVxWG9sA/VYtQdB+1TYHTNSJ0SV9uy4/n3V4j1ZLR+2tiX+lAUuz+129FV+lWAtg2H51tppbZkS1l+NL/YV3vQM+bmQfg6pii2fSwZdX3hXQ/hC+pjjW4AUCglVgFb+vTUcpmzL93fvDdLgatZpuQByTKMxoFotRVC6Lp/G0VIRBi05m4aY2Ir9ieEGidp0HZCToBZKQmqzg/hzSKu8eEWlKQFhjJrvuaSwClJMM2J3Qls42TKppEykHQBPy+2A4YSBPkyCRtAXNz44goz90vtzjqw1c0zvPRBWatAvzvMzN2xUpcYFkYHa/r4Qn4skxwv0mmK4rb5YBTigQuuVsf+5etKD+xpU2N7YBe4b8uqgzn+2vWsKdQRcSERZU749P/H2g3dTo81n0s1ccA2ud84Pej3joHABCvJWFPwuyCqf5G83N2vR+9ZOpbcXPGnP4LG48Tzvy/3Xa0eXf41V8SXL7D8lD3vVvKTlsgtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2fa415-6946-42d4-6698-08de7b092232
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 22:47:09.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keryO7phxwFjkIhYNNt5SrtskKVGsNxvnXvg73U+2Pxlu+NUw6DkNlhFN9K8SlV0kAQIlrR4owPGlI2o4j+h48LlAmpeVOrrv9Ph0S0x9kBvn14kzLAxpXNFPccAR+dA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603050195
X-Authority-Analysis: v=2.4 cv=E/zAZKdl c=1 sm=1 tr=0 ts=69aa07f5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=r4i2-iqrLMQ46bfHh84A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13812
X-Proofpoint-ORIG-GUID: EQZruEPh4C8Gv2hwm-llYjCpKEpx0OIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE5NCBTYWx0ZWRfXw0rztFDpsZL8
 tRjv05EPfJ50XgW7loz1H2kcStHAjN+qMl2Jwr4lUythqK44QqRQ+SiNx9qVa1NhC796A4Kf0Ul
 xw9GhdHgqluSMVtMoUktJeLsz7uNxfKR9zLhuckLCYA7SH9xDnPWjjtvIQ9BbdmDOBn3HY6aWG+
 QDhPCRQo6DxR4YyLu5Rd8tWDEDWFEZj0XuGwih8XCMv+yYo8x/ICnzS/D8M2XbgDqlXJNkR9xU3
 j7bJQpB8VLsWMV9bYLNO6jrrR0eNpNFJALRGXDKfoUG5YLA8VoGKCp6xqNcG7SENSyESdOIABGv
 YQEfnSJZ4oIAW4eNtbS22qihkCFYcnuGs0W0UAEp0r8/Pq68AHcYmlKR9EvfiVD05oo6ANovw7Z
 ZkNDew3ed6QEbf9aX1lldLJuDKo9oS2QF+dlwczGNo9YFEVbHpWsoDtBNnY9BFQZPtkUxaFHe/T
 9V2dE6ljgNAsD3BTwzh2q2xm918+4ekTkW5OSly0=
X-Proofpoint-GUID: EQZruEPh4C8Gv2hwm-llYjCpKEpx0OIT
X-Rspamd-Queue-Id: E3C3321913E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223282-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com,kernel.org,librecast.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,live.com,linux.ibm.com,linux-foundation.org,kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,oracle.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi Peter,

On 06/03/26 03:36, Peter Schneider wrote:
> 
> The people who tacked their Tested-by on yesterday's 6.1.165, 6.6.128 
> and 6.12.75 RC2 did so after testing without the patch "x86/kexec: add a 
> sanity check on previous kernel's ima kexec buffer", because after my 
> initial report you dropped it, but in the final releases it was present 
> again (essentially invalidating the Tested-By), causing the same build 
> failure, but only on X86, and only with CONFIG_WERROR=Y.
> 


I think the kernel unconditionally adds 
-Werror=implicit-function-declaration whether we enable WERROR or not.

Notes:
------

$ grep "WERROR" .config
# CONFIG_WERROR is not set
# CONFIG_KVM_WERROR is not set
# CONFIG_DRM_AMDGPU_WERROR is not set
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_XE_WERROR is not set
# CONFIG_DRM_WERROR is not set

$ make -j arch/x86/kernel/setup.o
   DESCEND bpf/resolve_btfids
   DESCEND objtool
   INSTALL libsubcmd_headers
   CALL    scripts/checksyscalls.sh
   INSTALL libsubcmd_headers
   CC      arch/x86/kernel/setup.o
arch/x86/kernel/setup.c: In function ‘ima_get_kexec_buffer’:
arch/x86/kernel/setup.c:380:15: error: implicit declaration of function 
‘ima_validate_range’ [-Werror=implicit-function-declaration]
   380 |         ret = ima_validate_range(ima_kexec_buffer_phys, 
ima_kexec_buffer_size);
       |               ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:229: arch/x86/kernel/setup.o] Error 1
make[3]: *** [scripts/Makefile.build:466: arch/x86/kernel] Error 2
make[2]: *** [scripts/Makefile.build:466: arch/x86] Error 2
make[1]: *** [/home/opc/linux/Makefile:1954: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

$  make -n V=1 arch/x86/kernel/setup.o | grep -o 
"Werror=implicit-function-declaration"
Werror=implicit-function-declaration

this is likely because scripts/Makefile.extrawarn in line 13 has this 
and that is then included in Makefile.

Notes:

Patch 1: introducing a generic helper (stable CCed)
Patch 2: fixing a bug using that helper (stable CCed)

So while stable scripts picked up two these was no conflict because of 
not picking one and the build problem is not seen in few configs because 
the code is really gated by CONFIG_HAVE_IMA_KEXEC, and HAVE_IMA_KEXEC is 
selected by CONFIG_IMA, so the build problem seen on some configs is 
equivalent to having CONFIG_IMA or not.


> Now in todays three releases which fix this, you wrote in the release 
> announcements "Only upgrade if you've observed a build failure with 
> 6.1.165." / 6.6.128 / 6.12.75.
> 
> But this wording is, IMHO, inaccurate and inadquate, because people who 
> built yesterdays releases with CONFIG_WERROR=N will not have seen a 
> build failure, and if they now, because of your release announcement, DO 
> NOT upgrade to one of todays releases, they now have a kernel with an 
> incomplete patchset, i.e. with only the patch ""x86/kexec: add a sanity 
> check on previous kernel's ima kexec buffer" and not the three missing 
> prerequisite patches from Harshit's patch series which he said he will 
> properly backport later, and this could be built only by lucky 
> coincedence, and THIS is the combination of code nobody actually tested 
> which Brett talked about.
> 
> What does it do? Does is cause harm? I don't know. Do you know? Maybe 
> Harshit could tell us if it's a serious omission or if it's not 
> critical. This, IMHO, should have been avoided. The better wording in 
> the release announcements of today would have been: "All users on X86 
> must upgrade", so that nobody stays, unaware, on a kernel with that 
> incomplete patch set.

I think only people having CONFIG_IMA are affected by this patch, and 
whoever have that will run into build failure. (As missing function is a 
for-sure build failure).

A possible process improvement while tagging to stable ?
I should have really marked Patch2 as dependent on Patch1, (similar to 
what we have in stable, we do have stable-dep-of tag for prerequisites).
but we might not need, as, how it worked all this way then: we might be 
running different configs(allmodconfig, allnoconfig, randconfig etc.,.) 
like in this case few configs detected this build failure. But this 
might help if there is a functional dependency and not compile time.

Thanks,
Harshit

