Return-Path: <stable+bounces-235676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDyIKP5+2WmjqAgAu9opvQ
	(envelope-from <stable+bounces-235676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:51:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2829F3DD530
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BE9E305ED96
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D1344DA2;
	Fri, 10 Apr 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnwsLv/e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207124EAB1;
	Fri, 10 Apr 2026 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861462; cv=fail; b=YU6kHX49B1AvWAT0F1smBgfGLBNj+AqxiaOZBB2sikBGtt0pxJem3c5LvDwEBdLLrr/cdrN9fqIzaU06E8aBdKBnmc8GNa0b5BT2yglSXBp9CQElK5BKiYhQox5XYMBWZ9q7d35+2dLHHXfgAo81eETayidKCHKSiLhl2ThTQQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861462; c=relaxed/simple;
	bh=/sq7p1G+HFGllN2NlZsGLcKzI9Tb4hHJBcANk4+1mQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTgjaxknqcuxh79jM/NuSvneaOXpUBH1TVL+LbdOXL8zIOodgli6/FMg/gdUGkpO8/Y88QpRteuj5rDczl/A5/D+LzcgDxNbmtXQBC02UNUCdLG4+qWCi9svxOtVKIyGZlBKCAFahJeyBWdifCtyH9+VFaeAwN3BhENZ/BfEFEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnwsLv/e; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775861461; x=1807397461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/sq7p1G+HFGllN2NlZsGLcKzI9Tb4hHJBcANk4+1mQU=;
  b=bnwsLv/eokoiKSdG1vMEOgjZdMx9C1mWuUQgUSeKnVZomBuGcpj5n2Yi
   5sc67QndDE5fNB1DM5WQVJFZbygPGVvCzbVkx6GAHHEh+icRfP0qxSkyP
   WW7D0n9N/AEshAcTrmB2HG7Vs5fBzNHjSPBmFJ1MZgb8oDc7QHhl9T0EL
   MSJCFMIzLQqd/PEPpTz79xxzDVSbsEdpzLnijbu+GanX9eopXOmZMQ3R+
   AZZFe10FCEFdqohAU7bO1AG58zWyNqYQ8JK2RvCv65WS8sDpLTORZHNGS
   vKghVi71Ci/pj02unfGDKW1gCTHnuyhSjTbjXbl9iFFFQHyWBcx7u/pws
   Q==;
X-CSE-ConnectionGUID: Vmoc5ZpVRCKLXVZBSN5baw==
X-CSE-MsgGUID: R6zEq+yNSHmOPgv+csBGuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="75929351"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="75929351"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:51:00 -0700
X-CSE-ConnectionGUID: KYuLSKeRSFm5TCuTb5gzFQ==
X-CSE-MsgGUID: 5jP6zc86QPiKsY/RH3/Ztg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="233615781"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:50:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 15:50:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 15:50:58 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 15:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCGGsDmivUcHqpac0+lwcZu1CO5w4PBAU3GMdSbutN+TEUmrz0csEIzPzc0cqq3X3OaVLYDeuEU5MnFBhlFYgV9OaYhL0UvqckV2VQt3JHEXb6cXuk6a92RVkNOdIbeMHS+zpFLSaqazt0U6j7pVNs+tr2le636zoiTsRg4810o1QLBetZwfG/5KaoaOcvASS3fFQlhw795e7uCg96viL0G5wqpU2CiOXgOEWAW9zj9I3df82K/8o8OaYsWZxZD2f6Rt1dgZunasQp42jvDkQCxVolig/cTbKbv8C0sK12iqe3M5nmbsMYAQe8GWHtlE9+S8ryvmULOcoZadEEiLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoLHXog4zBjbS2hBGrBDJVrLWY48Wo4J4PRxwBt5w28=;
 b=Z9GdQsg/+/VqJfupC+iL4NN0l48Vt9g7mUR/swEmfVkQId7OnM0WIx+yFY3113i88pJjUVtkyyWCkTI27zTg63wq+v5SzahV61ZnxDYlqRMkKKKDLvaG2/j32ouyJDnNrQseyyg+UtHWbepYwxnSsdco4sDjT23oFBLIJtXOWIiFXzTuD745qEaB3x64r14FOH6e+bf3McCOeVO7YFn5ru0YWWmJnl59k5FuxZCzB+3aBtciiObkX+b21J69bldbcsWqEssgjTNKtEPcq4qZdN9V1shHrjYyfp3N5LGcUV9XA4fq64EtohPCu8e/Fnalk/sTDwddZt8X5Ud6v8IYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Fri, 10 Apr
 2026 22:50:54 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 22:50:54 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	"Shameer Kolothum" <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>, "Niklas Schnelle" <schnelle@linux.ibm.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/2] vfio/xe: Add a missing vfio_pci_core_release_dev()
