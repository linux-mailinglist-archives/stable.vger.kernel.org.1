Return-Path: <stable+bounces-94466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE28A9D430A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 21:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0852862F0
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56BB1BBBC5;
	Wed, 20 Nov 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFV20xdf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ttSmj13h"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711B1C1F36;
	Wed, 20 Nov 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134485; cv=fail; b=oHMG0i8gOMI51meHxLUPXI9IYQWLmOVbSt4dmjB3MmvCg7JVIPmDxhRI4jFF3EwumxQZizpx31uca2Lb1DV2UfMq5M2qM0wzA3BSSDELi7Svf/RaZti84YtDJoTHszaPhzBlzAopuVdVeIVameZyaihO93iwCegJRu+xOXWt+1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134485; c=relaxed/simple;
	bh=6lZFydvihcVF2eV+BkfPDno00oJeUF7JTLEssRLopeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NELLvrijLxvMyUHjlcgFfk/pY3/IsLtFjVOlUpw5+Z0d8pEngKlrRn+Ts9Y3e0E5fryRjDyr7zPUM6SGLm4rbxzBDVxzTNwzu68Qrge+7GtJrrdC1wuGGMW7h1zs/6H/P00OLY+FSBQdx8hvHV1lmlJC1ejYImNZCXe4MRnD+Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CFV20xdf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ttSmj13h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKKMe1l014550;
	Wed, 20 Nov 2024 20:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=QLEjj9tDd9whF20n3V
	sG3oLNo1V6yY8lKLH0vuVx4FQ=; b=CFV20xdfbbqNT/Psm5ixVf7meh0T87uvc7
	EOq+8mlNiBztZLIBJd7AkbyWUkFmEXLWVH1ZEpMDnUAJdtd5LNLVttIRx80po21u
	uSOadLTUvloUWmeVLfKrQ93pdKtXwi76vu32TEWAfhXBFwXBEX8q67kAW97MuTMU
	k+b4cKXJcm57PcLkmOTBj6mv582A+GKi8Wh5ehiU/DRfabCiyaMJaXSX33nodM4M
	SbgR8P/l/L0Sx45+vwwywYTRPAOVYRS7qObOWz0HMInX5J8pzXdY9yiYlii6dh7o
	mHnKZXeMJ8R72fCqTdxlI6NIlTvnrkGxoNIxs+zeXFCzVhvTRtsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sra15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 20:27:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKIuGIA008968;
	Wed, 20 Nov 2024 20:27:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuau15d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 20:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9m+ycHiFMngtKR2LCC73Yb/abEtnYDiA7Jo8AIUwGZ550FBAcV6NFJz06OudV0Yw68bXC/Mv0s7q/a29hBkacYlmXmhsGbIUcOTO114/FtOsn89VPwVPStT85ydSXtNpDA0YuGA1W9gWO8hiN69mp6UghRIq9gKCLEK6i8sJ7/tN5k9vQqwc8o+cJj8H+52nPjgh1vZU1rN6arJPkQIbQamqf36AsttUbMZI44BU+xzL5WaslSMS6cQQhO5RtKPWiY4x7R3RK728HBxCs9OdHHa+ks6Msnn8s8C6VGL7jY9p6x35WVp7jHWUJPT9Cx9BsKBlVm8d7jMRan8BZwVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLEjj9tDd9whF20n3VsG3oLNo1V6yY8lKLH0vuVx4FQ=;
 b=sRmItbyXEkEGzuNYwLBiKsb5+y7WmTUgah170FMp0we1yckIDtaPuZqFbPJQSbH6qflTtGjGgiWglGuDkFjU4U8mlO9R4y0jOvoJyISMLXklKNy/B48dsuzhveJMZvxo0jrDzkDKqxANfT86D8qO8LvgBO+V4nAr1Nn7UnjIw4tOJaVnOJ4gsYVYv2NDqOITp6JBpF91mS8kVJWNDhhViC9qCoeW9mSGlFEvwoAnw7JYBfgO8hR8Us+wuiBR2vAmJyp/8+ZeypQi+SDs+YYHG0YCnY/sp7Nf+TLNHzmB7ODjIWlJojiwE28hCePSTc5JxDbXlYg0Z7giQRyHZ/8l8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLEjj9tDd9whF20n3VsG3oLNo1V6yY8lKLH0vuVx4FQ=;
 b=ttSmj13hFgTqWOp3X/5lhw3ONDttqDZMxdEciaypb+yIfrwUR2Hc9Fgicb57kvjlYVtglHhvyVWgLhXkr8U7YHayC+vuXdZWSYAiK+NTmviU0q3TtXN/zn8Bqxacl8gymjUmAGfbJZES490C6mtl6ATnW2L+tFbdavghp3SEGj4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 20:27:49 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 20:27:49 +0000
