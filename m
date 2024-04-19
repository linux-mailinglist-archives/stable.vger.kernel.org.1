Return-Path: <stable+bounces-40315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C28AB4B8
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 20:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AA21C21DE2
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 18:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1C13B5A1;
	Fri, 19 Apr 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqK4xQz+"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456A130E5E;
	Fri, 19 Apr 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549879; cv=fail; b=bqlYlscmL85Cu5rjGG8tAG6qI/BKiauVnXnRP3s1ZXOCyDzH8C091rEr98AB2XJ75Kz1VG5XzwTxgr4uuYlaickcALrqaNS0CJLgvI2oGxse3xj8rL7vjhGePeaw3/44XBAAD0hHm/K99jTcEeulcWYvnV+z6J6lPvg+7VLjGMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549879; c=relaxed/simple;
	bh=1Q9mUmFV8prQvcPJewMsmclXYvVhSJHJRmjQHdTXNj4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ksoldImkTCjRstLrM5OYOhJu8qmJ5gdi559Oh12ojlVZ2Q/6141t02FLDH68DgtNB7GLjFnrCNFIwXQR3SqqybuDEdjhaAUlMCydCq0t6EZHkAHqK0TNdjou3KglXvkCQbKT/1gYW74YOPrMUPfr7sT+KBO5clcWQ6x1yOzJtWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqK4xQz+; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gedOhjvRpxuEAIC+DCN2usYquo55uzwi+sjPVJLJWBYp1bngyva/FWJicxoHAAwcACDPQAwXZkLtgf4w8cndDn4mfXzYUtEN6Sth7xriQVkbCaorjnTTSnjO96EeqgI+qCEZbvE3VESMXoF/77SMiLrJ1U86HRO+P50rvbWu/OUg9d5JwP6xcAI4kG1kDqNoKPw7fRZxoSvlm8xAl5ETQcOpfM1JMx1hlqlQlc9nuKhQ8ZmJUfJlV8LDUHCupOSfXOfzbq7MBJlnIi61+ILx2kE5uPy/AOM/EVOe86Di6Lr8f79ra8Vu8dnqvajRVmljFQVGZkTiTxb3/V+RbI21aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8/VcuV4s257xRep7QS3OomL+Fy5JTcIuQ5hi6W/8/8=;
 b=YqzvvZbe64JZ4oBJxtUVH6+mVaR/baiGkS9Z8k7XRFXkeTTjT+av6oO0zPuysiwF5s04jGGg/fByoNWPi/qpT6gW9kly+b8rOkmeYjqvlu3G0kKcs8r2NTV69jz6LqEBEyFs8Ci5H6/3zV93NPa310XszcbmEeVG1g4UdiItre6iPXgQRqND0c6ZJO0l2py7OoOZc0ks40/gIPXwA5MwSCUTmTNLLh5AjN4RK6kBEKUuvsVv45UfWQK/qMrJoRLcRaq8Hv6X5YW1ZSqJkoVHdg9UBxg8HEs3EMdpHvAX5DQNIlkIbGkfSLcng6so5x7rcAYeQ9/5AhV1B339JjGaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8/VcuV4s257xRep7QS3OomL+Fy5JTcIuQ5hi6W/8/8=;
 b=hqK4xQz+t+05BlSDpLGWLv8X+WNf2w9WplrLqvkMN9tb1weNwS5TuQF2uB2EJO+AQzC0vGzKbRvWJvndkrSRG3Mk+XRYbq6iGhUu6cIDFuqujrkqLYrVuoj9Ygrl1Deayr3HLsOeybcISPgX4EAwV3qjfr4PKsLIVnTgPVqQfj3OlyVIuFom7CsHWyhqyzvutbLn7YvZYgiB1wktjCS5029jG13uZ+EI5r8cvGpnwkSdPMNPIVQwa6UYQpmBRjOKgwL7lyL04uTVpz9oqJPoDLWGcVt99m/H4i41BzcFcoN7iapqoEnuhU7C37EpMFPMmNiaZ3ir2E7bJFM7YdADww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 18:04:32 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 18:04:32 +0000
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
 <ZiKH52u_sjpm2mhf@hog>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Yossi Kuperman
 <yossiku@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 0/3] Resolve security issue in MACsec offload
 Rx datapath
