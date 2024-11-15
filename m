Return-Path: <stable+bounces-93504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A59CDBDC
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C551F21F4D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE6192B81;
	Fri, 15 Nov 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WUgjUwA/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mO/SVK+o"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471101922DD
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664337; cv=fail; b=IjeDAsTAXHFQ4pj/iJW9DpM8K1SxxnyuYhUznlrirD7e8kHvWIinR2+4rKJpD2m3NeoO47jrAsYTruQNLOcdMSQukwHc8qYrBMnw+DM2PDbW11OMdVefHqd0djM0uwg0ZR9Yybw66J0PRSp4GOcQxHNURL1YwlrXVYgwdvYeYPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664337; c=relaxed/simple;
	bh=qbAZOlfQ8gFxhMVKsIRuo1JqIH71tJbpJXHMq+lfzQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cinAsHZ3s8lqeK4/g02wJ5ZK2bD46923Gq6iNW2k+C3znHCfBiK9zy/zThNPmPthL+FWSZGj5lb3olt4PtdlziHrTCPqYtFxgm+Ywl4IgN05/X3Vt4XB/kfpH2YQ7qI5LO1IWB2EKpWbMNha6uFb7aktHxON9xUOIa70M25b3Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WUgjUwA/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mO/SVK+o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8tYOd024076;
	Fri, 15 Nov 2024 09:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=RZN9GhsEDw6RAFng8m
	EkQeVCuHlQBMU+6NL7Zv9AF34=; b=WUgjUwA/mQhZQpene0UZasrTa4n5lw3YSS
	rQZxhzq8NWNIf2km4+aQE8QuwA2i63L7DJsTrKHm4Lb9aDXnXa6pLGj36bzSVq69
	0XyiDYv2XxZmNS4+zbMJFD4beHRuPzK6Q5ZysMSf59TvG0RH76igPZCnR05IerHL
	PfejqV7eNQKel/ZVHhmL2V5q7tICrFOrAid0cpcYlJ1nLwVTvp94NuPwDrIUQtyM
	m53SLDTHW5caz4QzLY+IuqVWjdw6HV8RS6/zLr55fjQJLQfKMAJifvtySaauzdon
	ZOPYkprTsDi/7lCnUTV6JBjGoZ2jEibT88Ggl1WarywGpSSHU3sw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4msex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:51:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF9hug8035888;
	Fri, 15 Nov 2024 09:51:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c044e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB+ZIly5QuzcX7GVGRDYzFOnNzDB7BywfGBBaebfTo7JM7D2LBJETEVwtgTAtBMy2ihm1zU9RGRMWcPtt84KIsu7MgJuEIAJA/oXyKlq020d8LWGmx8leBfaxrG8T46XP1DWLN+ZXMRhogWvvKNFmrE8aZ0Bf1znPzaLMLxvmnWVR2KRuqm6qbR7IYI2gk/b2+C9x4RJ7Rnmr0XyJTWJ6jQCIOSl0RHRSa69+44gmoMHhskGj1adSfVS15SQjjzsEmS6Ij1c4s0bOMHPN4tlfJqqJBc2QEjlNak9STZ5owTPTPAzzMC+Jo9Srrd2/5g9VdU2o0ViQhi/T8QUo/fJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZN9GhsEDw6RAFng8mEkQeVCuHlQBMU+6NL7Zv9AF34=;
 b=FPhHYyhCm77Jh3AqWpDab3GAz7/ChTlV7qYMzs7MMn0f9blhCBH9urttUVil1f+uAO21EsocTux2qdzDLSS4Nk2g/IDYPaL1UJT51VBDE8mdLtL1l1IVGzFaC4COpeUdKnA0ChyxJMV0G2hGfpJytYsE5DyScJPvV1dBaFdbS38xkgbGgDaoyxiC39oiVbDS91g234Gsi3QfiPQRG+l+a96yxo1YnTJmlW12QChjSPltgPlDB18uU+VnoA74EViub+2piC14oBlGzvoyqRYcHMYkHTNfzZWmh+BYUtfgOcwIydONSocoOjN9b3y9smyB9m7lD8yN1kKTk3vgYUO2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZN9GhsEDw6RAFng8mEkQeVCuHlQBMU+6NL7Zv9AF34=;
 b=mO/SVK+otMZyVNj2/fT8WT1IlkS0PEuuts2zL8ReaFiriKI+3py7zdj7hG1rbaXZ0YBn2S/yCQs0NXc5DeKvYLbQWiX3oU1ajPT2nkVSC9E/VXV5CJ3cvP15gKRk0CICfvn6fMuL26+gRQAlOylR0iJgLWYvL2kgbi/rMlj5ReA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 15 Nov
 2024 09:51:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 09:51:44 +0000
