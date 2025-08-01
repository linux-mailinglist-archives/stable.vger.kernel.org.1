Return-Path: <stable+bounces-165736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A3B18213
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA634E7A2D
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63D722069E;
	Fri,  1 Aug 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pqd6n8kZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E251798F
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053399; cv=fail; b=LhO3o64PJc6qkd3n++PBNPZhMfgQKxmh2b7y1no3jfpUUbj0HpmpAMc4AtfEbQlqF3l4VbQZ/2ul1zRi03d1trTagee8EUbc2yQhXM3tQC0f/II0SgOrJp7iDmgR35lQMbMTBN3gxwFG3HX4Vk1g8upyslEH8btUYhpiTa2ILLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053399; c=relaxed/simple;
	bh=k1+d1FlW57kV4DZH5nGqrakfH7wpLsY46UoafaEHyLc=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=U7LtjgnxIVPMd0N5Z4+DBf6FFDonWht83WR4ymlPNQQwa7NuHBswlDySfzQ4bLG7BuWl4N23VnYPKQpKDVtbAR2Wo6VWfdJ4XhFe1j+A2vUxjMmqA3wPLfVA/ErgdtvCrIHqqjXX9W07tXsB/5pMXmEJPkd4xb8hgeTgPuYnSyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pqd6n8kZ; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl9zHKfzSAcjwXkyjBNzdZZ9BbIwfato7FwX0JEzWnGZTrRixzEJFIibiNMo2lKAMo9fxLyDc/PDTQ6dw9w+jWtWiLcEpMAHt/xKGwu18ancuORQCpQK10k0GS89v2cM91d/ELEs/XPfvlglncakU9N0lWog9gSVv6rrmkeEobK90VnHUEB0k86Cvt0ouj5bJkV8UeLfQ+innfcLt8lfWeekrD6+SGyUQBIJkt9ugsj/QY5/kmm0G+T0fZ/OF8QJ9MoOwAaUhRtQHLXuRca3DTEXCmjhvkkN/LObbI9HqUnU+LKDBH1GuWWrtifHxn6JW5HK5SiLe0HKtUIgYJd4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJIcYpDyStqzba/M6bJ6dT8FRd2vKWUyvh5maZ3n7Zg=;
 b=zNZuCuLU95Lo3kPd3adMSy0mgWUcAb5pYDVi6TtIuelRkY+aUwttXZ6ZzvkhAj5kuki4cq28ezyRq2trIogECFyCFHwca0ZPuUND1E1oo8XpwIOBpHsht6dTndnSKj16kEa6FQCGxsb9HmPrPzZKYw4muvE/70VuKX7A4d6gxpR4Kv+OzDxXPXijIFHSJsewaIk9yLyG4Mo3reCpK4Bw0otgwxQ/noyog2uK3O0YKeeD3Q7IXetRAIR65BLBjwwCKXApK8zqu1nRlfEPQFPFkpPBX9FiaFDPnfW20RsaV4ucQQeaIR7byvPLo44/ERGBeJPHHg31o7mqN5JgMtXPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJIcYpDyStqzba/M6bJ6dT8FRd2vKWUyvh5maZ3n7Zg=;
 b=Pqd6n8kZCh1p0Xcxqildb+H1DO/oOwIJ1qP0rlRLgUuo3JsNIgR74V5gOfwOIjSngfDg4Jy2Mey3WAhyzqTvammnFifA+0VYePgN6OAwLSMLKI8jtIaeafPAxbIZSNRuMq9ARZfZ/2jUyizZMlzJLtwojIP6hgOv0NPOOr16F6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 13:03:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8989.017; Fri, 1 Aug 2025
 13:03:14 +0000
