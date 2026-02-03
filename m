Return-Path: <stable+bounces-213158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJPtOVxkgWn6FwMAu9opvQ
	(envelope-from <stable+bounces-213158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:58:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C61D3F38
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4BA303C00B
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDB31E0EB;
	Tue,  3 Feb 2026 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPHDWMbn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA32D29C8
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087273; cv=fail; b=KhlyWves+EPOe3lQBoUyR4Wq3jcP7LpjGBnexpPWnP7a+v7CTcexeRn2AcSvZ9wT1CskCQ4YBMfpQKpyU1gR7aUtOQCrvDWDGjqGM6obIwVXrlX+GiKz1+FE8raZyG9gBZUojiKradrow2W6Z37fAlPS2FD0SbR4VXdSl+D+27Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087273; c=relaxed/simple;
	bh=Fv8DJJL90UXjZbZ4DMt2itF2PMXuuGKrzO2rJHSKn2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rgnvCLeNC3YPkpXMyJeGFVvqS+4HYo/oKrtSOpAXzNc1ps8fIQDoBf8wf7QO6aQJN601citDen/fFatMPpmCNJgYyVVZJXKnlAectj6iYwBY/1ho/JOrwKmEDWLV9AhrruzQ4gdbgSZi5rsT9aN9kmmINTWZuFu4cTvtr5y912k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPHDWMbn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770087272; x=1801623272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fv8DJJL90UXjZbZ4DMt2itF2PMXuuGKrzO2rJHSKn2g=;
  b=UPHDWMbn2dbJ/tkIOKmfyuOVSOLiLjKc8TTi1gQVTMNYo/XmL5nXH1Wd
   DyNfMzg3dUpZoGp0CVOhwplNt905V3MZ2OS4gaKPFFkzYMLiz5CPkdfA2
   J/l6ECDvMwhntNdXOgLZXym1q1aAVp7vD6f70SSumgkCjH+Wtx6ywbx3n
   zxedwZMbaF24htekkI/7OD82Z4Dr/eBXAJ4un4A4xETx8PStqwHasG89s
   avqXGvarsh9D3dATNPzn7rBJgeCs4uxHNBiYc6dQ6iVDK3xpRVbSZCq9S
   XYpx8JKsk+09eRf82X8sJniT2IwtVB2BnVE+q86KtB/ARiINiAE9dXmf/
   w==;
X-CSE-ConnectionGUID: AlczLPcMSsKzypJkmlPg2A==
X-CSE-MsgGUID: PKd9KOjxS+ChLamh5v3jCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71290632"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71290632"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 18:54:31 -0800
X-CSE-ConnectionGUID: 0Jl8Q+cpR2maU7zSIhxMuA==
X-CSE-MsgGUID: Db20xF/PQHSMs3U2FigVOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="208797518"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 18:54:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 18:54:30 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 18:54:30 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 18:54:30 -0800
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by PH3PPFAC6BA7F25.namprd11.prod.outlook.com (2603:10b6:518:1::d42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 02:54:21 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::b23b:735f:b015:26ad]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::b23b:735f:b015:26ad%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 02:54:21 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "Yao, Jia" <jia.yao@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Yao, Jia" <jia.yao@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Mathew, Alwin" <alwin.mathew@intel.com>, "Mrozek,
 Michal" <michal.mrozek@intel.com>, "Brost, Matthew"
	<matthew.brost@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH v3] drm/xe/uapi: Reject coh_none PAT index for CPU cached
 memory in madvise
Thread-Topic: [PATCH v3] drm/xe/uapi: Reject coh_none PAT index for CPU cached
 memory in madvise
