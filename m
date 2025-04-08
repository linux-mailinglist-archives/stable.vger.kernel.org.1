Return-Path: <stable+bounces-128806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0492BA7F26C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1318991AD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D224C08F;
	Tue,  8 Apr 2025 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jJgrbIHS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bLJXbLKy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA22744E;
	Tue,  8 Apr 2025 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744076651; cv=fail; b=W26PppRdS5jYJqcjK7csseEz0MlzlV/3k00uhL+mI96moi3WU4NuxsVz7y7OAinKQ/Awpl0zO5WKlq4MzAcGz7FjS+Cu7ixv2lR8MPFUOK8KW4Nodp6NdiD01nNT4CMNAfw6C54dvLNi+IB0zr0GEdSUBU6N0DQZuN57bmPQt2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744076651; c=relaxed/simple;
	bh=rHcXioCYKZp01dRMT/teIXItfSqjw7netYKUi+HX3kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CQR9IToqMeTTvpSUX4Ef7BwbvWbw8tQFTXBEDSU1sO69ZcCkwTOaW9BpyThC+lXNC5cIap54NQgtiTKtjhPtl7VWfRkgzHXEU4GHTqQc4XbFiKm851SiB8TIVUEyf5M55rrntMSTh/P+lQryMfRdkTAAMlNrCq/3Dr7VCqVfH48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jJgrbIHS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bLJXbLKy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537H0jVL028111;
	Tue, 8 Apr 2025 01:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+9arurvEn7ARzsUNQz
	R6WiHNOAjUlBjDkaET64tsNxo=; b=jJgrbIHSUCxI1cNep79O2IQHdQjnGN1sxM
	vKQ+yOZ1r8Hfnlb3kfP0jhhgj0DnnG26DfGZjzE9upeaRpwiKvnAUmP+5gfDDI5v
	NCRoy66tHgjiyGsmT5sUoBDUDPpQKV4drdFPZ1tL9VSRXjdLRe5yIH6mP2H08ph7
	MUqtMq8bezplfj6j1iPrsPx4ZJygnf5s/AY/6xq9S3gfmaJ6QfNdwS5+faQzPApE
	t8939DWnU72nxJAQtsbzfMlpaJWBS9G81kXI/IaERNwdgGOFgBMYhgQ2bAlSA9EP
	MM4MQZ1wiyIMi1YQaCp12dsOHuraSUhnt54Jtzi2l7NdP+plywWg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41buh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 01:43:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537MxTfJ016164;
	Tue, 8 Apr 2025 01:43:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty8k6an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 01:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVBNWGuJDKZMCnvd5/5Skw3tWU0dbpKwoQrmdneUFH//uejkNQFu7TJULMkcGEgQ884PNGI8OfGHkRMoTnyLGpZ2KRIv5aoFDLNhE2+5NbiCd5pCkBK0PKgRYzt4XSrlfkEoUyqPp3gsxKH5LSftcvwB+e+QT0bVD/dnJfZE+vahVxwKQe4svJdQephAOdpXT0CnW5KlTLOABNPbFc22fdHz/elmlWeplCRsZnZY62F/kVOadpY1AiTp/ff1AYlaPuthS+pAK1uU8bQronulGih1jIUQYjzEPk/9w/zHR3wLAKaASbuUDS55CKpl7GVfvi+q/lFODqHBetSCfcSJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9arurvEn7ARzsUNQzR6WiHNOAjUlBjDkaET64tsNxo=;
 b=p5VuQW+9nwApZfDEkcmWDltfXPh7FNw8KjQAn5qj1yvNaImHnFH9NBrNoO9RuMzJmhbRd2M/7DLpXamVSmmVNbrKX69pCrZKgNxvVUEz0HEmldrojs1E4wvp/JdNRyXUSLNzPftva3+tPWuTLXSHTugRwrkfTMLIba2H59b3K5KhE0MInQfjT595Eji+B+iB2kYCHothARbd2bU4iG+ororQn6MYhTm4+2cpn27A5CxlvHFEZUw9virFfhlFg2jnulyZBg21h9re7Ir45JTiTTYTlLkZA68FTH2oJlTYveLeF40KVDwPRgpQusYtQRAsRw5e9q9715KIm1NzJMfk4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9arurvEn7ARzsUNQzR6WiHNOAjUlBjDkaET64tsNxo=;
 b=bLJXbLKyrduSCjVliBLp78PnQOPNZXKgpVMWAiJAb/+z0PM2fafhDsn530EJYDq9HWjd6UKBqgxe3zJ25zMUNJPhVcIsBUg3DEHylGcRsbe9Pewou7Khe0NBqJ9EImVBhDh9I3wRoKjti9Yg40kX8uh+DJidDng22Y9A+FK5qpU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB5662.namprd10.prod.outlook.com (2603:10b6:a03:3dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 8 Apr
 2025 01:43:51 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 01:43:50 +0000
Date: Mon, 7 Apr 2025 21:43:47 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RESEND Patch v2 1/3] maple_tree: Fix mt_destroy_walk() on root
 leaf node
