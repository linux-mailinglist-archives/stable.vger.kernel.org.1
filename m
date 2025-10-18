Return-Path: <stable+bounces-187819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A84BEC8DB
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 08:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24503351875
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52D2773DE;
	Sat, 18 Oct 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SIJ2uPNN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZoTz8mgY"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A69443;
	Sat, 18 Oct 2025 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760770495; cv=fail; b=gCL64UGxP4J2VlFMnQ8btfIP9oU56vuXiZdEqcwv/OCSadTicl8XDBdZPpF7dopWC2qJrajvGP/1NLmswfMwWM7Pv7ovjVQR6dOFq5JWi8Ot6MwXbN375XLcyaOzPf2/Ep+PjtF2Gv5gl8fBBPIQr+C4vB6yEhaX0uwn4lruZeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760770495; c=relaxed/simple;
	bh=5EDU9IrUDPvNRw+QKUrE113fLv8YcoH8RrMW2Yt4CPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZkSkJckIhiGUw6y5Rn152tvCX/bqeadewy4luO6eguDedzh7DZkNObRcjyuCOb67+7vxtd1MdHuQyBnTYbXuRj+OVpGXKFFATSs1nJcPYf5qv7I4tj5d1Shrc0ix0I5oR43Dr2T5hYDUX+w9QUkN9PciTOrKy26lPHzyJYVYlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SIJ2uPNN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZoTz8mgY; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 568d9e40abef11f0b33aeb1e7f16c2b6-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5EDU9IrUDPvNRw+QKUrE113fLv8YcoH8RrMW2Yt4CPk=;
	b=SIJ2uPNN7N526/NvKvWiA4upXr4ADE5IejyOZ2qOVN5NOAR1hdWctsNKSxIaicvXn7DUekySkSAiK1AJN7plv2oVyrmmAPgO19sGNWC3ywDCMKQQE++lK2Fl1XsWry48Tx0f1SOZvAmXN82sCnVJ6fCRIXV3WjHnHk8ez/bMWAE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fd3a2447-f330-4c20-a113-3d44a75d3cbe,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:6a0b3151-c509-4cf3-8dc0-fcdaad49a6d3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 568d9e40abef11f0b33aeb1e7f16c2b6-20251018
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1806947220; Sat, 18 Oct 2025 14:54:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 14:54:44 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 14:54:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqHzN6UowqmZ3aEigYToOJ4tMKDRyIebDXlNi/DCG40qw9bHstImvN8RsSCfW1O+gmugPlvVuW/i8Gztb75JNqeo+nrA5LDA+g/kZrQQ13i2w6kRr2YD1Pgc+VYSKdRgEKJuy2p/HcXx0QRCxDhhOmLFk6HOonSHgtLiVKlArpDrU1myTH9K4PEF7ikzs7S+8G9QbLA9U+GOvDQDgqgC1xuJ4SiMZYTtHS7Z6MRO8dU2KXmewX90V5XJKCnk/oWb/PF6RxxYAr6YSafWh4DyrRweYPblj2NSmwutxh9ehqnT9SMKqBSKhAUBR+BmSRl4ksGcLkfxdvdA0E/4tSkNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EDU9IrUDPvNRw+QKUrE113fLv8YcoH8RrMW2Yt4CPk=;
 b=keK8FUAo3x4wn+zcbh8ojMPaKJIgO4M75r9z6uIS/xL0t7TAMSaHA3H4MGEj4PJZqEhCz1ya5k8m5g9kAAtndGInQPUr7xkL5AF7+1KB+pj0/2tBufxBPFu0mUhrgfwnvaY5gho56N5BZZYsmIpbnSXvmbKp/8V6a5PR79MiHVHi8I0JywYlVWhTvkacG5iPmLcKKn5S1QU9s2t7sdDfGpfkCAL8ama2Qq12rNhOp6jts0RP9Scw/F2mRjJ0/2r/FXRn9C/o6pzNsYUxkAqiTWlNhFgo139O25/bFKgPTyoSYzFLbyhpuLLoedOEiMQt7NQV56pcvkNIW47lYw+qDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EDU9IrUDPvNRw+QKUrE113fLv8YcoH8RrMW2Yt4CPk=;
 b=ZoTz8mgYjMSEBqSUzl5nL7aoURey/DaI557ZtAuFUfsYU5C8dkZoBju/Ua3hkVyQv/gk+Q7bew3AmNC2EC5FO1TqW8M4xSI/Qtp2ZCwH1ezcrbzYsho7EHtBycGaa7p1R0mx+BARMRgRBqsJrprkH9KakU31TxBNw5kgHo4wmNs=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEZPR03MB6990.apcprd03.prod.outlook.com (2603:1096:101:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.14; Sat, 18 Oct 2025 06:54:39 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 06:54:39 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"johan@kernel.org" <johan@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"j@jannau.net" <j@jannau.net>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "wens@csie.org" <wens@csie.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"sven@kernel.org" <sven@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 06/14] iommu/mediatek: fix device leaks on probe()
