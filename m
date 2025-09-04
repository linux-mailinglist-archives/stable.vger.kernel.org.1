Return-Path: <stable+bounces-177769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD715B4463C
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 21:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7925017B87E
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497642505A5;
	Thu,  4 Sep 2025 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xq/8Bhap"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2A33997
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013369; cv=fail; b=YTH9cHS+TD9AOMAfMgHNOiPVhYqYs9ZR4cOi0izjSENGYRa00dyBLRe+RVBeghuKmSICotBDey1AhLlkSwPY3wPZayyxzISeuNvsrjEURR7KKZRipQliEwlTYwJuSbSX7UCfz31AKjJZ837DU9iDEWZ6TYalWTpko+0ocuCwmzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013369; c=relaxed/simple;
	bh=xH4HEIV+j00Khn4x/5wxWrfhFOarDoAWJjt2f4/yDTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fh1Bhbr+yYPs2+JmrHtOnVvDrmQmEjzNlpUnyFnmwK1fQ44gs6xHErQhDzRBRM/vkMPHw26ToYkcgtun3ZnuRMAqYZ1BOLk3K7Cd0qqlVFGpCq1vabqAR6LfBpWDz2EoNZT1S4Vsp/TzpkQxubhhs8L3OO2t5rMM/yp4LpMwv4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xq/8Bhap; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Czog6m2Xh6XuNFKe3s1nMySzryAuE48YwKvIKVre3edQqtubiq3OTBDk3gzYNIK4ZnnJWgdAsobpb1el++K1kaWM5CZXkjNVN2njCFKeSTIaSMf7fh6d/oMUxkqe13r3oWEzmI3aXWmXe553Q9aD2xIDPI6Pg7iiDllBGRahU29PvWU7H9QTLkmQDIzzQ7c7ve7MKVyrPdUJ0MUSCVh2vlpsDSWHGA6yexmc1nl07/oORRNX3dCg1IvSVQ/Go+gCKskLs2hf9WiDATB+h1ZNBTqr1/+Jv+FEKVT11sAw2vFtcNjpJTwx2jrRsOvuh2wFD9PBtpA0RdSkoACnyRYerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH4HEIV+j00Khn4x/5wxWrfhFOarDoAWJjt2f4/yDTc=;
 b=Hfp6vRAb/99VdQXh30r2fH85rkG4IpTDxMTQBnvyQIwWYJfjmTNG860rOtozI9ZNZzeztQSuQobfpoZtuLMA46Yu04d4CPedERFYOzCEBJT4Nr3Kz6SmaeAnYRetDOzGB/097t+3Xra9VyAX1S8S7Njfo+jqA3ryN+yDX7Xz2xHWTFJssSh6yp+dErmG2RtQl619/3E4aVTrIvBs8vtvte+T3mIdmD5Er4Eu1R/aXP2Ocq2OHnXreBNBAJp3FP9lk328h1EiHyb4yfWFf25pX4gcx9B8UWZl+lSXVJsONjF4T6+x3YKdUb7f0Hn5IPZ7hgUxEDPuPF4Pik+I68n6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH4HEIV+j00Khn4x/5wxWrfhFOarDoAWJjt2f4/yDTc=;
 b=xq/8Bhap8GxQ6TefdbQ65VA2iLWyNJKmkrD8Gq7w8IZ6JANBwff9v2Gp4puv/P2G/RUiIBkVzKhyWf2crTDOLICaG+M/2v0NxVMuY/3Y4ZI3xJsVYnQ/tLNQ6cUJD+Oo0pkmaWIAdcucVkiJMYTK6PDdDhtsb55rhh81FiATgEk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 19:16:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 19:16:04 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "Lin, Wayne" <Wayne.Lin@amd.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Imre Deak
	<imre.deak@intel.com>
