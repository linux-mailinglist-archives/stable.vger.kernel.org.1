Return-Path: <stable+bounces-67498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE39507F8
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BA0285991
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400B19D886;
	Tue, 13 Aug 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rs+Wq4Tt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o4ctiHjM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED5125AC;
	Tue, 13 Aug 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559984; cv=fail; b=bxnYUaLpW/9xkIfUHGUA6F8meN8qhNI6jNs+568xiVkueDQ++27jPMSWdsrtf6iNNeh3cAHi/QwvOtEcAPM25bp4zeOrTfrAzZrUOqEOIeWLc1VvPc8ljyIn/0YormVSTTVJ22Q5P9jHYmhTFCEXv8eQPnFzSYUwAgGoovv/PN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559984; c=relaxed/simple;
	bh=ZpxfUoXHiDLEL42LOT8Bc5X/XsMPU8gG+EqqbcFEnmY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=QJpwd04n76y3V4/QJzoN2dfTZaiRLOodTgywLqQ7qIZ1az2oVZibGtUqSthXA87u5/EQoVO2wqjzoGCI3TqDhkN/9e9MllNC4wluX/s1YnNDEbZVRJrUGy3zR3ags8e2NmbfaqT/ocosaf5Jul6GUk8uZAoF/WiUZFrkeczHNM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rs+Wq4Tt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o4ctiHjM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D7tp9B016693;
	Tue, 13 Aug 2024 14:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=Nikwf5nNsjlOFE
	2uZuqhJ/IEYBa4DcArlL+4RYvLNLw=; b=Rs+Wq4TtoVDXd8m9wM6ZNVsvwG9fQP
	NVgrDurKwqgOnN4sdLrwz2ZFtqPnYjWE+EmgLhaGoAsP5ETk4DrazgBYrdWNBJVC
	Z9k8zN0pjwcXp8m4X8pWM3E1d4zpLignCouDeZF0zMvGrjAdG8PPla+vJlrKHSJd
	jZW3z9fDnXbb/TGlAtX4uwbzxY+p3uUWpTDY/EOgqbpPzygnbPBfclNzTENFPVj3
	zFbiTgSPrBz89FEADVam3Pq/h4l3eRMD4VY9ZAurTZneXiIc+tJ1eXudk3oxfUPs
	Zr6/7mz2xenAGd+CHHEYGkdCeCakRt8TiWg/FDR5XYch6zn3G1Cpjvgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy02x66b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:39:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DEbxJY003402;
	Tue, 13 Aug 2024 14:39:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8hxq2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVQ/TA/pT/KP+iNSnSDgKhQSg5SoWS4HcTmM7snOIuxzXZVex2RwxHtfOJitrGQdanpCu4Mkp4SE7XkcaJPSmwWHhO8KYA95AYv0gTXRYY213o3u1c3HYk9jlYem+bt4/n+zn67YekZ+JxVHoOf9qiURrDcujJ2VG+0HBygsOPI0wV2UzutJhtNVeMzF4RkXWJd2/UCazxGUZrdPj9BG8UPGIjIXdbI9Ya3//sIx8kujMS22J9yalbtweA7x5PAbKuWxRO0fOiu7QTcN/j4mOEIidv2UriPHmCvHvdszkVuhuf/P/cOKeT2VJzxy3lTxwPHzf+yIFUrbJpXLJVpQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nikwf5nNsjlOFE2uZuqhJ/IEYBa4DcArlL+4RYvLNLw=;
 b=KlevtEeLmg5nJodmvG1RnMo1JrZuAxMp7jzX2EdBpM/9DV38CNAhtRz5SAQS31+dMt5k4GzWjqa0fCoy8TIbEDCeQ0inHtBadTSRsdHra2WILzeH9a9SOnfdnl/WgyK5nh7N28tutV0klUwWrsO07e8DFtkFAAFHaZg8zuDilqgfpaTqvGbE8Ep4DFHMG6D0Jt6YZtl4bptzM6vnA97l6bje+zv3/nT2nvSjiE0ViOTR0cVhBDeIJLmECT9FawfJ6lXYzcXE0jWS98ees+3YuUO+gPLviR7gBXpGdGiz6g+T4jhwCs/B3AI2QPgp+03JQZJ0incr4wBTD09SEz5SMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nikwf5nNsjlOFE2uZuqhJ/IEYBa4DcArlL+4RYvLNLw=;
 b=o4ctiHjM8glIR76gxw+9nJflAkw833WWfeiWnsGxUVxEMU1qtjeiT2gMKivfvrw0QRTsuqFzPNcmJ9TPK6x+4ZQGL8s4kOUzkdYBXuEflN9O51kV3YyTe+49sxNCM02Y/E+ThFxpDu/KFFWU/ph92PVIAQH1qDcDtBYwBzm2CpY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5579.namprd10.prod.outlook.com (2603:10b6:510:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 14:39:18 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 14:39:18 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Igor Pylypiv
 <ipylypiv@google.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K .
 Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        Stephan Eisvogel <eisvogel@seitics.de>,
        Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Revert "ata: libata-scsi: Honor the D_SENSE bit for
 CK_COND=1 and no error"
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240813131900.1285842-2-cassel@kernel.org> (Niklas Cassel's
	message of "Tue, 13 Aug 2024 15:19:01 +0200")
Organization: Oracle Corporation
Message-ID: <yq1o75wv668.fsf@ca-mkp.ca.oracle.com>
References: <20240813131900.1285842-2-cassel@kernel.org>
Date: Tue, 13 Aug 2024 10:39:16 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a36b5a-7aab-4968-5a13-08dcbba5b675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mM8enVK1A+obS16CqVIgXdWe2EGAOYdvzYx38Ipjs/icviMTs/k9S8v6QIt8?=
 =?us-ascii?Q?6ZBGV5A5MTDzL63dBPOlJu3t5Iy8RiEmGbCPtCtFmTQUEmW5fNrl2dOAXh+B?=
 =?us-ascii?Q?p2TZCnpIIdJ5o4mM0uezA/Pb5wGtOTWIdSwquwLOj9DERWmN0t4kEswYZT3V?=
 =?us-ascii?Q?qsLdhtMDMt16BENuNtfx9dI+zme9bUByjJjP3Z8u8xaxoYJhIGT3DrOQMg2U?=
 =?us-ascii?Q?gnA5RtuR3NVuySX9Igf42/lQpeizFrSgE+TiKKgwkgrhmbbcyNbs1XJkVk7l?=
 =?us-ascii?Q?Ujg1q6WPXQo795W3IdL7QPBNJpM6+Qwvkp3ArgyD6CoXsv17S+hZMadjCxDq?=
 =?us-ascii?Q?qxNA86K61bX6585hvrDUKu5tQLxY7o7dyq/PtdSoIFAk1zDlGlXMLM79kUTf?=
 =?us-ascii?Q?Q3SJoPDSx3yAqtAXLd1niV8P9KJYi49nPJZejBnSsjgXQpvLoCEPn5IyjVDM?=
 =?us-ascii?Q?vR50s6kul62oVF5+2FdStOLThv7mXcPLiM4eFAKmV+ZOTkagH6qEMsIjw8l/?=
 =?us-ascii?Q?o94k3QGIbg+oxDfvlW2UcVtPZTTI3q8u3pv6IwFkBnncEb8vZm91AX/fSkgM?=
 =?us-ascii?Q?iGUPNDLZfYmuTP8ZeQwoPgt68eskFUvYVqxzn7pLNa/b7JHUNa3OXTuJSJ9E?=
 =?us-ascii?Q?W0AOEXFUreCiq5tFcN72C449iAPSa+O/6a8paXCtHFdFMdOXet4fIDZzXEqj?=
 =?us-ascii?Q?xoA2Teb8COUQoSfZhYV2+yTt6TEcoSMZGi+3/pWmycXej3yXZhRd2YRVmSAE?=
 =?us-ascii?Q?OcozsWafl/FZ8MyhRCRYUnjcd+swC+qai/7spGYF+HnsZGEee43Ed75aCt2C?=
 =?us-ascii?Q?kKF0ftJV0KnkNr458UToGSslglDJXOZ282tSLwkgJIb6oK94BiwPblzwEQWA?=
 =?us-ascii?Q?SufH+GEWT7sVFvbfSdA3tukhKrvQJQgJgLIjBYuOdBD6IBSm8obrhANCMHmv?=
 =?us-ascii?Q?3nxjswRD48Ek5Q41ijahezN8VzPFWNzDkzlzEi5FcUMac3jp+VAZUM8eJ/y8?=
 =?us-ascii?Q?krEkAcMdwQSNBTYWFdGCe7n5uHt/OYH0VBEuYncTIRvho63wD5qkoINPudDm?=
 =?us-ascii?Q?fJq5DiVSWsRjw3Wg6wAA4wKHCeQmbAj+VsYVA9ziyC0hjhHISjEfzcUGYRKj?=
 =?us-ascii?Q?pAr0a8y1ZsE9DRIv9WvIpAimJpVq4cWDsHVmR8bGD8BQ6HzkafEJh3+xBVyd?=
 =?us-ascii?Q?uNM5HsHX9iC9/jmG+gYRKLgzYXsFGkwpvB8xTJlGQxWVK+1tBPsBEOHRJ32f?=
 =?us-ascii?Q?p+tg4VVS/6HYXEsJN3xVUWGI2DGURyQjtoURXosxTbJy50Yh3sdq8/xgswgi?=
 =?us-ascii?Q?Ceftu/M6OS/DCDU4uUQH6wMvL4jJAiFT+MaraIKQouoqTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?370T7hHSIrQ4upvt6oyKmbhhjxymtF45LxJ5pKMfLqj5EkKSJowP+DcOtm50?=
 =?us-ascii?Q?L7nnOUG6KdSkpwrmld0ktXcGj+GMNnr3idqyUQEyZEHhPODHmfOt0UtFhQBD?=
 =?us-ascii?Q?teks1VeH0eMzwH9ytBlRTkO6F0RDXA8HL9ZfP0FiyGFTQSY9CBSoLErTQDN3?=
 =?us-ascii?Q?hXFh4+unrfaVX7LueNNpXrODUclgrRwyrNEa7/23mc6ha0xchoy9dyelH1pl?=
 =?us-ascii?Q?0+APm2fNiUlELRvP9dDyYmknXFnoJvS/WVWB3BSka2EnJh1j+foY3dCIWAEL?=
 =?us-ascii?Q?mkEnAx01Denj2tc6CZavicfhJY0v+DZniMa+RrbWsfMVgqPsiAmgrBr+G8AY?=
 =?us-ascii?Q?7w0gzSXAe2nUUCz5y5X38ueLG8qmOOUDy80V7kHwNhgBD43XkEQJU3ieAt/b?=
 =?us-ascii?Q?dplIYoVXCUMf/AbEgX0PIZ1KTQxi1qA1hJY/ygCpcEDd4yDs+VK2JOZDFRQI?=
 =?us-ascii?Q?TSvtGbXmI5n3G5UDKsAvlN9wOAt3h1ew2umXpCYVOqG8wfI9wPv86/urDIaz?=
 =?us-ascii?Q?A95oX0bJTqyJlOcq8IR1I70IKjIFmYHJcBg7lLhH8FDJY8i1ljaeItqci5E0?=
 =?us-ascii?Q?4WXHZOsS79j6UItjJXuTTRx/0bOOPQzfrSNofkUgMcOVOeUhrmXKvw6a37hv?=
 =?us-ascii?Q?oS+TzBH3WpDm6JBCku6W4eyy3v840D1zeJn6WyP+NvuxWQcxnWQsy/MR5B2t?=
 =?us-ascii?Q?fWMmHTIAefgLYkJdAfQnW7W8tdIPF+wd4xz8v2qWalvoWyT6l1lOov1SiIwq?=
 =?us-ascii?Q?tjukSqRM1A6CEAlU/Y6f1vBtqo21qgQKeOwUYdMDEYH4o8VKHSkovBbGNa9p?=
 =?us-ascii?Q?Bu68d2iKvsT54vL0U8PkztHgVZpgEtQWy6W1RW0J2Wo754lfzjUhRlT0IJHA?=
 =?us-ascii?Q?AyaXqU2cMdn9Vd/nkXp8QL7+qd1ekINUJb/9zas6GfqTQvmS9MblP70vQ9sv?=
 =?us-ascii?Q?FuuseatvRBo0J/v8Rt/KGbhh5OX2/T9x4WdmGl4VK8Ig1cTWp4Th1Uw0gn/d?=
 =?us-ascii?Q?bbqoJT+hZfRClyy6O92IyXn69HvTa9oIFZAT3wWRvABxQMGR80/VXyQ/anlr?=
 =?us-ascii?Q?pzjh4bv1YcgxoRUcFnKqfZJafIEGvd0jwm+zYcj2FfFHbOatn1FHKRFQgXo4?=
 =?us-ascii?Q?1ZsMQ2NiI6lcQPDeflJ9zHf/Cg+HFh+4PQ64XlI3vQz72qmdN1M9r1jQ89qV?=
 =?us-ascii?Q?E9a1+nmQaZ0McyVfI+Uzm8nV0q+csqCdVzLvuuiHTilPzjwJyZzL23tCBOiO?=
 =?us-ascii?Q?1HxAjiFS7ELrpE8msPkRgQisrP0j/hCaZXLQ5cI1HwuXZKyC+F55lRih8UwV?=
 =?us-ascii?Q?b1gkwWKkIC+mmHAg0VH42OczZrcVGLAXOS//qZQ/LaVQG0ksmRa8ckWPfJTF?=
 =?us-ascii?Q?OVCPqL/z+eur/d2XsxWB1EdZo9G+H+PS/r7LOiUV529YqTw8Ra0OYdpMuwQm?=
 =?us-ascii?Q?z/+g9aKBQuGx9TrYasRbo0IYCp2zf4B9Zod6IP210bv0LOwI+K3sinl9QUJZ?=
 =?us-ascii?Q?ueWJUutstluunRpXsi5HEoF4BT0DseWdJCLpvP21UdoipkAsNWU3CwL+eloh?=
 =?us-ascii?Q?VCJSjMA3UxHeeE6QMDAArSN4NgbjFicbyzkWEH4G7/mT0dmQQRLMVJ200gcY?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6jZJZT+AVELU3WMSI5lv1qicPHEqWGZep+BQXTpe+He0D0srnA1NVI/NUWwmH8FwvZKyoM6liCPqqm50B+K3Jl5z+I3cgRjTWJiPYfzMyoeHqmzViMevzfuex4oUYdTRn0xCWULQ3sQbuEdnrU1nJE/DBAPZOv+z4AFnoi87SsN0+vJa+Wp021unUHePDGrrRj3TdEE9pLYw8GkwVCvmR7FehQctsliZiFoqMZo4E0XDkzgNhrtFPsk0AqNuFElhD9GUDwpqnaSmlW3zmRdubbLTLCJwG0WPHw9ZTCpZxekKG487FFAz911alcDxKHc86vNpYGOjugRRkDEszAlmIOHxrq0XmMc6acTDlFwjN5ORPNphzpZfUQyKk35Ln9CE3LfQTdMCSPGrkbZXFJgGy+MrXId/PYX2XIDdBzdkHYhtwjFoRWFBTExKOy48M/MTHNqQBpm9ltqGhWrAPnjTQZKQgud4KkVqS5cOrMxGntu5npM39qta0VcvMSCdymJzdyRaqWO+JWwVZmgoE86KHMvkKF5QBGr2s4tLJL3FbYuakazpDD7ieyuzKWYTUv3ApiDNSC+adR1JMnAKqLrl7psxbueKD/4B1O3eJIa9aGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a36b5a-7aab-4968-5a13-08dcbba5b675
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:39:18.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 769jdLs5GcvrqmFL1jTe+FSgILv7nntGdOXpokP8NHb6UiA2EdnkB0zH5dmwexEKKhi+kAVTy/eUeLd5+9wZEbX1r7qQSuqC5TuTYarXIbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130105
X-Proofpoint-GUID: Pg3cKy87sk4gRzL1ECi6SANIj4UmUXx8
X-Proofpoint-ORIG-GUID: Pg3cKy87sk4gRzL1ECi6SANIj4UmUXx8


Niklas,

> This reverts commit 28ab9769117ca944cb6eb537af5599aa436287a4.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

