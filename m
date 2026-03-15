Return-Path: <stable+bounces-225462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG0xDcRCtmnr/gAAu9opvQ
	(envelope-from <stable+bounces-225462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 06:25:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0628FFF5
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 06:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4033C3065AEE
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 05:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA961DF742;
	Sun, 15 Mar 2026 05:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t9PoYWuR"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010000.outbound.protection.outlook.com [52.103.73.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE035898;
	Sun, 15 Mar 2026 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773552318; cv=fail; b=mBJbpsbUVZ0NPUKmxTVP9vSu9anWeaxkgNz9KcZgu6XBtT7Z931a6l9lei53Ik6HEHTS7iagZYpCPLPHi5EC+VKcuT5IgZly93D/WXsPPOvboqnJPnqYdK8aLeAS5OesICi2JqCXrk5j9864BhgJBsLlusCvAhWe1jKpnpJeseY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773552318; c=relaxed/simple;
	bh=O7gNUTdKOjQNLcZNQvqT2REOK5Bjdm2LtOogu/2pAk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJn1V+5I2HhMKvLuOEKTPp5GTJkpUifsyYpeZGlRT4YrzSuXa9n8oqioJ5gbXDMn4VJaU4Qdu38cfEAVBwfLfP8QP2fTRD9LOP1ginjUfP64Ou7zse2KBo5tH5FXDEMPwfnsi4wZShvfHUhCsdGyfbw80QQ1pik1MVjEcWmEjGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t9PoYWuR; arc=fail smtp.client-ip=52.103.73.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFiYGifB09FyAFxu7hsKuegUPnwcsPZmKy4EuPpqbsL4VUHfuuKgd2TnFuw3rC+h5ZaWWkvAawYqnV25uQTJKbSYfwvIk+jIURW2IKMiL5WouQs1fS4ue8QjY/xQljqOtDB0F0gSQjLsjeVa1fS0T2DOV3Cn4oDfYtVlMdDESr+qcJEHHDN6f+8CFn0HIxAc4BGQP8Qaz3NVAFV2/NHwqrZNIw9HBJ34rFjMTGeD8O4T3xtL9oGA6W5urJYFBkBjUQX4XHm6ryWAaOjjy+rlVxlzsAL5QPZIdwaDdmiKU+wwjiyNYuqpwBRoj8sRUOJXk/HeMzTs+j42OdWOzRJqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7gNUTdKOjQNLcZNQvqT2REOK5Bjdm2LtOogu/2pAk4=;
 b=e6AYWx513jlwMh9cVyxxtjwpKzdF54Qqt+tVCrdeygql/IA8xK/tu2lJySdO7Rn53kBbKsrdRcOeQ0rVNlx56Y3ceumHLwaoLvpnoDlllbT91Kiia5WAZcod3NQrpqGhONE6KsJ8GKGw/FZ+nie6GsBbzT5e3LzgfMkiNEZ3HNvih7cy/06tZqs7BoZ8kO+DaXHfYwcnHI2M7mnnrYVeJkHzgfeBd4/JbxXasQ+cLYc+S2WD7+z7IytMDeNf8P2Ly1KxwoE/yaMv6YG0aar5jiBB3sqGXdscB50ygMqVaN4V58E9FVBrA/eRaxiR/Un3NeRJYYIo/E29hld+m9Up9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7gNUTdKOjQNLcZNQvqT2REOK5Bjdm2LtOogu/2pAk4=;
 b=t9PoYWuRh2JXvzclJ9N3WF1cqQN+TB8I/XjSqo/TV58b+cDZHp5yD9VSkhYIbF93oeOFa4CnUDIO2PGk/8DsyFZuqebI0NdDN1pSu3zicq+/eznVwr5vU89p4BIHICXDL283lpoHoKHxaunEuzGmUNWrAWo8fPRr+BUHbnbydXNBYlWL4924QR9BlXLFUYH0UjzrUV9usg7en3GXL37FVdog6J0U2aBFhoAK4uWz362smaXim0ZDravuQ4EK0bKsWnMPyHsmPBqUHTvpzRPwjNJ1xyhKQ8/5g/Y+SUbcp80Q320DGbzX5ovkPV7Hmf7mdxEAHz+cTCMoW1MmGAn05A==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME5PR01MB10980.ausprd01.prod.outlook.com (2603:10c6:220:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Sun, 15 Mar
 2026 05:25:11 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.020; Sun, 15 Mar 2026
 05:25:11 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Alex
 Deucher <alexander.deucher@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Prike Liang
	<Prike.Liang@amd.com>, Simona Vetter <simona@ffwll.ch>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Topic: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Index: AQHcs8hGwEBqfqGCO0+uHWGWL9p3mrWuc94AgACctAA=
Date: Sun, 15 Mar 2026 05:25:11 +0000
Message-ID: <51CF1DD4-7CB7-4B5B-BDF9-3411B921B5D7@outlook.com>
References:
 <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <bed7f0c7-4346-41d0-ac5f-f5a897888533@web.de>
In-Reply-To: <bed7f0c7-4346-41d0-ac5f-f5a897888533@web.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME5PR01MB10980:EE_
x-ms-office365-filtering-correlation-id: 203e5dfc-1818-459d-be8d-08de82533ae4
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|22091999003|24121999003|15080799012|461199028|31061999003|51005399006|19110799012|10035399007|3412199025|440099028|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlNmMk1HU3NxRDl4TlhFMGtGbGd4cXJrVjd0Y0J5NDJGZCtjQ1ZOc1FLSmw0?=
 =?utf-8?B?WnNxTFpUQXVFSzJ5RzlQUzhGRXcvaXFhTW9jTlBRa2FWLzhmczVoVUZ0UnF3?=
 =?utf-8?B?ZFI5ZEtHcGt6VGdtd1Jqc3Iremw3U3plSy9LTWxNZ296T3g3UHRmM05pWS9T?=
 =?utf-8?B?eDU5NGxhSjBvMmlkbnFLWlFVUUk3Y1U3d05vRHpqb3JjYlRmazB2eVVsUk5u?=
 =?utf-8?B?dzIvcFFOWTZzSktFTUd6NkdERXBWb0ZtTkR0OFp3dTZYUmZHUU84a3RkaWcz?=
 =?utf-8?B?S0hQc0k2eUk4V0pmTUJKNFhTN21VanZ4RFYxbDQxeHVaekpVdWlHQU5sWno5?=
 =?utf-8?B?TW5YVU80WkdVNjBBajFNNjNLUXVNWlhTVWxtajJHQnoxamhYKzlvUGRUWGZ5?=
 =?utf-8?B?akNhWlZ0TE10MWlJRGp3aUhBUzFkSDhmMDE5MWhSMm9kNGhkemIrTVdWSFli?=
 =?utf-8?B?bWFCUmlkajNBUEhyMFlWc1RlQnBEa0FvS1RUWHlob1FZTUx1T2pIcDZjWkg3?=
 =?utf-8?B?THJYQXEvTTRoYnl1UnJwbHkxWVZIcEhnanNycmFIOHZXQ3dOdTRQYzVraU4z?=
 =?utf-8?B?Tk80VkQyOFlnbTh1dDhsNzE0cnpnREJSUDRua1RoQXZWazZNYWpzZnlJUGM3?=
 =?utf-8?B?eUJkcWFNRW5zYjljRStDRk9HakVmd1VvVlhkdm9JZG9QYTdxTXZJRjg2LzZl?=
 =?utf-8?B?N2JCeE11RUlFamJGU3NIMXM3angxdjdhY0Irb2xWVWE3MWYyWlpaOU04YjdW?=
 =?utf-8?B?N2xONzZiWjRIMGdjM0NYU2JvSEJiUWZLTHJOaWlsZkhwWGNFZWRQVmZ3aVRh?=
 =?utf-8?B?bG9wV1VuSHFvaTJucFV4ZnlhR1pOK3FyMk5KQUdzdXFZTjJxTWZRNUZ0akZZ?=
 =?utf-8?B?OGlmMG10MHlnS2oxSGVvZGIzYlhpOVNhSFVyVEcrelZuOFVzS2ZSOUlhdFRu?=
 =?utf-8?B?Z1JVSXRZdTNVSUQwY2pkOFdWZFB4dmpHVHdXVHZ6L2dBZWxVVitsbVBReFlK?=
 =?utf-8?B?UkNRWW9VVEVIQ2YwaGNVYm16TmJWYnpCbkNGQ0puQ2l3ZU9LSVhIOVFzNGR2?=
 =?utf-8?B?V1pyMjFiR3BTWU40QmFtQkRnRmp2Z3hBMVJKZ2U3VHBnNHp1T0g0Q1JscVNv?=
 =?utf-8?B?bDNGaVZSTjQ3eU5IUWVSREJ4eVNmVlpZNmtra05wOFR1TnBKa1p6Njd2U0Ez?=
 =?utf-8?B?ZG5MRTlTZDZ2N2h3UXlQejMvdXVham05dTBHOHJSNDQ0bmdPdDB6WUl4NmR5?=
 =?utf-8?B?UXRZaCtnY2RxZXptSlpEZVZOc2l1L3M1Vm44K0xKU1lUWWJkczdGWXhDTXZq?=
 =?utf-8?B?dGVxMHAwY3dOOGd2dW9uRERwaVVtaGxodjd4VEdyRWI5K3gydVRJQ0JqSkxL?=
 =?utf-8?B?cDJnTzRubFI3bVE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXFVOHJmZmdZbjd3d1N3VlJ4Z2hjMW4yZUlQSHZ3Y1RjeGFyV2crZEJ6RFBL?=
 =?utf-8?B?ay9uUEJFdlhZYzZOZUZuWnBLb0Rjd3h0WHQySVBWTEpGYVRVWkllY0c2S3pT?=
 =?utf-8?B?UW1RdkYxbFZOeXNJNlVybStEcVFzTFlaaFJIOWxUK0pmalc4QUliSzF2ODQ2?=
 =?utf-8?B?T2NpWCtFbnVHbFh6L0YydnlpQW0yaTMxSXA5dGZYK2NQSWpxeG42MmVSanRx?=
 =?utf-8?B?V1laMys2WkNuOUp0RGpzRDYvNXBpU0JoV0R5MEJYQXhSVFgyYjMzeFRaendz?=
 =?utf-8?B?MGFvR2JyVlFKYmdLZzNTdFlNS2dSYWFlSHRaS3Q5NWMrY2ZId2MzQUVwZ0xG?=
 =?utf-8?B?ZkF2QzMzQ0ZTY2tGa2ZWOFZTd0FZa0R5MUFxNzZ5bGRFVm5WN1pPR2w2UXBk?=
 =?utf-8?B?bHpFdkJZVFcxNjQyc3IvTi9aNTBuM3pVaTErcHVzRHF1Qk9URkJnamRPUDZF?=
 =?utf-8?B?UDFHZHVUaWRhL2pTTGNIdDUwbmhPZDRyYTNxZldCZUEzSmxNb29GM3ViWGdJ?=
 =?utf-8?B?Z2w3WDlvTkJKWjIydTk5NGo4ME5FZEFLSHFJSjVjZHN4Nm5ZeWExN1Q2aC9M?=
 =?utf-8?B?S0VyaDZkZXZ4TVg2bHlUbXJBSlJwT0ZzMjIxcDU1MVh2MXJDUmFnNDVycnZn?=
 =?utf-8?B?NXdUMlNtdFVQcXhROEpoSE0rT0g4bWxoSk93dlR4K2pobGdNM0lob3o5RE1P?=
 =?utf-8?B?SmlkTG1kSDFndXluK3dTK0dLTVlJMDZOS1BQV3Uvb290MytvY3hNNGVvVTVD?=
 =?utf-8?B?YjNQV1d2SGlReXpHMGY2WitPTWlkYmdVSGRrdlN0ZFg1K0xQU3RnRlYzTzht?=
 =?utf-8?B?YzY2Q1V5NjR3T3Z0NmUyTTBvRmpQR0NZVHhuWm4wRHJ0Z1pKT3IxM0pjWnNr?=
 =?utf-8?B?TFZ4UXYxbG94ZFVQZDEyVjlWc0FVZXgrSlp2b1RtZzB1bFNzc3cvU0FyZjVy?=
 =?utf-8?B?OWthMzJ4YUFSemVtUVFMTUpXdnU0cXljZndsVFZqYjBCTm5Ldm85b1ZISkZE?=
 =?utf-8?B?OWNYejBlb0I1QTB6SU5GY0I2bk93V1hvZnRiYVRhaTUxMnMwaFE5d2pISS9u?=
 =?utf-8?B?OHdjRjE1bWtUcTdFTEUwQ051N25NTzZvUUNyT0JLKys4YTIrdTV1NlR6TWJm?=
 =?utf-8?B?WEsvK2FHUG5ZZG9LM0NQSGw0S0hhME45L1FON3pIeG5LUVVocHZKalJQeTdM?=
 =?utf-8?B?STlKTTdLQk5ZWlhiWlB3dURValkxYXhVZFZpMmdFSmhYZFE0Rk9PQytGa05p?=
 =?utf-8?B?OEFCd1RUcGpHTENEVDRkNWUvSXhiSENjTm0zUTljcU5yRjNZRm9YbElSWXF6?=
 =?utf-8?B?WHNHeWM4VlV1L3YrbWN2NjRHc3JYUGJBL09mQVFpUGExU29mSUtpVUlEMVhu?=
 =?utf-8?B?bEdNVW5xMXo3VjJNbXVUc2tuNXRRRFlKTUVuNkl4REdOTHpFeXJ0NnVHTklx?=
 =?utf-8?B?T01xT08wbVdESUpWb1crNWk0T1RnZzhqM01HM1pCN2ZBbTYvV3NveERzYURZ?=
 =?utf-8?B?anlBMy9PSXc0Q1MvRkNyZU5pb3gzVUI2KzNLdys1VXp4aWUxTXlsYUVRZ1FM?=
 =?utf-8?B?aHhjNkEybWFKTUpCNHdjd2NuS2NZU0tWZjlHbnBSZlBGWmF4YjdZZVZxYmNO?=
 =?utf-8?B?VGpzUmsvc0NSSmxuSnhJSFEvWjh0cHlnWTBya2NSVTAySFVCb1NjcU4zWVQ4?=
 =?utf-8?B?VWZGTitURmdaSE9lYXNEOUFtTURXWEhGMXllRXVvT0NCTUs5Zmp1SSt1Z0c4?=
 =?utf-8?B?cXNpSUVnMG50YS9QN21xUWdObHI5bHY5NFp6NWFUOXJJb0RvaVNvYnozNTNh?=
 =?utf-8?B?VTExRDVyR0s2T3UxRVYzeml2akRSQXNHTDRveEFmTkM2UHBRVHh4ZkdoSE9F?=
 =?utf-8?B?Um9USUFtSUNqelhYZDh2bjJjVE4yY25EdFd6OW1NanFsRGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00BC80C7DB4AE84F9C9A12F51D0B7581@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 203e5dfc-1818-459d-be8d-08de82533ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2026 05:25:11.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME5PR01MB10980
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225462-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[web.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: A7E0628FFF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU2F0LCBNYXIgMTQsIDIwMjYgYXQgMDk6MDQ6MDhQTSArMDEwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6DQo+IOKApg0KPiA+IEZpeCBieSBhZGRpbmcga2ZyZWUoKSBiZWZvcmUgZWFjaCBnb3Rv
IGZyZWVfbXFkIG9uIFZBIHZhbGlkYXRpb24NCj4gPiBmYWlsdXJlIGluIHRoZSBDT01QVVRFLCBH
RlgsIGFuZCBTRE1BIGJyYW5jaGVzLg0KPiANCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBi
ZW5lZml0IGFueSBtb3JlIGZyb20gYXBwbGljYXRpb24gb2YgYW4gYXR0cmlidXRlDQo+IGxpa2Ug
X19mcmVlKGtmcmVlKT8NCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMC1y
YzMvc291cmNlL2luY2x1ZGUvbGludXgvY2xlYW51cC5oI0wxNTctTDE2MQ0KDQpIaSBNYXJrdXMs
DQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIEkgY29uc2lkZXJlZCBfX2ZyZWUoa2ZyZWUp
IGJ1dCB0aGUgY2xlYW51cC5oDQpjb21tZW50IHNheXMgc2NvcGUtYmFzZWQgY2xlYW51cCBhbmQg
ImdvdG8iIHNob3VsZCBub3QgYmUgbWl4ZWQgaW4gdGhlIHNhbWUNCmZ1bmN0aW9uLiBTaW5jZSBt
ZXNfdXNlcnFfbXFkX2NyZWF0ZSgpIHJlbGllcyBoZWF2aWx5IG9uIGdvdG8tYmFzZWQNCnVud2lu
ZGluZywgYXBwbHlpbmcgX19mcmVlKGtmcmVlKSBvbmx5IHRvIHRoZSBtZW1kdXAgcG9pbnRlcnMg
d291bGQNCnZpb2xhdGUgdGhhdCBndWlkZWxpbmUuDQoNCkEgZnVsbCBjb252ZXJzaW9uIHRvIHNj
b3BlLWJhc2VkIGNsZWFudXAgd291bGQgcmVxdWlyZSByZXN0cnVjdHVyaW5nDQp0aGUgZW50aXJl
IGZ1bmN0aW9uLCB3aGljaCBzZWVtcyBiZXlvbmQgdGhlIHNjb3BlIG9mIGEgYnVnIGZpeC4NCg0K
VGhhbmtzLA0KSnVucnVpIEx1bw0KDQo=

