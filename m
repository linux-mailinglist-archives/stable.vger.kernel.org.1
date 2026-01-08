Return-Path: <stable+bounces-206392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D89D0516C
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D23E335EAD4
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC52E6CAA;
	Thu,  8 Jan 2026 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OsXQkZ+7"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AA284898;
	Thu,  8 Jan 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891266; cv=fail; b=cH2eXFCH5uk1TTtMrN7gKWK65mzhmTg5qrNv67UxIr16sdmn7FuuafL8iGuq1vWabr7c4xHz5wuwf20AbvdC4xhbGBRS5KEM7TCSNdynXqLWgd1GPinesh4JOVGe6QReGHBbRB/smrkAimhTWmiZgMCagmk4O6uGHapoNCGueIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891266; c=relaxed/simple;
	bh=wixT+/baTWbjLExgCk9rTXxJ/XLWSobHTQrSqF2uO74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cOlrsRV9d48UtIQ2LkgSvv6OBWEeiuRYACOkcZ9ASN3SZ/Lk3aWMRwhxS56HKXNdAm2YekzLZkW2SY0t3UC3Cpd1BAOFHdDHWtrtNG8mLNixAt3kKgkKjmKSUi4wSVJK2/gxr9pKk9r834YDzr4DJnsQDZu3GcCqgF8LxXwgaus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OsXQkZ+7; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c99ZwbCu9nugVpIBm5EtirOtXlH5UWlk5K73f4fTRf0HNfwfi2kUBIlzoiRC62+HTmYYS1hwRPk2JIwjRjJmfwoHpcir8jqcZwso2LXSCy5qC4J/D5SXOc2cAx82aU7hQy3TI0s7NJcJdOoDXuvLHL/pJn1hhxQmijvPlxi7Q6coH73ItbWH2niAUn1+70gPeNwsC+rNwod22onxPcCAjYot2+dt09apGm5v7Myko/IRtaVI63q8kLCtVRrN2FzmPudP4KGxUlQ3gVKzRTeBCrFfbNMnQHlrLf9U4vvPLizdXzkTwFzg/AvoJDkbce58DRw8pXC7n1gXqZj83+QaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wixT+/baTWbjLExgCk9rTXxJ/XLWSobHTQrSqF2uO74=;
 b=qPUhiK9BAy375iuRL4isNJtcDWETluEoFquAt3XFb1R19CtWwHTJSDZIcOnj9NMZmb6PbsN8gSgwnRWj+24Jf8ZvNujDrWmW0igg/Prn5To5bf1PW0rzFg94IYmo2hXHpIibSvLLq0J9N/QiBVoI9eHxw5T8ZoG5rVSVczfJ1y+d6qpsVMSza1d8/1Gnv81OEf9jMUc7TN6aQXasg14pAzTx0YYeZbgKAUqv7OcHVFWbkoVbByo+NJAT8ti+gniu9/RrOxxIKxSOohC8JZv3b5oAbaT7wjZsbumqQ3uBTNKghwcCtIpL+lxhOaQ1FJxPvyb+feDTgc1zY40rNri/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wixT+/baTWbjLExgCk9rTXxJ/XLWSobHTQrSqF2uO74=;
 b=OsXQkZ+7Yhw3MIYQwwg8JpFpCC/ltm06myCEFOCC5Jeb7ulT2zzS7Cb+4XCcG85MR0abK/t7zIAQLsQbkLSnfa8fR9Jiek/Id3AEuOb5n0GZ7xgo0+kXDu9q1lYgbgtt5fcsh5QeKTBI6Ldur3+yesDK5EGmytD9G59vxxOO9yfwX/fTMQsCOBSAfbvlrg6pYLB0SRwj1Z4+KkisGeX0fUiKDiKdvRbH4HwLowIBQQPZqy012GIzDfeoIDfrOOkrP494KgDEk3PDFyuMz9o/Iiz4dK+VXcH8QGIqfpXWwOnMAPsrnaYoOY/siE7sJ2mDOZbQjrozByTgWcL2HpBI0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:54:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:54:15 +0000
