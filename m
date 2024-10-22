Return-Path: <stable+bounces-87728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39639AA946
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038B61C2167D
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89419F110;
	Tue, 22 Oct 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="RnStCpdR"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156681E495;
	Tue, 22 Oct 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604773; cv=fail; b=kuUdu+59tARgkI4vEUVYtWDf9LMDK0WjjsgbuQC6ic24fZ/VZxUI1dQv3qtKdAYYMQZnL4wANegjAPQmPAUQSBNECorAn+sPLptHAs7lHX0bO82K2LvlVLnoChngQzR76a5cE/jAfRt8CMATlHx1MoQfZPMhRWRLLgq9uMeTBH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604773; c=relaxed/simple;
	bh=4RRSw+Zzw5CRyaccDSMBFT+SyfM4NlneqrGnwHhg+xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=mYQZyMWEdUa0XRvFWH38nOZI59R/km14QiJuCrgyw5x+Zb74H3podEZ3yxDv6m8VSs2ms/c3fTA2fH67mBlIXLvSsljNn+9XSOmEH4Owyxci7YmGiGSvK2Bm6JeZJEF//V1qNfhZK7yjgILzW2wQdJQGNj8TO9cQgIleAByQ9R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=RnStCpdR; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ4C2qBYRCTCXkUNyPhLLNfY+h0Wwzok863cs8SmP1XQGPEooVc7Asu66hPdH5mZIJU4EsqI7BVbuchNkz7s3bUHR0AgeIYcI0xepLoCPLUqPZZMhI0FKmmQDduQg4YR+D0yvOxe5bL7oAO7hXij7Y9zt65/jpObY/zfzXAKQyt+zb1gReXtQDPTuNKs7BloibGCUg5RDgs95eG+y1ckSQxrqZOnOvf2Z6ykxDfrSaLz/zEO6dQ/HhsgX6HVCzN7mgOIMEEnTp5jswO0dddDncjJ/NtMiBq7Rc4Y/ugMQv7/VgIgOPEPhOfbZyeUSIbG5UDIjsoaegC/NKKRpBOdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Lzly6Sq5sPZYfgsMteaqARJphm13TRBgl/J3hc2tI=;
 b=m1b6EJBn7GpCSVqyd6Mz7nHYWJAZBnc4+oEyaUCldaY4itimfcHoifvzoBvY8GkBhBnj8Bh81/++bdypBObYKcdRN0MEbeoPotPR5cELIk15XkhgeMluFgyQUDEGcT6hNVG1gZ1J4ZVwI42c+bkRXqeU4KIpx1+7BytFAo1ub+mWkHnkmomj4N2Wb9GK4uPPwG7Jb2C3FglYB330MbHe265ZKGMVvyGZ3RnDTjVEeH2bKJFU7qBaNGaNvesCIWJIHxH9qI6NEMkFR73f0gTQXGaCH/mt1xJIx3Z8pdIaJANvuIOkJL0XdiCYgAe+72e0YxP4Hg11f0Z/HF3N1lSNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Lzly6Sq5sPZYfgsMteaqARJphm13TRBgl/J3hc2tI=;
 b=RnStCpdRq0bQrxuop5sEVd+O8DjMTxsKtw9eg26cbBvp932eg3cDXNHiuwB4qtxatarvGdZdYdeYhspMnayvb8XM5qpcz1nYKORjzxSdR+THRLX6fy3dX/eQEzfzd1P+WGwmrxlzxeaWpUUaQacNUWDlzznhQmIwdfU5cIolNP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB8PR10MB3290.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 13:46:04 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 13:46:04 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,  Bartosz Golaszewski <brgl@bgdev.pl>,
  Kees Cook <kees@kernel.org>,  Andy Shevchenko <andy@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  James Bottomley
 <James.Bottomley@hansenpartnership.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  linux-hardening@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  stable@vger.kernel.org
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output
 truncation