Message-ID: <mwv46z5wqetbxhrxgwppa3zj3ifjimjqkrlxu75e2byiurt7sq@mw4otg4rq4zy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
References: <20250407231354.11771-1-richard.weiyang@gmail.com>
 <20250407231354.11771-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407231354.11771-2-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBP288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5bf1a4-73cc-4cc8-05ef-08dd763ed00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYIWwnaMGrMmugwOlg5hdhHQVxBkFna2NlfmyPkR5RFwuBQ4ygYXWulvr+wI?=
 =?us-ascii?Q?wb1E+CN76kzV76plVSwHG98hjFDHPfxccdbEkWzCuw8ZeviHUwD2Icycyzmm?=
 =?us-ascii?Q?8VC3f9/DRGjNn8SyTsxTH+ozB1WwOGPmY89rSNbjYdYwvZoiw/6PmvqrapVU?=
 =?us-ascii?Q?0iHZQ2LbIrZZi+1Bc7qGhc1PbJmvauvALHwz5YB2jXnyt5IzKBEHSmMR+sx9?=
 =?us-ascii?Q?iKGQN05zRoSxJ95uO1KZ7k8HC41Qi5yMoNRuBxu87cYguqIH4PNDw00Eb5uv?=
 =?us-ascii?Q?eMEuAHXnQgCLX7yS/O4iyXrWRZ3gviq4JHpjOAZOQ7V9yEQSivd9Y3jtVR8Z?=
 =?us-ascii?Q?aGWMXIeOmZu/KFQggyj2bf/9oVovbbDo50giq9cd7zSLaP8kk4lkH46QeLG+?=
 =?us-ascii?Q?fkzoD4eWRXjF4393PFVPmy4m1F+l/usMAEoysfmBvDCJ3XqxTuANhUSDBnIB?=
 =?us-ascii?Q?+9thcEaXo6mbEAXbEGmFIS6rdudmmTowLbu4uHRWeu2ZnyLNoR4V8SmliBE2?=
 =?us-ascii?Q?lixMlaxIv3Jusz4/hROtlUGAWTikoHHGSZhs+UKStdoUQp2WEsxO0rfK2uO7?=
 =?us-ascii?Q?L/nsOXCGRHsCoh3YlDOsmMtzHtagpFNSnxBCbvuj6ovWWXslCBSsv+G2Lp+U?=
 =?us-ascii?Q?0gG3QDCmejR2UPX7EAzSglW4JVu5zIR6xanJlsQOh2bNPZanwP4CtkIn0JBa?=
 =?us-ascii?Q?58wP39Ymz5HDwIGwkYfG8D2zelmp2xz7erD3jFzQhYBVo8uXzfpQmLA6OlRl?=
 =?us-ascii?Q?eY7r4KMHg0IjCJeOP6P+ZUxFkodjv6nCpj52l5BK+dzVHUQ8MsjXQ9UD7utp?=
 =?us-ascii?Q?TsLqNHD7zRvG23SBvxwKwD3MKHdnOrgFRZoiU5OFxf0tIGpPhUbXMAc48jRu?=
 =?us-ascii?Q?P3PwF3uJTjZ0ZKz2rk7iL/3y0LWmh5AJc0/XV28nx8Rgm5zBIUqdvZvtyOXX?=
 =?us-ascii?Q?gJBLXFExd34gh+6BZDhkf2alq2bphnOY880LO3g3ondEEkTkZFSy6m3dwu+C?=
 =?us-ascii?Q?pP9ZNAiUvgw240pyGSsc+XsokhlVdaQwg9SpXjx7wXlrRn0zqWc165ub4pUe?=
 =?us-ascii?Q?rsvCA7P/Y8TritCM3j9Ks5J7yE+BBI5P+xaC1gLlAzBYrS0khhAkx7grBEGt?=
 =?us-ascii?Q?Oq3dLSvge/FTKyP8KWvvozE51j9V3MUVKyBg10K7EBZO0BZywj+39VJfVPz6?=
 =?us-ascii?Q?e8oCjg+INF2oeefFYGq3nhZ+KrJQH7A0oFE2YbeJp4JwCn7XpZE68w14qBFt?=
 =?us-ascii?Q?asCVXTvm57O4IyORBPocCJubyHxsHMjkTWTspG4h4TRElSprERAThYjyZE2f?=
 =?us-ascii?Q?O8CEAHNhmshYwAqa/OXgZSSHGd9ZBWXsAZFyEn8GY2QVhx7FI5V+C5PNN11z?=
 =?us-ascii?Q?FY0K8CCoqiKTuntUmDtnn8zf92YX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+CfOjx3elH8nWY9+6dxa2ekTt7fYzvGaucde8Gg+zTpucTBja88SytS0kPCn?=
 =?us-ascii?Q?9hP3cSRRUdOiXpAEp6kDIwgw+H0mEhKvWxgZG0QuxvNoZfN9hSpKxAO9rSrN?=
 =?us-ascii?Q?IYjZ6vX9Lf0JzruS4pyB4nrxxl600ELZxd+T9yFN70Ncp7uw7IaB9n2lOKU2?=
 =?us-ascii?Q?kJUjyaQ8s0LvtsmXoKcUGjSBzqoewwj47PNF6ajpPFImVESZYVEtnIbnY69g?=
 =?us-ascii?Q?//45uhW0HF9BEQ4Dv9IfEGGspn/vALoI4HmcNU6bG/iwNGajaqsJxCJk2M5p?=
 =?us-ascii?Q?3mEV/dMfb8dng5110pEsX1dd6O6WewxEmKpRassFcQ4/f3rmxRNJlBgCPTgy?=
 =?us-ascii?Q?ryQ2rGPYKWM/Eq51GgTs7iZR4hCS0YsqpX/hoeONw33tdKdUx8Z3GT4wDmV4?=
 =?us-ascii?Q?Z75i1YONdMSoBqWhNl7cRPZAM2wCWr1U+YeSBJWpFBomEPz6dGMjQBALIWQk?=
 =?us-ascii?Q?r65JG5imynKCzxrWKuJi4abD6I8U20oTzTaERRKX72paAcOSrMQ7Z5mia8Fa?=
 =?us-ascii?Q?0hdfNgrNII69IoAxpPvQqSVSLk/54VlCBD80jg2fs/GXoAQJwjQ4ZkdgmP/Z?=
 =?us-ascii?Q?vQP0/wW4hpLZTaX5Z+1YshF5RBCmhL7oxuSq+w9xzrceVycHq53sq9pl6LmS?=
 =?us-ascii?Q?99QDA3SYw7U+htDWc5M7MfH2NGCQLQiRmSQS3U1+pdiGUJAuga67t0ZKguTm?=
 =?us-ascii?Q?iHsz4w8v4uLPWhGn3edKCf0n+WKcN3VsVfUdtXmYfO+sl772lLIaJ5DfFiTa?=
 =?us-ascii?Q?iAjdPwNnHMQwKIXCzlAV+ICS5wgNEJmnCrklFQIbwAF/LZXs98aqiOMUii9B?=
 =?us-ascii?Q?KUS3UbHC7IregSHlmkHtBJowoz0TX8jCh5FUm0vmAXXglA0jXAFniK8EsBoI?=
 =?us-ascii?Q?3XHA5vGgKeCnenQx8sgehWV0VkPcO+wq7oU8DYf/c4wI7wviL2zop641gefu?=
 =?us-ascii?Q?HKrYrarmSQ3seG7IcF8J6e1BwgZPMJOYy//NpBHEAfwva1JG6itbtUboIebj?=
 =?us-ascii?Q?iox3WbiELOlz2OgqJkioBwQxAf0X90d/WwjB/vtmO3iNRCbinonI9CNA6L8v?=
 =?us-ascii?Q?/udileJ8lCPJE8e65pGKDkhh5dJuGIm7Zp3kVwEhBHujGPG3wdjSLumTMgiz?=
 =?us-ascii?Q?rOcMkO3TXR1jeVXhqHuFGD9/4pB9LzohH+imyDi+BO0lTo4jVs1NREGNFIKw?=
 =?us-ascii?Q?rIolarpd+Ntb915IevSuuZ7OsNbhwQqnZ0CabzgZragzAbSrGNRqil7Gj+sc?=
 =?us-ascii?Q?t9e0OElRe5Q0U5oRzQlPTiNzmX1C7FkM1K6s2ONCOlrtGqa3/NUhotZ+gwiB?=
 =?us-ascii?Q?gDiqbmRGIcHFK9kIAmFWPeh3h79XP9LhJlMET6+Ccl2hP8u6aq4h8ItWKGHg?=
 =?us-ascii?Q?bq5Q/I5mQvVOXNn0VIQ610pW+feSHmJP2OnGcpt/PpHSiN+ddAf1imMwfEBP?=
 =?us-ascii?Q?aYadPAHAAxh7XgzGvyNDIufTpWo+wqIaW6IgiRbh7K7G4WuBZoBqo4X1PGiC?=
 =?us-ascii?Q?sqFvHdwXqKNKlRJYLFUBs2Ge8XgFYpm88gLKF3VSXG8XHGBAo/6+erPfdVkB?=
 =?us-ascii?Q?jgQFBWDn6q8QkGKtqlWnvw1hqaxSi+dWoa2eK14C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DMno35cFrStIgQQ4Ay+dxHBUY9nNyqV4G9KpKyynhMHsvzLBlwxXBw4D6Ri1dVODdiPjIDfMvFq6f03O5Exr6MhOAiXLy4/cuk6yJjoXANbOl/nH42/5q/Ro0TI6V5YYnaUm8nkV3pdMQruF7xEG4jFQT2AjDXiOsJ6Xts/YpJ3ycjXfekrJor6rL5DyHyEX7NKhRUQyenw8RzSUG/rMpj05q8HhiXzTXgFYTNTE3SMS6ygh8ncdpgDFrB4VA4yvn9gWnYN+ctoKwhoJpnhSObnVTSaK2Jr05rIwX+T73AP5WHDk3gYjTcDAMQcwZsonvpuy4MSx7G/Ly7AiEAa9ZdU09cQb9q56N9Tf7DoPYMEgqNrACMNshtANR4egCsG5ilLMHi4OCht0flgNJwT9eN7pXOHpZ57b8pMeygm0Z0WyoPPbd+MPg3PfoTE4r8Blu7e8rj9WztgLkqGj6BnpQYoX2NKVq1nMMWKlu383lsMQvGf41YNWJ1/tJNB9r8/dertT6VWmPgcZl1aCwkyo3UqNbZKqEEa45udmZkjKKmeN2z892E4QwQP4Fp1pZ3KGXJM/sJrG4hckWKNpjtFBGHgF2dLXo7kFpLLKqZ6+Ruo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5bf1a4-73cc-4cc8-05ef-08dd763ed00f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 01:43:50.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNSzomE/ELNc9WqQC7WzDafbqnQRyvexjzefOjD+6wLEo73KHDQywDRcDVVWHyPxcqzkKBOdtPZrsceKE7LhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_07,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080011
X-Proofpoint-ORIG-GUID: nSlDu4XZ8O_qdvCuuq4Alc6bAp7aPRUb
X-Proofpoint-GUID: nSlDu4XZ8O_qdvCuuq4Alc6bAp7aPRUb

* Wei Yang <richard.weiyang@gmail.com> [250407 19:14]:
> On destroy, we should set each node dead. But current code miss this
> when the maple tree has only the root node.
> 
> The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
> node dead, but this is skipped since the only root node is a leaf.
> 
> Fixes this by setting the node dead if it is a leaf.
> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> 
> ---
> v2:
>   * move the operation into mt_destroy_walk()
>   * adjust the title accordingly
> ---
>  lib/maple_tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4bd5a5be1440..0696e8d1c4e9 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5284,6 +5284,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
>  	struct maple_enode *start;
>  
>  	if (mte_is_leaf(enode)) {
> +		mte_set_node_dead(enode);
>  		node->type = mte_node_type(enode);
>  		goto free_leaf;
>  	}
> -- 
> 2.34.1
> 