Date: Fri, 19 Apr 2024 10:56:20 -0700
In-reply-to: <ZiKH52u_sjpm2mhf@hog>
Message-ID: <87jzkt6xg0.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bace4b8-7d19-4930-a547-08dc609b2a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q214YTBvUnlVWlRXT3dYYkVyVk01RUV4NkgyQVBucVNNWWxoZUFMMHVoczA2?=
 =?utf-8?B?SGRGMzRFNmQrMHdxUFcxWFdDS29ETVpRZDBja09GQy93NitBUGRxVms2NU5K?=
 =?utf-8?B?ckwrWDJmS3NHVG1TNXV2T3NOOHAwSFpiMVlJbFlxMURnaXpPK2dKZkRvTU8y?=
 =?utf-8?B?eTJVRTcycXR4eDVvWkpmd1IwQW5hcit3cE9nRGlnSlRnZG5KVjNGdEZSdW5v?=
 =?utf-8?B?NithZG41dDAxTGVxcDhpNjJBdlQ0ZlRXRUVJQ3BlSEZaODNGM1ZaeTVHckZC?=
 =?utf-8?B?b3JSMjBFdUl6dVVpRUVxV0Z5YW1RRDdJT2VpK2tSMnpwWU96L1Faem10aFBP?=
 =?utf-8?B?cVVhREkvSlZmV0ZhOUsvcEY1UURMRFhndWR3WDU5ZUY1SENKeldvZzY4WW9N?=
 =?utf-8?B?THBpRDVicG5RN0QrN0dGWjVuVEl4eCtvdHZlVm9INXgyTGlhbjk5Zmh2c3Ur?=
 =?utf-8?B?bnJlOUNyYXdhUEpJZ2hDV0IxN1N3eG9nYjhDTG5UQksrQjFGeHBTL1pVTFFq?=
 =?utf-8?B?YytVVmJrVzJkT3NOMmhFTEJuZ0hjdU5heW9lenhiNGd5VW4relA5bTNmQVVk?=
 =?utf-8?B?clFMQnN4NGdhV283Ujlnbi8rZVY0ajRQTEp6dnJGWEQ3ZklVRnhTc1puR1dZ?=
 =?utf-8?B?ZGtzN1BndTRNc2ZCTWRUUWFKalhxcFE0Q3ZFajNEcEJwaGJxcEQwQUJsL2lF?=
 =?utf-8?B?TE9QbCs2NFdFVGR2L3ZNSHByVENCYUVDY0YzZklKS3ZoMDkrNFNaTWcxRFFC?=
 =?utf-8?B?cDZMbFhMTnFaVlVUam4zdGZqL0svL2cxUllyR0FFNXdFWVp4TjdYbEwrNlRT?=
 =?utf-8?B?R1loWVZBQW1ZQUtsSGd2WHkrL3pEclNsS3YrOFJwN09MdHZxSGxGUzAvdHBI?=
 =?utf-8?B?NVRuS1NiT0dSZnQyNVlOZ0NLVkZBdlU0dm00aDFwUnJRcjRSRVVCNHoycXlG?=
 =?utf-8?B?eEg0UitWMmIzY25rcUpuLzRHSTlQS3Q2L3VUd1prQTJlSkdsajZBbkJ4eEQ1?=
 =?utf-8?B?anB5UXFNZExCS3VTZUU2UWhHWnVjTzhXeGxvdnF5aFovR2hiNjluYm90bS9D?=
 =?utf-8?B?VUxHUWtSWndndUUzeU5PSzhybSsyYzlhYkFFV2FVSUlmWXhObTg4aEVuUGZp?=
 =?utf-8?B?VjBGdTFSQzY4d0JqYk5Hckx4RzVNU0Jwb1oxbEZNdnp6c2J5R0pRK1lsTzh3?=
 =?utf-8?B?aHk4SFNHMzJ2SEFYVUx5RGw3aW5ybGxORFZRMlpRSWtxTmdPbmRFN1gvdlJ0?=
 =?utf-8?B?MG5xWVpjQURoWm0zMktGNVloZGZaS2xEeXZzNmRhK0dBSEQxclduRU9vclJl?=
 =?utf-8?B?T2dObWdTcE41aDVQcTUzWXhQS2RZZFdMVTJsK0MwVnhQaW5lOVZOOU9kRkN5?=
 =?utf-8?B?elRZd1h5d3pzeStaVVNGSmFWd3BFUVBYd0dvNGFwM2dRM1pjRDlvRkhBbC9x?=
 =?utf-8?B?NVlPbUoxeTV5ZzJjZEw4TEh6Z082MGEvYkJwMExsWmZYVGxFZlVXWXcxbzE3?=
 =?utf-8?B?bWdnT2g2VUJ4T2gzUlhTNWhJY3FMa1FOeit0bEIrak9TMWlVUjhoN08xVnh0?=
 =?utf-8?B?NlJjdGtMaDlPWTN1Nnlab2pJcVlwc1JNRWl0RDlJTFZ6RTFMc3Q0UURnT05w?=
 =?utf-8?B?RW44anlvTE5tQi9QWHdlODhTS0kxbmpPRVJubEs3ei9wNi9pUDZKb3REUThS?=
 =?utf-8?B?V0J4ZWJxRlhaNmdrY1VBN3VSdEZqeXRXeEhYSnYxUW1sOVpUeGViMlpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVR2UnVoTTRHYmNsVUZsOStIMUJXbVZrUzdlTENnTWd5MVBoNGgvb1l4OUtQ?=
 =?utf-8?B?SVlOaWg3VjRJL1RBblRoYzBXcmhYYW9zVDhudjZueGVzdmxKZnRHZ09vdU5M?=
 =?utf-8?B?UDBWNXAvWWVLTzd0YktTSThXYVJyZ2tWRkFOWGlyR0xBdzRYY09qeGVycTVI?=
 =?utf-8?B?VUR4Vy9idTJRVzVlYUFqalBTbitMSVlUZ2tjRG40aDlNMHEyeko4RmxQVjRH?=
 =?utf-8?B?YnAyVTZnRWwwcS8xWG0wRGhJcytrZktqZmN2M0tCZ2NXZDFHcVF0RDN3VUx3?=
 =?utf-8?B?ZVVXTWRQYml3Q00vRUU2eW1sUUNsbnZuZlp3K3pSdFd3eGl2cmZVYTNqd3pT?=
 =?utf-8?B?UGsrMW5nZ1NqaHFKRklWQ1RnYVpYWTJqVTB5LzBYdkQ4NUFOZEYvMGNIWmg1?=
 =?utf-8?B?RWRSMk81Mm42QkFERUMxU2RIV2tBSXIyRTRMb0JzOHZSY2tvUjdQbFdsS05r?=
 =?utf-8?B?Vm5iS0VQSldGNGdyR3V4eHNQNmRLS2V5QzcxcTlDSSsxT0xFdFhPTjI3U2d1?=
 =?utf-8?B?R2k1V1IrSG5LTE5MNE9GanBYaHB4MldGaWNCNHBRcjVkc1dtODg5MjdtU2Nu?=
 =?utf-8?B?MGZ0VU9SSG1xVkFZRzNTMm9CMSsxLzVZK0RKbjlHK0plQXVHQ1hNRWcxaTV4?=
 =?utf-8?B?TU8zSHhkVVlmWVZKZk5lcndGVEhTTHluZW5PczJDMVR5eGF5TTZpWWtRc2t2?=
 =?utf-8?B?OHdqQkpPaHRMYndMU3B0dE1Sc3Y5dHhpbFl0d0pwb1IxRzZKck1yZlFxU0VG?=
 =?utf-8?B?TU45UVpZNk44Y25hbWpDNzhDdGF0QjZ0TUFmUnNFR2U2d3FoZmhpYmZnUEdo?=
 =?utf-8?B?aHJGWFFITURMYmw4STJMTnppTXBSeXE0Wnd5QXJQNUdUZHBaaXZkYXdhQmFU?=
 =?utf-8?B?UnUzWndxeEFCR214bllkZ2hwaFVwZWFiMEtQbXF3aE5VWEJMbkRBR1ZwSi9R?=
 =?utf-8?B?cGFNaWhST3JsemlobHZOZGxJK0hPNmlucWtzK1piQVdyam00dTFIODVUdzYx?=
 =?utf-8?B?WjIzaC9nNXZKOHF5L1VRelBLbEphckhQNDBrZWI0dXVxRkp1QjV0cmFCaklk?=
 =?utf-8?B?ZUpWOG5POEhBaVZ5K3Ric2VyeERJRGU1ajdXZ3EzYmRMWS9yb090WVQyaEFI?=
 =?utf-8?B?TmFEMEZwSXU5SlBwbkVrTHBVZWk2ZGpDV2JWMkpVMGlKVFJndmVCSFM4YkZN?=
 =?utf-8?B?NEl1RjVwdHY5ZHpXdFk4aFlGTmtBeXh0ZDRzUERLUTloZlUvQkNrN2FQMkR2?=
 =?utf-8?B?bDRNWVA3YkVGNm8za3A0TkJMUmRJQmZ4TmxlVmFpVlkwOWdqRWZNdXJjSzJ4?=
 =?utf-8?B?cmwyV1VhaWNxYm1WSjJ6UERZSUE5NDBJbU1Vc1hMRTF1YjU1Q1dvNzRLSTNj?=
 =?utf-8?B?WVVWS2lMUEFrd1l0SnlLUDhFMEcxVGdQMDhsQ1JzcmhKNHk1MUlzREF3bTBl?=
 =?utf-8?B?Y2RJejlYZHlpbENZakV1U1pmekNaZkVEWFZtdndUUW1mNWE5L1lPUVVzeFNF?=
 =?utf-8?B?dmdPY2lFZHRTcmEzUXdrUUtTVHZwQ1c5YS9QelNpMHhWdWpFR1J4cE9NQ1FC?=
 =?utf-8?B?L2hnQ1RNYjk0Yjg2SkF1Zjh4R3hEU2tYbGpRWFdzQnRMZFh4b1NLWlFqcTBB?=
 =?utf-8?B?NGQya3puMndGamVoZVhKZytNL2tWanFzZzJmTWlOcm5rOTZTN2Vxc1lVUnVz?=
 =?utf-8?B?R0R5cDJyclZrRVBKZEwzMG40RHFmVWN3ZDZwMEpUL1JvZm5RTmQ1UlU5SVpy?=
 =?utf-8?B?Njh4dnVQTHlkMFNjdG9TWkRNcCt0UUtwMHVUZXB4cSttNkxJRjhEWG1WeGJX?=
 =?utf-8?B?UmNqdkF5Qk1jRnV2VTVzR2sva2xaYlJvTUVCRlJBbnhaS2tKUTJRR2ZYc2Zq?=
 =?utf-8?B?V1dOOXVaZktjVmg3eEFOL3hkMjBKbTExdkFDYWJIZzFQeE9XSFpCSFhyQjk5?=
 =?utf-8?B?QXBkS1h5c2NxbGh3cGNkRDdwTmdqOXJWZUJFbmJXM29BUTZFaVc0M1lQVWVv?=
 =?utf-8?B?SjFNaXJzRzQ3Sy84K1g0Q1p5cUhwQWRvSnVXSTNOTk1ERnNnTFp5K1ZrMFFM?=
 =?utf-8?B?QktVSGtyQmpHanRpRFNtYlg2VEtqaDBJR1RjakhMRDZkY2V0MERYN0ZqbmtC?=
 =?utf-8?B?NlRvY0d4RmRxeXBCZGVtZ0kwWCt1YXdwcmN0Rkw2dkZvZzhnUDcvTWlGanA0?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bace4b8-7d19-4930-a547-08dc609b2a39
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:04:32.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZxUqsZZFyXJZx3Ma0lHkjclE3FqaIUOF2DxI/Ai8lgygWp4mj7vYpitJPnebdFuzuW/Efv3JpB5eF0ix3CPcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