In-Reply-To: <CAHp75Ve1WUKYmv6sfGZ6amujs=C7MnxauLM+C2MeW8vxBV1NfQ@mail.gmail.com>
	(Andy Shevchenko's message of "Tue, 22 Oct 2024 12:15:41 +0300")
References: <20241021100421.41734-1-brgl@bgdev.pl>
	<bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
	<CAHp75Ve1WUKYmv6sfGZ6amujs=C7MnxauLM+C2MeW8vxBV1NfQ@mail.gmail.com>
Date: Tue, 22 Oct 2024 15:46:08 +0200
Message-ID: <87y12gp7xb.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB8PR10MB3290:EE_
X-MS-Office365-Filtering-Correlation-Id: 038919ab-7789-476a-72a9-08dcf29fdf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rlc1MC9oZS9DSTJEZy8zNHRZS0lMaFhhSUlhWVhtcGxMa0NDMGZ5YWRSTmRL?=
 =?utf-8?B?MG15ZE9pMlArNEdLWHJ6M1R6cTNYZEpHSGs4R1k0Y3RRWDZ5MnoxKzE2c2hw?=
 =?utf-8?B?SjZYeldqR0VXaVR3T0tFNUlFWUIzT3UwVHpFVis1NFAvTjdGV0x5bXpvTVBl?=
 =?utf-8?B?MUZVUThvRFdKSnNJMXNTd3UvRFNSMjNQMEZaQm8yVHFvaFhDTDllUHB0VlJH?=
 =?utf-8?B?Z29kOFJqNSthT0dUdzFEc05xZGRFTFhRZ3p0V01SaUZsZGprUjVpaEJtUHVt?=
 =?utf-8?B?eTlPZ2dHZ1Evb1owUk1aMHJQREQ1aFFNLyszOUphSkxNd3NvVW5ycXpzNDly?=
 =?utf-8?B?NFhpSWY3UFY0Y25xNUpjeEQzd1J6dmpZa1QrakZHcVc1MHJzSkJ3bHVJNkxP?=
 =?utf-8?B?WE9QTWZmTjJKYno4aWlYNUNrRGZHczdrRDNxVjlkNURabEVNbU9RR21WUUVE?=
 =?utf-8?B?NE1zTitGcFBXVVdMTllaZDNwdnZsMXdMck0vM0YzMEJCRE9xSUlyd012elFH?=
 =?utf-8?B?WG9hU3B0Zk5iSFhtWXhnU3VQeGVPa0FDS0tmem1HMHRsTUNScnJBa09zRGov?=
 =?utf-8?B?MTYyNU00ek84Z0plY2hZOVVYTXFpNU1EUldoRW5ZQ1EyYUtkRHJnYytWSm5P?=
 =?utf-8?B?Wk1MVEpUV0VPVGVNLzRGeGxOWXNDVzVpVklkZHE1aDBIc045M3VsSUhhN3JK?=
 =?utf-8?B?VEU3NEJqRHI5WHZET2IrU3RqM1pscXFkSEdkT3VXbDlzV3ZTd3RBLzVHYWlW?=
 =?utf-8?B?ZGtYM21UWFp4alQ1VHhTR283T2FwQ2NLOS83c1ZTajFKUHduUVY0NElvYkx1?=
 =?utf-8?B?a0FoSm9iNkNSTVI4ejlWYlZmUGUvSWw5V0lmMXVtTmJscktiay9kZFd1cUcr?=
 =?utf-8?B?bGE0SFJKVzFFRVpna2l3R1BQajYzTjJXUGN5Kyt0YjRENXRKVWV1QWVNMWxQ?=
 =?utf-8?B?R0lSb1hlUysvVUlsdTBEc25QUFIySTd6alJqQkxCTTZQSEt4RnRlbUJPOEFW?=
 =?utf-8?B?OXlwUUlpZis2Z3FlUGwyMzFIU2ptOXJEckdJN3h5cnBwaEVweVpUWmJoV0ZY?=
 =?utf-8?B?c1phMFY1WHhlaXBkSjQvZlo3U1VnbW5nRFZ2ZWZsVmZCVXhzd3c3ekViM0xW?=
 =?utf-8?B?dnRXSUc0NWZjWHQyNTd0NXpIbjVCb2twVkJLTS9abmV1U3QyNHNwUGZUYUhv?=
 =?utf-8?B?SzJwdENrb1NEdlM0OWNEMW5zZ1U5c1A1cnEydzN1ZkExMzRYWkk2RUtrTW1m?=
 =?utf-8?B?dFRMSElvc0NkdHRuT0FkRjk2c0lEKzZkKy9naWxPbmRzdGxLa3VvNEVVSzg3?=
 =?utf-8?B?R2JXVGxudTZkL2lNTHJaZndJNGFYellXY24weE9xUURHZDJpTmc1VUJGSlUv?=
 =?utf-8?B?T3l4ZndHbERnWEpqWFpHdFYwS25VMkNwZUV2VWFMY1lSb0Z1T281dm5FR0Q3?=
 =?utf-8?B?MDRtNSt2em0zM1lFdVZXZzgyL3J5ZTZmb2hxZzhKZFVLRlJRRmlJa3E4cGJ1?=
 =?utf-8?B?SGpsVUxyZ2dSdDZaTkVrZU83U3hzV3Juc25CcTJQOWxVK2Y0WTI5SmRYcU03?=
 =?utf-8?B?b3ZBTHlBeTNEUjEyczRQMkhrTUlDcVZEUWh1Um56ZmJ0cCt6MnYwVHlNY2t3?=
 =?utf-8?B?ZkVwWmRrOEQvdkg2elNOK1Ntb1BsdGhCY2tUTHJsVlRhR01YUDZQODFzRkRC?=
 =?utf-8?B?ZlAwL2ZGOENRVFpqUVlxaEpTa2hEQmg1cTgyRlhlZUozTUJZeFpBNlViWkgv?=
 =?utf-8?B?R3RBVEt4UUZpMjhIWTJXa20rbUtMeG9rMHlQSnp4N1F5MlAwdUlIS2M0QzAx?=
 =?utf-8?Q?9+XFdK+BGIYoPvBo3uPo1DfAu1ZXxUOtyrq4w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC9QQ3BqQmJ5RVFRYVNMVHQvSVl0elVIZldHSXJWcTNZWHNVRk9HdTQ4L0FN?=
 =?utf-8?B?QzRDc2xLZ2ljZVJXczlaRmI0VDJmM1N6WTNVUHRpL1FLSmJsazUyQnQydWVT?=
 =?utf-8?B?UGNtaDVTTTRwdmo2ZTgyUFFnbXZWN1B5TmR6UDRXTWtEUk1SUTlySEE4ZEVH?=
 =?utf-8?B?LzV4S0NWZFBqdklsZHhXcHVRY2JYU2I5d2RpS2RUOWhHMEUzTmxtM3UwcTBO?=
 =?utf-8?B?Yis1a1ZiQnBiNVJqYnAxTDNEN1Vva0tzUzhROHNJb0p4aVBuekJYbkx0UkhL?=
 =?utf-8?B?UzNjQnJTZSs1QWFrTmpxeHh5Y0Juenk2ekRqUjRkYlRZMkt5R2tmWG5hOE5Q?=
 =?utf-8?B?OWZGbFpmQ3FweXZTNjd0S1pxeE5DUE80UWw0SVlmM2RGM01GOFl1SXVqV2lM?=
 =?utf-8?B?TjA3ZGcyQ1lkaHQ4YWhQT04rRVRkMW01ZnFmM2twVklHRjV3WlNhL1Z3djBt?=
 =?utf-8?B?SHlyMkpjMlRWYkFDYlB5NlpzUjNRcTZsclpsL0JEaXlzZEdxVm9MdGt5Rmlz?=
 =?utf-8?B?YjgyZjIxOG5PdzZLc2tOOHZQRHp4SEZJLzNCRlMrd2JiTndtS0NRNzZyYWZV?=
 =?utf-8?B?UzRTekNuZGlhVEgweGRrOHo3djR6SU1IaEN5bDRBell0VzBiQndza2pqemRP?=
 =?utf-8?B?bDdWcGFZalh3RGxOTnNISzFkZlZDRWFSVFViNko0NVNRVExJZ2xtc3NpRUEy?=
 =?utf-8?B?eXhjRDFmVzJCczdBcThOeHFBdjBwMC81VlNRWkFnckkySW50QVBBU0JQWE5K?=
 =?utf-8?B?MS9KRGlkcTBjelZJNzRnWTk1dkVZRGhkSkJMV0pRYmVqV3RGQ0ZWTWhUTmMr?=
 =?utf-8?B?VGhUMDRBSVhSNng5UlJJZzFlaTAwTzNCZThxc24rY2d6SU1HclU4eU5rZ0dM?=
 =?utf-8?B?bm9Hc1JwYlkzNjNJckEzN09IMXFFbWhROStpL2JOQUl5TFRlOFBwcU94TURM?=
 =?utf-8?B?a3M0SVYxb09LZGkvN2RDQTRJWis4TWdoeGVrRXcvaUw2YnBhaVl6SkxKdTJt?=
 =?utf-8?B?M2RvdWQxNzdvS1BxcDl3OUl1MmV1TWVQYTRvL2dNbDdDRDE2elZTTzB4ODJ4?=
 =?utf-8?B?eVBnOSt2Vi9xcStUbG1YODRIbVdIYnY1UTZBR28vTFozMHY2MjY3TW9SNFYv?=
 =?utf-8?B?ZHZhRGlPU21SVElqMS8wcmhQbmtUdU9NZm5mUmk0M1ZvVjFubWxvdTE4RGtW?=
 =?utf-8?B?NzJCSWIvWEJFVStnZGMzbG9sOU55WmVDVzY5NEN6UzBzWWNrR00vVzNGLzgy?=
 =?utf-8?B?a1B5dDNzV2NzY25IcWpIeTlBTTRva0FuaWNJVGxEbXJjcmQ4RmRodmkyT2ox?=
 =?utf-8?B?V0MzV2I3OEE5TktQc3IyVkNxNkNEamhVbjV4RnVlL09jM25Wbk1xdm15dE5O?=
 =?utf-8?B?M3Fjb3VZWU0zT3NtUWVVYXZsVVNnT1IzV2N2WUtlaktmS1JNbUVESytqeXpm?=
 =?utf-8?B?UjBRdDBmV0dyMFpkY1RGTUcwa3NoZklMWXFPbSsrYTc1Nlg5WE1zSUJNcHlH?=
 =?utf-8?B?N24xSllBWnIxM0IxbXYyQlIrNGpUV3kxRWcxR3E1UmJBbjJrY2FtNU1lNzUv?=
 =?utf-8?B?N2xrNEdOcW5QNDB1OG0xUlVMRlk4RnhIa1o5SWtMbnVSdmY1Q3R0Rmw3UUNM?=
 =?utf-8?B?U3ZZRjI2WmpBem1Bbmtzd1dSa29SR3RoNDVBM0QreVozcmJTbjhrNHhIZzQ2?=
 =?utf-8?B?VldvYnlZRFZoVytOM3FROExaYVZwdGVPQ2dBUG84SjJtdkkrVmdSYTJMRFls?=
 =?utf-8?B?N0dBQmk2K1cyR2dxWDlUd3VsK1ExY0xDQ0F0WE1LYWxPM0gyT0Ztb0RZZXp3?=
 =?utf-8?B?SnNPdW5zdEZDeVZZSWcyUGs5VkZlQnZCcHNSMDdrb1ZXcTlLRjRFWnQrK2Nt?=
 =?utf-8?B?Z0JUMEZ5amxvaHdDcDB0WFd3NTJSQ2JJNWhidi81MHVoYkczNSs2TElLUzA5?=
 =?utf-8?B?VGJ5VGlLbFhmVHdQY3VxaDc2ZThLS1U1bm9rTlBEUGZqZlIrdHA1SVZodU1m?=
 =?utf-8?B?UU91QndMMmdncHNwcFhHU1FqZkJrR1NUMk95cmFNU2Z0bTMrRVhLZy9iT0x0?=
 =?utf-8?B?T2FRbS82S1NYVUFqUUE1THBwM05IaTBWdEVOU3NWQnJ3YlNtdjVzSlhnVVMw?=
 =?utf-8?B?L2dFMHZjcDdQeDJHaXljYlFOQWY5SVFLWmh0S3hMbW8yTHRrTHlSVDEwb3kw?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 038919ab-7789-476a-72a9-08dcf29fdf67
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:46:04.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2fTzqe5bZU12RAVNzfrLeeMpjGp9mJMcLGqEQSECjI2VetiucH8Vk+e2dTu/TW67lMOTYgsxLqY6QrHJ2o9uFJxL+52IBDXsj2zn/sMdj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3290

On Tue, Oct 22 2024, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Oct 22, 2024 at 10:15=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org=
> wrote:
>>
>> On 21. 10. 24, 12:04, Bartosz Golaszewski wrote:
>> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> >
>> > The output of ".%03u" with the unsigned int in range [0, 4294966295] m=
ay
>> > get truncated if the target buffer is not 12 bytes.
>>
>> Perhaps, if you elaborate on how 'remainder' can become > 999?
>
> The problem here that we have a two-way road: on one hand we ought to
> fix the bugs in the kernel, on the other hand the compiler warnings
> (even false positives) better to be fixed as we don't know which
> compiler gets it fixed, but now we have a problem with building with
> `make W=3D1` for the default configurations (it prevents build due to
> compilation errors), so this change is definitely is an improvement.

Well, yes, kind of, and of course a 12 byte stack buffer doesn't hurt
more than an 8 byte one (i.e. not at all). However, it does feel rather
arbitrary.

Can't we fix the code to avoid the tmp buffer and do one less
snprintf()? Something like this entirely untested thing:

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 9982344cca34..7aa592f9a494 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -50,13 +50,10 @@ void string_get_size(u64 size, u64 blk_size, const enum=
 string_size_units units,
 		[STRING_UNITS_2] =3D 1024,
 	};
 	static const unsigned int rounding[] =3D { 500, 50, 5 };
-	int i =3D 0, j;
+	int i =3D 0, j =3D 0;
 	u32 remainder =3D 0, sf_cap;
-	char tmp[8];
 	const char *unit;
=20
-	tmp[0] =3D '\0';
-
 	if (blk_size =3D=3D 0)
 		size =3D 0;
 	if (size =3D=3D 0)
@@ -115,19 +112,16 @@ void string_get_size(u64 size, u64 blk_size, const en=
um string_size_units units,
 		size +=3D 1;
 	}
=20
-	if (j) {
-		snprintf(tmp, sizeof(tmp), ".%03u", remainder);
-		tmp[j+1] =3D '\0';
-	}
-
  out:
 	if (i >=3D ARRAY_SIZE(units_2))
 		unit =3D "UNK";
 	else
 		unit =3D units_str[units][i];
=20
-	snprintf(buf, len, "%u%s %s", (u32)size,
-		 tmp, unit);
+	if (j)
+		snprintf(buf, len, "%u.%03u %s", (u32)size, remainder, unit);
+	else
+		snprintf(buf, len, "%u %s", (u32)size, unit);
 }
 EXPORT_SYMBOL(string_get_size);
=20
Rasmus

