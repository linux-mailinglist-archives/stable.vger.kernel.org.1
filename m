Return-Path: <stable+bounces-179088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CBB4FE9E
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A3E5E2D23
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7B33472A;
	Tue,  9 Sep 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVQqRSgS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fteun352"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85B2EB853
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426593; cv=fail; b=XVzV+7k6nse13Sywh5Trw/TAqiGMjwrXkk+2kFxGhKqVhKGvCrV4U1AamnopgmFDkBreIGbsVU/OW1fMZ8ytoXriPkBeWcPnWwvJMu59DjRwHwcX6LXKtn2hCnFuz68TSZMONaTFUmXLXBjT4Erz/YlcDvmXWmjGWd9sPvgglk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426593; c=relaxed/simple;
	bh=GO1JjWHNfQPTnvVzCz4RSV/E4YlnSKM3o4L3w/EQR64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RUEAomJpZzsU84l5WqsKiTae5hzMiNEyaYRpAfcvPd7wU6MBdgxbcp4x2JrTzA1o6Y0CxHki8b6P2vMp8rfJopzyWBlLMKZlijsz+lWIvhk8gX0mcCl81BPORr9AKhi6AlmOU9y7Fpifo2lfUmPMLgdZEa1T6FQzo++6XIXwk+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bVQqRSgS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fteun352; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPX5o009226;
	Tue, 9 Sep 2025 14:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7fIn/GJoR+5KlAvala
	DukL9qbf0rZf9vzMSmE7yKChI=; b=bVQqRSgSJl9KmovOn0JOasCvQTDR2M3d3o
	2rSzKJ+3e4GNcFPvvm/fdv7bHmwXELqHMI93wSY96RPCoS53fkdh4hx5c+5yz/2o
	77/XjCz/DtWWYEmGVYHCRmUU7cP9JplttYW6yvwMD7bkTbD9olB0QFHiaK5PYZQA
	QSYKi4B5YIgOqTB9wrayc1MGoMQHItGwpH+wnAeLe3ah1oHwYdF/RLCoi59a6JGn
	6OGe4Hp5Mmqq8o+PC2WI4alnsy0/sHvZWPcIeHS9YJvDfB8jY1oDvHMROZg0bP1I
	wDf+N9pVtbaZkbN76pN2A++Our1lD65xDVPgUTfEvaLkbAKdXbXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2t2s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:02:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589CaD14012839;
	Tue, 9 Sep 2025 14:02:07 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9vcxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfikbOLvEjEhJw0iyF/TZPBPv6yC7djMSja9bZvsbhU+/MVAibZacYjhBNEDHjFT0C/Z+dMRMujm/ov+C8vEBfrGfUJoRA2JCxQuHq4n24mcIzuRRc1PQ2wq4DDPObHqLXGq+yAr9479trmgHMktDYMJizsUyhHEaO7bcNZdLr1fmU7tXCgkmQrg45trv/085y8/LLv7MxTwtqSKDpZCIMFymx96XZD/LKYJsbz/iaiR+iKppcasBLiooVHazMfPwjiiph3pN26XFDlb+S3/RNGw9uGvEOY3W10fUeTyglCfntIsE4N3Njp6sftakHmIfuQkg7uR/ktLiOGmQaSOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fIn/GJoR+5KlAvalaDukL9qbf0rZf9vzMSmE7yKChI=;
 b=q59TcmtLTu6c6nll4evGjtF3ImRzMTGlGen+UykTEy7o9K+V6YoqbNbKYCtnUmrFD5+xS3ZLg2CKTpneemKbJSBP/pmCK+ayrH8PEr0GNtOCWt1qFXRqfaV3l2kJg7bs4dpS4DMLfvMc9GIvEoojMbLe6LJ6wumX8xdKiQguja1b1NSz9MiVrIJMwHN4xJ6+r0sdv2FhPVKwAx3KP27vsYnwbY/8TIyF6BPBQHBBCwFpXeuTFsvji1jzKfT5lNfCHFroJTggQQdA2UNkE3RxwmvBxE4qWZIeRKPdiRKMY4ywwPZBv9nuheG/rCOA48DjpqZTMIOJXshQF3lyWeTQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fIn/GJoR+5KlAvalaDukL9qbf0rZf9vzMSmE7yKChI=;
 b=Fteun352gXJtjRwGu5T7FJLJUh9uzD81nJhAxBEc6sod0DTqcL37eFf8w7ZfuKe+V/6ygcsRh9YqWx1sDvqUfRWhKAv4vqrCo1Pa6K5Dhtw+CWRVlIiTehufqd/8cDLk46wfcFT19ztnIMA6k6zPsCQ6QKQGNSdzLZbNuN6CFtg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB7526.namprd10.prod.outlook.com (2603:10b6:8:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:58:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:58:57 +0000
Date: Tue, 9 Sep 2025 22:58:45 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bibo mao <maobibo@loongson.cn>, Borislav Betkov <bp@alien8.de>,
        Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
        Dev Jain <dev.jain@arm.com>, Dmitriy Vyukov <dvyukov@google.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jane Chu <jane.chu@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <joro@8bytes.org>, John Hubbard <jhubbard@nvidia.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleinxer <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 6.12.y] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aMAylft99J4x_b7d@hyeyoo>
