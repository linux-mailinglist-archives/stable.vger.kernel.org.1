Return-Path: <stable+bounces-83383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755F998E5A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 19:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AC21F247F0
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196519B3E3;
	Thu, 10 Oct 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dEaMjnZz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H5gZ1T6C"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6418950A;
	Thu, 10 Oct 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581516; cv=fail; b=Ym+M2UPM2C1cdZKpCjuJpONZqn0VDSw+heTa6+LCo2g4Hl1USsr+EOLn+F3n/dtc/rSF5pCvxQXVXBerJRJAJBztOTih6K/QnrJv9D7UZjUVdm7+8WjmQWHOBIsPPVI5CBwAyJFuF4hzYQ/qyzYA1kzUbuoyLwZONbTYi1BhUso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581516; c=relaxed/simple;
	bh=numsXl8yztczp4XAfVg8NajFxX+HU5m0oCB6lSy/r6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kf9+0eADcROVbI7gsWpABtpVpdy9etXDi6g9kus5/sn8JGFpo9Ic7mjaGv3RTNAzCYrlRF7LP3C7X4ppbrx4JBuFVJTt0z6Ec2jLeO+i0SytNAuQ1oLxSVaXeSPm16x0xICxXu0lXQb+ktZoKdDNBSf2Fq0Tt2aTqnW8KXW2yLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dEaMjnZz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H5gZ1T6C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMdI0022955;
	Thu, 10 Oct 2024 17:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9VEXaieLFL8o8TftT4
	6wJnCkbZ0qA/C2VN7kManWSEA=; b=dEaMjnZzX1UOZnPQoT08W4Z1hezW++E1t2
	Dadbgq4XLq57hKLEIXcXkBNXNWOY89RAmT19Jvk11immUI+I9ibubVCUJoRP6zqE
	u4GQklfFbfAfe6/7QcQFUTfwye7ll2EFPgv8GpS/lsi+f/OdXViTh1s7OsAVf2H6
	ppjEGA07MFJEUEvNMYjE8Tvo8R9kmCXQ7WN6pgAjdSNh1av+53ZF0GziMlyTjTum
	XkNeMg2OLoTk7jTgWrD0qS0FMf+SOYz0y0yrZSRiUIkYpz+/xqQYm5h2uHeymjKu
	nFm91UXa7v9zpi/vGOsYxP2eSVKDBr/bpEPIPnaKhj50qxf4prSA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyvbcd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:31:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHFSUA017131;
	Thu, 10 Oct 2024 17:31:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwgpcrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIxqYKTo7bkrXqYvPs3imQp4njR/3UTryfSTUigvaw2UZZAQ7LsjK932v9ol/tpQFe2oDRuwa9oDZv2AhieKSaa7yAHco3C9F4X1fANIap4/JefVp56MFodi9qguiKuQ1WytSp2024uARYNwssHMvxp6v6eK8GRi6vFHzsLVSFl0eamgoOoUb0mcKTz101HiAvOz/CnvzzB9Bp81Fw3qmd/h/rW6ZW/2UulC/05K8olh7JYtLoECX1o/x51BTITMGT3uaifV27ki4yaeQ1o3/qs/owSUbezDn/H0h84wFmYf9j7qX8PNDlkNZvBqQ9UiHj1LUiLKVCZdvu/XyYObnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VEXaieLFL8o8TftT46wJnCkbZ0qA/C2VN7kManWSEA=;
 b=lr6P2cc/begb//EZwYRRvF7KLP3s+U6kqLeQq7aiNJvTZEQIXTCYpJajUazRNtYi5cutP77H2avrYveTVVDsWuOl+UQktwmh4ANDbueSWy4AYH+QWTc+8cEF0DdU+e2nnf5/C8UDIC2/0n2LsriU0rN6Ok7A4K2CF+u2xgOwVYrtVFbBEVrHKQ6PJh59M4GtEP6rLf8+Nxv0fGXqFiVnMa7hJsovuD+AfOxw1IrmNOJLo8gmrxfanWADU9Fkp09VKSbMV7lA+UALD1YL+giyWTW4u0gEiYw4KakcRXrdd1HUf5Ds1l3BHnXShmigtUl8ctL9kvGx2Hl7DFy7PbeUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VEXaieLFL8o8TftT46wJnCkbZ0qA/C2VN7kManWSEA=;
 b=H5gZ1T6CldgbySOVOAfBvXa4uF0JYB9h4cdSeIem1lPBPMdqiCGix90j6f0vIRHpPGByRpSE3WHun9PGpqaztTsYdcQE+eU0EHPSr3nGgfkYA/FnhrVVZ8rlBZ8JKoFg5OJ7mcdUL8UvJfkOQXphpyF+7kqOfcvIBC1Sh1Z/SEU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Thu, 10 Oct
 2024 17:31:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:31:09 +0000
