Return-Path: <stable+bounces-125742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E89A6B826
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC073B1CF2
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A81F151A;
	Fri, 21 Mar 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="VYjIE9P5"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754F1E98ED;
	Fri, 21 Mar 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550846; cv=fail; b=ebRvSkITNX0rOiKy4PmVXViQFxBj13mCbt2LrOUUTVkm/SIuqjmAlRhOVFgwqE0w0SaVJoqGnNGKgsUPJ+uA90jQ3cldN9TClFuW8sgAmMisgeD0JDra8M0jq+/biJYIC7gQ/FzFeS2nCxth9JrO5zfXgrIhS0odaDlc7RATDrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550846; c=relaxed/simple;
	bh=jHe89sbp3VK7vO2BA0YBWMNmNar0/pwtSPLBFoQHRvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qr6o7aHKhjQ9Gcl3aGoR/KgZ8FypMIjpJLcNWMePeDrP/5gqRTe8V2CrMsd+n3f0n5parZzceds10Q8Hx7gNeaf3gS39/gXxl9tpYVUIB6X6nEfSK1nIqo7iCZKiCZA1bNqRy9NVFRiY6JEpZTo+sRCdcXZe+8FeuDZRxgYqa6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=VYjIE9P5; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I58dLLm874EcU9NmdmRGwcnaWH0JjR4ux8EkwmDvbAJaahO/Z+nRfOfd431pNdc6ZfeD+/emYFAbD7Lqyez11AVS18fPUNINN88NX8gL89W/v+CSgaaq1AtzNSGAbkKtF0n7w2Dc5JHTbDJJTB+XkY13rS2SDwP4dONVGfDPPpcfSU9kCe5a2uuIBJBVI2Nz0/19SIBTXCX8bvvh676usIBDWWUwjJFYGCgOvK63fjs8RotnOZwEEuaJCvuYEHIUYSJSyqkdF54qtaVj0bXvz2xebpuYP6BXGQcwxHZqZVX4IkI92gpwNLn8u3vXKnlFW13ImXq6lDmn0Z1GoymMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qqb5cMDfEZmidCb37ywDJiPeqCLFEHdx7mIOM6MY8c=;
 b=QF3Pt3i1zhFgfeNbR/OPTyWOeqyDUfnQAU+1iJHENXn7xK2up/jDzwS6UMqjNdIivAN6JP2gE6QBC58Ix6OfmDAadBwJHQEpZ+D81YOowNU12OdqgOxdd5C/8AI7+LSqncs+ZpGkB5QuK2eMSyy0JkG6d8Rmx4tx0Oa4hcmj0P9+IMA+J1IJfUsJMP2q0Fmt97aJuMuui274kYFpGb7hGAd1xuofgOKj1du978N3NLOwBdUBpbr5/uXXcb078UPAtanGbzE24GSCVAwp0G0Srd2llJvrPHSMAbOx67zsAJquVPiI2xT8pjY99h7z9Qs52005jqhAXFAkHxSLt+qhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qqb5cMDfEZmidCb37ywDJiPeqCLFEHdx7mIOM6MY8c=;
 b=VYjIE9P5/cYq4WIgV8vG0uMivu94yKlVOFEcXy+fEhBZPCW1z7/Paja5jOQbVLHfNUTRM8PZIUA2SVnIuvqG1jFfE0MuRxCB/Tr7+YdOJAYPNSexJGaRGy3TrZJN+d2WOfFUwVlu5SeFBUWQmZv6EoPmhdymvTT0zPIV7tq9wkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 09:53:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 09:53:59 +0000
Message-ID: <71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de>
Date: Fri, 21 Mar 2025 10:53:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
To: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org,
 Alexey Charkov <alchark@gmail.com>