Date: Fri, 15 Nov 2024 09:51:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] mm: resolve faulty mmap_region() error path
 behaviour
Message-ID: <1f886f9f-d979-4f79-b172-79bf089a194f@lucifer.local>
References: <2024111159-powwow-tweezers-dc64@gregkh>
 <20241114172643.730936-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114172643.730936-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0644.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: e36d4fd6-dc11-437a-a055-08dd055b1ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUibukYyFQoPGAwOvijJAhIxRTeGdb//p2aGTVoHIVAzq7NtyiBwfcNKc07W?=
 =?us-ascii?Q?qFsfwvSvSUSgsXws5BEbFCB2RYkEhrKG32nLFrC9UkU/s5etv4EVdHNppf/S?=
 =?us-ascii?Q?vGmndWRGvxr2YL16ZOFPW+rrEx76npDARhUsBTiHuM8s7PstK4/p+cAfa8X5?=
 =?us-ascii?Q?KuLs06qs3Ztqm5xBKn+/S2P6RjRo5YNBlyI3NenQNTNhXwmOSAKmzBfbX61s?=
 =?us-ascii?Q?PgWRlMolOGxH+7IxYSSoK99XGio0OS3NeWPV55SUE2fRb9ZKX7uIBvl9aOnZ?=
 =?us-ascii?Q?naJb3TDg+b9MYT8NL1cUE4Qo1ZLklZqwI7YdalhbOWjl65RKOIHyT5DkULye?=
 =?us-ascii?Q?AUgyHJa1NxL2ofE6ARepOy906iF3pYFy0uqd4xbMDUsz4hpzHawnsuv4gQCc?=
 =?us-ascii?Q?igB3wup/4UHzcY3EhEgKVHR2CvPyYL48nhfKaYSBQs6pd3i5yCedTTEP0d1Y?=
 =?us-ascii?Q?UtJqYO9+kYbuwdNBRfa6Sx7Ik1NmpXZDC2C4OVqdt8+biOxXEh5JmXPAbbYW?=
 =?us-ascii?Q?18YHJie8j7QcfoMkTu9SxGQmnWnWXhsTCSn0sIHV5OZDuhOYeoc6p0RT++DL?=
 =?us-ascii?Q?xC6Zyu8eKrunacjS9vrxl7x5JjjuV5n3bJC8esvsCDcCoZ20ndTMzx3V0c8+?=
 =?us-ascii?Q?u0/PWRs9a0lC3J0D84kwLMLldg4q4sNjjyRbdmYlRkpktL0r0hdq13BF/0P+?=
 =?us-ascii?Q?1yvmieGj9HBwVpjSSMcPx87TeVw0s+qaBEOUzz1OO2Vrc8C4sFJEBAmqVdPk?=
 =?us-ascii?Q?czeSri0OC2EEJR1LSGq7VhP02jNlrJjUKQTmp+48mzybt1kLlDckSk6taNfi?=
 =?us-ascii?Q?bXQG/tfxGOrTM2xH76YMQs0vecEtU6OjiG8RkJ+pTNULF1p4TB++YP22GXNT?=
 =?us-ascii?Q?Y98vmrFLeeuvyVFsah1imkMjrF1SQs5682xOfUbSZ18/Rc58Og9bKMHeTKjs?=
 =?us-ascii?Q?crSkfO3OXwG5VNKtQ9uAJ21LP2qR/Si7rb41xbvkaJc/ksnAUEZj+59lFIRP?=
 =?us-ascii?Q?dLi40xm3hJ00L5NW5ifbH04EUz59WSyPBkj//XtEUEb9EUbtN4Vg/+ZEPBO3?=
 =?us-ascii?Q?1SVcyi23SG1zQw+03vv3LDZjhKE1ekSTyK6yoy5ALuFUNwXpez+hT2Hr++cU?=
 =?us-ascii?Q?h3uucjJLPLKh9wuA+U0xEOp3gYVUVMXvKxuN0PHLASB9LYEBiQHH8k7Vp8Hf?=
 =?us-ascii?Q?gx5HvapdNiWOEi0h9fYwt+EJfWtTjmEZdehVuCnENNgPOW1Hv0l/OKICyCFV?=
 =?us-ascii?Q?ubhrhSP2E+jeqmDhN4cW+QKSsd5a3Jyb6wAvMALRLR3qXVchH4dOWKC6yiBf?=
 =?us-ascii?Q?vzU9lu+aSUdyM3KfZLo1yAGc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FdiYsWD1/Z2aDLnRupJ0uhAuc4Kq0KJ6okDHpf56b9LQQJLwiHKRz4+ycnbg?=
 =?us-ascii?Q?Sl1LI2XX/wqjWe3BzBsmz/YVrlpTbtHEbCTO5NO/rFEEUCeCRc9UnAXe8+td?=
 =?us-ascii?Q?BTH4KMnivWG6CmrWtOFIYGbQNImyfDW6TnzncEytlBxLUXk88BrVaSJ7JXvv?=
 =?us-ascii?Q?ep+TH1sMgQxDLEim4g2werbKZIsTUv/g/zwUUusyLP7iu3EEQhBvw3EuuNpw?=
 =?us-ascii?Q?k0eRjVSazQ8/732ysLr8Gb2Vq2v1C5z3m/cA6rcamo/kZ/Px9VLZSGWeZH3W?=
 =?us-ascii?Q?zPSOT4oyEL9PjqKv+bYqjTpT79e+DP1hj3ZSfFFkzK7Fmjh8LbVYVakTsxoT?=
 =?us-ascii?Q?mzq/Pb+7zG/nQDreXjzS3Z6MtVI4hIdqO7Q0qmlStDFD9T/HjKXtHSXaMdk3?=
 =?us-ascii?Q?Aw1jEqQ1pWweMa4Y0AX774bgj683awfQk9hyQl0Ff9Yq4f2PT0RzyglRBhxK?=
 =?us-ascii?Q?dkDGlGwpd6Xvi3ahTmqTLuon2a78tTc5OjR3tTZkngxacyj3qL/XX06Mrqv9?=
 =?us-ascii?Q?L3RGwpspru2ar37mjsyANFHMiIjNnxDmzdKFUz32P561C2z9vqTI/NKAWJMv?=
 =?us-ascii?Q?Ve7rFx15FeBREokeOAPgVDaG6EM6SrNtrLcRE3HHoE79xit+pQ0NhJ1GEceA?=
 =?us-ascii?Q?jNlB5O6rxsDZrdv/Y5bILSNpOyYK1RJppy4IsQpcoz6yZW3gWRW4ZcL+IT5L?=
 =?us-ascii?Q?EQtMyKBuIvVHzTRuyXzphSfQnOyWUmHQ4NmQG48s/F0BZ7zAUfIjaqsTtEfb?=
 =?us-ascii?Q?tEHJWHhJCI7N/dYzQuBGP7jUmRbzLY3m6zuKsCcjM9/ytdq09WEJRQptMnhR?=
 =?us-ascii?Q?LLONLsWqWHM9xM0ZtJ97Cg3Yaqn81FmUP7txhkNR3PUXMuYOohY4LsEI5+vN?=
 =?us-ascii?Q?XyZAYx6MpPmQKbfhJmGMNcZb1vzkDG9Odcd7x8SsJ18R5iLnTdsFy/cfme3W?=
 =?us-ascii?Q?yKW6u5ZnaxNb65MJELXhNWLvTp2YJbIKzks3Ol47oLcStDrVJqXzo+o+dx98?=
 =?us-ascii?Q?dSoDTji3RA5lw/o4ubze6+ZamzqIZkL3weenpSlZBH4Eqqpm5CcsiL9urjfg?=
 =?us-ascii?Q?NTMe14mFoWkcfYMiXV8p3Zji0Qli7+gIAvFTngQtH3yd8I/QSJ6J/wp3Ee5I?=
 =?us-ascii?Q?PQzmH6IbhZ3GAAigNu9Pw/IV9Rd9dum03Nl4PIOecEU7qhXcPhUKEyYxoK60?=
 =?us-ascii?Q?cxf0fjvPCKQlcJ5l2G6nxTxOd2p+S1Fk3bhXZmCiGpqA6FwKd1cSae3ROKB3?=
 =?us-ascii?Q?577e76bJA/hoFZ+Y8Fod9SmN/6FegbxCpUoXTLECQTxYg7PCEoxWWiL01QTA?=
 =?us-ascii?Q?YNYRirXgmNqS3n8RknuCAvNfGfz4EH/M/ZWTWTsWgNfOlNUlPycjL8AFEs4P?=
 =?us-ascii?Q?mL1EDRmrTWS+6C/mnedQ0+oJfocthEzMt/tap5bUL5jcTT288tFWIl7OHqkn?=
 =?us-ascii?Q?ZLR+olDJ9z/q/a63eFNaNFFzwSdM3wHbo+YHTkz3vqISbP3wBiHuU9PFGdb9?=
 =?us-ascii?Q?KXoTnAVOOX5N0JeB4/9F54OrplJ3hW2rNHFH+L5fFe6SoeHaCMAmi/OqUmMb?=
 =?us-ascii?Q?IfSsyu1sV8Ua9jSK3NTkCxE/dApNxuJF4ly4Lvkae5Q6R2G7OeUP2RH+WGzT?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EKcss3ATOolmq7LR1j6mrKMvEhrZJPNPBP2Is+JyvlCKlazOTx8QV2jequPg8cEzjXMKufCxVL4UptQTZ+TqKMUxyNy0Yd+IlNgvaih8BxxhDwD91decdjF1Gp0g6Yv88MhT0uBFhPDblG14hjmVAt3mJd8OHZvGTw2SED1O8EfA5kili55weHIOanAWGu5Vpsgk+jvNgSEtDWy4KYF6azrYu9rDRwT+XByNr+Xu7HaUo1II3tGzqrA04bUlXYoKzY77cwH08/v7+KRt4rpTLGQnNi1W5f+PCT2nHSibduOZ1mCK+ElE48iFbuzaGaFbsleCO1MmoPNh/ggkwd6e6mIkIrEc4m5KuXLomLjonXC5HoH4ZCa54rSO2Hi0/atUoxjyDrP2CD0bIZOPbcqfTFeoDOBDjMfOmvzLUvABid4Fisa6B1+f71Tke+TR6FL/EPSrrcFRLltMmkBNvqldMkiOncOiaXPSsHYvPaa4jCvdFRBe9GHPVzCoDcPcioN3m5JlW9PAGVal515LIpBdyNBEWepEPcgH3WHFrEz8vbR8JEMtAk6njPF5NRUfGNR4fdZw7fdEb6RK6k6ypZclNXvezd+S9R9Sbrbv53ibIhw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36d4fd6-dc11-437a-a055-08dd055b1ca9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 09:51:44.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX3RfEQn4DexIzerqk7q/Y5SoV54dL/j/2lNimh+mn3aiTAjl9hICD8siyldBU3uCyMvzJ27PNllgywiqhNAkaL0+JjfKU9XX8lSnlxgKug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=733 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150083