On Fri, 19 Apr, 2024 17:04:07 +0200 Sabrina Dubroca <sd@queasysnail.net> wr=
ote:
> This should go to net, not net-next. It fixes a serious bug. Also
> please change the title to:
>   fix isolation of broadcast traffic with MACsec offload
>
> "resolve security issue" is too vague.

Ack. It also fixes an issue where macsec should not reply to arbitrary
unicast traffic even in promiscuous mode. ARP unicast without a matching
destination address should not be replied to by the macsec device even
if its in promiscuous mode (the software implementation of macsec
behaves correctly in this regard).

>
> 2024-04-18, 18:17:14 -0700, Rahul Rameshbabu wrote:
>> Some device drivers support devices that enable them to annotate whether=
 a
>> Rx skb refers to a packet that was processed by the MACsec offloading
>> functionality of the device. Logic in the Rx handling for MACsec offload
>> does not utilize this information to preemptively avoid forwarding to th=
e
>> macsec netdev currently. Because of this, things like multicast messages
>> such as ARP requests are forwarded to the macsec netdev whether the mess=
age
>> received was MACsec encrypted or not. The goal of this patch series is t=
o
>> improve the Rx handling for MACsec offload for devices capable of
>> annotating skbs received that were decrypted by the NIC offload for MACs=
ec.
>>=20
>> Here is a summary of the issue that occurs with the existing logic today=
.
>>=20
>>     * The current design of the MACsec offload handling path tries to us=
e
>>       "best guess" mechanisms for determining whether a packet associate=
d
>>       with the currently handled skb in the datapath was processed via H=
W
>>       offload=E2=80=8B
>
> nit: there's a strange character after "offload" and at the end of a
> few other lines in this list