Thread-Index: AQHckjTw83Nh8BnXNUmj+yygys4aurVwSdTQ
Date: Tue, 3 Feb 2026 02:54:20 +0000
Message-ID: <DM4PR11MB5456C0C970FF042E8A6E8B4AEA9BA@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260130220750.573838-1-jia.yao@intel.com>
In-Reply-To: <20260130220750.573838-1-jia.yao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|PH3PPFAC6BA7F25:EE_
x-ms-office365-filtering-correlation-id: 307a716c-edcc-40c5-30b7-08de62cf87eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?6nXeVbBuqnjeVjFioyewlqB/+W2si2b8C0mQxEIVK5/sixsEPGl854kK5cyG?=
 =?us-ascii?Q?Apo6RpvpysaodrJhxp/DkNA0cBbdBYmhItFz4C+Bd4kkK+fyxedBuhRJaCib?=
 =?us-ascii?Q?l1ImGhuxoGdm9V85DR2KjRKkZIJKYa3ykrlvf17mqW9QQJOEIJdoekCVmC0q?=
 =?us-ascii?Q?VmR109BMUkDI0S0igsdw6J+Ga+uL/Oa3Ha+setwewPQ0UJrnIsjg+mULcrAB?=
 =?us-ascii?Q?KEmoFynPJtpL6Vc4cxG00KcA21jgur059CAOBpknmzhkJgdL6q1jA+/hkX/L?=
 =?us-ascii?Q?HnFOyIzI3yVSmzRiY6EGB7Olu71BNuYupIdawMAIIphkbhkshVmWmZhYyUeS?=
 =?us-ascii?Q?Cu4NoWUfvUybuJBFhH+JE1FeSPwZuhZfqJonz4wNEVleGh5BnGV7cginukQ8?=
 =?us-ascii?Q?t7MLV8j9/zeOfiaETxbgmdLBiYbuV7KFt+kjVgh5rHeW2igt5aJQ+LeQHxS+?=
 =?us-ascii?Q?NV9A6fTeJl4ifOccJezDRlPRoiUpj0bMN30M1dAVKTYrdkKVuEZbbsqoEUOE?=
 =?us-ascii?Q?eaQcIPxsOsrCYu6xZ7Q9LaAlmu1kdFWJNQLetQDZLLm3ExvcPbJhEnVhF0jn?=
 =?us-ascii?Q?inn21oI5O9wcdIVQVlOU8nkIa3heZz+di5ryFm+IJEEXXLIsdaJjSU2BZJzW?=
 =?us-ascii?Q?ZtckHYg8tyd434xNDzasP1/GkVQnRDDPQUC2j6pbt1/7a3Hf9aJLuhIw4R2C?=
 =?us-ascii?Q?jlWSuyYzwRnusfA0DM92Z5cZaeqcd/emBn2MRC+ALmIaT9iuXLJry3x/MMD5?=
 =?us-ascii?Q?LXDJ/7RRqA0XQnRUpZPbyHrcIs1b+mJE5R1yXfzb2guSEEE2Jlm1L56gHrKF?=
 =?us-ascii?Q?hEPK9H6cPiiup/1GpDBVLnyfebjlHOEYImpKUaXQssg5UQooKePBrYcDzEAn?=
 =?us-ascii?Q?1o7UYDh+Oe9WY6QbceW/HRPtL5pRNBBGmEMiM0cPY8+mAcrtttC22Hw6DE1E?=
 =?us-ascii?Q?P7gHn79/dTrMk6qmePyfTXFUAVSugvP7to+kq4LeySRJfl6fod2uQLnytfeH?=
 =?us-ascii?Q?4H4bdZdg6WSHBFbTXg2hcqNYG/JjC7wWPdvCJdmIHU5yymHvWfpBimxd7hHu?=
 =?us-ascii?Q?/8O55nLzsNGj/eYgdV6/gycdX6Yeb7hhT7quXPke2dYGEC7KjDL6ojBOxhIj?=
 =?us-ascii?Q?YyWpio6PTIapgaBPYBXeTyUUjSdvKwFXOF8b58efUE5VCmCaDrmvrpd+hE6u?=
 =?us-ascii?Q?QHcN2VKO1nFHkER75GmGCExx50S7DdiMZnLwgxpBwfnPVF4qSFQds5UdNh4C?=
 =?us-ascii?Q?Zxuw4ED9w2NakJVuOr196kK5cLDxSdiSNSrwXVuWyPlvmVqgBGIMLsDc5RMQ?=
 =?us-ascii?Q?7z6WATNFmkZ0b6tbSCWqqItOgPdwqZaRpYJ4k7ptotIFQvDjZ9j73LUqgLdf?=
 =?us-ascii?Q?U0+3ptLQEsdlXN0PcahnFjUbWXDyicYDSEB9zAS1g77QeoVlvDCDDRf50F6i?=
 =?us-ascii?Q?ZGMv0VWotE37rdUf3xmaIg+4QkRnbTlC6Jo6wmmUZRY84TQXa1JsU0vNP91H?=
 =?us-ascii?Q?yTjsirpm7BAHotns8lof89gGcBhYtfOQXmfbC0WMmR1fW8c+Pg3d1W3SE1I8?=
 =?us-ascii?Q?QhRV1w6sApPFhjEQkBK/SWAhDvsIqVJy2n1hJl7Jsy+uIL2jbt+aFMYdxPke?=
 =?us-ascii?Q?f0ccTh71BCnxFLyCEyT9m2k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9aNi7IHCuZ35lBah3+bsFcqsnrlM9pAIUx02p1fztVPYDzbj4zbxRFggeIYG?=
 =?us-ascii?Q?RVvz6u04Z3dW7+9ogzRnmyunLhBmKDSKPbTE8F5QiT2gBwrK5nlkduFrRaBL?=
 =?us-ascii?Q?ZtM7r2a9yYrTPltmjUBrrorj36u1mHVYw1nCLCeL/mbHs/FMryaTVj5AbdAq?=
 =?us-ascii?Q?65sOiJMH2HlNyKBLM0vXqhYXpHkHN0NcTuX91GTwMAyZzPnhSyZ1sKT63xtX?=
 =?us-ascii?Q?oqGk5REqMFYN4d1lNYi9iW3L5TTH9RGQqRf7tAlzMKjfY/v+dDyhoPT1IRrR?=
 =?us-ascii?Q?lRDhoBqTwiSo6FMt8bVruNlyOjE28B6wFfUb5QRaEMuJGBGa7UENLeFkwbjH?=
 =?us-ascii?Q?pVS0kp1yuZmAvlNRq/bTVYTYl0U7dDOrTMap/zLO9yQqlRzJOgHYIbqdB/oq?=
 =?us-ascii?Q?sgQfoXBs1BHy3DsYhQrgSymw2g2h0TD2tdbWzPQZ1kdpMXKmOzWli+SjX2/B?=
 =?us-ascii?Q?2bs1MAGu24D6F2zPz5tErusdgqiY5U9DsJkLZq9aHWYvU3MK96tGNWuHPlDh?=
 =?us-ascii?Q?VtVQFC/CGv94mTURuWEDocm3+U9gHWZuga4EaNW3Ru5434Le809CT6o1Cggc?=
 =?us-ascii?Q?f5SBqS7iaK7DcuhnERCDWpgkzLtcEcXa/7cF0r1GQmFlcSYbGPQMRjLJFo4G?=
 =?us-ascii?Q?MwErF8jRCukj4tJI8cdJnN5bjoMxmKn53eQkgvXY8TotKlr/ur9wyJpPwpAI?=
 =?us-ascii?Q?wMQWlh0UkcNY+niCxsyKxc5WZxFaiyKLHdl1eXXMr6eeQe7bPqqYm579i0w/?=
 =?us-ascii?Q?NhfiZTN4ojkAZQeju8yEDIUU9/8IGzzpIueZ+swbKUdVETXcBJVLG8tKUiAI?=
 =?us-ascii?Q?s4jtY+CQEPg4hFULo/kBzufopOwWkQECjmW6uO3dPwEIbnLEHz2zHA0ddzEE?=
 =?us-ascii?Q?3KtXtNMsMiE4qfuMQrSmVWm2IUY1woDDeziUyrKQUXkdcpFWBApi6/cxKVFZ?=
 =?us-ascii?Q?plHp7RheSNByjuChb104AkEyp3KZnPa3jCbqdXYYqpf4YSAwDeUGQ2o/DFLE?=
 =?us-ascii?Q?v8ripWovcYGn/xNHzlyvqAQkeLMkoPsoibr6tZSOJ+4yBBVkEX7Q0zluF93y?=
 =?us-ascii?Q?Yw9VM7Pok4NYYXwBf4J/5/U0UPHa/wkS+m6cJFAyW+Zvskx30DFinDaZjHyH?=
 =?us-ascii?Q?F1L2eo/fTATNW9THdN9U+rILntgoM5EcSRxqzGMTQxxTR+rMd+etVxqxCVjK?=
 =?us-ascii?Q?pZQNVyNiN//G/di7gV+HOD0NoR9MaBInXYGs3betsjEEGosXI0shg8BmAIUM?=
 =?us-ascii?Q?XrgBDe1n5LhDr9VskdhoW6TKU+zbMTTzmCRYGIKRlBkGg3pscY6r8fOJ+cks?=
 =?us-ascii?Q?r5Qzekn7sXKx9YzVziLUXroevUdTsnZqS3rKWURxlnJi4hibOMId7oz5mfyX?=
 =?us-ascii?Q?9C0keE2CSlrDlLudpYaIjaf73ig272K0xmgp+Qd6J3s/zSzbwU/TdQEMp315?=
 =?us-ascii?Q?isEZcYpdcRCD7m2Szt4O1LY1weZo6u8kxYHdYWMPCrd13lmLDCeSKF+JmiPK?=
 =?us-ascii?Q?JeswALbrh9HHj8wkWfWzOlO2wZLeR/+tksKo+LpCOmwtn8eSCjNLE6IVFxMI?=
 =?us-ascii?Q?olv4Y5m3wGTCOhJsLUkdvmHIV6H5QS54+sujYojZU7hzIlzcedL1WFcOwJue?=
 =?us-ascii?Q?tsQqSLDM1rZWuYXJisWIactjScOHwpSxDVpADKUbf+N7JMVkvmTeO+7lMENf?=
 =?us-ascii?Q?g3kD2Wi/5v6yp4jAp8i59k/mdKbS7xrgwQhY9kGGteQ8+Fep9qwTt8tWyxWV?=
 =?us-ascii?Q?F2kLhn1Khg=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJiSHdIitaFdhujoSiZ7tI/id5iN11DNzgaFsvF5Z/0M3ZHQdPMZV4qy82Dy6R1kNHe5tZ0xORf0c2O1o/3u/DQzfVrtQ5t61jIbu8dozbGlNk90HaOtzgZP/KMmXrX8yyjzArPqlcD/UM+ojSwTdi6MsldABGWCbEtWF3J5/inFYVGBkkSP+zPz+2fl42o5adxcH1AJEMyl6yYEoAHoAWeE9CTiBPj1OlxJYURJOLhs/pTcn28z/JjWQ4MI8iZhSsQHYoF0KRqBSsPju0ScUlyl8DJqyRCal9JOVpCCht3F3A+NrDw7t6sKF5VANqfjiZGmqKRn7YXMPG7wEyCXhA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgcz5HTcx/bW3sg3aQ+YHLuQOdneYYM69LRVaHnX4Ks=;
 b=Sl2f8JDDT+nbtWSb+/loWEm2PEThAeyKEvQ9h7lZvvuXQW6St9kG1lLPdAWtGTJGnTbH6eSuLhCs7e0XufrMphHtY+SdR6yPainqS2rTuohSkfFmMEHxZecEjO7gj80jgw9RwKSzWj1Nls7U+eayeYUpMf3zsAGWhahxa2+sov0UVn8O04q40IjteAFuAOZNMc2LzgZJlEkInPrLhuq4owSZgCH+hK0tkSYnf3T/gsIa/OifQMvK/+l/UQE34uFSnDoZRec6/n82NUEF6+2vNmrcZ1WY0dUElpNA2PUCA+jcLEjKa8VzzXxhmpgBRDxUJlEA4MPwkc2eDNvL/3JaPw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM4PR11MB5456.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 307a716c-edcc-40c5-30b7-08de62cf87eb
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2026 02:54:21.0817 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: JwUW/rhT41M+p3QgyGMTKyNeAn5cqSrApjL9mXUlzlRG8o7f9TRy8VpPDrtb2paBnsi+kw5Lo1DKBqRENpiEhg==
x-ms-exchange-transport-crosstenantheadersstamped: PH3PPFAC6BA7F25
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 79C61D3F38
X-Rspamd-Action: no action

