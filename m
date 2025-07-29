Return-Path: <stable+bounces-165047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74EB14BC6
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B0E3A71E4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62092882B4;
	Tue, 29 Jul 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ht2ch6y3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NK4RyLer"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305E1C3C04;
	Tue, 29 Jul 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783079; cv=fail; b=hmGxQdoP9KKCLhSTz5ou2C4XCCsOBU+8ikefubPDs0uqZg6uv6FSTVK8iM+nCn/OILl6MdbEWm9srYYHowgV/XPMbZBC4ObyP/kcRab+DhfibI3iyz6sHnkqWVX26zTDVfTPU8p9htYRcelrm2EAqeDtI1a61UYjD8bf69mezWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783079; c=relaxed/simple;
	bh=NiTgVlCG/masA2XP6TuUTh+rQWaNYvlbWITH1E+AdpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jOog65K35x1S7aoEjGjAkxL3X7husRVPw14ll/gUHGK4gsF1NgOaoPn6O9xbpz/DNwm88Lb5tSTmSBAnBFQAgYENjQHfbYl3HoEXn0i7Rwl18bRIlZaFIU+ihKgnojUCFdhkAuxb7nxOMmS15y2ZnFoSCdKUD+raODTuFKuUqPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ht2ch6y3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NK4RyLer; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g3rX025053;
	Tue, 29 Jul 2025 09:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0gmm3a0i4AUQzOzB6x
	nn/lr3chBCcAUbr/xb3l1gPtk=; b=ht2ch6y3Oabd3DC4SQ6NAPR7OO9a45V0uS
	mNGU/pSJdTDZvJWkaXoYzN8ctpl0MaueBNhyA/I+OPFYyOIZdQxdnI1EPj6NmV70
	QndtO24dERbukUQAwGS79WM98rlbnjhI98o3eIEQwHwNE4Eb5yTbUQx1RXaW7nfV
	kagzW49pLWCNQwaujcVU29mmKf+OcFaATvGfbADMtT8F68vlhgrI194bMLchaGus
	ERP7WMWwQiB0Qv2lZ7D59VXv+9h/TuRTKiJ8Prz0HQRIW45NZkAhT/WVMVXAbzPq
	1zNumbUbu8Moy6ZH7nUZGIqeXQxvApZ+KHI3Zimmf/zkdT14JhwA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4yfann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:57:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T919Rm021096;
	Tue, 29 Jul 2025 09:57:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nffynf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3Z7FWqwDST9u/gegEx32eOyMK8k2h8V2hPnAXHrxH45x6gSXeK9FqFEE6Rq/nzREO8E8IsSGPakN74xe6nA6pEbOK5TWkKH9+pAw+ex3F2JaGUE2FRLpNFtaaBG2ZkT01maI8AmoHbT5rfBIP9Qe2zv25mUBq2/8YGtAloqwhfBf4XsOpZgxAQUzgillmX+XkuPsGHiN8IickwERz3ueMN9J+hnKxs7DL6+kaShtDTHq0Xrf3s0xydhg+SBUg1mxVxj/jnoQyBBCmm6yYJnqDzf/gRj5fLypZH3s/95H/WUGbBfSYMB2CshoEC0e5cFItLed2MneigAePv/hrvOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gmm3a0i4AUQzOzB6xnn/lr3chBCcAUbr/xb3l1gPtk=;
 b=NOs55r5H093ZuVzoM8EWw3tlNO69Rj7X6a5dY0JJMHb60Pa6BdggrbtER1U9E/ksM7cc7uXsk9xrVt7tIv4IaXbvkVka50XnM3OdqVTlZLig0Fsp8yrmJPcjnmexlSvtm8R5TyfFAlIhePVJAV1bJ5Q0kkWPfjTR23g7pBybsGFpg4KOOP6XADPrW5aquHO7d6WDZgTrLScD6/1XRSqlaJA/ustX9wsWyQHoODgHzQgle7byxTdX6/h01gjaQdlr9Zl0ypFMxGZCg+W3LLJrzDJlaMqQiP5UQuLGIE8irQWxmFd2NfQ+SU1D9gFEhMJF3aCb6twtyL2/b6oISeJwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gmm3a0i4AUQzOzB6xnn/lr3chBCcAUbr/xb3l1gPtk=;
 b=NK4RyLerzWPwhmUpEQvN/HP4fYL2Rt+g8elAu7z+VpIQeMziK6xC2eMoCO2S++O8a7EgEktgez1kqgUXKU26VgeDpTYF9e6whnXrY3wAN/l9pKS9ihTnDmW3RBSTryrH5BYP6YDh8sKNjd+39vtLttxWxMdocrcBUSTfqprDJgM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 09:57:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 09:57:43 +0000