Thread-Topic: [PATCH v2 06/14] iommu/mediatek: fix device leaks on probe()
Thread-Index: AQHcN28XJyTFxPYvL02gIA5wQrzo57THiUUA
Date: Sat, 18 Oct 2025 06:54:39 +0000
Message-ID: <aeec9ee86b63ee892d84ab0232f372bdeccc780f.camel@mediatek.com>
References: <20251007094327.11734-1-johan@kernel.org>
	 <20251007094327.11734-7-johan@kernel.org>
In-Reply-To: <20251007094327.11734-7-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEZPR03MB6990:EE_
x-ms-office365-filtering-correlation-id: 014a84f9-ce64-4ec1-5554-08de0e133586
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MjFhcS95Ri8yUXJoTnlpZTJsU3JzUWNsR3VmTkxzV2RqL1pvb2NqY3VkczdF?=
 =?utf-8?B?eHJtMllqREVsS1FqdEFkYnNwMnErVHB3cXFHZHVpTnNucmZBQko0MmtCL0Vm?=
 =?utf-8?B?MEJFTXBvQ1N4WksyNy9HOUswS05UYkhyQnhYUjRqdWVSMy8vaERESm1XcWlK?=
 =?utf-8?B?RlNDZTNqM1FLcno3aVhCZFV3dmxMR1hadjRJUkgxVjdUN0hPS3FGY0QrWHp0?=
 =?utf-8?B?Qm5qamxKVWt6WEpHM1FUTnpxcFMxenp5QUFybGRtNDlEdU1lVzRqcE5KaU1M?=
 =?utf-8?B?dFdQWTdjRFdRbGFmLzdjK3F2L1F0SmRSd1RyUCtsTUd1WjBvUi90OERtMmxw?=
 =?utf-8?B?VGpIQzB6d2lCemRYQktsK3FSTGtUMUZyY3A2Q2hxenhaWlJYbmVsYkpORUtk?=
 =?utf-8?B?ZUVXUE1WN2xZZnN1WWdJTEdJTzVNa3hVR2RYZ1BhdFVjbi81cGN3MHN5dnVR?=
 =?utf-8?B?ZmdCbENUK0E3R1pVNHRxZ3dyUm16WVJlSmxxNitXSE1PbFJYeU1hdElJRVN5?=
 =?utf-8?B?OXBwUDNUYlRRU2duWGUwRHJ5NlNTRFhMRHFMMzRKTExJQXluU2JMR1FPSjRX?=
 =?utf-8?B?TC9vcEFCWGU0bEpDRlJhWGxKOGV5alIxWUFiTlFxcjlKQ1M4RW9VTGF6dkpk?=
 =?utf-8?B?U0NxYmRUdTJGa1hJZEhxVjB5MmxKZlVtRGdtMkpEWEJjWTVBbjdFTmxDeG1K?=
 =?utf-8?B?QjFvQmt4a01CWTZSK25NWldNNGVxTHlZa1B3QWlIUlMzRERhUysxS3VBNlVp?=
 =?utf-8?B?ZjVkMWhDSEtHMjl4cGJmanRqNUxpeFFWRmllWHZNOTRjcjVBOHFxemVVTW9s?=
 =?utf-8?B?Uk1hS29yb1gxNUlsRlVjSFlHUVJmZHNrMnFxZU0rWDRRU2hoWnAydkgyZUx2?=
 =?utf-8?B?Y2xsYXJ5QjJDVjd2TUhFQ2RsdkdvYW5FSC8wbG5RRWpYaC92UGx6WkRrY3Fv?=
 =?utf-8?B?alJ5RXQ0cnNRWDJ2ZytHNTYrMGRlVnNWNkMxeTN1R0V1WVRnNnB6Z2NpejBS?=
 =?utf-8?B?eHV4ODRndEV6RHlINzloM2ZxNE1lanRJQzVpekIxbmppdTZaSm5ZVVAzaXBa?=
 =?utf-8?B?aVVuRERkMHhCVUVkYnVnMER2cHBPUUJTeWM2VzkwSzRxWE9uaFRIR2NWNmRI?=
 =?utf-8?B?bFQ5UElKY3BpckR4N3FTaERSVitGbjVWeHNNQStOZVVQT2xjOE5HQlZ0UGVl?=
 =?utf-8?B?U0wxNExXb3BENlp1RUswMWFWVTF5OHM0RS85QmFHZkpaWVFnSVcrMHlXakky?=
 =?utf-8?B?ek5OcnFQTXBIUlBVbXBsYVFWYmZ2MWNISGI1SFQwYzVGbk91WXpxTTRFS0hy?=
 =?utf-8?B?SGVsNk1tcFpDRW5lWkh2RXo4NnVOUWdZWFA5Q3ZQRERsa0FwM0VaQmVJeEc0?=
 =?utf-8?B?OXcyN0N2MXhndEZsWE9PSmNpRm5xMkFrWVNZRk5BYXR2YkpsQy96b0s1cnR4?=
 =?utf-8?B?aFI2Z0FnY0hXdzJxVXpOWWpubTVXcGs2bXlxUjNFL2pIRjAyVzkxTTd5K1Fm?=
 =?utf-8?B?Zk5XaCtPVGxydnFPcnV1a3VyMzJyajdqQ2syMUZybHRyMTZQcHVmdnZkS21G?=
 =?utf-8?B?Mzk3VnZhQ3FnUVZIb0xMTlEvMTF0WnlGWEcrWTFWVm1EeS9DT0t4RDJYY2RS?=
 =?utf-8?B?Y29TcGdmM0ltcGJsYWxhZCsySFBnaWlyWDBRKzE1WnhOVkgyV21JZ0lVV1BC?=
 =?utf-8?B?SlQ2TkJBdEkwcmhlTGVybjdKVXNqYUFhaW53VmIrdFJyNDRYbDllb2pOVnpR?=
 =?utf-8?B?Q3NCR1llTlNxc2U1WnlDM1d1am01VVRpL21FRXB0b0xEQ0F4czB2TkNRakho?=
 =?utf-8?B?R0xjWjZ0Vzg1dDFKWVUvRVBYVlNwc1EzYnlwYzNweG1sWjQ4bmQ5TFgrd0FQ?=
 =?utf-8?B?eHlheXdvZVpzUTA0VUFQTXBUS0ZoY1MwM2dNTlBPSDR4RWJySFA2MThzV29y?=
 =?utf-8?B?Y3hMYXpiLzJQaG5mVnFLTTlSZkQzdTljblZScWpGOWlPSFcrNHNuOEFlWDhu?=
 =?utf-8?B?VTJETG1PVUpQWnhnNXJWdHVpeVBLcWVFRjBXazFxYUVYRytFZS96TTg1N1FG?=
 =?utf-8?Q?QUab1O?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGpjc3JpbkVEUWdPekRWS2tTUGE0YStOSUFuT0ZRRGU5UVQwUndQNzR3b09D?=
 =?utf-8?B?KzlpU05rdVNCNllnV3NMalhqQm1BNkMxMVh4YUNhd3YySE5BdmE4amgxbjBZ?=
 =?utf-8?B?Tlc5UlkvY1I4cEVGL3dWeVZZUjVwVjhoU1hXTXRpeWh5UTg0d0x2cXA2ZU8y?=
 =?utf-8?B?b2xNTDZJVy9idjhWcFFiMXQwUGRWMmJ2bGNVZzJCZFVlVTJsUXhsWlBTTnUz?=
 =?utf-8?B?eWlGYU1WdysveWh4bkVlTzdQb0VZUzZUK0V0QnRYVzh6ekhCaWZ6NjJ3OEt2?=
 =?utf-8?B?T0ZVVURpVXRMQzRBbDRDR2xONDREOE9BaTBScHhZUXR6K0UxOWdxSHdpTmxW?=
 =?utf-8?B?ei90cXIxdFZBVUpGVkFGSE1MZDBIQ1ZMWkxBMElJZUlLMWZLRW9kNjlub1k5?=
 =?utf-8?B?QVpUUGNDUFBoKzdzWXpPQ2RkWDV0NzNrenpnZmN4RWVJRlErelZrSTNkQzVj?=
 =?utf-8?B?bThVYVlPOG1ReGRtcUp5bCtMTktoVndnRHc0RHhidGIrWlVzK1VUb3RJZ29V?=
 =?utf-8?B?c0Z1Q1FHak9wRURVUFdVZld1WEErb0hQMFJxR3QrQ3lkandhSkZvZzF0aWZS?=
 =?utf-8?B?L2xiNGFWdEY4TVI1K085UEhFVlVmSS8xZFIvZGNDdURIMzBqR1B2WTJ3allz?=
 =?utf-8?B?cW9SR0xwUmxnYzRUSzU4aUc5b1VLL2lUZVdiZHlmdnF3Tnlab2wrbTJRTUlN?=
 =?utf-8?B?TWhDbnpPR2d6RUljUEZaU0ZsZmNqZUZuMGg4djVLLzBGdm1ERFhXeFZnZmJn?=
 =?utf-8?B?QWQxb1JkZU9iVW1hT2F5T28yY3Rtd0RkZllpbEMzL0lqZmt4azRnOWNtcWtR?=
 =?utf-8?B?dW9teTJRUkpSMWhQTVJUWlRqZDJsUmk4Sm0zbXZMMzVnb25kVmpzWFNNaS9T?=
 =?utf-8?B?blJBS2dRY2x5TXZGSEJVb1FRSEMyY2RYaHJpbHZVazZ2TzlxOG5HVGNSZWVT?=
 =?utf-8?B?RTExeUhIS1llUTdGTUE1bEVRbDVlK2FVMzV0TUxhazhyN0ptRTA3b201UTZL?=
 =?utf-8?B?ZG5DZllUMWs0Skt6dzhTTitFV2RQU2N6TGJ5Q1JrajdXZWMvMXVrNGdteVlt?=
 =?utf-8?B?YWQyZEtSbms3UU9XeW9PeUM1eVRkN0ZvRHYvWkFjaFpROGswWW92TE5maTNR?=
 =?utf-8?B?eUVhTGV5ckU0N0crN3ZtZnlKZXVSVzNrTmQ3ellxK20veER1dXJ2YlJ2Ny96?=
 =?utf-8?B?N3NEVG41d1hmWnZxR1dFaHJBa2xYVTRXN2syWDE2OWhtTjd3SzV4TnVmdHlS?=
 =?utf-8?B?dDBHUExKWEZ6TWNQaVpMMEVER3RTOFhHSEFWcEVjV2MrOUQzUG0yU1I3SVdN?=
 =?utf-8?B?WkJkNVphbkJtdmhQVWZ0N2s0R253bWEvcStCd0lYdXRRWnNaVGdJcGNIRitR?=
 =?utf-8?B?NmU3VFBualRWOHp4YitKTzVWTnQydWtaNEdKc2ZscTk1T3VSV3FQcUlNYklP?=
 =?utf-8?B?cEZrczhvOEtsTVBpN2NNam90c1R2dW1PSytXS0ZQTElEMzhWUnZ2ZjcxS3ho?=
 =?utf-8?B?VWVzWVBuTFNnV0txWElRdWwvOXo4UW1vOUxycVptL3QzdEpWdDlTYzh4Qmdq?=
 =?utf-8?B?alVRM29NMWhYVU5wTFI4NzljTU5VWStPU1BoQ1d3MkphVm54ZG80Q09MWkEx?=
 =?utf-8?B?eDQ3S2JzbmVkaDUrQnZ2d0prVHRQQWNEaHBVUEoxRXJvWkszUnRSTnd0d0NL?=
 =?utf-8?B?cit2TXlVWFpJTHcrM2U0bEg2M0xIQmt5aGpSU3JxQnZJVEtGOTM4Y2IyQnRB?=
 =?utf-8?B?eGs4YllJUG0vbmJ2Si9iemRWRzhoL3NDYS84YUVESEU3RUk5S3MzY1NEbVN5?=
 =?utf-8?B?aXU1V0dzNTNOWENYS2UyK3hWQjEvdThSdWJZbjZWTEVDSDZ5YkloZVorU04x?=
 =?utf-8?B?M3o2VUVnckI0MmhBUDk0ckQ3N3FOOXpoVERMUUZ6OTNHaGMrcWt0dndUVlZK?=
 =?utf-8?B?RlZhU2FRVnlraUt0Q1F3R09IK2lSUys0NFpmWUFKczBRdXJnQ0lEQkUydVlt?=
 =?utf-8?B?TUN3TXRLdU5hMXFWNlJhaWcrT0VGTmtyQTBEczJtd2Q1dUVTYlJianRQUS8y?=
 =?utf-8?B?Vk1jd2d5dTdSTTFQQUYwVmNoUEdUODNOQ0JIM3czaFFEYUFUNFk4eWFiMTVW?=
 =?utf-8?Q?ZFa6/K1HHfOC88SHzcv0wTd43?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63F1E840E194D441BBCDD7798D0974D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014a84f9-ce64-4ec1-5554-08de0e133586
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 06:54:39.8284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kypITRNd+TUoo/H3f88n0Q8VTJRSL0ikcnIYJYXrl33LKwmIFtprZFwWY/xmlOaP9wv5R1xNAmx8n4jsMmN6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6990
X-MTK: N

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDExOjQzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gTWFrZSBzdXJlIHRvIGRyb3AgdGhlIHJlZmVyZW5jZXMgdGFrZW4gdG8g
dGhlIGxhcmIgZGV2aWNlcyBkdXJpbmcNCj4gcHJvYmUgb24gcHJvYmUgZmFpbHVyZSAoZS5nLiBw
cm9iZSBkZWZlcnJhbCkgYW5kIG9uIGRyaXZlciB1bmJpbmQuDQo+IA0KPiBOb3RlIHRoYXQgY29t
bWl0IDI2NTkzOTI4NTY0YyAoImlvbW11L21lZGlhdGVrOiBBZGQgZXJyb3IgcGF0aCBmb3INCj4g
bG9vcA0KPiBvZiBtbV9kdHNfcGFyc2UiKSBmaXhlZCB0aGUgbGVha3MgaW4gYSBjb3VwbGUgb2Yg
ZXJyb3IgcGF0aHMsIGJ1dCB0aGUNCj4gcmVmZXJlbmNlcyBhcmUgc3RpbGwgbGVha2luZyBvbiBz
dWNjZXNzIGFuZCBsYXRlIGZhaWx1cmVzLg0KPiANCj4gRml4ZXM6IDBkZjRmYWJlMjA4ZCAoImlv
bW11L21lZGlhdGVrOiBBZGQgbXQ4MTczIElPTU1VIGRyaXZlciIpDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnICAgICAgIyA0LjYNCj4gQ2M6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsu
Y29tPg0KPiBBY2tlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4g
IGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyNCArKysrKysrKysrKysrKysrKystLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11
L210a19pb21tdS5jDQo+IGluZGV4IDhkOGU4NTE4NjE4OC4uMjBhNWJhODBmOTgzIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCj4gQEAgLTEyMTYsMTMgKzEyMTYsMTcgQEAgc3RhdGljIGludCBtdGtfaW9t
bXVfbW1fZHRzX3BhcnNlKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgc3RydWN0IGNvbXBvbmVudF9t
YXRjaCAqKm0NCj4gICAgICAgICAgICAgICAgIHBsYXRmb3JtX2RldmljZV9wdXQocGxhcmJkZXYp
Ow0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgaWYgKCFmcnN0X2F2YWlsX3NtaWNvbW1fbm9k
ZSkNCj4gLSAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIGlmICghZnJz
dF9hdmFpbF9zbWljb21tX25vZGUpIHsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7
DQo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9sYXJiZGV2X3B1dDsNCg0KVGhlcmUgYWxyZWFk
eSBpcyBhICJwbGF0Zm9ybV9kZXZpY2VfcHV0KHBsYXJiZGV2KTsiIGF0IHRoZSBlbmQgb2YgImZv
ciINCmxvb3AsIHRoZW4gbm8gbmVlZCBwdXRfZGV2aWNlIGZvciBpdCBvdXRzaWRlIHRoZSAiZm9y
IiBsb29wIG9yIG91dHNpZGUNCnRoaXMgZnVuY3Rpb24/DQoNClRoYW5rcy4NCg0KPiArICAgICAg
IH0NCj4gDQo+ICAgICAgICAgcGNvbW1kZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKGZyc3Rf
YXZhaWxfc21pY29tbV9ub2RlKTsNCj4gICAgICAgICBvZl9ub2RlX3B1dChmcnN0X2F2YWlsX3Nt
aWNvbW1fbm9kZSk7DQo+IC0gICAgICAgaWYgKCFwY29tbWRldikNCj4gLSAgICAgICAgICAgICAg
IHJldHVybiAtRU5PREVWOw0KPiArICAgICAgIGlmICghcGNvbW1kZXYpIHsNCj4gKyAgICAgICAg
ICAgICAgIHJldCA9IC1FTk9ERVY7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9sYXJiZGV2
X3B1dDsNCj4gKyAgICAgICB9DQo+ICAgICAgICAgZGF0YS0+c21pY29tbV9kZXYgPSAmcGNvbW1k
ZXYtPmRldjsNCj4gDQo+ICAgICAgICAgbGluayA9IGRldmljZV9saW5rX2FkZChkYXRhLT5zbWlj
b21tX2RldiwgZGV2LA0KPiBAQCAtMTIzMCw3ICsxMjM0LDggQEAgc3RhdGljIGludCBtdGtfaW9t
bXVfbW1fZHRzX3BhcnNlKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwgc3RydWN0IGNvbXBvbmVudF9t
YXRjaCAqKm0NCj4gICAgICAgICBwbGF0Zm9ybV9kZXZpY2VfcHV0KHBjb21tZGV2KTsNCj4gICAg
ICAgICBpZiAoIWxpbmspIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiVW5hYmxl
IHRvIGxpbmsgJXMuXG4iLCBkZXZfbmFtZShkYXRhLQ0KPiA+c21pY29tbV9kZXYpKTsNCj4gLSAg
ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgICAgICAgICAgcmV0ID0gLUVJ
TlZBTDsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2xhcmJkZXZfcHV0Ow0KPiAgICAgICAg
IH0NCj4gICAgICAgICByZXR1cm4gMDsNCj4gDQo+IEBAIC0xNDAyLDggKzE0MDcsMTIgQEAgc3Rh
dGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gICAgICAgICBpb21tdV9kZXZpY2Vfc3lzZnNfcmVtb3ZlKCZkYXRhLT5pb21tdSk7DQo+ICBv
dXRfbGlzdF9kZWw6DQo+ICAgICAgICAgbGlzdF9kZWwoJmRhdGEtPmxpc3QpOw0KPiAtICAgICAg
IGlmIChNVEtfSU9NTVVfSVNfVFlQRShkYXRhLT5wbGF0X2RhdGEsIE1US19JT01NVV9UWVBFX01N
KSkNCj4gKyAgICAgICBpZiAoTVRLX0lPTU1VX0lTX1RZUEUoZGF0YS0+cGxhdF9kYXRhLCBNVEtf
SU9NTVVfVFlQRV9NTSkpIHsNCj4gICAgICAgICAgICAgICAgIGRldmljZV9saW5rX3JlbW92ZShk
YXRhLT5zbWljb21tX2RldiwgZGV2KTsNCj4gKw0KPiArICAgICAgICAgICAgICAgZm9yIChpID0g
MDsgaSA8IE1US19MQVJCX05SX01BWDsgaSsrKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBw
dXRfZGV2aWNlKGRhdGEtPmxhcmJfaW11W2ldLmRldik7DQo+ICsgICAgICAgfQ0KPiAgb3V0X3J1
bnRpbWVfZGlzYWJsZToNCj4gICAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gICAg
ICAgICByZXR1cm4gcmV0Ow0KPiBAQCAtMTQyMyw2ICsxNDMyLDkgQEAgc3RhdGljIHZvaWQgbXRr
X2lvbW11X3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAg
IGlmIChNVEtfSU9NTVVfSVNfVFlQRShkYXRhLT5wbGF0X2RhdGEsIE1US19JT01NVV9UWVBFX01N
KSkgew0KPiAgICAgICAgICAgICAgICAgZGV2aWNlX2xpbmtfcmVtb3ZlKGRhdGEtPnNtaWNvbW1f
ZGV2LCAmcGRldi0+ZGV2KTsNCj4gICAgICAgICAgICAgICAgIGNvbXBvbmVudF9tYXN0ZXJfZGVs
KCZwZGV2LT5kZXYsICZtdGtfaW9tbXVfY29tX29wcyk7DQo+ICsNCj4gKyAgICAgICAgICAgICAg
IGZvciAoaSA9IDA7IGkgPCBNVEtfTEFSQl9OUl9NQVg7IGkrKykNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcHV0X2RldmljZShkYXRhLT5sYXJiX2ltdVtpXS5kZXYpOw0KPiAgICAgICAgIH0N
Cj4gICAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ICAgICAgICAgZm9y
IChpID0gMDsgaSA8IGRhdGEtPnBsYXRfZGF0YS0+YmFua3NfbnVtOyBpKyspIHsNCj4gLS0NCj4g
Mi40OS4xDQo+IA0K

