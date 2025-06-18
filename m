Return-Path: <stable+bounces-154638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9602ADE3FF
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322D317B24E
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841F21576E;
	Wed, 18 Jun 2025 06:52:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF9212D97
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229525; cv=fail; b=Daylcq/T8cXKmgOV6TfDcG3WVNzfg3B7SdCsah4IdS/ivvNBpN3l2GJI/t8Iha2SQ6t0D2fa8C2oxzfeAFMFKxMrlVBPSwSgINjk7khtyS+asO2DWOT7ULGBcm6g6nihpeppIvNnHN0Shgo6ueuNDwvhNXQlUCM4F+M3hg6YxI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229525; c=relaxed/simple;
	bh=nJiqquR24x37HVE77RQaXnek33jnwLdMhXDMcumGBrI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sqa2GZZxfnntAOuuu//k5leSJu22u768PlqfrogpOPsGVtwViIacLtr1vxty6wkR9bhhuQBmpvoehXM/Som7khVHOJp7oz6IhgskQmaPBqpUfhEC4SruEwAaZKv642yItkuI53pbz896UDrWQZpUsTDG29LDiq7Oq29IH0ZrCFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I6lwR6021176;
	Wed, 18 Jun 2025 06:51:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 478xa1m8gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:51:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs+FWlSynE741A31kJtROE1rsZF8A52zMEnpX4xigM63f8QSdltR74D/mIBEZLNDGq2/RZzzp9frsPH36obC+JoehtCb/XgCLOa7xrniaT6uCHJhrijdbAOa7b6APz0n3wYuvh+MGSp9WnAquflNn6fZE1hbJRTfvwMhH4Z2CXrzISUXa1SjZvsUEu/7XGPCUH265cCJ96YzKf0M/KQt7xlV9XHmoF11uljG8u3EFxPo8ZcVOwDpa+06yKvsjAeb2bZMhYFWeOiwbPeC1uHY3koeEgsrxeHniZ1b+0MOEY5ksLk1TGcpuijIbzfXqWwWDe8JluH9OLWMeVSMdFpAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm1V/XL0G9LHmDvTKS8WLGeHjvB/Ht3yaAfrdW2cXec=;
 b=vNRYXL5NctempAcV5R4xnQijLy8RArJ4rNO9KvdXLtTYn6O3w0fnDEVzjcOgVx8JteJ6maq2FVMDfP+TasVLJSrSAxIRDS7sxUkTkko7odpYLXf2NQStZDaHOnLk1CspqPDXtAbIwa4gFA/X3FKVZYjNRk0pmMaYIf/i2P41V+hDKWfzRHirfagTJUPS9h3UC07yZ79Nr2G1QZJw71z8doLqLifGgbgkJmfj+nr6mSMxW8FM+7O0+H2ZfD670ZV/Tystd0q/0gf7aqxhJKFNFCeVu4Y8KaPsViyvQk3/w7zW/gRVHo4hYAr9lk2CiR4kQGdgPUZ/y47ofkDDP4nAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by DM4PR11MB8203.namprd11.prod.outlook.com
 (2603:10b6:8:187::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 18 Jun
 2025 06:51:44 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::eddf:de3:fd0e:9a36]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::eddf:de3:fd0e:9a36%8]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 06:51:45 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: ipylypiv@google.com, tadamsjr@google.com, jinpu.wang@ionos.com,
        martin.petersen@oracle.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 6.1.y] scsi: pm80xx: Set phy->enable_completion only when we wait for it
