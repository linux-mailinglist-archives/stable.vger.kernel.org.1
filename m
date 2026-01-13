Return-Path: <stable+bounces-208299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59413D1B902
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 23:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D48A23012E93
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A270534FF46;
	Tue, 13 Jan 2026 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ftMIvngY"
X-Original-To: stable@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020114.outbound.protection.outlook.com [52.101.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FA319873;
	Tue, 13 Jan 2026 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342584; cv=fail; b=j10fEsVWAGQmPXl9p3L3dQAH6okk99Eh5NjHYf8+s0Ao0yMgFWgCj1Lszgi73uyG0wbfkzJwR3lc4vdKw+gMr3tpwCQ8w0Wv/V1HV5P0W9+umOXBmqzDhE7pntiDSwMDggneR2oXk/UnJsHqvzeL2K0VdlFJRAC0Kilx7QGYQbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342584; c=relaxed/simple;
	bh=ALuESjNdOYJKr3VZqCKy6GvRNRKPJjnwHc4m5Y93NRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G5z6RNVFBS03k+4OCBD9J6jFMW7YHpQwMvrc2iMVZ5oArUtm47wT1GrEWUHehbo9gmmGMaRWkCZMGsFd3ll+rCx3az84t13JP6U1zN7K86Tq6K/AHpGMdt9XCouOLq66Ihn5gnHgCHhk9R50R8OwFwsBA4lBJ7YaELkTW/Iju4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ftMIvngY; arc=fail smtp.client-ip=52.101.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psnR0nj1K49neNsS1IS0zWHcGKSpRsc2gi+zPL/WIIklcY6n5WrPeH5dgvfXxJA0wlGZtK5F21LIN0QzUGVfVtJuwiwdJ3eRbeOvduk4yEbeHgQ8KytIWBDd4elpF5jPZcrjA2n3WRfI4Nex0LOXaD/FKr+r9dxULQRGTmu9I4WFNe4TnUKhtcxDbGmiSfDIASgdDggtB/nR+UR/lhRE+aPO8wQBouBesHvADBn1e3ikrHEP8S+t4hNr7kEjpvlCqr8RaZimS3KPgNsa2cpHCp++EW2B+Mpoc/W+Y49pp90uYiCvjrBmzoTveLnRiVVwLxJVukI9QqErq+fN9DEBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8xFWLNNxGb7O5O2WbRrvBF0yWf8U5f+TNewYjeXxSk=;
 b=h6I2FmbmJB7lIm4VnhnfbwgBEn3k1l2T7t/X1bR9LDXWzoAn89NSAwQ9CJKc7Zc6tCiM+QZz0LaxvQIjSWbBnBALXh6Xy+Zc3wkl9ViYbdOOpqs41DY4F138uEzSa9uCcqCbiN243loELDzYUeN1NdFSxwmvpnk4dlj/1OjLFYfS14oJ3lKjXxdRsnPDnZ71lRl57eH0Ho5XQHJGqflgfyZl70eFxEWQMyj9k1eYLVPZZWZ7vxEBaTiFvCWH5DvTmMjs0GqBR491MjpY1Bg6wOoj7WkNlfXIrItOlW/tHpDpLbRelW+afxyjMiUrpiBrUwlkYE32idFi1BhcvJLVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8xFWLNNxGb7O5O2WbRrvBF0yWf8U5f+TNewYjeXxSk=;
 b=ftMIvngYlzSn66QjjFpHUFM3Ym/eAnDv5HYllv80R3s2N1fsb6akPN/0IN73qK7QQEuoiFAwx/0Rl4Fhm589UqisdcK/Pdsb0Y+QgommU0DT9402qjVGLr2DX1DiNXyN+qKl3nvR7WlcPiYk1oczuPLGqgFDnXvS+n0miMS9bWcoCFhvEoE6RGq2zqO5JmNhfdC5xqJ0PZukMpwzNaeWEmnEtZau1WQ283kjvLHEkQXBRvyi5GBecybNQ2nVy6kGHx/hcOWGRtBnHQQN2jA7ZV8tYfaKRYwy9he2igGJLx6j0sqOTN5ejP74lZGR6etXPr0rq4bobz8mt5kCq9aTcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB11236.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 22:16:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.008; Tue, 13 Jan 2026
 22:16:19 +0000
Message-ID: <c5d48b86-6b8e-4695-bbfa-a308d59eba52@efficios.com>
Date: Tue, 13 Jan 2026 17:16:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mm: Fix OOM killer and proc stats inaccuracy on
 large many-core systems
To: Andrew Morton <akpm@linux-foundation.org>
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
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
 <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
 <20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0213.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB11236:EE_
X-MS-Office365-Filtering-Correlation-Id: 13acc095-9337-4aaf-62dd-08de52f1602d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEs5NmFPNDN6UnBMZ1h0ZXoyL1N0RTdkOVhQNTRZMjJyMWE3SHFtVnNoU29w?=
 =?utf-8?B?VU85SmRKbjBheVNmSktzWjdEU2RCcVNucTJ4dXU1aGxsK3dhN0NBZFFWSU5Q?=
 =?utf-8?B?dmI2dlZ6WGVMaURIWjNBbnE4cHllZ3dCYWQvdUliWlhjTTYwYk1YSTZYTmMr?=
 =?utf-8?B?TFNBSWE1Q1FIdFVoRGlrL0Fkbm50RWUxa0tLcFMwd2hwNVBjZjY4ZXJ4Zmhv?=
 =?utf-8?B?OFJvY1RWRXFtQXpBcWxjQmxNdWdBOE5mUGJlZ1luYytNdDc2aGZJRTZKUmNy?=
 =?utf-8?B?TXVIZWRSY3J3K0Z4ZnVkQ0VSRmlZR09rSVc4WEkyZmVmMkROeHI1MjZEUDlx?=
 =?utf-8?B?QVlLZWFSNFBOOHIxaFpINmhPMThuVHN1NU1ZWXhxSXRFSXJTSDhTYXNLMk40?=
 =?utf-8?B?c3NLTG4rMDBNYkJkT1hXSlNWdWlRK1V3VFhVeU1QbWh6ZTVMcVo1bGZOY3JR?=
 =?utf-8?B?NndMVlIvR1RlUFhHTk51aWdLcWV4TkdSQkVzTlJPZWRaalpZM3l2a0h4Vjd2?=
 =?utf-8?B?c0MxUmtNZHRIOUU4LzRsNzFWODZTd1k5eTNITXNFQit6bFU3SzQrL0hFUVcw?=
 =?utf-8?B?Q3krVDhvSzBBVnZsZnp1SFNzMGt6cWpSclRWV1ZGT0o1aXBlbng5a1hPSytJ?=
 =?utf-8?B?bnJQQURZRlNIclFOU1VRak5KWEp1a2RwMVpDTytGSFRJUm1Mdm9NbmtWRG85?=
 =?utf-8?B?QlIra3Z5Z1VOUWoxczZPREQ0REVHNk5jMW4vZ3FhQ1BjMnRrSEgvRnl0bVRQ?=
 =?utf-8?B?S0x5QXdQYUZ6UlMzdFhQWFlUd0VsNWNWd2ZUWjdTN0JWTlYzWWFxQ0YwZ2NC?=
 =?utf-8?B?UlIvR3JybStkMVMzUktPc01WYk1rQk9taHZEemdZSU9TQko4N05KSThyZlFV?=
 =?utf-8?B?QWZYMEdodE43N3ZjQzNVZ3ZmS2JjN0VvWUw1NjJ2OUZwR1h0eGROKzFzUmtZ?=
 =?utf-8?B?b01MeHhHTGZZSmN6ZDM0KzNJOG44UVY0ajF4ZGV6aEhBdlVTc1BoL3RyNmdK?=
 =?utf-8?B?dnZuYjB3R0ZUQnk3QjNZOVI2OTdubHJSVTBkeFNVOW9odjdXSGRpL1RQUGRE?=
 =?utf-8?B?UFdpREFITm1vNWkyZ1hWODV2ZjU1cVVqclp0S0kzNUtGNVZjdStvSjN0MTRE?=
 =?utf-8?B?NENSbFU3SGlkR1cxTWdJWWJSNXNRUHFac3dKWlVpd2EyKzFHdkRTWmIvMGQ3?=
 =?utf-8?B?NWFWT0pYRlNwRUg1a0d1UjZiWUIxMWhIaDEyUGFWaGNSYUFocXVkT3diQkhn?=
 =?utf-8?B?NU5XS1JWMGpyT1RaaDQ2THJDRENrUkI2RHoxeExXR0tzVWM2clk4WExTYVFU?=
 =?utf-8?B?WGlLeDRxYmorbWF5TlB6TVFacjZuUUw4VE11WG8wVGJGcSt4QXoxSDdqdTZS?=
 =?utf-8?B?Q0tHUEVVTUtMT28xd0N5OHg4cUd0T24yWTV6WkRvTkhrYVo0WlYzMHJRd1RT?=
 =?utf-8?B?cmZIU0NXWkVFZmFQVEtWa2k4K2daT3AxTjhyZE1vNGdUWXVlWmN6TGxSN2dL?=
 =?utf-8?B?QVVYcHBuRFk0enRLN2hBZ3Eya296eHlYbjZJTDZrQlgzTUMyTXRMdWtmUS9S?=
 =?utf-8?B?djl6UWtwZ2ZycFVUMndKSHN6RzJ4N1dldkcySXUwakhzazYwNnJtQWw2Y0hQ?=
 =?utf-8?B?ZStBOEErNlNJOVZWZ3F4M3hkVXBocVlVYWJFQkFJejJqR2MxS0lSTGVuNWpI?=
 =?utf-8?B?YzBld1RiditUSUdldXJUaHRQa21CL3B5WEc4aCtwZXU4dVM1c1dLRUc1S0Vh?=
 =?utf-8?B?bDZoMThsN1d4R2wxbmpjakQ3SlpRejlmYWd5b0pKbVNyRzY1Z0tLSmV2SGwy?=
 =?utf-8?B?K2FBNWlRdlh4WUFCemlSeGpncWdNWjVFSGlsSlRWd2N5Uk1aOFREWSswQ25Y?=
 =?utf-8?B?RWVXMGRQczliQnVTMGNZNkpZN1AySDBIS0xRMEx1VlRtb0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9rY1dGZ2dJTGhxUkk3ZXhqdlBqVUJCemt1VzIxdG0rUXhadEpYRGFuNm5D?=
 =?utf-8?B?c0NJaHpDWDhtMHF6OGJxTjlPbDdUMVYySE5LRlZYR0UxSUVmYWo0WWR0YVNt?=
 =?utf-8?B?R2hET1ZKQ2RBV3B0T3BTNWdIMnZXek9sSGZwRUZ5ZU42ZU1tY1V3aE0zL3dw?=
 =?utf-8?B?L0F4b3dLMHZnYmRFeHQwYnV0MXA5ZXFvZUhJd1JXaUxCYjZPMWVjWGk2MEx6?=
 =?utf-8?B?V3F1U2lEemgwSHVua0tHSnlvQ3k5OFdJcjh5SEVYdjBOdlQ2V3FYSDhVN21N?=
 =?utf-8?B?NjJ2WTRwSmtiZEZML2lyM3VRUU1XeDlOVzBPNjdRRmpLSW9lMlpkNjk3K3N4?=
 =?utf-8?B?ME5tS3BlVDB2TzVhMGNLTjMyUklYNHFEVERyeFdsTmRBbEcvNEsrNnFtMlhP?=
 =?utf-8?B?bEcvOGJUdFJnMlcveVYyU0dKbWRBVlJVbWNWS1MzMVRrV1I3dll4eC8yNjVq?=
 =?utf-8?B?elUyNWE1aGRsZnk1MUwzTjF5VE0zWThqNzNxaEUwY2Zjek4rVDRnWFJsVnEx?=
 =?utf-8?B?SGFWeHh4eGRtZkI5VlpNR21uSml1S3MrZnVTNjQ2UFRFcmJaUHd0VytVamxn?=
 =?utf-8?B?MmdXSG02UCs2N2VmOHJjVWNvbFBhQWdYMFRhZjFZQW9tcUExNERtQkpYUUZI?=
 =?utf-8?B?czl4TVhrb3ExZ0hoSERhUDlndDZjb3JxWitLcElhYm5EZ044RG54OC8wUmsv?=
 =?utf-8?B?dFhGTVZwdU1WWE5hVVNvLytMaStNSU1VZ0pFRzBsVUZrcElmaDdZd2piVjhM?=
 =?utf-8?B?VjRaZnV1djdaU2U2ZjQ3QjdMYytPQlZhdjdBYUlFdVBHcnZlWHh6Rks2VXRq?=
 =?utf-8?B?TlJMTXIvWmhudlVwNFNjblcrbHBuaHUvY2RHOStOZ1MzWXYwaFZ3VGpzRG1X?=
 =?utf-8?B?VndzZzZkMGw3eCt2d0dRUG53a0lZTngwQUpIZlhDako0TzRrdTNwc09zK0Zy?=
 =?utf-8?B?Tzl1emxxejBlTmw0SVFmWlJKZ2tkcUlGYjZaeFpPZ2NVYldZQm1FcUQrLzl1?=
 =?utf-8?B?VGljQ3JHMUpEODE5NEZ6TFlKUEdzaEZmK1RseUFPVFZzTUJzZ3lBQmF2Rkt5?=
 =?utf-8?B?WUhYR1p0bjltanBhYzdSNnVDOTRMS09XZDhyeTRMMUVERlMvUkhUVU1rNlpO?=
 =?utf-8?B?VE1ZNWgyUGZ5QUo3OU43N3NGcHBGMXIzY21hNnR0MEk0ZVlqbFJWY0o4SmlI?=
 =?utf-8?B?RENpK0hiRkxBMDNEZlFxMzQvQU9BcVZ0dG0raTlJM1ZsWTk2d2NFelNhUzJn?=
 =?utf-8?B?d2dzNG5ZRkRoS2sxOE9JLzcrUEw5UVFSd2I0bENVM256VW45cldNS25Na0Nn?=
 =?utf-8?B?Z0xCczNZYWlHV25FUEpMS2RwcW1VNDdPYXZ2a2Qvbmk2Q2R3V1AvUmRIWExm?=
 =?utf-8?B?MWxwbFdnM3FQWmtPb2pDbzhaOU91UzdhVVdKRjJ3alprbTFJYy9WSjhUZXNu?=
 =?utf-8?B?bU1tT09KUGxNT1RlYWlnWmRkTU9PclJFMmJNYnZlYWpOL3ZhcG9uOXZ3U2Nv?=
 =?utf-8?B?YW0xRW1BWDRQbUxkZXpucGV4TmM1YlpxWHNGbWhSY3FlRGpHVDRIOUt4THJa?=
 =?utf-8?B?WE5RbHBEekpBVzRpcEkyV00xbHJnQVNQZ3RUT2E0QmdJcEtoWEdTS3VvSUpC?=
 =?utf-8?B?WWdTZVdrYk9XdVB6ZlV4UitkRGE2bkViZ0xUZkl6djZvZytQSUdtQ2d5aEFZ?=
 =?utf-8?B?RFpYNWJIdnU0M0ZGNlBOM2xQS3ViTGhjV1dXSzY0cG5jVFkyTllkekN2M2h2?=
 =?utf-8?B?eVFXR08xVU1hTkIzZk9oS1JqV1FzSHBTcjd5K0pwVWNicGVVUy9nd0VUSHRR?=
 =?utf-8?B?a3BnSHgySnNFNERaWXo0dXdCVjRpS0h2bzBFMVJ6QjRTL0Z4SDZucHhTbmMx?=
 =?utf-8?B?ckVkTkVWMFFDT0F5SVV3c2xmUmZ3c2hlTmJtd09oaGNMZmcwWU8xa0xZMjls?=
 =?utf-8?B?VFduUWppNVg4d2dNTjU2VjdtYlYzblJGY1BaUksvMkd2T0g4L0JCb3pVMisw?=
 =?utf-8?B?NWRUSnN5OU9pa0h4Wm9wd2tYNlh3a0ZZZmVVVVRoM2NoaHduZzExMGcxT09N?=
 =?utf-8?B?d2tpcFQ0Wnd4dCtldG1ITWVZdjl0RDRhT1Nrd2RRbExXbXZ3Z09PZjh3ODZ3?=
 =?utf-8?B?QytjSUE5c3JEeE5kVGdUNFd0alFoTUp6d3kvMmZuZEprQWdzWjVPQmoxTTFs?=
 =?utf-8?B?Z1JFQnVJQTMvaEd0TDZuMU5sQUNSYytFYVR5a3JhMFBDTDNyY1VXSVhnaGQ0?=
 =?utf-8?B?cTFMRzlaV200cU1LWWhkMURkbnBRNGNnSUtKa0gxc2VJbUoxZmhvN0JPM041?=
 =?utf-8?B?eHRueDJhMGZ3SkRGVlg2enp0dHFPVmUyTk4ydXRtam1pQVdkMEo5aTd5dTRJ?=
 =?utf-8?Q?D/0vig0IeQ5vURbqwJJuP/M5DhP3Jv+gxKg+YTl6p/1K/?=
X-MS-Exchange-AntiSpam-MessageData-1: dUvIIF6QRbm428XcjDGTQ4H0qw3BjPy2hKc=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13acc095-9337-4aaf-62dd-08de52f1602d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:16:18.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxueU1Zk9/zwMCFeCt2njv4063BEMljFdyl7V9WwN4xXLeAVo6gT0z4bt3iuuN2p3lFfrazORBy+R4Tx9pQK/n1NJ2diMGJfcZ/kZt/sR0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11236

On 2026-01-13 16:46, Andrew Morton wrote:
> On Tue, 13 Jan 2026 14:47:34 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Use the precise, albeit slower, precise RSS counter sums for the OOM
>> killer task selection and proc statistics. The approximated value is
>> too imprecise on large many-core systems.
> 
> Thanks.
> 
> Problem: if I also queue your "mm: Reduce latency of OOM killer task
> selection" series then this single patch won't get tested, because the
> larger series erases this patch, yes?

That's a good point.

> 
> Obvious solution: aim this patch at next-merge-window and let's look at
> the larger series for the next -rc cycle.  Thoughts?

Yes, that works for me. Does it mean I should re-submit the hpcc
series after the next merge window closes, or do you keep a queue of
stuff waiting for the next -rc cycle somewhere ?

> 
>> The following rss tracking issues were noted by Sweet Tea Dorminy [1],
>> which lead to picking wrong tasks as OOM kill target:
>>
>>    Recently, several internal services had an RSS usage regression as part of a
>>    kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
>>    read RSS statistics in a backup watchdog process to monitor and decide if
>>    they'd overrun their memory budget. Now, however, a representative service
>>    with five threads, expected to use about a hundred MB of memory, on a 250-cpu
>>    machine had memory usage tens of megabytes different from the expected amount
>>    -- this constituted a significant percentage of inaccuracy, causing the
>>    watchdog to act.
>>
>>    This was a result of commit f1a7941243c1 ("mm: convert mm's rss stats
>>    into percpu_counter") [1].  Previously, the memory error was bounded by
>>    64*nr_threads pages, a very livable megabyte. Now, however, as a result of
>>    scheduler decisions moving the threads around the CPUs, the memory error could
>>    be as large as a gigabyte.
>>
>>    This is a really tremendous inaccuracy for any few-threaded program on a
>>    large machine and impedes monitoring significantly. These stat counters are
>>    also used to make OOM killing decisions, so this additional inaccuracy could
>>    make a big difference in OOM situations -- either resulting in the wrong
>>    process being killed, or in less memory being returned from an OOM-kill than
>>    expected.
>>
>> Here is a (possibly incomplete) list of the prior approaches that were
>> used or proposed, along with their downside:
>>
>> 1) Per-thread rss tracking: large error on many-thread processes.
>>
>> 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
>>     increased system time in make test workloads [1]. Moreover, the
>>     inaccuracy increases with O(n^2) with the number of CPUs.
>>
>> 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
>>     error is high with systems that have lots of NUMA nodes (32 times
>>     the number of NUMA nodes).
>>
>> The simple fix proposed here is to do the precise per-cpu counters sum
>> every time a counter value needs to be read. This applies to the OOM
>> killer task selection, to the /proc statistics, and to the oom mark_victim
>> trace event.
>>
>> Note that commit 82241a83cd15 ("mm: fix the inaccurate memory statistics
>> issue for users") introduced get_mm_counter_sum() for precise proc
>> memory status queries for _some_ proc files. This change renames
>> get_mm_counter_sum() to get_mm_counter(), thus moving the rest of the
>> proc files to the precise sum.
> 
> Please confirm - switching /proc functions from get_mm_counter_sum() to
> get_mm_counter_sum() doesn't actually change anything, right?  It would
> be concerning to add possible overhead to things like task_statm().

The approach proposed by this patch is to switch all proc ABIs which
query RSS to the precise sum to eliminate any discrepancy caused by too
imprecise approximate sums. It's a big hammer, and it can slow down
those proc interfaces, including task_statm(). Is it an issue ?

The hpcc series introduces an approximation which provides accuracy
limits on the approximation that make the result is still somewhat
meaninful on large many core systems.

The overall approach here would be to move back those proc interfaces
which care about low overhead to the hpcc approximate sum when it lands
upstream. But in order to learn that, we need to know which proc
interface files are performance-sensitive. How can we get that data ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