Date: Thu, 8 Jan 2026 12:54:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Lucas Wei <lucaswei@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, sjadavani@google.com,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	smostafa@google.com
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
Message-ID: <20260108165414.GF23056@nvidia.com>
References: <20251229033621.996546-1-lucaswei@google.com>
 <87o6ndduye.wl-maz@kernel.org>
 <aV6K7QnUa7jDpKw-@willie-the-truck>
 <7cd7b4f0-7aa5-4ca0-adc6-44d968c1ed48@arm.com>
 <aV_KqiaDf9-2NcxH@willie-the-truck>
 <a0fd155b-67fc-45a4-8510-01f89681d6fa@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0fd155b-67fc-45a4-8510-01f89681d6fa@arm.com>
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 01db5f60-7a12-4ce3-98e8-08de4ed68e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kCu95GD1i9bpFGFz4Oz2TMffwzevkp6h/uJ9EIfNc1oBlyhQFcpZtcEkHx8S?=
 =?us-ascii?Q?6JSLcNSaNhU1guFbaSBqA81WklLc+Xs/9q14tMPbbqOLFF8m6XbHoYuxG/K1?=
 =?us-ascii?Q?/8W/3FJIAW6cWKCuBBPD7lDP64eBFxTngqTxzKKPmdqI4jaDJSxrCdX7xZLW?=
 =?us-ascii?Q?leD+hPE5AZ1bOEbwn5qFQrk2iV/v5QGCeXEBFeY81UCLUQ3o8OumEbCIfmk9?=
 =?us-ascii?Q?KVhKyCX/P7UvDgHRmspE30qjr5tFjHPesiqPjYsf+Tcq4N04HUM8Epohawmq?=
 =?us-ascii?Q?ua3TTfJ8U41Lj0i39+/mehGymBv5F+5YfAv4CLidTM0Nh0r+5fHorZlyntFL?=
 =?us-ascii?Q?Iwkz3M0cZURL6J4N3vvB6pPPmV5XRaUl/vBdQakqDG+T0w8+RLjITQ+2oHil?=
 =?us-ascii?Q?ySQQZ7VTXNeDVD2nuN0Ry2dLu9s2y8bjFuwre2CJPb5mHtfb/H8nmrixUb1W?=
 =?us-ascii?Q?iQTFDXSxW6BOHk3l04zwDVvI8wYIRGUEsZuvdmdKj7XgQd/jMW2HZdM+N/hj?=
 =?us-ascii?Q?ZNi59vf0ZCV2pdwieYQJL4Odgbr+PXKBtQMSH1EtVJzSEyFkBWzTp8iwOpAn?=
 =?us-ascii?Q?HS7bFwZ1jUwQ22EOoChbSB85yZNdTY65QjpKrjo/maD/P/bOljesYb67R6TD?=
 =?us-ascii?Q?evbGscvF9lW/nGscc1GcA5W1v7IqF0JlzsUgLJGw20JQ4VW+m8he7ORBUiU4?=
 =?us-ascii?Q?yTsRLLl93OuiWUhkMbxaVU6hUxzawFnE48x0tLQezLPEFVoeter4nN3VsyF3?=
 =?us-ascii?Q?h05NNfNCvDGxtx9LdiitkiJibXM5ojcOcW8hWRW2OgPT+Y9n88yn6RwngxvO?=
 =?us-ascii?Q?aLerFeJp9ZRujSsogC2xXmmfJN92Ql+GmJPVSaFXNdaXu5clUPHAId0hXcQs?=
 =?us-ascii?Q?AXLVGJBBZohg6SQcv9Cjia9j4xmEQdB6eIRS3+yGHluRpTrVrF7XhI0N5ci2?=
 =?us-ascii?Q?T+QZdPDO229ICrV1Walch4awyeJh0OOsEBU1hJ9TRDS2myIWN1yUIVlNCqMV?=
 =?us-ascii?Q?FLyBLdKmVHkuAHyICm2o9QLuo+K+04swjqUpDVzp/ycwDZ3KxBSeDKjRMmef?=
 =?us-ascii?Q?xr7Yqh2yhhMBeQyIdAYzl/LBswf2YYU661UXoNAmxvBJANvZfWgN8eYVBEC7?=
 =?us-ascii?Q?1e5n9N9JPLe3RHhoAAfIYe4MyBJs+yEJpGy2ldYqBMtvEBrYmRwKxUA4+3GP?=
 =?us-ascii?Q?BKWWdpk/63jznShSdKchGMA9CC57VXA//IpK+NxTBqZOlSSdOToyocDc7UCV?=
 =?us-ascii?Q?yCiUFywRZqJ1y+ApV/AZKc0qO4CHcVbdv2IzD1uRadsJqBNSEE6aR8QyRtGb?=
 =?us-ascii?Q?SAywPyqzjanHtOfjChn37wPeTOhLeECQLol2OEyuIMl7Sgaf0jmvYDGMdYI+?=
 =?us-ascii?Q?NGU5drX2ZVJZq91iaRsxhK5kDPo3fe8Mfpqkq01wUsRHxID9dvcnMf4gj2YP?=
 =?us-ascii?Q?gv0BpxslI2aS1QuI7G+LFtZjQQP/CgBD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zgqkqp/aLoCIpp6HomL2OeyIwbqosOIoc5m2ADGFkSgnERwWbMkQJGwvHtM+?=
 =?us-ascii?Q?2HiVlvhot3qfhgcyy+0szYaAFLUpHIU45N4Sfp6yZ40YVETe0h3ZVYq6bUJg?=
 =?us-ascii?Q?pecA/W4wS9yROV7c1fQsyM50vr+24U6SAtJ70uebxdltqJ1dkK54u+15pI/c?=
 =?us-ascii?Q?f7D1uVEd2fIKG3YPQDxCWKTcXxS3p92RmdUFa7KWqJzELRVTCiUECpOppKeG?=
 =?us-ascii?Q?DpQ7Ofo6Vtg09yJf/oMGnG2JWT87zx3WIZM+Lr7qKRJDkBv2UeUEOLwkv/C3?=
 =?us-ascii?Q?aPdRbClja81Sy+G9glU3/jQHc/4vdt+24THpH+evTE0g9cThUgOMiYSijVM8?=
 =?us-ascii?Q?rh2L2hi2mpLQnd8JyVyhDZfDcaAPgzyRWVXcgQO48+aDxGnToNUw051VJVUx?=
 =?us-ascii?Q?dbImnMIJRrYy7NuzSPQkDvQJZiapOlOSZs78W0QSB04dn4jV6plxijahEnrC?=
 =?us-ascii?Q?iqKDlsngX91XJfIhiuM6tOtLIbFdD9tXXsEI6iXET6rOFY4IFzZ2+1waBVWw?=
 =?us-ascii?Q?eso5z6gxjBpYvoSo9rPkuGqKJgZjZlHubfIDSzenZQHjoXbvXNgtKDZaOsvG?=
 =?us-ascii?Q?sLTHplJUkqj76FAGi8zpGU5lBD8Z8tmOe40c/eyRxje9dWNAGXWz/w8veYca?=
 =?us-ascii?Q?s1GUQGSoyf1Vprf/6ZMX+e5VGQnuxjLhsoCRkXUwig6J1gn2iZEEDCuv4bad?=
 =?us-ascii?Q?mSEuQY+mCcD3YgOCwCPbtyZksYQtlnc+mEy657hcILcpGGtEA5EvOqhTQTUJ?=
 =?us-ascii?Q?z9qOyx9XZeLXTVQRC0IqyA+T8QqVIZbZH/x3EdJ2l9fo1T0WQJ4FVstvFTnq?=
 =?us-ascii?Q?6vPnRBYLwxLXicAZ0FPi44UJUvrkCVi5WIpEVe0RKbfKtX6YDME7qIEhQE70?=
 =?us-ascii?Q?mxxVmGKXvCdYD42U717WB5X97PvHfngAmTLsRgEXIfG8bEq40Qo5JHZmL6CE?=
 =?us-ascii?Q?fUPEwaifGWWUFXV1U4ktf6Vu+q9le1EJxVwt0Uidjw9O4jT+wwVCPB/vHhJZ?=
 =?us-ascii?Q?aanLW8npk4MhMTXd4oeu7t661SD4BaHV7L1GLGK+29H3BaHlArMR4LpXJZM8?=
 =?us-ascii?Q?qH9BfC49do44cwY3w30WB8L4PtvohmTa/ESUncONrOO1o/4A0npF1xoRwm63?=
 =?us-ascii?Q?Qdcat8y4Zv+QZEK/+nhYLxDZ3+CCVD+f2XLuChFduQgJCxvkxDVw54ETujKk?=
 =?us-ascii?Q?/HaKoGZonKdzAnNaZ7tR8i09JFeisHeCYYueakPdILLXxdb+f4glIyIhOFpW?=
 =?us-ascii?Q?RM+dmmgVAq0TuuwIXL3YzhwnD7oc8202DnrTELB3RMyLDr1IBsIv3rpzAUV6?=
 =?us-ascii?Q?cSkUjtEiV+QKG6qv5p7y0hgwZqfJcyu4drnqXf0+5vFtWPY7oQ7hPaNiJBu7?=
 =?us-ascii?Q?hP52dN5NuSd0SrD02YIlIoe+7c0Z+DBUaIN6WHXK5Qv8A9WMjDtmwL/RcPEW?=
 =?us-ascii?Q?2SoFr2uJQfXMbvgQA/sq9qnTqQWGUGoObTqHobqGzkR26XkFroRoAF7vUaV/?=
 =?us-ascii?Q?K7CpBEtgZIV8tjc3KVVquQNlUM470BDnJ9zZq/THqXATYXy+3JO1pb9EJ/zJ?=
 =?us-ascii?Q?7AiyR44p/x5W5L35A32fEPhErDDEy5gMRwfoZ0QWSMuKPeUhsbN6ya1232s1?=
 =?us-ascii?Q?pTYsYogP/kq00Fp3mxSEl7+S24Chiw4/WartXpwACKMLBbO4u17u/gtSOz/I?=
 =?us-ascii?Q?k4U9MEx2spioAw8EuqqFZb3z9r6eNJDVQCOWV7CykyRF/PpvDGv1UNIK1OZa?=
 =?us-ascii?Q?DhneMsEWOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01db5f60-7a12-4ce3-98e8-08de4ed68e29
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:54:14.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+oZV2YmNi59mPDa3QG2uY0sDs0emKWZdKMk31DQ75pZS04+LiLVId+drCRG6fkU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

On Thu, Jan 08, 2026 at 04:41:47PM +0000, Robin Murphy wrote:

> The point is that if there's a coherent interconnect downstream of the SMMU
> - which we infer from the SMMU's own coherency - then we should be able to
> make the *output* of SMMU translation coherent,

Sadly I'm aware of HW where that isn't true..

The SMMU is flexible and there are more than one fabric connection
from a SW visible SMMU instance. They can have different properties.

Especially if the design is focused on something like isochronous real
time guarentees.

Jason

