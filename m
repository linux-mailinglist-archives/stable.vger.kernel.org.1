Return-Path: <stable+bounces-201079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B428CBF79B
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C91D430019DC
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103D225408;
	Mon, 15 Dec 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="UNgousbB"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5F1EB5FD
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825242; cv=fail; b=rmDhppmz+Nx5+1cZudvSJO+z0HhE7v/2Tc5ZF52nIXOvhqIerw4ZOXOlRXjTqSpYdjVzGgKJw1LMUZzolwOn5PEGBDYr4CdnlLCjoFeVLoVe/DZRYiGhm2ec1C2qegfbNWTzVfgjGa5tHLUi1UYRHv51i4pDL1y9yFDp+i6D1MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825242; c=relaxed/simple;
	bh=y6hpxIjH5k974q44Je/BiQNHX6oG1UeETaxy+bSY98I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=pU/TosGNTqmze0+XBmwRQMU+pdg5Eyz/JfASQ3r7XmFu4vLS8dP/WRV1yc+2/p8xkJiOe0/FLdn7Husq8I1UFJ5/ppu/5rGWL/VjwR4e+jooKrHG6E3B//1xiUtHxNATRn30pQM6U/dukUjrpWVz7sKc35CBgbAv4IZWPd6gFj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=UNgousbB; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXkMpxNE38bfA4+EkSdqzOcXM1N65IIyvHMvMMCyCBsuyNtOloNsPbl1lUF0SmS8wmfHtm/PvAQvvglHB6uL+Gbjw/zMxZKUtMBMsCqByTVwBUCodt6ITUi5PAqdD2TEOi8E9czXEl/T3LYa8rO9ZhMzqkd1hlK7HyH7iHdUG79MZFg/wEmCv7AuH/ig2cwMuyZrDE3yRvjrhpc5aXXcoiVt2TvIzyCBnj8Zu+6wMvTTbmLMdeUOwn1w/6sCtmkfStXdD/L6b810LD6xYMk8+ZQjrp8T+Sm9JcAswXt1iMC7fIqB8nPKlBX6hwUD1BvlKMgSWNzqnYtN6RnlWiK7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n1Y4JB2/rPKGi9/qGywegZWgUg2nzC6EjigTgMo4iE=;
 b=dL/LKLG3wba2LnuAmcB3k9RBIYXWji1lwxM5wYv+E4EdCNAEVoqq9j1mreW977lyFaK7yMS3qY6+0VnHWfnIBNB7IDBbyBEqrxMfWj+txOtRUc308yO6Bgk6r1fVmTuoTH0ChZpp3UA5N0PtlwbIIpzZr7+rgMXWVrYuRf+4l4YfXslpbBcHdkP+P3JArDRI2va/maL86L1Q/BnZK6TdlX5tvPdaL+0Z12aRDlvLXgBK5XRQSzxo4X66hWUQiSfPnPb9v+Anr95T0wQrfY8lNPrXqDr4yoRcsMBYflPCaMrqF0xEbum5Q0l2or1GHlG63rWBvHJhr1/mSWWNuP3c1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n1Y4JB2/rPKGi9/qGywegZWgUg2nzC6EjigTgMo4iE=;
 b=UNgousbB2F8WpB46v93O2v+bDEaNxbKELdfh7EkAy/7FxnOoBtPyWp1oE87WbMhb+MffsWLDKflGj/Xo8zAOSxVKYRnHhYRV4q/7teCNqxj1HRpf24JnefewMUA9FqaZqlsmHh/euc9jmZqLzuc2LKa2QJIzNjmjnvbm185FmSkgARSXAooZ3cmED1MaqjWXHkREdhLA5pgkXnujZunfcU71W6eSSF0rFHH2DXUHkeL3/KDrdz6vy45S4eD3xB1OpXJBK8Gcr4zf6YOXWkrPYQvD6lgzkdzt7k0EH9YehaGp77s9kvg+Q/AS2wOV9LNoEFayVgfo3jFFydgFcyYw5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by DB8P189MB1144.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 19:00:37 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 19:00:37 +0000