References: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e553a9e-e565-4c8c-5ba9-08dd685e4d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3MyMTlwTnlIK3ZHcnNFRDVuZ2huUk5zMU9aYjMzUDRGWStLNDV3VUhreVBD?=
 =?utf-8?B?elN6NUtBdDFmVWdmbTRucFdGT1J4TG5mbDNmblJjNVJxMnl5SU11NzJud3dQ?=
 =?utf-8?B?Qk0rYkVMV3VtWk9kTmZVckxqeUVVYVVoOXhYVkxCcDNqRjRRQWpxT3dqSVU0?=
 =?utf-8?B?d2RhSkFoekpldEc1VWdYUkt4SGJGbG9FMVRUWkxMQWFHajdkczB2bS9zaFk5?=
 =?utf-8?B?elpFRlhhNXNFMXZpalFUamUyK2ltSW5aOUlBZCs3ZG1GRWh5ZE5WSExnQUNB?=
 =?utf-8?B?Ujc4MjEzL3hkNE9GbG1QU1dUWlJtZFB4eU96VUVZTDNqTmtYbzZEb2FucFRH?=
 =?utf-8?B?akI2eTJLTmNua3crUm5MUnBEdGpRK1ZqbWt3dy96d01YUHVKMlNmVUk1Rzkz?=
 =?utf-8?B?SWNncVR1a0NCYzlaZXN0UUpJVDZWZnFmM0l1czVZOXFkYW15T1RMc1M3Qm90?=
 =?utf-8?B?bkN3eFZ4T29UeXoyOFkyNFQwSWhXZmgydmJ1YzBWVVUzemc4aForQTJUSTNm?=
 =?utf-8?B?aktjSnFMajBDdTNMV2hLTjZERHRidXJkc2ZOVktnNGN2VzdsZWQxM1lFTjMw?=
 =?utf-8?B?UlpQYk9qenBGOEU0UUZ4cGNrMVEzc3NEYnd6WjcvQU5oTmVBUVBhTTBydFRh?=
 =?utf-8?B?VVhnOXB6dkEvUk9ldUtnSVYyTDVjdlNxSlRlUCtPWFdUdzdma2V3SDkzSG9I?=
 =?utf-8?B?NFBmbTM1SzJpU2swcFNwMzZFUFZUUlJHTTNoQW9CM3cwRU10T25qMHVaSGlG?=
 =?utf-8?B?a3pGYzFQMEtJREQ3M0M1MlpneDA2OVlFV1RQdmhsNmd6MFN4QzdiNHBneTQ0?=
 =?utf-8?B?bVlscktEaktvejdqN1ZEeXlEVWhqbEVzcld0L2dCaHl0Q1lOS2ZMUzZiNk9L?=
 =?utf-8?B?OHd1L2taaFB1Y2dmdU41eFMvbXRSdU1lMzhqYnVGVVQ3RG82d21qRlBXdUcx?=
 =?utf-8?B?MEluU3FMRXVEMmtHS0hwRndqWk5Cd3BnRGFCMDNTbnlPUzZmRnZ1Wnp1eUpm?=
 =?utf-8?B?cmJFb3ZuWExTQzcxWCtPTVE3di9WN2EzM2RsZkwxREJJUXBNbEF2UW5rdGlX?=
 =?utf-8?B?RUxBd0ZEQVIyTEFtd2NvbjJRNVp3N0YxbU00YnU2MnEvblplcjJVOVNNR2xS?=
 =?utf-8?B?dmp4ZHNIbHNIUUNrYW0xMUY3eUJpdDZSS21UejI5UHFvZE1IRm42RWVtVktM?=
 =?utf-8?B?MDhyaXpSWnVWSHM0akJSZUJzUjl1YUV1SmtvQlo5MHJyNThSbWptdjRndFow?=
 =?utf-8?B?ZFprQWVOZjBzNzJDZ2tOejE3S1NhMXBXTGVVbnZwVDF1TzB5Z3AvbTdmdFVi?=
 =?utf-8?B?NFFyQktTeDl5Sy9YQXZBK2ZZUTdodHVmVlQxWGc4ZlZzSkVmYStzVUJGYmFX?=
 =?utf-8?B?U0dDSUpVTHgvUGQ4MkN1SXhlTVp6em5pL2JVcFVBK29vNWNsSm1oTGxVR2VB?=
 =?utf-8?B?Wk1CTVFsNzRqU3dVT3k0TTFEZmhpL3paWTdjcHU3dzFOYUQ5cmVvc20rajQv?=
 =?utf-8?B?dkNwYUdLRTFTQWN6b29IazFRWitvQzNoSFlzbnRjdENUbGNjYWxpa2VVWWl2?=
 =?utf-8?B?NXdPS2RSbU5GK3doQnpvemlzbnNMYStXVlZYY0ZhekgyMnZqOGpPU0tMVVJm?=
 =?utf-8?B?RFlVaWVIeWxXOGZwTHQ0QnBVNUFweWRINFBHQ0tjR3U5eU1QL3ZZUjFiQjFx?=
 =?utf-8?B?QUpTOTUwbmExWVVIRndNU2VmOWZnYzl2NERXSUw3c01jU2lFQ1V2Q0txbkM5?=
 =?utf-8?B?Qzc3bDJJRHFHL3pyM3Y4RTVnQUxxcXZhVGpZdUxlNFBkTnNuWVgvNk9iMk9W?=
 =?utf-8?B?b0NNNWtrdnI4MWRSMnVQUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2p5L2xLRGlwVWd2WHFZZ28zNUpYamlmZU5rQzJxbUVXZnNSSGpSQ1ZqdlNU?=
 =?utf-8?B?cHBjd3VXYkV5SXA0UzJDbXdGQlEyc09jem9EOTJSSDhNZm1BS0pTQmN5c3dR?=
 =?utf-8?B?MkxodlJNWGNlUkRBRHZiNE5LeCtYMXJPTEFJYVBva05mc1BRTTR5T3hIdmxr?=
 =?utf-8?B?TURFL2hWeEd1N3JFVi91U0lEM2hxWU1zYVNXajd0S2pXdjZDc3pNMkRhY3Vl?=
 =?utf-8?B?c0FlaWdkZEkxcDZLNFpmNGtGVk93cEVoV0pzUFJzWkIvczBxOFpsZXhDRnB5?=
 =?utf-8?B?ak0rTE56Y205cG81bnl5bnRqSG9uVU12ODljd2NBU3NZVjF3R0g5Lzh4ck16?=
 =?utf-8?B?VTF4WCtienA4dENlSnN5TlRVYXNCTm0vNXhZdjNzS0EzK2YwbjNRNkVYLzM2?=
 =?utf-8?B?MzdzTWFIZjVGcXZ5bzhVczhaTkhSeWY1TmRVdTBRRWFOaTdRQVJ3MTNxZ0ZP?=
 =?utf-8?B?d1hWMFYrWCs3N1F3R296eW94Qy9zN2l1N2NnOEUvV3IrM3ZpLzdCRVBjSWt3?=
 =?utf-8?B?aFBzNHNvVjlxS09zdURsbVNoVnhwYnZLMzBZTDR4WkgyVFpZVTU2Mm9Ycmo0?=
 =?utf-8?B?NFk3UXhEQkdZaDQvemlCT0NmNVdsSVNIaktZZFhsQmV2MVI2U0lESGFsQmd0?=
 =?utf-8?B?dk9lWVRLM3VrM2Q2dHFCTVlMbmZEYlQ0bVd2emIzNGRZWUZzNjk4ZmpKdjV1?=
 =?utf-8?B?dWNmakE2R3IwTWRVeDV4R1FrMTgrdmlmbkRodkRmVmhTTGdOQzJmQ3VYQlNr?=
 =?utf-8?B?R2lMSzJJdE9kRTJ5OXRucmRHNmRsQmhSWjdzcjJhOVRzWVFsWVNsSm1XMTJV?=
 =?utf-8?B?cGJrUk1IZjIrbU1xb0RzUnFVbm5WaThOclRpWFVycnpCY1dXMmtNWkFUc2NK?=
 =?utf-8?B?bzdoUittVlQ5eHZzVk5BWXRIR0tMbnZtNEhEUU1LeTFoNGt0amtlZjdOMGIr?=
 =?utf-8?B?enpwV01kdHhiZEErbUFPNFdvVlg1Mm1HVUpGRXBkY08xVkMwejdqRlhWMmp2?=
 =?utf-8?B?bkVDZlNWcGlpZ1hkSVhTTDR5S3F5clN0OEc1VHlIMmxYWkcxZlJTS0YzVWU2?=
 =?utf-8?B?cVo5Y3hvKzdIZWNCYUF3R1dia3VhZ20zbklmZVJVODBuT09LQytudUtha3F3?=
 =?utf-8?B?cUhKOXJNRUt0Q2Z1OUFZUk9LRWt1bUZTUkphd3FrRjh0RVB4OEVWaUZhV0xu?=
 =?utf-8?B?VDhxbGN4T0l0OG55dGprVWJFV0tCT3Nqa3NyK1VxMjNOU05tK1lXb2V4TktG?=
 =?utf-8?B?Uk9tbXA4OTYxOFZuS3BiblV5LzBpK1hzNXFCME5OeFY0U05CK3pkU09Ya25S?=
 =?utf-8?B?TlQ0bjNKTWI1RW5XQU1hRlF1RTF2M3BkNzFrM01VZVZMWUZtWW1ieTBzck1x?=
 =?utf-8?B?ZldRNkNyaC94Q3Y4UURoVE9GT1Yra2ZGMmIxRExTWWwrUXRHVlNVekJZT3VJ?=
 =?utf-8?B?WDcyTk56bE1PQWR3RGhDbytXNHFuSHpFRHF1cmhYc0tiOVVVYi9GYnFvTmpO?=
 =?utf-8?B?bGs0MlgxSXVrcS9oWVVWd2U3aHVvNU9VbDU1U3g1QUlQQkk4VmpIdGphWDdV?=
 =?utf-8?B?OEJHT0p4a1MwczBZQVpUUWxiTmRnbTdDSnB0Vy9hcVVLZnhJekZtQ1docnJZ?=
 =?utf-8?B?MDV2ZWQ0Sy9ocWhPTndEMDFsWU0wbC9taUw3d3J0dDRONHA1UXkrRi9KRm01?=
 =?utf-8?B?UlRzTDNlcXN6aHh0ZG1nZUtacHBWUVNDaW11YTUrL2xjS1RXNWJ5a1ZPTzNw?=
 =?utf-8?B?NlNORGM2NGpoTVVZNUFpeEljZGZtSDVOQ3FMYWxaYnhkN2pwRmtyQVBnOXpB?=
 =?utf-8?B?OHNXcS85K1lZaEFPdVJjN3VBTWsxSG4wWXUyaWRzQmxCb1ZlZ2tScmdHbVM1?=
 =?utf-8?B?QTZQRTJmTjJTL3BEOGlwdVh3MzFuSWhwU0lQWmRMTWhhRzhxVTdYNlhWbzlR?=
 =?utf-8?B?QXRsVVFmdzRoSEdSZFlkaG42cGlaR1cyMmFDa1l0THlWb0pVaW0vN2czS3hF?=
 =?utf-8?B?K0w4dFJwUlZxTmptYmdocjNmdXhsWW9xVURPVDBTaGtYUlFVYW1Rckk2c3lY?=
 =?utf-8?B?TWNIYVJSQVhZUTNlQmVMaU54VlduMEEzWXp3OGN4ZXZFZVNQbHZIMGdkUC8v?=
 =?utf-8?B?QURwOUtvd2hCMU0raGphb252NDJMbk9mTDZpc0hYNFFvK2J5ZFpCZS8vKzFm?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e553a9e-e565-4c8c-5ba9-08dd685e4d63
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 09:53:59.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxplwNRoiThXsKeINEVKHOa+wp9F+NaHbmFF5hcw1govWXwfeBwVeLmNhkjU/e2H61b5G7hHCUI08X35iwvriRVyRAnoMEokPHQneuviqXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

