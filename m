Return-Path: <stable+bounces-205079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550FCF8307
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A363300F88A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419A2EFD86;
	Tue,  6 Jan 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KFFqEu+D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A/at1HZu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C831A561
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700360; cv=fail; b=Q5octibK7lJzHr++tnYR5FGkD9LV6ppxu4ab/nCUVXTDb9uXy3qHlXHvf/tj9z3ddYmXYD+e0sJkTnJwYc+ZoFD0NnTqZ0U6naM0gleSBFeJFOXxOJ3hCO3P3BYOC356RL5t46gwvjsYCPFs7t2BCIC1vx0/m5rs6+KDqIz69sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700360; c=relaxed/simple;
	bh=GhBj+xlogUOsEdy0QxEkfT0Sti/IJwKq4YX0BJD+ecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=quCImBC96flGZhSdMLJcSSaLdW1nms1U4e3gK88uoBIXJ/vnI4nVNPNcZIzVcw8Piefn8WL0dsj1lW06eFkuwnqfvh1IM+WfHTH/v9em9rvpsCYnhTc/Vi2V2x7wiAWEyfAfOlq8z32mXgdlQ/MI9ffMvTcoXObMx4YRQ0AK4DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KFFqEu+D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A/at1HZu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606BIHSX3416962;
	Tue, 6 Jan 2026 11:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YRTFR5z/EUn74CMCxN+y7Z39O4n8nRWovgf3Bj7K4UU=; b=
	KFFqEu+DXj5/Wst6pW21rE4eGqTXhbrlUSjUrhgA5nw0ZWROwuLblOtslMHOKgVx
	uCJrD0qfnET/lL/sj8i3K/bObkIcOTA4TNeDUcBveknFI2Jb/270bkg9dIW/wzFG
	3l54Mj8UNyX4KG8D8xcQ2IEUXI1xN0IWnR9OWQ71ZeekByUBkXHUv4/s7K8n8L4o
	x2nvFub/nw7EDlVnbaCIDDC4a/UR+vvrsXPHmagYvNyarmtVU+24gYsIBHLNEl2h
	HkX+EF+oYa7eDlUYteaja2AzCdiL1BzLKP0wQV3yLPJEJ8RHHAIv/W++uD0lNp0a
	oDUMIBpV8hrnlHOtWdGT7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh1ddg0u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:50:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606AIE4Z015471;
	Tue, 6 Jan 2026 11:50:50 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj881d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC44QN7BwY+N131pwx6B9zTRaHdNlYwnKiYS4A3VV8WHguLknX6yXgh2edH7ZEWbD9B6ZWInmG5vLGQkQjy4AcN0kH29CIgA+/cxrlBLLyC1NoMFc8OWxT1p8oBif1cBilFPcJImtrODKzvZPRtHYDPbvxBnlVlNMz5dJowkY+LwSYqCCPuNXCsbYbs24draPMCpXeOSpe/A2aMkufmUVpFvxiuxy7pwVO2viI4ZcEhlSbIIpYN1/RuKatb2Mv5e2JpwqSByDs7PXs5/AeMt1AkWfWeRMW9ivflz/SPDUjNjltVSuaiQ9slt5IJSzdqyspNUvgr8Z38LZp0+DZ8d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRTFR5z/EUn74CMCxN+y7Z39O4n8nRWovgf3Bj7K4UU=;
 b=Xk0R7SpzYMzrQvgQZrxfePmkHMLuBCCpWoMqWvYjRuNCFFhavFR8eJPqLzw1LMA4mBgg+3WyQmDHg6V1YvCtRwauCH8lxGXkmJVwjmJckg9CbBWxtiRpjez8UzkgBBgNDRo8ukbylh7MhbV9/koPR5O3EjQ1nGkfiX/D4KNPBCSEoF3HJD7rg2fmZKTJxw39vCHiWTCbao76m1l1eGvB4CEp8+Q28ZqhF/gnJPaiRer51HkjWtFIHm6ZlXQUPQCr4P815xlxc/DpiBAjHbT5GqorAappbYwr5cTeDT/4vuwoVLjh++wA9rDiVrbnuVFr+cT1g25mbaAkC1tjHnuUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRTFR5z/EUn74CMCxN+y7Z39O4n8nRWovgf3Bj7K4UU=;
 b=A/at1HZuIy6yjZ9OYKXogZutTw2D47HHzJ8+al548bUld1v0LQXMhch8RGMZ8XIYXXlvpTyNE/PaYEnCCfQylz9JGa/bE7tCNwdKNG8xzOvktteKzYWkz7EHMKKe5Z7prgl0sXtvimyLduQnOxkK2Yo91PHSyanvfYDSqS20a8k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:50:47 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:50:47 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Peter Xu <peterx@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 5.15.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Tue,  6 Jan 2026 20:50:35 +0900