Date: Sat, 11 Apr 2026 00:49:48 +0200
Message-ID: <20260410224948.900550-2-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410224948.900550-1-michal.winiarski@intel.com>
References: <20260410224948.900550-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000215.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8cd) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|PH0PR11MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 07646e3e-5a74-44be-6849-08de97539f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: z14iUsFzK2UttLPYVsgf90AK8vccUalCGHabqYdBDjn7gmLusTS51FuU/J44JzoQXfzRr0ryU7nuZbef8U8VYi1Lq1Yk/xs+691JzxvFNtbvNHyixB3uALssc0fptg6dBHOJFZBM6EN73msNNiZM67l8kxr4IHOwaFZlIyS9Vxe6CH/f2oP0JRKF4EvBdZNjmLAXsZaRlTQ7kT91tZtZACqPuOlUBsOUa7hDB/8OHWyLallOOtb2mzpCJFfcv6fiyAZrBOAD4fa8zx/c36Av2c2J8Y/C9r/OKt0nEbk4r9zC3SlCOmNUAsTtRickD6AEofPRlZP6DIoF5cGmxYGVQpIKTVX0VHMvHqXBKostsvAipAIltGyEpdWJKVNh1NCYfkc40u+lQbCOnEJjHR4FZnbx0NEraes+H76qJ2QpgPpDRparWyDHbKqi1yK8obYzm7V0OiHhY9htGZmpgprG1cypMh+lz8ytX8hbgOmQgY2ne83L1HutZsrWyGWdWm2zZ8S/iGxYy1NNp17Wklg8j5GCSLkkGs6/fPhoJsudhlPfUUf49za4AuyklgA8g6W9ijP4Ia6E0DJomCVuGw3VMC+6R7xgs6ltPPMxPWnLlJrlMDl7qXCVd0lpx8xs0qVtME0kUnxSBrEw2lvuca13z0TGlRqah7aNdjGsnr0KFSF6JX/v6MltgrB6R1oPsIX6IG4vWsy78V4+pGtHqoD2UGiim/nL60REkKKq1ObyVW1c3PfIqcrJ+1nDILY9cF4s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3krTjNTZEFtVVhhWS9jaTRucHhyVm5SUU9XTVU1Y2JENGt3S2RTUENmS05Q?=
 =?utf-8?B?QWtxNHNsczBFdHhwZzU3T0lQSmlCTE1TZm9ZVlMraUdJKys0bHkyYUNFcVBP?=
 =?utf-8?B?OXNhYTVTdGk3WnhjenBVRnFoUXBGazVITFVycDZJWXY0VlRVRDN1dTg1Unlh?=
 =?utf-8?B?YnM2Y3p4Y2tRWFZNZEhueWF0YnVINnZrMHBBRTRkdFc2MTB0Y01LSUJDcE5a?=
 =?utf-8?B?bVlPZThjbFNib0hUSmxCNUxrcDl4TEJocGF6ZzZHVUk4eW1reVVYTjZ0UnM2?=
 =?utf-8?B?cXRrL2xua3IvVFBiczI2cU11aHBKNEx6eEFCZTQ0dGVBTjlOeGpOUE1WMWhz?=
 =?utf-8?B?NXFMcE9sM0IyMnJCVzdNNER3S1dHaVpQUTRycWowU0d2aUFRbjJhaTcwN242?=
 =?utf-8?B?b3ZSTGQ3VHpRWkhuaEIyMytHdDV3eFk2K3hZamVicUJCQTU1cXhYZUtqMDF2?=
 =?utf-8?B?Nld1TXRsdGxmRkVDN3E2UFlOSWgrU2RZN0FqSkFSTUhzdFpvaFNUR2tOOCtJ?=
 =?utf-8?B?enBBVmYrNFBFNVB4cnRTL0JXOVNUTG12S3hkVTBWMldnb2pLTVRWbXk3SllX?=
 =?utf-8?B?WEQxdkJPTmtFcFNDM2QzK2RFcmk2K2NWdzNxYWcrclpodkZxWHdKQVAwMnZQ?=
 =?utf-8?B?ZjBZNGZYMDFXMldMVDVOQms4d2lRZE12WnBUYUJrdTFkSEp3R0JiekUzaGJo?=
 =?utf-8?B?QWFQMnlCNm5UQ1MzVlRTN0xHSUx3R21FY1dLb3RYOGpJUzVhZGo1SUJBRHlH?=
 =?utf-8?B?eEhndkpMVmhQS2EzVmZBSW1VTXlZbENWUVJBQjAyYnQrdDBuS2hlMHBnVFJN?=
 =?utf-8?B?TkVqQ25qdFVtTGhRWElGOUN2dzV0akFUUEFNYlRMZ3VGcEV6VHJPRFp5WGwx?=
 =?utf-8?B?WnJEUkZwbFJGVXp5MEtNVWhwT3RaKzlXRGQyM1FMa0dnWmQzd1M0NGJ3d2tO?=
 =?utf-8?B?dGdKMWxtQXhDSXZ6Rnh0cUVVWHJTcSs0ZHVqSzAwYmZ5aEYwVU9tTks3SHZp?=
 =?utf-8?B?bWJoYkdvNjVtMjJMY1d3SUdpU2RIamZpWkFjaFRZWVJpNnVVeW9MRGhwK2VT?=
 =?utf-8?B?K0QzYWJDOG5rSndhNGhONWRBRllNK04xUFo3Ukc4N3N3SnQ4WGVLZEtaTnp0?=
 =?utf-8?B?Tzk5KzYwcXc3ZUZ1bTJiSFkrdUZraXlRQTBpVXdJWjNSS3k3aVRZTDhlcFN0?=
 =?utf-8?B?bUxWQmpQZUl1d2ZpNitNN2NLOVA3eUdSSmdGSEJSWmREMXJxaG1xSVhmbVA5?=
 =?utf-8?B?cTJoV01pWlI5bWxXR0JPdEhuRHVabklMWU9YNCtVUkorMmljNTJ3ZUMzdUlB?=
 =?utf-8?B?aHF6N01VMmg1V2dTYTBKTmhwQ0NqUi93c0JuTzRDZlNxWVhlM3lRKzRjRnRD?=
 =?utf-8?B?Q1RFUFBwTVJKM09WRGVNT01GcTdVT1A1aXp1UW9nSUJadmc0dXI4U3p4eFd6?=
 =?utf-8?B?aGp2aDhvVng0UDV4S3JCTCtwS3FQRHZWN1p5d1YvQk1EdFh0a21hWE02MUo5?=
 =?utf-8?B?dEp1bXcxZnY2amxwZDF5bWt1T0xCb2RPWWFTMjd0ZVJlZC95eWt4WkhWZFJo?=
 =?utf-8?B?N29nN01PMDllTWovSUVrZGwzY0pTZllwRURseHFCRzFNeUtITjdNL1g0cWZv?=
 =?utf-8?B?eVdLMXk2UklJa1ZCUFRSNk1lbEpmT1VyVlZGbkEyZ3JuRnZhRUdEa0tER01E?=
 =?utf-8?B?SDZuTW9tcjFsVW4rQVpKVjZOSFNRdm1UTEZQVk10K2xiVUdGaVJtY0NrNDZE?=
 =?utf-8?B?Qmw5MER5QmZ5ZVVZTjBqVUNITzVMQ09ZVDN1WElNek82ay9KUVc1dzZPL3lI?=
 =?utf-8?B?S1ZCeVdNY0dRNlpqNyt3VndKNFU5ZWE3d2JjTTR3WWVoNCtON0pXc0s0OUpL?=
 =?utf-8?B?bFFNbDhOMUF4RWdSMXZqOEg5Z1gxM0Q3T09LbTdrZ25uWWttY3FsTHRzWEFF?=
 =?utf-8?B?b3lFZ3FEdkRwRFNyVU9RanNreEdZazczRElyZDk2R1ZPOFJjdERaNFo4RCs5?=
 =?utf-8?B?NjdnWXNKRC8zVjltaHJzWk9JMTJLalVtdzFMTDZpejBuV0ZtY1FmQW9RU2V0?=
 =?utf-8?B?S3JtR2M5RXlOaWZIWW1qZ0xzMkMvK2E3REZHWVpyZ1VBeFVtdUtzTytKRExL?=
 =?utf-8?B?amJjektqVklUYW9QUWMvbDRzWHVPb0RvSm5FT0wrZjRPMHpTTzBON3lVTlR3?=
 =?utf-8?B?MDZiQTFLYmNiNW02UC9IclNFb1JHeUJZWVpUSVl1Ykg0MEhoUWVjUjZRZXZ5?=
 =?utf-8?B?QXJZTy9sbmE0bU1HSUI0QlJRVC92S2J0SFhrMFREQzFyS0wxKzRyQXhFdnps?=
 =?utf-8?B?aEoxUG5BNTR0MHV6VmVkeC9ZOE9lVW9PQVFtTHlmMXBZMHFvWXRIb3VUelVo?=
 =?utf-8?Q?6Y1sBp+GI8Ps9muQ=3D?=