Date: Wed, 18 Jun 2025 14:51:33 +0800
Message-Id: <20250618065133.3756860-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.35.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::16) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: c84ebdcc-714f-4ec5-a4b6-08ddae3496c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G45KzyxsBGnPFgrV6qCBRrwIXcsJ2T06euG3HIhR0ebPos3qnR0h3uJdxIOY?=
 =?us-ascii?Q?agoGoZXXqqCFMHk6wwUf6HichV80zyt1PL/00bHngDxNXkzvieBvPYYfWeZP?=
 =?us-ascii?Q?3wHl/RHGXJr6pUHEdojiYBlXIDHXmyULizPh7cnQBD968vrRc+eYXa2IGnev?=
 =?us-ascii?Q?f02ZfBROs4jmgnErrpPsy0t/Rku26du50EA/egv5LNFrr04FndxhoX31CL6B?=
 =?us-ascii?Q?1lk0KhKn3/L0CvOgOKO3Zuid9MqXc5pP2c+2WM+KJm7oFa85NZUuR/LfKsZo?=
 =?us-ascii?Q?YqZV35vJo/CD4qKk7ZsWP8uL4u21eEjJpQoZHwV2BYVi5vc402SIgV5AmGWb?=
 =?us-ascii?Q?HJTrVaTxedwj32QqOqqEpssT0ll7Tcsux94m4aCjtSJ1dXgnua0kdPsojADu?=
 =?us-ascii?Q?9d3uhvDGt9WRVUajiSDPOK4zDySyqdEJAdL01qEgxEUzmCqwmcsBMXl+acOo?=
 =?us-ascii?Q?sWy/yMfSCg+z5AA8irJZqLBKYOEWFowZ6yp6I7XLkIMqGBBvXkib8Olms9Zz?=
 =?us-ascii?Q?CDhU1QG0zcjRZQsdaSaJd/K0v8qFw0MnAiZ14uNrAYrAZLjilbpZlRz84Baw?=
 =?us-ascii?Q?lghwDlvvx2vxXiZG6nAnqNe1Z63pCTuVfx+w50Q7tJPFoVGdeh0q3i+rK+MD?=
 =?us-ascii?Q?Pcro7dLmLkwVEUOvOFkk45oWl6skKe7LbACF00WOC8FSw9Y54pJ+5h/2IrAB?=
 =?us-ascii?Q?YDOkLywlg7MRSP3KZaE5m8PMO7+xWDmhR/fTS/24hs2e5khcaaeAm4+19AIq?=
 =?us-ascii?Q?EctxpMXtSxOcFAz6/AnQfex7xnI10hwqrMx9Nz8LNOvDa87Np15oCMoc1jDg?=
 =?us-ascii?Q?9oxf02+EO2crg18WKzLpfA7MDG41O7v6KfNzkOeMlVzzGQHgn445mZE2Q7rY?=
 =?us-ascii?Q?lkv7WKlmJ5TkzO6jH0MG+1CjULAlkhyh2b71Rgwj0Ss2hUfqvprIplYvl9HI?=
 =?us-ascii?Q?y1KzQ/1SGJ7VP9pJ0achfVu9Pgrj6JZ6Jie+Hk9ThIR0D1WZ2FUwe/OOi1Ff?=
 =?us-ascii?Q?XYA5wzI+klmJJxVjQslcRtoLHzGmzLVrB3jYKbfVkMtzAsmrk8mVwlvbSzQa?=
 =?us-ascii?Q?bvKM/46CAWFd0K1l6O720j/yF90myXAoFq+PIXEUPJ5Ja3yrcz0SQJVkK/5K?=
 =?us-ascii?Q?bZxtLht3x28C4RtpFNfSOsc3w1e0XZXVUiWkcc5GBuvcjlxvxR69ws8zQEr2?=
 =?us-ascii?Q?4PusYsn0pQqHiNsKp/ss35KQRuT9Ve94zFbKq9U7lKbBZzxeltnK3pU/9gFb?=
 =?us-ascii?Q?4szrAyqqBpCz+Ej5b85iTFBbeBJRmOUGzlI+pNLDFJZBHZVK4z6bXnr96YhY?=
 =?us-ascii?Q?nVlfmqTTyprOA4sRcmPyTupNnyd78xzj3Fu3raSKPE/cQ1jYmlZ91J6zZfeM?=
 =?us-ascii?Q?k+CuUUUuuZsMM8h7aeIxVMvNB9CnuNFFPFpT903eo+AZTeYiZ2mVc6rno6yO?=
 =?us-ascii?Q?iIW8+EE7rO63EV3gjNs730N39nGCLShb90RflVUbY/TjATtagMumFrQYqHJC?=
 =?us-ascii?Q?fuKClduz3/o6ans=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLdw+f7q6nQSYzHxYXLfqIXA5W+ManupV0quYPQE9/ZPIxIRoDhcrHXWLrsB?=
 =?us-ascii?Q?c9SatvwVEetqTSZRo7T7yJrNe/HuTHtLL8/79UownazcCG5dh5nN6rAK6fVH?=
 =?us-ascii?Q?tMKeaveWUjPXwu32iHtr3KdLy7Lm3Jk7db9iY9A+d6QTU9C3A0dqcdq6dYN0?=
 =?us-ascii?Q?Y41rlBSNKmYrdEWs00PcqjWhuytj92nlt4WzLRiqtSjgafKEwGqRLe7A2vJ5?=
 =?us-ascii?Q?8Jou3DzNRveZNOQPh8BpJBe+x1z2G9fPt1eAOhyOqwujqJkbhaHqahnIuZov?=
 =?us-ascii?Q?3HvO93bJxcLqvfzO2cNFlBN3PK/ls+bSbnb7Jf8OJdDJ/h1bEr7KzzyoNwOV?=
 =?us-ascii?Q?SGbZcxzI64ULufX8DI/aM7vR13/SEXLCgZEVPEN1SROV7OXckheMkKNeJ5vo?=
 =?us-ascii?Q?126MmyPr5QVru+dxEIJPEPHn88SzrUGu6M+TFVaZ3EWBalgvWOAHvXyJUv6+?=
 =?us-ascii?Q?+j90vICcV+qWdLwiDLNzr+BzMwp3ibi29GStW0ZMg/9lOgZiKYLEeMh6lkNn?=
 =?us-ascii?Q?tiEtSwubbQLWEEyUDGeAVCv2QmyYfZl2YLXk1F4PmXo6D9/5nZodvsUhav/X?=
 =?us-ascii?Q?Twc232CJRnRelmn57jy1Zs0V3lIvEti8SD3vNR+WPgIE+L1S8ASlejUvg4IC?=
 =?us-ascii?Q?bQgcgmuQ1BGxPq6tzoBszSUoGR721vQrLf9pnVd72dpT8XPl+U9F2rWsP9Bi?=
 =?us-ascii?Q?gtUwOkm7CP97rhkXMt1iA3TYJ7H4eKXprcb1JLnFeYqUYbFSP6QUWuadT9kN?=
 =?us-ascii?Q?1TDEGjJat0mB/ILZEG4zwGAbjXd+0nfOA4y94vcJpMeYPNI+OLS5J5qC1HtQ?=
 =?us-ascii?Q?etixa0nOUtOZgIbk6UeRdZgrr8o/6JU8DwXvtXCnHxVEhhsKtK/+UWlRw8uQ?=
 =?us-ascii?Q?lM3rsd5TeZDQvhq0/UnajfsRt9qVyOa8uUopZTd1QgvJvV2ZbiL+qwwMyIIs?=
 =?us-ascii?Q?SG6inci3oRy9zkoj7PAXMIqXHQkBPq/aABZyRPqLhgdoGq7fP5sPGKAZbpib?=
 =?us-ascii?Q?6bP++m2KXcNkLp577TlmG6A5ecKppP+CfHXLaUWLYgeSoohc8gOSpnoMRJ6Q?=
 =?us-ascii?Q?dyZtzjvt88mOP+s3myj5rrgMehhnWlxpiaH0OpF0TisR4kWWIqE2Gt1bKTJn?=
 =?us-ascii?Q?VEB3T1VbRctJ+HXwMx2lkaJafxikAiyZcQQPspaivoM97NQnVKWA+GrKuWpq?=
 =?us-ascii?Q?ArClTpMQgKCmVSMKHBBkW6xQuAaVUD82z+wcKomE051j+WPT0I14hp8hOPmZ?=
 =?us-ascii?Q?FM2WRYkvmN5/kaRhGCn/gH1BSXTrc9PxbvOE15b4Qje9byru1umwfLzlUIk0?=
 =?us-ascii?Q?5XUmxYpvHzw5rPO1tOvt0P6jXOyLREahoNi6kNn6idV07nVD7HIVpsSo/0tm?=
 =?us-ascii?Q?5Dimwd1/XfyriCbjxdccCpC4x1slT/HT8AT523EL5tb4+3I+GQKKrnNOg1Bs?=
 =?us-ascii?Q?wm55qfy/q7A7PrBuDaCuBlbFDBxDHr3Tz/jvp/W59/IWKnLRSvX/oQzlAk3I?=
 =?us-ascii?Q?SzaZf+y4ErTaH07QIY7rPkFa4TZ4XkUrulQECPndNrPh272ZZkYLTaQpTNW9?=
 =?us-ascii?Q?Y2V2+OrC8dIWM2vgKoRl03sP6XEx1EamdXB2p83EkB0zsZKwaqHazCzLU9fE?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84ebdcc-714f-4ec5-a4b6-08ddae3496c3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 06:51:44.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy7XIOeFNeyImUhc1vVF/Ca31mlr1oaxTexkenz90/il4k0tyIz5n2tQl7nv2hsfZjFLCjDNqqQ+DQ54hhM/tQ/RCUWF7GCUYk+YQQUTLB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-Authority-Analysis: v=2.4 cv=PuiTbxM3 c=1 sm=1 tr=0 ts=68526203 cx=c_pps a=oQ4nnv97Sq73DcBK0zarQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=UgJECxHJAAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=3UlDCcIxoiahvXo4ZDgA:9 a=-El7cUbtino8hM1DCn8D:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: h-PJA2CnCXN4jlstxGolopvyK45DVVAY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1OCBTYWx0ZWRfX4aoKvSdnIVRX lFnZOs7UYdbmxjYDU37vK4p561KCECiL/Hv/EB1VoYj/WNyGyM/LKeIxe3dZecm3DXBPbFQG+B/ pykZ2i5AUKYjCutUOJy3XdjA1BVSyTUuIPxkb/yfzwJ23qr1clnHEz6NX6rUqHHkCHnuMxb7pVx
 wX6+IR45FI4Yd2c87ywBTfNfkQQLBT398/ODblL5jnvkbHesm+wPJRKDARp5Hsr+i5F1s59WDAC cCngQ3D01FO7D2ulXx+hc2yT/pwGjImdse9iYwTAG/8KxSHQ2AQCxjnBwGR+DYHyr72TmxKyyBh W6MXHDmYlNPFmS+ZRtDWTdSaeJY+N/WY9nikyDA0nXMxW9VCdMmHHCk53mFbQ8JIvx42ypt6tWS
 ggeG9jZ26gS72L+Gfk5ZVOMubNFBUrcKaSY2cXCVWztGtHkIcPz3st1QocyrfOlmp0uSMV/5