Message-ID: <20260106115036.86042-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106115036.86042-1-harry.yoo@oracle.com>
References: <20260106115036.86042-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0067.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4311b48c-6631-48ae-113e-08de4d19d4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwStTD6Rjfp4veBAd9mkGhoXGWsVACQmkCkjnTJSYdV1UfOC/GIR7rFpTjVQ?=
 =?us-ascii?Q?ovkTYoKz1H9RMwyPmo9G8LQclsDxPYA7BNZLxzCcvjwnyqBFoGtr7kD80axv?=
 =?us-ascii?Q?3MnNcWY51rtq1eYk2i/3KLxTbtPtyY3YYg1NMqMeiaBaomrwuUD9mxky8Q6J?=
 =?us-ascii?Q?xQ0J1e6ZF59+uxuw47B7ODEX90JENYUwqxbbqrfDtAgfgiYpegYs5J5rm7Cx?=
 =?us-ascii?Q?FLKg/BPuefwmX14j7MTDy8SnjF2JOl/C1pdhgzAHHT91g5/kneUDtw9Yfsi+?=
 =?us-ascii?Q?CkzWim90S01qW63ClQBggefiJOmsB+EGqL0DuEQNTKVxaCmlkepXQIf508+6?=
 =?us-ascii?Q?pxoAZDO2FCqXuI4WqMUWH7ydkwdXvu4vi+81fMhxpSTsOHPB460U3m2owDrI?=
 =?us-ascii?Q?T4+AxQrBCD45XviQt9ADxYacmLk03t7OBLJtoMsME0PgjDCUgz6rOSTtWqWP?=
 =?us-ascii?Q?jXYNGWPuj+qmH87vD1i6OrBOxX5COFuMSuDaMDX7PJ9aP/nkuXEmgNVSOAe/?=
 =?us-ascii?Q?70akh/AzhjjCzmxM77bJdVrSJFmFh9BvIBZqnTPUcx/lnuAU1EsI4t8gMQ5i?=
 =?us-ascii?Q?KyWnYsFA62ayaNnqsQrZFLelqY7y4VeEImAmTpX8icT7Ij27MXwMgVu7e2sK?=
 =?us-ascii?Q?wcBD3F7Imm3ygeFYrT5dC4f38mAPVmSj54UIazIEIBAKmi0Spl1WaQsov8G5?=
 =?us-ascii?Q?u887ZnIbGOVoKgi+dM6m1WxhlFAXySaBwkF/YOrYdgdcYani2ipyAunpLdLX?=
 =?us-ascii?Q?kHyDdjgMyI23Ksu2yVQAREJTiJ59SkyCWg1dt8EfON7u3VlttyZKtCiMMkI8?=
 =?us-ascii?Q?YvIfMTyPnUzjqVqDWhWdcs1yXc25Ph2cwAkEeMCp00CfKNu0CdXRvuU9cxkO?=
 =?us-ascii?Q?7SlUO83qYVgYSnl/6JwYQ0rX/Sv8V4Dr9mEbWoDdeT+VbQVf70k8J18q/5ny?=
 =?us-ascii?Q?3cumktUaxbIEVv3bpPJAu90IrRc5qnign5iNQvBEMz9EIJ65xlEGpDkuRkKT?=
 =?us-ascii?Q?KZuo6XRorL19WkLpswEJH/2+y8mOaWIM4pOSF+arJREklN8PKfY6QzVUPmu0?=
 =?us-ascii?Q?s3plgHvSa8TccwIKGNGaMFXtLL5flzaGsef3WZyg5E5bSFluXFAbkmhvGiWw?=
 =?us-ascii?Q?bQB1sLuLNaya8Gvc64IauTgqvhw9ZpLZS2/dyndzjzxjOVprI1ziUkh7QSle?=
 =?us-ascii?Q?MCTDYEVIevBWy+1ZhSIUu/aE5YLrWXZamK4ce90G4QCp06hL/a+4txGBOoZR?=
 =?us-ascii?Q?OmI7pJ6oX2SxPZWTukyAGJUzpq4Y9Hf1qohZOG5FPhKnD8fIbhRIxNyCO6BA?=
 =?us-ascii?Q?POA2iZDzsINLGeR+Gs0gG656htxwV9ofAzY80oDcUDR8wHds8ilH4nDrh0zA?=
 =?us-ascii?Q?xlTSnK6NRSPEj2T9BiPMuQnfB/uPGpDzSVPXQjP/oUovZqkP7TY9ADhnMuUD?=
 =?us-ascii?Q?LmY4bgCCabXFl0cJbkD8wKl/v+WyvHD6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/TFLmR3Gmgm972iLq1lmzHRf9aNYXUjuKMm8Om8+t27wHAY5TGbFRGcmjqE?=
 =?us-ascii?Q?9az6k3Qtyqo+viQebw4uz/yS7D/XDA3NajHT3ApfCqNYfWJQQVJMEJwMxbNr?=
 =?us-ascii?Q?VXgQMpJcKjKqY6WcY2wt9KUupXc4gWWw5K7gcoW+S1GPqo78j7WNa58LYSSH?=
 =?us-ascii?Q?iucEREydHsoQMFIl7RK2t0AtxSrLcZxyRGS6yEqsr/HjdSTvOKDiXYfXh+WS?=
 =?us-ascii?Q?/1MSIRCA2Ax1INyQyV0Kz2EeX/kUSkX2fHHoW5/JuiIIozaj94J0ptJduaxq?=
 =?us-ascii?Q?7K4quJx6KPYI7ajYsybiMu5ckbemst5zc+dKfa34s3NtaXG5MubHFMa9nVuc?=
 =?us-ascii?Q?UwqvSa1zkLkO2gitgFYrdC1c8rOkOLZEPUlg3c+0JJIF9YC8VAH3R90ptDky?=
 =?us-ascii?Q?L+dinwmsKTAbNTkVDrizfG8pVHNbX5PNBv6B+YfX3IU0/pnNuoNKOiGuSeYj?=
 =?us-ascii?Q?jGykxp0LabMsFgZrqZeL9p9T6Jm+2uluWWnGqkyCmhILVor7wbGDQzKACrM1?=
 =?us-ascii?Q?CP1HH1pyzn7Myz8B6o2PnKaOpddljaZGDsQoXKYiBS8dYVqHA8gPvZlAxnHZ?=
 =?us-ascii?Q?g7jaCJTo3zJa6GaQn/H0lrYUEbIiC4y2GZZVYKtK2pujqzWOgixEy51dyfp1?=
 =?us-ascii?Q?XoMWb7Pu2aex+tPllQNvVvPcTiKTRh/h3c4xl5fAmDkTTKreqgvzH3AZXmS/?=
 =?us-ascii?Q?WG1kXCXue+6+qSSAuDnLXWMKROnLhD3pbPnOqFXoSvkK1jNY08M5nGVoQe56?=
 =?us-ascii?Q?/ZyWXXIE+S5lt4eUIxA+5faFFeGUm1px1T6Q3UV/3VZWHsPZRDdX8TNAPD4/?=
 =?us-ascii?Q?PXUFmU5L2+3gxaJ33uoK2HtbZXPTEwPA/MIoejtmjhm29yeXdxTY3P6kZofa?=
 =?us-ascii?Q?c/sU+m7/y1iV3D8g7Z3sKbtFAQCx3kCMDQumqV6sR27Py7KKCHBXT4wvgLgE?=
 =?us-ascii?Q?VHNKyCeW68VULuCJNL4/jjDqzxrTEblMmHQWitTOtjiGaOfk2fpN09bRx0X+?=
 =?us-ascii?Q?qWpNg6piWGwfDvBQlpra3zynNemlJpzPu++Bzr4P0E8Q4IpcG7/h9mZS/QKS?=
 =?us-ascii?Q?o2xFCmsTgWpLyjQYOzY7qzMPg7vA9UggOJBlHKrTGlkQLh5B+o9JqhMK1bQV?=
 =?us-ascii?Q?IddlpOU1jPe0eKd86AYVZcHuWyLmwqk+XJx2J8Rt1cHdWjOMTMfXQB0KwwJp?=
 =?us-ascii?Q?gW3kWmLO7kDdQmHzKJsTwljDXVZWvnRjVBRIgAVhZYJ/2pwR5av6Y+ircbMQ?=
 =?us-ascii?Q?20yHkqR7A2VpHNjnaIZVJpy6Q8urmiMMwKK6X/3sLouciWl5vh8n+69kzEjm?=
 =?us-ascii?Q?iTKzlKvcW31rQIjgGcb+iHftLZ8OjZLSMvvtMyTWA3ybVAfIqHKWQiBcKrLG?=
 =?us-ascii?Q?CLxytcbaferrYBm6Yk9lCZ4DI/5mrpbXtImNjEQXI3rvN25BR5Tso+ndX8HE?=
 =?us-ascii?Q?PY6iP8pPC5EPVLSPteJ0bkgDKfKrijb+NLK37sa4ikUDeqRd01iNHK32dkk/?=
 =?us-ascii?Q?WI9xmS7Oih5mNimZIgmVXJUE/eV8XYhim4lI3X0OAffjde6hx9qnlkNzSl07?=
 =?us-ascii?Q?Dj6jZkwY9abgQBOQU7gEeh5ggbUbWqNLY5C0mSotkW8ZmltjXHOKSr1edoOR?=
 =?us-ascii?Q?+TDtX7OzOdOnUeLfZQrZX74pYQbhOLicsrsh5BGNeWa9OK8z4eotJ3eFnHOc?=
 =?us-ascii?Q?cI2SPCH/cYpHo+Zf2UVrtWOd4aJ1VUKrr1mNM0I1SnhrouM5WIIcGxuiBn6S?=
 =?us-ascii?Q?Em3SnnCqKA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hSICwwzLPqtbkQkid1WpQGY91pT7C9XYQUmsh1OIE+Ldd++2W0TzFoZWdwpqtHx45z4CNkg9eiYNAx23K6v1AN7V2B4TYCNtyAF5r+tQK91KImooTxFK15SScmtBIaUkWomwdwlPU8QldIpV1hAgHsitDcLPbkwrLHVbwJ1jkZx0ieTrreMofr0yF5hmz6CmWNolW2+WGhcvWk1ZpoptYgHt4Aa03nQdxxLAy2xuYBsa+Gvp9nXFRlwUGoo3zjC441taMs+QecCW8PvXerodHUKRjV6EN6YQ4BVtFXNVBO8h3gJI5ScLyuUCqBpIC45G1zzxgb0ao5yxiBws0d1ajkqscPzi6wEbNPsNH5LoufY8l6GGClgYEqLrXPtS74hW5UL742yd9p2tm3VKBnSRnoVOM1Or8X/EwflQoJPKlD5i2v0+3UqEYGdn0Qw1PfOPiAh7RoYTtG/nfVRP2vKj0N3csuWGZrQ/m1pfUwgtonGCpwum6/sKf0buHBQDPav7qOUVUUNElnYf1glb02BKAU7iEO9LX7qn8vKhYDkxI4H9b0yf408vttH/LWejEYTpQdLumKHSClQIz0+rCZoFZ7Kb6g4HycB95XrueXvqQh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4311b48c-6631-48ae-113e-08de4d19d4c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:50:47.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTpyqZ8y9HYlyIaILYRaNODp4TRS1BYbJxKmS7ony6sUfAlWyg6j3SbzMyZnLLVZsa2BXsACmyViIqT+6Ni0zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060102