Date: Tue, 29 Jul 2025 10:57:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
Message-ID: <63d2682f-a24e-4fe2-82d1-fb58a8575c6c@lucifer.local>
References: <20250728175355.2282375-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728175355.2282375-1-surenb@google.com>
X-ClientProxiedBy: MM0P280CA0106.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb41e94-5fa1-4cec-a735-08ddce865cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VD+vDVasex5KUuB9+09KPJoXAc/4fqFitzf22eh9Tv7AykG0wD0PBctvw2qq?=
 =?us-ascii?Q?qcXzTliEwNGQbf/D+DmMtaW5eZzv93NoLHGMasFQ7tLOKfvdo0ZT9U2If3wH?=
 =?us-ascii?Q?We3iZ8uewhYWlqAWVFdHOiHSpMRdKJL8SJgWG2wIiAaWZ9JkRpaTe+EnOeSQ?=
 =?us-ascii?Q?w9WzGZGWA7K9sYgqInqNf2qnEGW43GVPIDEYpIcn/2WldwN/u02mBX/B/qnc?=
 =?us-ascii?Q?AOBIoqi9N/2ZQn/BicvdmdY+zO4HSI8LanIsEH+1JYjJ3vSz06MgR0pvtywe?=
 =?us-ascii?Q?Dgr40jgaqNmtw/eiU008nFHn/pVDjDFPT/ob6YIW7jRmzqCBg6Whv+kHtO3P?=
 =?us-ascii?Q?1J2s5OyDu5o/X0RHJqNS5t+qfow2ijfWe0J3zv4yOvwtp7VHDeV5mjOpWCqG?=
 =?us-ascii?Q?Yt8Vhx8gkVWgKIccfxyDfcQHhBaUU72uSIufU9vMAijWdyHwZpMGHhaY/sT4?=
 =?us-ascii?Q?3o2xrp/jK2Zw+5nUdm6P8S5ZbH/hVa/ufddjtA5PTfahYSaTsZ0w3h5r/Iln?=
 =?us-ascii?Q?tFu3oY0uFHk/4MeQIYy/5nw2SE1uI+hONMuDfc+XfO8ZjHSzP9nKfztpGt2g?=
 =?us-ascii?Q?ihqcRXyFdq+GmfUrK5DSgoGlgbQ2vNWAYe/2g/PV8EBfxaRi7pM4Rpq7noPI?=
 =?us-ascii?Q?1muDlrSrECpHEA5oItpVLPH7MfBOSNUB86pY921I7Ei3+S/d1LTJ3Xnd4TBF?=
 =?us-ascii?Q?mHKBQ0GGV8ml9K19G521VPJUdjleG5PpfhE47hC8WP0yh/rgwi7cowcm7Rz5?=
 =?us-ascii?Q?+UuMptMImorVMxxOfic2CpmsWs8Y48oQoc2A7AQ2RvKRDMeJkXUOEmCrw94S?=
 =?us-ascii?Q?pX7fveVPSP4Wb9eDr6lbJcWUJyd3iZb6OMN8V7OPyGPnzYynjzVzI/h4RAiM?=
 =?us-ascii?Q?1XlexGwAVSLcxtEw366nlZdekOzrwXbpuYYVb50LnA7q1XhkRFHyaBNVfZ4X?=
 =?us-ascii?Q?L5KySCc9+40aSWsCeFztXkMPWKq7BFIHp/hPGu4n/r1YRYbJrQO3UbB5P1+L?=
 =?us-ascii?Q?zu4pK9nLrdDUR2tLGYCCK7xTk19+qCL7t1fzFQfhmMUmJ3ixPLJPXCQAmEKv?=
 =?us-ascii?Q?RHp7ixL2PKcdRN6FdhB3WagbEkJF8YGz+kCRXa7HAEtF/q9Desuwrli/7VGd?=
 =?us-ascii?Q?D7BITVTVD4fkrvLRafecv8mrf0Ziyw0tHsB0WNMfysWu97vbKypLAA8BtLFK?=
 =?us-ascii?Q?J/gNY7CcA79VLu0b8dpIH6BKLLg6XulwhYRaZlMy7Dmtc085QQ1JGKREdjWE?=
 =?us-ascii?Q?AnGp0Ai67fNAgFovkwQGD2CJXjUCbt9uRz6Qf+6ShJyHVjmLeRzkZtSfHOll?=
 =?us-ascii?Q?RmTajMrWM5SaKMUPKA/BoRepCF/9vb8ImAvRWm6BimSe89SUl4sbdyyMszRQ?=
 =?us-ascii?Q?45muu7HVZHCY4JA+hj5r52/1Y0v+fk3n704Y72ZE7jeVdGRIerbrN2hJyPC5?=
 =?us-ascii?Q?1VfFoaeWmaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3pdsMqWlAmGf3vnozqO9Eaf7dGMjsSfpTxONF9wITFw2y2n/MsIdZYVNESrv?=
 =?us-ascii?Q?PhjiNBSWewxF3PQyaeNP4xGXdugvqXPzH+Pe+10z02vgL8wvP/kdFbAKwnA6?=
 =?us-ascii?Q?ahPMP8oKd3W9BpLVxsb02X//mXxLmCLPU2PC0cXu6p3nqxd/w/8LBLi7cxbs?=
 =?us-ascii?Q?CYNsf7QiQ1dJJj6oZBFPM8HtloJavmMjv1idcfrW+r0a7wp1qfH7Sk+XNV6N?=
 =?us-ascii?Q?rJthvmMup6Ah1jtFMFF6tYkDs+qbo3lcRn/wXZ8qLnrs3m8pTSthVXy2GOpU?=
 =?us-ascii?Q?qAF0bxo7b67W0e9lb/8KH3JOAJ0093yYYSTng9q5ncMvlKOWcerDyPSB4AHu?=
 =?us-ascii?Q?zImBwV3pe2DxmsEkW+bJ8jlO9jp7EIkm2yK2SR0sL2291P3SFsKmLcdxyhd1?=
 =?us-ascii?Q?z7MYNJ3OvEEO638UmLgjFqe+iOWXX64R2MYxGoame/kWF6I+tWoSEXoqkoZf?=
 =?us-ascii?Q?45KxKKjg/KYWZtM+PwFcepggQQ0n5repWmHLLf/aw8Cotji65pxQ1Vvuxzz7?=
 =?us-ascii?Q?FKQNaVuLe9RK92uy1C6Ks+I4KZj+cJGoWvtoAcoCcwNS8x5t0EIXSbLsAlgD?=
 =?us-ascii?Q?mTEVIhciGhndejJzyQCmkxjJ0vrdYLD8UD5IziQszhTcDJou7CPjmLyegt5h?=
 =?us-ascii?Q?qH/6LunuGp6EnPqaw5MXI2J9Gf/Mun1/1/31jcZBLI5MZPmBLUb97osMiWJi?=
 =?us-ascii?Q?2WmsKIoR/WJECDNYgr5KRztbuI8OXN6gt5n6RsnN+HyGm+t5Z04D6/7m3Ux1?=
 =?us-ascii?Q?j4Ev7rHK50xkDJHpxIN2F4JEr9jdHeGnQq2CfaAM1rwcHUovfEWQUEnGs0KO?=
 =?us-ascii?Q?IDw+NG00xWBlrSyMc/BLqHjXyIom6TaZ6+VxKNpPDUxykkW5LMGTKR61DJvX?=
 =?us-ascii?Q?L9Oko0KFoSOFomkqgSs2LjB6iKICoXXsdkaOWWQU5v0SCVTtiUsCT/bxmwfZ?=
 =?us-ascii?Q?PAN6MCEa/XDD3lzrgE6NK1z1hFGUMXBTBGZl8S0yJ955pPzA828SxBv1iNVN?=
 =?us-ascii?Q?SVyYHrIwPgwipY2j8IVArVWvjyLJ4TqzlXAq+8+VoJJnK7sdVpJ4D0fzUjzI?=
 =?us-ascii?Q?cP4SDgUebi8x4WnHzeGOwM1Gyps7YZSqB6AgmChHvrzIJHt9anwXZYvTn7bA?=
 =?us-ascii?Q?oO9tZomVVkWjIRgO54W+HwqsetXqDgwViQIE86TQX/rj/C4hGe/WRZhKKo7w?=
 =?us-ascii?Q?ooK2S171uRrCeMX5tVpPCD0Zo44pNVKWWbx1+PmDR1bBcYQX2Af4gTmG7nWo?=
 =?us-ascii?Q?eU0LXEKZxFMeMmBTccyESkyxacYZMG17bXLfx99xJT0ucZwndhQD15vwaRte?=
 =?us-ascii?Q?8lpedHtDAzHPEGV26GEz0Mqu+DOaE8Ftmutsfw/zhj4Vu8umlKY5VFaVmzzV?=
 =?us-ascii?Q?RnKnPCQuZWzEua2ASrSlR/VrS5nToYrBbHrA90qxGkf3Eyo+Taa7YT4oAL7r?=
 =?us-ascii?Q?qyzu+X7dN2ea0gGVezujZi0ttG4kfRgP+uSUex3WVxrWt+XLQzSQVFzKsC3g?=
 =?us-ascii?Q?lwu4KxbOE8/ss1PVw32f772p91RsoG2dK/f7LIVtNpt3soJGHcu6RjqYjDz+?=
 =?us-ascii?Q?E7pxBhkLl+LXMNa9ubBsOTF1UjK9XDJGPMCtCtwy7wMlAcjIB8GHAvR76rqW?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R7zDsTp9sPH2rvLy6CkFDptFjs+o0awCWK+AWMlPRcmZC4Ux/H9PoK/gcSqZ/b3PMVRci6nfNaC4mBTB1vKlZEGb1/pKXZD4z+hH8NIiKeYmPhCa3jhXp91t0OluwcylBDvZ7/8WO5PGJqW0Pn+txJFjTyOQOmuDmRW9SyU3QHzEE/xVu2c3HRIV2oPdpwiMAZiPYElONa+Yp1qKpBR3CWTyfkjbfAbgkAZlXQoaj3KJUDJOkwGVbbTlHmYPUnNYPOR6yfglys9tSgmjSnNf9bRwzjd7y3KkC6ZfNn1KXqx6ynZn2QxKBrlqgneHFTJ55qVIGCdNTehCrGlCVDEtAy4G6JgoID3PJkOo5greskhX81B7f3VyqXVXBdW0znkX4aPDLQ5snerECdRnOUzo9rwS22PSjdBJjJCIpX/18PoSMn4JEZYfwQmRJF2ohz+/E7XWrwpjhphIFRKcMhAmnD+mQFLYWpVWcIKpP/tMbk63wqy0cHj7aL9tNqlXyVRgcpl2xt3pv8sm5csuxnJIyKjiK4AVr56VGJ3ha/abeEjGCm/m5fhM71pl2ov4ai/ktKzvqKvxsoE2Jhl6TuaYJBcLVAIuuNy6D/4EHilMOYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb41e94-5fa1-4cec-a735-08ddce865cac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:57:43.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS6LSpzWdo61ACvxibvnREJWTwVO3XDRUB75vvY/Uoj+8rE1ew5pqAYn9hFc1kqxpVgPQIHjet+EwsM5A0wL67mBsURwOUZrGHPNeXpO8L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290077
