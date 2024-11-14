Return-Path: <stable+bounces-93053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B29C91C1
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C44B281FC
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D098198E9B;
	Thu, 14 Nov 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BcmdHkcz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Em5joXa8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E9288DA
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609404; cv=fail; b=fk+AxXu6kM4CbEolNItOnUy0EWWkPqoQA08jIOaBru2C9faxQQw3669KNLL+jfi3hsz6MjXUw8yEoxd/RFqNhhhgA46HyOkbq3xdQQyJnGIDwXJ9PoVK+qQ5EcZihZ1SOMbtMMcfU25F8YTtLz2hA2yb3LLPJgZmvLEFyBF5slk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609404; c=relaxed/simple;
	bh=H2tvGME4dbOPO/1yQp2B0Dn8kYnKt54+LYBe+YbdzXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHWGN6P+80l3C0rB7yVjS9LBxW0tA9YUvCXdEoqzEDsCBZp4NrfULXGbMM9oWDooMooSLU8N/n1pmj3fqBG0f8uZDmn4a+jwPY+SmDAYwdYu+opYzUPMqbYokav6Lg0+vlcALKIPH5lhKdgFFwpG/oJu+yEY4zSwIU07NwaQNBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BcmdHkcz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Em5joXa8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEDAH1h001669;
	Thu, 14 Nov 2024 18:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=znQnOkAudkjNrI7gEGL/TbCCiheTdMZzvko1T3l6foU=; b=
	BcmdHkczNltIGT8AlSvTypx/Tr44DXXrEJnnVmzsXzbKh8Zd/jHzjDGXGRqzF8BZ
	o1Tl60qtVKeuc5rokKE6eoWBKyHhvfDpryq2lpWLu/JPFbIYceUY8c1AGrKm46Rk
	NU+zNDTs6zGzeMpqQFwEsAVKp42gmEUJiUnIJvuhU0HB2Zp3h1UPu6XWD2St198N
	qqc5m6LnEcvRRapE7jp8uwMIjD5etLpT8jIyZ8tWJ3f87M0fSqKx8qjNo7/dTlZt
	KNuX1gdHg7mh5Xo2POVm0+M0ZCF+tHwPG4hOBJyGLng3bXG6cDz/Cp4YMR7PPDjo
	16Wsf3OVn7l2WqgCVIT5wQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbj111-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHUDL0005686;
	Thu, 14 Nov 2024 18:36:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bkf3a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMcRoS6i7Xtk1bx3O5RXSRo8LpN1miTiD1YRbOntIxX+UpZ0WtvwMOtF6jZvlWHKHJdO7CXkGCAbdWBqdWMCT7V5U2oAuolJX+x5Z4FoXJIlBuK+cDc08cP6uTKCyOnOamLp054reRknlTHRSjVoACvJEcalgBaceqphS6+cImGKoUgU2VzEn1UpKnf30c0jsB1d8zjVsqj8SCNM/gH34NZZ4E1itNxopEpTwXibxbhpc4HlSLP+n2DnUbf+g+9+Qk0aeYMEVnSY+Yj+q+csvTD7C+zTkTpyUztg3U2UcHQmS9IwtLtApLMjXC87VkDjFLyh+qsfwkXqKp5mi/GplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znQnOkAudkjNrI7gEGL/TbCCiheTdMZzvko1T3l6foU=;
 b=ILbVF1O/a6bLNg8pWDeQacGnLj+Ghj6OElTTxesHpTW/kD5ESsKW32YUTa84PugaiHzjGF2yNglI1Wox6UaE2Y51PgE7SfdfpKdZmgUd3gzm5dQpR2P9HEeJ9J6lNwnx7TydKcWiXRQH4R0cWk+qXIDFviR5BJ+wIhQDe6AiVC5Ria/aQvqb/q5Rq/19qkNbJ34gVFz0FYnrUovo6cSiJX308SrKDXagfDwptrNDxCGHwMgOEj4mxP19EIvKw7Qs5BAnheGz6L6OidcwDnfMO6+QFpzidP/VDzfrOVeIAN1RrDlHXg38o6xV4V7XbOCCtyL6Amq4XeSBcYU7UV4lpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znQnOkAudkjNrI7gEGL/TbCCiheTdMZzvko1T3l6foU=;
 b=Em5joXa8Zuq/QpetcyHs+S29kTxvs9q6uVavJXSTPyHtqRmevnki23OR0js9DCgibko0js5Meb9hh+lEElZpfTHJ8C9blQjgdyIkSlEE28oyubQF+rNwaoGx8cVE9R4xT7rT1gdFWxkLTBAUcybkBKjGVk2sVk003VLtXs1mg4k=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:36:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:36:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6.y] mm: resolve faulty mmap_region() error path behaviour