Date: Thu, 10 Oct 2024 18:31:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Jann Horn <jannh@google.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Vlastimil Babka <vbabka@suse.cz>, Ben Hutchings <bwh@kernel.org>,
        Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against
 inaccessible VMAs
Message-ID: <de4577ed-8794-43f0-8d8d-980abeccbf57@lucifer.local>
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
 <202410090632.brLG8w0b-lkp@intel.com>
 <f065ca1a-473b-41da-998a-cd51ae1d201d@lucifer.local>
 <20241009140822.0628a4d09312cbc19d73c6e4@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009140822.0628a4d09312cbc19d73c6e4@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: b2393ac1-b615-405d-e773-08dce951546b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WwtgrOdnRmmOl4krZ3Gfj6QgJXjUux1hcrdRjlAS8d9XjX9+uMc8y7qyYv8U?=
 =?us-ascii?Q?UUMlqsLN0PQQ9Pg+iky6WkhJWDa8/OH/B+sXX8hSktcY7pJNW261qjPVUQJv?=
 =?us-ascii?Q?faeRShgTxbtrN2WxBtMpvoqhwQ1I9ZMlonwfXbOj0shgu6Ybvp7uumYpTDYe?=
 =?us-ascii?Q?wRPLs5wsDLqCWggdH5xt/M3laXwmcRzYnCCwT7sWDfx9Fcc+QKwOt85h+80i?=
 =?us-ascii?Q?Zht1jxL723VbowF07fum3MhOIwZhZUw+YtnAd8RaGCGhQwCI7X2l8HzLvImR?=
 =?us-ascii?Q?OTJy1NMNyCV9ubXEZtvNAXmMdgJGz1urQVsudKYBbApy8dSbtRcXnx/glrgh?=
 =?us-ascii?Q?ZlEgHZa8jqbROOXNOBrlf0v7rHC9uXzFfwYn3e4MQS08hCfjspielaUAb3I+?=
 =?us-ascii?Q?4oaehIRVCq48kDrJTshJ6p7e0Jqd46twYZ9JUP3mAQPuEjSRChoWpan6uKdG?=
 =?us-ascii?Q?S4DhyU9s3EVUOoEj3NHa9uWhF92/mVCtRVpHePuKfjjKuiEnW+xJvpKCUrnU?=
 =?us-ascii?Q?2c0N5qrKki+E9QQi80FZsDwP1ZczDbiD3G00+e7LRlYZVQT3TjD09bwrkaGJ?=
 =?us-ascii?Q?VuaIJRNEFHMDa60QEJqnuGzcqPoW3WkI9PnExadZ9n4/7TUPWUBxuhiczyIU?=
 =?us-ascii?Q?b/cEL1C4t/vQV31K/eeukIMDJEnx2l2phsCnZ8VBCJPnPScCyR7E2CSZtueh?=
 =?us-ascii?Q?IHyWrIQIymH+EgBRLhOn5H9b5xsU+rKisk+GXyTjhh/OoXzMFa5ejNqATc2M?=
 =?us-ascii?Q?zHoF1HvCrIdbWxM8X7Xfcsm1ldA1XYguXKBpa+5hiK2VlcqziSHWfZQFdrg6?=
 =?us-ascii?Q?e8FMxNgDlf0ucSatTCJ7h1jvIRWwOO4XAVGduzCHmCwg1nUo7S0dw77G9AJ4?=
 =?us-ascii?Q?suSNltBqd/PLRwQe3GYcQBG2o5DlPewsndH01ahnaXjXutMnbbFVWPifRh/L?=
 =?us-ascii?Q?1Lgo6h4jFvSDd2R4anV4ftL3mm1MgLw7caZZMDdOqwCWqq+s3quE79tmrc4G?=
 =?us-ascii?Q?18g6ooyIAxuSm5oPiqSkhmKT8J+QrpKYJNkLibiqq47t+WAAiBWE1ZKsQ4rI?=
 =?us-ascii?Q?l6DY7JgsP7wXjNMVxOz8sqYeoerJg4qib4nhoPsAhZ7t7Is8QpebgF5PwpVe?=
 =?us-ascii?Q?ivQx1WvD8jKY5kK1Joz/XJakrkTZaEM6wvKFkcUnZa4AcEVQ1YhAIBn27EZ9?=
 =?us-ascii?Q?9G/UN+ggcC4i2EVUBufSdnhQfQBjYZmSGy0nFIZngimyDYx3GmPoOvtqf6rq?=
 =?us-ascii?Q?NO5AqVI9NSAP2dUftgjo2QJh9hNy9IIdRtKtlJ6PQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aWcUwROvVxPu6l5PLqPUzoGkZRTq6LTtDx8nt0UA/NIfqp+wZcURz8folHHu?=
 =?us-ascii?Q?/4wNy5nicShfkAquM7733acJN4TaKBt8o3HCjqcWW9RsRlQRk13q0ofV2Pg/?=
 =?us-ascii?Q?FGfraPl9/JVx0qK52C+LnLmBB9IvB+PG54Mfp/tCm6r8ScBeVLPeN4T6ZBQq?=
 =?us-ascii?Q?SpvgbdHcuNMlzFZNSflwiSpgdseYV8ORzlLnYbzkYNHrzcE/Ql5wYtr0xS6n?=
 =?us-ascii?Q?mcih+df1qyZBINnTv3N4FvSp5pqtYiCrCPEjz6WdVjmNTWKcBHy1mD6DAMXF?=
 =?us-ascii?Q?Ee0zJ2nlfsxsNmnN0QcD0hvsj4l+NjGpA8cB8toirp586PYGiXXrrCUC5aHy?=
 =?us-ascii?Q?bf5CL7X13c7E0aGhWf+zZ2qPKh1Sh+s24x2ry767o52rKwk0J+cq9KqrvxZ6?=
 =?us-ascii?Q?HVZOSczWWnrhQljh1cGcyvGYsvb1o9OSLkO54rVsB+/5pntbjAA51sETq3c0?=
 =?us-ascii?Q?TJaYMD2G3ZiAdY20+WGCk7h9ZDnicA/U2so/d28Ivwbb9hnzv9/Gn5AR1al+?=
 =?us-ascii?Q?Cw3nZUdn0P1EOV2u7g9VcV5Gd2WN5Z+THfcjAkxKVHoqHK3w3h699YTyN3AF?=
 =?us-ascii?Q?G+aWLEn4J/aBVUz9B0WCEd2n5+XD9G1h3xxQ+5ka6J5LN2Q3GmpK28hzPoni?=
 =?us-ascii?Q?pOsaF7W1QQaaJtfk+4aPjtkTfcNcuDbv+DfAuCjmaYNjsP3rP95zT4yG+UMW?=
 =?us-ascii?Q?IgzJoXS316F1UhaZ8xLkG2wY7BdRgK3RufqHOZYeoVahKbuc+RFqosEtCdGP?=
 =?us-ascii?Q?4dz+1Y3EDyB8BYusAR2psERQPEAOlQj5cl3Kk/K6aogGnM7ukmg/rzOiBG6Q?=
 =?us-ascii?Q?jj3NDSdkS3dLt4o9zZBbhY3jwrJo3p0GPRiCAwU4XLUBxtsVbDP8YZMb5RzK?=
 =?us-ascii?Q?5xVwXHLyLWu7+kshk/m/y/PVJB+M6Vl5XlPX+gIxQf8GCTWIp0y4yibFfC56?=
 =?us-ascii?Q?KnXbaNecjORbCht9BlsbXL+zasw/QOxJa0O4tNiP/n6ZHtZLw7TieWFkZvJ8?=
 =?us-ascii?Q?rtZO/dCicSSwfCK19YMWHZ8r44aI0Jro+PrSWgaSGPXuxRERKAjh2fj9Ao5E?=
 =?us-ascii?Q?tbIO3hLw7w5z95rXiDroA/rDOr+L9iUcj5/nHe1/FWXvOD4frHJ2BErUgI3P?=
 =?us-ascii?Q?6si7LA3E0gaevrOCg5xNVOdIcfOheityfFXK3Cyhw2oI0XC9FB35oYBr+VDn?=
 =?us-ascii?Q?KwDhficTKVKUakplD3EbF+0RJIaqC0xtTlXhaDz3zGIUJNnLx9hZaOi/L4AB?=
 =?us-ascii?Q?HLJvFlddYT7WI7lqul+tC3ubw+F3xbY0cCXBIg/Eh+/DdK4toi3YFAO00g7N?=
 =?us-ascii?Q?a2CFtL9LLODoQdsLb19EW+oTEMxbXk+nxUA0lOGGE9Yl77j6NrwJS9docaTz?=
 =?us-ascii?Q?0qANepPd98qbZQoDYQpIPgVwNwGDq7l6IJoTO23cUJVYMQ7nP7dGGNpP1iA5?=
 =?us-ascii?Q?DN5C0Sn5UcXMKW26MXM6H+TW8Kc5xgFejjhNKyKpZRXMKdZzyGHvR7kBIVug?=
 =?us-ascii?Q?hoV+fWq8BKB9yqGERLfhKdr+NuvaOGucLOcASQrhJwEjQuer4esIa2oHh/fO?=
 =?us-ascii?Q?bi5fVgOfqzDZVdWsg+JQWxhqmat75vWd4U/tEskK0sqL9W36pTYwnYhLd50J?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bvFUbJd38l+Kr0wlQEqIml5aUBk3WdhxghkoEaV+uuuYOIuaBrRvRddxJDxUSCW3rUYUaHc5GCfdkC+qLVzV8akH19JOl1Q0UnfPmIyHH+6KTomPhNzOsoV0xeVZgMxRwdY7F6IXqrmjQrGdJg4klaH7iy7JjHR+o+BObKhAilwxDh8LGIKFaOo3BOg0iNu7Ujrs/UxRi6YwCZfzgmCZ/ZsveAFMEp+Zp2lO0077EhjnxrRT8BsQVjrxUTSfRxEDcdE/vu3k9i68wAhCWC7hKLaIPqTAI2O8vdu0QrjrJ8xfiATcritT972nrAnPu/4ZnbWPt+Jjdb/RcPjOTDJYGrKWjopzBjYdTDlSEOUgqzMVfQ/QnrNmLBPFAQizZyk6KGIeLfhv1G8es06HNMog89WOmgkxAWNVTL0Q1rtibCSXS59vU0LVGSjtgPfCEPZdw2XqMoiAA/BoeohHplIe4cV5gktx5d5veJYRpE0jhAd8p/qZ/HnyoD50M1ZdcRfrk9gpj+sPbF6HnRzjuk+NXAXy9qCgAICfh3vxUoO4JyY76JMcqVGarSQ31raPTW8tRnLjZDpEFITUk7sgiMX/baGvaM/BHw3BKTg5lS72V34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2393ac1-b615-405d-e773-08dce951546b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:31:09.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eK8dzAIwyRaW1YqwNQh4gA9fyRRTYADJu7gPdDyJYjbyB4BZf4LrFTfLOd5yoH03iX3N4qUe3EJ2v1KkQTcmzGhSR/rw8esmAw2imS7W2Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_12,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100115
X-Proofpoint-GUID: DvgFpNKL1tH8qrgYW2SMEREyxU_D2-fZ
X-Proofpoint-ORIG-GUID: DvgFpNKL1tH8qrgYW2SMEREyxU_D2-fZ

On Wed, Oct 09, 2024 at 02:08:22PM -0700, Andrew Morton wrote:
> On Wed, 9 Oct 2024 15:53:50 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > All errors (new ones prefixed by >>):
> > >
> > >    mm/mmap.c: In function 'expand_upwards':
> > > >> mm/mmap.c:1069:39: error: 'prev' undeclared (first use in this function)
> > >     1069 |                 if (vma_is_accessible(prev))
> >
> > Suspect this is just a simple typo and should be next rather than prev :>)
>
> Agree, I'll make that change.
>
> CONFIG_STACK_GROWSUP is only a parisc thing.  That makes runtime
> testing difficult.

Hi Andrew,

Would it be possible to drop this for now as it is not clear we want to
take this approach and there is some concern this could break some things?

I believe Jann was going to provide an alternative that attacked this from
the mmap()/mprotect() side also?

Thanks!