X-Proofpoint-GUID: yG_YnX6xV5_hTqL-HYXICOsdK205p7hf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3NyBTYWx0ZWRfX++qvNQVpXjSa
 t07+jRduYEg+QPscRIbWzqhJxOHKRQunjx1bfwrG7PO8r/C5pRUCE6tQ4NnBJ5BUiTwgvuXIRS2
 74VDzCJtI/93ZZVfAi/wKxPC89FsImrHZISudnDe9Q5ij+W0nVmWtZWDAKmS5IQdNGAwFG7lEfU
 eC9onJ07KmQcZtXkOP7eve3yKIjzLg+HAzM3MFc+J4+vBZHwBIcbLz3kUFnIuURnYXlK9eVp+np
 TWRbO7VP82m+T+A1Rf3gA4zhB3UbBVYV0IDYCEat3BMUZYRPMnmCY6JUBNu+++/77k7aYU/kOTM
 mIsfrk+ZpiVSjXEJ3wkkvXlf7NudmBdBIFGsXNRQEmSKv+NjQL3FzErpLk0Bch7UQiIqHxLSqsG
 BacT6lu0sq4OoJbQ6uxT7LdFrrZEeX43Q7ULmdgb0ZIiNbNye43YoDsXm8fbiZM6nFtFXOGB
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=68889b1b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=2OiXAoeUM-DF6Iu2o8AA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12071
X-Proofpoint-ORIG-GUID: yG_YnX6xV5_hTqL-HYXICOsdK205p7hf