X-Proofpoint-ORIG-GUID: qAN7dzfcbuRXvTiLCHbDGA8UJ1PGmR8y
X-Proofpoint-GUID: qAN7dzfcbuRXvTiLCHbDGA8UJ1PGmR8y

On Thu, Nov 14, 2024 at 05:26:43PM +0000, Lorenzo Stoakes wrote:
> The mmap_region() function is somewhat terrifying, with spaghetti-like
> control flow and numerous means by which issues can arise and incomplete
> state, memory leaks and other unpleasantness can occur.
>
> A large amount of the complexity arises from trying to handle errors late
> in the process of mapping a VMA, which forms the basis of recently
> observed issues with resource leaks and observable inconsistent state.
>
> Taking advantage of previous patches in this series we move a number of
> checks earlier in the code, simplifying things by moving the core of the
> logic into a static internal function __mmap_region().
>
> Doing this allows us to perform a number of checks up front before we do
> any real work, and allows us to unwind the writable unmap check
> unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> validation unconditionally also.
>
> We move a number of things here:
>
> 1. We preallocate memory for the iterator before we call the file-backed
>    memory hook, allowing us to exit early and avoid having to perform
>    complicated and error-prone close/free logic. We carefully free
>    iterator state on both success and error paths.
>
> 2. The enclosing mmap_region() function handles the mapping_map_writable()
>    logic early. Previously the logic had the mapping_map_writable() at the
>    point of mapping a newly allocated file-backed VMA, and a matching
>    mapping_unmap_writable() on success and error paths.
>
>    We now do this unconditionally if this is a file-backed, shared writable
>    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
>    doing so does not invalidate the seal check we just performed, and we in
>    any case always decrement the counter in the wrapper.
>
>    We perform a debug assert to ensure a driver does not attempt to do the
>    opposite.
>
> 3. We also move arch_validate_flags() up into the mmap_region()
>    function. This is only relevant on arm64 and sparc64, and the check is
>    only meaningful for SPARC with ADI enabled. We explicitly add a warning
>    for this arch if a driver invalidates this check, though the code ought
>    eventually to be fixed to eliminate the need for this.
>
> With all of these measures in place, we no longer need to explicitly close
> the VMA on error paths, as we place all checks which might fail prior to a
> call to any driver mmap hook.
>
> This eliminates an entire class of errors, makes the code easier to reason
> about and more robust.