Message-ID: <9469816e-6ae8-476e-b154-28c78a79bac8@amd.com>
Date: Fri, 1 Aug 2025 18:33:09 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Adjustments for pinctrl-amd debounce behavior
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2258ee-a5f2-441a-5076-08ddd0fbc681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVhQZmpxYmRsVjFHTHdaVyszcGV2cEZrcHk2aUY1Y0s1eUdReXJtZ1NlSTNt?=
 =?utf-8?B?MXdGZit0MUNZNG5sam13dWJsZUlVV05kVS9JYjN6RGRPbVNUTWdKSHdDQ1Uv?=
 =?utf-8?B?eXdGb2t4MnV5WjRKQkVZVUVUN05ScDIwZE5jdmUrWUpDUE1pRkQzd3F4VlV4?=
 =?utf-8?B?YnVYQTVhTEYwT2NTN3c3OUQ3dDBSNWtVcjFiYzVFNGZoeHkyQUJlV1hYcTRY?=
 =?utf-8?B?OWx4Y2pUQUE2T3pGZXplZ3Nhbzk2SitoTFA3dERvMXhyb1lVRzE3U3N5Y1Nm?=
 =?utf-8?B?WDNJMUxFZmRqY0tkNmZFZ2E2SkFienFPZjkrRWFlV252V3JmT1piYmpoYVkr?=
 =?utf-8?B?ZHk3MnJRWjF6WkxaVUJWZ2k1MkR6c0JXNTVrZkk1RXhVNzNJRzRkSTZwOVlZ?=
 =?utf-8?B?SVBGcThMSFNwbnBBb05UYXlWWEQyOVdtdDlsS0ZRWE4wdXZFZjJId2UzdDdJ?=
 =?utf-8?B?QnRJUE50aVF5SVV2YUdVemdiZE5VTzFrUXkxeGI5SisvWG9OZXFwZTlsUWR3?=
 =?utf-8?B?WmtFVFQ3OTJtbEZkRVRjaEhkY2FZRUNibVBlandDOEE2enM5NTJKdGp0WGVT?=
 =?utf-8?B?QUtoK1RYYmx4cmZsNHV0VDEvZ3NtYnFJdlEzeFdoeEdyUVdCMlJhczU2eitP?=
 =?utf-8?B?WjY1WnBack9aL0ZXcmR0NWQrNUxYcnlKdzhUcEdSZDhucWpXQ09JMFQwUmI4?=
 =?utf-8?B?OG5XdmlRQkwwN1lZcGFoR2RXeHZLZE84YjFwWStUZURVaG1IQmlBT0l2SG1Z?=
 =?utf-8?B?UDdYVDFLSTdZWk45VWpNMGhkcnRNS2RMMWNUV2lETXNVSzBZZjNCbTd0UEE0?=
 =?utf-8?B?VWViS3Y4N0czRXB6bHRPclpZN3lML2c1ci95ak51ZElUUkR0UXo3N1hkMkhr?=
 =?utf-8?B?dHFzOVViUFo3clNXM2UzOG1YZUdFUTY3Y3IzTlFMQkc2OXByN0lNSEZjamVT?=
 =?utf-8?B?WXltUUpMa3lMZlN3cW5wNTBHZ2FvMkNmbk16RWdUK3lza3JNWWhBMlhPYmUz?=
 =?utf-8?B?VUlBdGl5ais5OWc5bzFEM016eS9HWGswejlsN21MU1cyNFJ3SlZILzhKazZ0?=
 =?utf-8?B?c1daUUtseUJoRW1RVHZ2RFBPM2gwWUxzSUZpV1VqV0hFWExsWVRMQnZzL2hV?=
 =?utf-8?B?S3UvUjBtMmIvd080TVMyWFJEUWMzck5yQXczM2J0QVVSTWp2N1hUaWRMWEZn?=
 =?utf-8?B?OVB5S05jQUkyLzlNUHI5ZkdFSlNsdlRHcVBGT01tTnhQci9EVlJGbXBjWnZS?=
 =?utf-8?B?RS9TK0hreTVWd09FZVNVQTJlN2pkejNORmZYMjVycmpkTmJ1UXU0OE1idXFS?=
 =?utf-8?B?U0xOVGgzVU9aWXRPOVRIU3VzN3UyWU1tRVc4V0FvbTlSUUVFRGdLZE1iZlly?=
 =?utf-8?B?cXYwVGRicENuaGgrSjZKUHgvNXlKZXVmSFovbysvbXFYRUFQM3hoY1FNMk9w?=
 =?utf-8?B?WlZqVnhiNS8wOFQ4azdQaEJGWWhHRGlOcTBwSUxkWFBUR0FaK1BSb3ZHV3Rs?=
 =?utf-8?B?Tkhza3FtQkdaTTJVVzF6VitMalZmd2xJcEJYZlludE9ERHhUUCt1QXNpOUpJ?=
 =?utf-8?B?TEFMRXhLa3A2Q09MSUJnMGoyNkh1Y0t6WERES2ZUZ2NHZFBKcWgwQkhoTmVk?=
 =?utf-8?B?ZGtIaVJCL0RqU1Z1UXI5Y3VjSjZWbHZWYkxFZjFLMkRtTmlaTmEvL0s0SEFk?=
 =?utf-8?B?SXFLTjlja1I4Vis1VTY5QVBmdHBNVGo3UnhtaCtVKzBjcUExb3E3WS80QkNW?=
 =?utf-8?B?Z2xOY0dGdDlUZms1MkxnMnN4N1JvMjdoeFk1aDVYRHl5Y3dTRzZsL1hJb1Vi?=
 =?utf-8?B?c1EyNTYzRFFjWDI3UFVFekNkTFVrRVZ6ZkdJUzd5SG5QSXFoem5TWTAzREt2?=
 =?utf-8?B?UXRoR3FVUW9qcEtWTTZrSGozNzEvVTZianpQL0RzcHVkT1NucExpWG5XaWJK?=
 =?utf-8?Q?VMUcdIac36s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlZvUGl6NkN5ZWR4eG1qTXFxNWFsdWVuSnZpc25NY2VkSkpkbUxTWDJ5a0dF?=
 =?utf-8?B?d1F3blU0UWZrSHQxRTZ0QU56ajNaalgvWUtrL01DNzZ6Ynd5cGdabWdBbW04?=
 =?utf-8?B?ZVpBeGkwK1MxQXBaQ0pncG5LbmwzUkJNdmY0cWpoYy9iUldVVHk1RXh6OUs5?=
 =?utf-8?B?N3krQklWcHNnNHk1aGtpbERKODJDdFVOQjI3YVZ2VDZqRkRBdnFNZ2NJYVpn?=
 =?utf-8?B?SUlMcTVFL1R6cnNqc01IblkvUHo2ZjJ2TWRnb3cwMHU2R3Y3TlB5YlloQ2Fq?=
 =?utf-8?B?dWNWU1RXS21SeHIyNU1may9rellnRUlET2E1VVg5eFdYU1dmNlR6L1Q0N1hJ?=
 =?utf-8?B?MnRBWFhCNXEvd1Zjc2xSNlppUzU0R1NMTW9iY2V6V291dHRhZ1V6aFdpd0RW?=
 =?utf-8?B?QnQyc1FkdE5WbEJ5Q0p3WHR0eDU4dVBYYnVoZ2ZPK0l5NGtBYktESmtiYzdu?=
 =?utf-8?B?Tlo3L29KUzVtSjhnSmFGSE9PQXM0WVk3Y0d0MUVWWEREcFBUS2hmblRKdFZU?=
 =?utf-8?B?Tm44UVVtVUNIdDZscTRlZW1yUTMyb2V3YmZNa0d1cXdWdSs0eThUSmtkVjA2?=
 =?utf-8?B?S2dCd3h3aC9ZZy9oZ3o4YmZMMlpLZndWVGxHcEN4U0cvZXQ5ZlNxcTNxMThh?=
 =?utf-8?B?MlE1T2F6b1pTS3hJd3RUS2E0NHVTNm1zUW00dms5dzNmTCtWOE5zTUxFbURH?=
 =?utf-8?B?Y0JYZDdhaUNtd21PNkY0ZFFPbHRBOEp2aTJ3TTMvWFZsZDJvV2hJV3lmZXBZ?=
 =?utf-8?B?NG0zQjZDQU0yM3BZelF0UFBDUEN3UDl0RHpTTmJ2bkd6ZHRYaFc0YXBva29w?=
 =?utf-8?B?SStLRy9udlltaDJscWdzblcvdm5ITCtSV056WEVHTlZVM0VkcUVPSWlMVmhJ?=
 =?utf-8?B?b0xxbzhWMWVPaWFuaXhEV2FvRTZXL0N2TVpobjlrSkUyWS9UUG5wWXEvMXJK?=
 =?utf-8?B?QkQ5bUtOUzBvcDBPQllYZ3gwSlZ0YmdGOGo1UFFDdWVodkl4N1pvK2lLeFd3?=
 =?utf-8?B?OElDUUJRYmpUc1VubFQzdWkvYk5IOUR4RVJsTEtobjE2Vm1oK20vc0hPZnVZ?=
 =?utf-8?B?MDdqZmtSRWdWSStwQm5LYS9xVFhJWFdBRjBBRkVNUXpVUklVS1UrUTlkWXVK?=
 =?utf-8?B?cllad2RvMHFDNXNmdHR0dzBtZW5nSHV0dk15bEJFNU54MkdtRE5VSEZ1cW1M?=
 =?utf-8?B?a0NqYk41RVhzc2dTUklCcFdVQVJiU3c2SldXZkhPcThrdmduN1R4K0RSYmxO?=
 =?utf-8?B?ek9IMnNNdVl1OHNNc1EwSnNEZGhzRi9UWmFyVk0yZisxOEdzVTA3aDN6QmRK?=
 =?utf-8?B?dGlhRzBaVnNRaWtUb0VtaFhNR0ZnRkF5Rk1ob3k2bHpUMkdYWXRlYURVS0s5?=
 =?utf-8?B?SUI5ZTlCOVdvbTcrU25ObFZKWXJvSDZkaS9kT0hVem1ucU9kR3d4NUFSeWVy?=
 =?utf-8?B?ZUFhb0MwVy9RQU5vbmlXdmdjQ0JVSVRYckRlT0JlY1NIaE0zQkNxVlFEU0VM?=
 =?utf-8?B?U3JMYzgxOXhGS2JLOUhtMXlHbVRtOE9Jb2FoMXY4UDRHd05RMnhtQ0lxeUd5?=
 =?utf-8?B?Sk0yYkVxRm1uNmRXTlRQTUtwMzVEZ2I0M2tQU2hiNjRlV004OUF0U0NCV2FN?=
 =?utf-8?B?ZTJZazZURGV3M0h4WWNuYnh3NkR6WVNwSFZNWnR1alJwWU9vMDZudEwrMm44?=
 =?utf-8?B?a0ZId2dvVWw2TVkycjFZNG0zY0txOWQ2TEZ6bzlZMUFKTFY3V1pnUnE0bTlM?=
 =?utf-8?B?VkZha3pNTTR2SWQrMmxsTHNYMG4wZzZqYnRTQW1raUZQNHlQS2NGZ2dFL3Q5?=
 =?utf-8?B?UVdVbU8zWUd1cTF1M2tSV0ZETjRYUG9rWFBYcUVWaHF6V2lYb0NFdmNtVG03?=
 =?utf-8?B?T244T21UeUpnWnRMLzhmajJXY2I2MXY4bzA2T1RraStoS1JyZ2VLOTNsazRv?=
 =?utf-8?B?TmlvS1VLbC9hOTh2STlsZlZlRmRGRExpMHhIRTJsQXQwekl0THNmNUQ1NC9U?=
 =?utf-8?B?eTRTeGpjamtRWGZWbkwyaHlXSm1jLytwUGlka3VlOWUwY3JaSllNVkMvbUpl?=
 =?utf-8?B?YlZCek9NTjFUZzZzL3NIZC8zNS9vL1loWmVQU1ltRks1Qk13STNYbTR2Zi9i?=
 =?utf-8?Q?90tiXz3CXiLUZprJuY1UZO+os?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2258ee-a5f2-441a-5076-08ddd0fbc681
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:03:14.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYq/QhnOs2S7VfZhv6zeLTTbjvMN/T6ZN1M0Ex09nyENi/SfMoAIUZJzdWc0UvbshUUeeCIZuMogApL26VjpoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

Hi,

The issue that I originally fixed with

commit 8ff4fb276e23 ("pinctrl: amd: Clear GPIO debounce for suspend")

I have found out will be a problem on more platforms due to more designs 
switching to power button controlled this way.

I think it would be a good idea to take it back to stable kernels.

Thanks!

