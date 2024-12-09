Return-Path: <stable+bounces-100155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360269E9267
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA101882CD8
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC721B8E7;
	Mon,  9 Dec 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="RK663hqx"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1A21D01F;
	Mon,  9 Dec 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743819; cv=fail; b=uosFW/plS369ysfH/5WsqVzwo8FWOb7L8QBK+2gx7Gf9uZ2a8+1pwpJMKslnjB1FcnJt/XY2xAYnV+JH3ZLVIhaeAwuHpAYpQk5y/SuEeF/jvRYRA+wXsvWr12WCm6hm5DT77Jr77w2Y6/WxJk5jc26SjUyKrJde+OiPrEjGjfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743819; c=relaxed/simple;
	bh=abUm4b7PZ59KLthONXnYKYlTTbVXKGBA85Kz5XjcUbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ct9DlE6cU8PCa4SLPU6qAJUNcaY5BE9dDAPiaFd9Th3DUaPHwSyTR8v/Q2xfPzfmpQxN9J3NbhllDo1x1COrgnde0a9/NT49iITl8MRUvGyiPNdinDoqVgqBgeOv5Dbv7BKKd4H+e25wn2GOJCLGU9OwvSuR379r85LsaEB4pmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=RK663hqx; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zj0PheTPu5aXcMp+e7mw2Kg7fyrqxkBrFV9puwnSH1z1gWqfD+2t3c92PbOcKaxr500D8igWIfeJwUHrREGeKZP0ejgpMWTvma6Y8xkzPV6YMQwOvcaScgbaeF0a1iHx+mj7W5NGg5vVPSagkPp/BzrDI/T9d/TEv7NEF1WNR3N/XD7/I/6HDyJpeGGWR6pJoyD7PYtwuYrJzjga0KALdJ8AIYQB8AP9DF0OfaJywsiI4mUX9DzpM2IHV/Ef+xeUoSiTJfLjuIH76qPwSBW/pHB5CIoEvlqSNw6tWjwBl15AKIDDaliWbD85oBf+Jt1Bc+KiakScg4HbZ0OX00a1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMTKW0qMxaoACm7ZczLtA+fplb6GaZXPO81Ex2dBXsk=;
 b=Ncc63UfgNb/R8MgVGNPPs9XB9kHyxuGywirMSGzTK9a8VVqf3UDb4b1GitNe9VY6lncsnIz0MeOVomNGmx7J7oQKdbwKFXEG8JbRoBKOgbvS42nSO0m2xXuqF1N/jO211t1f3lPtM/HVB+3jOH9impHx+OLHUCbse2GGBgOLV4Dq30CxZZ3UwlZ3w5gX54+d+eGtrGLcRDODx0bnkpX0+pIcYraf421QE+fsyevVI2Jm3xLBHob+GsYjUe+7JznytKjNN3i6humdRdv8EmtE7sMNeUnTLvGpyCabfEFnJ9YDgXZL7LBMO26xvuBcF0cDhN5fwcBivNiD90hDVm1hEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMTKW0qMxaoACm7ZczLtA+fplb6GaZXPO81Ex2dBXsk=;
 b=RK663hqx2h3qiu2S/Rd5QQqYhLO2G+J5jcQAB5SazeAfexZO+v06fyy3/t/YqvQZIvSBbQEy4EzDA/70ezf5UdG8R3v5rGPBV9uLGcOw1HX6B/3EUH3OA6/zy/l5BajOpzCub4NOpCQWCP/JNGF2uMwLLtnRrVHL8bwC+UQu8hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 11:30:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 11:30:11 +0000