Date: Wed, 20 Nov 2024 15:27:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v1] mm/mempolicy: fix migrate_to_node() assuming there is
 at least one VMA in a MM
Message-ID: <lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>
References: <20241120201151.9518-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120201151.9518-1-david@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YTBP288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f54320-2de4-4e10-c57b-08dd09a1cd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jlLLtFQnluuffcIspk9HYV4SWlz+LMkCscU3KzJLCk5B6Kp2tPtx5n0QPT+O?=
 =?us-ascii?Q?8DdnlvDfks8MqH7r44U1a7ZDjjVdh/+Je8qpqclbjqAqU7e4uOV6DeAY8Faj?=
 =?us-ascii?Q?dEpHmQ+M6oK6I/qacCNF9QcCbSQMKzA7qxmXFDGiOgOVwIQZny957Em/SqjH?=
 =?us-ascii?Q?KAz8YLgYVoCQlOt8OJ5rUJFSv6n3Fsog68MuY5i2BpyKzZxbCWzQUaCUJak6?=
 =?us-ascii?Q?rDcz7bZf5X7t1VN347sROp7zZ+8q5ZpyOkVXLlYdBq3TNlXAk3hqBQ+yxhrn?=
 =?us-ascii?Q?s0zUN0J70AnH4uT4A9CqEcaNxXvk4DHBzaQxX6gY+4Dkq0TB32ToKAfmADm2?=
 =?us-ascii?Q?tU5LH+Ki5keGIshpv04ZFMbWJWMccEiNmu6LSsTHZ52BMy2kD5pbI8lpr1F8?=
 =?us-ascii?Q?js+0akO1yeeThGX+J5upiDeUDD8+twLuhUuzmFynjv+J/TeTrg50MJ8lsQSV?=
 =?us-ascii?Q?kfd7znLkdc9NGVfLwUIwDNOQ8hzpnirjbp54qhJILfpgC+gcDH/e0ZMkWaJF?=
 =?us-ascii?Q?HYBY9137IDwNQ7iMKWY6eBzR3LJvokiBUFE1CK7orVj1cLtmS1r8KqkrskaU?=
 =?us-ascii?Q?kMLc/DV2lsLHziNlRRrhdLlfLtstHf9SQsLFbEbv9KtHN1AMgY4K9wYqhzsE?=
 =?us-ascii?Q?n4NBiN45D+6txRI69IuIdTJQoPUnM5Og2ldnCMz+pqlOK9ucHKUlYlKqw/Ky?=
 =?us-ascii?Q?UIXehi41LcZWAhMaWbsEkofD8x9b/Iy/Hbkm0+WWZMEUfYPicVpbr6N2EAdB?=
 =?us-ascii?Q?0ySw+0oGgWVhzC6z6FdLHlaW8kEpwU8LPSGi+gA152UM63fvV5HX3q6N2Xxl?=
 =?us-ascii?Q?VSCy3qL+sQ6Fk95ZNdGS2yQUc4DhW6RokTDJ20tsO0SzbC1VWwPghbT934Yl?=
 =?us-ascii?Q?iMMeP08L/f0FQaMvz8TV9aHU/np9Civ/bpk2I2agkvNnr0yxL5GzhPT++yFH?=
 =?us-ascii?Q?lXnWGXAOEHc2Oe2twngqT50ii2HRNuQ1Xce4KR/VD4pgoi2oKetPFy6T+Cmi?=
 =?us-ascii?Q?IqtryuRIsPIBEq7meUSNSbR1DOPwXcG5pFkpLq/GLS1tS99Hqp88P7kyqyul?=
 =?us-ascii?Q?tlLvSdmq8E48T7jwfUC6V0QkGc+21aeIprJtRd8dJ7szuX3hmnTWBpFq2H82?=
 =?us-ascii?Q?excw7xAEBFaLonQeBGI7gKi5bXvEhac5Z8kolgK1/djnfgrX7qJpHePo4TyY?=
 =?us-ascii?Q?Wbj14gXtVjHYMveJK/Gc+V+ryC4tkew8cd9uJei//3nbrcHTMA4gwwZc4OFi?=
 =?us-ascii?Q?5IlYngC69W3jGaYuRgX3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TPfrHOmIkmYGMWLilzGVAjcxiboCXtAuRUhHVheiVMEr6EMLtLQ7cajUMVU?=
 =?us-ascii?Q?GGeScTc9XkS9XsnMEbRv7Atai2W/wuizmINtTZu26ecRbhdhHjELrXH024j6?=
 =?us-ascii?Q?mRR/fO7go8VOFlEtWC7ndAKPsBGxtG8hlaVhggheMtoKz9CPO/ahEi75zWO4?=
 =?us-ascii?Q?qwkF8KtzXV76DBUen8yn8IJrBZFvJC/jXhZMXfnUEVhMO8E3PhR66KMe15X4?=
 =?us-ascii?Q?HLs+e+JfaI8Wt2sTU6yieplCCzJsp/SOAxhJe4Kvf81img2ChCzWSx3ATAwu?=
 =?us-ascii?Q?6P/aNRPFIYiZDE0F8ZRz9pC+RC12Ox8Fd+E79CCV4K5iMLnli2pxjUghh0U1?=
 =?us-ascii?Q?0Z8OYeo1DKbIvLTf/0W99yP1ydrgNnTMe1jPEHsFmH0w6ptrxYhbHcNYFbmm?=
 =?us-ascii?Q?OoQa2FueyH9GSljmjDElyMBWCJSv5hBSZuOf/zMazBZAvuUMPgZXgbpQSlFv?=
 =?us-ascii?Q?0UYbWHveqBUGhFGXCtMPodpbZYKvkxZptMqejqKsCZRXeX4MOMBxlYt3fdMR?=
 =?us-ascii?Q?0H2go3uQ3SIBKdSIhS3d2hKqxZJv6E8z7Nn0e3VpAFPQl3G+lZZ1nzY7UwaR?=
 =?us-ascii?Q?WHsgpVH3Lw/Y7o6RUrDxIXiyYOFr86xxwo17AEjFmUYYPII1Exol223TuqCi?=
 =?us-ascii?Q?YwIfxhA9sYo+eJdy0lKO9U977WXQFMIgerNHysFOlOJdEg1eDnT9FieEv9OK?=
 =?us-ascii?Q?IyGLYZDjR2M5yS0ue2XMNNLQjtkimu+wXeyMALOiMfAxgRon4K5fJbc945gb?=
 =?us-ascii?Q?8r+LHGBfW4c3T0pX2AwBq1GAEfU4gyc8DkmjHxoZjiylhP010kCL3LS08gg2?=
 =?us-ascii?Q?5A2nAkrbJhGMqYpesYuAycpRLUuWERvnKYnmkNt1+nBjXr2Ve81jcmXoiSGA?=
 =?us-ascii?Q?+weIm/AxUjlTgB6zLAp6UgJ+LXLE+CRWIYIUKs7eQMhXoGei5dwMQBZzqEts?=
 =?us-ascii?Q?Q1smkJ+5E64F3Jbki3+w923bD7dAPWpC8n6fvXhF360RYKhEuFEkX82wVDCx?=
 =?us-ascii?Q?zJ5A5+Nd+YkpU1woNXyffb8H5fNOK1c3oREB6GsITY5n5zQRAEAwYxJHLeph?=
 =?us-ascii?Q?4JqJz9NDoNq9U3Ogx9YW5gFD9g10Hnhf2v4Y9t5P1T0CXZLV8o0YlVeSK/F+?=
 =?us-ascii?Q?Jx8SFQ7Khy5f0rdFZFkQNbHdzQapUlTKKwbaXDQxuOYEnizQmQJ1zt5c6rrM?=
 =?us-ascii?Q?dEdvAPzwPjzpgT/0OEzmiFT9tWy1byp1p4moWDD1O6eQxEhAzvq03ybnyf+l?=
 =?us-ascii?Q?j525Mjf+Yu/w9lyKd/cK5d6X9HNtKFe2j4S/PuH3Cnxy6yRK912X6mzg11pf?=
 =?us-ascii?Q?OKl5+7XPsMEZMZouRofGrCPf4omc0U3UorjE3NIsB26dYYLW15J3z5+7Gw/3?=
 =?us-ascii?Q?NWREJddwa/u2QNUKTlhZNoAMi7XO0vLrnJFlQRURBnIHF63h5D0jQhHmmmHH?=
 =?us-ascii?Q?4Mjr8mqbYMJsszVuE67en9Y9ZdEDHify/oMInoNObJJv+GfQBkOb1Jq9zyX7?=
 =?us-ascii?Q?Kn/F02AL5vA1xz2X5YYWkYh6sRMADa2c2gcAmUCHmSRIa+0fzjDzyx1uXKtr?=
 =?us-ascii?Q?+eDi9tmADO/OSwOhVUZJM2SrjOVkc7CEDoQfXMg7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f3faLWQWI9udcJXS1H+GQFEB9H9PItjBod48bIu8ARJW3asr1J7PDBqtS0+1JQtLlXQGbM5J0hfJhoF9QnQtmzmGj6jKY1yvs09sqV54Gi+sm4/GABd0+tWPy4/qDfBnfesIiOW9VON0P8nBytRUfm8dRUxtaQZUVzJPfcN3Uri2SuLoWl/wPuURPRgQEJpeygy26O3oJuwhME2LO5UeWbSY9a6yMjoHGlYKCiD3gvhpj0bVjykl8Op9V8DV5jrfGPhtyesCGFZWkkz2+P1/ULWlJ/7lP9xCvkBFBXQSFn69hZ2DJ0sGbvBBQ8tausV1iu4nPLjUQQV/MAPI1ta7drPLTAwOoriL7nv+6jPvAvoFDDg2/5yaNs3RNEUiK1VK+dKb9z3lcjlAh3DpYHR/coERzrZqXSwJhKMDNCSPu/v0iJA9baNNrqyIs8BL+FrzV19Iqdjp13dWSqZEEKfKSHAw8YuVV6N+o+2q0XogJimgjPYD8dsFoOigpeHUO+MQAM3HaGOqGCcADeF4h6N2hEMJf3+NjGsdKUZXaYCJYSqq/5ooRmEhCCitEUYm6cAVAXPBFMZW+lEu1Qb4upVkHwYbH5qGAD+L3DI4bGpd7vo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f54320-2de4-4e10-c57b-08dd09a1cd3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:27:49.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNF/Ej9U23mRzLKL+viMuwVAZ/dIvLeFM+sJgr2/KEkBwzg3/QYWP5aV1uI6WrZKtEqLqH9fyVrTgIVIKw3FlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_17,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=867 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411200143
