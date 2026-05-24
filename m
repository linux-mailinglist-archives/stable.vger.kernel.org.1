Return-Path: <stable+bounces-254001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEmCAjqpEmrL2QYAu9opvQ
	(envelope-from <stable+bounces-254001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 09:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5C5C19A6
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9B5300E3B3
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97721366065;
	Sun, 24 May 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kIzvBkPx"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012014.outbound.protection.outlook.com [52.103.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81021E2834;
	Sun, 24 May 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779607850; cv=fail; b=bIO7Sgd0sjr8hNgZ3Ovymto2xX6swa0uMzGnO4hG+X5ntCbd4qM6IcNmYxU1u2FKDSwZz+LfYJPsLAf2vlQPUOOjmWsPJ2OAtowW1T2Gc0w3p92LhqhjtAxBgtrNV7AWlEAxQPQbHzga+TK8Ko2GjRwkCSGc+5nMNgc6ppPG0/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779607850; c=relaxed/simple;
	bh=kPzttnAh1oPowtqkIiCnMTU6FkjO+AXHxo8baXK6xyo=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=epNJxs/Paul2aTx5Yq09BPTXfukVSehTMguCYu2XYLC5NjKviQM8peKvodKbB3lzWjeqCZYzfPtoVkHi/R2UnRl9MeWxhMZ1V7NLrNIEz35y+4o0C17uz5dd1aV0uTShh2xTb0w2ps2uSA75YLx+x8zaGAXpAh3kh6airUKCmrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kIzvBkPx; arc=fail smtp.client-ip=52.103.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRQek/oLSSEaWKC6EER73bNh66LDYtqivp6YZiQ/WZoDJbkAeh7J18NzmOmrUzCubcA1cr5YqedIwMQEHapKxcoY38Yib3ksnBE9MMGlCD4RDCKzGl5KLhblA0v0oFh1wCStJMU4U5lXT3LkodlYMmJ0zeji6BH2vaKSgnyz60M4DywdGebhVs5u8hcqa0WGx/77tQ/yNQKr62eEFqIO0zGQ76s62l9W8bmEvLHr3fZZqM01JhjwMwvUr4TYuxxiJe9sYo0H+S8w9tNEDZSiWANCV0qHNpSfp5BI0lXhdyzk6GOJWfLW01CdIazjez39kxrOSm1xDOu2V+pmrOlyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl4pfrBszuFHS2Lapz3YWyZztbQv+ZStZ7TTRdkjr8I=;
 b=A313z4CfTgepdkVpWDu4Ut1BCIAAHBvp4QW0OfU1B/v7Jo+nAZ9vQb4g3Cw8dsHJG8c3a+J1yluOBpW6/zMXcsTlbcG3YMdUp9wVfkC0xM4DGxgCK6Wlae/v0EjAFw18LtdoFhvxb5VUM8Ei8Bt1WBKOyL8ukgA3V9bO1lyaHvQHQ9cLRa2NEXvK3dD2OemGMR6bQErS2+sq8PyG843oz8ih+NXkJY9XczNpHQ6sOgtMlhl/fK9/9g55diBeNboSO+1qdEM4wLRH7pEdg1Liig4Bp7tRM5Lm+rK/iZPr9pN9F1ci6Lh3DI2vDQTXI693Irwi9XHXhnfvzMWUssqscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl4pfrBszuFHS2Lapz3YWyZztbQv+ZStZ7TTRdkjr8I=;
 b=kIzvBkPxOiieAFQUrQKfPIYX+zbMDwDAbHDvLdKVXtWL61oXcFqt3r+7LB3+O2QwTbSZN1150Ky7pvPnFDUVuoGcnL+b4+UmrElAKhKJ4+5JRgHYICRu9eZ5EvGjVeJJTREjlDqJ1L2/1mCopqV8b4xSoF4VF6DgBIvMuThHDW1OlYRAQ0uRR1bmf53kM0V5ypLRh+j52dleGCnpfDHxw5+Sfu7YbkoaBrtgHPQN00h1Z96K6GpcTND/8OrSlklXtZAbUU4k/YopWeGr6KN7cUJSBcEyjzrDq5QeovXZ0CzeLMkXy0uh3yHMkw7qlsDZYdiBfpJu5kRNTkhBUvq0Yg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME5PR01MB10155.ausprd01.prod.outlook.com (2603:10c6:220:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 07:30:43 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 07:30:43 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sun, 24 May 2026 15:29:29 +0800
Subject: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE sharing to same
 PF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIANioEmoC/x3KQQqAIBBA0avErBNMS6SrRIvUsWZjoRGBePeGl
 o//KxTMhAXmrkLGhwqdiTH0HfhjSzsKCmxQUhk5qVFEerEIrZ0zwXrvowV+r4x/4HWBhDesrX0
 Lm46YXAAAAA==
X-Change-ID: 20260524-fixes-33bb6d8cccf8
To: Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=kPzttnAh1oPowtqkIiCnMTU6FkjO+AXHxo8baXK6xyo=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLKEVNxTcb03dxv920xLpio/H/t+VOhQX63vn60P+9
 oXHlKLsi+93lLIwiHExyIopshwvuPTNwneL7hafLckwc1iZQIYwcHEKwEQ0NzIybDNkeBLBwpp9
 Nch57Zni5xqKvL+OsmWYJh4JvsZy7dDqEEaGI75Jb4XkTZsnrWJfdfSGc/2a57efCL9547bmTDM
 f1/ZP/ABURUyC
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260524-fixes-v1-1-c5396a69e940@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME5PR01MB10155:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f4f131-5018-445c-e574-08deb9665c75
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|41001999006|15080799012|23021999003|5062599005|6090799003|5072599009|24121999003|22091999003|55001999006|24021099003|3412199025|440099028|40105399003|52005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1lYRzdZS3BNYmtMdWJvVzZaZUZiYjdWOU1UNGY5cEl3ZVUwd1dnWmlESHl0?=
 =?utf-8?B?TExDZzY4ZklRcmh5dmVsTXh1dGxYcDBiU2VrM0lHaTZOZ2YxRXpHYXd6TTRN?=
 =?utf-8?B?VWN3NVN1QWd4UVRySkZtd3JJeFplME8zK0Jlb1pzL0VrdlpiS2QvR1l2SHEx?=
 =?utf-8?B?dWZNbDA3SUtVYVU0NHdJUU9QTmNzSW1zU0dGbktobmJjNHZMVFlzWUM1SW5u?=
 =?utf-8?B?UTVjOWVUL2xCbUxZK0hLWThMczVGa1UrR2Z4Yy9Dd3ZvdlJDYTM1WEpwYUd2?=
 =?utf-8?B?S1pQS05KMFpFRzdBWncxNFZnUlZVNmVDdW8wSUd4ZlVnalhaWmZLdnhGQzh6?=
 =?utf-8?B?VXJLNjluVnBiYzM2eEEyaHNpQS9BS0VGS0hUMEVDQ1dMYVkrSmx1QkxVNWFX?=
 =?utf-8?B?TlpPbjVXWSttYUFjQXh0YlpJWVNweEd1VzFubWFNTExabE5HVmd4Vms0bXRC?=
 =?utf-8?B?ZHQrY3h1MTNzNzl5MHpwWUdhaUZwMVovNGlnbTB3OEV5SG5uMjJCMFRoTzJz?=
 =?utf-8?B?dXlEV2drcHMyWTF1ekM1NkNVdFJTL2pFRDZpLzdzT1pzTVY4NlE2TEpqWnhZ?=
 =?utf-8?B?Y3JKOGVJMFJtT2pMUkRja1VteEc5R1N6N1o0WGZrbmtCNFZVYTR1RHZncENx?=
 =?utf-8?B?bENwem94bU1SenJDOHhBbmZidVdJbTM1UGg4bVdUQlN2N2NlRU9FbE5STmdu?=
 =?utf-8?B?bTQxOWtvNEMzSXVZWVJWdUJUSEZua3JyZFBqUWVmT29FaDcxQlh6RWpyancz?=
 =?utf-8?B?a09ZcitZRHJES2RqZVlab1lvTW5naG1lWmhjNWU2N3RnZUxmUm1sbDVFaU9l?=
 =?utf-8?B?aTZkMkNSV09SV25Nbko1QURvbU1OL0QxaW15Y1FwVExTZWF2SWRZa1J5Rm1q?=
 =?utf-8?B?anpPUFBkMi9Na0h3eDgyaCtOamFrQjRKTkZzM1hISjZLZHFTR1oycWdoOXNj?=
 =?utf-8?B?WU84b0pOMU91Umc0Q1FuZGxQTWgza2hpRUFQVEJpU1cyTys0M0E5MXRuZzN4?=
 =?utf-8?B?Sjl2Mm14eTAwbHhVS0NlTzhmR1ZEd1JycWtPVEpIRmRyYWRKNmRYeHAwT00y?=
 =?utf-8?B?NDhJMXcwY0NpOUtzVTNNNysxVHVzMmJhdFNmdzl5MGJGN3R6OXI0Ylo2anBj?=
 =?utf-8?B?THB5TUJYQ25odVB3M3VUZUFnV3ZwTHdYVmJVZEdaM1BoODdIb0JFRWtUZ1pV?=
 =?utf-8?B?MC9zZXlQeTZGMnhTWFVnbjNEKzBOSXVFR1NuUGppb3lTUU5MbSs5UUxuOENO?=
 =?utf-8?B?blNWSWlzR2tTZzlHUk1Jb3FvQm9YWWpPeTNUK3NuaU1xNURsdzNPcmx3RVVF?=
 =?utf-8?B?Y1FaZmJxM3NhUEthdHk0akZWZnRlZXNDZUVoT1pyTjM1L2s0cFdOeVI5d3NB?=
 =?utf-8?B?MytVem5Ga1VldWR0QjRyb2NHYWZXbUt4cFdIaVplbE8yQ29IV0pPRVhwQW9J?=
 =?utf-8?B?ejBHME5BdEVKQVB1Z3JKK2EySE9QSm5wdWw3d3RxaXpQRmZCRThLbHBSR2Fw?=
 =?utf-8?B?TlRLS204b200RkVnT21EOGRuLzd3bHVEd1AvZUVFeVcrYWZ2R0xBZUlCeXNv?=
 =?utf-8?B?WGJRdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW01SWtrSlNIa1l3WmVsSGVWUytyNHlTY3ZpQXhMZVRaU01Yd3JmOWtWL2Mv?=
 =?utf-8?B?L09zR0o4TGpOWlRHbkt1RXJIajJBbUFubC9LdldqbEgzZFRFK1lGMlVuRktG?=
 =?utf-8?B?RGdmaFFwNVpaaG4ySmE5V1cvR1RaQ21ybHlWdHIvdC9RQUFJZU5zd05nY1py?=
 =?utf-8?B?TFBuVjV3Z1E3RVl3RmY4enVHY3ZWQU9BWVF0L0Qwb2dMbGYrT0lUQU45ZmFt?=
 =?utf-8?B?N1RTaGlBaWJhbU5GRzdUKzBGL3VmcTBQUnRTOXNpVUxhRys5UTBrTUxucDBr?=
 =?utf-8?B?dFd0NnZhVHBJZ1FkWUcvbVdoNHhsN0JOTHJiNFdnb3dpUmVYb1FUeTJ3RFo5?=
 =?utf-8?B?c1NybHpzZXpWUVhHUm4zaXBsVHFkbjFvT3BJd2FLc0htdG5DSDdLN0k1RnBa?=
 =?utf-8?B?ajFXYWpMdHVqTEZ3MjVCNW42RkRSTjhhNVJDY0lxejBXMElOY3ZQaTlFeDBY?=
 =?utf-8?B?OTNOZEIrQnBjaDdZaDZWNTBlS0krWUR1d2txTmpMeWFZYThMTS9TZ2UvRGlF?=
 =?utf-8?B?VzdHTjZhZUJNSG10aHk2OFZDbW85N1p1SXNhY1RFZlJtVHJjaTdUa3hWZFlq?=
 =?utf-8?B?ZGs5dStMdFRackU5eWVvNTdSaTRYcFNmSlBCQ3lqbGNzQzFnK2hQYitMQm9v?=
 =?utf-8?B?ZWhsTDJRS3JialF0aUFEQ01Pc0p6bW5sTHhqenZMUG5jOFFqWkNBRG9UTFF2?=
 =?utf-8?B?V21iNnJIRHlSdTBFREZ0RGlTWWJ6U01nNVBxeGpMQ09SSnlaVEhPVUZpNWJv?=
 =?utf-8?B?aEo0TEp2QzZ4SHBrL3FBQjkvZzh0dXdYRitHTGFiQ3p2RkVta1V2Qjd6NGZE?=
 =?utf-8?B?RjJ0clFJOVI4a2tBWjdGY2dDSWtJMW5OcTNDeDFBNk51YWVpY1VTMktUbDhI?=
 =?utf-8?B?dkMwWnFwZm1KQnl4SVpob0ZjaDF1Q1h4a2ZsZVl2NFhtTHlxeHcrOHZldzZQ?=
 =?utf-8?B?dk1wNDQ1UDFSblloVDJpNXFzQXl4N3A1OTZqOGhVSG9DcW1PbEUwRzJOaSsy?=
 =?utf-8?B?WGVWU0xKNkQvK0w1QUJFUmlzWjh1VzdPRnkzaE1NOW8vaUNEeFlNWG9vRWpI?=
 =?utf-8?B?bDBMUHdpUTR4MGNJcnlIUVIvZ3o5VGV0Qjg1SnVyRkJkOXAwOGpDVW9SSk14?=
 =?utf-8?B?cVJVcmRDT01QS2o5UEVlNHBhOHBXWWxPVG1pWjM1cXNFc1hVeFlYbmxaVWlo?=
 =?utf-8?B?bUlPSU00S2hkU3hUNm5qSjNjSWlUQjhCMGxPQ3d0NVFiQ0dpSzhXYlFqYkI5?=
 =?utf-8?B?Z05mSEdmQkkxQ0lPcmt5UnRPWUh4clBqajBwaG5MdEFhSkFRK0RjVE9yNFYv?=
 =?utf-8?B?dGIxQ0drT1FOa1BsN1dIUmNCOVU5Tytwd3ZVc0oyQWZtWWpVQ3Z0cTI5Q0tY?=
 =?utf-8?B?SisvZktnSVkrU1VpaU01L0trNTU1K1RiVzkwc3c0NVpPbjNXWDJkb3hhYjdF?=
 =?utf-8?B?V2l6SjRTc2ZqRTZTdmJGMFh6S3loeEIwQ0hqY3p3T1MrMDl1L1BpUkhFYXVh?=
 =?utf-8?B?ZWgyT1E3dXFuZ2JEZlNpcHgwcmc3eWlUVThma2JEekZJT00rRENYclJsQWpy?=
 =?utf-8?B?cU8zbDRMZ1JRSWIvcjNKOW9FSmNVU0Q5R0pGUGZ6S1J2aGJWSFhMeXpwSml3?=
 =?utf-8?B?amgyOE04MHg5Z2Mwdk5xUDdiQktCWTIwMEd0aitSY0xCUlhEbmxLODc2KzN5?=
 =?utf-8?B?SnUxUVF0NGNlSmNuRkpyUGZIdTNYWUE4ZHZpbjZTeU5BUDJPajhlQXp3TVk5?=
 =?utf-8?B?TFZlMHRUUGJKOFllYmkvNFJGK1JzVkxFdld5ampuVEJraWo0WnhBcDlTdHE2?=
 =?utf-8?B?eGtiK285TU1BUElqSURwU0sxRloxdGthZnZWR25tSlYrL3lEQ3B5VXdkZEph?=
 =?utf-8?B?Q0dpNFhvSGZ0KzlPbWNDSk8zOFA5d0hhb2c2QW9Ib2ZPN0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f4f131-5018-445c-e574-08deb9665c75
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 07:30:42.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME5PR01MB10155
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254001-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:email,outlook.com:dkim,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: A4D5C5C19A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rvu_mbox_handler_lmtst_tbl_setup() uses req->base_pcifunc as a direct
index into the LMT map table to read another function's LMTLINE
physical base address and copy it into the caller's own LMT map table
entry. The mailbox dispatcher authenticates req->hdr.pcifunc from the
IRQ source, but req->base_pcifunc is a separate payload field and is
not sanitized.

Reject the request with -EPERM when the caller and base function do
not share a parent PF.

Fixes: 893ae97214c3 ("octeontx2-af: cn10k: Support configurable LMTST regions")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index d2163da28d18..0c27b4b669f1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -178,6 +178,13 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
 	 * pcifunc (will be the one who is calling this mailbox).
 	 */
 	if (req->base_pcifunc) {
+		/* Only allow LMTLINE sharing within the same PF, so that a
+		 * PCI function cannot hijack another PF's LMTLINE region.
+		 */
+		if (rvu_get_pf(rvu->pdev, req->hdr.pcifunc) !=
+		    rvu_get_pf(rvu->pdev, req->base_pcifunc))
+			return -EPERM;
+
 		/* Calculating the LMT table index equivalent to primary
 		 * pcifunc.
 		 */

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260524-fixes-33bb6d8cccf8

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