Hi Dragan,

On 3/21/25 4:28 AM, Dragan Simic wrote:
> The differences in the vendor-approved CPU and GPU OPPs for the standard
> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J variant [2]
> come from the latter, presumably, supporting an extended temperature range
> that's usually associated with industrial applications, despite the two SoC
> variant datasheets specifying the same upper limit for the allowed ambient
> temperature for both variants.  However, the lower temperature limit is

RK3588 is rated for 0-80°C, RK3588J for -40-85°C, c.f. Recommended 
Operating Conditions, Table 3-2, Ambient Operating Temperature.

> specified much lower for the RK3588J variant. [1][2]
> 
> To be on the safe side and to ensure maximum longevity of the RK3588J SoCs,
> only the CPU and GPU OPPs that are declared by the vendor to be always safe
> for this SoC variant may be provided.  As explained by the vendor [3] and
> according to its datasheet, [2] the RK3588J variant can actually run safely
> at higher CPU and GPU OPPs as well, but only when not enjoying the assumed
> extended temperature range that the RK3588J, as an SoC variant targeted

"only when not enjoying the assumed extended temperature range" is 
extrapolated by me/us and not confirmed by Rockchip themselves. I've 
asked for a statement on what "industrial environment" they specify in 
the Normal Mode explanation means since it's the only time they use the 
term. I've yet to receive an answer. The only thing Rockchip in their 
datasheet is that the overdrive mode will shorten lifetime when used for 
a long time, especially in high temperature conditions. It's not clear 
whether we can use the overdrive mode even within the RK3588 typical 
range of operation.