Date: Thu, 14 Nov 2024 18:36:23 +0000
Message-ID: <20241114183623.849184-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111148-talcum-shrapnel-3374@gregkh>
References: <2024111148-talcum-shrapnel-3374@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0337.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: ece088f4-ead3-49ad-3b2d-08dd04db3fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c72RUS3mkCdp/s18B3d0azn+Ty7/kZ3gNrNggiWIEl/L5XhvwzQWkuPpd2Zm?=
 =?us-ascii?Q?qJaqSxk04Q2lEMmMiCCsRdQRlG0hHdrICjZsCJpmTpTpFf3Ob1zQwY4xJfBb?=
 =?us-ascii?Q?xfo+FNyuB5ImxCpGNCGwU2+3Y5bzDgA0H3BXBCwfK4PkZRJrZbIa2feIvhOO?=
 =?us-ascii?Q?BF0hgpAKYA9O8uV0l9R2njhrjewzTsr01oTu5ABpI4v8sWQn2fCEvPtTzymQ?=
 =?us-ascii?Q?Dcm12WtnuI0Rwc70NQweK4Oz+vzcBDaW9vt6o5ym+5szhjHjLv1jrk0LJYr4?=
 =?us-ascii?Q?WWwL2st+v3K4W41zyUTiczHuflV2nzVbvow2Y396VkTyLS4kz9izdx8QwUBS?=
 =?us-ascii?Q?R+Rk4aBnMeM4ZY0Wo+ER61pFYk6Q3+BPl8A37eYdmW6Oy75Xgy/y+w5xsVS6?=
 =?us-ascii?Q?Ec/SYa+VOekUfdEHymghCu0uMX8xUtaR0EcnDp6etkqALb+V0XVxtZNnD9Uq?=
 =?us-ascii?Q?A8gfp7ieUu5xVsLUUypKuJrYwO6C/ne8tfgH3uX6GK82uEG97BSgWOkeV5gJ?=
 =?us-ascii?Q?fYTa3fmrh8TSv1dBJfDwx39FqOnkNTh+Nnw1P4kAwN3+WUMA9f7RJjN0+6X+?=
 =?us-ascii?Q?EPJefKMdK6QzXCRP+zECNiJAPfjwuB5YbMab+bQmlDFmIvhe5aakPCApybjg?=
 =?us-ascii?Q?8BNfHK2Is3P6DyosQO7j6vnf8TxEN6tai/Fl0w9ofVpSGcocY56tYlCM6nBB?=
 =?us-ascii?Q?FiV3jdWYfdBRcMYYPs7j9HfYvz2Oc9W4DovNL5D+wgtN2PkUGc4cs/ExeKFV?=
 =?us-ascii?Q?dedy+yeWw7phEsYci4XYd9H8eUjsTP/IJpLJn+4EshaZfDOP2vtocAUHX/IP?=
 =?us-ascii?Q?COPCL1ckg/WLFekqUTz2+KEdUNBgmEU/uDLEwjQ15mTNB0PY+yFwMp5C2zuq?=
 =?us-ascii?Q?yHGjtuEpi0UdFG4hNu3soBj2SmPZqNaMaVSYAaAVkiv6QZ4oTohmD6Qgvga4?=
 =?us-ascii?Q?GIVaGKu5oF99p/LoDLhCsQEjR3fxXET1xv4m8flqCmPVvBWcqPGefnvTAGou?=
 =?us-ascii?Q?EzChXEkheviYz6xxVvCQ+DM8+Ld2AHYj2O4FQCwJgX0qPc+0tGeN59rc9V/h?=
 =?us-ascii?Q?YUwtQiEEpZerTISY7ER3l3p0dVT9in3Fz0P0v9120bym3S6yY/kQAPzYjQvM?=
 =?us-ascii?Q?AbcP8iIPA9mWV9T4Q85acuzH3UJ6DGkKTpJzrx+dd5gMfl6RnYMm6EBKuSnN?=
 =?us-ascii?Q?W7Trbo0EJw7ZwHfKfeAQJybLc5fIE+p7JcV3FajMfMkU3EmwAzlJOZabQAct?=
 =?us-ascii?Q?TH+5c7vnxW2gUE8DBS7Oz92/c2VskJfmWxr4YElAFoLYY0iGYpY7JM2fhM+e?=
 =?us-ascii?Q?G6icH/jyTZo5Fd3RCBPPPce4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0Vrq9xVcbTz/23DrR8OV7KAVv3GKsjw0T2ajMdG6dx1tIhqCQ42HtR7bizQ?=
 =?us-ascii?Q?MGts0iyokNxXglGyFuQvxSdXAqmUkBffSjGmSfBdLfYfm62MqpuGmbe0Mm0a?=
 =?us-ascii?Q?vVz2NQBA6NpVyKARPc+6FqBfA94tCTDQpHp8FojeAEQgqCrjbXvWRqgQhW0L?=
 =?us-ascii?Q?6xYIKoTNocOQNmIkNk7/+x1Jv3S8BkrFEx/+FYNDkYZcYyemds3gClvPqij2?=
 =?us-ascii?Q?S/w/20aHd9Cc2ipar8pAqgM1YTFWCuTM4Xe0JkIT58ZQ8KB2szUv+gRtSCDH?=
 =?us-ascii?Q?bUxCea4cf6u+M1NeSKND0VxRe2xLJ/kncYCQD6CLc/pBGVQYzIJ7ivs1w/6Y?=
 =?us-ascii?Q?/ujLe8eag05yvzx2dkdjXT5maHCHvbnJCw+kAY6+Bf7FXLzTStqMVI0l9Tmn?=
 =?us-ascii?Q?qjygJIwQDjhKUJx/XQ3aomwZKwvZMswJI/szHg+t1dmB7arvRxUhebfp1ExU?=
 =?us-ascii?Q?+q73o7PWejitwQu/66lcj8welIOTDnLCI4aS60v2GJ69qUVXDDoqlMbKgra7?=
 =?us-ascii?Q?aSnPkBRXnph76BQxFjtyGqH5NHj1gHSoe5qGaaGPKeJUwR7vtkvoz8kA2MP2?=
 =?us-ascii?Q?RA4JQasZRREHZ3Bc5zVKSL8520bFg3eOTCwyIyWrUfhasDk0TlkZeoJ5kdA6?=
 =?us-ascii?Q?4biR+pHSGxAYK41rRSLYeGgIMRdUXkc3t3HYeScWH9A+QHTz9LZX0PDCB7mQ?=
 =?us-ascii?Q?iAK/QxROLg5DIIjQOLWGWnVGtihxYde4yoYhWSuB9UZu/+6eIPJ80HWOpVOh?=
 =?us-ascii?Q?lDXhzGnzGGJfg7GuBZWzvlgkuChjHmIqSn1RTiz89GVXsaiPKLQq9Ow4jVhI?=
 =?us-ascii?Q?IPidOQ+RkouR9+90WWadZViHn361OcKo5Mxg1JyCLN/w9ZXmtNsFKlseRKj5?=
 =?us-ascii?Q?wzLAfSnmzNFfHLEUsj0uoWLokxyA2zLypea2oUpHfrgRGPiy/bU+0MBSGgFj?=
 =?us-ascii?Q?0cI36YaGb2TBlC63Z/Qe9t35jscXyymGnaQK4H5r9eeYGdOIAwlGMhzhiRr7?=
 =?us-ascii?Q?uIBN72WIHBFBCIHjpUFPQ9fyFOgAG7dHhsupr6HHWZijEsEx3t1XPrY54PS0?=
 =?us-ascii?Q?WZUVxINgcHppMLSDtOC5TZJdgMraNZ7hS2zq+F0uC+bhxVKMlTR+ppKEsK4+?=
 =?us-ascii?Q?OBWt3vIb6IQHwyLXQ/sD/A6Wt5E1Dau7Lkoeh6lVPkBe9OUQFxV3IwdBc0kW?=
 =?us-ascii?Q?xqIbMXiT/8DsSUxiz4An6OA9Vq9UcgXhk+WLuuNjgjsLzrI98eMlGMTZ4tRe?=
 =?us-ascii?Q?bKnozvZ/FZA9J4V2l06J0a2sv1TEpNM2YNSdZGfRwSN2Qrvgnelk96QIoRtM?=
 =?us-ascii?Q?4hEgfQeqLvk7sdC9alkPJt+V7G3s8UJfzu2N8OCc7oYfr1kT78PGVcK+geYY?=
 =?us-ascii?Q?IChZFauDs0E8s9WJsI1mZFI3zvUQ8RmICUqLpJaNoaY/JZUpeqh5iBcgKi/w?=
 =?us-ascii?Q?XOrDKHtRuK7/aAveF72jfoAfAWcVu4heFRjS5vUDjept+MoO8zQAKfqXKZCY?=
 =?us-ascii?Q?DPcbzkZntHBNQH44OOqHPMnRi1dVC4i3Al2Ra0YzvJVLA2Aw5oDpQy72Ti7j?=
 =?us-ascii?Q?jiwBdEl/X6wRAJEQDoB6UVHIu0oMcDmRoqQnsYa0VSKfY2FiF/JzX2v88QYk?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wT528HHAZ6uCa8OcsO7j8NHGI7T5+rEnMU0DSy6bTi6Cd4xBKVlOWMoUpiEvNCtfHbup0bEtlXjPyZgIZNY4Z95dac1DWAnEveHt4ZgXJ8Ndau2SX7+uUVvKV3KYtZl6RoHmalyTVhpKv4WB0m7w6H3FPfLDx7OW4vxZkdIUGie83AIM9ZfyfalulblmMexNZWGUiYeg6ZmY7cIgGKfBjMn/66oAR6JmWKGQFk9IPg9vcyA7XhEIE/K/zs2N4tphb22aXhd4AtLf9TtJnNgAooZlQ/L+qZb8xLXW40O9O2SiGFuFf5KW5makPl/hpiWOiT9b4O0brt1gADxKjehFnVwqhd4gXISYU8fJ/EwLdCt8EHx4gUR+MT2mjNC4USVCRKrjtTom6HozddQlnENGTwANliPK/F2x0pP965xCqG3E3qWUg7Oo5adR1kKOZ0eVVxcVxXeQUOeOA0Uo2bbKiB5J0CSmlYFoNlqawnprp0Sqo+JTj9achElYPSwkTiTtENdSY7RgwxA3UN8jb2MkomG2ojjlaCp17hQPAHR2o/uNpJy/q6rjyCgMeK1gN3UtTwXX+QNwWTMZciFF4yVK1x5DYk495kLhaZuoBX46JSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece088f4-ead3-49ad-3b2d-08dd04db3fc8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:36:27.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sj9p9JcxbFwNLzcpTg+ek3Cj8ULyS93iet5J93iTDvc7kBoruTig7n11M9kU/sf9KI+lCNjyX+ybyHzRAMZv5uCOL3Ihp4P4KOL61BQK6dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140146
