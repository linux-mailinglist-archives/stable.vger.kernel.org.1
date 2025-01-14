Return-Path: <stable+bounces-108602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325EA1097B
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F387A1788
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E751482E3;
	Tue, 14 Jan 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lKSC7UVI"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF241487ED;
	Tue, 14 Jan 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865226; cv=fail; b=IfOkixJhZ7ER1bcljSUp8H4mHvggFli4CECQV02SaES89PzykIZxI2Q+miG5yQXDSawZWx2FBusEtVGDTIqNhqceHJZ5MzMo9M2NsRC94z0zxiIaWH8TRF7AxU7cD3kUs1t32Xs3kO526cUP9R2M/JJa3TbkkiCuWZbce6dAifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865226; c=relaxed/simple;
	bh=QuOIxXGkgc7ge6VoKAjlcF7xx2Otsg8iZPR0kDmDtNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ugkrj6NLo2yT5wmQKmSPr0qiXYRy089Ze/CJAxz0uFHp4Jv1/00ZGYcUBjrKD4wWPms5TdH213pD5VgwlL56DW2yeHuTad/4zHnm8pu8yHcuUNfEnb4a07mEaFHtlbZT9N2HPxDW4v9MxqGUpc3KwFczISYtChZpYHP6sf5yy9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lKSC7UVI; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLOtQgEg+SDa2NrJzoVGFGXgPHlRlvSNWSdcJixHeb2h+PLKvgFEXbJsEbKj6Ex58UbC2J6ThBcsL91VAM/vMFA7gbO2jEeL7IZgEe1lXKrYlin1jLwAqrFrr6KX2kH1hdlVagYaatUvNY7Bj9b6ChnK/s5JDp6JIR2LWZCnhdm1zDINyy+FqO3GuQLU5nLkws67L8MLBmM3sE7uVMWxlBIVUlG/ab88u81v8AR+QHCI7F8WS75H79Amk3Iunmz2ktpATIWdCi6tmwBPnyWAXlFbEj+6zx+2IqEXoEwoqKo87vGzQ3gllrmRRSrzFCCHu6pGuN4iqcYioWoaWE2sFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L1/xbL8Y0VxBxHOQ3BrRPfkuQolm+W9p6cH7Aqknn8=;
 b=DYYks3aQXpe3RsYtuGAv2FH3wm0M0szQwTaAcKSRYJRlZtljTG5peG+ki2XUDR18CUauWj5M/ng4aUpebJ+8Jmd2hiSi2CzY+3NW4xT+HZqCoYzvTLVDQAWYukJnQrBzyNinMz6NSNaiCLtJUzBiaKfWul8WzSy95Mu5RtPN5F+CMfuOTgHb5UZMyr6kVy05xJ/pvG7404KSgNKRDh0MXNDusKlFhitIR6M1dB9kbA91VGOQhLCp/ifTZI00M6OO25k8aVmjy7RyHQe+qPdwHlLFaxbcUOKX3RWKAQcsHw56nfaEyVQ7+thQMyAS1zuGX5DKhqagRWXlNkGrrcyWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L1/xbL8Y0VxBxHOQ3BrRPfkuQolm+W9p6cH7Aqknn8=;
 b=lKSC7UVIeBgbOjGqyONpZUMwWMFJajN5P72SHIcKEmkG0QvwS4S8IAMSCljnaBzrSRFurm4dUKdvZeCJ7kLCdgzD7Hn6YFgUR63o+QUB89344Qykztcuxufu42x4BEw9lvum9RKJchHUmSwJadux2K7z2NDze3vrP8/tmZ7q06c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:33:42 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 14:33:42 +0000
