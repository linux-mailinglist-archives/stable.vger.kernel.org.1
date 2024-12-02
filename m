Return-Path: <stable+bounces-95988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A450A9DFFD8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229FBB28017
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99411FDE1C;
	Mon,  2 Dec 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FhAvR3JX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oFlIv+Kn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0F1FDE0B;
	Mon,  2 Dec 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137853; cv=fail; b=GtXIv6ehh/onfgKbgpCoYQ39FyyO4qsyYAoQXBmwKi1aFHg5Z1kQLvn9poQphMWtMpQPuiGAL+N5A13pnRJ7z9lKvAl6xZYZZTlSwhYvwoANIQdEO9j4rv/0zKw7krzJ70yV86wJuEHBoLxi/2UzkCk2bxojRmwkBUOT75s5ONc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137853; c=relaxed/simple;
	bh=5JoRbla2bp5Qno92u/seV3kNOPx3VgM2RohSLCJUBfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gySWCFPnxM/DDm1kkysp7GqJdqQdr7H/wChBTe39DioKPLFfx6xhWleb3H+nbqaG/edlXro2SP7MhTQ/ZcwvCdiaWY+jfYSmPmG0Ujq8B0zlJA+vgzz/yxqJM72hmHgGVgjx/RLXWUHSP+hWZ4RWMQkEqWvMGZ6cMzSS0o0VC8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FhAvR3JX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oFlIv+Kn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26Ww19008600;
	Mon, 2 Dec 2024 11:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=I+w2hwxa/YUTZZUnekajsBhLkqgjc8gxVVx749WCQws=; b=
	FhAvR3JXLAIhn2RMv2fysc0zPEJ5E379/GqqJHfRSb9TQk90hXNYgdsuDO/gw8P5
	UsG5kMN3ex8dDgaNqSpFU8My5tmShDDSDrQs7guvEXN/31lV6tmBvkGVOLJKDevI
	CkRKVm6JPQBFBpOEDdmDTuIRdW+cmqHpsjz0rnusI3ofIck+dBDjRRJGcv3bXx2P
	iUAWTEQljq4Lpn/34YUqJfvw3F2mtoYn4pnLJcc5skvTJfUUBNYr6YXzpe304E1s
	Ls7ty+O38osiomlZGTG4TrtZbhnAssZjz9Ts3GyLXZZmhcuRFcZGyB0uS5MAfH7F
	7qFHcvjl+WlJE+1CdHec7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9ytkmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:10:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B295XnU037342;
	Mon, 2 Dec 2024 11:10:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s56r6gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g50qJXi0HVVpBlmhHek/qO9uhBZTaPkD5heKPK/pnD8O3G/B+ZgL0esMaj8nZso+fWXs0h6FEg0J761c+AqfiD1AXqv6tXhkv9F6jIa8NpMW1WDFZgjFNUi8GE4fJn8nsJLMQcTouaZjhfcwTGnH4CW9wSs+TDELc4rxYKZJDIdiA8wCLcbG/u0gd3LOHglGHeaTEJZMdGfvS0p+5q4P25ILNgG5h5Z0Iqbc3KiBrE5VfZvwOKqBVFkEFlLtBYIIT5hyTMsIblr4oLDWYfRZrxhny/Ox//HjF1n55Fjf74gPSIP8/PkEaCxFvSgtrMV4mu+HMGZIoa5zlnC6CecFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+w2hwxa/YUTZZUnekajsBhLkqgjc8gxVVx749WCQws=;
 b=liMB9gshSURc1lSutt85mfLm6FNVGG96cLv62nmw+VLa7oGzbVYdM+NDjs3Tnk3XvCmlCCyyqGaTeiqVhrd2qR2o7gZx2F8t5ACq5vZXsCj+CtM0EYbfC3usU3iu/ybQTV/xe7THQyhIlJHI5ZpwiGvIExeCn5FkKYMAa49fQ29WwQgdyXVDQ6WzmVN1+uoqTzS6NPLbMJsDoBNxNPIJ74LAR+YImIWSgWmvxKmGAcD1rUdj0JpYZRaBG9sXuEbSrVAC815GU0GtEQxfaEYCd4i0ujN/L3W5m5/oZ2CkqjPhqCWoG6fr5xRo/46Lzzpq+HjmlshxiYNy/r6fXLd/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+w2hwxa/YUTZZUnekajsBhLkqgjc8gxVVx749WCQws=;
 b=oFlIv+KnysxgMz3/ai9Q0xPHU6BRMovjvOzWC63XaXVWLn4qwF6qjL3fgSBZp0S5W568ZhIE9lJ04EVSvqImedgA+UkVPmbjb0NudLcWwuC1Q9atTpnHMPjed/KWtvtl4SJ01UDhIxeLSjDXaYGVCNgeu4QP/4qJ9amxGEHDR88=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 11:10:46 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 11:10:46 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.4.y 1/2] cgroup: Make operations on the cgroup root_list RCU safe
