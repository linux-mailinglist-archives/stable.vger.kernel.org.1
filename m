Return-Path: <stable+bounces-249741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMX8Jz0vDWq8uAUAu9opvQ
	(envelope-from <stable+bounces-249741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:49:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C94325875C6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71A673012590
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB0370AEC;
	Wed, 20 May 2026 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E80AmQkm"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010014.outbound.protection.outlook.com [52.103.73.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075E3128D4;
	Wed, 20 May 2026 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779248950; cv=fail; b=o64bpZDWLfPNSnEfDVoBdgzTIZGgkUCL4u/0FCXHSwE0DmbyRMcIRZB+huR2QcFVbi/FtlBzlYkZdOPEKHNKNYxf3ScUzQ+MtWd5mW0BY/qXLk9YJIa/8npjvjDqv62tpoVQztdblioUFzuRB5Wzt9xRWqflB6GYgcfnUqM+bVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779248950; c=relaxed/simple;
	bh=gadIm6suwuJu5DsYITqUYuZvzBN45Qh8UlyQPoEB4b0=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=fJO3OFHMSHXVDAFDUByDaxvs3PhEBl5h1smhOF48tbO8eXcBZkR2hYzKHcyYQ/vV/E7l2JPYCzm313sdOcLpg8RyHAiqCTN3gqm3jrNpwLHRl9DM1MovAdDQyDQ6d/T0hiW3WGaUkOvNjGHtbszlRwWtFGfPB+7gd/JUHOyEZAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E80AmQkm; arc=fail smtp.client-ip=52.103.73.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUY0FPZ9QKJ/U2Md/WpP6fFpWYT4/E3YBCUYr9svHiHNKV/w6N681BkFPDECUyWSJ6oQVx9an0GX474olNQxemkIAgcNsYyg98wKIJDTsUmyq9vhyo/kunxL80xw+r5rTpZtBJF1I+G9t/mUA5hdtVH4vwkgRuj+NLbozHZubeTIbMntpJ7kR5jidSD3JdNxvaTCDR4TuKsam7hK5OnkIlugUCxCPm2E7T92UDYUKWWEwdBDXK0DUBs43rZMizr4D1CF0W31sPW7/ScilIcSlSt7Lrqf9Y8aD4euxBgiBkFhS74zP6qKQPDfsQBTBB8eXu/XCed5I+IVgzQEm+eEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9KGuyRJf/uaQk6/59XNxBiNrdW2pCMNzRcdFuDrkCs=;
 b=vp6r315Ay94qh04M7YbWG6ztYc8vLj/96Yl2dUHyG0BxlJB0X1gk7KSrVAo82rO4H+WK6IRlNqDe9X6x0w+iAZhTr/dFVAQtCvghrOWJ2SDpUQjj0Vtq66P4FP912Ogta1sLGFhHpbK0KUKobAoMJxHgeOPQ0iE/HPOU1hUUVaFYAK/xMTSFveKrDX7DDaryqidAPHDrKHfciwn9pjFGpggThSpltTfHaLbl6v1393uEhY/JxAmqTElOOqs2kXj2F3sleAx6p2ZoJY9VLvyJ/2Eaurj+rywqE67s7fET782hETY0tDN65vH0TKixOYc7L/aLwcOfVVy3TXkt3m0FnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9KGuyRJf/uaQk6/59XNxBiNrdW2pCMNzRcdFuDrkCs=;
 b=E80AmQkmkPhZT4thlGDdEOb04HMLtLLtcS91PDML+f+0b8a1Frf+ls5KMA9Mst3TwoEdb0WEhRr8j35zihW5BiJQj9IQagqZ0ue/FMNgDtyROL+k1c55qkTIDPC7HOLb2aco0fhCt2wk8PRGRrsOcYVt9o48KKpE2OnE7yHvM6t5cCVG1PN/80T5tTDT2ZURJ33mjZUxor8bbMwtcsdOTqj1IN3yPPh4Jp6+8IxCqwM+D2Ab0jwloaNr+3tG4TRnDbynlMzPpfMK5eaYzO3ZFMl3zHHxyOnp6on+lzZ8YQPJ3XgKd5pyVlrc1+zst4kjGOUXxXXI4JS6Zxjy2The9g==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB9280.ausprd01.prod.outlook.com (2603:10c6:10:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 03:48:32 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 03:48:32 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 20 May 2026 11:47:55 +0800
Subject: [PATCH net] macsec: fix replay protection at XPN lower-PN wrap
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78813FD49E58F253B989F197AF012@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAOouDWoC/x3KQQqAIBBA0avIrBNsoJKuEi1Sx5qNhUYE4t0bW
 j7+r1AoMxWYVYVMDxc+k6DvFPhjSztpDmJAg6MZ0OjILxXtrJswInkTLMh7ZfqDrAskumFt7QO
 Pock0XAAAAA==
X-Change-ID: 20260520-fixes-b8b72f2ec0d8
To: Sabrina Dubroca <sd@queasysnail.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Era Mayflower <mayflowerera@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=gadIm6suwuJu5DsYITqUYuZvzBN45Qh8UlyQPoEB4b0=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLF69V5L+1zce7LJ9/lk/a7VzgP+UMkte4eD2R2Zs5
 iXXDE6Lf+woZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAi6xg+GfEeivqZPFtzYm6
 0qf6WdIfifmLOSsbvZtcG7Y1qmaOhRnD/8Ij7rW6y7q1WYpeljgfkE8IUpvqIRTlaCTXVHfI7mg
 EPwAgDURM
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260520-fixes-v1-1-b9ccda969c4f@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY7PR01MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 56827913-d89b-440f-e7c6-08deb622a96d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5062599005|24121999003|22091999003|55001999006|24021099003|6090799003|5072599009|8060799015|19110799012|15080799012|23021999003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHlwNFMySk4xUXkvRFpIT1ppV1YrMCszWjlsdWQrZUhBYS9uRzFQeFpZdlhU?=
 =?utf-8?B?WEdWSzdvRHVYbTRlWllPOUQ5U2VNNG1FT3NwWTJzbnZXTENBdHJWK216NzNm?=
 =?utf-8?B?UWF5ZGxsc084aERXT3RMSFNTMDY4NzFhT0pWeFBSUFpTMzZjWngvWmlJcTMw?=
 =?utf-8?B?U3RpN3dmOGl3ek1NcFNDVlhqVnVVZ1lKeDF5bXp2VlZEQ1BTTTBaU083cith?=
 =?utf-8?B?bzRXVGpVR3JWdTNoU2FJcFRXcnNLd0dXY1FUNU5yUzdwWnBMNWlnWmFRNjQ3?=
 =?utf-8?B?RDZocTNuYi9CWlVvRjBOaWRhS01zZFVubHhpVnpVb2FmKzJxT01uV3ZhNjV4?=
 =?utf-8?B?M0Uzb205SmEwejJoL0phcFYxR3dVODlmT2kxd0pSeHZGYkhIMDFaTWZLaU9M?=
 =?utf-8?B?NzV1NFAzR1BYZUhrRW10VFdKdno5N2FaS1ZPUHd6aVpGRlZGTGFLeEFibTVl?=
 =?utf-8?B?NDJmeDFRS1FEUncvM25SQzc4ZUc0U3pqdkNpTFp3SnlDV05HQlUrVVFXTlJs?=
 =?utf-8?B?cWNYL0ZrdWc4dllrM1ArQnNFVDlZVmdjQkppb2tpZHVobDVlOCt1M293RDg0?=
 =?utf-8?B?NnZVbHVaSE84MnVYWUI2Y210VXVFMWlURHpzRnVqKzlxeTNISmh3WFVCbmJV?=
 =?utf-8?B?YjFWNnY1eW1QRkdnVWo5T3QzaTdhTDJrYnY4WFVhNjBMY2hVRWsxUXQ0ZThh?=
 =?utf-8?B?K0JIS2hsVmtLRWtQUjY3a3c1THlYZjAzbWlrUTJ1ZTdlOXQwdnNLUFNvSTVw?=
 =?utf-8?B?QmtVcHJSYXlyQUVCeWpEYk9xRFg4ZHdyUjZzTnpGRllXdE15T2pIZXViWnVp?=
 =?utf-8?B?OE13ZWczWTJNR2w4eFc4VTB0VVEyUzZBSWxyQkNGS3Vxek9yd3pKRUJuV3N5?=
 =?utf-8?B?dDFxQzRyd3h3a25PZEpOa0pqenRaSm1LL2FvTjg5R0tpZnBzQnFzOHF3Tlpt?=
 =?utf-8?B?TGtmaXkrR0s5bzdlbWJhS2c3S3RHRFVQZWhONnoyMlIxMllMT3JuRFp6OWlZ?=
 =?utf-8?B?dHZTdFY3ZVVsTnNOUFNPUTB1dUtkaVFGY2N5b1JLamJuVzFaeFlveEtJN3lw?=
 =?utf-8?B?UTdCNy94VjcyZmNRYVM3WDNpYlh6eVF4bm1xcDhHUUt0QUdKMG02cW1YUXZM?=
 =?utf-8?B?eWpoMzJNL2RxSEdHUlFqbWNrTVBWN3QvNkkwZmpOUU9QbVBvTTBGeVJUdEln?=
 =?utf-8?B?SVBtU3huYVF4Zm9XMFZkTnZlNjFRd00rekFCMElCVzUrZjdaY3NQZk9LbzlW?=
 =?utf-8?B?K1ZCQUptZWYxaTgzMFFqcndzT2RRQVh1anREK3lKbEh1bXBYeWoycWpka1pa?=
 =?utf-8?B?UXlmUTU5MFNJNmVvamJFNVd2QmlZTDN1YWRCSDVjclB3Z0FQcG03bU1QbU1I?=
 =?utf-8?B?R2RXMlNEVnNYQkdKdTdPYzlmaGRWS2s4WE9vMENxYkkrTG8raUtxYW5CRFdp?=
 =?utf-8?B?QlcvSUxXSVJpMmdhQjFpS3BhQ2IyTHJZRmM4TzY1TXF1a3llNEZWY1VKSm1E?=
 =?utf-8?Q?+EE9VnDv8YRVIMclfcIlt10xNwf?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVpb3RoN2VTU2QvV29MZmRnV0dJTXZJK2pYN0J2U0JCQzhUWXRSWlBDbnov?=
 =?utf-8?B?bWFrYWdKd3kzS2ZQamFua0NsVXRFZFdMYzVKMzNNNXpEMTRrS3N4eHQxUFV0?=
 =?utf-8?B?eXUzd3YwTUYrbzRidGQyMzFvVmpKaTBsdTRyQ3RDejhvRFRFWTRZWlY0SG5M?=
 =?utf-8?B?R0d1NzNKUEtkWVZoUlJGc3FSb3A5TS81eUhnTkNmQmNlWjI3bjN2UHgwa2N0?=
 =?utf-8?B?WkNua0JQZWVERkwzM1NuZmtWc09NN1Y4ZmJGd0RYMVN3UnZwMkRPMW9lWW5i?=
 =?utf-8?B?eVZkNkhqWlNoclJaU21NbHpWL2FtS0llZmFlZEJBb3E1QXdJcVR4NVZCQVVp?=
 =?utf-8?B?UUpSN3RTYkZkK0pOaFYvV2tRTXpZZHZGWHJ6UjRkYjBxT0cwUkVRNHJvczFX?=
 =?utf-8?B?R25zcENjNktiUHM5TmVBU0c1RmExcU9PQU5lOGU0K3RYT2JZWjdLOUZMYkNu?=
 =?utf-8?B?ejJuaTFQSW1LMXhMMjZwYTJkZzZ6V0g3bGhGWmkvdDcrWmYwK2xGM25CSmVi?=
 =?utf-8?B?ek9VeEVrWnk4enpDL1hDZVVndCtsa1FjYjRQSnNmaWRQNkcwYTlSa3hqdVd1?=
 =?utf-8?B?SlErLzJzakp5VWRWWEN4eVRnUDNnVGZnS1lDYkV6d1RuOEtRZm42Y1E2QU95?=
 =?utf-8?B?NVQySS9iUFdXRmdoZGZTcGsydHpibkpOVzExemo0UUJqOWJsblRVNjhlclda?=
 =?utf-8?B?dkdidnlDbHBnYnhtYkkxR2p1MFNyYnlIVzc4aVByWWZsRjgzRzRpQ3ZMV1Zi?=
 =?utf-8?B?VXVaSE9raUJFTmZlTDBRbzZoeWN1QVZXZzJIUXVVQ2Fkb29ONlhWR0l3LzB4?=
 =?utf-8?B?bzhqd0duOEpYZEZ5Um5vdDFtTzJCYndncnFaU2tJbFdRZFRmZENpOVhUTlRj?=
 =?utf-8?B?dUZGMldxNzNGVzMzSC9kODBUcHptaXZuT2YveURhcG1XYThjcWIwSVo3NUNU?=
 =?utf-8?B?ZlA5elc3dHh0dm5qeDhYZHJKSjd3OXJkMDNGczYybjJFWm4yQnl1ZExwcDJh?=
 =?utf-8?B?eUVVTUZ4SXF0QUJINWk5bXcxRU1CaXBudzJsSzZpNDd0RDZmSk0vV1ZjTzl1?=
 =?utf-8?B?TUI1MmR4N09yajlEeHpLS0FWRTNiM25hQXBPZDl1cStNM0swb0hoNFd5eWFu?=
 =?utf-8?B?THVlZ0o2WHZGdGREVFdmYm82OEFnTStqc2FvMkVISVd6cWt6SVlrSElMbHB4?=
 =?utf-8?B?aFEvTTF5cFhPK1hFTUJCMHB5Ty9wVngwOUdRUURtTGFjMDBNazJ6K0hGTGpZ?=
 =?utf-8?B?K2cvRCt1K0hUYkFvQXVjaVdIVm0wZnUzb1FGNVJqbWtuVTk0bytMdmF1MHox?=
 =?utf-8?B?YjM0UDRpdFpFQXA2QXJTSXZ3K0x4MWlLd01sT1BSbDJCdklaWEczN2QvaFpO?=
 =?utf-8?B?N2pzREd3ZzR5QnArM0p4bXhYMjF2N1NkaHQ0TDJ3NXI0Zy8zV1BWd3h2TjUr?=
 =?utf-8?B?WC9rbkt2bEhEaEExbVBTMVVGN1B0YXdJYVVQeGYxd0pkQWpDNkJvYzUzdzdQ?=
 =?utf-8?B?U0FhNTh6ZDNmZjhyQUFBeXZqSFVxbEh0U0xaZjQ2U2tVL3d4Tmd1U29nRTBN?=
 =?utf-8?B?R3FFSlFWS1VFaEdjNVk1SVQzdHhkbTczMVFNYVlCelFOcTVWRDdyTFFOb0F2?=
 =?utf-8?B?cUVlUEg5TWhnSEwrRCt0emo0bTEzZG8wQXdFT3dQYkdadEpOT2lRb0ZFM3hn?=
 =?utf-8?B?eVJZWjZ2d1JIbGp0Y3p0dFZuT0N0ZG1heWZsRGVvb3BKWm1WMVloeDhMY3Vl?=
 =?utf-8?B?aDUyNEF5TzZmR2ZvKytlMFFmbnhzOXJSWGtwWGc2K3VqR25rbWN5bTNPUktp?=
 =?utf-8?B?b1NZK2xZN3A3KzlDOWtBcEtSOGpiNStJVHA1U2RzQ3hXTzJKSS9LaGJHdkcv?=
 =?utf-8?B?WFhYMmpJck5aenNaRmNrSU9SbU9PdlJtcUsvaE1rMGRpR2c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56827913-d89b-440f-e7c6-08deb622a96d
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 03:48:32.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB9280
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249741-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C94325875C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In macsec_post_decrypt(), when pn is U32_MAX, pn + 1 overflows u32 to 0
and the first branch never fires. If next_pn_halves.lower is also in the
upper half, pn_same_half(pn, lower) is true and the XPN else-if does not
fire either, leaving next_pn_halves unchanged. An attacker that captures
the legitimate frame carrying pn == 0xFFFFFFFF on an XPN association
can then replay it indefinitely, since lowest_pn never rises above
the captured pn and macsec_decrypt() reconstructs the same IV.

Extend the XPN else-if to also fire when pn + 1 wraps to 0, so receipt
of pn == U32_MAX advances next_pn_halves to (upper + 1, 0).

Fixes: a21ecf0e0338 ("macsec: Support XPN frame handling - IEEE 802.1AEbw")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/macsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..cad95b7ec631 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -804,7 +804,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		if (pn + 1 > rx_sa->next_pn_halves.lower) {
 			rx_sa->next_pn_halves.lower = pn + 1;
 		} else if (secy->xpn &&
-			   !pn_same_half(pn, rx_sa->next_pn_halves.lower)) {
+			   (pn + 1 == 0 ||
+			    !pn_same_half(pn, rx_sa->next_pn_halves.lower))) {
 			rx_sa->next_pn_halves.upper++;
 			rx_sa->next_pn_halves.lower = pn + 1;
 		}

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260520-fixes-b8b72f2ec0d8

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


