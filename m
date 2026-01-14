Return-Path: <stable+bounces-208365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C11D1F907
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5F93013C4D
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58330E82C;
	Wed, 14 Jan 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S+Z9W+6m"
X-Original-To: stable@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022129.outbound.protection.outlook.com [40.107.193.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA02C0F69;
	Wed, 14 Jan 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402632; cv=fail; b=MQR0R9KHxBp/vsS0h1vcBHNWGhNvTSJEIQlQvEpWl6cTHIpRim0IU/crn2ePKRn/TLiBiTSXFaAIgBr+a5Ov8TDRFZ8fr7Hndy0evQFc78pYQ1LMGfn1AChEWT8Kl5dpCYE8bsTgebeZKfI7GzhzQvd5/1FFB818eivKC8sz1T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402632; c=relaxed/simple;
	bh=k6aJ6+YU3dA2v7M0bM/DdsT15vOB16kf4ERk7N6GzBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f4xijUmO3BSRCfbEuUPnB5ls6ulJgdL4uG7EDernFv2auyqIeAPlW3Z15z3cwDABRAwJ0AKr5yKtyyFV3g8vrCaRC0csGYRzH7inIVr3fBFFDqC+81Wl6FRmxfXWol34qpBjarnlsrvnKE/EEAtbGmZd9wWhnFilhE3tt2PWhy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=S+Z9W+6m; arc=fail smtp.client-ip=40.107.193.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br5vnPjMfySfQY2W9am2RVR7ACzqy1y5j1pBrebIvdikD1b/YxgYALWiF5Gie97MLlhjWN0ZKfAZSz7SbKjrkMfjyEgxaqq8vqnKikPKMhUnExNrUm/8D0WXo/QPcNyh8AxXSSRhflakUlnLOgB5UK5l2QDkm3ucOkLhwX/BjorHIlHpKT77Fl7FfHqpgXhg5o1MGUTlMh6hplewm6eRgJi5ftum1hjcZZZpUHjwBk/+kouUR3rytZK4A9+Di0No70i3/3t0eYtRdlWrLFcYj/WMuASZf8ATw1bwMeI6kbjFC+jZW0Cen7gNfu6wWNlsENhjW4TSTIncfIcAwBHK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rruM0tTEC260Bb7b7Vu+fkAdIXRzX5sYVDYLRIECJM=;
 b=YiqW+AvK8ANUxMVbShz2Td9p1CTbaFhPVQyh3M9faa67poDCiOobPgdPZtZfDSRtu7dZ4ESO6o/+YblBLSUtQy0NJeHaL/MO7c2KJJQaJjO/5Ask/EDOYTv5VbF3kembrUj6okab3IqTSLaZshZG6fFN1DTKY0OekeIZXT1lAYXi2lM5lA3Ug8ZatbFXumEdmeYzDcvu8AZ0xceP0a3faMvmak0h8Qsv8k/fkojSjgYUlEgsyvX0DBdKykTzyulJNT2r5u7pmBDhAGqYwKARjSzyG7ec/+gzoqFGOCzkgp8ZSgcTIakEjKIT0J6U/IayBHJalHopAvo1xovCDIGj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rruM0tTEC260Bb7b7Vu+fkAdIXRzX5sYVDYLRIECJM=;
 b=S+Z9W+6mgx5uLki0jvn3lk8lC+uBmVp6XUtcj9mjXQ+gmMPuOx4HA/1O5bW+D74djy48BwfDTgwS+90WHhwdOCL20+ubZuCneTGm1OdBKcXbf9Er+qrET2/coKidS1NjTQOUZvaCW1t5ZXejZPa3iKgug9wD1AxicDqrFOmC1uTsI3SCdc7G4OaHW+E2fUgisbfGP86Zt75r8Ip/3gzm2GeSFWQNq+rIGfhuVcTeeavcWx1ac1rLovMPV4DCJb+8FbT0s00CBl3t0RtuOBepRMHjLc19lIsyaGAty62YIS7g1GM8ceWJCj0gpyYUbqdYBaHdTGFuinru6BpRiWryhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6172.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 14:57:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 14:57:05 +0000
Message-ID: <11a68471-e856-41f7-b4d8-dff346bad1ce@efficios.com>
Date: Wed, 14 Jan 2026 09:57:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mm: Fix OOM killer and proc stats inaccuracy on
 large many-core systems
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
 SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik
 <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
 <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
 <b5621fc0-5fe0-4ba8-a6f1-84f09f54d186@linux.alibaba.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <b5621fc0-5fe0-4ba8-a6f1-84f09f54d186@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::38)
 To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d752ac4-63fe-4aad-6806-08de537d2e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE9LUmtBU2ZnOFBZcXoyYWdDeDVjc0labGhXTUsxeHRuaWRXRWhWNnJWbjZv?=
 =?utf-8?B?Z3ZCcGlTOURMNG1XSThpZUsremVCRytxbWRpMjlCaDFQTlJLYTFKVzZkeVVY?=
 =?utf-8?B?ZmNMVTlFRkN5K2U3UHBKcFQvek1kcHo4L3VGVUFEWUFUdkdTSis3NWJ4WWlt?=
 =?utf-8?B?VTZNM2o3dHNLcXBxTTNFUlBLSUlNZytnSHVJZ1EybldXcnl2UjhJamllSXhs?=
 =?utf-8?B?ZFhneGJjdi9nNVpoU1gxdnVBeWFJWEI3WWsrYjFLYkdZd1JuTTJsMkc4Zkl5?=
 =?utf-8?B?em8yVURjTnh4SGVkU3VESGpLUEVFaDdSTWlTR3E0bDJsNVRjdC9nTkRRZ2pJ?=
 =?utf-8?B?NTRkdHpyTGhVK291eWEzL2taUHlaWnFMNStpbnFHa21Lb0M5K05hSmhHUGtL?=
 =?utf-8?B?Unc4SDBxSWIwQTNlanJnZDlUekwwNWIrT1JQL3VnZk0xMmFJOHJSWS9xd2M1?=
 =?utf-8?B?RFc4aytaNFdubTJlaG1Qek56dU5EMnNPdzJpYTcyVm8yTkJWZ2hteThaVFhY?=
 =?utf-8?B?WVVzU0pad3ZZU3BacCtXYWdHRG9Va2YwSDZJSWZyZXgwZDEwWTdCekZ5Ujg0?=
 =?utf-8?B?NG5LTjcxaHczRlRiNmRaYWl0YVJWZVJWY21iMWJVZE9pR0lMTlVtdTRhT2dv?=
 =?utf-8?B?bks0bEtYdUN1a1M4ckNleDRQRHNCd2N1aWNWcTdyTmxHWWZmVGc2WVRUQjZS?=
 =?utf-8?B?QmpWNjFjWUlwcFh3YXJ6Nk5ZSW9QSURFWlZCKzlja2ZmVElrZGZVS3h4amNV?=
 =?utf-8?B?b25aaWtVTWdMSnVNY1hBT3BjSFZDVHNMREswVldzQWRYZ2c3Uks4ODd1Ymls?=
 =?utf-8?B?TXFtKzJaS0szMkZBYkcxYjZDQy85ZVozNGNxWDFVSUJqVjJtQ2VTL29Pejgr?=
 =?utf-8?B?cmJEWWw2Ty9vckZaUXYwdFowNTlESGNYN3IrOHFuV0E3SXdSbWsxZGlWRTBD?=
 =?utf-8?B?MDdBaXE2MmRLTlAzUFVlSmM3T1BScS9QeExmOW14czFET1NhRytkd3oxbnRw?=
 =?utf-8?B?dlNFWDZVblRsbFRWQ29PcTNqbEIwYlpXSzJYdktvc1NPanc4NDlpSUt4UnMx?=
 =?utf-8?B?UDZlRm1idUxmc202N3ZKd3BwOThSeVY4TzhEZXZVNTNmbWNWQW9uZ2NpeTUw?=
 =?utf-8?B?T0orZGNEQkhzZUVnaC93dVFqUTNocE1ldCt0VWZuUW90T2FoTHVOM2ZkT1Ni?=
 =?utf-8?B?N2x3cUlVOEo4c0luT1F5Vk8wWHZzZFFtUTc4L3FQNDdINkp2NDdiNVZ4ZXl1?=
 =?utf-8?B?UXJqbTBUb3RiYnVoNDdVYkk3TEFackZaak1ML0tqelQyc3NJbkRNQ3NWQlZ5?=
 =?utf-8?B?QWJvNzRBRUdYZGdmbEliRWdZYWxWV01CSkl6dGpBTXd5VmU5ZGV5VGl0dUkv?=
 =?utf-8?B?SGNGb1VHTHdwczFkSEJiTGJNT1lsVHM1WXVLU0hIMk5VeFd4SzlTbmU2QlFr?=
 =?utf-8?B?UmR6MFhFQmduL045cmYyY3dIblJzUXlONmIyb0YrcENKNGZNNGpqMkI1T3lL?=
 =?utf-8?B?VDdDUDRkUDVsYjQvUDREczlkamw5ejNWMkVjRDNwVnJLb0s0QjFnVFMzRGRy?=
 =?utf-8?B?aXZyOURCYkFJeGVuZGZKcjNhRmtlRlhuWEpXR1Arakg2K3pMcFhJOWoyTVE0?=
 =?utf-8?B?NjhEaG5Eb0VTRWU0QjlGREt6QnRVajVSUGw2OGFLbXRFOXI4TjloNjNUNyta?=
 =?utf-8?B?dGRwM21ablowQVo5SEZHYVBJMVhOKzh1K0hlVW9kc3BoRXRkYktjS0lCeFVU?=
 =?utf-8?B?SFdmY3RCUzFJak9pazhxUkl1eTNYcURQemI5LzBBVUoyVG5uRkpObzR3Nytw?=
 =?utf-8?B?bnluek4zS21KcUZnUS9xeUcrVWRLa1BYaVpUajdycU1jVHZqN1NzczFhRGlP?=
 =?utf-8?B?dFdhdm5mek1uRmhRMiswU3BKMmlERFZrdCtDMkNicFU1eUhEQXVYL0huV0xU?=
 =?utf-8?B?TldBWWQ2Y3NDZkw5azczbStDUTJDYzhtcXRwUzFnMXVJb3ZMc0YvdVI3SFFs?=
 =?utf-8?B?ZTk1Ym5hbnBHNGlhcVBVbGlNa0lhM29QQ0hRaUFIK1UzVEdGcHA2dEtTb1gy?=
 =?utf-8?Q?Fa3QcK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHVIaml0K1dKMEpQL0FJbTFwOTE1QjZtZGI5QlFERGtQZTBZQUU5NUdRSytq?=
 =?utf-8?B?N3d0RmlrQUpnOGo1N2R6NHBOTDRNWkJUVjFwTWhhdENraDg4V1ZsS1lJVFVv?=
 =?utf-8?B?dm9UQmp0dGRuUFVEOWpVNE1wdFF6T1lWS1c3RkxJTHo3SkVuUkRpQWNEaGRx?=
 =?utf-8?B?cWRZMHNrSlZ5UVFuMzcxLzlwcXh1WjI5VndHYzRrdWFIVzUxTkUzMWxuVHZG?=
 =?utf-8?B?Y1lJRTduS05SOXJkendFaUxLRUU5b0VQWlBOU1c2MU1GckdGRm10ZWJSUEJm?=
 =?utf-8?B?cUp6eG5YNGUrRk10dlNKNldIL2oxK0V6SDJGbnF1RmdXdURQaWFtbG9JTlZh?=
 =?utf-8?B?VkxkLzY2ZUs4K3lDbWRlTkNITUJJNENxZklqNzlMV2srUFN2SW5zTlUwQlhO?=
 =?utf-8?B?MDU4SG9zd0YvbVQzNzVwTVhGdCs1WVU2aDc2cW51ZW0ycVJKSUN2R3NKaDJp?=
 =?utf-8?B?Z3IzYk5VTDcvbWNXVkRvdzdqQkxnY1lrQ2FOdE5WZnUyNzk0WjRjTGV0Q21X?=
 =?utf-8?B?WEFweTF1aEt0d3NkOW80M0VrZDFpUTdtdnNpbWxETjNrRTNRV3UvbnV1SEdK?=
 =?utf-8?B?cTlFelJWQnp0cENlcjZ1bGRPUXI1WnRMRHVYQTFMbVlGckRNb2JBWmlIQkN3?=
 =?utf-8?B?a1hGWGthMnBlbUJ0emtEVWNNc1hyTUIvYi9LNmpWQ0pBbTdTQWFOQnozL29E?=
 =?utf-8?B?WGNsQXRwUGxweDJ4dkl6NEJnZFRZWFY1UXFFZUpVaVFkU1pURUpQZTJFWHR5?=
 =?utf-8?B?VW5CWW8zNTV0djhtaGNYL2JUR3VaSGZCQzVkekJNZEtZOGZvRlFIamprNEZr?=
 =?utf-8?B?cWhUakVOQldwRkVGL3pGVHpieTJpNkdkU2c3bzc1c2xnVGJ5M1RoMXZRMTVU?=
 =?utf-8?B?RXhFN3l5dzBnUk54YVdBRDdqTXNaQ0x4V2ZHSG9sa0xHUys0eStVQzBJMVp5?=
 =?utf-8?B?R2dMWkEwRDJvcWJ4NjROdVFkRElQSUIzWFB3eEVMcGhxSEFnT3RiaTdxQTNl?=
 =?utf-8?B?Ty9qdStucnZ6anJuQXNCdTYrWW8xODlZc2MzUWVlNzZYZS9TK0o1eE56cm8w?=
 =?utf-8?B?OFFxWU1GMEpDdEEvTUtKbXppekFFU0xEZzMwVVphdE5BbDA5YUoyQlRoMGg5?=
 =?utf-8?B?YnFaVTZRaC80ZWh1NGgwVlFjRGdMRnYzZitrWkxqRWdNQlZ2NWNnZnlUaXg1?=
 =?utf-8?B?Q1djdWFQMmNhK2o0Q0Z4UEJEdmx1ald0V3JNNWJTQXZ3TWp6RmhZUk84WXNG?=
 =?utf-8?B?QjRJTUhsa0NpM1FoTHZRWDVsS2dGNjZZUDc5RHYxOHZBRVhjaENZQWU1ZTVK?=
 =?utf-8?B?SmxMREVGaW1MdXNSdWVxRlI4Z2NLckZITDR6WDNOcHZYeXVSd2NOcWxKb1ZP?=
 =?utf-8?B?YlA5OEtoRlJ6L0NRL2FQZkxvQWVwSms0ZHZPMUg2K1ZvbklZdVVPYXBpRXF0?=
 =?utf-8?B?RDY3R0t5UGEzM2lmemR2WGh1MGJUb0gwQ0tiV1cxb3JtYTdtM3BuOXdoWVFG?=
 =?utf-8?B?Rll2ZlZacG11MkVHcEpBRjJUSkV5ellsMFNCWE44UDRkMFpCcG5EMjNIeGM0?=
 =?utf-8?B?bmhPd2NwSjhkM3N2UVEvU3E4OWhtQ1JFNDlHVlNIWVhMaUhraTlMT2xJS01i?=
 =?utf-8?B?eDUwL2E1bFFzSUlOTDFmYjdBRVI5KzJQUnJ5dWdReXNSNmZRZVdqSTlQb2dB?=
 =?utf-8?B?RnJ4cU5TWWtOVHY2VTlyUmxSSkZQUUdrWmlNSGZoT0hhSUkxYUNHRzQ4ZFBC?=
 =?utf-8?B?S2FSREF1UzNENVB6QllkTThmZWp1OWVEMTVsdjQ5SUdGOEJCMWUyV05Gajdk?=
 =?utf-8?B?Wk9ZWUl2LzR3dGFJZU1QQlNtdzUweEV3RndPWnFsalk0cytWZisvVG50VHpP?=
 =?utf-8?B?NnJ1UHFyMXVTdC9XUnI2c0FCQ3JQaXI2azBUa3VxQy9TQnl2MUhmOFNvTFMx?=
 =?utf-8?B?b3ZDNFRINWF6YzFxTk5lMGh5Q2NmNkx4bDJpaEw0MFFHNHdFVHpyVUFwTmd0?=
 =?utf-8?B?SUw0dUJlY0dVUCtsdmthZk5NbVYyTmtsL3RvOEExaklwU25obEJGSGVrb0gy?=
 =?utf-8?B?RU9ORU5OQmh2K09wc1ZnZmtvMlFyVjJBN2s2RTVJcHkvTEdIV2FsdkNJenh2?=
 =?utf-8?B?akVrWHNwNHRMTGttbTM4QjlsbWx2UWVNWHZ0UmVWalRXRHV0ZWpnT3dtTjlL?=
 =?utf-8?B?TnVZL3JFNDJHQkx0WjA0Y0pwbXNBSUdYK2hxOENpRmdCNE9WeGlZdkhycm1D?=
 =?utf-8?B?NDJoYVg1TUtBbTB6K2I5WlFETURLTXRVdTlTMUt5MEIxaG9wQ09LSVF5bjI0?=
 =?utf-8?B?N2VjZ1RQMk9PWlUzVVd5K0Q1MkU2cU1LTnJNZFBHVU40aXZDWFNWUllydU1s?=
 =?utf-8?Q?cHE8WJ3ete+E5Xpw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d752ac4-63fe-4aad-6806-08de537d2e8c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 14:57:05.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4GBjvY8/IwhSZv7RfdETEHzUcnahJcUNoR7FjGURb6rvoGmUByYr4KmNTEgjkmQZDKZYG5TmvuPpGj7qfXet5mZZ65Lz2d4KaWX7R1BTPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6172

On 2026-01-13 22:18, Baolin Wang wrote:

> 
> I'm not against this patch. However, I’m concerned that it may affect 
> not only the rest of the proc files, but also fork(), which calls 
> get_mm_rss(). At least we should evaluate its impact on fork()?
> 
It's fixed in v2. I'm introducing get_mm_rss_sum() specifically for
the oom killer.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

