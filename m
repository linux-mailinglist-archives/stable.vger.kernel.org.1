Return-Path: <stable+bounces-202927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A24CCA421
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 05:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9F06300A862
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 04:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB53BBF0;
	Thu, 18 Dec 2025 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="dMXIANU8"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD21E4BE
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766032496; cv=fail; b=qwubmiZhou8CGyc+Otsn+lsMlgRMm3QqvQJYc5TKaZ5cYTWck2Cj3s3sB1bKPMD0e90m1Dhxu9WuG10SgQ3yvjo8Xp+WuhqJOAVBqQMXqfLtdVIqFQLZmKkIx3tC6iYNfF4a53/aUIu3SzfXPt7rgdRG9MJhj8aoSfTbWMcFRaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766032496; c=relaxed/simple;
	bh=WYcMVYIt3ktcH3VpgOj5dQR59jqkXuANuc9gCEbIKyw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=itGO9fk8UdvasoWN219NHgGXzWlfY/D+7xb+lDWTNUuzHjuz/eemObYdiYUjibkck1pjE7kwFdg7xOkGdS04V6JO8y2FlDdUoQUjJEJHZ0blgfTYHOb0vvnf9UX95Lcl/+zGUeON8gEmjfe6gWvfh0jdIf9dAvE4ID+8QRjyVR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=dMXIANU8; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Received: from GVXP189MB3428.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2ac::14)
 by GV1P189MB2059.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt7LnQ2HBVwIYAjlqDky9aV7HuI7W3R58uegzLyzSJo8UJc9Pmgl+jBfCZou1Recyhq/M5bifiKuGhG3okVn17ck0d3fM9XD08b6Gxbo+aShOBIjl2+wwv98EtGkA/JRG8Zz8RV1jRleXlItjhZkwKoonsXlNpSFGi2+kHB5z3MrRbQNEe1qXStZKdEIFyzh4bqqkldd/Ef3O4AoMMohud8KJprvz3p+Gevh+Y7tD0FTrrqmG8UGtJcO20DH7cs2Itq88mPLXMtaaQhGUBlAcpc3yo0rzRLiXT9z5TU1N/HsdG12V2KDqEhtQNfpd57Ju5ZGLaRzW53NyCdQ4n4GEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVwVz8+BcIN3KQzYL0T61UR0CN4pqzaZvZ7nMwtgm1U=;
 b=pkvDvbO4d4CthA68MwaB5W8nXuy6GdQ74Rnb6Sj+QMRECwTNIGrE+fLq0IMVTJ0CRUTrpfJDhgY5M44/KqG/As0VVdKwEm/Typa5rCzaFb/X/rWzocI4wzYsyJbyGM4zhWNdZ/mr5tg9Bl5WLmOU2nUVxWa6Ia2DG84qP4x12SbjRjbXrvcGH6Yfa68uUdTJj0tJUcHWqFQEI4w3rDxJhD402KPwiG7oH8m8qcDskxLW6n5D1W5HHXW9hizbq1CBbVRT70dT8VxVyGbisOaeCgYgruR4fTOAWvMGnTBYoah71A7Xl9+ww2lSa8KoRVo5rwIvgx+3+Al25yrkK+v4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVwVz8+BcIN3KQzYL0T61UR0CN4pqzaZvZ7nMwtgm1U=;
 b=dMXIANU8Bw0xIY2uyVCJiK3N2Qa+cyvHLZl86P1bVOZZ3KUlnVad/sahS6JDHl6132msJGeBmkk+cNJshCGW4HWVifPW2BF0zzvSzyUBxj+5DqhKhXneO90PWDxZs92xoMP+XXiLxaxLe95PBBplFOU6dXF7AwNNMGN8K+wR6ZKX6IC/bJoSxJlsoPLgp1JYugZwHKztjHxUGePMg1c1HNiLGMD4lcJQAtaj14LHqoQ5cp7YcxUhPs1Z9d4gb2asQKNzMju8BKFlxyI1BWYTjjE1kegOK1kLyZj0PWllnA+fpHTO5TNuVT1ih2qJGnslMTy3lWY+TBRkU8HXrxa1zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by GVXP189MB3428.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 09:56:21 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:56:21 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Wed, 17 Dec 2025 10:55:57 +0100
