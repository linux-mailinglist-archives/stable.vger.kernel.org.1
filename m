Return-Path: <stable+bounces-45611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635768CCACE
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 04:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36622825FB
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667B38FA8;
	Thu, 23 May 2024 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T81E2axM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mVFsgu8M"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16A13A3E3
	for <stable@vger.kernel.org>; Thu, 23 May 2024 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431981; cv=fail; b=N+B6pN4oLnY9S16Pj+MKNLTB7pqD6du9f87Q3tfL853cdGAew7OtXA2BVcJxg1b5NP/PmizT5/s5IJCnYRJFtcgfcaZCN7/yNEynjGhI6/uyqxvy+kj86PK+rUJb9CZBqOnTqBmNsCViKJWT5OSPEp6RYfLtD1bizDUXZad6cgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431981; c=relaxed/simple;
	bh=wVPtpkTwn9/sWy5m+ha9vnrAka7hBfN+ilpbZ81rL1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAYVHEn0qVMHyIpk8JUWzpbufT8ea8bF+iv1UK4EPdrQdp/7fow1Bzji4a4/rBunU61zEysEr2Rh+Zsml+WG7376N0V+aF3TUJ0cY7ImZfSSTAXHJu+AaMR8UCrQ+7sBCTGJWs8vkcwrTjD8gsgVT5/wbljnQcp9b5Cpe66L7FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T81E2axM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mVFsgu8M; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a75ee7ec18ad11ef8065b7b53f7091ad-20240523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wVPtpkTwn9/sWy5m+ha9vnrAka7hBfN+ilpbZ81rL1Q=;
	b=T81E2axM6zaCetmSXXmwgiX9sN/v6AcalpL/euiKf9IG2PCmj3o1TreGAefk3hUuqa8P2rxQ+gm20SQqCdgD31v++M+0irhYW7SCdRR67d7wasFnJemaS5vdM7rc1SY6jLsIUoa79G+Uuq4KasM9PCZJgGYA8+ctB7NQ5ZD/24c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:48ec4688-fc46-481d-9d6c-2524a13f913e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:e28f1a93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a75ee7ec18ad11ef8065b7b53f7091ad-20240523
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <lin.gui@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1066772602; Thu, 23 May 2024 10:39:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 May 2024 10:39:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 23 May 2024 10:39:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beQTpPG3SKS5Z/9CX3Hpk0XDAvl8wtJdYh0OYY5nG+YqZwHeLy9lT3oEPvUOhZlZ4lo633pVR+M91k8GvidCjHQp2OMgIcEYvuv0MyWyFzSLRhhBwDc51KsfIngtgcdGNljSp0GDY6OEiayRNJ8i9XVgUr6F84QyABMjfqQmfqXYoLhIdC80PjMphpwuPg8NagXmnKWlyNd9V94XkB/nBZggC0C9sEhEs5ruJ61tX9lJw/bzVIkG/zHeZLqIryQTSCwdqFOhKwR87hdHpUaA+8XCQKCQgx3SUiTDvq7JUUMFnS5crHxifVNWINotJDdlN70IZfINzLuj805+r+TtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVPtpkTwn9/sWy5m+ha9vnrAka7hBfN+ilpbZ81rL1Q=;
 b=Ze8nN9SU5FuB1pm2z2NEgV6HgZh2KjtFI9ld53t6l6bouCq2J9/vOKFV+usvlthAqHV361eN3sIgp7e1M5xLghMIX+hHrRKwx+UWBvjqyXgDQwdlCLwucfowcAiBCA57VZVfeJKn9bXd6Q7n2PGvN16AivL9/WiHwGMnXjXUWbp4PY85QImHfgnDSjpISBzHmu2abaiPwXJ5DvACfxHLntfVJfNBwHKFAbjLN6EZ8q5FoarPj2SrT3VGQaCslaXWwtXjYL6LTOqOYyQirKqGR+LyQ1NCbP/ugQdyYqzXuZJkACdkNROYoCaBxv1oxfiETX6BwVtS+QFn3moy5+BtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVPtpkTwn9/sWy5m+ha9vnrAka7hBfN+ilpbZ81rL1Q=;
 b=mVFsgu8MzVZZEIGrzMkwE3I17qpfb5g4jdFjdQ7dIHHS3BXNzj+VNMIxFELDVoJTSckUQoQkfhBKi57KUcvQKxYZe/qAXkCpDwimAWrjX1zM2Rwq3Ft1s1/cqjWO9lcw50lgH+U27wvCz/BRz5KupzxHvZ9P32KQi1q7o/D0csU=
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com (2603:1096:301:8f::9)
 by SEYPR03MB7780.apcprd03.prod.outlook.com (2603:1096:101:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Thu, 23 May
 2024 02:39:15 +0000
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::4ca6:7dcb:47ec:f6f2]) by PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::4ca6:7dcb:47ec:f6f2%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 02:39:14 +0000
From: =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?=
	<Yongdong.Zhang@mediatek.com>, =?utf-8?B?Qm8gWWUgKOWPtuazoik=?=
	<Bo.Ye@mediatek.com>, =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?=
	<Qilin.Tan@mediatek.com>, =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?=
	<Wenbin.Mei@mediatek.com>, =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?=
	<Mengqi.Zhang@mediatek.com>, =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?=
	<Lin.Gui@mediatek.com>
