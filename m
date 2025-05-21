Return-Path: <stable+bounces-145787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D0ABEE9E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCCE7A4628
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FCD237713;
	Wed, 21 May 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="XL7H9zEb"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2052.outbound.protection.outlook.com [40.92.89.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE433F3
	for <stable@vger.kernel.org>; Wed, 21 May 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817635; cv=fail; b=MG0/+6B++yfmb9tTDzR9OkXCBk07rtU2euMkq6BL21KskK9M9lErwKArn4vlHTkfS/pq+J00aTuqXuog03YvrNXSJQMrG23l5xNkd3uH+ZJjEMJGPnrLlQJOzXyXsudCZFGvyPmxImc97E7EN2XYweMwwkU/oAbGKaPcLCIG0Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817635; c=relaxed/simple;
	bh=EAhhnIILjWJCsbloygIe+GEBe1UnjnFugc9cXpUmNak=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=FBBMMsRIXPeaXy/VKMS4XRXHcuDQHjDWhdLBcp7tEW3D+t6hjwt++6h/ftTmL3eLdFkpO6FgJcp1SukpVRqBbzel+V5c7mQNYUPjeeSw7j+F4pwvCp8u8q1OEWR/fMoLXLe87anIfRniwBgC7IFArfH7v+4cFd5xjMOkb51V2FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=XL7H9zEb; arc=fail smtp.client-ip=40.92.89.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdZ0mA7sLnskxGqSeTYAK3lRil0tBrdUeMNujfez/9WTr8jBUMq+6/wiLRdzQodwYO0X6+ZZTixA8Nxao7BKPhDGizf3dntC29rEkZAWpsmScoQADtby0MUF4h0h04pkw9SHW/FRuQhsOM+F9H/qH4mUeMvGc9d/okxBL58nafPna1TCl3QiUltZdlYA3ruAhp+oXxYM5WZZ/XG5iOQZS99DabI+ezfBx7naUkjvEnrtMujQCJhW9hQUM+N3TwM83z4l09ybEuujcaumCZcuNWT5XnqnmCbqNdXQlpdRo5lPrD8TDeUw50/6z/6X3vNB3E0tXaET4ndd+C6Vzk7YZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvS1F7T5aMHkoS/CWeJPHcqO4iI23CDax1+g4MvTpzc=;
 b=fFRgPvrc43owRcL+tmYEMTb306/PCqUw2nq6g5W2R0m5pF+NVOHFT0qOxOsNk33LJfeWcFoL5yorbawYujYkvyHMzuTd2TMt7a0YxIwcy9CcZ+ml9iEkIPH4DdRBj1F0dqe+gtUCt/C11lisBROyMozikLRIZDPWYX5gej8P4xxH+WHIILnCnndYbx4wu+ZFguOF/hdLFvdQxH605fmUQmnu3ynb+EVmO08ojDRB0BsLgp5DXw0Rx9JZkai/Io15no4TaACv4X0gC0/cpS3xxEK5yWdEcLr8G2D1BwIN2Dde4hgmGr9LY3W2jKzKKrOl+FhVayKoNRcZRt45YxNvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvS1F7T5aMHkoS/CWeJPHcqO4iI23CDax1+g4MvTpzc=;
 b=XL7H9zEb0fZxESHvCQZqan4bCBS3YgwwPRL6Q126lKw8Ge8gQ6nHvmnLH2scsgZ7iXaTMTkDYh9uFJJ3uLajwNntVRBQbYCmfMZNthuDqcoANv7ds0DHaIl6yWLcXf0cKRRnhI2U9z65l8r+mMHVYigi1NZqA/0KGI7BGlab2RSooT+8BNxjKGiitVNdlvp7XdnOt1i6LHWXGHmXRpijugFAMEXFJk4r469SB9MRJC7HyqtTuU2Qr9t1vtAo29IAFtdFOvWfQbSAkYMriqozLOgdjfYjoWrIlzS/fqITInK14BIrHIstB8zKS5oDfNDvelsJPiTwiXuryjlv8F3OZQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by DBBP189MB1273.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 08:53:50 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 08:53:49 +0000
Message-ID:
 <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Wed, 21 May 2025 10:53:48 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
To: stable@vger.kernel.org, regressions@lists.linux.dev, denis.ciocca@st.com,
 linus.walleij@linaro.org
Subject: Panic with a lis2dw12 accelerometer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <4d085bd6-25e2-4568-975a-f2ec4131bf84@hotmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|DBBP189MB1273:EE_
X-MS-Office365-Filtering-Correlation-Id: a92c9bfc-d79a-4ec0-213d-08dd984500d8
X-MS-Exchange-SLBlob-MailProps:
	CLk2x5OX5VbtPgnz4S1zjFDaJZfzufkhroFcFIlTMNAwBDz400JEwXDkyfwqZ5fPFd61FTa8Y9fCGGluxW2i/QkxzGOZTKY0KTSUdk9fmb0eqhf1oXgVZzIOMwvwq2HYLNkJZC8/TyTc9ilpy/pM69Wumfab6gLg8Dl8xLFFay5F88BPYUNhPTkk//0CJDPNh5dDQOqvuSzu/2RVA9GHM07D2S0ciscNF+LBMeT4y2hVK0V8LA6xh71hxLsxmHlqdRkmdIEXwSfAHTB0StwUWRwA+edA6iAXJFi2gLmb6ud3x8KUG/tETewnKOt4Zd7geg9HG5FQ3elGmaWpaqyWzCjZs97LWWo/OSNVOKuBY+yUk4puTfFrJBRe/pjCyVNGyB8oSbw4BS6HvXghnmiWRT+KX1IK/gYXoqR9mLrDXul9gHqdlT4pljzctGOnC6ygFvTp8UvJcgGUlX8THus084FoGQlZ3W6jWxKKAqx5ZRzNiKOjwWBTc+7AMd0qC0DTfkPv4hRsVRFYVLQRKDVjvCQH69XEmjHtLh1OL0EhwXRGtR7IDe1rQJeCgaZVqxXAYQH2L/B+7hBiPfLmRVTdgaibVAOC8Vbwq3QibqYrISMmd+wNC9Nhdyh4V8sfUuXAOMH5TaSKlWRVusoae8jsNxT1NfTXpod3HpHyyfzhVua0LBYfD0EGEAqJbxTUaFQtxuY4blYvYfgJKiRwMPt69A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|8060799009|5072599009|461199028|6090799003|41001999006|19110799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3dKSGFtbmFKTFJkY0tTODBWMXFiaWdXQWcyWTduUVNCV1o5Y1pZTm9nT1VW?=
 =?utf-8?B?WGVlL3g5TGgrWU9PQTF1enptR2hYajZ2NXZaem1FOHJ2cTYydkhBRmFmUGUv?=
 =?utf-8?B?Z2ZYMWRueUoxYm16T1haYW5jVCttRDFKc2twWVNZb3NMeHpJcGRmWXk3K3I0?=
 =?utf-8?B?aER5VHF3T0pCNmRLSWU3bEYvN0xBTVcyUUUza3k1ZGNXRzZ2RUw2bVpPS2dj?=
 =?utf-8?B?M0szTGpQM3J1dnBzcHQ4YVVVeGZJRHZlYk0zUS9sd2JrZnI1eVQxa1p0REs0?=
 =?utf-8?B?TGtkTzEyRU9VSFBsejdZWU1JRWVsZWo0YytwVThOcWtMYlhWeFk2TGE1N3BE?=
 =?utf-8?B?NGpYMVBidEhNcWNXSzZRTjBlQm5BL2RCaUVKRERLSzgxTGdZbzRwa0xMQVdB?=
 =?utf-8?B?Mk9ZMFNEUmpDTjJpT2EzYjNiem9JZUtkTW5ZcUFZK0FIeWJkNEd4M1l1djdN?=
 =?utf-8?B?cG5VeTFNNXQwNExGdWNuMnZMYlhqMll1VTFmVFc0VmxiRFArTC81QjA0cU5q?=
 =?utf-8?B?REhPcmIrK1VjN3B3OU5Ka284Mi9HMklac3VMTU1QL2RsMXlWQmdmeGZJMlFW?=
 =?utf-8?B?c214c1hjMkh5cTJqNE1JSkJLaW13a3pWV3dEMHBkOVdLQm5KNDR1M3RINXJL?=
 =?utf-8?B?cFpVSUR2Lys0SUxXOWJKRTNIcXpFdHpGMi8xd3JYKzQ3S0haMFc3RlN0NlU2?=
 =?utf-8?B?TEZ0ZXh0MytsbXFINk4ycDY1V3hyVXFNRTY0OXhKc01qNVE5a0RBYzAzUHRE?=
 =?utf-8?B?bEFkTnV0WHY4Sm9aWjVMcytuQmtCSFBqL3FRL0wyaTE2YmdsTjYyL1hvK3Qx?=
 =?utf-8?B?WVJBRTdNNnltam94QjNZaStaNTd2L0JqakU3eVBvNEZvLy95a0Eybno1dWpr?=
 =?utf-8?B?ZE4wRktWN25DWnd3RUdxeDUrVHhJRVRySGpFWi9nb1UyN2FDalpHbWJhMHFi?=
 =?utf-8?B?NGljaW9pdkFwWUZ3eE5Lcm9HRG5mVFNhVlZkOS8yQ2NHTnVjMHJJVXkxNDJN?=
 =?utf-8?B?TFJoU0M1U3E0dFFFd3JzUnA4a3VBZWRTUTlGMjJhQTRXNFIvK2VKMGVwVStU?=
 =?utf-8?B?UkxFQ3E5c0gwTGtmU2ZnNmprY1VhMEJ0M0RkYjhLZFV4a0YvTjl3VndCTlZX?=
 =?utf-8?B?Mm84LzZqMHdnL2FTWEE3QmV5bzRhNTl5S0kvWTY3cXBBajFkV2FnNkRCSG1Z?=
 =?utf-8?B?OTA5TWRER1NQeTJDTWZjT29DSXlZcE5Vejg2UjJZSHY5cldVdCs3Q085RDdP?=
 =?utf-8?B?RVVlVmVnemJqNy9RdDBYbHh6U2F0eU1qZkVlTWZMR1pvdEpZZDVORjR1ZjFT?=
 =?utf-8?B?Zm5ZdC9wWmhvVlhnMW9SWnJFekx1bDZQU1llUXdZcERRc0E3OWxkOWtUMllH?=
 =?utf-8?B?WmlwN0J2NGJwZ1o4TmpxS0RFQ3N5dnhSMmpQU2RFWFJLKzJkemhzY0lIZUNy?=
 =?utf-8?B?dlUyMTRUM25qQlJ1RzhyOGl0a1NGZmtQelNvdHVEbEN0UE9LRnU0SmtuaW9z?=
 =?utf-8?B?S3ZIdEhNQzE2NHRNdFZTMGpUMldoaWQrMTdHR3Z0R0ZlVmwxcWFOaXlSQngz?=
 =?utf-8?B?Mm8xdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBxMGFIY09HM2dyKytwd2FOZ05WQnc3SjdjbE10d0Qxa0diUEdQMmF4bDYz?=
 =?utf-8?B?RS9aNStabk9qdzJWOEgzVkM2NUNselFyT3VSenU2OTFaaXJuVGZHT2xVYjlW?=
 =?utf-8?B?bmFDK2JScENKZSt1Z3NJQTFSbkJ1bEkxRlVTNVphNG5HWS9zUGVBUkdIYy9x?=
 =?utf-8?B?UXZjWkE2Mjh0citFdWhrTDUwQjBvN0dTZmNVZGdPek5TVlY0MEVDNjdYc0Jp?=
 =?utf-8?B?VFNWYkoremxldldmS0FUMVpyT0srTXU2K3g1dEdkdGJSYnhPZVRVWW5qL2xK?=
 =?utf-8?B?M0pSQ251TzVVOERkQjhVL0plSVRBREZPdzdsdWt0Rm1UeTlKVHZ3bTlzM0li?=
 =?utf-8?B?aVdLVm0zMWp0NGdCYW44cWlNWi9WeVlQZlMxQjZVQXdVOFZaTFN0dFJjNFlT?=
 =?utf-8?B?bVhYTnZjUjhQOE9TTVUzanlOTVF2UzV4enNkMnQ5Nmh4L1JmbDRsWG1QeE5t?=
 =?utf-8?B?Rzc5YXpTajIyd0c1a1l6eUttQ3pVaTlCN2NTTWU2MVJ3aERNQm5zaGlSeWFQ?=
 =?utf-8?B?NGhKcllUR1pxSDhNdEMxbWlzdExzQ2h5VjBVOGlDMTMrTXB0WWJueSs4cUJI?=
 =?utf-8?B?czJzc044d3FxTnM0dklPbmZwWEo0NlZqQnRuUVdpSXYzNlRaV0xsQ0NydU9Y?=
 =?utf-8?B?QmpjeVhhZ3hEaEp4NEJ1UFV0bURvU2oycHBoQXV6cThaN2xDaTNBRE9BVzlZ?=
 =?utf-8?B?UHFvNm9BTkdCN0tvRUh5eXNmSWExRE5rTVJNZENNcjJINEVqS2U1SnhZNklS?=
 =?utf-8?B?SW02ZGQ2Y2FQaExWQ2dCNW1QWW1kK2dYZExtdUxCYkVZRnRpMnAySTNiVVg0?=
 =?utf-8?B?RzZGSjE3ejV1T1Q4SzBZTFBxYklhTGZETmVWYlFZK3dlT1ZoTEJ6bXQ5K09u?=
 =?utf-8?B?M1ZlYlBFSXFweWdHLzI5WkkyUU1ncjBvUEZaZ0ZvSXhURjNTZG1GdytBMFlO?=
 =?utf-8?B?V2d2V1Y3SHdrcENjMmFTZThRY2FIcC9lQ01HQ3ZNOFJtb3FTMWNVVWJUajdB?=
 =?utf-8?B?QXFiSkovYitmaVlGKzh6ZDZJVXllWXhSdURyNmx3dC9jYnBTZTdKNkV0ME9X?=
 =?utf-8?B?U3UxaTNhZkd6aGovaWZhTTBqdlJDU296R0tDaDFmK1NiSmFYaTNTQWxaVHJJ?=
 =?utf-8?B?N0FlY2xhZWNRcE8wYVNTR1JOMW5tanpCUnBXV1NrVG5wZW1DMkJJTmxkWFRE?=
 =?utf-8?B?b3hiWlVRaCs1em1nTWxXWTB0eGo3b1lVNHV3ZGRrbklBVUNCUTlqTHlRMVNh?=
 =?utf-8?B?U1BPZ0ZieThhZGpJZURtQVNqOUhiaFdEOFN3ZHJCcVlZNUx0aFBNVzE2Q3Fx?=
 =?utf-8?B?Q3ZvSXcreHFMb3IzbHhLazBQbmx0U1lmbVR5ODg5Yzl0RG1ZTFNaU1JDcDUr?=
 =?utf-8?B?Mld5M1JBVHliTDNjbUFvWjdrRnBPMkFiZzBhYk5HN09RdXNJbURJM01ubnNo?=
 =?utf-8?B?RXNGZDBndXNCdTRudEhBcW5JZDJxbUFkNGc2R05YdDlLTitwZnhadVZsUkZN?=
 =?utf-8?B?OE92STRQZXBHZjNhZTVGSjRKS1B1RERzZ2JMUnA4ZXQvNkExckhoZTBjWjFo?=
 =?utf-8?B?M2Y4b0F1dXU3cFRacjJPUm1MZHlBV3o1ZzRBaThsY0MzcEEvTDdOZ1FET1Br?=
 =?utf-8?B?di9ERlFFM2lVVjlFekxwdklaQXlzb3ZCd0N6Z1BkQk0zMm5kc3FXZ3dTV1My?=
 =?utf-8?B?c255WnVZQ0dWMlU3bTEyVjJ3MEZ2WDArSzFPcEJLOGxOZ1ZpaFFnUmJRTkRr?=
 =?utf-8?Q?5PhNnJB9epyovZQcuXCC3hEQ41kdZ0B57h4lC84?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a92c9bfc-d79a-4ec0-213d-08dd984500d8
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:53:49.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1273

I've just experienced an Issue that I think may be a regression.

I'm enabling a device which incorporates a lis2dw12 accelerometer, 
currently I am running 6.12 lts, so 6.12.29 as of typing this message.

My first issue is a Panic:

[    0.281814] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000000000c0
[    0.290626] Mem abort info:
[    0.293465]   ESR = 0x0000000096000004
[    0.297230]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.302558]   SET = 0, FnV = 0
[    0.305619]   EA = 0, S1PTW = 0
[    0.308766]   FSC = 0x04: level 0 translation fault
[    0.313649] Data abort info:
[    0.316534]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.322032]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.327093]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.332413] [00000000000000c0] user address but active_mm is swapper
[    0.338774] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.345044] Modules linked in:
[    0.348106] CPU: 2 UID: 0 PID: 43 Comm: kworker/u16:1 Not tainted 
6.12.28-00054-gf24728d836e5 #13
[    0.356983] Hardware name: GOcontroll Moduline Mini (DT)
[    0.362297] Workqueue: events_unbound deferred_probe_work_func
[    0.368143] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    0.375109] pc : device_set_deferred_probe_reason+0x58/0x84
[    0.380686] lr : device_set_deferred_probe_reason+0x50/0x84
[    0.386262] sp : ffff8000816d34d0
[    0.389577] x29: ffff8000816d34d0 x28: ffff000004099d08 x27: 
ffff0000040998f0
[    0.396724] x26: 0000000030a40000 x25: ffff000004099be4 x24: 
ffff00003fdf2758
[    0.403870] x23: 000000000000000f x22: ffff8000816d3508 x21: 
ffff000000260a20
[    0.411017] x20: ffff00000409a808 x19: ffff800081299db8 x18: 
ffffffffffffffff
[    0.418163] x17: 00007fff7e57efff x16: ffff8000815ad000 x15: 
ffff0000002617da
[    0.425309] x14: 0000000000000001 x13: 0a7365696c707075 x12: 
7320656c62616e65
[    0.432454] x11: 0000000669b8cb4b x10: 0000000000000020 x9 : 
ffff8000816d3590
[    0.439599] x8 : ffff8000816d3590 x7 : 0000000000000000 x6 : 
ffff800080fe16a6
[    0.446745] x5 : ffff000000260a3f x4 : ffff800080fc3912 x3 : 
0000000000000000
[    0.453890] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff000000260a20
[    0.461037] Call trace:
[    0.463485]  device_set_deferred_probe_reason+0x58/0x84
[    0.468715]  dev_err_probe+0xa0/0xec
[    0.472296]  st_sensors_power_enable+0x50/0x60
[    0.476748]  st_accel_i2c_probe+0x70/0xe0
[    0.480763]  i2c_device_probe+0xfc/0x2d8
[    0.484692]  really_probe+0xc0/0x394
[    0.488271]  __driver_probe_device+0x7c/0x14c
[    0.492631]  driver_probe_device+0x3c/0x120
[    0.496818]  __device_attach_driver+0xbc/0x160
[    0.501265]  bus_for_each_drv+0x88/0xe8
[    0.505108]  __device_attach+0xa0/0x1b4
[    0.508949]  device_initial_probe+0x14/0x20
[    0.513135]  bus_probe_device+0xb0/0xbc
[    0.516974]  device_add+0x594/0x7a4
[    0.520469]  device_register+0x20/0x3c
[    0.524224]  i2c_new_client_device+0x19c/0x3d0
[    0.528671]  of_i2c_register_device+0xd4/0xfc
[    0.533033]  of_i2c_register_devices+0x6c/0x140
[    0.537568]  i2c_register_adapter+0x1f4/0x728
[    0.541929]  __i2c_add_numbered_adapter+0x58/0xa8
[    0.546637]  i2c_add_adapter+0xa0/0xd0
[    0.550389]  i2c_add_numbered_adapter+0x2c/0x38
[    0.554924]  i2c_imx_probe+0x2b0/0x6d4
[    0.558679]  platform_probe+0x68/0xdc
[    0.562347]  really_probe+0xc0/0x394
[    0.565926]  __driver_probe_device+0x7c/0x14c
[    0.570286]  driver_probe_device+0x3c/0x120
[    0.574473]  __device_attach_driver+0xbc/0x160
[    0.578920]  bus_for_each_drv+0x88/0xe8
[    0.582763]  __device_attach+0xa0/0x1b4
[    0.586602]  device_initial_probe+0x14/0x20
[    0.590790]  bus_probe_device+0xb0/0xbc
[    0.594628]  deferred_probe_work_func+0xb8/0x11c
[    0.599250]  process_one_work+0x180/0x2dc
[    0.603265]  worker_thread+0x2c0/0x3e0
[    0.607017]  kthread+0x110/0x120
[    0.610252]  ret_from_fork+0x10/0x20
[    0.613836] Code: 911a8021 97f9326d f9402681 aa0003f5 (f9406020)
[    0.619931] ---[ end trace 0000000000000000 ]---
[    0.624551] Kernel panic - not syncing: Oops: Fatal exception
[    0.630299] SMP: stopping secondary CPUs
[    0.634543] Kernel Offset: disabled
[    0.638032] CPU features: 0x00,00000080,00200000,4200420b
[    0.643433] Memory Limit: none