X-Authority-Analysis: v=2.4 cv=donWylg4 c=1 sm=1 tr=0 ts=695cf71a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=bsZYzbwDObJwb2A-_GYA:9 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: uMb0AlQnUilOF33ovqRHzWSiPuq9Gn3W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwMyBTYWx0ZWRfX9+0Dd8zwXPQc
 UoLA+Zpn9EuLFdP9oHpRLCAUnZf0DLoKx+d+Ftfv9GD8XRnJwitlpnv1aj1TunXl2bKY02RQBEj
 66lQNr45aVEVFQC4Wt6h5HFSBzLI/Mh7w+JKfYKMfijlM0V+asKnVwXANPq+28Gpl3YT4pbG9Uz
 dk5IjUikldktzgiseEdtO/f1bHU6IA8B9fsgClEsjCuqE+Zf5R6JHucGbnglZZR9XzmNburzbTS
 Yz4/RbKN+JzO7YZhaI2IipyUurEKocDVGBDQarZFB1mlNlW3cj7gMuZ/l1zrhP3jgeYO/0zfqRL
 jWomDjvZIvWhtd2CZrl65Mpt4Ll6TjoHK3Lu7yL6A8x7032JU/WKlPL5JwUq1D4Pr75JnPzCc/J
 99UNz3mhflmzzoOskislv5vWf+0c+s/XFmdJIxnqMvZl3EfI7eoSyRn1dNymvXp1JwxIawakrC0
 5SPtbRDDX0eKUgspc5g==
