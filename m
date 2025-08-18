Return-Path: <stable+bounces-169910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06730B296EF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 04:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6FC27A5990
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE02472B6;
	Mon, 18 Aug 2025 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmrqn5w3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eRfS8NSv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CA217F27;
	Mon, 18 Aug 2025 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483789; cv=fail; b=XdEyKJECmoMANqdxiZK5Y5ewDIL8XJe34qTuaouQkoycUgochy0hh4Unv1tuxwFfxjzouPg8tl2yl2lLvWYVtgwhQy/CXe1avZWX1ps2n89pWoN/W5/bHSGbrxFh5It++CJdmcy7IvzwcYaPi0kxrSwUUkGimY4wDlZxbbvFoyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483789; c=relaxed/simple;
	bh=lR8cCbrGgQgEMLluF8UmpJXj+5QGlAr77ogYvT+Vjsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PrEN9V1GmAnzbrCYZK7Ru5dDuFq6P0MmBNR2h5L+UnyMKHq/zG86HOu3TISu2lnr0WVHvmlD4FFUkGlNpCaYd0M5EdhPVYYv9TZyYhO8b5L8Z2gzNdVjiOvF4801qjm2Dw6+3yGsjCKTAMMP4JRNlHp8q2FZxlybnKU1WSgYshU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cmrqn5w3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eRfS8NSv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HNO4Uk022494;
	Mon, 18 Aug 2025 02:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=q9L84NhahhOW0fpeQK
	x7czziafpNxTuDrGt14IK1Cj4=; b=cmrqn5w3Lk5B1soEU3e/UBBeaeKbdJx7WA
	YN6bF8fcryIdJ+DFEXUQvvWbNN0Isb9G2PnMzQxBtb23efwsgC2wzLRpdI0AWVSk
	6pc+VoE44OM7yBiGZ2clTwV9YflqZyICV8x1WrW6U5h1ok+weynWwltGLb9iEHT7
	6jc92AQhEm9zHuO/LUg9sYWTTeRO3HuMhFgExRS0FaaRUusf8IgE+Hwl/RbVhW1T
	s3GJbKiQyufiP9TPmg/otN6dsbsS1V0I6zjzMbxUWHafUVLda/w/XCOGrHHhl3m/
	ekADL64nNEiBN0JxSnCa5eakBSQAUNThqlET1u8ZUfuhqRhDEcRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgdfj055-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 02:22:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57I0Zqf8040786;
	Mon, 18 Aug 2025 02:22:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge8u74y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 02:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLUVUW7UOm3GzeAHW03NbmXX2M9gKNnIERsuYpPFJAxplrzbLffhkQthvEBE2tRFps2tz9iiBNoOnYQ0DoGvCYO0985Y93IiixT4s2FFTmeqDYpa+taNrmV0oIwVdUCxhymYdkZOwzsCzxJgI328SQJVvGdeUa+VLPJ870EA/LNUkCBx2nI71AT5ikvrdw+AxQv5kdRz3qqy3plX+DoCcv9HSo3k4TBjkopp0lj7/OCytt7YkiVoXu+UOnzLrszeCA3FG9qpAYIyxPFA+r5fkTsN9gv4pMRJP2ZkZv56zlBbEDggT/ylRtjS0LYQKshNbvIoFjiKLtnDSWmej4Nu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9L84NhahhOW0fpeQKx7czziafpNxTuDrGt14IK1Cj4=;
 b=adVT2Yz0uWIiBLUVrscb0LFRVnPLoDeR4I8F+FoypNEC2zQw0soBaJKKc8PEmguTHFGQGwuJbkBnEcnqXc08/mNcVFLmQ/fgParmqy4HKyf+oheJk86A10/C2DrUW6DWmUW0C8qf49o70kqzrDx/1L8yI9GhZ5eC/Hv6yFGo2V/S1HCxDsG33ONIR9gdEbP3sfDeNJkEJyxGXtF7OFYoTwPpPcyxchuqGZ29PJMO504MQlA8DTg43OnVn3YrHcyTfMLFlX9YHneattC/lmA1DbKdKOGvx5+Ha74BAfqMcdz1iCzdf0NmR96XtWw4Hl6tI/WaXRGfX1XMNGTv1FNMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9L84NhahhOW0fpeQKx7czziafpNxTuDrGt14IK1Cj4=;
 b=eRfS8NSvl+DJ0Fho7I74HFgmXA259QmS4O6rcKz5RP1zwXBEaVkuG97p1JqUF8eeVkbF7vAciHDP73xI12f1ii0nJUTLkc2XJ8TDAjirBmshCFY0T5JaUc/rITzCyqGyn/XVGeqKnJehD1ho6Zp2zJPAW7yTTdhsAOzXM8ycJ5w=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB5026.namprd10.prod.outlook.com (2603:10b6:208:322::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 02:22:44 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 02:22:44 +0000
Date: Mon, 18 Aug 2025 11:22:36 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: yangshiguang <yangshiguang1011@163.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>
Subject: Re: Re: Re: [PATCH v2] mm: slub: avoid wake up kswapd in
 set_track_prepare
Message-ID: <aKKObGA7TN4Vq9-W@harry>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
 <aKBAdUkCd95Rg85A@harry>
 <14b4d82.262b.198b25732bb.Coremail.yangshiguang1011@163.com>
 <aKBhdAsHypo1Q3pC@harry>
 <22a353bd.1e2b.198baeeac20.Coremail.yangshiguang1011@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a353bd.1e2b.198baeeac20.Coremail.yangshiguang1011@163.com>
X-ClientProxiedBy: SE2P216CA0064.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: c89f0326-e0d6-4941-79dd-08ddddfe1d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tkYrIx0vDD78mSVdYxAnQSW09wLBuLn+aIMIg9elNibjOiZ4SAIpo2wpl+xD?=
 =?us-ascii?Q?D7TzX7cwVB60crsGxgSdFSpkT97s9mVcal+lUAP1qxFKEAP8d5t/2xaMRI8L?=
 =?us-ascii?Q?hr8qvJkCumOgvo3L0ebpGOjlmHX1VWIliEPQu0gsUEL9gpGZG+Cs5xyIWfcn?=
 =?us-ascii?Q?TiwDrnlhCmiYH1Z4//nECCdxsZv8HlfMERXIRG3nQwN3sQThPpnO1LXmPn47?=
 =?us-ascii?Q?9BcMpRqFBR8mw+Rnz/84Tiyv7BmhYb2uATzOLZV59Yo03+EgRTk/bd7u7FuW?=
 =?us-ascii?Q?COhgQDbMbsPnDUppItUKF+ecxaNIgakqSiMKTlRhiRh28Ms5Se3/JpD8lxQI?=
 =?us-ascii?Q?bXNjcrM+WNrcH2ZNUXjGrJL/Lj4rSlEdPRXNbrn01DdjW8x6VxO1d5ARq47b?=
 =?us-ascii?Q?hofXrtEgru1x1Lurp+txya2QgT/8yj+lHxsrFIhyxz8imCuxMZhMRDPLRuAp?=
 =?us-ascii?Q?cEyTtt9+SRB2f4JyY8tdjxI9FiENKeakkoYV4Xp4NhROBhzDS7UsmF4uX4kM?=
 =?us-ascii?Q?n5NtSgLERrMn3AwWJQsao+i23Uxl/Q5neNx5H5dxasp3x5KyiuwxasWRcbU/?=
 =?us-ascii?Q?vITSdJHhHdQMVupFI1MmeohRpJ8rdCpM4eZsOM1ypvKzkjc/73XFX3Z7PLw2?=
 =?us-ascii?Q?N6o1Zr0hYy3ld9oZz/FTOkvmtufbdN3UPSnxSIeOYzJsfSorVirN1TGumYlx?=
 =?us-ascii?Q?k86s8w9GLzH924wPh1pcLshTCWEKfiwwdVZEfmWJ5wnqB/vae9PrfK2ryjWa?=
 =?us-ascii?Q?GwxnwrUxs2rFAF3hWA2C7uStYhVDOwbMaAeDxgKS7+fL7aaj8MLjaaRSdDor?=
 =?us-ascii?Q?BIORIOHIU7XrXz+8F6NyAej7CeLosM7r6NwvlVkXlv9curTERc29u+R+t6rY?=
 =?us-ascii?Q?jeQxzr5pSZGKtEuW4p3PSXVWU8nXKEVHX+Yplc3YR8Xde4MHFRGkKQCnuYt6?=
 =?us-ascii?Q?3iO5v1aJ0yLn9I8TWxZO8iZcY+IfwbfezCCe1DmUqd+E1FeMFHaxDPrkN/BF?=
 =?us-ascii?Q?El0vyD9gBljNooOZdr9QEF7sgVKOfsvVmUTkbnq1AYrYfAOJf/15Enh9LHxN?=
 =?us-ascii?Q?DwRVUKZ4dtE958ad9ZN0rIHMjqoEW7Q1NC9LWZjVYwqaNsGSg6oKORELjQYW?=
 =?us-ascii?Q?lI/8cIdiTsGXRDWSx32xwxp4AMztl2oVOR5HrbEhe0iPEIUHZLvJkrrEWnLY?=
 =?us-ascii?Q?6I1PJqNiAB/JEBM9K36+AX91lDVmHUuUOSN3zCR/PH5dcv5BGPp5+ayP+Ddz?=
 =?us-ascii?Q?05ZmOBUQdHFK1VsarW7AHAzeoFcXoJfDok0NknTWleIzzyutsr1KqQxLVFXH?=
 =?us-ascii?Q?25LW8Dd6H/GBJgfYsQOJV3lFG+v8m15gtnShEm9ApRnsCRRrrXZhv8V+lQOQ?=
 =?us-ascii?Q?nJrhkwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4CiRogSDNjzIcYPsAXYwkBZOoD09ny8RJN/NuBarCnfKRmpBnhKeGiok791L?=
 =?us-ascii?Q?GsFgml0BljDgC/Li0QLoLiErtJObW6c06JJvlI+At91gk41IPIQ9eCtVK10h?=
 =?us-ascii?Q?uLSQzPJG6sMMjswNcqakdsl+5QFukjKS1jmmkJSMnH8VgEePUipdBJhHxBEb?=
 =?us-ascii?Q?d09FwSWAyceiJoWYb9XnSccEljuhaN4fp1mU/m8R9XmreszPZazZ29RB2sVX?=
 =?us-ascii?Q?b9fEDEgxw3IhvPfyXIbAV+9+/a62xwD5g0/v4fb8rVnqKYQYodt2mcZgw/67?=
 =?us-ascii?Q?AuUpXKeGFOezOpb94urbzlSsnNAKBrMUl+eJtQkiMDdsZfqNIvp4xbEc3R0R?=
 =?us-ascii?Q?xMdaY9zGTBIpp8T7wifRxx6r6S8xiFbaXfFvj1UXmobTIfkie/aF5zLh9dK9?=
 =?us-ascii?Q?TKiQ3H7Ds0o4dJWCP0dPUp8jL1wForSzjw/AK5IJy0Rsb/LleYL8D0qMjinr?=
 =?us-ascii?Q?YervprvOQWrL/WHoXy4GQhZ4Am84axXyLTO2KnBXG24qt7VDCDYPrPUdUq+Y?=
 =?us-ascii?Q?BcPxNF+q7zOUIF9kYO4TDfdzF1SDv08/kOh3kEGyr0gcBR2lMTumtKgakcLM?=
 =?us-ascii?Q?VL3kod3TP6AaZdeDBmPefoMJct63L+mHmMtRZiLelj72yQxo4ZrzDu5AafVf?=
 =?us-ascii?Q?ELRpu0q6BIB8p2NgMy2CNsV/rR0csNP4pyLL3MBPkQQ8d5yggkpeZ8aiU4th?=
 =?us-ascii?Q?roZSVZfdB09aSFxeKqLIH6hR0YEPC0FeOEtf/8szVQHTYu1iXE9RRW4HFPtC?=
 =?us-ascii?Q?0WVQoA1emq2l/E94eAKJ3biq8WWXUmGFQrsyXTJ1E5NzV2sv74mH6C0fBldh?=
 =?us-ascii?Q?mkmd3YS8C+3R1PG7+DX2DD71F2bRmPptrcUcxR5cezDPETMfaFLDlA1IyrpV?=
 =?us-ascii?Q?rXQpvckxO/qQDEYlb1JZQwPY/KhhpLMBCunO7nmBsnqxp7vEDiUUZ01v3iZY?=
 =?us-ascii?Q?4YDOJBgxU5odeMUKxD5+e5WW2K3zria2wzD6DFehxM3MJsmInX76iCw11mTP?=
 =?us-ascii?Q?3lTGw7WLNE74I3c1w5BFl8wKWekmbhzTGOJLKJhhvcm3od3OE5tdoGxui5i/?=
 =?us-ascii?Q?4w/968MiKMuGHxELCC/UeUJQMa9JoLaYdqpbT/ACZhyQPvHQ2Zsh8TXAxatl?=
 =?us-ascii?Q?R5ytChHB7gatuvzpLZFVcDWHqsHEX23pImlBDtXAkCW0blENs6LqOvFfgPyz?=
 =?us-ascii?Q?BL/eICcJm3v5z6gyiIFrUasYDkcqFjyoFp+/GtGMD2ka6oxLg1tfdeZlCstx?=
 =?us-ascii?Q?MOpCieSvAwu30skBOa3RnV0qfhvshfevlWXSuHTQGvISvCMFAfv3xKHVS0BR?=
 =?us-ascii?Q?kq/yTpfzoBAFdaxPjh6G5TJLr3QQRgV24j+CWUrngncUurpm7PxbfcD+ToRn?=
 =?us-ascii?Q?/4VZiEErOcGrqGr/Vzp5+LszBGFGaLYIKFVA3seU6AazoZwJElF2F1H4li6W?=
 =?us-ascii?Q?dIXTNF2FnKI+mI4oQp6WfVMq0r5FVRjxsJDjPx+G2dSkaUqBq/GPWIlEbkXd?=
 =?us-ascii?Q?zrPZlTwshvBN1ewjt6wT7OfQiXupnKP0tKO669Nnu1KZUBXqTxSMjZxh8P8f?=
 =?us-ascii?Q?io1Y4Vrl67+dqf5LEfwgKWViZ/hRj/SWw9U0aqBh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2a4UuNJCUzOIsYjf+1NvCOcqWq/OF5MdkTO1Dbiykiap9ulVlG+gJIgxRCISxJK3FtqQjkr9Ln/lKxtNzIYbjPP/EPochpm//42iinTSrDOE2KoLyZ4VW5ocw8UH2zKI2I1mgHu/xXM0XiHWN7ZDb1lK9SE7l53eGObXlfxgbNPE0Q4KrjnUxgkNjtksWkM2PgNGF7CoDb9ylUSk5TWFGs/XNmQsz64Qj40Vqo8VKbCipvxoR18UMnS24fqNyc9jkaD4JOYAuHNn/oUfig+iM6kuZMQHsgWSL+Wk+D8NeMuDScOz3ZA+xGxvfySnxURR1y7TLfEem9ZLabe12PFEWObx9xEw96OZNrFd9fdKJwqVhOzUvYHXeE8XZmVdnuDuSxJ4d4wTlgI9TqXwW3l/l4JNKS1aipXMsFjfX5oDzQrZB1QNaFK7RRncoDLx6pUsOqEVi7vTf31JDKZo1weZyp7p+tpT+/g0Xeskz5UHJMCdMkKcEsGs2vVhWzn4OTxVXC+n9d4YODUjw5W81vnu7pUyhH53uHf9h0i0hPTnij0tCmZlhbiTB5h0vx55D8hLO9WdCqpYPLn+ZdzHZDqFHqZ3lqc8x++oMj5YqMEXNpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89f0326-e0d6-4941-79dd-08ddddfe1d26
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:22:44.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDT96cqH3dLIFmVyM5+z/2c0vYHprZ3enEQLd6Kz3z5v+hQ0xJ7Li2J3IJZvfgyVYWt8FliRuk//HU0gdsN0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180020
X-Proofpoint-ORIG-GUID: S4gKk1A11-VYBxmPkBcTlxBfsN70x5UH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDAyMSBTYWx0ZWRfX7+/gUZ5+pa25
 djGmacxOHtpZFVeKF25QAnvWYJ4vjNtpKqeEdx0qwq1H3cfZzNFQWETnD8k4tAk1B5jAegIEqPb
 b3LB+xTZjryb6BfhTqxfcE81JaxwLvMN7Azi+0D/PCFN3I22AfQUuY9s51m5/JG0lNpLMJP80kp
 gBf6kwA27bUA7zr74mhm/xd5CjWjobzb88MHTvCt05myLgOpO6T9AGLgFMSwZk2GNU+qhyCdhv6
 OmHnipuZ8WirLwya+5dzWx+vU1Rv8B8UQdfCLtmv1lqwg83TPWhlYGLp333zn/AR98EdMH6h/gO
 V0XMx/D4A6wZfq1XNtcRzl3Np0ySv8sCwKduy5ljcyC9GhdBgFh6kdYOi88uww/HKSGrd2U9fok
 Q3LBaF6syIcyPnYdH8ovTwyygl8eB21IirOcEr1GKJPh4KA3TSe6QXzT+Wo+vLRz137tcqoZ
X-Proofpoint-GUID: S4gKk1A11-VYBxmPkBcTlxBfsN70x5UH
X-Authority-Analysis: v=2.4 cv=OK4n3TaB c=1 sm=1 tr=0 ts=68a28e77 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=yPCof4ZbAAAA:8 a=IeNN-m2dAAAA:8 a=sJtbVmcJBxbCO38O8okA:9 a=CjuIK1q_8ugA:10

On Mon, Aug 18, 2025 at 10:07:40AM +0800, yangshiguang wrote:
> 
> 
> At 2025-08-16 18:46:12, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >On Sat, Aug 16, 2025 at 06:05:15PM +0800, yangshiguang wrote:
> >> 
> >> 
> >> At 2025-08-16 16:25:25, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >On Thu, Aug 14, 2025 at 07:16:42PM +0800, yangshiguang1011@163.com wrote:
> >> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> >> 
> >> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> >> 
> >> >> set_track_prepare() can incur lock recursion.
> >> >> The issue is that it is called from hrtimer_start_range_ns
> >> >> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
> >> >> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
> >> >> and try to hold the per_cpu(hrtimer_bases)[n].lock.
> >> >> 
> >> >> So avoid waking up kswapd.The oops looks something like:
> >> >
> >> >Hi yangshiguang, 
> >> >
> >> >In the next revision, could you please elaborate the commit message
> >> >to reflect how this change avoids waking up kswapd?
> >> >
> >> 
> >> of course. Thanks for the reminder.
> >> 
> >> >> BUG: spinlock recursion on CPU#3, swapper/3/0
> >> >>  lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
> >> >> Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
> >> >> Call trace:
> >> >> spin_bug+0x0
> >> >> _raw_spin_lock_irqsave+0x80
> >> >> hrtimer_try_to_cancel+0x94
> >> >> task_contending+0x10c
> >> >> enqueue_dl_entity+0x2a4
> >> >> dl_server_start+0x74
> >> >> enqueue_task_fair+0x568
> >> >> enqueue_task+0xac
> >> >> do_activate_task+0x14c
> >> >> ttwu_do_activate+0xcc
> >> >> try_to_wake_up+0x6c8
> >> >> default_wake_function+0x20
> >> >> autoremove_wake_function+0x1c
> >> >> __wake_up+0xac
> >> >> wakeup_kswapd+0x19c
> >> >> wake_all_kswapds+0x78
> >> >> __alloc_pages_slowpath+0x1ac
> >> >> __alloc_pages_noprof+0x298
> >> >> stack_depot_save_flags+0x6b0
> >> >> stack_depot_save+0x14
> >> >> set_track_prepare+0x5c
> >> >> ___slab_alloc+0xccc
> >> >> __kmalloc_cache_noprof+0x470
> >> >> __set_page_owner+0x2bc
> >> >> post_alloc_hook[jt]+0x1b8
> >> >> prep_new_page+0x28
> >> >> get_page_from_freelist+0x1edc
> >> >> __alloc_pages_noprof+0x13c
> >> >> alloc_slab_page+0x244
> >> >> allocate_slab+0x7c
> >> >> ___slab_alloc+0x8e8
> >> >> kmem_cache_alloc_noprof+0x450
> >> >> debug_objects_fill_pool+0x22c
> >> >> debug_object_activate+0x40
> >> >> enqueue_hrtimer[jt]+0xdc
> >> >> hrtimer_start_range_ns+0x5f8
> >> >> ...
> >> >> 
> >> >> Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
> >> >> Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
> >> >> ---
> >> >> v1 -> v2:
> >> >>     propagate gfp flags to set_track_prepare()
> >> >> 
> >> >> [1] https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com 
> >> >> ---
> >> >>  mm/slub.c | 21 +++++++++++----------
> >> >>  1 file changed, 11 insertions(+), 10 deletions(-)
> >> >> 
> >> >> diff --git a/mm/slub.c b/mm/slub.c
> >> >> index 30003763d224..dba905bf1e03 100644
> >> >> --- a/mm/slub.c
> >> >> +++ b/mm/slub.c
> >> >> @@ -962,19 +962,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
> >> >>  }
> >> >>  
> >> >>  #ifdef CONFIG_STACKDEPOT
> >> >> -static noinline depot_stack_handle_t set_track_prepare(void)
> >> >> +static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
> >> >>  {
> >> >>  	depot_stack_handle_t handle;
> >> >>  	unsigned long entries[TRACK_ADDRS_COUNT];
> >> >>  	unsigned int nr_entries;
> >> >> +	gfp_flags &= GFP_NOWAIT;
> >> >
> >> >Is there any reason to downgrade it to GFP_NOWAIT when the gfp flag allows
> >> >direct reclamation?
> >> >
> >> 
> >> Hi Harry,
> >> 
> >> The original allocation is GFP_NOWAIT.
> >> So I think it's better not to increase the allocation cost here.
> >
> >I don't think the allocation cost is important here, because collecting
> >a stack trace for each alloc/free is quite slow anyway. And we don't really
> >care about performance in debug caches (it isn't designed to be
> >performant).
> >
> >I think it was GFP_NOWAIT because it was considered safe without
> >regard to the GFP flags passed, rather than due to performance
> >considerations.
> >
> Hi harry,
> 
> Is that so?
> gfp_flags &= (GFP_NOWAIT | __GFP_DIRECT_RECLAIM);

This still clears gfp flags passed by the caller to the allocator.
Why not use gfp_flags directly without clearing some flags?

-- 
Cheers,
Harry / Hyeonggon