Subject: Re: [PATCH] drm/amd/display: Disable DPCD Probe Quirk
Thread-Topic: [PATCH] drm/amd/display: Disable DPCD Probe Quirk
Thread-Index: AQHcHdAWfG53tAhVakWK+Xeuq6lwl7SDZRYA
Date: Thu, 4 Sep 2025 19:16:04 +0000
Message-ID: <dcfffd43-30e9-44eb-811c-d3aedd0fb860@amd.com>
References: <20250904191351.746707-1-Jerry.Zuo@amd.com>
In-Reply-To: <20250904191351.746707-1-Jerry.Zuo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW4PR12MB6729:EE_
x-ms-office365-filtering-correlation-id: 80b5f031-72cd-4db6-1586-08ddebe77e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Si93UkRuc2NNVjlWOVF3N29rY21Hd3d5UHVwNTlXWkJ5ZS90VnZLUVRQMmJD?=
 =?utf-8?B?ZTFGZjdGTVo4VlV4NDZINjA1RTJlek5VWWJDeERlMDlOOHF3bTk3bnNGRk5J?=
 =?utf-8?B?YW04bG85UVMxdWw1WFBQZDZQdlVEb0o1V2RyTUowYWxWUWlCMTBsTDlUWTVq?=
 =?utf-8?B?endhNjVjS1BIbmI4QkRHeWZGaHVUQmRTNi8wT1MvTVcvQWJ2NnVnQ0c0YnpM?=
 =?utf-8?B?Z1BYek1CdEZmdEh4U2Q4Q3lKSW0wSEY5b1Z5Rk44VUIxd3FhWG45ZG9pUFNz?=
 =?utf-8?B?MGVydHIyQ3AzN0ZpaitIT1paOFFhQWlBYTlXMzQ0YThub3NWQ2w0bHJQMUJI?=
 =?utf-8?B?VkF6eVVJTE1KQ1RINk9rWWpqRVpUMGJxdmh5bVAxRmU0RXg1S3pUd0RsV2J3?=
 =?utf-8?B?cGY1dDdQMzR1eW5XVGxHMmRBNjdMa3U5bWlhMU5xS2hMMjFkUGJqRGVxR0o3?=
 =?utf-8?B?aWJzK0hlcEVIZkJ3TzJyZERIQ3ZuQTdpRFJwaDd6Rk9KQTNyZUcya2VLNFZE?=
 =?utf-8?B?YlhCUlEvQTV3aDVkU1BwUXJrQzRaRU1YcUZFbTdWcVZWZHV6NE9KY1AralIw?=
 =?utf-8?B?c0lneGdEbDlQN2xBVGtDZHVvc0t2VzlaSnNMMzlDUFl4ZmJlOXJZbDZTWWlX?=
 =?utf-8?B?RnlPVEQ1clMxR3hORTBNWlJpT2Q5ZXAwMHdkczQ1TGtzSzM2N0FRbHRLblhZ?=
 =?utf-8?B?UEc2Ri9RRkY4L2MrRW40SzhjMW1UMUNUalEwb0dhak5LZU1mamRwaC9CVnRS?=
 =?utf-8?B?MFFTRXdiWklKbm1ueXgrTis3dkVMR1krcDhRcHlqK3QrUHpHVlIvNHQrOStq?=
 =?utf-8?B?b0Q5amNJdTdjTjRmajJ6bWRCUlhuVmh1d2NFQzczZUhudHNKa1l4Y0JoY1hw?=
 =?utf-8?B?QUFTYmFFS3NxaDZLTE5PY1N3eFZUVUNrQUdyTUxyUTdIMG11R2FiRDNTQVBn?=
 =?utf-8?B?MXlhVlBrS3V4SEpNYXRnSEpkUWJxL0RsWnlsaTlkOUVDSnNLUVhnSldudTlS?=
 =?utf-8?B?anpQblRLdGVGMStFTm53T0VpZDRwdG9mNmZMQmdDcTZ0b08rN1ErSndHeGcw?=
 =?utf-8?B?WkhYQ1dWRXBJWUVsRHJLYmtIM2U2VDZmNGM3K3U0YytNNWNSVlV3alRCejZN?=
 =?utf-8?B?WXJMNC8xRmlWNTIrdU5VL1Z3Vnl4SWFDdVhTd1pXZ21ydVZsdHdxUE95RDVS?=
 =?utf-8?B?MVBvYXN2bnNYOEZPVGtHRU5ONmFaKzRyeGVpeXlramxBWTZtd3RyK1hLRStT?=
 =?utf-8?B?ZitUc0lvWlMzOEJubFZqb3Q2UEZqQkJ1aUpVWGtjdVlhK0g4S0hhZUdTcGRI?=
 =?utf-8?B?cWRsNm9HRG9zSjhVNWpoRWN0T2J3VzJSSEIvN09kRkNqUjJhTSt5aHJjN0Fp?=
 =?utf-8?B?L0Z2M2t6a1BnVkNFUWxnNDVjWitDTkd3WTVyQUZidlVMaVFRZVhlRHVlVkp2?=
 =?utf-8?B?ZktuVjI2aEJBSk5vdEJUTEpOcS92dHN1aDB4TE4rOC9WU01uQVRJSy8ybTVr?=
 =?utf-8?B?M2NORHB3SXJSMDhOMjVlZzB5NzYvSjNGYVJqalpSNW1QcXBZUVkxQ0k0bnFv?=
 =?utf-8?B?OEkxU2tGSG1rU0JGZlBiV0JNYTZoY0tFenJ6dWo3K3c3R2lRTmdFY1RjWVpk?=
 =?utf-8?B?cUp5eTh2T2xROStBdHpyaXZRdEpQaXM5VHZuMDY2MGFFa1JiSDVwZFB0a1pQ?=
 =?utf-8?B?UWU4N2VPWHB1a2xpTjY3UExZZzVqNVcvVFlNTThnVkdZRW5QMXlFNlBWL3Fx?=
 =?utf-8?B?L01pUDdaK3Q0VnEyMExKdEZRQkNUN2tFcmI0OEtvVElNVkVyekUySld6WGlC?=
 =?utf-8?B?WWpNSkVJM1QxOEFlOFYxcnJKWURHWHB4ZFc4d21NRmJ6TW5QVUdxdGkrSTVw?=
 =?utf-8?B?WEkvbjdPM25KYTZQMmEwQlhpcjZJNEc0NnN1TVZEWkhkUjdiNVgrRUJ0UURH?=
 =?utf-8?Q?zGvIICJW3N0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWRKWE1mZnN5NnRXK24wdFpOYUNZMFlOcHk4ZDRuTGVvQUlOanpDU3RzelYv?=
 =?utf-8?B?UURvV2MvaVIvZzZUdW5jcXZvMFVPN3RRdkQwR1pLUmlmRlhyMXpKdm1NVCtS?=
 =?utf-8?B?bllxNjJqeTdtWXk0NnBRNEhSNUtWSnVNbExHSGFPOWYzN0pnR254NlRacjFO?=
 =?utf-8?B?M3RaUys1eUE0ajFhT2YrRldNOVI5REZGMkdROEkxVXBUaGpiV24yQzdIY01G?=
 =?utf-8?B?RGFtYzRGY1dqTnRnc1dZbEpHZFM4Tm9mUHNLQ0VIODNvWUhIb3UzdVpScGdS?=
 =?utf-8?B?VEZqc1hJTll3UFpqTm5TMkZxclp3Sk5LeGZFSUFTQXRVNEZ3OERmUzU3bXpO?=
 =?utf-8?B?UlBBZllrOGNIMTZHajBITlVJQ1dOeHhaTWFSUFBkUlhiWU1IUVdVT0xBZlYy?=
 =?utf-8?B?b1VQM05vWUZ1VTU2K1V3OEg5WlhDZzBHK0tLNXJ0RUpmWTFJa1FwcVBJTHBx?=
 =?utf-8?B?VkdPUWJzRWZtTmFpK3Niem9aMllwYjRlOW03UnN1N25KVEMrS3NxWXY5Y2dO?=
 =?utf-8?B?TEloN2xFN29wZWN6R0MxZndMTUJKVEtlVEp6aDNobi8rNTlkdjcrVkNkV1ds?=
 =?utf-8?B?d0s3NERkUGhTT213Z2MwTUlCNHY3dzJPdEdqdVB3azJNdUsxM2NhMlBqUEh3?=
 =?utf-8?B?WFhJVmZ0enBjRHU4Qk5LRU5uUkFuN0R4b1NCUGM2cTRDczBPVmo1bWlSN0Zv?=
 =?utf-8?B?Vm10OXVweEZVby85b0htQk9YQWVXVExPVFZPNHJqSk90cjA2bGJZWVNneXBB?=
 =?utf-8?B?QXNtMldTZWkyRjZhL2tNQ0JGVTdLOFI2NnJ2VDNsUDFlVE5mN1F1VHdET2hZ?=
 =?utf-8?B?T2J4RlloRVhIWUFRNVJBWmtkOVFQRGUwTFAyYmFpeFpWUm1RdlgzS1o5bXRu?=
 =?utf-8?B?RjFVRFZRRHFDV1JRelZscmJOOGowaHk3OE5OT1NqOGNRZVd6SjU4ellMV2pS?=
 =?utf-8?B?aHpiL3hKQjhrbnlSOURRbFlyMGNncUlyWHBwcnp4b0t3cm9PZnU0Ry8zTUU5?=
 =?utf-8?B?dmx5c0xFSmUrZzNwdXR5N2Vab3llWHhUbDJvd3hoNzdRRlZsYXpEdmFUazNN?=
 =?utf-8?B?NWxFUWNVQ1o5UjhYRmZtTTluV1VxY0tMdzZSYjA1THcvaTRVTEFENlpJbzlk?=
 =?utf-8?B?aU0rWnI5NHNSdlg2STgya3JLZ0ZkOW5nUjRSNlNhWW5DTCtEU2RNY1NQQUVn?=
 =?utf-8?B?MmM5Vm83MGVPT3VONEdLR29sNzRSVnIxWGVzTDdkdEpsUElDSEVEUXJwczJD?=
 =?utf-8?B?U1A5bU5SNHJIZVRIZDBVSDFaelNUa21VbnlqTzRWajZ2RCtLZ1pZTTY4OGtV?=
 =?utf-8?B?Q0kvUnYyTlFjYzFnVW1aUGdmNklIWWZIZHpiamJmM1VJVkNNRXB4eCtlSlZB?=
 =?utf-8?B?M0k0bmY3cFZGWjNDZTV2emtrdDBEQzlKRnZWMDZpclVlUFlSYVJ4dy9DQmM4?=
 =?utf-8?B?QzR0MlpLVUViZE1JcHpqYnRwMkVKMkh4L29TM0VjVWVGeXJOZHpBM0RRMVJs?=
 =?utf-8?B?Z0JPOTdFNXRZR0tBUzZ5bjMrdlArVkI0anlySkNHdXptVEN4N3RNeXVnZkpS?=
 =?utf-8?B?THhHQWxpcDhJR29xOGRMVENpbXptSVU5alBoNkNJRU5BaUJ0VjBEWHlGd1N1?=
 =?utf-8?B?SU5jWVFSanZkUS85bHlucUF4czlweTVQU1J1YjdmdmhUZHY5eEZENmloNGsv?=
 =?utf-8?B?RTVjOE1TcXNIM25jZjhpRUFUamI4cDA1VDlyMURKdTcrVkoxOE9JZWJBMlEr?=
 =?utf-8?B?bkIzNTlaQWJwOVl1ZHA3RnhyUVBDMzVuVlNSeTVwN3B3aTBYclhZcytjMHJx?=
 =?utf-8?B?aEx0TWg0TDU2b3FJcFl2SEZ5OGxkN0ZxVUx2dzdmQWlnWUFtM1FyR21US3Fo?=
 =?utf-8?B?dnowRUNneXQyQktEUjByZzhKN3M5WVQwMVNIYmZHTXdTOG8veDBidDNlZEQz?=
 =?utf-8?B?cEtDazYrOGlXKzZvNm5CemhmQ01qanpySWkyREtpbkc5Y1M3czR2Ym9rVktL?=
 =?utf-8?B?bWRtNFZ1SEJ6SlZLNmZNMlZmamRUcTNiM1RTRFpFZUJTRzFpbWRYZzhhWUor?=
 =?utf-8?B?RS9uM3ZsZmw1aWpPc3NNYWczUnhKLzg3Q3V1bVZLblBxckp0Y3M1OGxTcEZ1?=
 =?utf-8?Q?btKI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1269378D9B155F46A9FFF5CBB69875D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b5f031-72cd-4db6-1586-08ddebe77e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 19:16:04.3619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lggp6BgAQnXPgpAMBK0cxvTRIywrqgOQ+P04nK5G62uYv2NaZciX2e8+QhWTgHfzwTByXf2te7BrSNcpsCpRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