Will clean up. They got carried over from the presentation I copied this
list from.

>
>>     * The best guess mechanism uses the following heuristic logic (in or=
der of
>>       precedence)
>>       - Check if header destination MAC address matches MACsec netdev MA=
C
>>         address -> forward to MACsec port
>>       - Check if packet is multicast traffic -> forward to MACsec port=
=E2=80=8B
>                                                                    here ^
>
>>       - MACsec security channel was able to be looked up from skb offloa=
d
>>         context (mlx5 only) -> forward to MACsec port=E2=80=8B
>                                                   here ^
>
>>     * Problem: plaintext traffic can potentially solicit a MACsec encryp=
ted
>>       response from the offload device
>>       - Core aspect of MACsec is that it identifies unauthorized LAN con=
nections
>>         and excludes them from communication
>>         + This behavior can be seen when not enabling offload for MACsec=
=E2=80=8B
>                                                                      here=
 ^
>
>>       - The offload behavior violates this principle in MACsec
>>=20
>

Thanks for taking the time to explicitly point them out.

>>=20
>> Link: https://github.com/Binary-Eater/macsec-rx-offload/blob/trunk/MACse=
c_violation_in_core_stack_offload_rx_handling.pdf
>> Link: https://lore.kernel.org/netdev/87r0l25y1c.fsf@nvidia.com/
>> Link: https://lore.kernel.org/netdev/20231116182900.46052-1-rrameshbabu@=
nvidia.com/
>> Cc: Sabrina Dubroca <sd@queasysnail.net>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>
> I would put some Fixes tags on this series. Since we can't do anything
> about non-md_dst devices, I would say that the main patch fixes
> 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path
> support"), and the driver patch fixes b7c9400cbc48 ("net/mlx5e:
> Implement MACsec Rx data path using MACsec skb_metadata_dst"). Jakub,
> Rahul, does that sound ok to both of you?

I am aligned with this.

--
Thanks,

Rahul Rameshbabu

