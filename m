Return-Path: <stable+bounces-215530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G1XNL8VimlrGAAAu9opvQ
	(envelope-from <stable+bounces-215530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 18:13:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF09112F20
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49359302C912
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BE3859E8;
	Mon,  9 Feb 2026 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbZENy86";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bbuwze5t"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127B3859D3
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656926; cv=fail; b=uoDsVH0PWBGnazz2Z8/BbEif/T4t4c7d9aa5M7tSpwr7HWUdXFL2I10+jtm2i/ZwmVy58W+RjqWR5cyQ6bzJDh2eGZ30vP+Xl7c5dQvkKi5fw8JUlh3JK7iINkTGt2QEjdfk0d9LvPhF7SlBcGZoLlZHjYxeF2jtG5FVpBp8Npk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656926; c=relaxed/simple;
	bh=zscc+dB7Y9Ofz6I0CPpGOSHzR9hdxJRY6e8ZAhQ8ZIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CyOtmyT5CaKqk92IrrsBpYSz3FZzuFNTvf2ABMWZYtuZnzIkRaR615XBxEt7xceAGWbkeRA8loiPApLGl6xWMmfJA7XB6fRJLc7DYoeHle/Znes6pEMcuUnU6iocAg0POTI+GleczXLi2zAhVfVSc8CpC/vxUbaB1LrptVXD/qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbZENy86; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bbuwze5t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619EClXK2021401;
	Mon, 9 Feb 2026 17:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mqkPopx7IoJHttMZDC
	RP0i9Pq0O5PXSnIsqQO5MIY9Y=; b=JbZENy86Zhr5TtNz1GC/6vZoBr7+9lbd3L
	F0wAYHRrHsXPPXrJbT2UOx5Aabf86KlbjX8h9d3e7+jzsfwPaxRkYOt1VjywdLDf
	Z6UrO7LS0Q6ydWz70AqfyCuBnwIIs2y8OwhHnS2nztuGHtqwU9NaZ7wfZFomQ5L5
	9Rl7dm6X8rGBareQukey4qdR6gbZcHcsX5CsKz2Yb//fsNOKZsc9q2cwzsoeRYdk
	yYtNb7j3K6XpcTWyF/IEgtW3gituLu7IWOyp01JTMue1NJr3ZP6LonjqRhzRxmpm
	ueBFOXG0Vb5PGcqkIalvTRiBJKAK6Rgq20fJ7Co6ZAmiQIpgwnAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xfp2bf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 17:08:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619FuMim005044;
	Mon, 9 Feb 2026 17:08:21 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c7jnq2sm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 17:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzfy/Zp9XUfLZW6RUyRFxDsKa1leaovBSFpJc0nOmvIKlFApJHRwGoqTJfamZfdlI0LtO3DFo+X0/pZB7TIeyyOGHLowS0Sv3kHpy53dywfSNAKBaIKFItY5YEEHYNlFwGbnF1ypQ8mIlCSRQyDLL2gajvgRfAqtzaXzEMeDswNrOGXFJ1zfQKBLfLQHJUZzaqzHRg4BRZtbEVpahhE4nLY8Zk3BX/dVA/Kkoz3BpsNC+jn09sr5/1zS2kXk17xavb2yT7Z5Lhqj9Es+/qcR++FrjzLHwoD/zSQBEjJWptZ6mkvb27Gd1L5A+ZlvQOw9b2bhpuEaXFuRl7Mb4qdTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqkPopx7IoJHttMZDCRP0i9Pq0O5PXSnIsqQO5MIY9Y=;
 b=TaC2tvNSwSum/rOLXGFBQbk/1voG6vvJbKXE8RFPCwiR5JkLvvadIRGEfSQqyEXIZ4wYpKhQKQfB0qfUksd1isutvbANLS5wOwU+Vb7ruim9fZpCLHG926VfzML1OZoE+443qq9BSCaHI8d4ov4PRVI0YrN9Uy9VCBnd4qUL+HwWWgdttK7SfGfHRl18lsddNMRFepJc4FBrpePq1Wjqk/0BsZv0IC2TvjJ8FM9OY9dEBB+0RnMswQ6k7U1ZQpUZ1E8tB/UxtULx6/Jgnr5uoxrWoVWVzo5cJI6sv/7pN3u2na/6Sh5MUxKp/mEgqIPP6pkmhAnbQoGCAAmIXUAqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqkPopx7IoJHttMZDCRP0i9Pq0O5PXSnIsqQO5MIY9Y=;
 b=bbuwze5tygDr2tBEsGAsd8DxlWVZ5HoeiKxo+uTpt4c2CPjfcTieYcvifMK3a5APFUn8K6rJOgk/RpLd0zqwi0ALmhsNOlwtzBNRSuF/cFFC81iJK4lvDO9JUk2Hb+qURW/+62GvIW/AuJPgCY+7J5hskIlXCukgYBUAl7AitF0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5145.namprd10.prod.outlook.com (2603:10b6:610:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Mon, 9 Feb
 2026 17:08:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:08:16 +0000
Date: Mon, 9 Feb 2026 17:08:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
        jannh@google.com, gavinguo@igalia.com, baolin.wang@linux.alibaba.com,
        ziy@nvidia.com, linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
        stable@vger.kernel.org
Subject: Re: [Patch v3] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
References: <20260205033113.30724-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205033113.30724-1-richard.weiyang@gmail.com>
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 19960e88-2ff4-4b53-7a8f-08de67fdd0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgAdqZhAuFQU0vk99Vs/Hj1NX3TAiljvjSs9dTj83FvOfoeZHEAnjusPHesx?=
 =?us-ascii?Q?JFUXqqiZEZ98Mc/rvfXI9UFv4A+VEMZ8Kr6zgZFVgD+rtqtBer6AhjF1g3gS?=
 =?us-ascii?Q?zQdkS/aXpYY4o5MI0ot58J+/OYkNFhipjjNhyBNuHqKPNmkBrTKYiF7GDlLX?=
 =?us-ascii?Q?gAWn6snNZiGpmyyxpaNuHwc4Gu0CQLHN9bUh5AKYsT8442XaBDLuYLAiOZFs?=
 =?us-ascii?Q?I6CtOHzhHrh8m9XOf98TR1mrIKIxW9TAsWKMNZArV+GtVm0Jv+EeEd471I0t?=
 =?us-ascii?Q?Tc8p+vWDdUjvS43z2bqHuTn+Njecd9+KnMqt+dqLey7BIP3D3sAbMa6SLxrP?=
 =?us-ascii?Q?Uce7da417Fxw7hpsUxM6xTu6XUdj2oGcfIjJiTDd9VlhTqZbCMSiekeV9Liv?=
 =?us-ascii?Q?7BspcmYp+RE2rMiQ6UdP1TMstKvWCLHURuJfbxWcIzM78R4pYCeFkrjhX23N?=
 =?us-ascii?Q?xB1R6PK1XlT5xmwHPVOhY6a6nhHHFNkday3viPrDPPSkyWYnZimLA5A9ZgpG?=
 =?us-ascii?Q?VT4A9OLeP0xlLFzfyDi/FSr4G+UlntSMLvhwonhZg43sxac5/jt97Aj1avsI?=
 =?us-ascii?Q?Nn7ANmNWKHTpPzR+y1QTm+UKwvbUvcm7JHo9noeikpKkR1BtR2p3dpvgITI0?=
 =?us-ascii?Q?Kw/cRGuy47BX24ZAPs2xEgaByXeXpNXcWOLMRm3csBOBL049l/9vz9xu0OPO?=
 =?us-ascii?Q?I74Sntun3Os4H3pDHcPfKouJ2SWcmp3kHPFxxWUQxjQyaw3zADgwzsN8+Wfa?=
 =?us-ascii?Q?ijbBkxk8u8PxRiYEuYgDWRdDdkWhhrEuUooD7CdQmvPtUde8qvghD8+FAQnt?=
 =?us-ascii?Q?HhxWYVVQJYVCso20DKNk8TXK6EF8hBPWcuVa2LHK1o2QDr7Itc0s8ejLM2xV?=
 =?us-ascii?Q?dT2VZY/UwEbmJw40WqKmu5mFAO7N4RofW1grII4FeZ8BlEuHtke9fNyh0+Vb?=
 =?us-ascii?Q?0zN2ObZCdHCsl/gkOYF4ceDY+/XP9y5l3ueGVp6Qeg/fD8roNpHbz6N9jN4D?=
 =?us-ascii?Q?fUqkOglurNzGpKvmHds0q/m8AGJunSDB5yaG9emc+wCAbYFcYIDxgCBDCw9J?=
 =?us-ascii?Q?BB6kiDUdDKOKJ9iJA/1WfMP54n0EjiHgsl13HdK9iAP3NUlEBgRr3CpNnsSG?=
 =?us-ascii?Q?qkhlqPkrtx3222dNwPYAp/GRedwFibT84NPjNVFe+w4xH2Yk09/t4DwiRyJx?=
 =?us-ascii?Q?Y0w93LCAMlTu/B1sJ5DOdQUmwrp9soZdT/P5+1lESMe310lenwMfFFuf4NP1?=
 =?us-ascii?Q?lE01e0oisKdvXEsigPb8H32PD+bTccjWJG2RBcSl8pIwKJmJxxp/qZPjGDK0?=
 =?us-ascii?Q?0s4icfWNFvdtqb7aPHXdAjaWmZDxEYPBmYoXuk2Bz5ZtcgO6+NUCM87QvcL3?=
 =?us-ascii?Q?o+tkijhn0Rgo5HNwzuSN04dhntNxYam5UljZQaOX7Y4ARHYa2luzBOw7ZWx3?=
 =?us-ascii?Q?sMn10hxA6YokLv+0+YXPFIyBjibfdIhFB4dbKTA7M6DWtW1+XWtgzqXz/d/8?=
 =?us-ascii?Q?PmvwzpD30c93jmT29EqoGmVpmem8RPaulNeRVDZ7KIaIIV0Miwzs3SzHDiUf?=
 =?us-ascii?Q?tJmEtLj04VctcCftEKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OBNWXkhQPjVnb5DmCK6pzWrxBqPuFk1uDTgtnzVjOhU6b2qLNKXM4f9OBWkm?=
 =?us-ascii?Q?rgOyZ47gQ72AgoiZStU7b2BbNGGUgZ0nn3cDsQobPtCvOOkzGDA3tlUuBi5z?=
 =?us-ascii?Q?7pp4VvKlG1W3/eMlyi9J91u4D/2WV5FQdz5QTRaC4nPNh06bEJpl7GBP/nF3?=
 =?us-ascii?Q?vu/yc+CNXj94P190YGdsVdLKT2Me4+QSgJnSATrcJxkB9pSc69cf477pDXMY?=
 =?us-ascii?Q?gXtgXRY6AWzkWNNImBL6WDQLYNmBHDea0uGYs1CnJ+ZPVJgf8JagYul1HP98?=
 =?us-ascii?Q?cVC042UTDkSsG0V8nc1EeZnbzcZRBJnOVGsEm1z5sfOjppSEDUbymPP8rhNd?=
 =?us-ascii?Q?Sp+RkKFYXlYASdgzsZ/TVYuDMkQXwLA1Cb7d5fqkXxTwmP6ZNrUigoFeBWL2?=
 =?us-ascii?Q?NI9h8riGi6ZwOMf9eukvxZP8a5gSFV4Gqef/4WAcIGjfflqDSAP6AfNIwLXT?=
 =?us-ascii?Q?ncPmxom+u8QfpsX0yJRjJnzOBD14KmvKONLIyaO5apiJQhlKJfNuXcI92IYc?=
 =?us-ascii?Q?G0CjYyqWHnRKUz/845DZBVEYYdNG6mCiWWJRliOGPrCCOIO7Cf/T1oYVFQsX?=
 =?us-ascii?Q?NZ0RSq2OwPeEjIqTeHO/n5+K+LxQUZ5wLvGCOlL351Fna9pfzwlrxCWkcFmK?=
 =?us-ascii?Q?BDsrNBItKpu4KNQeRvA+1aO2NP3FdBKdsgWfEIsy4SG98w2/YUAA56XOrw5M?=
 =?us-ascii?Q?2wVyb1XtpYxRYjQ6H90FZvnfPbzfbTdbR5qokCYI2dSfNskg2QofhxEpG2R1?=
 =?us-ascii?Q?ajOVVe6mTBAxxWsxMv0vph5YiIn+tETLVvXJ5RNSm8LAk6uftbt9bJ5Z/oxf?=
 =?us-ascii?Q?Mics5CxWV5EmObkcKa+fYxjhz8m3aCuDaSawawalCbKa8qkF8A9xZWUO2kRr?=
 =?us-ascii?Q?dnP4Rur9WeXH+osqZW8Ber4vxmrv+UqI8CwQM6DZzsZ/LhlY2RIxkA/5fPrw?=
 =?us-ascii?Q?KzLXens4tU50H6p0wZj2rhBGSW6rUbRQJJ5sqbdJkwTwzRQptZ6YuENngBjY?=
 =?us-ascii?Q?EJn7gMJV6FKmCq5zHcGlIy4arkC0+PKhmIE8jVOQ/ACrRSj1yHgwAbwZTQ2M?=
 =?us-ascii?Q?ZKQhN4Z2FeAYy8uQjUa0AT0gRp5bBchU96GbNAJkEkRxXEL8mfKB50wLsMBE?=
 =?us-ascii?Q?Q/P2st4BeJQzGcOuX2RD9AYjdIWWTFj/QU+xLFaWb7kK3c+BbiRsem4rDc6G?=
 =?us-ascii?Q?VIRcTwk52NT/V0uZ4lOPF+ogJyFaejvK7uRFLBIq+vXCxU6tYnkJBRuyl6nd?=
 =?us-ascii?Q?1l32h5nGMwg+OWzv2GbQ9af+Jk0Tr+eemqS0POrqujzqbSsGnCXaJDGuXk28?=
 =?us-ascii?Q?KHai7RvKrLpjLWEeErBHeH1ezAtHrZIkPI9HcvbIMLrjmMah6Ma6zb7rZN1B?=
 =?us-ascii?Q?uDgs1leQtPtGUeBmhDg3GgdRzbk79Jkf09xW+OSZ6M9aVOAzkVxSuMg0L92N?=
 =?us-ascii?Q?P1PrCj4fxwqJiiu/dNacXiHUY9EcKL4Y1r18StZkblRixnl7NjMZlkfqkHyV?=
 =?us-ascii?Q?mUL9sAV/1gaOQKTsKp/xhMvp56L1+w6pieDaakGIc576QwGUaj7ih199t66H?=
 =?us-ascii?Q?QvFUcChqAWkemzA63lOrztytNvQ46uiQ+6u/+3dMuVcDzOJAb0p6hYA5kzuJ?=
 =?us-ascii?Q?+zXsNjkuxxJv+kVmH8tgpqSF6NZpZUAXKayOMcuvFjGF2CZTZ9CGJHgLXGZh?=
 =?us-ascii?Q?ExbiqqQLvLpzy4qtkGLuAIoPpDv1f67NZ/3D59EItkl/F4F+2JgaZ0VvABl+?=
 =?us-ascii?Q?mCFNZqRvpQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+B2/bm3pJ81Kx/pEmG2ujtHiMjLHymkEc4OHYfHJN6ZmEYZrnygimHP8v/l4eS2h/lNrJ67YRXZ90PYyCTyKg9JqAxPbdoOQnbuxOgEBQnUEgZ2N2Th1Qtf5OLnNI7h7VRGyg79ZfrV9IRn9Sj9yxLWxnRvQhTQc+BH6hT6tj+3cXm+grWxF2zP2noPYO4+bBmcnCHmVoBMcns5JVTriA7unayY5OqkptSUGQm0y4Htlxy6sgFlbd+PZB0cwUj38gaqz6iWIyJ5xkSsns5CnIA1oySI5cRNvI4LiBi9GPhT61oKa1uQvNoNwaq7wZjAVIs7rPFaq1AVJX8Yn+8X7/ZQl6xQSUqd6necmexBCXvRGVXwunYC3+IztM4BclY5aEIrjU+U8rjWfj96Unm0RvmN4Uzg7YZYYTiDtLVDg7FGZFtoQNiTlmuinaBK2ZzdEX1sLrGKICFGeiGiVZSJdxj1HyE5MCxuTpyTVDOYZw347NVeSV7DO9SHiy9SeH2KPbEQiEnJymDtXhSAohmwHTbmkuK1EErgDmPK5yG54h8ViKHPxWrFJnkPtKEKxitfyb4lG3QDNVZf1jHvpf8/qwY8jSOIyYZfFDJIjt7817yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19960e88-2ff4-4b53-7a8f-08de67fdd0c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:08:16.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ec1OTv4NyFZDSP/fileTlGDqC2plGdW15KHqLMmjtpPHFrT2R7+FNkHXGA9srlcMtybK1mgkMxSdr6Jc3emLQtA15Qgyw/FS6pWqpJHe3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE0NCBTYWx0ZWRfX2umUnN3pM9Y7
 P9J5a1tIj2WqugQ+aWJcgbJ5fQdDK+qaFHdx5hqNCBSySfg5yla+WlVyNNdE1VrEFi//Na+5/Q0
 HlojhyOc9KtqEMoKc65ScWQLMqK99NVbovcUO8Gr9xBqdKxOF82nVEfndKL6J6gBjaxOsMOHbvG
 44Hw15JlWgnkkv2gwCEs/htEXL5XP5fZZ00YPSiwiuMBCS2XzDtw9klfBAv8cWXSxjORtKJ8nuI
 WqIbGFWYu1nHX7CFMInKjtxouEhpn8KSOcF2mA8VoAEJSiv6oDIky8X8peHmdccSziAP8Atwktl
 j5zdXzcADeA+Dhs/bPUnQ2TujeEIEfrK37fgf6Ev5BTS05OsAHBtfrGGIcZ3DtVXQEF8yd89k75
 n266Zu0EZJszT4NbYX/hEYvrmDyLIuRk0nnx3M6N8FRrPr1q2DUbQ8Z4wJGQYIsl86p568mu6ge
 dKjuV+64Y8J3VZXIZ8Q==
X-Proofpoint-GUID: _t9z159ebwK6wdtFLaXR2Yvg_-oGQqB3
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=698a1486 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=SRrdq9N9AAAA:8 a=Ikd4Dj_1AAAA:8 a=V2sgnzSHAAAA:8 a=VwQbUJbxAAAA:8
 a=DS5PB2M2N5xGk5OapvcA:9 a=CjuIK1q_8ugA:10 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-ORIG-GUID: _t9z159ebwK6wdtFLaXR2Yvg_-oGQqB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215530-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,igalia.com:email,oracle.onmicrosoft.com:dkim,linux.dev:email,lucifer.local:mid];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2FF09112F20
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:31:13AM +0000, Wei Yang wrote:
> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
> split_huge_pmd_locked()") return false unconditionally after
> split_huge_pmd_locked() which may fail early during try_to_migrate() for
> shared thp. This will lead to unexpected folio split failure.

I think this could be put more clearly. 'When splitting a PMD THP migration
entry in try_to_migrate_one() in a rmap walk invoked by try_to_migrate() when
TTU_SPLIT_HUGE_PMD is specified.' or something like that.

>
> One way to reproduce:
>
>     Create an anonymous thp range and fork 512 children, so we have a
>     thp shared mapped in 513 processes. Then trigger folio split with
>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>     order 0.

I think you should explain the issue before the repro. This is just confusing
things. Mention the repro _afterwards_.

>
> Without the above commit, we can successfully split to order 0.
> With the above commit, the folio is still a large folio.
>
> The reason is the above commit return false after split pmd

This sentence doesn't really make sense. Returns false where? And under what
circumstances?

I'm having to look through 60fbb14396d5 to understand this which isn't a good
sign.

'This patch adjusted try_to_migrate_one() to, when a PMD-mapped THP migration
entry is found, and TTU_SPLIT_HUGE_PMD is specified (for example, via
unmap_folio()), exit the walk and return false unconditionally'.

> unconditionally in the first process and break try_to_migrate().
>
> On memory pressure or failure, we would try to reclaim unused memory or
> limit bad memory after folio split. If failed to split it, we will leave

Limit bad memory? What does that mean? Also should be If '_we_' or '_it_' or
something like that.

> some more memory unusable than expected.

'We will leave some more memory unusable than expected' is super unclear.

You mean we will fail to migrate THP entries at the PTE level?

Can we say this instead please?

>
> The tricky thing in above reproduce method is current debugfs interface
> leverage function split_huge_pages_pid(), which will iterate the whole
> pmd range and do folio split on each base page address. This means it
> will try 512 times, and each time split one pmd from pmd mapped to pte
> mapped thp. If there are less than 512 shared mapped process,
> the folio is still split successfully at last. But in real world, we
> usually try it for once.

This whole sentence could be dropped I think I don't think it adds anything.

And you're really confusing the issue by dwelling on this I think.

You need to restart the walk in this case in order for the PTEs to be correctly
handled right?

Can you explain why we can't just essentially revert 60fbb14396d5? Or at least
the bit that did this change?

Also is unmap_folio() the only caller with TTU_SPLIT_HUGE_PMD as the comment
that was deleted by 60fbb14396d5 implied? Or are there others? If it is, please
mention the commit msg.


>
> This patch fixes this by restart page_vma_mapped_walk() after
> split_huge_pmd_locked(). We cannot simply return "true" to fix the
> problem, as that would affect another case:

I mean how would it fix the problem to incorrectly have it return true when the
walk had not in fact completed?

I'm not sure why you're dwelling on this idea in the commit msg?

> split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
> leave the folio mapped through PTEs; we would return "true" from
> try_to_migrate_one() in that case as well. While that is mostly
> harmless, we could end up walking the rmap, wasting some cycles.

I mean I think we can just drop this whole paragraph no?

You might think I'm being picky about the commit msg here, but as is I find it
pretty much incomprehensible and that's not helpful if we have to go back and
read this in future.

>
> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Gavin Guo <gavinguo@igalia.com>
> Acked-by: David Hildenbrand (arm) <david@kernel.org>
> Cc: Gavin Guo <gavinguo@igalia.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: <stable@vger.kernel.org>
>
> ---
> v3:
>   * gather RB
>   * adjust the commit log and comment per David

Clearly not enough :)

>   * add userspace-visible runtime effect in change log

Which one was that?

> v2:
>   * restart page_vma_mapped_walk() after split_huge_pmd_locked()
> ---
>  mm/rmap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 618df3385c8b..1041a64b8e6b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2446,11 +2446,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			__maybe_unused pmd_t pmdval;
>
>  			if (flags & TTU_SPLIT_HUGE_PMD) {
> +				/*
> +				 * split_huge_pmd_locked() might leave the
> +				 * folio mapped through PTEs. Retry the walk
> +				 * so we can detect this scenario and properly
> +				 * abort the walk.
> +				 */

This comment is a lot clearer than the commit msg :)

>  				split_huge_pmd_locked(vma, pvmw.address,
>  						      pvmw.pmd, true);
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				flags &= ~TTU_SPLIT_HUGE_PMD;
> +				page_vma_mapped_walk_restart(&pvmw);
> +				continue;

This logic does lok reasonable.

>  			}
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>  			pmdval = pmdp_get(pvmw.pmd);
> --
> 2.34.1
>

Cheers, Lorenzo