References: <2025090602-bullwhip-runner-63fe@gregkh>
 <20250909055432.7584-1-harry.yoo@oracle.com>
 <2025090947-everglade-hassle-bcbc@gregkh>
 <2025090923-depth-rebuttal-925c@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025090923-depth-rebuttal-925c@gregkh>
X-ClientProxiedBy: SL2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:100:2d::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dceee3-a20e-4a74-1f16-08ddefa90553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZoh3CvXu2FCKMfuDg6CkWdTyHbXUNkQ13SQAotDi0zlMRDVOJLrME2VfZqc?=
 =?us-ascii?Q?iWFIdrsWerYkQNAFlCMEKwpn7DV//51hlrWRnp6YnkaBtrDDTnulFzgrvfYb?=
 =?us-ascii?Q?MHOiZQ5LZ60y7KxA+qPUn8JeZYUBtQSnulGp3whzfqVwIDUthwWvisLUc82I?=
 =?us-ascii?Q?1NE8/Icf7Ldy4v97+nF/r5UWKtDx4sABDjE2QCpEIF6/MyWRrFuiZexVuymV?=
 =?us-ascii?Q?NHy6DGVeVt7mp+iHxzh2mqFCsnvAuOcncdXn6A9CHOQBJoP86Dog5VxGKkqu?=
 =?us-ascii?Q?RGlOsUrcfkP4BFE6QWh99BEcSZpvmTHLqdzQmgGYUy4RcQEHIavfWUeRS8GZ?=
 =?us-ascii?Q?x923AcaQJJ47F4No+6pRRuDaff4fvDQ1s1maw0gsutA67HOB5y3D2UrcP5WJ?=
 =?us-ascii?Q?BIjgHJSUrnwjBNdc/zwVJ3Rcw/3LnRIN5KmB2pBBY8buYcCXI5IB1t4BMdsJ?=
 =?us-ascii?Q?KlObc5tsjbu+dX6Zm6qjAmr0/5zuK6dInmzuwpnMLGejNXs8UxwIo0/o3S1G?=
 =?us-ascii?Q?Ng/JQ2rOlN3DPgkl8oCu2sop+WAfqKzaaOGgBIEtnwr0InNHD2ZGW4h+24h9?=
 =?us-ascii?Q?NkSAFKWNzTB08NztiEsnzvtXbA0T3NdVjYsCYPz3WDo1kDFemFZWe8aAigRK?=
 =?us-ascii?Q?HNIT0JIxZNXe8n8D2hD/WiElCxKy7fZAqf/d3xsr+DcVVn/sdjcKr8ySULY/?=
 =?us-ascii?Q?mrzGg1NW/zUfHyVKtRr5U/eKzPquiSFyGNOlQHHgkAGCP5g8Wh54Rfd3BSIx?=
 =?us-ascii?Q?GTm2QJ+5vxjjY3Rdf+Am/o8Yg8B5CAfYNHPACtcUL4VKKpcul+JEDatQqjbo?=
 =?us-ascii?Q?dtq6oPA/liYEATNx6gpf2xgrSEV/SekuNX+KwiKfM1UnHVUWQw57t5bbUDig?=
 =?us-ascii?Q?qNx3ren9+njRDeASe1D07fFA6jqJF4rHW9GE2OmLNBA0re2M5U24Iw6mOHzL?=
 =?us-ascii?Q?CUFRd2cLI8b9Xmz/DAXWZHSqMMNpZcY73/4RLc4a8rEyUMVyKps1WXBjdHBU?=
 =?us-ascii?Q?XUyqnusHg19XfTcQC4JDbsZ/bR+kQUSLQFE7fC7b3KAie8HSno8b7TEC3T90?=
 =?us-ascii?Q?mpyhp9gJgv8/ALszOcry2qas05vD4MQGdSRGo9F3VWZUXOZajAa2ewPVh9jO?=
 =?us-ascii?Q?Trme3hLYsz2RKJeYkCMXbLFBF/DCIQjYToHLPhuZG/Df1m1qYWiRQaa2EQhc?=
 =?us-ascii?Q?iH2thKFvqk6L745nvjmMWOk3PyO2BPuikNp5galLchhwPaE5PDr3BspqFRk2?=
 =?us-ascii?Q?lAS5QASwAyqCKKLonXBV9vpQC5vpVbcx1kzm6i+6oYVgMBv6UY+N2539blwK?=
 =?us-ascii?Q?mzqlTmihysn6eGX+1zDBuUx9qMh2tGDdpqISyaftLnKYoQyt6ZBuNPpZrzW6?=
 =?us-ascii?Q?Izcwurdyp6xoSU+Pdash5t86i2GI7XxbgkaVK+rhZ5JUzfdnUBDo0osEbARQ?=
 =?us-ascii?Q?/lS7yUoV+kuMZV3vV4ZpOOreA2/gQzvc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzEQhLMDM93DiLFQXX4DbLITGAr9ANrMnJsUUqlGWm+msrgfIWg3zfLsOCMH?=
 =?us-ascii?Q?XW5GxKpcSDitXsApEy8EFyyFseKc7uyOCWrYd63666NYa7Q9QuGMPOkwE5fD?=
 =?us-ascii?Q?EMDxZcSRRn+2jZ7n1ddKYGwJjRjm74o/98Ukd32HIuZvExYE3B5IQvhXhjmK?=
 =?us-ascii?Q?ZKQDgtOXG8eRE3eGwfSycY2WUQqD32LMU8DuBc4OeQdestNJY+JwVoWfhNUp?=
 =?us-ascii?Q?5QT6osE/fw32nfsYTMzOpaSevQUgDXEESy5IlHmubdby69a/grdtSJuAMpIz?=
 =?us-ascii?Q?BHTTP3+F6u7dGySyvx5hXg8DyVz00De1piLRAsgyFzFqbeAi3AuFXHoyOIK5?=
 =?us-ascii?Q?bgjuasT9EKJmXzdPM08oGZ24vBKmMWEPGJMxlM+NdrMuGtP8aysFl0YM6woF?=
 =?us-ascii?Q?dl4CGlE2XocXGqsMAl9KymzpiYGd3YivGdeJk4vSoOy4Y7iQwFWKOX1tYctK?=
 =?us-ascii?Q?KAai99nz3l27oXGYvtgd6WIoIAm2axMszcOp/wxqoCi7TqRbq7C/et5gzlcB?=
 =?us-ascii?Q?JggAmI6NfHImRLDs7n4bAcOJXpfo7Nd7pLZyulg7idfZMEMN2tjcprJDN617?=
 =?us-ascii?Q?w4xsHbX8OsRx3iChFubEKN3PE5BRnTMo6wr9EmIzrqo3ITLdqf2aErCqDn1E?=
 =?us-ascii?Q?DqnzelWAm7rrDLMm+37ljiLYpJfAVsmhMX90bliapZ8NsTdG/rLhQEJe9s97?=
 =?us-ascii?Q?h1+yF/WeRv8JejLEW4G1Y5GOxmfCt9CGDvqAV7MDs/2oNsjRAhXb0mKBvtAJ?=
 =?us-ascii?Q?aP0mcznBayWGEXi9dyU3o7f/pr1PTEBplb9qeC7q4qzy/tAtGTnTHpOZjLPf?=
 =?us-ascii?Q?YMvGQ56zWANjlBo0ujH/LdTIOnz3eqgjzd3RXOPILNO6PNNNq8Nl/jIAe7r6?=
 =?us-ascii?Q?pAZPB5w3hXiy6MD/q41HEWnwb9lbx5CU9AmNmlVdwE02r8ATsOMktkFvmbX4?=
 =?us-ascii?Q?hpxAUIJVMJggEzcFPxKY4EAhVXHw/3XbplmYhZPw0ezAwwETCwwjdlZg36au?=
 =?us-ascii?Q?er9/CglTQezIQWX1eQX6STKCw9s49C56oGpUdK+4FoT3RHrFnUVECqFxKlGq?=
 =?us-ascii?Q?eMz7VpsSDsrlYxNEdvjyLaAlpgnQtUY0fiqcpEb7XnYuOzyYy930u3Nvui1G?=
 =?us-ascii?Q?77+gAuWz+/Mo1A+lq8k13UuFJpGT35QjLJsv4jnBiGjbI7gk3/s77Ccis8Jl?=
 =?us-ascii?Q?g5zUVd4J7dS19Hxty3QCxQosipXrmv9I/l0zQzkDXGecoZIFyHwwKway8Wnd?=
 =?us-ascii?Q?a6BMNY8/7Z3ETClVuEZeMVgn5dTrqszFGWUQsyIbGdLNhnDk3VoJ2kMHCk+/?=
 =?us-ascii?Q?JzgNoFYUukI9SOZgx4MRHa/PGPLHEGIkhc2vL/Eher1OrV0LfYsRO0xNnlF3?=
 =?us-ascii?Q?2p8pa1deRGPJqxWC9S3UtvPnyrX7Mh0vXqUOlNAkbZTu4GEtCFBvIkwSjGEa?=
 =?us-ascii?Q?+Vu9Tp3hy/ebeDcQyt1AMC8k8E569la35S5o2AuLtnDaXtFFUlrEhoViN9Qy?=
 =?us-ascii?Q?zSHij2TA5w6i3yFStCm0a8c4FmZuKhqVRDfuWW1/NsU8d5QCHeFC3OVpZjKt?=
 =?us-ascii?Q?9xH4M961KZ4K/u+FZqQxDqndnvP3pe3imiNnZ6bj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M++epcIr7hz8XxeKjGePSByvbgLGNqaYZChzMJmp40pqDQ7RHr7wZO5ukNy4fk+RuaZvuDJUB3EMX5FQmV+EzmJcFNqj2+Bb8O+1qs7rMRiTfb/6qcaN67swcYGinNDs0cSFTERzLN1GqqeKKVBcO2EKNQ53ICXbjTsawwk7VzkaPYoqH2ELeXclKd7ZzvmrxKfoFpUMA4uAsbcHat/n6JXD84lizReQr0LG/NPCJNZXJIn5FSfsQq6rOy30ZrSR7VMhHuR+/7LRquq8uDs5YKBIZJWIglSRu0J7Gu68/lMURxWouBSkZBrshkrFxQX20gVsexj/wJqaKPTVHUx2Q4EI/vdXe7ptgnxU8/QudjawqL4cRzYGD3rZyV2WJSbQwrA7jzPB6g1oXjjaeKd79AdkPYSP/sTmOtaFWIdRu6lfFniMDAfcdw3OmsIWrutt0rTTvvT8gq9U/iHoCcfXSSGDP3cKE7V2TTLzLJrOz6NAOAElM6AqhjCe92YI9HYEZ9inQE5+VsbJKLxfwRNovYZ4zjeb9tScapuxnafSibalzuYmvpcHIJe+mJKZozK+PvJ9l+giNq0/rH6VkYUwDjNqEBk9qWJvq6pDvsttUFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dceee3-a20e-4a74-1f16-08ddefa90553
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:58:57.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HewSxrrsZYRu7N9YiieIaVg7Oao38NXz+j2tsudbY4hZJ49X3IPe99CSSY93p9unsS7IenQfPSlpJXDOK4a3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090138
X-Proofpoint-GUID: Zco3XGbg1y_DT4WDZ1nHPKWw9T8yB2qC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX59Aac/3igQg3
 BxuR1XfXvVbbNi2bolGRKM27VJJzeFhvJ4sv76kMtCLD2ychedtqv2I8brv1PK6jwQhSQDXmAWy
 seXPqIR0lG0oh5HDDyom8t9mECHArYDQaGmqjK9zxqX5WYpdpmkZ88NDGWGtr7svEqZDv0Gu+kD
 ClefeHl/Rv6gFIgdwr7ujGpxzX+rN1y6NZGafXmz68A4YeCA40p72R82a0egjmx8e+atIbg4hKw
 MxlQS80Mrm5NRP9n3v/8VnyaMuJDMzB1MFK9OmGQnsb6vtQFZlpeK1PGSXe9wFTn5QlN8J7CATa
 yKjiOf/1OugEQKkxePbYfA9OOv0/pMCoSOzxP35evWWWD015nhuUjuD8D0Ls4LRYRWxUs3JMyro
 Mn5ItADI
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c03360 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8
 a=tA7aZXjiAAAA:8 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8
 a=Z4Rwk6OoAAAA:8 a=OMhaNCsbRJRo9K5OWVoA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22 a=kIIFJ0VLUOy1gFZzwZHL:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: Zco3XGbg1y_DT4WDZ1nHPKWw9T8yB2qC