Message-ID: <93b1101b-fb3f-40b2-a2a6-11c942a8ccd2@cherry.de>
Date: Mon, 9 Dec 2024 12:30:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: rockchip: increase gmac rx_delay on
 rk3399-puma
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Iskander Amara <iskander.amara@theobroma-systems.com>,
 Sasha Levin <sashal@kernel.org>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: stable@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241205151827.282130-1-jakob.unterwurzacher@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241205151827.282130-1-jakob.unterwurzacher@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 3132097b-28e7-4416-d91d-08dd1844d78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNJVWNJS2tqU0UwTmhMcGNiVDhNLzFqbllXZk4zYzI4WmtDL0lPNktJN2hm?=
 =?utf-8?B?aG5uZVcrc21uTnRUajhnY1c0ZUtkSHcxUXljdHRTRExrazJKSkl1Z214ZzM5?=
 =?utf-8?B?RjVtbE82eVJUWmllTGNQTHZ0UEIrWEsybEkwVHBqM2VicWdxcHVOQ05xc3h2?=
 =?utf-8?B?amhheDRUVDZVRDcvbm1TNFl5L2JHazU0WEhXYU9nMFZEZjluYTl1ZU1KbGVR?=
 =?utf-8?B?bFhVb2RjQkdkTzB5a202VDlqYmpUVHZ0RkRFckZ0bjBYcUo1WkNhSzhRS2t5?=
 =?utf-8?B?QXBhUk9pQ1JkR3pjT2J4b0dadVY4Y2pyczFDYzZuVTdtTmtGOTBPd1YvM2ZG?=
 =?utf-8?B?RXZBbExqOVJCWEFWVHJUZmI3SW9FVG42aUltb3JaZ2VNa3ZUVm5EK1dhQUU4?=
 =?utf-8?B?ZjcrTHBhaVQyU2NUMnI0cy9lUXpoZ2xaSGF1LzNJWTJuSitCYk95NmhoQ0hp?=
 =?utf-8?B?bjN0SGd2bGI3U3VpNjd4dkhuektjTWJjZ1Y0YStTU1krdStyVVNqQzFSSnl5?=
 =?utf-8?B?MngvWVlvai9IMEJwU1RpaUNmRG95VnQvWG1Jbldrd09BRFFJUVpmdXNTVnQ3?=
 =?utf-8?B?KzZkanhGaHFIcUJlT3NXUlFkOGpGNzUrbmhMWUNsNWFKeDFQTWcrUDFmM2Iw?=
 =?utf-8?B?ZmN6NVY0SXdFbGh2RGhSTmd0WUJMRlkwa0JsTjdMM2lXWGh6blFlUXNhRTda?=
 =?utf-8?B?TFVwSHovN3lsa3lxdDdCbk1iZDUrT1k5Sm5wNEJ5YnFiTzM5ejNKT0RtODMz?=
 =?utf-8?B?cEhTM2treGl2c29ETmtyU3dTVU05L2Q0aVloT1dxdDdoR1F1UUJaNUMyK3Vy?=
 =?utf-8?B?NlU3TUgyNytVZGhRWHlWbXMvRXJER3UvV01VTGtya2dxYm8zemtDTG80QmNH?=
 =?utf-8?B?V2syZDgxT3A0Q0dFTmRVWGUrMU1Wby9CcTN3ZHhOaGp3TyszN2FFaFBYM2t6?=
 =?utf-8?B?ckxRYUpvS1B2RlJEOCtJK2JGYUM5N2ZkWTBsVjk1SHVPZVFCVjdXNi9PYnd1?=
 =?utf-8?B?bTloSTZyMWpvc09nYXgvNm9JbUx4S1ZJN29JR2Q3aE9PbVc0V3JKSG84eTdW?=
 =?utf-8?B?ek1RS3Y5QjhDZU40cVFQc0QvQkw4SlMvVldKSlNhKzJYOEFDbElUc25VYVV1?=
 =?utf-8?B?bENvYzBYMFAzZEF5ZDZ3ME9UOFcxaStqVjhrSnNvRGM0aXRHbUgrODRTWVpF?=
 =?utf-8?B?TTA2QWJVcWl6NjF6SHJHeGxoYWlya1VrSlhjQVpPbXprc3M0YzlpN2VvMXhJ?=
 =?utf-8?B?NG1hSVFhNjU1bzkzc3ppQmFubTVpQU4yc0tySFdYdW1oZzlmSDhFWEhwZkV4?=
 =?utf-8?B?UzY5TFlMdUdpejFMcEM5VVY5UldKRzIyNEdJdmxUZ3dxUmNxdzgwNnphVzJS?=
 =?utf-8?B?SW5sSUo3OS9zeEJLSm1FZXpvYmRsd3Z3ZW1LeGxSeHpGS1VUdGQwa1BJOTlE?=
 =?utf-8?B?OG52amFidnE0VjZkRnNIL0wrejd4cFkxVG04ZExVKzFRVGRTQjhNekNFQnJ6?=
 =?utf-8?B?Rm9CUWlNazVnT1kvcmNKRFF2MmkzV0FsQm1NYUxPOThoZkMwUkc0d3pyVXVo?=
 =?utf-8?B?OU03clE4dVdtQmNoVk91WG4zVFBGb0pjV1VQSnVCTk9LUjJCT3hjQU84cmda?=
 =?utf-8?B?QTV5RUNXaTNIL0FiS1k3VWhDTGIyWFJKSzNNQVV3QlZybWZzdjF0R0xVZ25R?=
 =?utf-8?B?a0NheHRpRTZMbzZXbkFINSswSm1objkxUXJ5SnJORE9kR3A5ZHZGcW9Welhq?=
 =?utf-8?B?b3ZpK2g0VU1mVmVQbXY5bjhyL3VTS2RjalJCelJ0bmRyNWtzdmlPVFlPOGVx?=
 =?utf-8?B?WW55WHBOSlVmTzJ6eUFJT0pjNnZrdG94RnJJdTJYU1BhWmg1Rks5YWdBbEZz?=
 =?utf-8?Q?RIxfc+5W2jwLp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHVaSDlyNENWZEdHSXNYeHhiMGJSWGdLNDAxVEsvVy9pUkVTR0ZWZ2pLYVlB?=
 =?utf-8?B?RmViRktPRnc0Tk1HMXNnMDk3UWFEUzlzMGE1eVdzM3UvMlhvNXFIRG9Tcllo?=
 =?utf-8?B?em5hZ3ZLTjVqSFNTRGF2c3ViSTdTZXFLOFZhQVMwQ3FKbkUxTVQyd3ZPcGhC?=
 =?utf-8?B?QzVqQWxyc2svOVc2cTVRTG9seTRmK0s2aDhqZCs5cmQxTzVPcnlWS1c1aGRE?=
 =?utf-8?B?ZFVSWlR2TUhKdXBCcC9xYVdORVNORHUxSTVVajljVEc0bjdmQW1IYU8xYjR4?=
 =?utf-8?B?cVBEZjVtVkJyc3cvYy9lVmpLbyt2RGlYbE9xeHNGb0JTeHNpSFppc1I4akFW?=
 =?utf-8?B?Vmt4RnhnaUkyZEU3MXhTdENhcmc1RXQvN1BpN25qUWdwV2RlMGJBbjdTb2l1?=
 =?utf-8?B?TmkrbU9xbHlpT1pYL0Fxb2g3YjhERjh2c0JxK052L29zQ0hDRU16bWZNYzU3?=
 =?utf-8?B?UVZTUE5wZnZYV2lwNWc0dm0vbEdlWDdpdTZraHlROUZZRkpkcUJURUtObUMw?=
 =?utf-8?B?UFk5dUpIL2Z2Zm10V0Iram9YemVscnVMMU1EdEgwZmdBUUR2K1oyR0x6N3JD?=
 =?utf-8?B?aUF5ZUdXalhDcEh1c1ZHRG1abzhYYUVSRjVKOGY0RnRWRlFCRVFLRXlOTXdi?=
 =?utf-8?B?ZFNKSldVdkttZmQ4RXEyQVZHWTR0d2tUVFFuc0tSY2oyYlJVcm1QMWNTV1RI?=
 =?utf-8?B?NEs1Rms4K1YvZVpROFNuVzdscTAxWFpLRjFJNDJseStrODdOYlR3TzJsK1ov?=
 =?utf-8?B?R1p1Wm1CRzFlbDJNTUhUY2FNOTZlTk0xaDMzakJQK0IwS1JzVlRrRWU2am90?=
 =?utf-8?B?VnRhRTJyOWI4bkM1QXJQV1VhU21PbWxyUEhqMTVzL3JUQzZxaTlWQ25FK1Nu?=
 =?utf-8?B?M3ArdUZMbFFESW92Rkg3TlJMaXJjSnF2S29ZcW51V2R1TmxLWVdwakFWeFo3?=
 =?utf-8?B?aWQ5ZTA1TjFYNzVNQ0k2dDlBK1FkcDN4ckU2OXhVY1FFMWNsbCtNbjZUQVp1?=
 =?utf-8?B?L1I1Mm5KT1Q4TXlWYkRyTFpOV2J3M1ZSY2gxVjVjc1h3bTc4a2NsWWFyalll?=
 =?utf-8?B?ZFAvamJUVFA3ckg1Q1VGa2Vpcy9NWGRnU1V1M1hKd0E1aStxa2NQdmx2eWY0?=
 =?utf-8?B?M0s1RHFNMVJvWkxwZitWaUlNWGFqbmx4bFZ6ZWxjZHNleXlUQ3M4YmREVWpU?=
 =?utf-8?B?SWNwR2o3OFFsRlEreVJrNTNLTjBFdUZpSjhyVUJzVmtSdml5anoxa091Z1Fw?=
 =?utf-8?B?TVRYZmoxVlorb043RWcvTSt1SkZIZENDQ0RRaE1RUEFVZ0YrZzVLRXcwNjVB?=
 =?utf-8?B?TjUrblB1blFQSTZHYWVrWDd5QStaRzdrdTZpR1haYUo4MDAzaWtmZjUrOGZY?=
 =?utf-8?B?emxIQjhRQ0lneEZyMWR5Qi95eWdhakx6WnhuNUtsUUtlcml3Zjl0L1k0STBO?=
 =?utf-8?B?eHBGZDQzcGl4REZlcWNEZWZ6QmFsVm1GM1E0Qm05ZWc0OGFKWTI5dGFyUE1y?=
 =?utf-8?B?YnZrUk5UdTBhb0RzcDNWd0lKTk1pakE3MCtjR2diVGQ2bk9QUFBuNzVROHpH?=
 =?utf-8?B?aGRZOEY1bnlzZ2Vld3N2Yk81OWdiYkV6Y2ZxSUlGemt1M2dHVEc2aFk5NDNJ?=
 =?utf-8?B?V3FTU0ozaVJ6S1hreDNVSXBTZzlCK1pZemNGY0s2L2Erb25DN1pKRW45UFBZ?=
 =?utf-8?B?NUFMK3NDQS9KQWRlNzFoaEJqN3BkUnBvMVZNSk9nUDMwaFM2QTg2TkdxS2J2?=
 =?utf-8?B?OHZhZFEzM3MxZWd4dmg0TXJrK2NlaldnQUJqTUh1TFpQS3l6K3dYelU2M0s4?=
 =?utf-8?B?RjRobkY2YXZvN3c0dENUdHZRRUZkQUFOelZGaWd1akhHK2orL2xwUEQrTUtx?=
 =?utf-8?B?ZndMdk5uNjhLSE9mSmJtT1o2RlY1Mm5ZRTN6MUI3UmorVnJ2bFk1SXRIQXM3?=
 =?utf-8?B?MHp5cUlraUcrVlowTk5VTXp2OG95MUJtakRwSTY3cFdXb05zSjRUd3VsNUdG?=
 =?utf-8?B?eU8xUXJvS25XSU5SMHFVZG5wanJGcndkT0E5ZlJwQ0grb1EvVXBmb2tMMGl3?=
 =?utf-8?B?d2hUbGZFb3ZTbE5ZUWRnTVhWNVVPV3lQZkpiQWQxWXFBeDFUcHVNREc3ZFdJ?=
 =?utf-8?B?RFV4aXdPZjkwL1c1UnFHb00ySGdYVXBOdUV2UDhiSmJHcUNoczdqTDhYazRl?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3132097b-28e7-4416-d91d-08dd1844d78f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 11:30:11.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqxY33de5UkKm5DiUOVbmkI/bGnlfEtJaDWv+S52Tw6jA3fbI/Phd4Cf0hH8QQF9UPWvL6J9CfzTf94YXawOCLZDiGUAPsoKPc4G77iXW/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Hi Jakob,

