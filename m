Return-Path: <stable+bounces-197578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F83C919DD
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 11:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A573AACCD
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFA30B525;
	Fri, 28 Nov 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JkIho1PB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E133054FE;
	Fri, 28 Nov 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325594; cv=fail; b=mLfxoCZpxJJG1VtQCThBVrjxPQEke97CNJ2tOK+QX0M2geIswhIxZyyn6QzlcYSilqAhJ96jJpan+ki7StLvf8xcGIwZn5vr0rwLWquySLNT1SqZdfcL8wuNMxP06vO0dfJBeoS0+Q/N0Nt8Nv8oV3R5F8DBS1CiQX9uOdcwhBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325594; c=relaxed/simple;
	bh=azKnxbQrgu7zp3P3XydLlECLpRlbCQN6p5kjDDVe98A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IMsO/VUQ5fQCiosRagNBoNzD157P/Aw/izWw429Xuvvwq3xp3Vgap7OrVkf/ahFOCaT4pYN9zTviQDsc23LJ9nEHlNw8Pm2rl4b1NS/5apPiemf5XSpBBq+AqVKhF/3EZsDCZbhq6o5QZ4GC+/87sR7IpfmQzwvcfLN0ojAiik8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JkIho1PB; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS5mukk3437377;
	Fri, 28 Nov 2025 10:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=iETJe7uIKHVuphNppkMXrGOLMx0QIPUUpxVM0e5+Gjk=; b=
	JkIho1PBiJCxI4wmm4H6W4D8zNnoqBGvivBeYnGZWbqNz2ZMXjT81jOIcnolOAtZ
	cJXceOwW7VCe2v3JodkCSSru80AxTkmrHqxccRYd7sS/902ivD9a+rX4D/yxGdXE
	5yCY3lexrtjnVV//7IN5pvzlQQMDmvX0NcyCv6RbTi3qTmalt/SHwcwS0EmIR/Qh
	kV0UCFKF+wVh6b8B0fhASMqAcx/RYNmj18Qf2Rrah8D+R0p2ChTBRrqJlBChUYkP
	fgm5Is1FeVCTw5V0sELqUKSkXSxDvTUb3iPu936cH3wScKjScb4KTYp0y9Dvsqzs
	gPjOftNoEoraEQip/ekODg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak455psmc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 10:26:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN9RZfzvNlrgz018+wGCsDd/B2cWm7DcGvFyYu0umeTq4jTx+tJeDNlBlH4E53JwR8wmvFD7f5SsFRZ56j5ehTrcSN14faSzkzerzTeV0d+TmtEuo0fh/dVTfQB/akdq6DN1vjTvUtPty8JtZ4SpLUxROlGFE4QYQmNPLJnXDt6lORMXLSm4WR9TDeb4x3G87pGQkX6WYgFVv+nVGgo4T0mIZ5SSk6frFRS0uWZLshaZXacOUjERCs+gUfck8MHPEfrZGLaph+/2XvcRjcn9NgiMybXOSYO6JIoCx52vcWxPQcUY+o1Lw8+46Uzr2GeKSAqx+4NtMkVts1gvoR9vTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iETJe7uIKHVuphNppkMXrGOLMx0QIPUUpxVM0e5+Gjk=;
 b=VMl4MxJrMPC+LWSUkhrlJ1bhRIVUA7fg7H9W1fIZ+ZnHAArqE1zjkTgL1yLVrbS4oVcjJcOF9SA6fM1WUidhtulSpzK5GG+9ASOrBp6x9RV251Vn2N8yK9Y7ubWO+E0J3HZUFMmrS0YZ7wVPea0gZw6Cq0x8MonxVY849rh0n1bkHOTZvvbmNvGHDgUG93Aw8j1PGQKLXymWa0zpnE50cLRvc6DZV11oZQoWKm9BWzynlA+vzhWXWsHJ75PvqMTKBSGk91qmfHmlPVY+zDOnQSh13uz4qzusBwsk6m7M2CYt//ownhOyrkYIBkSDjArNi6czEwZxV+ePQB4A8yaOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 10:25:58 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:25:58 +0000
