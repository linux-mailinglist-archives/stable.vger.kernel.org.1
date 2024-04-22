Return-Path: <stable+bounces-40412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC608AD94D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6357E1C21657
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1E4437D;
	Mon, 22 Apr 2024 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZQcRWl4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lEMNGvxm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C804437F
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829755; cv=fail; b=dgh+lH8YviyrsRDOK+NsOgovDKuJ9QBNkmVILh4uh3rQ0zbGqk0Edm5oDwTfB3P9f4pSgvdVVRmCJN7P2Wfv1OpiTykYGeIda9mMEOGBqGXIpNq0bK4qrtLIydHAy5wHpJD+Qlt3FUM00sa3R6/eqLLOlN1eVkArMVl2heGOK4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829755; c=relaxed/simple;
	bh=fELk7yVy1wgF/NXeU5vc+Q9iTixqq1SfETYojEurC5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=obrzISTqoJhRZ4TvaD4B5myoTzM19IWqMvinXjjd85Bt3pU8jgFgAKT/9g667SJGU5SwjK2NzaqQZNViy4xqq27Iqm11lt6Y3X10WIyOuOaetBPmdQhOzv1d5mILBybM5zN9YQR2jDFtR3WZpKOJAWarHaJCSJRRIjcxrQxAu9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HZQcRWl4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lEMNGvxm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHmmHC017465;
	Mon, 22 Apr 2024 23:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fELk7yVy1wgF/NXeU5vc+Q9iTixqq1SfETYojEurC5g=;
 b=HZQcRWl4iAnqI/g5UiWFXvrZL1AlqQVejMvtBk1k0/qJo10C+cIn/Lbs4yBtCDDcH+jm
 CLd3vVn/dFB9vTYALRv0wK3CirQjYJKT3GtYXmsPrM9GpIjlXwFf9xvkUFntfnJGs0pe
 Q8ofQDQloBesq75FVQsc7LTLg13X9NHLBxnNgzihUtz84aySUDeMCEMappn8ZZcwOVJv
 BYfKLABYskWfAxvdzq91LrG1elbperKyhHj+Zo8Ta2bXTGJqdwo5nY1+HFky/t7txsS2
 JVIu2G7hpGmXrETRhK4VSQ8LHKalJV1j+3OfvkZiZ+Ld67lP1AzHb/PPjdkQXDM8175b sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4by5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 23:49:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MMQUEf006977;
	Mon, 22 Apr 2024 23:49:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456d21j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 23:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4B8hOTPS0FNmHIRQ22pahuATJ5JA074qMD1RDc4I5Q7ripN8AH8IthnEvvNUnC9Ryhj40PXh2fbt/TihyI76igOL5XlJu4AC6vAkV0JLvZfDQyxrNYmOYn9xneNuloU41Y7CYvw5+91p9PjWcph+MIf0TSTC179xtg795dwj3Vn+ZXVhfbyTXysYHu55tlNJ/rAPhntmLrUMhmMc26l6B+dEbX9zWxjpQN5u2YgXvZVPQsGoUBVCxtrx9alcAlFcCNXsYphwSaIjFMYhgjVfBJ7NXxf1kl1JaazP0sPXQPrArBjmvDMrwgeujd63KocUgjfVD/kQocny6rgrSHXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fELk7yVy1wgF/NXeU5vc+Q9iTixqq1SfETYojEurC5g=;
 b=OZpk/+nPVRrGvHibiTVhjIcTWp+Ttp2KgixSG00gr7nKaUW4qEFPBGmPsJ0WzYn8rljmCsF6oOhTmimEoEqj1xfT5lvGLbWiCltHXkDdLLbx7/VuO4gFduRE6NTiuVHmZwlsjDtr0HiAMF/F+V7QmzBcCPKWOukBhhxmXb4chjS4ZeVqY/NZIrGSKuLt31di3FMaqYcJx5preEncWrC8SgWK1A80hwISDsHgrnsL+rvmb4FaBPyOE8cisUP8NEY24tibkcNB+LJh7NM6UpxCppJ4N1PwA5DXffbNdMOQPs2wBxFUCht17R3Rj7L6bSunodIRY8ZCdK0NSu1zWJz4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fELk7yVy1wgF/NXeU5vc+Q9iTixqq1SfETYojEurC5g=;
 b=lEMNGvxmKvUSgfz6G/gT8mdymf8CUDBOeL9eaFPlRK20hhIikmkW8nS+7iBC9odCVEbHj3h2oEibqI3lKTfLxV1L7TJn/8/yO2AwvkhO9KYUhHZwjLJYybFkKu3pNpu1dedsqjz4rfA7lrESuGkIuv0R1zx7hpMyLJTEUcKUmmo=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 23:49:08 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::485e:729e:c0a4:e562]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::485e:729e:c0a4:e562%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 23:49:08 +0000