Message-ID: <9981e3f5-1414-dd82-c6ad-379289575b07@amd.com>
Date: Tue, 14 Jan 2025 08:33:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Andrea Parri <parri.andrea@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Huang <kai.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Russell King <linux@armlinux.org.uk>,
 Samuel Holland <samuel.holland@sifive.com>,
 Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org,
 Ashish Kalra <ashish.kalra@amd.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
 <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
 <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>
 <vuj7mlvkvazuz5noupusqt2bk42vjkr5lkgivnrub2nby4ma6y@7ezpclbirwcs>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <vuj7mlvkvazuz5noupusqt2bk42vjkr5lkgivnrub2nby4ma6y@7ezpclbirwcs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:806:20::35) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: c3defa5d-2478-4016-8659-08dd34a87190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEhVYWlYK0tjbFNWWkZFYXZtNTAwa2RkR3FMbmNVL0VDTHJrS0xNME9qclAy?=
 =?utf-8?B?UTh4eGs3eDBkczdLU2l6bThuK0tQMXdxL0RmNHFBUFlVTmJLcnREdWhVQ0l5?=
 =?utf-8?B?Wi9kUlZzQmZkTVNDTkp3RVBIcFJtYndZWVZtZ2FkaUdVOVNxeS9HbE5pZ2pr?=
 =?utf-8?B?TGVGc1RMTjVBb01LNFd0T0h4OWtacytJZXN2RWZjdEZwbHNvNTNPV3BKdkNP?=
 =?utf-8?B?RG1sNGpBMjBNNU1JWGFFQmNWMWFDYTZLUEV3Y2ZWbXRBVU5VTTY4K3ZTVHI2?=
 =?utf-8?B?NnJIL3UvOFFBR3gxSmFmTXFaUlBPWlliTG85NUtXMDN5RlpXRHdkamw2dm5x?=
 =?utf-8?B?VVRBdk9jbk45SGs2Q1dWRjVGLzlNOEFpcEZaWHBDQlNSTnVNN0tpblhaOC9M?=
 =?utf-8?B?ZW0zY2pzRGFVbGhxd0d3ZWRoc2FSQWI1QkZCYlF6WXVGREtvYlh6L001UDJp?=
 =?utf-8?B?RHgrdlBzc1IwT2lwNUN1dEZEVHY2YlppaWl0QmNUSVZvVjl4MGNEdXNsekJz?=
 =?utf-8?B?Y2c4ejA5TWhMakdiTW5aanFmM2ZmT1g5UmJUT1YvK1UxbXBkb2hhQ1lRQlNO?=
 =?utf-8?B?azlQMzF6ZFBHUmd4MHFMS3h5ZkVzQU1vcko3Uk56djZIeGxqdkZXbnEvd28z?=
 =?utf-8?B?VytMK29aTFkvMnc3VEhSQ2JmUzdxeCt1aGFmbEZXSENXYXY0dGhMejFRN2FN?=
 =?utf-8?B?WTA3OUFxT3dvM1YyZEFDQnZpWlpLSDdOaVRKTi9VMDlWY09SMXIvb3FrQkxl?=
 =?utf-8?B?TXRsRzdTVkFYS2FOSndzQ2xVN1QzeVNqTWFJQ25UWmNjUmlEcU8zV2ZyVHlp?=
 =?utf-8?B?UXYxYWYwZ3NUZXJQbWVOb1pXYjZNT0lEOGZBWmxURkx2aERuSGkwVWMrTnFa?=
 =?utf-8?B?UU00YnZITDRJMlhlenliSkpoWEd0Y1FrWXdSaHFLMlJOdVFWR0Z0NnJGb3pl?=
 =?utf-8?B?STZzNjZpVmd4bGVORW1aYnhOTUU1VWZFeFNod2xMVVM0VmhyRVg4RTc5RnpH?=
 =?utf-8?B?aXZjbE5KS2VvYWtMRTRZZTlwZjRuSGlEeGtDTHM1ajNGQldqaTUxdkNXTGcv?=
 =?utf-8?B?NzdVMmZJQkR0MjFMeWJOR2NUQ3ZDWk1QZEdFVHpZTUlwZERGWXBGeHV4cDRk?=
 =?utf-8?B?TnU1TDdZcE5OTnFtcmtYdlZmZFF3UnFYWDBHdU9ZQTJ6R2JjbmVZOEtJM1k0?=
 =?utf-8?B?eHRlS1FmRFdPaitpTnVwMTJUU2w5M3F5OEtTQWI3Z2U2dTZuQmlJRUdYRmlV?=
 =?utf-8?B?c1dKYzQ3eGhpamJYUE81cEovQzIyRDZTMS9EWFdmdjVnUmszaE1TeU5QcEZR?=
 =?utf-8?B?djAyQ0xzTWp2ek11bEQwb2YyS2RMR0ZHVDFWRXlDTEYyeGlxYkFCWnVCTjdh?=
 =?utf-8?B?WXdDN0JLbVlWbVhlMjZhVFExR1RpZnQ3ZS9EUm9tN0xQV05oT2ZScXhIZysy?=
 =?utf-8?B?dnpHRHVDcDk4RGprd1I0MU41ZlZhcTJaSGFHbTZ4K0ZZQitMYnkzMTR0ekMx?=
 =?utf-8?B?TGZtVHpjai9senNWdFhCYmJUOE5RMXJYTElqOHpIejd3VEpGeUNUWnBzVlpk?=
 =?utf-8?B?cjR5blVDb3hGSitqL2pLeFdiOXgyaXdPSFo4VTAzSzhONzAwT1p2ZXZUaTc2?=
 =?utf-8?B?TGx6TzRZaU5OOGgycExVZDFsanVQTWNxTTRrS0hkT1dPRlRCbFVmMERlRkw5?=
 =?utf-8?B?dHlrZTUzWmpsVElBdVdDRDFZMW1qc3czUjBTb3NjcW1JcExMSmd3U2lwL1RQ?=
 =?utf-8?B?ZjhydzBEVmwyYTBJQ252dEJBVGJlNVUySXhCV0xwVGoycy94TUhDdEFoWndK?=
 =?utf-8?B?cktjMjhrbFJ4RTkvYkNPRUxOaDk3Z0ovOHFMdzVSdU9saGZwZEF2T211VGlG?=
 =?utf-8?Q?itK512RTNsqHo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGJMU2t0cDZHcGRmQ0x4M3JBYWR6U0NUSFVUSm8ycVVURTZ5ZUduc01pZnZO?=
 =?utf-8?B?U2VUZEhvaDkwVnhvcGdablBjRzZxcU9FUEZ2S3laaWV3bVp6YVpOaktPYTJB?=
 =?utf-8?B?dklZVU9CRFJmSFZZdkg1d2dtT05uQ1Z1Q2QzZUVjSVJlMTk0VlIyWFNQYVgv?=
 =?utf-8?B?SnVKTTMwZG9ZVlBKcFJEZ3BEVmNXeHpDdW55RlJzcCs1VzRydThKbitqV3FF?=
 =?utf-8?B?anpXVWVTM0JuVGMzcXpaVjFiQ2gwRWM2dDhpWDd6ZG01Ly9DUVAzOW45WlVh?=
 =?utf-8?B?cHZQUk4zVk8zYitnZlZTWVRhUkJ6QklhT2ZHVlIwZk9rVUlvR3BYWnhwb2FW?=
 =?utf-8?B?eEc3M0xEYkx0U3loV1VucUdySTdISFVhOHRzNW9vMEhVaTBuUVRzcUZ5MSt5?=
 =?utf-8?B?cHVuZ0JGOVJLeHVaelNXcTNPdWhiaDEvYXdmWC9uWHp2OGNCbWFHUnpGQjQy?=
 =?utf-8?B?aTBBWjNUWkxSK3JXaXYzVnJDa0YxenYyY0NJZnJqOTJMY0J5d3FZYW43dG83?=
 =?utf-8?B?MkI0Vi91WlR1YVB6KzRqNFRaTkVvR1VaWVQ2YTdzRFg5SDJBRjNDd1BXamJz?=
 =?utf-8?B?TlhWTGIzSk1WMW44V0FQVDBycEtVdmlDdHA2cTBETXB3L2FQSnRKdzhiQ2xa?=
 =?utf-8?B?WitKQnVtNnJqQWJXUnY2RWZsWjJwZnRIdjd3SThTejJDMnlTZDVUZ0tKSEJ6?=
 =?utf-8?B?bi9oeVFBeDYvM0VtazlEN2IvSElKdnh1VUliY2pPSTdmZmllbm1oUTFGY2NY?=
 =?utf-8?B?QjZYV0lMVFhiTHJXRGJ4ajdDa2s4bjhDUElzTjdQTnlnUDJNRzlGRk5uekM4?=
 =?utf-8?B?VHdja1ZBaDZmYWNrdHg5VW1WYmlERUJBZEdXQ2V5cHBLcjBzVnlVV2JtYnYv?=
 =?utf-8?B?THlpeVBjMXlNVFdpLzRqRmx2OEw2MDRhbUkzcDNtS0I2Y0ZpcW43bHpIUUtY?=
 =?utf-8?B?ckZEYUxxUldEODRzNCtWV3EzYmxLcG9ibFRWb2h3d1dKQTgwQXUxb0VHWTZV?=
 =?utf-8?B?Z25FcC9iOElueVIwcXB6ZS83V0M1M0JQTS9MSVJXeko2V211V0g5ZFZLZENW?=
 =?utf-8?B?MVhJWEhYS1NXeWlZRHB1RmR0MTJ4TXd4M3hRWGRHZHpNYlNVVEo4RHRWT1BW?=
 =?utf-8?B?ZWtyZHFSdGFhd25hTjdRMWJCNGY5aFF1OCtndUhVVDdVT1pjeGJuK3BCNVAy?=
 =?utf-8?B?L0hwNEpTQkZPTnJlK3FPSUpXWmlLTXh5MTYrRngzeVE1MThldHFXM1VHMUds?=
 =?utf-8?B?MmltS0xHV2JkZHphNUhNMC9TaEZLUExrM0NvUTJYV1NsYm10ajZMdDkxTnVO?=
 =?utf-8?B?VXAwQnpPczlrb2lhZTVWdURidElReGNHK2tDMnJuR0tDbHdRaEg5VUI1TEFu?=
 =?utf-8?B?MUZpYituN0EyczNRSzM5OU9JNFJHbWRBUThBZWhCbXpjS1pDdVZMY21FNm93?=
 =?utf-8?B?NWtOdTdKOUFOSjJGQlNpWXFhK1pmRkt0Mnc3Zy9qaFJNTWJWeU1xN1JzblJR?=
 =?utf-8?B?YXNzenF2ckxGVjFYbzN4akNMdyswd3hFeFJTMjREVnFWUHg2ZWRmU0Q2VjdU?=
 =?utf-8?B?SXpGWnJNeDYyUVlSVHpHMnVLeC9HbVhqM0RGalk1MEJzUW9Jdm5GaWt2Vnho?=
 =?utf-8?B?dmgxc3JEMGVYTHJYK3F6RDBFcU85Q1dwTW5ZUUFSUEppQXVpVjJpOTNPc0Y4?=
 =?utf-8?B?bmw1M0tzQjBxN21GcEtTQnk2Qmp0dUN6alRwMEQwbGtmaWZFUHA2a2FZcWhV?=
 =?utf-8?B?UXE4TGtGRGRqQ2NnOXpqazVXTStRQm0zZGRVcTdmZGE0eVpQdHVXeVg4T2Ux?=
 =?utf-8?B?TDkvc2dBQnBGYnF2SUpnV3dERkxtUGppd0Q3UXNnWFp4MGF0eVN5bWFDU2N5?=
 =?utf-8?B?R1RuQW12amMvcjVWU1ZPQ1dEQ2J5ZHhYRXIyOFRMTkVzcEJpQkowdjMyb0Jp?=
 =?utf-8?B?T2ZoMk1ZeUNyZVI5SysvaUlwTUZaWG1YWFg2Ny83R0lwaklEOEY0S3dadHh6?=
 =?utf-8?B?TjVRYTJRQU5TcEdtQUMyREQ0N3d4cTA5SEtlTlZoSzZKbjhveElPYWRGMFU4?=
 =?utf-8?B?czkvRm5rN1Y5RC9rZ2VhYVVydXFxM0JCTUVYWlBvY2JxaEdYTDdiYko0ODBk?=
 =?utf-8?Q?q91ZA/0OZBQuVhQ46LcWxAHPQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3defa5d-2478-4016-8659-08dd34a87190
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:33:42.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQbxLDPhVd/pY/1qT4G+9Yh0r4p5sqr12XXYYr6H1lbnB3MIr2z33dtQmfPyhaz+80dtbou0CFekdrJ5eh2C+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585