> specifically at industrial applications, is made (or binned) for.
> 
> Thus, only the CPU and GPU OPPs that are specified by the vendor to be safe
> throughout the entire RK3588J's extended temperature range may be provided,
> while anyone who actually can ensure that their RK3588J-based board is
> never going to run within the extended temperature range, may probably
> safely apply a DT overlay that adds the higher CPU and GPU OPPs.  As we

Wouldn't say "safely" here, Rockchip still says that running overdrive 
mode for a long time may shorten lifetime... that followed by 
"especially in high temperature condition" doesn't mean that operating 
the RK3588J within the RK3588 typical range is safe to do.

> obviously can't know what will be the runtime temperature conditions for
> a particular board, we may provide only the always-safe OPPs.
> 
> With all this and the downstream RK3588(J) DT definitions [4][5] in mind,
> let's delete the RK3588J CPU and GPU OPPs that are not considered belonging
> to the normal operation mode for this SoC variant.  To quote the RK3588J
> datasheet [2], "normal mode means the chipset works under safety voltage
> and frequency;  for the industrial environment, highly recommend to keep in
> normal mode, the lifetime is reasonably guaranteed", while "overdrive mode
> brings higher frequency, and the voltage will increase accordingly;  under
> the overdrive mode for a long time, the chipset may shorten the lifetime,
> especially in high temperature condition".
> 
> To sum up the RK3588J datasheet [2] and the vendor-provided DTs, [4][5]
> the maximum allowed CPU core and GPU frequencies are as follows:
> 
>     IP core    | Normal mode | Overdrive mode
>    ------------+-------------+----------------
>     Cortex-A55 |   1,296 MHz |      1,704 MHz
>     Cortex-A76 |   1,608 MHz |      2,016 MHz
>     GPU        |     700 MHz |        850 MHz
> 