Message-ID: <def9e0ce-2998-4fe9-a4c8-151ed442e541@oracle.com>
Date: Tue, 23 Apr 2024 09:49:00 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4.14, v4.19, v5.4, v5.10, v5.15] igb: free up irq
 resources in device shutdown path.
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <20240312150713.3231723-1-imran.f.khan@oracle.com>
 <2024032918-shortlist-product-cce8@gregkh>
 <28752189-6c59-4977-abda-2ea90577573f@oracle.com>
 <2024042347-establish-maggot-6543@gregkh>
From: imran.f.khan@oracle.com
In-Reply-To: <2024042347-establish-maggot-6543@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: dd18af6c-e2d2-44aa-1fb4-08dc6326cd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TWszcHJHVkprS2wvNWRQOGFLSDRDZWtnUkVnTlVsQkV0aG9EcUJyMXB3YlEy?=
 =?utf-8?B?ZFJ2SW9sTERTMTkxUUY0Z1BOMlE4K2IrSmMyMjNpVzVJRkZ3ZFNTUzFNSDJZ?=
 =?utf-8?B?NzhNV1ZKcGNYQVBjbEFUemUyVFNkcTBld3NxL2RuSlA5TmFhRWlBeGZnTnY1?=
 =?utf-8?B?Y1dxKzRaS3FIV3lxSGs2a016allJMlFOQWJ6VGIvSzhLMVk0dSs3dXg0ZU5m?=
 =?utf-8?B?ZFA3RmFBeXJtajBGSzU0V002L0JkZnl1TG41TkJHOS84bmZSSjlCOCsxbEsx?=
 =?utf-8?B?NUpMSlRZMVJpWmNENUZMV0dLdUlHc0pUNzhpdnhTWEVqMHlDbXBHRUNsdkNh?=
 =?utf-8?B?SFhjYmc1b1BSeXRySk8yNEVwelpBbUlzeVNEd1NSNFlLTy90elJqcXBjSmVS?=
 =?utf-8?B?VmIyM2t1WHZQWWE4eC9hdHNqeVVmZUF0cUQzNGFmTkhRZzcvNEdONXg3NGMw?=
 =?utf-8?B?QlI5bEdEdlNGMlNRd1JHdERVN1BiSUxyUlhrMHVoRUhzS2dydEFPRDdSQ0FO?=
 =?utf-8?B?TXdFdkpjWGlINWgvM3NCWGRQcHIyeUZSbWRqd0RJcllQUGtOaVk0blhIRW9l?=
 =?utf-8?B?elR3cnM1eVdsZG14ZXYrdE9PcXF2MVE1ZG1iZE5MMzQrMGRUeFUyeFdwaHNl?=
 =?utf-8?B?OWljTlI4VWhGU05TTEkydlliclZMSkNuT09VdnVIWld1bnRKMjRQQVgrcU9m?=
 =?utf-8?B?UXlkYklwYmlsQ0c3dk1COFhEb05uU3FZSGdsa0JrOHJDQk5uNWFteEV3OXVY?=
 =?utf-8?B?U2ZhSjQxWDNaTHdLZ1dvUko1SVZ6M0hEY3M5eElWaVJabjZDbWpCQmlDTi9U?=
 =?utf-8?B?U2lPZkJwUVNIcVRaMDZyOTkrSXB5ei9CVTQ5UDB6TDRZa0h0dmx6MU9lcE1B?=
 =?utf-8?B?dUpUYVNYcFllSTZ1VWwrL3ZtY2J5MHU0dkpmUkdBdU1OVnE4WnNFK3pyNXUr?=
 =?utf-8?B?YmZ6RVVvalUxZ2dPNy8zK2NpaWpzNlFLazR6d01CdzhWS3JtZXM3YlowUFVr?=
 =?utf-8?B?UldzY0E4bzUrTFF5UjZEeG92V2tIdW9JZUtKUk9zZkR2ZG9xMElabVBSQzJX?=
 =?utf-8?B?emY3SWJyYlZERVRCYit0dVg1TWhqcm5qcWJ6VzBYOG9nSWx0bm5SVUxnbGp6?=
 =?utf-8?B?YlNxQTFOcXpFSGcxUDdSa0lVTTZsUzJucHZVUUREdWJXa0VMTXZ1UGZYdlRy?=
 =?utf-8?B?R3NiQkRhV3hGK1BpZEYxRVdZUWRRN2V1SGVpTmNOU3VIdFVUVGtldy9PQm96?=
 =?utf-8?B?QnQ5am5PVVFKcUdnZWFzR0d3U1A1bGtsS2wvY0Y4VVV0cWxIVzdmT2lCaXRo?=
 =?utf-8?B?bWc2VUpKN1ZWK3VpNFVzOVBDSW5NTW02SDV6UHlCVEU2MFZscitUM1AvYVNP?=
 =?utf-8?B?RFFRQUFOL0FBbnpTdzBzcncyRDFtMnU2TDNSTHFKaitDL2V0dFo3bkVQRGt6?=
 =?utf-8?B?RGduTEhVc2ZIZVBobGlDcTF1YWJyZkRuMUVqOXBaOXFqa3VSNEN4Ym95RXd4?=
 =?utf-8?B?dVpDalNiOTN6V2tSTXo3ZTR6NXByc2IzSUptUHBNUUM4R1lyV0hGTXJYYXFZ?=
 =?utf-8?B?M0NUVHN0VTk4UzVnYnFDTm15RTExa2xiL3ZUQXNuS1k4REtCWk12K2dXbXla?=
 =?utf-8?B?eDhPMzJUTDE1WDZlUTVJZVlVM3drOVJvT3U5Z2dPWDRHbEs5WG1heFFOMEtN?=
 =?utf-8?B?OTlZZGdzOHBQMFIvK3p4ODJYOU9VQzEyTkQ2b201TVhiUEpJTGNncXd3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1hMcEgyTDZDanJlM29ZTjZrckZwYVpxVVAwYlVKSjNLUGs2YnhtQStvTk16?=
 =?utf-8?B?K04zbkYzYXlKd1BEYkYyRkZxWENLRk55L3BPcFdxdmpQOExob2lhWXdtVVhP?=
 =?utf-8?B?WTBZb2REZkFDcExOVXk1UXZlNVlRU1VpdjBwMUNFdlJlUXp2dThTRksrYXYz?=
 =?utf-8?B?UnVtbFY0a25NL2dwTDJNSHpaR1hkZzFMZEpkeStPQjhyNXZEU0lKYjgzeW1R?=
 =?utf-8?B?UzVmTnl6TVhObjUxMy9LY0YwVEZiRHlIWWpTNm5rVUhkVFJPZnJndmh0VGxp?=
 =?utf-8?B?UGl4WTZKV21rZWEwaWFheU9Hd0dvd3Y5VTBsQ01xYzE3TU4zUlhNcTdxa2lP?=
 =?utf-8?B?eHFvN3c5MUVuVHEzZGFSb1U4WVgwQWtHeEZtOHdNTVllV3krZmgzSTI3MkFC?=
 =?utf-8?B?dDQySGwwT2lxWGxlRGpMOVJVZTd3QjBUUkROT2tDbFM2d3I0M3VHbDRkY0c3?=
 =?utf-8?B?TWFXckVZRXovSVpFcUpXN3BoVThmOU5CTHd1VmUzaHhJYUpNbFBPcFdiZ1ZO?=
 =?utf-8?B?ZFk0elZndXZ4NGVZc0kwdVdwZlZLcFRkSVUxMXI5ZWQ5Q1Y1ZXczL21kWHV5?=
 =?utf-8?B?bnpFaHRxV2RONld1VjNFUmNaZU1TUUhhUzlIMHpibGFEemxvS0lkeDV1QkY4?=
 =?utf-8?B?VW92MGdkL20zdktJS2N6T29IQUdYV2Myd2MxR1pzaGhJU0lncVZYemhOWmwr?=
 =?utf-8?B?c2Qrd1Q2ZDFERHB6QUJIUDVobEc2TUE5czczNUtnMVRTRDREOUw1YXEwUS96?=
 =?utf-8?B?a1RLS0FWdXZSRElneVlCVjNpd3JuOVp1ZitZOHVlNy9CWW1BK1MyTWFEbjRz?=
 =?utf-8?B?UHoyTGhQN3hHOWwwc0cyclVwLzJsY0swSHNwdWFnTFBFTnY0MlFvZFRqUUE4?=
 =?utf-8?B?SG9qN3kvVmNmYjRwNjdyRFcvYi9NVzlFQTRhTHlQTUszUkVnb2R3allYZU42?=
 =?utf-8?B?cHBLZHloREM4VVMvbkxIRGxzM1JRZ0NOczVkWlJ5SHpCVGxVeXk3eDhkajB6?=
 =?utf-8?B?bEVtSjV6aiszMWxSQzBqeVlOTHVuT1JUUEZBbFVDNkNHOWpSSGEvZlVqaDJz?=
 =?utf-8?B?ZS9LYjJBZXZST08vYVBYdUZ4NVYybElsQlYrOTl1aDdWdFpwN05KbXRrUkh0?=
 =?utf-8?B?MXV6NDFKdDhWazRnb3p5OTliWGdZZ3oya1d0N0Z2YXVaV1ZucEVJNzU0RzZS?=
 =?utf-8?B?R3ViZVVSb21XSUJ6WGR6a3dyeWl0YjIzb0lYajhKUS9DK3paUCtVdmY2WG1Q?=
 =?utf-8?B?eTd4SzRLY0FvQVhYbE9jUzZzZ3VVb0FWTm9aMEI5K3pPUlJSdFhhZ3pDYnZ3?=
 =?utf-8?B?R3llUjg3RHVsYkVta2xLSkJCSjVYOHU4R1BKL1hmQkNQeWFEV0labGp1Z01K?=
 =?utf-8?B?VmoydVNxRkF5cFVoRU54T21hNDVDWFVnbysxZEdPYUZlNE1RNVBSVjdCTGtZ?=
 =?utf-8?B?QTJYQmxNRjhwOUpSY2xCQ3VFSmNxNlY4K1N0SFJYM2tkazJpU1FpbWNucUN6?=
 =?utf-8?B?czRiSFc5U2p5OU04RDZvVVE5WGVSVGlwSlZQK3JnNWRqYlE3NThncElwY0Vz?=
 =?utf-8?B?bHVMN3hTaGlqYzdZYkUwMUVnU1dub2FaWEMvUUdJRjdFbUdEdTZ5aWJIVTky?=
 =?utf-8?B?Y0RDQjJJSXlBa0FIb0dSSWhOVnVlRUdxai9ZZE1TWEh1QkFJcjFtWVluNVB3?=
 =?utf-8?B?RWhMTi9uamM1ajFtSm9wOFYzTGEvQ01SK2U5ckpJZlJicnptbXhENWtnd0Y2?=
 =?utf-8?B?aVBJSkFabkdjeDJiL1h1cStseTByWlBST2c4czBsN2FqRzhiYU9hOEFPaUhr?=
 =?utf-8?B?c3lnWFVVTFpWS3RDd2xNSEtpcmMrc0w2SDFXV1g2QXZYSk12dEpGODBCUnlG?=
 =?utf-8?B?ZVY0MEtxbFJpZWVYMG1JYnFVeTk3aW5MT0tvOTYwOUtoMFBmdWh0RnZQVEVx?=
 =?utf-8?B?MGZ6OFJpTERBQmMyeFNZTno1VXFqMXc5Mk02V3dOc2RVenYyNVliaEY2akd4?=
 =?utf-8?B?aHZWZ014bGU1TU53ZTJXMk9KMno3Ym8yTXZjSFpObklrY082STYydk9OMjlF?=
 =?utf-8?B?cmg0aHhMOXBmM0JVMVhucVRmT0tLLzhXVlR1dXdRc2JZQzB4L3pBUmhTY0F5?=
 =?utf-8?Q?JtVarSYvqOjyTFOezSFZn9hqX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YQLRoPf779rleDs7M0mbj7ic8zBhsbSCZ0aIgu9Cueu0DxXZWu7VkrJtmj223Oo8zpFQOzw3Ef7Yu7kOessDap0EROsjrFXAJutU3ToztzR5/arI+pCXeXYXEHZWbAMCWjrEUeunendAEZQxiyN1n+loOW4UXoBcuRYqXCp4+X6PuUFadZ3wDEIOQqWjq7O/1L/mUsy+DKRyIQp+gNP+uYbRGKKXZ1k6ZIZt30mLTl3JOEYfiIyAEgbxZW73yaiDusqsssYc8NiCo3ZBGacRxlfwrZY0kzMQAwFe/ljnApjBhIXijJHnkrX42FbiUpYmpRBPpfM39NxYdXbFGmy4sirSVnt75pW89gJI71BAVkzHhNaZjOFvTARoVVCt+LrnYEOScZcAyI3usPNm4Ge8xujs2B3v4uTfswrXTF6sXL+z6oXPfL2nMwfBWSndB6jFHZJeZbVWETtDyCrJdh+mQOqtVyNeEoQ9it4cOUSDJwucc1iNvF5LzOrCg/wK/xCN8qIQYi89hzqezi2mlOT+D+q/FuFKhmCaEd6GOJjxSfemReOtDDHCZE8GBh5PJq2dF/yvy6OUMCnztr32Qk1VME+7zrnZ/BM3hgX6i3nDD9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd18af6c-e2d2-44aa-1fb4-08dc6326cd17
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:49:08.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc1CNNZO+arvQJrno1Z+FU1nysiF3SGRyH5ktPtTxNfJn027juqwQ4twvjkY+dmEgoQKbzC806eoPU9vpGWkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220100
X-Proofpoint-GUID: dgHVhqn2kkWOiJsdqnldCiR7_POoxPoM
X-Proofpoint-ORIG-GUID: dgHVhqn2kkWOiJsdqnldCiR7_POoxPoM

Hello Greg,
Thanks for confirming and I am sorry for the confusion. I was referring to
kABI (Kernel Application binary Interface) which is a set of in-kernel symbols
used by drivers and other modules.
We (Oracle Linux) try to keep it unchanged so that external third party
kernel modules or drivers work without needing recompilation.

I understand now, that there is no such requirements in upstream.

thanks,
imran

On 23/4/2024 9:13 am, Greg KH wrote:

> On Tue, Apr 23, 2024 at 08:32:09AM +1000, imran.f.khan@oracle.com wrote:
>> Could you kindly confirm if a backport that fixes an issue but breaks kernel ABI
>> is allowed in stable tree ?
> There is no such thing as a stable in-kernel api, so I don't understand
> what you are asking here, sorry.
>
> The only api that we ever care about is the user/kernel api, that can
> not break.
>
> thanks,
>
> greg k-h