Date: Mon,  2 Dec 2024 16:40:23 +0530
Message-ID: <20241202111024.11212-2-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202111024.11212-1-siddh.raman.pant@oracle.com>
References: <20241202111024.11212-1-siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|MN6PR10MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: b94a2504-ec7e-4dd8-903f-08dd12c1f891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UMfz+PaznXS/1v0FiIXL7EQqrWBUOte8dgPsbf2g4yMCaTeNNJh/7bu7o1ii?=
 =?us-ascii?Q?gZrlMuzvO5r4pjUNd19yQ+y/55W6zWuaJdOrO/BYQst44kbz6owa4+gaAOYt?=
 =?us-ascii?Q?a7iQ19vwR05BWQHhAjdCYjJoZea5bHiuqD41JuNBb8u6HV5D5QDCp1baZuXn?=
 =?us-ascii?Q?gULrfRrxUFxPcEQqH2gLA7WcLQ0qtNmdCGBnyjBSTYlPuH2+RjvxfXKmulm6?=
 =?us-ascii?Q?rxL6yFPSDLtCeQACD9Z8KL7O6ppteKdDUCHyki+z7GCRbINSybJBKGfXTxaG?=
 =?us-ascii?Q?ouP02+MopWZvj+OzBMqpL160tuhzdDifAzfdTi5rNHV1N/gBJ/cFAg+Cb+d7?=
 =?us-ascii?Q?90v1wEiZK9RjKF/sDXxSW/d00l3HeUW5gOckR42X+aPSvis0JtwPk6AvuGlc?=
 =?us-ascii?Q?Ue95DDwPd5W5EBVHFv7Fd7iwAx9p9pDxaRRjETlCVRDvf10Chlyqm3m7A16G?=
 =?us-ascii?Q?P58pHJ0PIh1WAjeAW8AOAU9CozYwoDo3Zb4YdBr84wGU6xpp9k6zhi6jqCe4?=
 =?us-ascii?Q?5VQ/VaumZ4DBpdJ3dRSnt4KQZ7Xka3Jp4h4I3NiCuXEA7W0DEfe4IDZlOs0W?=
 =?us-ascii?Q?2mPbri9MYTY9ur98TgudQLl0K18GlVVzTX0Y0FFocMOKX21J7SGw38C5JfEu?=
 =?us-ascii?Q?9B+gpYck1zIpeKeNFeX76q+2TGyGtcm2YDY6Lu5EEZoQjHypqWBtk+1ycqut?=
 =?us-ascii?Q?NNZluqMyAxSPH+wHRNKaIFnEzLDHdOhc0irssnAW+2dI350YPLuKkw5fk99H?=
 =?us-ascii?Q?d1PvyCy8d/pd+mVfMSTzoLB6/BO46+BXLlgqhKOh8mCgnjsLzgNdwAb/1ADd?=
 =?us-ascii?Q?dguBxHP5t08cv26hJxQ64bK2rpiuJYb5oXLY8Tl/QPPe3w5nG+quaNfHLCU+?=
 =?us-ascii?Q?AiqtlLpQmD6ee1jN9+fbWtXnMY/b+XD98tDLF3ZY/+mlRbLFVCTyl5DgcYZM?=
 =?us-ascii?Q?NJ6ySS+Qp/y/qpwNo6l/bZ0Hjg3ExO445qkFlIaSzJ6B9JpoXpQVN351iIO+?=
 =?us-ascii?Q?xkg29huZAv3eVcy3n552DtK5Sj81yNcUmeLbNDsrVV32UnMVDoLgxeIPoHPG?=
 =?us-ascii?Q?gfhtsDBO/+0vU6QHDipEdLk682eM85LvxdoqTzG0tTjLZsTp5g6hEZW1NMMy?=
 =?us-ascii?Q?bR210p9/DFS3htj/8zsHxrab0UwPmAinDaZQFfh+rXkmSX8dibS/0mXl7Cj5?=
 =?us-ascii?Q?57/y9wq0Qr4aQscOVrxtjT5tsdBj2mRPN5Z/O48P8r+pgrSLPYgkhUWLbGal?=
 =?us-ascii?Q?8I2Uctim7dtBfk/w1Zl1hvGSjufnSU6NHSZZztN6RvjrBxiHB7zNwq5ZwU7F?=
 =?us-ascii?Q?qF6MZs2GKwTfOmYdT8FUqE9B9Jc48eOcqGskkHVA9DWNCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XLhCX2wHjmeVcEBxqZ7wGAdXxCnJ2r5ZAuwk0HkBeJ87o5iB8Bf2HLoNxF+t?=
 =?us-ascii?Q?/d7AssX2AectBrBZ0xN2RMebJt/81iy2JWjshl++r+dFlqy/ouOd4xFNQI1M?=
 =?us-ascii?Q?OXyuR2JyjhhaATs/+ukDoRGHhqSqWIyHh4WqYuUUnUsZiDi11m0HueZ0qiPd?=
 =?us-ascii?Q?xktz+RqZY3Jc4xuvzGJrUq0X2CI74QVxkVvK7Odiflc4JCBO8Wy6EShfssYH?=
 =?us-ascii?Q?hfkGvJFl+G2zzidqSHkcP4r9g1Ed2PTA6QIOR8JPKsrFhXFrjLEAMyoZ+p2B?=
 =?us-ascii?Q?P+UR3PnbIfb6Ga+9dCuE4o2+10N3qGspd7sCICWYUzHhUn5mLyyOP87HwZjT?=
 =?us-ascii?Q?SKiYjP09k0PVil3CIxW8dInMWSj7bvf17kWXNPYSwnvyYxTLj6FvO+fERnUT?=
 =?us-ascii?Q?hq5nKZEhIeijP7F7ejyfoggq+d/3mEah9tsvn6GESP0OS3dmQTlkSZ/PM4fK?=
 =?us-ascii?Q?gymkRbh+Sj8uGPvUaTayNYuxarZ1wAUP9eIjB8vFN35F1ASwswhNtAssq1HJ?=
 =?us-ascii?Q?9bxvUX9uIIm0xHmqfOQNNfCVADbkjF2Afxti8YWGFdOBmN84udGmBFic0ls/?=
 =?us-ascii?Q?2hwqVHPyNqWNGnj7rziiz78gA5zOzTbNqoMFfWfuqg7KXFxRMKuUoPpXEWnR?=
 =?us-ascii?Q?FHggLKFnWDymzeRt7SI9kcbxFFssBnLpulfbPtPuHo/6dkGJgoKFBWMcO4k1?=
 =?us-ascii?Q?e1WaTE41QdJFX57mW4iYXIoKXJiB9RrbJQR3cVf+6YLTepa3vdJZQD4YpFdc?=
 =?us-ascii?Q?Rhb3/RAxXrJeWc/FiWhhJ28tUY6L0nXH2C3crPvtWh3sB2kIX6Rx9nMgIp26?=
 =?us-ascii?Q?HfANxVg1CqsBX7O0zTjE5YAtwSCxfELjvldvhi65PkANws46sNZqkTpgqJBR?=
 =?us-ascii?Q?kauPpK2hG/VvtV10tjytjBE1t9oNWzFlRFLeUlhXd3+np9LCL9NeK0ObhVeO?=
 =?us-ascii?Q?b9edELhYEEN7XIU2IX54FtiJjlzFpPaAFfG3bNyK3RL4ipZ611LapuF4Tf8c?=
 =?us-ascii?Q?f4zEkHUD0Qk73EthBA+SKIPMEdtor854dq9A2AYwrziDr2fA2GkxlP1yc9nb?=
 =?us-ascii?Q?AzdRu1jvR5QP9SB3nn7QRx+SIoyGG6Y0sVvSJS/tj4e1QhE0te2serpAdQO0?=
 =?us-ascii?Q?VVZ1WgwS+/90xJKz8fJ7zF+nbTGiVVMpBQ9cj5xfU+J17cOuxzr/G5NUWAbB?=
 =?us-ascii?Q?7Ya7FFKXayX2FOYOW6NDyfcTmyteVt5CCiUVPawYDaqz9DX3ocO55meiUoAE?=
 =?us-ascii?Q?PD9ws+7ceCvjg3CuzaQ99YBphvOYCKm5VPmoQpSl4uy2L85SERdWAxf6bPhE?=
 =?us-ascii?Q?1C5ndxbFxM4/N5Ki5sil/TJhjD3yqA/2JS4BXgN2gNTCJWJlqHS6DqqpB9UU?=
 =?us-ascii?Q?oUfjFcwhJiK9jlOGzVtagdKC6CZzAVjwf6fCfijLmgf8CRA43FdcnTIBQm+O?=
 =?us-ascii?Q?gLuad1hVud2D6zuWnaP9fcIdZlXoVxmDz0hgr9SolxpvF1qzHERE1T/c7vXJ?=
 =?us-ascii?Q?9I5w9C0XZZbalV6N5dY9h5VDcIZ4SqHDtbzMNrJLmjAzM6nZzvWOmOe7aW4C?=
 =?us-ascii?Q?shQtcWideA7v7Fz6PEAoW7Lc4RvtfaYpTVginCpUqWxVPKEskEmorp8i+NKi?=
 =?us-ascii?Q?Vh6Rl1dEVCuwP/XxAbIdvv8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gNEomC+17M329ufySmIS5bO++n5QHxvg0rSd2zyhc6uOhQ3Bn5MZFzBHydHBmTdbxXrj5FOBCCJjmNZN029IH9Ftut+ecxd0vArwEg4ToioVmMh5ibSsbHsw+HTKmnDVKlluxXZhXOOcEH1qPLJKi9Pwd/ocJWrHQDR/AxE4+4RIbSMEBBGtO16k/+Uheip7i+NSRSgqunNYf5N7+GDRh2v/jgeFyyrBKOKhUjdO3AJAYyyIFz8il40iSpB4qF6EUy5tDr9aP9n7D6k9aui3XPmyrwYNIEo59Yefgz8cCxKdLKWk2sLR8XU3F+wmL87rDzidRHBFiYMTOPkG7qqSSNvo1UAkkGcJugUt37F/Gm2+tcUoRuxzQscZExW6+UuK4qAkiHtlKYZLvUuon70541qZIGdeRgUreQKzsDvTn2LWlaXGpqvK1rjQWQtelhfYV3v3t8mLjhjUOZaFm3Fw/ieMBX9jZeyEERoxHzs86ueFG60JdCqtDTOgW4EarEYaMXDWPoBv2oILTQJxwSrZG1EtvnYv8DyiszFor5LTcaDfbqtSTEQpcvTr7HRyKbOnx7j60Eo+httyNYPm9WWooDPQHy43ZEG6HItWkNtJIsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94a2504-ec7e-4dd8-903f-08dd12c1f891
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:10:46.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paA+E1tBH7VAgfV7uYUIunq/eNfe11ffBDoSgACJ293syj5ZtZsB8E54x07RI/dzDjSk178kLa0Zc/9jBu7Fk1UEVeyTtEPrNXRlxbIiJ00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020098
X-Proofpoint-GUID: CptGlyKRP9y0yuJ1D7UBNY4Psj0-HCXU
X-Proofpoint-ORIG-GUID: CptGlyKRP9y0yuJ1D7UBNY4Psj0-HCXU