Date: Mon, 15 Dec 2025 20:00:35 +0100 (CET)
From: =?ISO-8859-15?Q?David_Nystr=F6m?= <david.nystrom@est.tech>
To: Alyssa Ross <hi@alyssa.is>
cc: =?ISO-8859-15?Q?Philip_M=FCller?= <philm@manjaro.org>, 
    Greg KH <gregkh@linuxfoundation.org>, Laura Nao <laura.nao@collabora.com>, 
    stable@vger.kernel.org, Uday M Bhat <uday.m.bhat@intel.com>
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
In-Reply-To: <yyi32aqbvgmvud6egijxurgpbe6mzax73z6l5od3nzt4lsoxzt@msp7t3hsvobw>
Message-ID: <6dd6eef7-15cb-00a3-c216-d6eaaa5cbf54@est.tech>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org> <20250320112806.332385-1-laura.nao@collabora.com> <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org> <2025040121-strongbox-sculptor-15a1@gregkh> <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
 <2025060532-cadmium-shaking-833e@gregkh> <8dbd9d73-1177-42fc-aa84-78139d957378@manjaro.org> <yyi32aqbvgmvud6egijxurgpbe6mzax73z6l5od3nzt4lsoxzt@msp7t3hsvobw>
Content-Type: multipart/mixed; boundary=832332983817681717658252361689685
X-ClientProxiedBy: LO4P123CA0291.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::8) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|DB8P189MB1144:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b8ffa6-f8ff-4fa4-8ea0-08de3c0c3b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3hKalBQKzR2eFEyd1J5dHZMTWJBbDJrckIxSkVyTTZkbGhYbklKaWQwQitN?=
 =?utf-8?B?UGhIMWVDdnlhN0FYYUVsS1Q2RS9ZTmtzUnQyZ3hpTFBGZ0oyNmNaWHNGYnZU?=
 =?utf-8?B?TVRSdXNReGY3ZEd5VGRyQURjb0pBVy83aitNVGRuRWVValBQL3VHR1QySnZk?=
 =?utf-8?B?NDBzd3VPTnNPYmwvQXp3NGZpeURQb3RyV0F3WjJvWElDUGllTnNQRTdIRmZS?=
 =?utf-8?B?bXJoRHlPY1lKMXJjbC9vcVBXaEtWSkF4dTlKWEF0RDhSNi81RXh0d0JTOEoz?=
 =?utf-8?B?SndBUk5aNFZHUnYyRWZYdytWVDRDTk5nU1pieFJXZGN3dTV3ZkdxcnNvT2d5?=
 =?utf-8?B?ZVI2dDNqNG5CR3g3LzZrdE1ZelQ2NzhENTIzUFFEUndacG5EaXp0WUs0dGdQ?=
 =?utf-8?B?TE1ONythQ0ZBYmVJcDdCVU1WUE1MaEljQXhuY1kxMjdwOVFlNVV1NEIxOGVO?=
 =?utf-8?B?VkhoNXYyOHZUS3Fxc1k0S0Ewc1NtcHJuYzExYWNjdExoQ1RERkk2TkRGalp6?=
 =?utf-8?B?azJFUCtjazZnbHZnZGZMOW1KaXZoQ2trdkJ4eWF5OFRJaVdVSGJKdGFza2NV?=
 =?utf-8?B?aGhvZnlpSnVzOXN1dXd1RElHM01kNVBPU0VUZDE0NXVhQ2RNQU9kclZCbTRH?=
 =?utf-8?B?R1M2aU9vQlp1NXY4NmMyVG1rbWxjNUNzU1NHd3Z6djJabkorQTFVV2NXMFhy?=
 =?utf-8?B?ZTA0U25za2hKNGNXY0Y4T2NjY0hzbHZldHE5NlZnTGNYY0NYNmtHdTlSejc4?=
 =?utf-8?B?M1VIZFd4bDRiTnVvS1QzUlNUbFhDV01TU2JzRG5Nc2JiZW9XNEw1RWlWRGY3?=
 =?utf-8?B?VUY1ZkZLRTd0Q1Q4dkRORFd6Tld5enJCTU0rL3Zja1dCcGN1b2J2WG1UUjNh?=
 =?utf-8?B?dGNVWE9sV2pCV25PL2hNbm0rRVkwVW52aUF1bFo0ejZmNFc4ZVVEb1ozdWll?=
 =?utf-8?B?Q3NhdVRxSm8vencxZisveStXRS9abmZEaTdjbGRhcm43SWpiZFdwcXh5anZX?=
 =?utf-8?B?MFR3TWFCc01saDNqZXdLeWNzZkJSSXpiN0JnMy9VcTQ2QTJWQ2JBNlB2MWJV?=
 =?utf-8?B?cjc0TjIvVmFOamF6WmJxcGxaanVFSWtUaTc1VW0vOXZOL3laTkhrKzdJaVcy?=
 =?utf-8?B?emxKaldlRkQyU3NLeDRTR2FqZDdBVkdzRlpUemxVeC91SWR6cXdNL3RnNEVx?=
 =?utf-8?B?aWJ3TWZqd05ld01kQzB2Q0tzOVZaZEEzWjMyaVZ1MjR5TUt5MENnTWJybTRR?=
 =?utf-8?B?b3VCSmNrN3ZaZnFTQlg0SldwWTZUUm11YVRLY3ZSOGtya2dzZE0vZHBjTUE4?=
 =?utf-8?B?dVdRdnN5bUZDbmkrU0lraHhHTEhocWRoTEl1bS9wNUxtY01lQ3JtRHlBQXFB?=
 =?utf-8?B?ZkRseUpiNFdGMFJRVld0UkVEcWwrcjhoSjNnbHFjTTFWNExpck55cUZyWjUw?=
 =?utf-8?B?dHRQRE9GZDd5K2EyTis5ajdobThkU1ZYRjhIOU41Q25NWTlFUmwyYlJ6V0F1?=
 =?utf-8?B?ZUJIcmcyajhDekFWT3dqVHNKLzFkeFVvbFJDVDBhajVIc21YYkg2TGsvTEJw?=
 =?utf-8?B?dTlFUHFXb1Iremo1Q0htMXBqK1l5SWdrVUplSWJ5ZEVheVJHUDMxalRXUXJI?=
 =?utf-8?B?TUh2OWQzSkE4dHhDZFBpRkRSdzUvNTNTc2tUUzg1U2VsYlMxeGhabVprcnVO?=
 =?utf-8?B?Smc2UlF6SDViNkhCdDB3eldndGtqdkdhUC9naTM3NVU4Vm51UWV5SjJKUGVC?=
 =?utf-8?B?TTl0VTZGQzJJcEpNSktFWnJualdVRWp1NStpTjB0b3ZNTEdKQ2dlcTFEMWFr?=
 =?utf-8?B?TTRjajdQenhBVjBsQkhXMDI5RTlmRUl5ZU1OM0tFSDJ2ekhWaUpnR1BXcXR1?=
 =?utf-8?B?UGQwa2dvSWZjenl0N2piWUtGdk10WVRoNlpWK0lJd05pTlVobGphSitHWk1N?=
 =?utf-8?Q?P5XTgMRXYFv+2XWbUcEdoaeU9jaAdvIa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhHNzNPMWt2LzlkUG1VeGVacWNlREpaN2QrV3p5eks3YmtLS3c0Q1Y3ZHBW?=
 =?utf-8?B?aUxtUUVsbmZsYmYzZG1zK1Jpck1qVmthY045U0Fyd0JmTDZxNzBzOEw2UElX?=
 =?utf-8?B?MFY3aGZCS20vajhuR2p6VUtVajNPL1V1S1Q2a3Z0MnQ5ZWt0azdPOXk1Q0Vp?=
 =?utf-8?B?ZmoySEwzbG1wRnVQT055SDFwS1RqdWlBSk1PZ2FpUkJBRnRUUnVkMkhmb0hz?=
 =?utf-8?B?eFBrZG41VGlzMDB4bWpmUFJIN2p2d2VSNm4weTYvTzN4enFRdGZrVkY5Tnox?=
 =?utf-8?B?RCt2a01YTTliNDQydy90ellnVCt6ZWpXNU04Ums1R1ZOYnBieXV4RDdqdWRu?=
 =?utf-8?B?WUVmSDJZcUFqMDlCUmRSM3d0YS96Q0JNbVdkTUJDaXJSTTl3YWtMV0I0NXJJ?=
 =?utf-8?B?eGpCZmdRUXZBOU9QbkoxakhIM0FnamY3cHlvckFxd1pkRFk5SXMwcmFPMFNn?=
 =?utf-8?B?YVJMZSt6U0hBSi9oUmZmU1BNQUxlL25XSitHQ0dtWGZ4TXJ5UmNXT0RzZEgx?=
 =?utf-8?B?aVhxYmxLYmNjTXJSSW12Um1zQ3hBdEE0V001VmV4WXMyUXV3TVI0UkR6ak1p?=
 =?utf-8?B?b2Z4NmIxWVpESzdlaWZRdng0WVd4S1FvUmpEa2RxVU82dTRJRW0rVDFSWWNR?=
 =?utf-8?B?bkI3WWRxeVpzK0JyNm9KVWp1cGtRSnRoenhFMDlmZzl0eGhuZDJWU3JqUyt5?=
 =?utf-8?B?SGNrREJBaTdYWGhiaVZXZGJzNFpDR0dkSHJXL1JGblVGN1pVMEJMamJvcy9y?=
 =?utf-8?B?cUdRTW5mWVNsU0VJTDRZaTdmd3FOeC9tZ29jNmdXTThmWEtKVlFRa1llL1lh?=
 =?utf-8?B?d3VGS3l3Wk1WUTdPOXFER1ErVnpUMWg1cXkrcEtYeHBDMDVWcndYa0s4V25V?=
 =?utf-8?B?d0JuL2Zod2NRa01DOVArUU04ZXo2eE9xYjhLVExDejQ0S1c5cmIxWGoyU3BG?=
 =?utf-8?B?c0UvZW1KdnBMSm5uMHlkc0cyUG9FMnA4Z1JRazNGeG5YRXRIeTBXNXhxRklx?=
 =?utf-8?B?ZUN5N3Q4VVpQaG9mN0wxMVBLVi84RDlOblBLeVJOcHVLb016ODBIYldIMjRQ?=
 =?utf-8?B?MVlGWlN1Q2lxMWpZTW1lRU5yaFczSCtSUjhVQWtrNUxmcFNhclljcjY1SlFi?=
 =?utf-8?B?TlBNcmFRWitiT3NsWGRJZEhjWmlEeS80Q09MdVBkNDZXN2dGUC9TTGk4cENL?=
 =?utf-8?B?U1FEdzBlUW4yWWJXRGRZc2JlbC9YSDZUTzRReGZDajd1c05hdU9iY0xORVk2?=
 =?utf-8?B?dGdlbzB4SzQvaXR6SVJlRTdGQy9SVzk1elRpdit0aTloVU43cHliWkUyblk3?=
 =?utf-8?B?TnpNOXZ3N2ZKWEdZTGczVzNjaGdScS8vVnF1NVRTaGFzdE5IVGNCNkhRSGZF?=
 =?utf-8?B?bElhUElDU0RNdXpDTFo3TlI0ZncrU1ZXYmRsM0ZDVHlkSEFReEwyQmJTcnhl?=
 =?utf-8?B?Q3FzdFhNL2dPMUdBeHUzSmNkSnpCWVBheEdnV0lHNGVhSzJTWGVvQWZ5a2h2?=
 =?utf-8?B?T0xhSHVhdlRqVHNxVTkvM3pjdy9Gdys4d0Y2VDZsZERDRUk2UlN4TWhTUmQ1?=
 =?utf-8?B?d1MwSXJKMlhLRDZmOUM1TzZoWEVFK0FEUlAvOUFzWkJKRlZGeTJPbHFDcXFy?=
 =?utf-8?B?U1E0R3luYTZUajhONW1EdllTak5Wb29qVnBTc3d5NW02NTIyKzRkaGhoZko1?=
 =?utf-8?B?NnlNVWJRTHhhQU50NU9zVHJkSUs5dU42RFUrZHVqVFRpd0NaUnpqMlhBVzNz?=
 =?utf-8?B?dkdrRjZWZXhmZkxMR0VtVHRXZnlObnIycUl4L083U2RmZC83WjZ2THJRWXpm?=
 =?utf-8?B?Mmx0cDVKb00rb0tXREZtcTBPRUVxVThsU2llU3RWQmZ6RUZ3QmNBTlVuUmFB?=
 =?utf-8?B?cHZneWVUMHZIeUo4dHRvcnp0RDhJNk1OeE5HVk5xVUFzRUFUUTZTdTJ4LzJR?=
 =?utf-8?B?dUc1ckVSdi8wckd6T0kwNUtvQWJBQTZ3d1p1M0liZ0VjdXBEZ1VCNWpITFFK?=
 =?utf-8?B?cnU5NGpwNXByUDJ4K0JjTkR0Q2d3TUpGem9KczUxdEdVQ0lZTGYyclZGckMz?=
 =?utf-8?B?S1M3czJlbmgyUHR3c0pLZkZyekRLNmFEWUljd1hLZnc1YVozeU9FcTFGTmtW?=
 =?utf-8?B?cHFpcVltWVlhZHRBclQxaS9JM1dUZzY2ZUxlR2FtRGI5UjlvSGJZVnBQd0RZ?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b8ffa6-f8ff-4fa4-8ea0-08de3c0c3b90
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 19:00:37.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftMUbUvP3TliejSyueP1SSKzM+BqSEeyiHZ8T+3b5rRrqHD83GfyPiTiWyDBbbbOLH+Wanc9gWeqizWVdbvwZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1144