It seems that indio_dev->dev is not initialized in 
st_sensors_power_enable(), this causes an issue when 
devm_regulator_bulk_get_enable() fails and then calls dev_err_probe with 
an uninitialized device.

To fix this I added:

indio_dev->dev = client->dev;

just before the call to st_sensors_power_enable() in 
drivers/iio/accel/st_accel_i2c.c

This fixed the kernel panic but showed another issue:

     0.440413] sysfs: cannot create duplicate filename 
'/devices/platform/soc@0/30800000.bus/30a40000.i2c/i2c-2/2-0018'
[    0.440422] CPU: 0 UID: 0 PID: 43 Comm: kworker/u16:1 Not tainted 
6.12.29+ #6
[    0.440430] Hardware name: GOcontroll Moduline Mini (DT)
[    0.440435] Workqueue: events_unbound deferred_probe_work_func
[    0.440449] Call trace:
[    0.440452]  dump_backtrace+0xd0/0x120
[    0.440462]  show_stack+0x18/0x24
[    0.440469]  dump_stack_lvl+0x60/0x80
[    0.440478]  dump_stack+0x18/0x24
[    0.440483]  sysfs_warn_dup+0x64/0x80
[    0.440491]  sysfs_create_dir_ns+0xf4/0x120
[    0.440496]  kobject_add_internal+0xb4/0x2d0
[    0.440504]  kobject_add+0x9c/0x108
[    0.440511]  device_add+0xb0/0x7a4
[    0.440519]  cdev_device_add+0x50/0xbc
[    0.440525]  __iio_device_register+0x718/0x924
[    0.440535]  __devm_iio_device_register+0x28/0x8c
[    0.440542]  st_accel_common_probe+0xd4/0xf0
[    0.440550]  st_accel_i2c_probe+0xa0/0xe0
[    0.440556]  i2c_device_probe+0xfc/0x2d8
[    0.440563]  really_probe+0xc0/0x394
[    0.440568]  __driver_probe_device+0x7c/0x14c
[    0.440573]  driver_probe_device+0x3c/0x120
[    0.440578]  __device_attach_driver+0xbc/0x160
[    0.440583]  bus_for_each_drv+0x88/0xe8
[    0.440590]  __device_attach+0xa0/0x1b4
[    0.440595]  device_initial_probe+0x14/0x20
[    0.440601]  bus_probe_device+0xb0/0xbc
[    0.440605]  deferred_probe_work_func+0xb8/0x11c
[    0.440610]  process_one_work+0x180/0x2dc
[    0.440616]  worker_thread+0x2c0/0x3e0
[    0.440621]  kthread+0x110/0x120
[    0.440628]  ret_from_fork+0x10/0x20
[    0.440636] kobject: kobject_add_internal failed for 2-0018 with 
-EEXIST, don't try to register things with the same name in the same 
directory.
[    0.453688] st-accel-i2c 2-0018: probe with driver st-accel-i2c 
failed with error -17

In /sys/bus/i2c/devices I can indeed see 2-0018 present, but it doesn't 
show up on the iio bus (/sys/bus/iio/devices), so I am guessing 
somewhere in the driver it registers it before it should, and then again 
when it should.

This is where my ability to fix thing fizzles out and so here I am 
asking for assistance.

Kind regards,
Maud