From: Yafang Shao <laoar.shao@gmail.com>

commit d23b5c577715892c87533b13923306acc6243f93 upstream.

At present, when we perform operations on the cgroup root_list, we must
hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
we can make operations on this list RCU-safe, eliminating the need to hold
the cgroup_mutex during traversal. Modifications to the list only occur in
the cgroup root setup and destroy paths, which should be infrequent in a
production environment. In contrast, traversal may occur frequently.
Therefore, making it RCU-safe would be beneficial.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
 ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
 codes")]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup.c          | 23 ++++++++++++++++-------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index d15884957e7f..c64f11674850 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -517,6 +517,7 @@ struct cgroup_root {
 
 	/* A list running through the active hierarchies */
 	struct list_head root_list;
+	struct rcu_head rcu;
 
 	/* Hierarchy-specific flags */
 	unsigned int flags;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 803989eae99e..bb85acc1114e 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -172,7 +172,8 @@ extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
+				lockdep_is_held(&cgroup_mutex))
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 79e57b6df731..273a8a42cb72 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1314,7 +1314,7 @@ void cgroup_free_root(struct cgroup_root *root)
 {
 	if (root) {
 		idr_destroy(&root->cgroup_idr);
-		kfree(root);
+		kfree_rcu(root, rcu);
 	}
 }
 
@@ -1348,7 +1348,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
+		list_del_rcu(&root->root_list);
 		cgroup_root_count--;
 	}
 
@@ -1401,7 +1401,6 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 {
 	struct cgroup *res = NULL;
 
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	if (cset == &init_css_set) {
@@ -1421,13 +1420,23 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
-	BUG_ON(!res);
+	/*
+	 * If cgroup_mutex is not held, the cgrp_cset_link will be freed
+	 * before we remove the cgroup root from the root_list. Consequently,
+	 * when accessing a cgroup root, the cset_link may have already been
+	 * freed, resulting in a NULL res_cgroup. However, by holding the
+	 * cgroup_mutex, we ensure that res_cgroup can't be NULL.
+	 * If we don't hold cgroup_mutex in the caller, we must do the NULL
+	 * check.
+	 */
 	return res;
 }
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held to prevent task's groups from being modified.
+ * Must be called with either cgroup_mutex or rcu read lock to prevent the
+ * cgroup root from being destroyed.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -2012,7 +2021,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
 
-	INIT_LIST_HEAD(&root->root_list);
+	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
@@ -2094,7 +2103,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
-- 
2.45.2