For avoidance of doubt, NACK this and the rest of the 5.10.y series, I'll
resend.

>
> Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Mark Brown <broonie@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 5de195060b2e251a835f622759550e6202167641)
> ---
>  mm/mmap.c | 69 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 24 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c30ebe82ebdb..9f76625a1743 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1726,7 +1726,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
>  }
>
> -unsigned long mmap_region(struct file *file, unsigned long addr,
> +static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
>  {
> @@ -1795,11 +1795,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			if (error)
>  				goto free_vma;
>  		}
> -		if (vm_flags & VM_SHARED) {
> -			error = mapping_map_writable(file->f_mapping);
> -			if (error)
> -				goto allow_write_and_free_vma;
> -		}
>
>  		/* ->mmap() can change vma->vm_file, but must guarantee that
>  		 * vma_link() below can deny write-access if VM_DENYWRITE is set
> @@ -1809,7 +1804,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vma->vm_file = get_file(file);
>  		error = mmap_file(file, vma);
>  		if (error)
> -			goto unmap_and_free_vma;
> +			goto unmap_and_free_file_vma;
>
>  		/* Can addr have changed??
>  		 *
> @@ -1820,6 +1815,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 */
>  		WARN_ON_ONCE(addr != vma->vm_start);
>
> +		/*
> +		 * Drivers should not permit writability when previously it was
> +		 * disallowed.
> +		 */
> +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> +				!(vm_flags & VM_MAYWRITE) &&
> +				(vma->vm_flags & VM_MAYWRITE));
> +
>  		addr = vma->vm_start;
>
>  		/* If vm_flags changed after mmap_file(), we should try merge vma again
> @@ -1851,21 +1854,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vma_set_anonymous(vma);
>  	}
>
> -	/* Allow architectures to sanity-check the vm_flags */
> -	if (!arch_validate_flags(vma->vm_flags)) {
> -		error = -EINVAL;
> -		if (file)
> -			goto close_and_free_vma;
> -		else
> -			goto free_vma;
> -	}
> +#ifdef CONFIG_SPARC64
> +	/* TODO: Fix SPARC ADI! */
> +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +#endif
>
>  	vma_link(mm, vma, prev, rb_link, rb_parent);
> -	/* Once vma denies write, undo our temporary denial count */
>  	if (file) {
>  unmap_writable:
> -		if (vm_flags & VM_SHARED)
> -			mapping_unmap_writable(file->f_mapping);
>  		if (vm_flags & VM_DENYWRITE)
>  			allow_write_access(file);
>  	}
> @@ -1899,17 +1895,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	return addr;
>
> -close_and_free_vma:
> -	vma_close(vma);
> -unmap_and_free_vma:
> +unmap_and_free_file_vma:
>  	vma->vm_file = NULL;
>  	fput(file);
>
>  	/* Undo any partial mapping done by a device driver. */
>  	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
> -	if (vm_flags & VM_SHARED)
> -		mapping_unmap_writable(file->f_mapping);
> -allow_write_and_free_vma:
>  	if (vm_flags & VM_DENYWRITE)
>  		allow_write_access(file);
>  free_vma:
> @@ -2931,6 +2922,36 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	return __do_munmap(mm, start, len, uf, false);
>  }
>
> +unsigned long mmap_region(struct file *file, unsigned long addr,
> +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> +			  struct list_head *uf)
> +{
> +	unsigned long ret;
> +	bool writable_file_mapping = false;
> +
> +	/* Allow architectures to sanity-check the vm_flags. */
> +	if (!arch_validate_flags(vm_flags))
> +		return -EINVAL;
> +
> +	/* Map writable and ensure this isn't a sealed memfd. */
> +	if (file && (vm_flags & VM_SHARED)) {
> +		int error = mapping_map_writable(file->f_mapping);
> +
> +		if (error)
> +			return error;
> +		writable_file_mapping = true;
> +	}
> +
> +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> +
> +	/* Clear our write mapping regardless of error. */
> +	if (writable_file_mapping)
> +		mapping_unmap_writable(file->f_mapping);
> +
> +	validate_mm(current->mm);
> +	return ret;
> +}
> +
>  static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
>  {
>  	int ret;
> --
> 2.47.0
>