Subject: backport a patch for Linux kernel-5.15 kernel-6.1 kenrel-6.6 stable
 tree
Thread-Topic: backport a patch for Linux kernel-5.15 kernel-6.1 kenrel-6.6
 stable tree
Thread-Index: AQHarLpm4Pel55rT8EmHOVSPAeydxw==
Date: Thu, 23 May 2024 02:39:14 +0000
Message-ID: <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
In-Reply-To: <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrNTQyMzJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hMmVhNThmZS0xOGFkLTExZWYtYjczNi1hNGY5MzMyZDU2ZjhcYW1lLXRlc3RcYTJlYTU4ZmYtMThhZC0xMWVmLWI3MzYtYTRmOTMzMmQ1NmY4Ym9keS50eHQiIHN6PSIyOTU0IiB0PSIxMzM2MDkwNTU1MjQ4MDYzMTUiIGg9Ik1HandUeW1HcHl2WXFjMENlTkZEUWQ0RWMzdz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5653:EE_|SEYPR03MB7780:EE_
x-ms-office365-filtering-correlation-id: 05d7768f-5846-4dd0-f3f7-08dc7ad18934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?c2wvRjV3OTVUN09KNUk5RlJlZmJMK1Y5b29aMHREQnhkQ3RDdmQxZnk3OGpl?=
 =?utf-8?B?VExRVnl0R29rRk5NMlY2MHkySEh0UWZTL0tISnc2ZlJHSVlRWk9KN3dCaENU?=
 =?utf-8?B?VVZqQ1hjZVhPTzFYRDhkc0tBcS9sTXpJMXA5eDN5RmpXQnc3QWpBa0hTVlgw?=
 =?utf-8?B?MUozbkN0WDFxK2ZleTI1K3FUd3gwTndMSnNWcDgxbXBReUt3ay9seGRyaWFT?=
 =?utf-8?B?aEphbGVRVWc0dTROYVdGcW1YeStOL0FZbDA0Zmcvdyt3YjZYc2RNQkc0TzdC?=
 =?utf-8?B?MUhiUDdnSVlQVml3anpMWlgwTkdzOHNMbExId1RVTzcwbUN6VEpreHk0dllo?=
 =?utf-8?B?cHdXZFNubEVicjJxRGZWQ2NuTnlLR3puRm1TeWVvdHpYc1ZNK0JQVFJ0bzcx?=
 =?utf-8?B?NGc1eHhpQW5aVWZnU3N2ZEt4cHJMZS8yU1Vlcjl1ZWpMSW1Fd3J5T1pXMmlH?=
 =?utf-8?B?MHJRb1lHei84ZEFia2lQdk9TWEZzUHZySW1ZUHpmeGIrVFB3MGM3NXdhZkpz?=
 =?utf-8?B?NFFOeVVXWEdXMkFkczN4bTE3d3JMc0lZaTdodmZYZGJSYVluVGpRcmJtUHR1?=
 =?utf-8?B?amZVWXRoYkQwQ1JjUjREL0lWb1g0THI5M2NkS0NwYzdGS0pqM3lhZ0JyK2Rw?=
 =?utf-8?B?L3BjekVyMGxmNTZPamxVeDdOb0o2K1pYdVhFanpDdjIwKzN4enFlN1NOV09H?=
 =?utf-8?B?ZFNUNFR3S3dWYy9xVzFoN1duNUJpQXdJSUNzeEFsUmt5ZUtOVUJTY3dKRmhZ?=
 =?utf-8?B?U01LcjZFajhTdnpsdlhvRGpNMThFQzgzck05cHl2M3RQNmsvaVRRQ3ZZd1Z0?=
 =?utf-8?B?V1hVN3UwaEt3WnFyOVo1bFBNOWtYK0t2N2NVTjBmd1UrdDhuaTQxQWZhL2Ew?=
 =?utf-8?B?NEtDYTRGb1R2QjFjSDFNZ2ZSMFVHQkVqSCtiT0cycXFqUmtnRndkVDNFdmxG?=
 =?utf-8?B?WjJZUVQ1ZnhnUktHQ3FSNmc4dWxZNlVpdnFrNzFSV20yMlNaT2l0dERBYjlF?=
 =?utf-8?B?SmZDQkZsWVIyWEg0VlVWQkhBNnFIUDNRUk1UMElkdDFEZGRzdWVOMGtHaHhY?=
 =?utf-8?B?UnpXdWVsSDJwZ0pDMit6a2RVTWJKSGRXamlMNUtQYldrOFVmRldmenRROFVx?=
 =?utf-8?B?VnhGbzFHNTM4d3dRVzF4aWwzU2t0V25XZXZadlVRWURGZkdKeTBMeGhKYXpL?=
 =?utf-8?B?cWJRRk5YM1dqTWRMYkFLUUtDVkNGSXpVS2dDd3l5bmFIN0NJL1RhYnhwajFT?=
 =?utf-8?B?TVJNaEtEOVFqUVRHMi9IR3M1Y0dXdzgyMTczOVRZQzR4dURzZzcxRUZEWldN?=
 =?utf-8?B?a0pXbUF5cTlmenBCb2FqUE44anNURDMzOG5HcTdVR2MzaXdGU0hqQjVFRHU4?=
 =?utf-8?B?RmFFRloxV3B6c05mMGNSemZLZVhpVnZscG5LV2ZBWFBweVIyV1gxcnp5Q05a?=
 =?utf-8?B?MVhNbm1OZkpvSUVra0xzR0NQSzVHV2I3YzVMSFRCRWgwYWV2WFQ5WmhQVDlX?=
 =?utf-8?B?Uzg2K0w4aW9CbVFOM2hGVHJNa1E0aDZORDQ0cEhLNGNud2FpR0RBNWlhNWxm?=
 =?utf-8?B?OFNFQjA3SWZHR21qNm5HeTVmMkNWYWY4M2pXc2d5NDA5U21weUxDdVJkc0JQ?=
 =?utf-8?B?QktMRHlnZ1BkRjE2WWdBN0QwWFFyY2pHOHR3VTQxNDgzNzd2UW1ISm1QeHo2?=
 =?utf-8?B?dkVORHFCcVhPM015R3AvTmlheW01MlA5M2xHTjRhU0JMdGxvL3BHNGx6bC9v?=
 =?utf-8?Q?tXh1hTFHG7h8mvMzgY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5653.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnFWUFVCYkYyOWpvVUlBY3dSYXVkcFdlVnU1aTVUTEZ5NDNwRGx2cEFqQkll?=
 =?utf-8?B?bE9ERndBWlNCeXFFREtpVEJ3cExYSjhKTlB4YldDRjcyWTdGNjRScWlZU0pq?=
 =?utf-8?B?TTY2R3N2aFVMUU5nNTVuQzRMZGVidHpZK2JaR3Jodml0ZENYdGRFdHh4OVVk?=
 =?utf-8?B?NmdiYUlodVpXdzFkRlRqeWFkTXhSY3hlaFVvMzQwT1JqOTMxK1QzNnkxVm9D?=
 =?utf-8?B?TVlXaGMrSUE5WVY2cDNRS3g5aE9QQlZDcFVCZ3ZpMXM2dlo2NXpmYzUwRFk2?=
 =?utf-8?B?Ykg0RGlOS3hqcUtweE9TWVA4Z2MxU0RGbUI4NjlJb1YzQ1Z3bTZjZEFXVmo3?=
 =?utf-8?B?V09NT2k4OFBsWitHcVNLWFJFZjhma2dBU0Y2N1B6bjZKK3dDeThIeTZoS044?=
 =?utf-8?B?K2NUVDZFS2swVVdOSVRlTi9oYTBPWlg5S2tsLzVteGxiamhiNE5oZ1pwK21X?=
 =?utf-8?B?cTlrR2dNSEpocGlCVHpxb3FGRmg5aElsUDJHZHdtR09vek9TdDNBYUluSXlF?=
 =?utf-8?B?YUdPWFF3MklSWmp2c29jTkJCRkZxTWJYTDd3MUJBQmRpenhPVW8reGhyS2dy?=
 =?utf-8?B?Mm9wTWNjUUpjYTZqRHJqQmNVWE9OVFh1bFE3ZGFvcGlobFRYQXFOZnc0Wm5H?=
 =?utf-8?B?c3V0VHh5N0Q0K2dNVzBESDdaYUo0cWJPKzZvbE1wUFExOTMvVmJQbXRDTXlS?=
 =?utf-8?B?cTBnanEwRHJtT3lhVEhQclNGZHp1MmJpdENXall0WDBPSTBpbC9tdGRaUGN5?=
 =?utf-8?B?Z0s1ejZhc2xLU2ZiSTZKTWd6NlFndDRZb1J2UjllWEkvTGh3dENjb1lxcUtt?=
 =?utf-8?B?VTZuSDJFVkJ4Vzd2QmtOdU5yTGZ4U2RlZHFGZ0tIRy81azZoUHgwQVc5Zlc0?=
 =?utf-8?B?YVV1WTF1Zm94ZVlqaGZqVE5sN2l6R2pUbWM4dzJUNUd5MGE5aDRyY0pjS0hR?=
 =?utf-8?B?akh6UlpqVXQ5MUtPMzg3d3ZYQXJndE93KzlVRkw2VjZVcDh3MHY2cmdLakE0?=
 =?utf-8?B?Z0ZaeTlNRWtENFkwRWVZR2lqVjg2VG8xcVlGUk8ySUdZYnZiM0c4eUtOS25o?=
 =?utf-8?B?Q0hlT2REZVdBTTdBWFB5eHhQbUJocC9WOExjeFFzTXdUSC9qZ0dKNVlLSnBo?=
 =?utf-8?B?bVdNV3A0V1NoSjNPa0prQjVRenRPazBoWk80RzR2cm5VTmNVcmdmR21NNW40?=
 =?utf-8?B?Sk1MNmlmL3lPaUkvK2s4MHE3YVkxSDVLcnJmbGY5TjhBdjN2ZmtqOXE5QnhR?=
 =?utf-8?B?ZFY4c21USmtNclRveGdNeFFUd0pxZEdxWGJyYStNMlh1a2Vzb1lxNGpuSmZH?=
 =?utf-8?B?bE1oKzlJMFBtZHppTDNqSHhid3JocU9STHFUL0x1Mk92SWEzME41aGczci9B?=
 =?utf-8?B?ZjhkeEE5YjNWcEhWV2prRVBPSWJkcGNWQU9QME56VElDa2ZKZGR0TThPN1M4?=
 =?utf-8?B?NlI3S3YyWjdqSjBWLzdUOUNmL24vbHdjSzN2NFVtUFEyemp4b3E2N3VqMDVR?=
 =?utf-8?B?cUNMWUlyalkxa0xoY1ZoNU9UTGIwREprb3RLS1RlQnlPa1R6bm1UcDRGRm1B?=
 =?utf-8?B?MmxKYUs3YkdHODNMRXRZbG5XY3pJaHpKei9lUHp6SzVOZmUrWDJjSTdEVC8y?=
 =?utf-8?B?aFFJUDcycU1XMjZKRU9GQVJ1VEIwR01rbVdoaDRySWRQdGdYaWhlSHBDeEdB?=
 =?utf-8?B?SGZLaGJ2TndaMDFQbDRocVVieDJySTEwK0pTdEx5UU9ZQ2pwa2tPeDhrTnpM?=
 =?utf-8?B?WmJIMjFGSjdzeGxDTm5oTDExTzVKU1dkUDR3YnhRN0czbitLWWhKdTJlQXVH?=
 =?utf-8?B?TlVkSFRwaEZOY29ROXJiWjVZK3N0V25ZcGVnU0lQVkxoaVNVaUU4bTlyTHQ3?=
 =?utf-8?B?ZnN3WUh0MnJDbnhHenhIUFNMejlUOVA3bmFGSHhNbDlpeEdsVk91Z2JOUHNo?=
 =?utf-8?B?UmI2S0xiZ0xCYUE2SEd6QU1FdFc5YXdUaVI0V0pXUmZSV2ZNemNadWZLajF4?=
 =?utf-8?B?VGJFcnQ3WjFVa3k4K0tpZkN4V29PNWFqN3BLQXgyVENpeWl0dG15QWcxYXJZ?=
 =?utf-8?B?dkF3bFJCcHZpckRTN0VCTC8xQ1BBWUhMTVB5eGdFeHF5VGo4bjNpOUlScGFQ?=
 =?utf-8?Q?gwP8ZaKRN2B05VRS4m+S74WqO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5653.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d7768f-5846-4dd0-f3f7-08dc7ad18934
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 02:39:14.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnYbhdC0Bk2JA9h3Qxls+N5ETfwuD4q9ZcJheqTx1b1hc8NbFECZgK+cdSYkj6e80GfVgl0taYn8uA+JP+Gkww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7780