T24gOS80LzI1IDI6MTMgUE0sIEZhbmd6aGkgWnVvIHdyb3RlOg0KPiBEaXNhYmxlIGRwY2QgcHJv
YmUgcXVpcmsgdG8gbmF0aXZlIGF1eC4NCj4gDQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9y
Zz4gIyA2LjE2Lnk6IDUyODFjYmUwYjU1YQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
ICMgNi4xNi55OiAwYjRhYTg1ZTg5ODENCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAj
IDYuMTYueTogYjg3ZWQ1MjJiMzY0DQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA2
LjE2LnkNCj4gU2lnbmVkLW9mZi1ieTogRmFuZ3poaSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPg0K
PiBSZXZpZXdlZC1ieTogSW1yZSBEZWFrIDxpbXJlLmRlYWtAaW50ZWwuY29tPg0KDQpDbG9zZXM6
IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzQ1MDANClJl
dmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4N
Cg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9tc3RfdHlwZXMuYyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMNCj4gaW5kZXggMjVlOGJlZmJjYzQ3Li45OWZk
MDY0MzI0YmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jDQo+IEBAIC04MDksNiArODA5
LDcgQEAgdm9pZCBhbWRncHVfZG1faW5pdGlhbGl6ZV9kcF9jb25uZWN0b3Ioc3RydWN0IGFtZGdw
dV9kaXNwbGF5X21hbmFnZXIgKmRtLA0KPiAgIAlkcm1fZHBfYXV4X2luaXQoJmFjb25uZWN0b3It
PmRtX2RwX2F1eC5hdXgpOw0KPiAgIAlkcm1fZHBfY2VjX3JlZ2lzdGVyX2Nvbm5lY3RvcigmYWNv
bm5lY3Rvci0+ZG1fZHBfYXV4LmF1eCwNCj4gICAJCQkJICAgICAgJmFjb25uZWN0b3ItPmJhc2Up
Ow0KPiArCWRybV9kcF9kcGNkX3NldF9wcm9iZSgmYWNvbm5lY3Rvci0+ZG1fZHBfYXV4LmF1eCwg
ZmFsc2UpOw0KPiAgIA0KPiAgIAlpZiAoYWNvbm5lY3Rvci0+YmFzZS5jb25uZWN0b3JfdHlwZSA9
PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KPiAgIAkJcmV0dXJuOw0KDQo=