On 1/14/25 01:27, Kirill A. Shutemov wrote:
> On Mon, Jan 13, 2025 at 02:47:56PM -0600, Tom Lendacky wrote:
>> On 1/13/25 07:14, Kirill A. Shutemov wrote:
>>> Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
>>>
>>> memremap(MEMREMAP_WB)
>>>   arch_memremap_wb()
>>>     ioremap_cache()
>>>       __ioremap_caller(.encrytped = false)
>>>
>>> In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
>>> if the resulting mapping is encrypted or decrypted.
>>>
>>> Creating a decrypted mapping without explicit request from the caller is
>>> risky:
>>>
>>>   - It can inadvertently expose the guest's data and compromise the
>>>     guest.
>>>
>>>   - Accessing private memory via shared/decrypted mapping on TDX will
>>>     either trigger implicit conversion to shared or #VE (depending on
>>>     VMM implementation).
>>>
>>>     Implicit conversion is destructive: subsequent access to the same
>>>     memory via private mapping will trigger a hard-to-debug #VE crash.
>>>
>>> The kernel already provides a way to request decrypted mapping
>>> explicitly via the MEMREMAP_DEC flag.
>>>
>>> Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
>>> default unless MEMREMAP_DEC is specified.
>>>
>>> Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.
>>
>> This patch causes my bare-metal system to crash during boot when using
>> mem_encrypt=on:
>>
>> [    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
>> [    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]
> 
> Could you try if this helps?
> 
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index c38b1a335590..b5051dcb7c1d 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -160,7 +160,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
>  	if (WARN_ON(!efi_enabled(EFI_MEMMAP)))
>  		return 0;
>  
> -	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB);
> +	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB | MEMREMAP_DEC);

Well that would work for SME where EFI tables/data are not encrypted,
but will break for SEV where EFI tables/data are encrypted.

Thanks,
Tom

>  	if (!tbl) {
>  		pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
>  		       efi_mem_attr_table);