X-Proofpoint-GUID: N1kP8crSylrufwsesuLThuU_U20Dj-Oe
X-Proofpoint-ORIG-GUID: N1kP8crSylrufwsesuLThuU_U20Dj-Oe

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 115 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fca3429da2fe..e4dfeaef668a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2666,14 +2666,14 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
@@ -2770,25 +2770,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
 
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
 
+	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
 
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		error = -EINVAL;
-		if (WARN_ON((addr != vma->vm_start)))
-			goto close_and_free_vma;
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
 
 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -2800,6 +2801,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				    vma->vm_end, vma->vm_flags, NULL,
 				    vma->vm_file, vma->vm_pgoff, NULL,
 				    NULL_VM_UFFD_CTX, NULL);
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -2813,7 +2815,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 		}
 
@@ -2821,24 +2823,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}
 
-	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
-		error = -EACCES;
-		goto close_and_free_vma;
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	error = -EINVAL;
-	if (!arch_validate_flags(vma->vm_flags))
-		goto close_and_free_vma;
-
-	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi, vma))
-		goto close_and_free_vma;
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
@@ -2861,10 +2854,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);
 
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 	ksm_add_vma(vma);
 expanded:
@@ -2894,33 +2884,60 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
-	validate_mm(mm);
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-
-	if (file || vma->vm_file) {
-unmap_and_free_vma:
-		fput(vma->vm_file);
-		vma->vm_file = NULL;
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;
 
-		vma_iter_set(&vmi, vma->vm_end);
-		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
-	}
-	if (file && (vm_flags & VM_SHARED))
-		mapping_unmap_writable(file->f_mapping);
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
+		     vma->vm_end, vma->vm_end, true);
+free_iter_vma:
+	vma_iter_free(&vmi);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
 	return error;
 }
 
+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Check to see if MDWE is applicable. */
+	if (map_deny_write_exec(vm_flags, vm_flags))
+		return -EACCES;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && (vm_flags & VM_SHARED)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
 	int ret;
-- 
2.47.0