From: "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>,
        "david.e.box@linux.intel.com"
	<david.e.box@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
Thread-Topic: [PATCH v3] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
Thread-Index: AQHcYBgSMpAr6bNYxEu4NYlaJlo5yLUH2bAAgAAItcA=
Date: Fri, 28 Nov 2025 10:25:58 +0000
Message-ID:
 <SJ0PR11MB5072C6A22897BE910A4D9866E5DCA@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20251128033254.3247322-2-yongxin.liu@windriver.com>
 <42e5a7c5-4d18-4e89-07c0-fdfb2b3bc28e@linux.intel.com>
In-Reply-To: <42e5a7c5-4d18-4e89-07c0-fdfb2b3bc28e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=4bde0bfa-9590-4052-8679-9ffb942fe567;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-11-28T10:25:17Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5072:EE_|PH7PR11MB7074:EE_
x-ms-office365-filtering-correlation-id: d69814db-6ac5-4bdc-905c-08de2e688598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZXgZqy3OEUSRavZ6ddcNDTcbEPR7/Kz6KMSF9q3qXVq+Kf9HDXG0wvSInN?=
 =?iso-8859-1?Q?9gqxxJMm0yVoamBO4CcnJ1izVhENxZKScJADw/OOaAZ6t7hmTJgRPibVnU?=
 =?iso-8859-1?Q?JIwmzourAroZwJb5g7X5+o4ICD/TN3TLSZ40SLtUOHTgewVahh4Rndq/UW?=
 =?iso-8859-1?Q?1nhgGnTm6YIDcaasl1aSDc3s4FR07MSgp7ZuW3Uz3+3g/UBULKCf9EVtVY?=
 =?iso-8859-1?Q?nz4Yplidh4b7Z1M8SMBY8CMKml7E9kHsxVBw24mQdnXixqwhEczKzciaNl?=
 =?iso-8859-1?Q?zylJk7t1JTP2BB3gCrFGUc5+7Lt75Voa8QOzeRx/wEBftLD/kQDiU1xh3m?=
 =?iso-8859-1?Q?P/n/YGrj/9sp/OjDcXRRc/aUs2F1TfKoA5w/fHzmjPfJtlEr73rXx/iUT2?=
 =?iso-8859-1?Q?1G7p5EfWsKVopl70VmlYl+JeWGaGrtNwfEntvkLoke9fVNzfyZ3f8iC63x?=
 =?iso-8859-1?Q?vJ7vjjxXGdJeCr92ZHhWnOEh5PpN3rC6DPXx65KOj4qHLcaSlngBWLR7nn?=
 =?iso-8859-1?Q?l2xeVJgIKh4lHA9hFqkoVjcpEoZxEG5hh199WkwqAUEAmpBQAYa058Ww87?=
 =?iso-8859-1?Q?lUTc/VbSftAHH1nHgXQS2MKscZp6OAPJ8GioYo1+Ox7TZ1vw80Td3iUHKn?=
 =?iso-8859-1?Q?I8k+2meU6nubh1sj3rnm9PSKjQI33JwaOAW2dkAmQP/Ev/KW7srosHTCY1?=
 =?iso-8859-1?Q?MsgvuYUb/kl1SwBGWqgWghXifOBLCJz5UVji+fEDCuCn4NRtlbAva0KFof?=
 =?iso-8859-1?Q?7NiU/mJ4q592sV5RbFVeLz7/E66ziRVTrCCXKFAOYYkOA3TdgBTPFY6ZnR?=
 =?iso-8859-1?Q?6f9T6yynYIiJuWHo1StLdHb3YdD9etkxHGf60/iAlwidZ7mhmvkdH1VnwO?=
 =?iso-8859-1?Q?4gy+FYJJOjasChVHLYZ3m41eHzUSdNGMG9VGVbnyF7AQA6GMLw7NvRV84A?=
 =?iso-8859-1?Q?LP1VHeTnCl/Ut84O1LyLHr6Zg4MD360ZN1/wO4hdsfqtjlrImuPQtlTQNU?=
 =?iso-8859-1?Q?EDLEIEgILudtNf5OnTQA5FaqkildBfdmce46WTBTyAxmWKw7nARYJe0nAs?=
 =?iso-8859-1?Q?zitsvGeieIwJcMt9JNL/AyqicqCs1Zt549PJO2Tpt/E0WPs+s1w07lRH0V?=
 =?iso-8859-1?Q?amrSXvhUNZMCNlRCjdv7oek9q3qaIHYzZCeYW3XqmXV/vxHpgKkBnItjsA?=
 =?iso-8859-1?Q?e5lQG5GYHoGcHO3zYR1SnVgYjtUODVJCIBIjt+cyRXFxdyGcPoVHJ+JgZE?=
 =?iso-8859-1?Q?jw9Kdzm2GTxeWikduLeJZZy8LoGv+qkvwIPu35qLrpvr8FYJv0CeGXBgbf?=
 =?iso-8859-1?Q?m14WBg4I2JFHAInWHCgCUByfEbUUvQBrHLMcyYWJvn7TgO2kiefJbYr73t?=
 =?iso-8859-1?Q?eXldlDAlQy4pjD/IDS4cMCx5D7Zb2NJO/3lyeSyZvVrEShlLvGTeKqfZ3K?=
 =?iso-8859-1?Q?IgJI9LKFf3C52xiesADm0V/uZN8xZgvt7H43Bq14DGQmqA8Ba3iu4Trty0?=
 =?iso-8859-1?Q?h+/eCtRvig8Vlw8c5o3m7bCkgXkMlcsIygl+sEpDKG1SNkIMJ/QwZsgDWF?=
 =?iso-8859-1?Q?Or2NQ6N85kb9qGyyZenHfjw6OlqC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Fl/8w+CrK26Z49IVyj6sio0Zxx92uWaQQ7csO/SnJQKvAEExuCZzc32bb2?=
 =?iso-8859-1?Q?FIGs8jIOx7gWWLNfWSrOIVZXbgtzFpKs/5n7TUb8HXuLdn52WSJVNL54xJ?=
 =?iso-8859-1?Q?7UFVOLHSzgQAAg+3d8/AOqPI3LksXFaA4g3UCC+vNlf0yHt3YdyA12g6jV?=
 =?iso-8859-1?Q?XNkVOIBlKm+OeFX3KEm8S4RAho4/e8VWz0p67sp7w/fIs1lzwQrThTFI74?=
 =?iso-8859-1?Q?T/8abhS4R2VQHjXRpRrKj7DqEQynpsjilSJxxGQAC0heN5HXG4behBdLEb?=
 =?iso-8859-1?Q?oT+0PsKptwhm1WTj8AMSSXjE6YQVVaISX4NO1PAMEdFocmWZQ+MsMEmjtP?=
 =?iso-8859-1?Q?GWHrSV7Xm2VPe+jk/zV27VXuXoh5VrlN3fZ6A9DLPRSOb+FVnOBdSpLcVn?=
 =?iso-8859-1?Q?z/NP2MU9pzYTGPaxRxqyBkmaWvrxaZoivJqC5kKQOAtK90EIzuWADN9vOL?=
 =?iso-8859-1?Q?ZUrZuijXpPeBP+dINdMlcyzLNUzb2L7ipp9tBMQer+8lz0rQNPKLcQhiUz?=
 =?iso-8859-1?Q?jo9NCsECKS0gpIrJk+m6drac8D8otENaON2BwTWF+VLLxkCr5U64oX90TV?=
 =?iso-8859-1?Q?vx6DSrz85dOe2YjZXMW3vM6xdzFLnePAcKkZjtmeEQMsBiASLnHrPuQEce?=
 =?iso-8859-1?Q?QU/OkZm6VjNq9kzLI8/k+UnmwbtQtya5o9/ukYmejZOb7ZFkvHPuUci/mR?=
 =?iso-8859-1?Q?xpwQzQL0wplHrbcNLZq7quTfkCntXD3ybIoFFCD3XXidFarJjsSjgTSxl3?=
 =?iso-8859-1?Q?wziMm5WvlpAA/7egqneFo5tIMXxKfxBBOxiENLbp/z368xmb/zM/pbZVyd?=
 =?iso-8859-1?Q?7uOF4/YnND9Zq1dqZ4PcXZoArQaR2mDTac3lIgiHhxgjtWLLa6F6f7NNqH?=
 =?iso-8859-1?Q?+U6lFpy2Yg2jeEWRMhoV0uHVmZng0ilLHAvWh6DDR7ZcfSUvjnCaRhfS4t?=
 =?iso-8859-1?Q?96f1GeMjvUlIzSOJSY6d0D4cTBSsxaasZZHU451vGaJ0L/FEcJXtFXxIVx?=
 =?iso-8859-1?Q?/95d9Skk/RnCAFeq3kgvwDVnNTEAt3Dbj/ece124utHZethuJsyNgiu9o4?=
 =?iso-8859-1?Q?rj527qELNicvOw39ShS40UEoKAzukT8/4y89tmUKdHhFOXZVeWk4qowoEq?=
 =?iso-8859-1?Q?H5ol0slloqtw2QMsixd+g88x5Tfk0Ms+/HrSEGjURxX2nD/TeBiZMuPiKP?=
 =?iso-8859-1?Q?NbAbRDE5LWto7shmUgZm70Xi1l1lk0GbWORIHMdi9SQ/R1lygqMF5AD3Sf?=
 =?iso-8859-1?Q?CoYW+nJdy/cgNnV7gYQcuxKQIhsNJlcDbFRH7XKRuxCvb5v4XFsA2vVutX?=
 =?iso-8859-1?Q?vQU5XeHBV6slg+9RdAc0QvfEQRNPJzemOxEXQ/8aif7cz0DmVvsUiTc1fH?=
 =?iso-8859-1?Q?3mz6cbsxVru6PxiG/h48P3O3sMku7gMAPVRR2IdCVv55fLEVvjGSe1htmM?=
 =?iso-8859-1?Q?xsgJ8eN9yIMlwKgEwc5rTD1MsIBjApZSu3NrTSmG81RiRoHF9iFUms9Srr?=
 =?iso-8859-1?Q?FWmXgw8zWxA3op95FYb4JBedrv/KMVidjQMVPAP1SaGqBuP4IHOQUmpRI4?=
 =?iso-8859-1?Q?Q6TKPuLlJfzHQFTEXGpojAwilwWpRmIvhbTBt1s0BgD4VjFUIMSWBoRMa8?=
 =?iso-8859-1?Q?u9JsuYFzYn/r8JE19S4e3WKYA56qTm3ee4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69814db-6ac5-4bdc-905c-08de2e688598
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 10:25:58.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGXAXIF6X3MFgK7uVlN/ceRYP71kggM8Nr7RJ5gFmvPWqdYU3ARocc5Awo0eTaVv2uJPDIQsHGRYDGGjMx0AB8FTGeejSQQSxUcqx0R8Gjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-Proofpoint-ORIG-GUID: 8atq8FTp9Lsj_WmvNQo4-eh2ZrlOGMib
X-Proofpoint-GUID: 8atq8FTp9Lsj_WmvNQo4-eh2ZrlOGMib
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=692978b9 cx=c_pps
 a=air8cPz1/yJpzemNVwtxUg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=gTniDQHQ_vd191n_fssA:9 a=wPNLvfGTeEIA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA3NiBTYWx0ZWRfX8ODgWUVpP7b0
 zqH7qMoa+k+BmvuVkYRjnifP616CfCUYCQcth8V1dgi/ibDzQiBjZXsyKeZoUwC4idLQ3FEJCJT
 iJiCJsa1hTDHGlBD5Ju0YbD/lB8aPgLXY86BkhpSZchreXVnTfgIs3qLV39UEZwP81BgExIdM4k
 0RjJ4OVlwQeZaodVSZ++659KWKn8uPc/0dQcCcanpbu3/K8dW8p91HJBUEZXh8DdnLnrLxKNgCL
 I5UUa59prEYQfVceZjNwgbiLUYW6dBvx/LwSgTw3F3XWsbKFpLbvx2vwflva7pBUKXpFLjWsu8P
 fEFop89fWSTynlbOdAV1REZdm9VF52UIPkg3pGPqqW6GAu5fabBmsO1XLryYj4VcxL2+wScuq5E
 sMhOhDm1GuuAq6tzOLTvC4X0P5WQlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280076

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Friday, November 28, 2025 17:54
> To: Liu, Yongxin <Yongxin.Liu@windriver.com>
> Cc: platform-driver-x86@vger.kernel.org; david.e.box@linux.intel.com; LKM=
L
> <linux-kernel@vger.kernel.org>; andrew@lunn.ch; kuba@kernel.org;
> stable@vger.kernel.org
> Subject: Re: [PATCH v3] platform/x86: intel_pmc_ipc: fix ACPI buffer
> memory leak
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Fri, 28 Nov 2025, yongxin.liu@windriver.com wrote:
>=20
> > From: Yongxin Liu <yongxin.liu@windriver.com>
> >
> > The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate
> > memory for the ACPI evaluation result but never frees it, causing a
> > 192-byte memory leak on each call.
> >
> > This leak is triggered during network interface initialization when
> > the stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().
> >
> >   unreferenced object 0xffff96a848d6ea80 (size 192):
> >     comm "dhcpcd", pid 541, jiffies 4294684345
> >     hex dump (first 32 bytes):
> >       04 00 00 00 05 00 00 00 98 ea d6 48 a8 96 ff ff  ...........H....
> >       00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
> >     backtrace (crc b1564374):
> >       kmemleak_alloc+0x2d/0x40
> >       __kmalloc_noprof+0x2fa/0x730
> >       acpi_ut_initialize_buffer+0x83/0xc0
> >       acpi_evaluate_object+0x29a/0x2f0
> >       intel_pmc_ipc+0xfd/0x170
> >       intel_mac_finish+0x168/0x230
> >       stmmac_mac_finish+0x3d/0x50
> >       phylink_major_config+0x22b/0x5b0
> >       phylink_mac_initial_config.constprop.0+0xf1/0x1b0
> >       phylink_start+0x8e/0x210
> >       __stmmac_open+0x12c/0x2b0
> >       stmmac_open+0x23c/0x380
> >       __dev_open+0x11d/0x2c0
> >       __dev_change_flags+0x1d2/0x250
> >       netif_change_flags+0x2b/0x70
> >       dev_change_flags+0x40/0xb0
> >
> > Add __free(kfree) for ACPI object to properly release the allocated
> buffer.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and
> > add SoC register access")
> > Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> > ---
> > V2->V3:
> > Use __free(kfree) instead of goto and kfree();
> >
> > V1->V2:
> > Cover all potential paths for kfree();
> > ---
> >  include/linux/platform_data/x86/intel_pmc_ipc.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h
> > b/include/linux/platform_data/x86/intel_pmc_ipc.h
> > index 1d34435b7001..cf0b78048b0e 100644
> > --- a/include/linux/platform_data/x86/intel_pmc_ipc.h
> > +++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
> > @@ -9,6 +9,7 @@
> >  #ifndef INTEL_PMC_IPC_H
> >  #define INTEL_PMC_IPC_H
> >  #include <linux/acpi.h>
> > +#include <linux/cleanup.h>
> >
> >  #define IPC_SOC_REGISTER_ACCESS                      0xAA
> >  #define IPC_SOC_SUB_CMD_READ                 0x00
> > @@ -48,7 +49,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd
> *ipc_cmd, struct pmc_ipc_rbuf
> >               {.type =3D ACPI_TYPE_INTEGER,},
> >       };
> >       struct acpi_object_list arg_list =3D { PMC_IPCS_PARAM_COUNT,
> params };
> > -     union acpi_object *obj;
> > +     union acpi_object *obj __free(kfree) =3D NULL;
>=20
> Please declare it where the value is getting assigned to it like I
> instructed in v1. While not strictly necessary here, I want us to
> reinforce the only correct pattern to use cleanup.h helpers at every usag=
e
> site.
>=20
> The placement matters when there is more than once cleanup.h thing done
> within a function. The cleanup order depends on the order you declared th=
e
> variables.

Thanks for your review. V4 will be sent.


--Yongxin

>=20
> >       int status;
> >
> >       if (!ipc_cmd || !rbuf)
> >
>=20
> --
>  i.