SGkgcmV2aWV3ZXJzLA0KDQpQbGVhc2UgaGVscCB0byBiYWNrcG9ydCB0aGlzIHBhdGNoIGludG8g
a2VucmVsLTUuMTUgLCBrZXJuZWwtNi4xICwga2VybmVsLTYuNiBzdGFibGUgdHJlZQ0KVGhhbmsg
eW91DQoNCg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbW1j
L3BhdGNoLzIwMjMxMjI1MDkzODM5LjIyOTMxLTItbWVuZ3FpLnpoYW5nQG1lZGlhdGVrLmNvbS8N
Cg0KW3YzLDEvMV0gbW1jOiBjb3JlOiBBZGQgSFM0MDAgdHVuaW5nIGluIEhTNDAwZXMgaW5pdGlh
bGl6YXRpb24NCk1lc3NhZ2UgSUQJMjAyMzEyMjUwOTM4MzkuMjI5MzEtMi1tZW5ncWkuemhhbmdA
bWVkaWF0ZWsuY29tIChtYWlsaW5nIGxpc3QgYXJjaGl2ZSkNClN0YXRlCU5ldw0KSGVhZGVycwlz
aG93DQpTZXJpZXMJbW1jOiBjb3JlOiBBZGQgSFM0MDAgdHVuaW5nIGluIEhTNDAwZXMgaW5pdGlh
bGl6YXRpb24gfCBleHBhbmQNCkNvbW1pdCBNZXNzYWdlDQpNZW5ncWkgWmhhbmdEZWMuIDI1LCAy
MDIzLCA5OjM4IGEubS4gVVRDDQpEdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uIHRvIEhTNDAwZXMg
c3RhZ2UsIGFkZCBoczQwMCB0dW5pbmcgZmxvdyBhcyBhbg0Kb3B0aW9uYWwgcHJvY2Vzcy4gRm9y
IE1lZGlhdGVrIElQLCBIUzAwZXMgbW9kZSByZXF1aXJlcyBhIHNwZWNpZmljDQp0dW5pbmcgdG8g
ZW5zdXJlIHRoZSBjb3JyZWN0IEhTNDAwIHRpbWluZyBzZXR0aW5nLg0KDQpTaWduZWQtb2ZmLWJ5
OiBNZW5ncWkgWmhhbmcgPG1lbmdxaS56aGFuZ0BtZWRpYXRlay5jb20+DQotLS0NCnYxIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIz
MTIwMTAzMDU0Ny4xMTU1My0xLW1lbmdxaS56aGFuZ0BtZWRpYXRlay5jb20vDQp2MiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyMzEy
MjIwNjIyMzYuMjYzNzAtMS1tZW5ncWkuemhhbmdAbWVkaWF0ZWsuY29tLw0KLS0tDQogZHJpdmVy
cy9tbWMvY29yZS9tbWMuYyB8IDkgKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KQmVzdCBSZWdhcmRzIO+8gQ0KR3VpbGluDQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpNZWRpYVRlayhDaGVuZ0R1KUluYy4NCkVtYWlsOiBtYWlsdG86
bGluLmd1aUBtZWRpYXRlay5jb20NCnRlbDorODYtMjgtODU5MzkwMDAtNjcwMDkNCkZheDorODYt
MjgtODU5Mjk4NzUNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCg0K