On 12/5/24 4:18 PM, Jakob Unterwurzacher wrote:
> During mass manufacturing, we noticed the mmc_rx_crc_error counter,
> as reported by "ethtool -S eth0 | grep mmc_rx_crc_error", to increase
> above zero during nuttcp speedtests. Most of the time, this did not
> affect the achieved speed, but it prompted this investigation.
> 
> Cycling through the rx_delay range on six boards (see table below) of
> various ages shows that there is a large good region from 0x12 to 0x35
> where we see zero crc errors on all tested boards.
> 
> The old rx_delay value (0x10) seems to have always been on the edge for
> the KSZ9031RNX that is usually placed on Puma.
> 
> Choose "rx_delay = 0x23" to put us smack in the middle of the good
> region. This works fine as well with the KSZ9131RNX PHY that was used
> for a small number of boards during the COVID chip shortages.
> 
> 	Board S/N        PHY        rx_delay good region
> 	---------        ---        --------------------
> 	Puma TT0069903   KSZ9031RNX 0x11 0x35
> 	Puma TT0157733   KSZ9031RNX 0x11 0x35
> 	Puma TT0681551   KSZ9031RNX 0x12 0x37
> 	Puma TT0681156   KSZ9031RNX 0x10 0x38
> 	Puma 17496030079 KSZ9031RNX 0x10 0x37 (Puma v1.2 from 2017)
> 	Puma TT0681720   KSZ9131RNX 0x02 0x39 (alternative PHY used in very few boards)
> 
> 	Intersection of good regions = 0x12 0x35
> 	Middle of good region = 0x23
> 
> Relates-to: PUMA-111
> Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

I had reported errors on my v2.1 Puma (KSZ9031) but none on my v2.3 
before that patch, and have 0 after applying this patch on both, so 
improvement for v2.1 and no regression for v2.3.

I ran the nuttcp test for an hour, failed after a minute on master 
(without the patch) on v2.1 but not on v2.3 and it didn't report any 
issue after an hour after applying this patch, thus:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # Puma v2.1/v2.3 
with KSZ9031

I assume Krzysztof complained about their old email address appearing in 
the Cc list (it was changed in 6.9 in MAINTAINERS file) which 
highlighted you didn't develop on master (I did test on master though). 
Please address their concern from their mail and send a v4.

Thanks!
Quentin