The NPU too is impacted by this, so maybe list it anyway here? Even if 
we don't support it right now and don't have OPPs for it.

> Unfortunately, when it comes to the actual voltages for the RK3588J CPU and
> GPU OPPs, there's a discrepancy between the RK3588J datasheet [2] and the
> downstream kernel code. [4][5]  The RK3588J datasheet states that "the max.
> working voltage of CPU/GPU/NPU is 0.75 V under the normal mode", while the
> downstream kernel code actually allows voltage ranges that go up to 0.95 V,
> which is still within the voltage range allowed by the datasheet.  However,
> the RK3588J datasheet also tells us to "strictly refer to the software
> configuration of SDK and the hardware reference design", so let's embrace
> the voltage ranges provided by the downstream kernel code, which also
> prevents the undesirable theoretical outcome of ending up with no usable
> OPPs on a particular board, as a result of the board's voltage regulator(s)
> being unable to deliver the exact voltages, for whatever reason.
> 
> The above-described voltage ranges for the RK3588J CPU OPPs remain taken
> from the downstream kernel code [4][5] by picking the highest, worst-bin
> values, which ensure that all RK3588J bins will work reliably.  Yes, with
> some power inevitably wasted as unnecessarily generated heat, but the
> reliability is paramount, together with the longevity.  This deficiency
> may be revisited separately at some point in the future.
> 
> The provided RK3588J CPU OPPs follow the slightly debatable "provide only
> the highest-frequency OPP from the same-voltage group" approach that's been