On Mon, Jul 28, 2025 at 10:53:55AM -0700, Suren Baghdasaryan wrote:
> By inducing delays in the right places, Jann Horn created a reproducer
> for a hard to hit UAF issue that became possible after VMAs were allowed
> to be recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.
>
> Race description is borrowed from Jann's discovery report:
> lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> rcu_read_lock(). At that point, the VMA may be concurrently freed, and
> it can be recycled by another process. vma_start_read() then
> increments the vma->vm_refcnt (if it is in an acceptable range), and
> if this succeeds, vma_start_read() can return a recycled VMA.
>
> In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> will then detect the mismatching ->vm_mm pointer and drop the VMA
> through vma_end_read(), which calls vma_refcount_put().
> vma_refcount_put() drops the refcount and then calls rcuwait_wake_up()
> using a copy of vma->vm_mm. This is wrong: It implicitly assumes that
> the caller is keeping the VMA's mm alive, but in this scenario the caller
> has no relation to the VMA's mm, so the rcuwait_wake_up() can cause UAF.
>
> The diagram depicting the race:
> T1         T2         T3
> ==         ==         ==
> lock_vma_under_rcu
>   mas_walk
>           <VMA gets removed from mm>
>                       mmap
>                         <the same VMA is reallocated>
>   vma_start_read
>     __refcount_inc_not_zero_limited_acquire
>                       munmap
>                         __vma_enter_locked
>                           refcount_add_not_zero
>   vma_end_read
>     vma_refcount_put
>       __refcount_dec_and_test
>                           rcuwait_wait_event
>                             <finish operation>
>       rcuwait_wake_up [UAF]
>
> Note that rcuwait_wait_event() in T3 does not block because refcount
> was already dropped by T1. At this point T3 can exit and free the mm
> causing UAF in T1.
> To avoid this we move vma->vm_mm verification into vma_start_read() and
> grab vma->vm_mm to stabilize it before vma_refcount_put() operation.
>
> Fixes: 3104138517fc ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/all/CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: <stable@vger.kernel.org>

