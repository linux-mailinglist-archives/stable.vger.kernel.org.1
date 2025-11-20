Return-Path: <stable+bounces-195221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A87C721D4
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 04:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C5714E46A7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326762853E0;
	Thu, 20 Nov 2025 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ly0wiae1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RlyioFd8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B826A1B5;
	Thu, 20 Nov 2025 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763610531; cv=fail; b=Q54deefKmoMNLzGnDwo6kKefbcpDOQwiq3R1ruVgTauJ4u7yuWow+GpeXVLEpJfkEe56QYoI70u9nvy2S+b5dCPopmfKI0JeXsF/Vw16sdiZfa+QlnIVOe12+cyqXXyDc36mR0TNNkMAwSrtJCrDKqrgWncF0xNX9OWBaYQxAd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763610531; c=relaxed/simple;
	bh=dh5UBzHnGZsnLRsJV8IybjxHSqyqZiJqy1/2SfGwdOc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=nCObhpOzVD953mzvqkTnJHlSQrLn8RclLBbIqeUw58Rhr9IaD7LL0TmfwDgpz+8pen2nNZ/acDHAwK6LjJBIGGiNOIOSmDA2Qw1qSAdPJS8AeGNNsrKnmUqmim88tHWvUbAMcF69Q6i6GpvQgYVTZR73KDEFQzSs0+6PI6Uypns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ly0wiae1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RlyioFd8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK1P2tb015658;
	Thu, 20 Nov 2025 03:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=x6xhHWZBBmd68yz69A
	wnaSdxi6+GXE+sl8i7OVPfqeg=; b=Ly0wiae1oI1515Q8QmmD4C2Tc3YKnkg9bu
	hcYLI2TAEwoiKps/957R3mKs5F7YBdiurJgSGRzmZ1VJtqRirdI0MdEqmU9HIsIH
	KdLXUrSzymywQquMe1sJwJ518ZBOQFRMyRdVk8UYwEcuUopsl9ucFnvKaI9T8KRH
	+ygaUMHd35TGZ/sHnuMpQU46dj4dzRCbJFZwb9nDoXmbqlIo4mLtDXp36Qii+xYp
	Lz/3oqTFOnMv80NzM4wk0IH53mEnaMVrksNF+4+0UKAVjGz48NfM1P8pv138uKRV
	8FSrzXv9KHcOsdxkpgaH1MX3vxvaXS1WJxg5UGkTtVlm1jgbrcEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbq0bjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 03:48:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK28lS0007971;
	Thu, 20 Nov 2025 03:48:40 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybgbm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 03:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgIsAyg4Gzy4CkKOdDkDWHilE/j2yA9ZjnCKkpGJRh9YhGE446dpAFZKsiCKNT5xVob2Pqdpdh4p5wkTmdS4OeNN6ndP67v9jAcq6XXR38kK4S6EzesIsLwAxXNg1vIbv8D4PP2FVBBR+CvZ3YlUyJ5XIPl+5guQkvD77yT9t68ARO5I0iabevp6V6d1RQs2n0FnD8T6etL0CjEistHbl2rXVsIfhpdTsglnV0pRhnxm3oeSDJqJA9iO8EAePLg1PU8o2PrnZfRb78MY/NfK0RcGnfBjxo+w0txvI0lYA09jRkUXyXvxkdA5bzBJQVE01NkDmvOydLmXD7bjVhyXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6xhHWZBBmd68yz69AwnaSdxi6+GXE+sl8i7OVPfqeg=;
 b=PbkfD8Z18jT9HawtDrxubuYEFlDLuaS0v9rK6rROY+CT7ijr0KcwXrXusIQ6L/NlBBJFU44q4Z0D+aOYCd2CRWKv29utdlm6TPHl1Er9rTGlSSrejVm/LSpfiJlKcJfwVLbOEcfYFzQVeUjUVqOJebdpdy4YovpxCaI4Q9/kkOUvNkp/TvQpsgNSMz/u9vBazIiWccCM3T2VHqYRSctfls6z/ON9ygEjM57ZHnfz9Q+96PxkDLEKoPropOz43B//bcIh+BMBpUA1Ryca8bv68L5SoiElRoriScb7EE/iO1hpFkv8y+JAsd2UtgLQ6NcSU2NCxuDaxdq+0H0W1z6cWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6xhHWZBBmd68yz69AwnaSdxi6+GXE+sl8i7OVPfqeg=;
 b=RlyioFd88H27CFW/rqJIRVmqKxQpoP02hgBUE/MRyVsqvHRP24DTC+qTxYtGAqvqcI6UNhESXwE7O+5G/SyFFwy0sUg+ZAKhd47HW5gRfhuXNGjGmlYEDmmyqoCNZy9ivKS/Wx3Pcr84o9pfizq/uWaO1eq8vNiKm4EScW+Hz9M=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA4PR10MB8633.namprd10.prod.outlook.com (2603:10b6:208:56c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:48:38 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 03:48:38 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ilia
 Baryshnikov <qwelias@gmail.com>, stable@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix system suspend for a security
 locked drive
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251119141313.2220084-3-cassel@kernel.org> (Niklas Cassel's
	message of "Wed, 19 Nov 2025 15:13:14 +0100")
Organization: Oracle Corporation
Message-ID: <yq1jyzl8iw4.fsf@ca-mkp.ca.oracle.com>
References: <20251119141313.2220084-3-cassel@kernel.org>
Date: Wed, 19 Nov 2025 22:48:35 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA4PR10MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 07636753-bdfe-487c-8488-08de27e7b020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SlMc9v23LRNMRQeEzKe6XV3G8XHyRDBL++7WHiqE2CA6anOMDzwDnZY+OQC6?=
 =?us-ascii?Q?0OnNj5Xd2M979zg7ltuo1lnmYO9SI4AwSNVGyBgUvq7ivnneP571SqxuGe9+?=
 =?us-ascii?Q?pSf6KBFk26mEyONV3b8bPjqXnzUZ+RZDUXWy+Mu7Od/XYtaQ3qJwtULFDa8M?=
 =?us-ascii?Q?xsKO+ja5nJj5sJfrPCpJbnl4h4W4u79A3sOqc7K2ITHCUL43b788XcsisgR5?=
 =?us-ascii?Q?tqLErElcmuHcbEJ3QawHf9AjW2WjQfLMoOccRKORl/GdPy8KgXpNAjh7CIU0?=
 =?us-ascii?Q?FDO9gaTXtZ+2gpjFJsdNQH3LRl15lDk+xHIuzrz+FlhtofN6MSq3b7rD+lcv?=
 =?us-ascii?Q?h9W3ymljyMgvGrymLrDPyr8Hv/7syjqTdmrPS1lSklNuXMw3vJ6+rhljUx+K?=
 =?us-ascii?Q?mE9o+bKArplNDD2wWzRbP561PJr3tU62xMemlwU/n429YeFM7YgcbFWEjNZk?=
 =?us-ascii?Q?4BCOrV0l/4n4DsZK9npUYP3EuwWyppbYIYm3DLSEidFA1efsyF8ToaVput+B?=
 =?us-ascii?Q?7lDnPVofEy7UNw91eyiLUPdQuhdSwisff50qy1yFVVzmRjq1sTNDQlhzdFsq?=
 =?us-ascii?Q?i2TxqQg+H2sukHDgLEJtzWXcEg/N+hlbiokOAZ6Grqtz+wJqX4WFGaJDQXeG?=
 =?us-ascii?Q?YgF4vBHpI2tPOB0LmHDjuAOFSAo6Go73oCzudFVX7AB6K+lQCOpJOvzdZw3+?=
 =?us-ascii?Q?E2EiuZ2o8iERuZr3RYvxPmaFlRtCNGlocQKfC6im92y4yju2Q+gXL9F1uiEd?=
 =?us-ascii?Q?TomgRkqPfvUJPSe5Q8KY0jPm0QsqB32ljb6w/rAY7YLa0FJOoUgWDOweeaN4?=
 =?us-ascii?Q?l8HoawTriAtGVk/A/WcAqGWgYn8o8+Ivjs5FE4/s67nEaj5O43OxNNa0N4oA?=
 =?us-ascii?Q?rn8AeQqNnaCTABJkvVab7ISehRxNLY3i2RxJW58cC9PNQrFUHRbOiO3bPdUl?=
 =?us-ascii?Q?CBnwnXX9uDCx3t7hn6DSijB/Bl1t1mccxyOlOL+ouC/0c3rKSHKSpeGx6oD0?=
 =?us-ascii?Q?dGTULnh9/qXISyrMrX+4KN+XNgJSpvXM52tkJXNh4Qj8Ym8Rc3li5Cg1NbLu?=
 =?us-ascii?Q?IWexbNMKVIzvgM5Y4H8BW4j8RyAkOahnElFeytq4pkOzPwGDwlgOCUciptB4?=
 =?us-ascii?Q?h6A2TBGla+K7lNTKcVeeKikTgeSgT7I/oqtrpn2LiB+XgKMwC3iY2y/BiKlI?=
 =?us-ascii?Q?sDU0F6VQpZfKO2UTc7PZ7TAiLC7+njTZSYfI18AEWPWm8J0z1u+8TMa32OBz?=
 =?us-ascii?Q?sp3MlDbsIq9282MKMUROpUP9v15K0SRupHlOvvqKYex549aLyLP7T/1VPvs+?=
 =?us-ascii?Q?Hl1hKmIpzcuGDUNWRzIUlQ2hQJSRiyFPj9u13zg6E2eIKL9sazQnC9LNuiZy?=
 =?us-ascii?Q?5HOQKoqLN5PFToyDm8bUSouXsuEXxY0LBkW4M5l9kSY6WYjfTz7+kyIlSrqB?=
 =?us-ascii?Q?Z1/4Gx9N+jKxGPJXNeoI5KgNSqxAT7GF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HIOoFA/ormfXAfDgClmLMhSrkeH6qNbRbDC3QOGLc+4Rv0CHAdSPmdD1wOiY?=
 =?us-ascii?Q?LSrbebrjg9csj3AtNGupNUFYsXMfBoNvt4czDsJQTdMFa6V039Tz4szkkFQd?=
 =?us-ascii?Q?gznLJFqWK6gHeUTxQGGiynugOw1yGhjp36S7uGf+V7ao9gylKM0XgJnOiwgW?=
 =?us-ascii?Q?NuNmG7fguUmzPEJP505k2wYhxzQVuwUlQqmjcjTx23oZqsSL0Fse6pP3mmK1?=
 =?us-ascii?Q?f/SLDVfnnyYrrDsmGfMSpYzkWXmjadusXMj3F7pEGjoQaeehe+v1Pqh92Ago?=
 =?us-ascii?Q?3WN88HCm38k8qiOFho6SdZrxUHgtcUAZRlvWQMsOytlUHpVknDxycuyCvouk?=
 =?us-ascii?Q?P4pxEF9H9ExR2M4LT7+ZQpqJsStXd6XEj4hueOcuQD5D7xOahV6GrRyoLQhf?=
 =?us-ascii?Q?oDQAtJ9rM7el92jBqvuLwQlTuNl1ITB7VL4ppNKuuvXyE7ztsM9VRcIkZ8yJ?=
 =?us-ascii?Q?ZzXKidetEQvLSJsrAC5T0gHLjwPbY1pmqNqVxZVY4JVs00Xn3QZbsGa0HmZf?=
 =?us-ascii?Q?Grmgmuf7SBf4sGoX6qU6wW1Gd8JmFXv5QaKMB7n+v8ClsVVeAJ9HAZzWhNN7?=
 =?us-ascii?Q?251T0cO9iEW/TBuIzESRWiF23lLEUl+KthEhARfcMDieHpT655gaAgPF24Q9?=
 =?us-ascii?Q?omZk8489rMB3WDdoNGmdw5l//JkYDnzErQ1r5mnMyTu3Yp+ABnF4KAKTAf2q?=
 =?us-ascii?Q?pg4FBMx8rmJS6VnIQ9i/7DgGgFzCqV+VsCyo+tSe927gBQ3bVt0YHua3BUrS?=
 =?us-ascii?Q?wkjVxxZHhgoZZNX9BdQbZdF/wnLiC18QDo78vvLIgAjqrGn0maNhLEFfZlhu?=
 =?us-ascii?Q?qzqUbQ5mOCoy939Z6pkaTQJF8wd3OcwYyS/uO2fjCevAMd+L85qGdH1BRIkM?=
 =?us-ascii?Q?Jyb0T3HJ5jLvYLA/w78dv7BzXOXDolk5+X2o5NCE9s8lhyYAh6UBPNzz8L/X?=
 =?us-ascii?Q?RHKIknxTW68lW6mlPUyhFCsEUAw3n0M7aV1ZGbnucjrA/N9bAhB0cWkA+1LH?=
 =?us-ascii?Q?p8pl/XkkMwTT3Z4pUVSnTre813YuI8XWnF2UXze1hJOAgldNnSX5/0rqBK/1?=
 =?us-ascii?Q?+gZpAXTKZwcuEH8WwDKvh27vWVAqp/vh+JDhXcqmYlDZ/W27u9vMLxIINWNE?=
 =?us-ascii?Q?SwR0VVYzoHzBocVff1rfJdHX0MuO96nF2BvFBCh1W4bh697ZPJPfocuFnAUl?=
 =?us-ascii?Q?TeDS+Ocdb8rOb8wbOMlyfwbkSDGuINWj9mno+yoMurNd9aTepOAoBtUkQuOU?=
 =?us-ascii?Q?Sxg91PUIYICZP0j+ZNB7DLZ6MEOmtN+kA1/OiHsm+2H5t5C6qUzFigoyvAx9?=
 =?us-ascii?Q?GNHv63nukVVRpGkRhqiAuZo9eF4nLOLey7y7TPrMoE/yxG3Ors6aowV2dRxf?=
 =?us-ascii?Q?F1vvD0brkuZNCDvBadJPp4lAfYiW8MoWOj7fz6Rhne/xvM0ZN/ZYaBaOpoJh?=
 =?us-ascii?Q?E29Uwvej4G6tYmx8vrpfruytqO+hK0os0bIIAiNv+mSFyN3PHFj00WcxCb51?=
 =?us-ascii?Q?imPZnOw6maZhtUMDYi0kQg9YBVkm1zPwpTzLLhTRdwomzcME/YIe1fZqu/Hx?=
 =?us-ascii?Q?NiiIrPF4YC6dMftM4rmD+M6VHc5j5TkcCRNiIhCIfKkD04+8dqcRI0BGUhPU?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OnyAShFghR0w6PvzYQ8VYJmq89ZQqyorngOLWkxsom1gZLsQTLYOr2sJnp3qCygdZEES4EPZtaE2oJ7dokzAKx/XkkrGZjzy7XuawdkAjszLD9RsaMVoFxyg1MYyt5Efa3zNFgkKcxgDux4I3GipRSOgA/PMf19IPi81KlvsDFWZssfXWQAK3FADGRBCiMgz+Mlu83/h4PK2vIv9N49202A7PMCvRK8WLsQTKzqgw2Zi95esG3AFtj33he3QQIkWuqSp4qKMnxQwRTruYKEpEvkmNE/giYBEmkNWUNptzvvBFb587gwmuM/wdFuLtajkIHqc9o94/5fX8G9PbMXMpoklwFmG2MglCtzhpszwg0Kii+3pbmT6XrmvAmxDozklCBn88boDdhLcBG2Z3qQ2VcRcppdWjsQfyuLvS7kguGiEDJMT7vqrnCypBjbipwJWcS8vPTm4tvkLCgWZBQuUESk7yd9T4iLRhGklYTafpVtxt0bBblvqas0p7M3I5sYCebkxA+Z1WqZr+ATo0lzG2qucmuhkpiQxZGNhy3HFGCDAKVzy+klxpkpfCgR+JY6Pv0h/K4BbHSuXuyVseUAugmGtOJXcIPyjzikf5ajhK7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07636753-bdfe-487c-8488-08de27e7b020
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:48:38.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWeoK02QkmznvnFG+jqLZRcqCNaorTqPj8hMGTP9TqW/vo4t4uHeQnFsr8wXisH1wzB1yn0fxPYx2YPDRuGaSoSwwposnUU5JNO6ZuKJEVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200018
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX1vb7eoOoTymO
 ufQTkw0VD6p2ZZVi+oPQFCmR+pW1G/D/G3zWyZtb1h861qStn7vw3ukfGYbAXsZiTb2ysTsMKR+
 sZ4+tP1cYbQBDUxSQa+KZgCEjhfcXocs2CS42V2MFnkM+dzQ5x8AXiF0g9W0lmLgsWSx2XtAwIn
 lFfzpajpnkMTaC2B6AGAlS4A4AI6q0y1WfTTrPdhmB9E/qlpoAamJuGswKi4P/TqLSjD4t+5Jxs
 s7GP17iNk+gLBUaE4jCdnxYXg4hBkeGvZbvdFWKp7hWsIGqNeWQfsqGtk2kHnk4a6Ebd4CRzWcP
 YIhXYfeZO5C/CyqKCR0OZKTYctvQ9EIpdu8JsD4g4eK1VzP9kbZVvieA8yd1n5cV5Z6bBTfvtZK
 HY2LeCKkEp84XXFOJuSLnV1FBya82Q==
X-Proofpoint-ORIG-GUID: pVLhBqzZKAWi_TwaTUUVKRbJ739tWD_8
X-Proofpoint-GUID: pVLhBqzZKAWi_TwaTUUVKRbJ739tWD_8
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691e8f99 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=H0HtMT7YaGYmSPmuLkcA:9


Niklas,

> Commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error()
> status handling") fixed ata_to_sense_error() to properly generate
> sense key ABORTED COMMAND (without any additional sense code), instead
> of the previous bogus sense key ILLEGAL REQUEST with the additional
> sense code UNALIGNED WRITE COMMAND, for a failed command.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