--832332983817681717658252361689685
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Sun, 26 Oct 2025, Alyssa Ross wrote:

> On Tue, Jun 24, 2025 at 09:05:31AM +0200, Philip Müller wrote:
>> On 6/5/25 10:46, Greg KH wrote:
>>> I have no context here, sorry...
>>
>> Seems with 5.10.239-rc1 it compiles again just fine ...
>
> We've been seeing this issue[1] since 5.10.244 (specifically commit
> b039655d31a1 ("genirq: Provide new interfaces for affinity hints")),
> and still in 5.10.245.
>
> Given that this has apparently come up before, and I don't see any
> likely cause looking at that diff, I suppose it's probably some build
> issue in 5.10 that can be triggered by innocent diffs, and so is liable
> to keep fixing and breaking itself until somebody figure out the root
> cause…
>
> [1]: https://github.com/NixOS/nixpkgs/pull/448034#issuecomment-3364278085
>

I have analyzed the issue, and it seems like never versions of GCC will 
agressively inline both in compile and linktime.
I'm not sure if this is fixed properly in master, I would assume its fixed 
by adding enough code into BTF exposed functions so that they not
optimized away anymore.

I can "fix" this locally via:
CONFIG_DEBUG_INFO_BTF=n

or

diff --git a/fs/Makefile b/fs/Makefile
index c660ce28f149..6fbaccbae1d9 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -6,6 +6,10 @@
  # Rewritten to use lists instead of if-statements.
  #

+# Prevent agressive link-time inlining of BTF symbols
+# Prevent GCC 15 IPA from removing filp_close symbol needed for BTF
+CFLAGS_open.o = -fno-inline -fno-ipa-sra
+

or by removing line below.

linux-stable$ git grep filp_close kernel/trace
kernel/trace/bpf_trace.c:BTF_ID(func, filp_close)

Last seems like the simplest option, but would cause regressions for BPF
programs I presume.
GCC 15+ does not seem to adhere to __noinline, at least not for this 
issue.
--832332983817681717658252361689685--