X-Proofpoint-ORIG-GUID: jETevOHld9il5iSGqWULTjPNQlzAOWib
X-Proofpoint-GUID: jETevOHld9il5iSGqWULTjPNQlzAOWib

* David Hildenbrand <david@redhat.com> [241120 15:12]:
> We currently assume that there is at least one VMA in a MM, which isn't
> true.
> 
> So we might end up having find_vma() return NULL, to then de-reference
> NULL. So properly handle find_vma() returning NULL.
> 
> This fixes the report:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
> RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
> Code: ...
> RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
> RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
> RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
> R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
> R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
> FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
>  __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
>  __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
>  __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 39743889aaf7 ("[PATCH] Swap Migration V5: sys_migrate_pages interface")
> Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/673d2696.050a0220.3c9d61.012f.GAE@google.com/T/
> Cc: <stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I hate the extra check because syzbot can cause this as this should
basically never happen in real life, but it seems we have to add it.

I wonder where else this is could show up.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mempolicy.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b646fab3e45e1..fbb6127e4595a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1080,6 +1080,10 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
>  
>  	mmap_read_lock(mm);
>  	vma = find_vma(mm, 0);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return 0;
> +	}
>  
>  	/*
>  	 * This does not migrate the range, but isolates all pages that
> -- 
> 2.47.0
> 
> 