Some comments not for this patch but for related code in this file.

On Fri, Jan 30, 2026 2:08 PM Jia Yao wrote:
> Add validation in xe_vm_madvise_ioctl() to reject PAT indices with
> XE_COH_NONE coherency mode when applied to CPU cached memory.
>
> Using coh_none with CPU cached buffers is a security issue. When the kern=
el
> clears pages before reallocation, the clear operation stays in CPU cache =
(dirty).
> GPU with coh_none can bypass CPU caches and read stale sensitive data dir=
ectly
> from DRAM, potentially leaking data from previously freed pages of other
> processes.
>
> This aligns with the existing validation in vm_bind path
> (xe_vm_bind_ioctl_validate_bo).
>
> v2(Matthew brost)
> - Add fixes
> - Move one debug print to better place
>
> v3(Matthew Auld)
> - Should be drm/xe/uapi
> - More Cc
>
> Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
> Cc: stable@vger.kernel.org # v6.18
> Cc: Mathew Alwin <alwin.mathew@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm_madvise.c | 47
> ++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c
> b/drivers/gpu/drm/xe/xe_vm_madvise.c
> index add9a6ca2390..50b82e821da7 100644
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
> @@ -352,6 +352,44 @@ static void xe_madvise_details_fini(struct
> xe_madvise_details *details)
>       drm_pagemap_put(details->dpagemap);
>  }
>
> +static bool check_pat_args_are_sane(struct xe_device *xe,
> +                                 struct xe_vmas_in_madvise_range
> *madvise_range,
> +                                 u16 pat_index)
> +{
> +     u16 coh_mode =3D xe_pat_index_get_coh_mode(xe, pat_index);
> +     int i;
> +
> +     /*
> +      * Using coh_none with CPU cached buffers is not allowed.
> +      * Otherwise CPU page clearing can be bypassed, which is a
> +      * security issue. GPU can directly access system memory and
> +      * bypass CPU caches, potentially reading stale sensitive data
> +      * from previously freed pages.
> +      */
> +     if (coh_mode !=3D XE_COH_NONE)
> +             return true;
> +
> +     for (i =3D 0; i < madvise_range->num_vmas; i++) {
> +             struct xe_vma *vma =3D madvise_range->vmas[i];
> +             struct xe_bo *bo =3D xe_vma_bo(vma);
> +
> +             if (bo) {
> +                     /* BO with WB caching + COH_NONE is not allowed */
> +                     if (XE_IOCTL_DBG(xe, bo->cpu_caching =3D=3D
> DRM_XE_GEM_CPU_CACHING_WB))
> +                             return false;
> +                     /* Imported dma-buf without caching info, assume
> cached */
> +                     if (XE_IOCTL_DBG(xe, !bo->cpu_caching))
> +                             return false;
> +             } else if (XE_IOCTL_DBG(xe, xe_vma_is_cpu_addr_mirror(vma))
> ||
> +                        xe_vma_is_userptr(vma)) {
> +                     /* System memory (userptr/SVM) is always CPU cached
> */
> +                     return false;
> +             }
> +     }
> +
> +     return true;
> +}
> +
>  static bool check_bo_args_are_sane(struct xe_vm *vm, struct xe_vma **vma=
s,
>                                  int num_vmas, u32 atomic_val)
>  {
> @@ -442,6 +480,14 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void
> *data, struct drm_file *fil
>       if (err || !madvise_range.num_vmas)
>               goto madv_fini;
>
> +     if (args->type =3D=3D DRM_XE_MEM_RANGE_ATTR_PAT) {
> +             if (!check_pat_args_are_sane(xe, &madvise_range,
> +                                          args->pat_index.val)) {
> +                     err =3D -EINVAL;
> +                     goto free_vmas;
> +             }
> +     }
> +
>       if (madvise_range.has_bo_vmas) {
>               if (args->type =3D=3D DRM_XE_MEM_RANGE_ATTR_ATOMIC) {
>                       if (!check_bo_args_are_sane(vm, madvise_range.vmas,

While go through the code, I find it is "goto madv_fini;" here, which shoul=
d be corrected to "goto free_vmas" also.
Could you please use another patch to fix it? Thanks.

> @@ -485,6 +531,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void
> *data, struct drm_file *fil
>  err_fini:
>       if (madvise_range.has_bo_vmas)
>               drm_exec_fini(&exec);
> +free_vmas:
>       kfree(madvise_range.vmas);
>       madvise_range.vmas =3D NULL;

This line could be removed; there is no need to set NULL for a local parame=
ter here.

Shuicheng

>  madv_fini:
> --
> 2.43.0