Subject: [PATCH 5.10.y v2 1/2] ext4: introduce ITAIL helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251217-ext4_splat-v2-1-3c84bb2c1cd0@est.tech>
References: <20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech>
In-Reply-To: <20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765965371; l=2980;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=/Kqh2cD4SnLglcAVM2G6mBrIOfdjq+IXHsfnbkuRFD8=;
 b=uR14MmPQ5YwaG6UEXJgzY2k99Z+5T6Wmp04ygp0LFNwPTsYzs0b5wcOidIAkt6i41J0iJKVT4
 uJbfW4ilakAAJgEkXmOO2TshkJVvfFTJk0F9/BY5lQF3l+Hn4srAl3q
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO4P123CA0353.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::16) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BESP189MB3241:EE_|GVXP189MB3428:EE_|GV1P189MB2059:EE_
X-MS-Office365-Filtering-Correlation-Id: efb15b76-4622-48ca-f9ed-08de3d528809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGdRSDcvRVZ1MGRvVFdHV2laZDNKc3lvMFVpQmxaekZWNm9GNDJ5WXJPTVVR?=
 =?utf-8?B?RzZOL3MydDNLSHFZVDFiQ3N0WGp0OWhXNVNxTVVjU09OQmpDdnpNTFlaelV5?=
 =?utf-8?B?MVZxOHNlcWRiL3k5anVmeVpJSHJ6NkZCenhhU0ZhTUZoMlNabm5OSXBLZWc5?=
 =?utf-8?B?UjltOUxHcjJqbzFaM3BSc21Cb3ZZTlRIdHlpNy9kTlFWM1NzbDlHZHBUK1Fn?=
 =?utf-8?B?VHFXbHdVVVIwTWxnLy9FcTM4V2JrV1NsUUxPN3JxaitiNk0yTUNORC9GVHFm?=
 =?utf-8?B?Nyt5eVlHTjROM3ZYN09XVkErOUovelZaUXhMUXlLUStncHRmbHh5YmtIUzU4?=
 =?utf-8?B?N0dxTXpUSC9xYXlRMHJ1UFowdThKcXhtem5ZbWx2bDlMdGFCZ05vVlhENkl4?=
 =?utf-8?B?OEFLaVpaa0k0VW1ESFAwdUozRmdkTC9EWjRwcEhSSDJmaE1UdllJT1YzYkFC?=
 =?utf-8?B?NlIwcEgvM3ZOWnF3ODNhKytDZVhBWU5DZmVoUmNBVFNkbTg3Z2xuelJhVTl3?=
 =?utf-8?B?WHFSZVhEcnFQTmg0YmJzdDdHS3hJVi91ZDNhZ0FhREFkRjlIalpTT00yOStM?=
 =?utf-8?B?NUJadVR5NWxRcWM1eU9vb3ZpYnc3OUZqM0xXdFE4R3IzWkl3d05oZ1duZE93?=
 =?utf-8?B?aVFaZk9vaG43eGwxb2txNXc4Nk92VXNVNHJUeW9EWVZia0o3WE9VclRDYlRi?=
 =?utf-8?B?UW44QXdSSkxkR0txSnFVcVdoUU40dFkvRnZ0NmExSENoNkFuQTNVdDVvZXlE?=
 =?utf-8?B?UlU2T2dJc01IS1Bsa05yd1k2b0t4N1VBZHRTRmFkL2MxN0ZJejQvRGFLQ0lD?=
 =?utf-8?B?SkFtbmhBU0E0VXk1ZHJNWnFvcktndlFWQnRNc281VjFZMjB5Vnd3cG1NTXBx?=
 =?utf-8?B?VHRUSU1od2lIYUk1L0RjUithZUdoMEYyT3RPS0FPd1NYSUpQR29RUSsrNUhT?=
 =?utf-8?B?c2RGMnhOMWxqQTN4YjhYVDYyaWUwM0NIVVZaN3Myem93b2k1YU1CdW5QRngz?=
 =?utf-8?B?YUFWOHhmdjduK0lPSkluNWZxOGdVSzgwZWxVWjVCczFrWjgvSnlNYmRFbVhT?=
 =?utf-8?B?c0RTTHcwY2FkWEVWUSt4NXVFcDNpb1A4V3ZtU0d1cjZmSDIzbXd3cm5JbThn?=
 =?utf-8?B?WjVLanViZnR1OWdFRHNBMFNWYW5NbTY4ZWE0Q0x1QkNNZ3BmVkNqS01SRFpR?=
 =?utf-8?B?b1NlRUxyVTFrSCtOUWd1RWt2eHFsbkh2a0lmR2lIS3V2M3B6Q1hWSmFWUlpr?=
 =?utf-8?B?TXcvbnIybEFJdHNGMFMxSy9wTWtpQ2tSKyszSzlyNG1EQ1Y0eU1PUnpTbXd2?=
 =?utf-8?B?ZE5OQWx4dytndHJ4UFpSWkVacnJyaUV5ZzBmb2VoRE4wNUhIUlUyY1h4NTFs?=
 =?utf-8?B?bGs4YVVQQmx3dGxhcEY5ZzVWejAyWjFpYUQvc2N3bytHMHlsRmpOMXpjR2lY?=
 =?utf-8?B?S1I0QmJzbVhBb3ZVellZUXdFYmZWZTRnb0NYQ2ZMR0o3bUV4eDFzYS9tOXVa?=
 =?utf-8?B?dWJNaWIra1hNdjJCVFp3THpFSk85dFRySDdwNUkvSFpZdGtoZmZHZ0t5clFp?=
 =?utf-8?B?TlFBZ0l0SkMzMXNWbUtySkgxcHA0bHo4ek9kbElFc3NqcWY1N3djdUpqbFRw?=
 =?utf-8?B?dmN0TDFEYWppbi9raUp5cHlDWXMxdjFaem1peXBoTDYzWmtZeHZ1OWVhQXFZ?=
 =?utf-8?B?Qm1FNldTTldpK1hZQ0ZyNWhoVDdweENWeW56L1crVnRpZnZvcXh0T3pjdGF5?=
 =?utf-8?B?TEE4TUJVcW1XdXNXRXZXdXB0MG9leStadGRTc2dDWnRzbHZmV3ZDSTRnandz?=
 =?utf-8?B?ZXY0amo3ei9lWGhWVUMxRy9tam5ucmxiVTVtYWFHaWkxOWg5WHFBSUR1Mitt?=
 =?utf-8?B?Wkl5Rk51YndXa3IwaWZjVFF0Rnp3UmdRMWNXeStETG9pTUE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UkZwQkM0RExzbHREbUhpdDZHRnA4eUpaR2JpdjVwRWRWMFpqVExWcGpvTW42?=
 =?utf-8?B?dzM5UFR1cHhPT01KNWRJaWpIcldNdVp1WWNSVWVvTDhmZzVVcTQzRTJsZFZO?=
 =?utf-8?B?UE5qWHZENUR6T01YVUhnRnp6RGZwT3I5dndGUlJWSDF6Wm5PZ1pvMXlTNitN?=
 =?utf-8?B?eGIrWUNYTEpGaUJEVFpJeU01ZmNXRVdGZ1VUUnpkZXk4Zmx4TlF1V3pjMGlj?=
 =?utf-8?B?TE42VEtWTlhhSC8wNEpOUjc3aDZreHBDQk95eXBpQXJWd1VBQWFQUGlnalA0?=
 =?utf-8?B?a1RwM2p6L2d3TElFWlBHQjg5Y2hXT3dVbGoxOFhZeEd4eXFnazhJTFdNUzkw?=
 =?utf-8?B?NW9MMjg5dUxMZ20wU3d2SzJnYU1zLzZ0L3l6WnJHWHIzZDFLNEpWOGp3eHlP?=
 =?utf-8?B?NjVPcGQ3T1lCaCtHYVoremM2VWlYSXdqaEhtTjkwdW1LSGFHNHVWZHhFc1hO?=
 =?utf-8?B?Mmc4d2xNdnNxcE9SQVd4dVd0TEc3Q00xT2I1VjJpZmVXYTFMMG5iaGFRenVj?=
 =?utf-8?B?R2xHMmF4R3lXaEN5M1QyajBkbTlEQ0Rqc0FsWHNpRzZkbDBQaEpkRkJTQ3pD?=
 =?utf-8?B?T21OQ25zWVM2TmYzRzJLYTg4SEEyTEpjYjJqL3hVMXhXRXA5ZC9MM3ZYM0x4?=
 =?utf-8?B?b0RFeXZBZHFLbFJEbWsrWDRNWnAzT3V3TVh2QW5LVkhjVXFjcGVEeHJKajVl?=
 =?utf-8?B?bkFRaXBVbWgzc2NZYzZLWStBaXVSRDRtNkdOUDRNZHFXWVdvTkhjbmR6ZWJW?=
 =?utf-8?B?b2VrcC9tdm9Cd0NWQkJWczdqWnZPZUwweHpTc2dlU3JsQm82YzZJZlU4QVli?=
 =?utf-8?B?dGVxd2RRWExTUWpGVXY3dm1mWndGU3lJdmlKMGRsejZ6S0tHTjBXUzZHdUcr?=
 =?utf-8?B?UU1URmpNLzUvS2tZSS9HV1RpUk9TQVdySXEvSk84blNwZ1pka2FzcEZaVFVj?=
 =?utf-8?B?UlVRQnp2NDRSMEViYmlEdUttRzExYm8zQXc1aFNXV1AyWTBxalNnYTVNcHE0?=
 =?utf-8?B?cHVkR2U3T0pYOVBVeTVIMzR1U092dlZXdDhaT2NwdmcxUWxJVndWRDhCdjBh?=
 =?utf-8?B?QitnOTgxYjlOYkNtSU5hNW9zNHFJbFlRMUNiU1JxczE5eFVGR0NYUEc5UG1k?=
 =?utf-8?B?SGd4cmZib2thVlJuS09ocDNjL0ZqWVl5SU10M2RyMkFZek1iajlKb2hIdFZB?=
 =?utf-8?B?aTJ5SWZhcTBNNWlnWllPWkJxZkFWNEFkWm9uVlFHcEVrQW5mYUErZEpqbW1S?=
 =?utf-8?B?TXRLeVlNWWRUd1JHZFZhTDdsZjR5SDRlVVdQNlZtdjErWU5obWpVUXgyTG5X?=
 =?utf-8?B?L2twdHkxN2Zic3ljL3ZVVFdEUHVIR2pHems2a2VhOWNjWVpFMXltamxqdjQw?=
 =?utf-8?B?My82bVUyV3M0WE5UUldoSlVoYmJqSGphVVYvemRHSTdtejFja0xmaFdTRnpy?=
 =?utf-8?B?K2ltcFFObG1WVWJ0dStKNEg4TEgyU2FUS3Z6OVIwcVEwbzlZU1kxYmJRNi9F?=
 =?utf-8?B?Z2JqMXRkZE1ORUltTzBNbXc4MDFxNk9FeDZUdno3a0N2RUU5aTJQaEw4bENZ?=
 =?utf-8?B?RUQ4cXBLZXowci9vSkxMajJ0OFhucWUrK1lFaVNxQU1uUmI0UE5Od2hvYVVB?=
 =?utf-8?B?WnNEMVVzbXZzRDVSY1g3dEdsdDJDZlk3aGpoWjE0ejh1VFNJOVBTTG9HZnph?=
 =?utf-8?B?elBxWHpDeG5tVS9pZnFDdHFXNlh5VG1Wc3dsemtWVDdYL0tWTXVTRHFyRUFL?=
 =?utf-8?B?ZW16dWxnQWpxZm02VXIzaisxWnpMSUV4K3kxWWJ0YkRwcjhSdWlTMEtOcE9j?=
 =?utf-8?B?clRnSnhLTXk4cjFsUTZRZWVwWVdVeldncFJQMXNoVllwdmJCOEpGcEU3M3Z4?=
 =?utf-8?B?MitTYUxKZ0xhWUVLODZ3NS9PbTI5MFV4eXV6RUtKQjNGbmNYZVFRVXVyTFFL?=
 =?utf-8?B?TUVISU1LVkNham1zaDNHYUlnYThNWmFucGJCdlZrSDhPM3ZhR1AwQ2FNZUJs?=
 =?utf-8?B?dWU4bU5OL2ZOMDc3aDVpWjJSd1UwM3loa0ZwdHBIWEFJSFVVdmMrWlFTemRU?=
 =?utf-8?B?MjJVQmwxa2dNbjZUdlc2SENYblZ1bCtHZUpzMno2TTJZL0MyY1dBczVEVzJn?=
 =?utf-8?B?OG9zRlBMSDZTd0lLTGg0MlJhbGllS2NDQjR6QjFNYmxZdTUydmNDc3RJVjgx?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efb15b76-4622-48ca-f9ed-08de3d528809
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:56:21.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q71s4y/yFQiqIMPGDzOh5GP5r3W72OCiMNo6x9VfBCZ5Ul2yWlXmIVDrRc0V3PsNkmMhppS4s0IPS7J9raj1rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB3428
X-OriginatorOrg: est.tech

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 69f3a3039b0d0003de008659cafd5a1eaaa0a7a4 ]

Introduce ITAIL helper to get the bound of xattr in inode.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-2-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/xattr.c | 10 +++++-----
 fs/ext4/xattr.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index fa8ce1c66d12..73a9b2934865 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -599,7 +599,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -744,7 +744,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -826,7 +826,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+		end = ITAIL(inode, raw_inode);
 		ret = xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
@@ -2215,7 +2215,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
 	is->s.here = is->s.first;
-	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
@@ -2739,7 +2739,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 */
 
 	base = IFIRST(header);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index e5e36bd11f05..9a596e19c2b1 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -68,6 +68,9 @@ struct ext4_xattr_entry {
 		((void *)raw_inode + \
 		EXT4_GOOD_OLD_INODE_SIZE + \
 		EXT4_I(inode)->i_extra_isize))
+#define ITAIL(inode, raw_inode) \
+	((void *)(raw_inode) + \
+	 EXT4_SB((inode)->i_sb)->s_inode_size)
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*

-- 
2.48.1