Interesting that we went for a different strategy for the GPU OPPs :)

> established earlier, [6] as a result of the "same-voltage, lower-frequency"
> OPPs being considered inefficient from the IPA governor's standpoint, which
> may also be revisited separately at some point in the future.
> 
> [1] https://wiki.friendlyelec.com/wiki/images/e/ee/Rockchip_RK3588_Datasheet_V1.6-20231016.pdf
> [2] https://wmsc.lcsc.com/wmsc/upload/file/pdf/v2/lcsc/2403201054_Rockchip-RK3588J_C22364189.pdf
> [3] https://lore.kernel.org/linux-rockchip/e55125ed-64fb-455e-b1e4-cebe2cf006e4@cherry.de/T/#u
> [4] https://raw.githubusercontent.com/rockchip-linux/kernel/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> [5] https://raw.githubusercontent.com/rockchip-linux/kernel/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> [6] https://lore.kernel.org/all/20240229-rk-dts-additions-v3-5-6afe8473a631@gmail.com/
> 
> Fixes: 667885a68658 ("arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j")
> Fixes: a7b2070505a2 ("arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j")
> Cc: stable@vger.kernel.org
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Alexey Charkov <alchark@gmail.com>
> Helped-by: Quentin Schulz <quentin.schulz@cherry.de>

Reported-by/Suggested-by?

I don't see Helped-by in 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

I see 2496b2aaacf137250f4ca449f465e2cadaabb0e8 got the Helped-by 
replaced by a Suggested-by for example, but I see other patches with 
Helped-by... if that is a standard trailer for kernel patches, then 
maybe we should add it to that doc?

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 53 ++++++++---------------
>   1 file changed, 17 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> index bce72bac4503..3045cb3bd68c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> @@ -11,74 +11,59 @@ cluster0_opp_table: opp-table-cluster0 {
>   		compatible = "operating-points-v2";
>   		opp-shared;
>   
> -		opp-1416000000 {
> -			opp-hz = /bits/ 64 <1416000000>;
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
>   			opp-microvolt = <750000 750000 950000>;
>   			clock-latency-ns = <40000>;
>   			opp-suspend;
>   		};
> -		opp-1608000000 {
> -			opp-hz = /bits/ 64 <1608000000>;
> -			opp-microvolt = <887500 887500 950000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp-1704000000 {
> -			opp-hz = /bits/ 64 <1704000000>;
> -			opp-microvolt = <937500 937500 950000>;
> +		opp-1296000000 {
> +			opp-hz = /bits/ 64 <1296000000>;
> +			opp-microvolt = <775000 775000 950000>;

Got tricked by this one.

In the Rockchip vendor kernel, the opp-microvolt is 750000 750000 
950000, so the same as CPU OPP 1.2GHz. However, the opp-microvolt-L1 and 
L0 are higher than that. Only a couple of the OPPs in vendor kernel 
actually have opp-microvolt-L* higher than opp-microvolt, that is a 
noteworthy oddity for anyone reviewing this patch :)

Anyway, that is correct, we take the highest voltage among all defined 
opp-microvolt* properties.

I only have comments on the commit log, the diff is fine so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