X-Proofpoint-GUID: h-PJA2CnCXN4jlstxGolopvyK45DVVAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506180058

From: Igor Pylypiv <ipylypiv@google.com>

[ Upstream commit e4f949ef1516c0d74745ee54a0f4882c1f6c7aea ]

pm8001_phy_control() populates the enable_completion pointer with a stack
address, sends a PHY_LINK_RESET / PHY_HARD_RESET, waits 300 ms, and
returns. The problem arises when a phy control response comes late.  After
300 ms the pm8001_phy_control() function returns and the passed
enable_completion stack address is no longer valid. Late phy control
response invokes complete() on a dangling enable_completion pointer which
leads to a kernel crash.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Terrence Adams <tadamsjr@google.com>
Link: https://lore.kernel.org/r/20240627155924.2361370-2-tadamsjr@google.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Test info:
Building OS: Ubuntu 22.04.5
GCC: gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
Base Tree: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
Builds:
make defconfig; make bzImage
make allyesconfig; make bzImage
make allmodconfig; make bzImage
Boot target: Intel Basking Ridge
---
 drivers/scsi/pm8001/pm8001_sas.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index a87c3d7e3e5c..f491edf73e23 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -168,7 +168,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 	unsigned long flags;
 	pm8001_ha = sas_phy->ha->lldd_ha;
 	phy = &pm8001_ha->phy[phy_id];
-	pm8001_ha->phy[phy_id].enable_completion = &completion;
+
 	switch (func) {
 	case PHY_FUNC_SET_LINK_RATE:
 		rates = funcdata;
@@ -181,6 +181,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 				rates->maximum_linkrate;
 		}
 		if (pm8001_ha->phy[phy_id].phy_state ==  PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
@@ -189,6 +190,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 		break;
 	case PHY_FUNC_HARD_RESET:
 		if (pm8001_ha->phy[phy_id].phy_state == PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
@@ -197,6 +199,7 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 		break;
 	case PHY_FUNC_LINK_RESET:
 		if (pm8001_ha->phy[phy_id].phy_state == PHY_LINK_DISABLE) {
+			pm8001_ha->phy[phy_id].enable_completion = &completion;
 			PM8001_CHIP_DISP->phy_start_req(pm8001_ha, phy_id);
 			wait_for_completion(&completion);
 		}
-- 
2.34.1