X-Exchange-RoutingPolicyChecked: jqoZ/81ckbMibRhBpDT9LSRxESp7ktHHsIT1dhDxEQcxLvY44CBaWDBF9//ixpTxIasZJSyFd4gAAKSthTGmvB0RXMVcn7uF6b+mLMWiwWYdFVLEzGUpOqsGQ6cRUtNfV+wBRlL6Fae/0A+MzGXvi5kQrVKJYFPQ3jLKAl2eVzFkNsV15B8kv2SWoHbK1+wjAIYmzSMy2fyRH66kZC4IhvsnEUJ5tlBPJeMbtvBk6HlTTCYUcKNurNhcPH/qpEeM8MAeltdDgBt3Jp7kasPkGBArGcieH++/hMLmp39wAjJEOt9uT8u6+zuukaS5uqmBco3q2LwHq55UP4UDw6DBFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07646e3e-5a74-44be-6849-08de97539f47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 22:50:54.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2EafgtuJLZ7blOHxCvOrlHHzFQvZGo5S/mvWRJX5MHl7sHsAhvXCsbOdxJAaDZYNmZwCtKnGbtzLPVykIPGpuSOILzsScLo3UATQk2R6fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235676-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.winiarski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2829F3DD530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver is implementing its own .release(), which means that it needs
to call vfio_pci_core_release_dev().
Add the missing call.

Fixes: 1f5556ec8b9ef ("vfio/xe: Add device specific vfio_pci driver variant for Intel graphics")
Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Closes: https://lore.kernel.org/kvm/408e262c507e8fd628a71e39904fedd99fa0ee8e.camel@linux.ibm.com/
Cc: stable@vger.kernel.org
Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/vfio/pci/xe/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index c20011eb4af3d..4ecadbbfd86ec 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -518,6 +518,7 @@ static void xe_vfio_pci_release_dev(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
 
 	mutex_destroy(&xe_vdev->state_mutex);
+	vfio_pci_core_release_dev(core_vdev);
 }
 
 static const struct vfio_device_ops xe_vfio_pci_ops = {
-- 
2.53.0


