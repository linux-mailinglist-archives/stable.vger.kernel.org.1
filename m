Return-Path: <stable+bounces-214457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGYeNvKVhGk43gMAu9opvQ
	(envelope-from <stable+bounces-214457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:06:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43315F2F72
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2724303C282
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5C3D413D;
	Thu,  5 Feb 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="M7rF0BdB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401339FD9;
	Thu,  5 Feb 2026 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296541; cv=fail; b=neouhQNUrHp1rpbetvvTs+9uST5pcxh5YcAAOnJsgcSeaIVHsDKc9dK/J2irCiDIqhN5H5pg1x/ZZm0MiP3lDKzI064/BV72pVhxgog9rejPd47re15K/YIPd+S3m9HZF07bigZVj7U8Js4ueZSTQSXweA4tg3OHIRFFGePDZxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296541; c=relaxed/simple;
	bh=552DqlARefCEHj+jJuRy8g4krGPe1q/gzdy1solEFyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLoTqjyNiGBiLBbaQ0hkMqI1wCN+MLPRYRsjPASrbqk7Ei3IMxJT/vGIPnVeJ4vN/VNA8hw0x0IA1PiVkX+qVZ/AKJqei3e5/fWRNDaVt3WTcIdm3lvs5A9bspI7pDGPZAPzV/d3KGetT6FytfYO5+pzxcCXYJYIo3KWm0oXhbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=M7rF0BdB; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614NFYeM3754793;
	Thu, 5 Feb 2026 12:29:37 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012005.outbound.protection.outlook.com [40.107.149.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4c1b3h41f9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:29:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQSWMZbE1iPpHypysisTfm+I9XTNkdcq+FV1DcqWl9cnhByKhBz77yLTC5QRyjUTw2ZUWKDPyJNXAma+ykOHi8lNdA8fQv4OhJZ/zNCB45oEYQSjFCqTchfmWl7/7X/r90BeILXft/VXUk4FqxHknK7FDXMUYpwlai2wCQrGknGTE8JwkdwA7oFuWE6QHfgbbSxEJWdDrWPvLKYBqFNFIUiCsi2hsUJXadjE1z8rWID5vRo6WSpSksvm1Zh7W2atcYvuLSxGCOfLVdHRpunBKZrJvNABurN91tvOo+UgPj82fNwBMyUo+TNuXO1QW+97Z5hPJeoqjoYey4X68MBbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=552DqlARefCEHj+jJuRy8g4krGPe1q/gzdy1solEFyQ=;
 b=aU2QN9VRk1Fqv06XYBqYxnqQywJ/o2plm11WzyRpkpmXZteyBIOGvlcs8UIMqpTMC9NpUJdbCi9G8ug71rT+29sYuIuC+30iSYEKr/LNxIgpjspZ8n9OSmiAWUVlHn7MKXQlbAUECMyPuqBO4KtUAB4ya/AGuIHua/8CYrsbeLL2mV11sxy+q6BgeYQiD8gwsal82jsoh2CUSbqlh1lolsgvmgfU2+0WOaxb8uLccP0Kr2iZQy+sWDi0DQGyPOhyf5X7J0hQpeBGieqpACw43B+PqK2YNjizaEBHSw7J9uhmtOzYyDA7lZVNKPnAReF5h3E1yRqSPxI9jBWcgRjTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=552DqlARefCEHj+jJuRy8g4krGPe1q/gzdy1solEFyQ=;
 b=M7rF0BdByW2/XqDEPg+WTXdRrveNeLQKhtXWUb4awUAFgU7nwTd6SYrSlRY2dMzYUeOAWq+h0bkXQcjCvsj42+OgrszM0xr1klmW4SuXR8WVaOxMtcTbVUnTJoVHwciLrhzANNoTJe/WosNd04L6q2A6Kn5mtewwM1Xb9JRhJWb1YI5NiGDRy9y054M9FJwtXjr7IW3yHXEBb1FTUC5RDmjccGYEUacZ4NZGeLpN38E4bImvzxg8CXovQ7OXZT79DOnJG15MdiygRK5iwkgC1K6H5RyK9t2X00nNeRo88UMGDju0pztB/zU6djR1AWYA0hO8lMm9cGy+M527fsIOtw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB4395.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 12:29:32 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ab9e:1ff7:9dd1:d0d8]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ab9e:1ff7:9dd1:d0d8%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:29:32 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Remi Buisson <Remi.Buisson@tdk.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Thread-Topic: [PATCH] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Thread-Index: AQHcloWgBClOZKgMzUa3ZJpthyAMrrVz+RMAgAAO+0k=
Date: Thu, 5 Feb 2026 12:29:32 +0000
Message-ID:
 <FR3P281MB1757F7C3B3820FF1568F4001CE99A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com>
 <CAHp75VdmVP45+3r6HoC-Gf7FfXMJdmfTV739LLDAtdX_f_xu7Q@mail.gmail.com>
In-Reply-To:
 <CAHp75VdmVP45+3r6HoC-Gf7FfXMJdmfTV739LLDAtdX_f_xu7Q@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB4395:EE_
x-ms-office365-filtering-correlation-id: bb56e23d-2722-415b-e2bf-08de64b2372c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|3613699012|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkJDR1ZZVDhOeHdIZ05UWEh3Q3JXUGZxeWtvdmhKbWVNOERRckNEaGV3TFBi?=
 =?utf-8?B?QjlTRVBDc0dZTTJ4cHQ3Vkl6UlF1em1DbElVdVEwQ3V1bVJVSmxiUTEvMktT?=
 =?utf-8?B?NXJmU3dsaUNZV1lGL21Cb25ST3JWeGlyRythNVYrRGVpNXNGVjlBTnZRMmV6?=
 =?utf-8?B?UUNIS0VHMnNFczI5SzJ6OWsvVStveE9PUnVHMEtIMlBLQTZaazhFTXpXNjVq?=
 =?utf-8?B?R3VLcStFckQ3aFpPenhLdHd2YjBIVXhrTTMvdW5aR0o0YmZ3R3F2dSswYURa?=
 =?utf-8?B?ZkNET2g0dmZtaUlPOTNTalR4OUl6M01HYVF3VzhOd01GTS94Zi95c3lQVmZ5?=
 =?utf-8?B?UExRYTQreDVTTys0WmJ4K3BtSTlIdm9qcVlta25xSmxkaDJTeVRjSjN5bngw?=
 =?utf-8?B?N1NxbS96ZkJOdHVKNXUvSnlqRFJBNU5pYkZsNVBQZjh0UXBLeXQzR0hGeUVK?=
 =?utf-8?B?eGUxTjJrNEo4TUJmTUtLOWNnMW16M0pNM2dYWFJRYUZvVDZxYlpCZHg3d1hm?=
 =?utf-8?B?am50TWlWNzJLMFFucDBFV3hSM1hlaDExQ1JtT3BNS240L1ZIWURSaFVnU1p5?=
 =?utf-8?B?MVN1eDNZZVZWS3piZ0VzQ3lQRSt2Kyt5cldVZmdWU2I1Zzl6VHJvbVVCQUpN?=
 =?utf-8?B?RXV2YStKeElnMm5FdkpIVmh3cG84bXljdVg0bFNqV0crVll0TU9pNVFmVE9s?=
 =?utf-8?B?R1czckwxNGMrWlo1Nktid0NxTW1rTnFNVFl4WTBhOWZ6a3VlcHpSc0U4b2t1?=
 =?utf-8?B?WUV3OGxEWlFoVys1c2xxaWxlRnFOa1lZemFjQ3QvelBjV3dlMjJCNjlmYk8w?=
 =?utf-8?B?WW1UcU54ZExPaXNzUTFhdmRmT29YQnN2ekp3dEIwMzVGNGJITStWa1pnZW9s?=
 =?utf-8?B?OVNFUk80T3E5T2ZqcmN4cDRuWHVSQWE0N3I2N1VGcUY2RU1JM0hncDV4RDB4?=
 =?utf-8?B?NVZja0xJVTl3YzQzeXoxZHFCNTM5ajN4eWpndzlQVjJZT3BOaUYwRlYwcEtq?=
 =?utf-8?B?TzZMc3VlMm4ybWVFYlByejd0UW1DaUVxNklXam1ZaTVjdmZHUHRRVkNJNUt2?=
 =?utf-8?B?aFV1TXlIUm9waW5lZGNRTCs3UlB4YWE1NnpqTEVGUzIvYlU5bWV4Zm9Gb0Zo?=
 =?utf-8?B?UDM0blMrT3Rub0pBODZqS0JXdjIzTnhVNXhYcVU4Y3BrSDQ1Tzg4WHhwMElN?=
 =?utf-8?B?SlkwMjlQQ1VCd0Q5VVdGbXQ4ZHhxK1VoU0cvL25CZkNadEw2QjIvT3E1VHpD?=
 =?utf-8?B?WGdiNmxoa2hEQU94Rzd1T3ZJdHcvMFZWTDBSdXpFOFhST2NLdkhLVjNJWTlo?=
 =?utf-8?B?czU2Y3BhSkpNQWhwMnlCZzI3Z290Y1dYajNmb2FwdVNiUHdlaVJiZEV2K0x6?=
 =?utf-8?B?dUFaZkluSWJqQXVaRDBzUHArNEk4dml1QlFjMkY5WTEyZnorcERFRCtRVzJ0?=
 =?utf-8?B?dXRDQmtkQ25FTTRzTDNQNm9CVkI4NURHanB4eXU3L21BdUNPanN0MmZxUGFB?=
 =?utf-8?B?R1pSdmEyczByYjc5OThCRWFnd2NrVFFhclBzUFhYbEIzLzJpZEl1VHk4cGpx?=
 =?utf-8?B?Y1ZxSnFrNU5FQ1dOSTdvdHhxMDdGU0NhOUlGendSVnk4YUxXNWtPbm92aGE4?=
 =?utf-8?B?ZGhZUll6c09Kbk1mdTR5SjZrMy9rcUtpTjd5N0F0Vk5uQ2p4Ynh2K3NMNG4w?=
 =?utf-8?B?bG00dzdjTktKMmVvQ3JDQTRTNkxodjZqcmcrcU41bHFFeVpEL3loZXVsTmov?=
 =?utf-8?B?UXFNdWpiS3M1Rk81MW8zQmY5K0VxeTY5MTNveEFST0xvUU1pUkt5UHZ4cCs0?=
 =?utf-8?B?K3hNbkttaCsrR2hHdTMyNnJiNGlBdDdlaVBrNmtIRDJScHdJdk1OUWxlRERk?=
 =?utf-8?B?cDNQdENQV1Rqb0QrTTZ5S3huc1hSSmhWNDMzZFRCV0hDVmpqM2g0VzdCK2Zx?=
 =?utf-8?B?bHRIeXA3UnRHTVFVbHAwdnBzM25vZEtCVWVPeFkzZnBnbjJkcXFRMnR6S2RE?=
 =?utf-8?B?NHRldk9KdWJTV05oVDFsQ0x6VWFndEYvdmRuZmV2eElldWJHNTJTTUlhbk9m?=
 =?utf-8?B?bmJTdXg3b3ZLbm5sMHNUWVJ1cDFvdXRueWN6bXJsZVY0VXdiaDF6Z3hoS0RL?=
 =?utf-8?B?TTdEcmw4UUp5b1FJMzBjOFB1U0hnSjJIamk3OU9XaHVYdGcxeW1TSFlqK1FX?=
 =?utf-8?B?S0dOVWVVb0hNK1MwdVFXRkNmbm05bVN1R1VwemRGR0JrWTRXNDJ1U1dPT0VD?=
 =?utf-8?B?c0FLYzB3NUVFWkg2aC8rK24wYnpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(3613699012)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckh2eU1QT1pxNHptMGxvY0c5SXpsYWcrTmpCVzBQQ3lyeE5QdE8rWTlzRzBu?=
 =?utf-8?B?bmx1Qldzb1VHSTZBS1J1ZlpNdG1TMXRiek9CMTQyeWZhSXEvcXBOTGF2RXhP?=
 =?utf-8?B?d3dPNW9nN2FHbmpqRWFITWQxMTRCYUtocFNDaU5VdTJ5WW0zRlpmSitXdWt3?=
 =?utf-8?B?TVZhUnUvck5aMWpueW1xTW9jK2M5RlFTdUJGeHFLcllJWTJQOERONjc4b3l4?=
 =?utf-8?B?WGxQSmg0Tm5hOFlJRytoaXZkRWRHRHlUUFZMYnEvVVZuRlZ0c25jNFJWbFJ1?=
 =?utf-8?B?OEx6cWJybzJuQ1RIbDNXNTRkT1B6bW4ydUViSVlML28zVkFuMVVDSDFSM01s?=
 =?utf-8?B?bzhkQ3EvclJPc2RBcE5BZFc4a29ZU0pnRmFOSENvdlJiMVBVbkp6ZElmdnY5?=
 =?utf-8?B?QnprYkMvT0ZnMmplYjFxUUhGVVVLY0RIaitjbnFBZmNMcGhoOWNSYlhjdlVS?=
 =?utf-8?B?R3E0VFFtazVmM1N2TEtXZ3FrWUZxTHF2Z0cweXRDbTAvbW03V1I0SVpWU1Rl?=
 =?utf-8?B?NGEvTk9sNUpxVnlyUStDaXN3U1FCK0wvNER5WDBUblZBNklBUURndDNlVmRF?=
 =?utf-8?B?dU51dGg1T282Szk1TGVJVmhQS09FMWtGOVdXZUF4dUtlT0YrQ0Jxb3pySWFq?=
 =?utf-8?B?UGFEUnBEMGhrSWx4OHVWOWVTQ3hQREV1Nko5bkt1VkUzZHRObUluNzMvRGVQ?=
 =?utf-8?B?ZVF3VlZnQ09EeTZzYTJLc29IWDVFWmozWDZ6V1I3eEtXZmNYUTIycTZHTU5W?=
 =?utf-8?B?TGczMTcwOEdEcmpLSE1oNmxheVlDMGFiR1dKbjBDVnA4UVQ2d3M5UnArcGRo?=
 =?utf-8?B?OTBxallYZG5vcG9hNGw2aCtRMzhEOEFSUFVlQ0hITk1zMFpkSENZZGxYTUp3?=
 =?utf-8?B?RnZWUVdGbDVaNVBHS1NKb1UxY2ZyTDcyVXllbmRES1dXMTBPK3owRktBdXRn?=
 =?utf-8?B?ckxDZmV2MkZhbHp3MXI1U3psYVhxV2hvYW1aT3krenQ2aEpEeEdtNDJ5SlZM?=
 =?utf-8?B?QTNtWDkxNHhVRzg3KzlXWjBCY1NNeDVCS1ZwMHpVVEtPQURyRE9TQjVMeXdQ?=
 =?utf-8?B?OG5ITGF1SXd6UkJ4bVEvd1lVZmUvdXZ1Q0xMaWQ5aDRmOVJKOEkybmI1M2ZJ?=
 =?utf-8?B?dDJXTlBxK1ZvSW50ZmFwYXhKMjhtSXg5YUVKaEVhT0VSUzdzNDVwZE9qdWdw?=
 =?utf-8?B?K29McXJDZ2FacytwQ0JyOFk4UmhSb20vMUhUMXNCWWdBUnc3MXR4MmlmSENW?=
 =?utf-8?B?aERLZXVUdEduS0kyUTltQVQ2akF4bytDTzFMQk5MZ3dzbDc1N0dtU1Bma0Ns?=
 =?utf-8?B?RG9lQmpoelNOVUtwK3VKWjBZdmtlU3RwU3d3OHNrcFBERHNjOSsyZ1lkY1Ja?=
 =?utf-8?B?VDJET3FNSWZTS0FsR0xDb1o2b3hxTzVjNHJzTDdqMXUyKzlheERjRGZnZkdv?=
 =?utf-8?B?TjNoMHVvWFkzY2NnaFlYcXFYRDdmR1pEdjNwS24xV2RDdG1yMEdHQ08yWUYr?=
 =?utf-8?B?UWVwT0wyU3lkQXd1bU1uQU5aUE5udTdmbzM2b1VyT0JvUllVV1l4VlFyNncz?=
 =?utf-8?B?YTZveVZGYk9LQzA5Rm9UdFVJUmdTdTlPejl3K3ptQjhNVm4xQkMzeWd0QzZq?=
 =?utf-8?B?dG5vSmRTYTRiU0h6UGMzN0xRLy96TlUyaFhCcm8yYy9XbURvZzJHS1pWOWZ4?=
 =?utf-8?B?bWttWHFlbUx0TmU5bTdpS3lJNVNFeC9WWDV6dnNndVVOc09TZW5vYTFrME9h?=
 =?utf-8?B?dGdOckw1WmMrZ3ptOFlSeVdHelNVTHlML3dkaXpVZEkzdTBtaHorOGZnaVl0?=
 =?utf-8?B?MEpxbjYyVU9ITmRrQldMaGJ3VjJrTHY2RkRNdGE1T0tzV2svMmlwSXdtdXJk?=
 =?utf-8?B?ZkdiYit5aktXcHlFeld1dFhoVFYvSG41bGthY3h5SVdvWUtXRWJuRnFQeFM1?=
 =?utf-8?B?ZlB6VkcvUTRody8rNHNhUlJpNmZOdGtXS0F1ZkhPdUJkVytVSFY4TFM5K2U3?=
 =?utf-8?B?T1ErcXVZMHVNWTFHc2duaE1lNDBLcTczZ2s4NTNxUlliNFJKeTg5Sk1FdFVU?=
 =?utf-8?B?bTBvYi81ZjNyYzNEQlR5ZWxpQ3NzVmp2OWNxaCtCQThHeDFRVWJGRDN0V1Iv?=
 =?utf-8?B?UUhGdzhyUzE0OUNaMU1iY2RYblo5b2xuRmV2cTBTQzlNTjQ1dXk5T0QvVTNy?=
 =?utf-8?B?alRKU3BKMXJ5TEcva2xrendFL1FuZ25ZTjBheld4NXlmeEFHSkVoaWtQcEEr?=
 =?utf-8?B?d3NuL21Lcy9MeCsvQnNCR05Bb1NnY29YdnVjT3ZRZ2ZMbTlDTHhlQUc2VXh0?=
 =?utf-8?B?RTdwODRUcjV6NVV4bWsxUFBOVHlrYk9aYThvUmVEUEltaGt2bVc2Y2JCb1VG?=
 =?utf-8?Q?KtO2fjdNycJlfEck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bb56e23d-2722-415b-e2bf-08de64b2372c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 12:29:32.5543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+xYnLFXXJUDY6XZiIOu3IV2tcAYxCCWe3/g3iyY0Nm45ua8zyNw13fk4APPNBMpWya121qf+USCD2k4PHUlpU0d8tU6UGnLQa6LMppLKDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4395
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Y431cxeN c=1 sm=1 tr=0 ts=69848d31 cx=c_pps
 a=pgaSwyyaIxgBiXzK+vO+rg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=In8RU02eAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=i0EeH86SAAAA:8 a=6yoErSXb8f44zbpSRBEA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: htmYK649n_QTVNnspMbcn33pfelzxgyo
X-Proofpoint-GUID: QxJytXbAbqKgfFntuSLiaqRDqpsLde8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MyBTYWx0ZWRfXzCceN3ZbfwiX
 1T4o5wjVuGUdB1CDBAQf/I/RJIv0+QngTaL1Bmdc9vPKQIPSOI/ejECiqq/76QRLeYR9T6KYiMC
 0p8m7c6nM3l2yo1zicUcyU9HiMHvURXr2I7Avs57YmA6t5Ry1ZY/as8ld/YmQHNZiFBpJkZN33I
 Pw0XEwjuOjteWXwu6jtNsXnwKvSnmYsBGxYSjEJIDlgTKw9pKMeB7/OtcnEbqke3AAkeRGaWOhD
 lUEQsig20Z6CgJGzJ5FY7m7VG8soqSZG+x0M4sBe+RA0Mv5YkxxfnU8f90ZiK0tV4rJLTkqHLr/
 lMHgh4Mstwf7NT/dtHmhp3xMwopf5fLMvZb2SUlcSLLYfILpwFRN+7pkfVTLe0qhtF8Atf1/Wc2
 40Tl7cXXXRvqfx74AP5rOzy0s66MUBQ8ZRqlYgAIkBCJ1C7u1fOM5wsDAbRHy0pVB9R8s7QRLWp
 nGSYPtNPNhYVecrvhuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tdk.com:email,tdk.com:url,tdk.com:dkim,huawei.com:email,baylibre.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Jean-Baptiste.Maneyrol@tdk.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tdk.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	HAS_WP_URI(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 43315F2F72
X-Rspamd-Action: no action

PkZyb206wqBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+Cj5TZW50
OsKgVGh1cnNkYXksIEZlYnJ1YXJ5IDUsIDIwMjYgMTI6MzIKPlRvOsKgSmVhbi1CYXB0aXN0ZSBN
YW5leXJvbCA8SmVhbi1CYXB0aXN0ZS5NYW5leXJvbEB0ZGsuY29tPgo+Q2M6wqBSZW1pIEJ1aXNz
b24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxu
dW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IEpv
bmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT47IGxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgc3RhYmxlQHZn
ZXIua2VybmVsLm9yZyA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPlN1YmplY3Q6wqBSZTogW1BB
VENIXSBpaW86IGltdTogaW52X2ljbTQ1NjAwOiBmaXggSU5UMSBkcml2ZSBiaXQgaW52ZXJ0ZWQK
PsKgCj5PbiBUaHUsIEZlYiA1LCAyMDI2IGF0IDExOuKAijU1IEFNIEplYW4tQmFwdGlzdGUgTWFu
ZXlyb2wgdmlhIEI0IFJlbGF5IDxkZXZudWxsK2plYW4tYmFwdGlzdGUu4oCKbWFuZXlyb2wu4oCK
dGRrLuKAimNvbUDigIprZXJuZWwu4oCKb3JnPiB3cm90ZTogPiA+IERyaXZlIGJpdCBtdXN0IGJl
IHNldCBmb3Igb3Blbi1kcmFpbiBtb2RlIGFuZCBiZSBjbGVhcmVkIGZvciBwdXNoLXB1bGwgPiBt
b2RlLiBBbnkgcG9pbnRlcnMgdG8KPlpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydAo+VGhpcyBNZXNz
YWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyCj5UaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91
dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCj7CoAo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+T24g
VGh1LCBGZWIgNSwgMjAyNiBhdCAxMTo1NeKAr0FNIEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlh
IEI0IFJlbGF5Cj48ZGV2bnVsbCtqZWFuLWJhcHRpc3RlLm1hbmV5cm9sLnRkay5jb21Aa2VybmVs
Lm9yZz4gd3JvdGU6Cj4+Cj4+IERyaXZlIGJpdCBtdXN0IGJlIHNldCBmb3Igb3Blbi1kcmFpbiBt
b2RlIGFuZCBiZSBjbGVhcmVkIGZvciBwdXNoLXB1bGwKPj4gbW9kZS4KPgo+QW55IHBvaW50ZXJz
IHRvIHRoZSBkYXRhc2hlZXQ/ICh0byB0aGUgcGFydGljdWxhciBzZWN0aW9uIC8gdGFibGUgdGhh
dAo+ZXhwbGFpbnMgdGhpcyBiaXQpCgpIZWxsbyBBbmR5LAoKaGVyZSBpcyBhIGxpbmsgdG8gdGhl
IGRhdGFzaGVldDoKaHR0cHM6Ly9pbnZlbnNlbnNlLnRkay5jb20vd3AtY29udGVudC91cGxvYWRz
L2RvY3VtZW50YXRpb24vRFMtMDAwNTc2X0lDTS00NTYwNS5wZGYKClRoZSByZWdpc3RlciBiaXRz
IGFyZSBkZXNjcmliZWQgaW4gc2VjdGlvbiAxNy4yMyAocGFnZSA3MikuCgpUaGFua3MsCkpCCgo+
Cj4uLi4KPgo+QXNzdW1pbmcgaXQncyBjb3JyZWN0LCB3aXRoIGFkZGVkIHJlZmVyZW5jZSB0byB0
aGUgZGF0YXNoZWV0Cj5SZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5v
cmc+Cj4KPi0tIAo+V2l0aCBCZXN0IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVua28KPg==