X-Proofpoint-GUID: uMb0AlQnUilOF33ovqRHzWSiPuq9Gn3W

From: Peter Xu <peterx@redhat.com>

commit a79390f5d6a78647fd70856bd42b22d994de0ba2 upstream.

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be
half comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on
any system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow
too during the int-size convertion.

Link: https://lkml.kernel.org/r/20230104225207.1066932-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: James Houghton <jthoughton@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 26 +++++++++++++-------------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 60572d423586e..ca26849a8e359 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -208,7 +208,7 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
@@ -379,7 +379,7 @@ static inline void move_hugetlb_state(struct page *oldpage,
 {
 }
 
-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 071dd864a7b2b..4a9ebd495ec91 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1910,7 +1910,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70ceac102a8db..d583f9394be5f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5644,7 +5644,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -5652,7 +5652,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f089de8564cad..3d984d070e3fe 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -634,7 +634,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
-	int nr_updated;
+	long nr_updated;
 
 	nr_updated = change_protection(vma, addr, end, PAGE_NONE, MM_CP_PROT_NUMA);
 	if (nr_updated)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ed18dc49533f6..58822900c6d65 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,13 +35,13 @@
 
 #include "internal.h"
 
-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
@@ -219,13 +219,13 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
+static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -233,7 +233,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -291,13 +291,13 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
+static inline long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -311,13 +311,13 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
+static inline long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -331,7 +331,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct vm_area_struct *vma,
+static long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
@@ -339,7 +339,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long start = addr;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -361,11 +361,11 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       unsigned long cp_flags)
 {
-	unsigned long pages;
+	long pages;
 
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
-- 
2.43.0


