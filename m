Return-Path: <stable+bounces-120193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B2A4CFAA
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 01:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE343A8347
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA81C683;
	Tue,  4 Mar 2025 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sRBwFGrf"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D4BE5E
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046760; cv=fail; b=n/AnPHW9163hCTzuM3dIkWyMC3sMO+8UCawZbKiIJ9b5MrCc2aVUpNSMx7DhgcxxJoKoARy14nttZyJnC+D+Ei9v3ui9K7nLZDSXRNvErBV/1+tTOId2jjk6n+EvMtBmRe5E0ff2tAQACxLgefkckNLh9o0Cbyruoyxejo28gOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046760; c=relaxed/simple;
	bh=AhDpt/gbUHxDqS0kr21v9tf67t67Myk0Pyb76T1bYfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzGTbYI4saq7aeTb2WNLET/Qa40f9MT1kdxSX7uQyVinKcbw2gD0FjPPY19+uorBLdgZ5yWVAvjJgSit8mcs4qqfGUzxnXsid+ayL7BnakYWPQ6NR7Cgl8qRNmqOQf1vn1ZfRHSFRM3Ek88+1UTjESuX5CS9xqqGZB2lgfCP/oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sRBwFGrf; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjVRqTcBiGj3i8aISXIU9UgpLKLAOMkOHflfRDrlyybXggrYBqsJjdtYrCnXlKOk4yK2kf10c3n0PgxyBUwBqKW3G1dZKdoCzvBdBvJOm/H0biybW/+uz2nlcVsdJJJ0cMif0ukS+w9jK79ZzobmB31IAMJkTOBlrUcF2Sj39Ss64bKJjtDymym+F53ZsX3BUjBV978m8oWQ3nFKuB2yf5M3QtC1rwIaWvYu+a/NsZZX67VPPB9dzsIWhu1Wsws+AJdm4l0zZ+I2N5wfMYcvlYf2dZGzwRMncCoHyq2Sj8zzIzLREqtNgrzPi898PmIvOLu4hy9KGt2UJv5zk9Z69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHZNPLsTcmf8Jd/WWkaI9jf8sEwDXn4SIfT4rmn/nbg=;
 b=uvAw/6AzAUsZNQNrL49jpCdIUVtF0d55Yn0MRpPse64iOSWvA8w+gpLX+LWJtJYFbl0RBG/5WwqK/YGOoSpVwpbLC4cGUCy+IbED++SjaijXYXuY5W6JChghiEgh9LqSuAfVr9ySuexLxwQFzaHlF4nhw2WoaAigUynIaT26YAQcL+qvqr3iFYubMirAtj5vEzfNfnncfSjvAnibas/6wRcC/TPVxhsTrnCAB02j4yOyei12/RN2yH24WutrPvmaX+kQmwFmljxYgeOOd0LO6KtyhjuhKlMeA6nWCULl9iT7R6cTF2JtFeNVKnm2vFNmfhv42w/uLZHBJPiAB7k4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHZNPLsTcmf8Jd/WWkaI9jf8sEwDXn4SIfT4rmn/nbg=;
 b=sRBwFGrfgLrKByNOsZjpECmmOJEM9VQYUCiXrRT/Yy6KeEfVZfBKinTWrT4+yTjuwmKJG1CR1rhNcUd0RHveWMTIKTfV4+pvC6xI2kJoAh4aXhKuUG3Is+DlBpny8iMjXay0OsGEzcLcA4vI24k3j8h3CgaM9HDHRPi30/7D7PHOSbLVQs/wUpDmS4azfM3Qi260Sdc16mKOZNJ8gGhP1SA58/Wh15FTkEOK1nVf+txBIHoLdN2NkXzGs9V+9gAjY7pt86I51xTlrSMF+8n1LquYqRg2B/NYDjARhGUA2ocRKdhjRVpxuaM6PhmLmbNEnTDOmivj/XYjbYXei/f60w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by VI2PR04MB10954.eurprd04.prod.outlook.com (2603:10a6:800:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 00:05:56 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 00:05:56 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: andrei.botila@nxp.com
Cc: Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata
Date: Tue,  4 Mar 2025 02:05:32 +0200
Message-ID: <20250304000535.4091619-3-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304000535.4091619-1-andrei.botila@oss.nxp.com>
References: <20250304000535.4091619-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|VI2PR04MB10954:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f58f933-a392-4a9d-bcfb-08dd5ab0563f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmN2R0FEOVlEZmg1ajNzRndzeUEybnk3SjRkS3R5S3lpQ2NkM0tCTG94aDdH?=
 =?utf-8?B?T0lOcTd4OTF3QTNQWnpHOSt6dHhaZXozblE1SDFoTWtxWWQ3NFFuK29US1Zw?=
 =?utf-8?B?TGJqZmh0OTU0TWN4VmRjak9QRmliRW9MU2VidGQ5UFBIT3cyZGkwbzN5b0dp?=
 =?utf-8?B?QzRwNnBCZ1FLYSt1anprWlpSZWw2cTNvSzZnakhOcDY3MFNBSUZDRmlmd2FW?=
 =?utf-8?B?TVNRK2dvTGJqWjJSNkh6RVdsUTcxWHJsbzR0L0JsQVZkVXNEN0pFaEZLR1ph?=
 =?utf-8?B?d1JOMUNwQzAzZE96bVZnWVBSRzhGWnE0WTlmc2VJa2pOdEkxWjJtLy8ycjhn?=
 =?utf-8?B?UUlLTnlPN1AzdnRrcEJVNUVteE1uUVRLUUo2Q1VUTEhXZ1hGWmNQUXQvdm5G?=
 =?utf-8?B?d1h5clczNTRRY3hGYWNwbTV5M3YyblRDOHp0V3JLcDlmK0FLTTR6RGtmYWdv?=
 =?utf-8?B?aHBPTW4xNWo3aWJ5b3UrQVBZS0xLWnlGTGtYYjIrSVhBSE9VNVk3Rm9ZVXhQ?=
 =?utf-8?B?ZDI0SXlmd01oNnVnSE9md3Q1Z3F5akJJU3crVzVTS2Y1MHNXUS8rcC9zZTNI?=
 =?utf-8?B?Zmc4Q1p4Ylh5RWhUeUk0cGRJWi9CWnZIOTJFb3JvekIvTHduWllwaXVNU0pt?=
 =?utf-8?B?YVFWQW9XaXJIdWRhQkNMM1l2TkxGVXFHVWtpTzR6L3prOFFaZ0plQ29lZUpZ?=
 =?utf-8?B?clhFS0xVcUNILzl0SDhmLzM0MXNpdkcwTm41VkNLdU1FV29NZkR6ZWcrNi9t?=
 =?utf-8?B?dk9FaTlLNFRJYS9YOXQ3cnVHa1VOUUtzVjBUQ1ZEb2lsaVg1enJkS1RuQU95?=
 =?utf-8?B?TlpjL2V6bmV1cUd1SHJrRE5iT2g0eE5zRnFoOS9Mb3plS1BKNTVrNVlxcnhx?=
 =?utf-8?B?S3lzb1Jvak5xc016TUp4Z0FxT0g3Vk42OXNKOEtYS3RhTWMwc3V4dytLZElK?=
 =?utf-8?B?ckllU1dFUFp3ampsZGt1L3hNR3Y1dlNMZXJGY2NtNUNqTTd2ZWFMSTMvR0pR?=
 =?utf-8?B?K1ZHU3BFbEpjamVrZ1drS0VjSy9uOGkwZVltMFBScGNUbnllVzBKNEQ3ZmhD?=
 =?utf-8?B?REtYQ0JFdWtFc25NQlpxbzF1cmJQZFJCTlhySVVnWjA0WHNTbzBFU0lMOGp2?=
 =?utf-8?B?ZW15NWN5VmZXQXNXUkl4SDdPcHB1aWxqMCt1ZnJpZWRnNi9yQkpQT2FDN3pM?=
 =?utf-8?B?Uzg5WEVvYmVKRDNmdkl1dG5QN2s0bll0OGZEK0ZkbnhvUUVtbzZ0OXBjRXBY?=
 =?utf-8?B?dkltb3ZxTDFmTXpoT1RMeFRjcXF6aWpJWnhrMmVON3MyMFpkSldtRGxhaEUx?=
 =?utf-8?B?aDZIOWhGT3IvbDdyNUloeHNYaVVrY3gycTR1UEE4N1hPeWQvWHV2aUN6YzNy?=
 =?utf-8?B?MTd3VHlsdHB4elcrOVRGQzB6T1NsQllWQ3J1d3RpNGVObkFzUmVYY1ZsUFZT?=
 =?utf-8?B?M3Z5QUF5K2drZ2ZEYmZpcWdDMmFqQ0xzOWxVT2UrczlRQXFVT1RwQUMySno2?=
 =?utf-8?B?c0s1UHN6b0F5T3YzS3BtRGNCVEZ1clBna0IweHBqK3piOXErdlFJaGxiMmVB?=
 =?utf-8?B?N2xRRzkyZEpsZUVnUjFZeGpWQVljbW54N3FNOXJtVkVxU0hxMFV0Z1IxYTk0?=
 =?utf-8?B?bXo5MzU0QUV6MUhZNFV4U2dqSGRxakYzMTZ2OW9JNjR1Uzgzb0h3L1N6OWlB?=
 =?utf-8?B?QmZSamhyK0gxbXd4Sjk0bTlXWVdFNUZab25vNjhJMUxvaXMyL0ptT1o0dnJG?=
 =?utf-8?B?VG1ad2tZaEFSZmVmb2U5OVZQV2U0cjRYemNvUkxQamxIQXNjMDBpTmlyemhu?=
 =?utf-8?B?bDVJcDFpZ241RTJDZUpFYlVSTWp0RGlmcTBzblI4Q0xFZExGNElmbEZkc05Q?=
 =?utf-8?Q?ZUMYKgewGhhK+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUhlUk5zampiTHBQMjdCVElGRTFzaVJsK3F1aTFqYXZaQ0pMR0FlNk42V01Y?=
 =?utf-8?B?am1QcnRTYmU3RHNWRHJXMkpiR1RVK2xMejNHZUNwYlRJeTV1RE03V2JLUi8v?=
 =?utf-8?B?UUw2MUJGKzBhVHdCR29lLzNxcHJjQ0Jzak9KenorTnFvSFZFbUw0aWZ5RGhB?=
 =?utf-8?B?YWM4eE9ocDRBZUpleWdsdGVRM0QreVpJSGdRdW5md2FOdEh2S1owMXlmclM2?=
 =?utf-8?B?Y0JHVGtoVGgwTFZpR1psTzRDdW91bkY1TTBFZEphUURHSmp2S0QxZXFteWQ1?=
 =?utf-8?B?Sm5TQ1l4SDFNbHlRQys4cksrUWpUQk5adE9oMXdXYTFsSVNPcnYrSlo5NGJJ?=
 =?utf-8?B?cW5TMzJXT1dpVXZLY0ltbG1ocCtjcmNmTWJnTWVuYkk5MmxUeVF0Sk0vZ2lw?=
 =?utf-8?B?amFNaElnSWhxV05RNmd4ZGJmNVErUDR2b1IwN3dPbnhtSU1vS3NrNDI1VWNV?=
 =?utf-8?B?UE4zUmVyaHdZd3d4RWtycjNBY1hqVmllVnhaNUlUaFVJcmdvTXRKNWhJRndV?=
 =?utf-8?B?OGVEOE13S1RZWU5NTFVobHpONVQ0MlUwcFZ6SmUvbHpmQ1VBYkZHTXRTeTNV?=
 =?utf-8?B?WW9EWE5zWStKZG8xS2RaOFdDOWVaUE5hTkQyZjk0K0ZscjFEZ25BQjl2dlp2?=
 =?utf-8?B?YzRLRSt1NTVGNmJzWDFDV1Y4LzRLQjFDaG15KzNIK1RXOGZBV3lueHozOVNJ?=
 =?utf-8?B?a2dlUkF6cFdmZG9TcElHTDBkcmRLUTNTRWFvMXZneVVxdFZQZ016RVBncmYv?=
 =?utf-8?B?WGRjaVRiS1hQOC84ZmVZQzZSeE5XMTZkVnNZWUVkUGNNdjRkV1hFaXJIWDNN?=
 =?utf-8?B?VzhIM3lvZWhMa1hLVkhDRjIrRi90NDk0azl2QS9vczVLYzFIOVFNMU9NeXRJ?=
 =?utf-8?B?OTV0SVkzd2pjWVFsMFFkb3RGV2hDaW9hQ0hROHJJdHZla1BBSTd5RDBlc01j?=
 =?utf-8?B?bWdhN3lkbjQ0R0RCcTR2enNWZW5qYm9ZT0VTQmUxdDY5UzJ0VGF0Z2F4RE9J?=
 =?utf-8?B?b2RVVU9NUmhEcldDeTVaZVBLSmEzM3puaWFSZHdIblJXUC85S3FEMTJaayt5?=
 =?utf-8?B?U1MyRGpIelBTUDFTSEFFYjRQa29JQXZmZDZUWXlIV0ViRWRHNEdaL2RzdHFM?=
 =?utf-8?B?bUcrSFAxeS9RV3BZcjhuSGNVV0dTMGZCSEszbnh6bmVpdVU2ZCtYUVhGbnFK?=
 =?utf-8?B?dTRYQkR0bkJZY0FaMnlsZEU0Ynd2cmtvbGJud1FVQ21lOUlEdHc5dGxOdnk1?=
 =?utf-8?B?Z3RZUEJWQkVaVWdLSXAwVUkyaCt5azhjM2xLZnRCbXdDSktLZ1Q5aktrbjVL?=
 =?utf-8?B?TElZRGVYZUozUzBVY2FLZzlGa2lsWXVHa21ucGNibWplRjRzTk5uWXUyL2wv?=
 =?utf-8?B?WlhJWVRPNzVCcyt1MGZsTy85N2hJWk1YK0tuZENyOXl6am5NaEMzZGVIMEtR?=
 =?utf-8?B?ajVxMDMxYXJQL2NBVVhYSVNSNEZrQ2tiUlcyODdMd2tuSUQ5UUNwWmlIaFo0?=
 =?utf-8?B?VUtwTVpJWlhrb2R5Y1h0cTY4QisyYnYrdTA2bTFkOVpwMzMrcTZWeXdLNklS?=
 =?utf-8?B?ay9mdjJpNGJXMllPV3I4Mm5qREY3SitBL01na3dDT0ZoUitCdTFkVXF5YmQw?=
 =?utf-8?B?TjI3MmpxMUtOTWtwU0ZIenFxdTJtRnM1SFYzUmRnODg1L2Y0a05tRmtqeHZq?=
 =?utf-8?B?cXJtMW5iWnV2V213Sk10SEFWaGNha05yZCtsbURvN0FPS1RRR3RBVFFONVZu?=
 =?utf-8?B?SEN3UHYyLzZJbW5GQ1E3TzNvWWtsRk9saWhLK1l0eWFnNWxKOGFpeS9QTEFV?=
 =?utf-8?B?QXN6RXJ3R3pUeThHOWpnNllaVkxabXhCcy9KRXNiRWIySUpVdjVKdG4weXFS?=
 =?utf-8?B?STMwTG5ZRFVQelg4WXJKU1VubXR2VkZpbU94T210MGZjYUZoV0l3U21WdG83?=
 =?utf-8?B?WW5kY1VFZGI1S21NSWtkbFNMTmY5a0VJVU5EeUc1WGlMRSs5aVVKY1N0Wmhk?=
 =?utf-8?B?S1NSQVQrNEZnZHc5OGsrZHBBNG1MQnV1NWJrOG1RVGp5bS9PT1hMNUkvMlpo?=
 =?utf-8?B?clQzbXdwRGJTNU5xTWdYaGw1YUJBcUVwU214dXdRZjV6UmtJMzNXQnpCVjc0?=
 =?utf-8?Q?D8kZSbqwSKj7b8h7LxcKm1+tT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f58f933-a392-4a9d-bcfb-08dd5ab0563f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 00:05:56.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //IeuKyzy2LNho0+lDIc16yBEx8WvTCJZSQLdE/pYWMcfZEBfzutONN9VWdvqPaiswtj/L5L1iHZKpSiukES1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10954

TJA1120B/TJA1121B can achieve a stable operation of SGMII after
a startup event by putting the SGMII PCS into power down mode and
restart afterwards.

It is necessary to put the SGMII PCS into power down mode and back up.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index e083b1a714fd..d142e0a02327 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -114,6 +114,9 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SGMII_BASIC_CONTROL	0xB000
+#define SGMII_LPM			BIT(11)
+
 #define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
 #define EXTENDED_CNT_EN			BIT(15)
 #define VEND1_MONITOR_STATUS		0xAC80
@@ -1598,11 +1601,11 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
-/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 & 3.2 */
 static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 {
+	bool macsec_ability, sgmii_ability;
 	int silicon_version, sample_type;
-	bool macsec_ability;
 	int phy_abilities;
 	int ret = 0;
 
@@ -1619,6 +1622,7 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
 				     VEND1_PORT_ABILITIES);
 	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	sgmii_ability = !!(phy_abilities & SGMII_ABILITY);
 	if ((!macsec_ability && silicon_version == 2) ||
 	    (macsec_ability && silicon_version == 1)) {
 		/* TJA1120/TJA1121 PHY configuration errata workaround.
@@ -1639,6 +1643,18 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+
+		if (sgmii_ability) {
+			/* TJA1120B/TJA1121B SGMII PCS restart errata workaround.
+			 * Put SGMII PCS into power down mode and back up.
+			 */
+			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 VEND1_SGMII_BASIC_CONTROL,
+					 SGMII_LPM);
+			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					   VEND1_SGMII_BASIC_CONTROL,
+					   SGMII_LPM);
+		}
 	}
 }
 
-- 
2.48.1