On Tue, Sep 09, 2025 at 03:52:35PM +0200, Greg KH wrote:
> On Tue, Sep 09, 2025 at 03:52:14PM +0200, Greg KH wrote:
> > On Tue, Sep 09, 2025 at 02:54:32PM +0900, Harry Yoo wrote:
> > > Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> > > populating PGD and P4D entries for the kernel address space.  These
> > > helpers ensure proper synchronization of page tables when updating the
> > > kernel portion of top-level page tables.
> > > 
> > > Until now, the kernel has relied on each architecture to handle
> > > synchronization of top-level page tables in an ad-hoc manner.  For
> > > example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
> > > mapping and vmemmap mapping changes").
> > > 
> > > However, this approach has proven fragile for following reasons:
> > > 
> > >   1) It is easy to forget to perform the necessary page table
> > >      synchronization when introducing new changes.
> > >      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
> > >      savings for compound devmaps") overlooked the need to synchronize
> > >      page tables for the vmemmap area.
> > > 
> > >   2) It is also easy to overlook that the vmemmap and direct mapping areas
> > >      must not be accessed before explicit page table synchronization.
> > >      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
> > >      sub-pmd ranges")) caused crashes by accessing the vmemmap area
> > >      before calling sync_global_pgds().
> > > 
> > > To address this, as suggested by Dave Hansen, introduce _kernel() variants
> > > of the page table population helpers, which invoke architecture-specific
> > > hooks to properly synchronize page tables.  These are introduced in a new
> > > header file, include/linux/pgalloc.h, so they can be called from common
> > > code.
> > > 
> > > They reuse existing infrastructure for vmalloc and ioremap.
> > > Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> > > and the actual synchronization is performed by
> > > arch_sync_kernel_mappings().
> > > 
> > > This change currently targets only x86_64, so only PGD and P4D level
> > > helpers are introduced.  Currently, these helpers are no-ops since no
> > > architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> > > 
> > > In theory, PUD and PMD level helpers can be added later if needed by other
> > > architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
> > > PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
> > > we introduce a PMD level helper.
> > > 
> > > [harry.yoo@oracle.com: fix KASAN build error due to p*d_populate_kernel()]
> > > Link: https://lkml.kernel.org/r/20250822020727.202749-1-harry.yoo@oracle.com
> > > Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
> > > Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Acked-by: Kiryl Shutsemau <kas@kernel.org>
> > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Alistair Popple <apopple@nvidia.com>
> > > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: bibo mao <maobibo@loongson.cn>
> > > Cc: Borislav Betkov <bp@alien8.de>
> > > Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
> > > Cc: Dennis Zhou <dennis@kernel.org>
> > > Cc: Dev Jain <dev.jain@arm.com>
> > > Cc: Dmitriy Vyukov <dvyukov@google.com>
> > > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Jane Chu <jane.chu@oracle.com>
> > > Cc: Joao Martins <joao.m.martins@oracle.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> > > Cc: Liam Howlett <liam.howlett@oracle.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Oscar Salvador <osalvador@suse.de>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Thomas Gleinxer <tglx@linutronix.de>
> > > Cc: Thomas Huth <thuth@redhat.com>
> > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Pedro Falcato <pfalcato@suse.de>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > [ Adjust context ]
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
> > >  include/linux/pgtable.h | 13 +++++++------
> > >  mm/kasan/init.c         | 12 ++++++------
> > >  mm/percpu.c             |  6 +++---
> > >  mm/sparse-vmemmap.c     |  6 +++---
> > >  5 files changed, 48 insertions(+), 18 deletions(-)
> > >  create mode 100644 include/linux/pgalloc.h
> > 
> > Can you resend these with the upstream git id from Linus's tree in it,
> > so we know how to compare it with the original?
>  
> Same for the other backports, sorry I forgot to say that here.

It's

commit f2d2f9598ebb0158a3fe17cda0106d7752e654a2 upstream.

Sorry for the inconvenience, I'll resend it with the upstream git id.

Thanks!

-- 
Cheers,
Harry / Hyeonggon