This LGTM AFAICT, so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I'll fold a description of this check into the detailed impl notes I'm writing.

> ---
> Changes since v1 [1]
> - Made a copy of vma->mm before using it in vma_start_read(),
> per Vlastimil Babka
>
> Notes:
> - Applies cleanly over mm-unstable.
> - Should be applied to 6.15 and 6.16 but these branches do not
> have lock_next_vma() function, so the change in lock_next_vma() should be
> skipped when applying to those branches.
>
> [1] https://lore.kernel.org/all/20250728170950.2216966-1-surenb@google.com/
>
>  include/linux/mmap_lock.h | 23 +++++++++++++++++++++++
>  mm/mmap_lock.c            | 10 +++-------
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 1f4f44951abe..da34afa2f8ef 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
>  #include <linux/tracepoint-defs.h>
>  #include <linux/types.h>
>  #include <linux/cleanup.h>
> +#include <linux/sched/mm.h>
>
>  #define MMAP_LOCK_INITIALIZER(name) \
>  	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
> @@ -183,6 +184,28 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
>  	}
>
>  	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +
> +	/*
> +	 * If vma got attached to another mm from under us, that mm is not
> +	 * stable and can be freed in the narrow window after vma->vm_refcnt
> +	 * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
> +	 * releasing vma->vm_refcnt.
> +	 */
> +	if (unlikely(vma->vm_mm != mm)) {
> +		/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
> +		struct mm_struct *other_mm = vma->vm_mm;

NIT: Not sure if we should have a space before the comment below. But it doesn't
matter... :)

> +		/*
> +		 * __mmdrop() is a heavy operation and we don't need RCU
> +		 * protection here. Release RCU lock during these operations.
> +		 */

NIT: Maybe worth saying 'we reinstate the RCU read lock as the caller expects it
to be held when this functino returns even on error' or something like this.

> +		rcu_read_unlock();
> +		mmgrab(other_mm);
> +		vma_refcount_put(vma);
> +		mmdrop(other_mm);
> +		rcu_read_lock();
> +		return NULL;
> +	}
> +
>  	/*
>  	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
>  	 * False unlocked result is impossible because we modify and check
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 729fb7d0dd59..aa3bc42ecde0 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	 */
>
>  	/* Check if the vma we locked is the right one. */
> -	if (unlikely(vma->vm_mm != mm ||
> -		     address < vma->vm_start || address >= vma->vm_end))
> +	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
>  		goto inval_end_read;
>
>  	rcu_read_unlock();
> @@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
>  		goto fallback;
>  	}
>
> -	/*
> -	 * Verify the vma we locked belongs to the same address space and it's
> -	 * not behind of the last search position.
> -	 */
> -	if (unlikely(vma->vm_mm != mm || from_addr >= vma->vm_end))
> +	/* Verify the vma is not behind of the last search position. */

NIT: 'behind of' should be 'behind', 'behind of' is weird sounding here

> +	if (unlikely(from_addr >= vma->vm_end))
>  		goto fallback_unlock;
>
>  	/*
>
> base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
> --
> 2.50.1.487.gc89ff58d15-goog
>

