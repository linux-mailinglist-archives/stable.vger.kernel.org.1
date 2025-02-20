Return-Path: <stable+bounces-118442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05BA3DBFF
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4764318988E7
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05023EA83;
	Thu, 20 Feb 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="hPYEkM3F"
X-Original-To: stable@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020078.outbound.protection.outlook.com [52.101.171.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF230282F5
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060129; cv=fail; b=L2ZxKRu+d+w83+UwZRUR1JB5zuYEosAiD5PoQGfg+i+ul2347RZ35vCRnUOy/4MwL4/ZqB4G3+4x8RY+OVKBF4p8hLg/ulPk2SdkA+nw0visD+epfrH8pNHx4RX60AUgfKSNtl0RjAPxM6Undutn1J2mH+QvvNYNG/NpitUOyok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060129; c=relaxed/simple;
	bh=Asto1aliJnhSL3kEm357P3pLlaWi+52O37TQB7rZjIo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J4ysL+ULpevE+7NdcfXYDklsz5L81trMWb639VfSWUH1ZbdyenDueAN6wusIBhqlaOLVSC4eKyQIakg20ZeoaYC2Om+pLMguNVEUTjQwWQiQQF1gahvCAfWyi/36eD2HSZkBEMh3OzkNte2KCsRFjcaD9SL+5N+VdCBrpDWFzQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=hPYEkM3F; arc=fail smtp.client-ip=52.101.171.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqevOk7fMV22hzUqXzCvTbX5ucqINhqRLmgxddoO6lCnBdAKBxMZKwyFNBOXgUeCjvVn1VmvfjF0wXEGPUUH9CC7Tm31nefuvoZAgAHTiL0iSu05VVUhtCyiHqhxzGsrzBCrez3nXoAQIuMzL99H3STyuoks88tXCC2it8JFiPy5gdV7GV1O1daDjF8JE3UVC7P4ImLhZYi7rZmSPow+3ddzWsKVrb8GU8/dm57w5LBRHm/eRUFh4lONm/K+UVuCmOtlxwC7XFXRdmFTtn1yyJOaEieRLoQ6yPJTFaucVzA1lOahkImb/FMY3wlCIzgjdBdOhuP951gfdY0UQaaEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Asto1aliJnhSL3kEm357P3pLlaWi+52O37TQB7rZjIo=;
 b=BdOKNQZhCL6KW2sKdnCgbaLq6VnGszUj7rO8tLsyjMj6QOsT6VN9DoQGpNrz8hWalg0gbMVp0Id5RCOcUiQdW1t3tDaTnsoUSQYOBA3IPGqAnpPKp9gUhm3OYHBVXLv1i7X7BtFuIBIKuKdEUS8qzArAozP+eIgFQxqcnBKR9UWq+6PS9qWD/TCAzcsPhQ8TTEayVkke5tWo5be3kB+eIRk1+iLdln5V0jdqg90jdLXChCfbtK6aH8cicy8/JldCrmtqHuyFjm3ZxgiJiaLKBVXECLOlfta9jh/vToFzqy2x775GbQ5KBh0yTEY4Nz2pYr2+3KjHSDlYV5fsPef3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asto1aliJnhSL3kEm357P3pLlaWi+52O37TQB7rZjIo=;
 b=hPYEkM3FjSILJDfu0+fZkbefwftiMXGm6duQwKYnFalsPb9555TzU81ytOdpfiPZTCuQdtf9oV197TZ0GEe5ba5TmfpQ0BAbhHhzUqR4/VOkkcD4PiEBJpPDk11CR/IWmOKCzItXcL75Hlo8ISo33sr/wQ89B2A5oMPM7SAEpmU=
Received: from BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2e::12)
 by FR2P281MB1767.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 14:02:03 +0000
Received: from BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM
 ([fe80::db36:9894:a488:d087]) by BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM
 ([fe80::db36:9894:a488:d087%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:02:03 +0000
From: Kamila Sionek <kamila.sionek@adtran.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Backporting patches to resolve rsa-caam self-test issues in kernel
 5.10.231
Thread-Topic: Backporting patches to resolve rsa-caam self-test issues in
 kernel 5.10.231
Thread-Index: AduDn+bwcW8o9omYQASgAFJdOGbhKw==
Date: Thu, 20 Feb 2025 14:02:03 +0000
Message-ID:
 <BEZP281MB3029E2F4767A20F1571F7E0B81C42@BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_ActionId=708f9bd8-e057-42c1-b4b1-d2ef7298cf16;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_ContentBits=0;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Enabled=true;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Method=Standard;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Name=General
 Buisness;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SetDate=2025-02-20T13:55:21Z;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SiteId=423946e4-28c0-4deb-904c-a4a4b174fb3f;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB3029:EE_|FR2P281MB1767:EE_
x-ms-office365-filtering-correlation-id: 48935234-c2f2-42c2-c2ff-08dd51b726fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aXDJ1wyxxgB3ZBLaQQCVB6JTPLi5lVt+qXq9xgqMQW9pIsxGQCShMySUHKdA?=
 =?us-ascii?Q?oHZfiqP05vNGlsti+zK1Z34Vgv/B9hNMN5deXRnK7bjz7mvTDcs99HG6txjO?=
 =?us-ascii?Q?IHWcLa/14IsJkXqfpLSGWKdGN1P8FEZHxIsvj9AQjIFihBHe1HNvVTmIJm9l?=
 =?us-ascii?Q?Ax/jgL5wi6OKi0loT5qbSyKiVsNuNqQjHiXCEp+5ao09cAlcgLm7Ruos5RrL?=
 =?us-ascii?Q?2BOnc2ZskZpl1hU+ddBCUv/4zN+C5MFwcOtGsroxyMqP9E8E7EjBfpoPco4P?=
 =?us-ascii?Q?CXdTSYnQBXkH8r1iQEa9rz11auaIuVsxpv8AGgKOuEGsucVjWy3e0IL1abY7?=
 =?us-ascii?Q?5y2N9efaTUS2WwJWKNnf3S4rw9Wy6zzps0Z+WbeZU91hIBwt57gUOa+Nqgdm?=
 =?us-ascii?Q?HZCS+c+ucpcXgB3bk3WX/P4vPblG65PhSslzR4ItUsu/BhbiOgGSj3qaqKdW?=
 =?us-ascii?Q?uQYmwVaBtagGUmTv2dW5odaIkrOzaVQb9E3gYM3PBwwP0BelNQiagbK3jyyK?=
 =?us-ascii?Q?zqOYyP/sLaK0ON0bFSLnRWJEK9E+EHsxfsanASJaOQOWfJdJmtyDWAU+IDjb?=
 =?us-ascii?Q?A9WF+L4oeajMhCwEB+CzKxqZBuNNjGbStdjh4mSl5MUR4lyAKXvPm0Zo0Igc?=
 =?us-ascii?Q?G8PJKlac881tgaXIE2gCQv9l54t62FW0vudJpZcOoQyQ7iRdz6rKxB/4hdFz?=
 =?us-ascii?Q?51LWtbwhK0apuxJut4jjAcjp8G58eD8cMbWaSb1HhQ8zzgN+bxAl2Po1g8de?=
 =?us-ascii?Q?SefA6bPzwUXloGxJ09OlL0sm7byndQtrIvlSA73dobXxiZHliBMGffPMnEJq?=
 =?us-ascii?Q?puxV1qwL677uYYB5cBkvI9jSUZIPmr157jSC1SL/Zl1uhtO8ylOTGCipblXd?=
 =?us-ascii?Q?aQF9dikPwp3HmaG9ZNQj+6A1WxN4QXvdMxr0l0knmRjer+WU9DTNxCgt52LN?=
 =?us-ascii?Q?X2cAdFq1ryYqV/9dAENaLtVMM6T373gHRBmUMfHasMj6Xjqr3sAAHTqH4DLn?=
 =?us-ascii?Q?dRQWN0qVEmELk2lDDTgPPb9zi3pkrtNyPgc1CDfjEIVjlpE1LcKnsBttcMMX?=
 =?us-ascii?Q?BQLCUDjbYNWLxTDq9q87jDcW8zFim5DO50Cxc/NwWMpC2QVlHeJsQNJ7hXSM?=
 =?us-ascii?Q?u4u+25wicmcOEXs7L7DUn5lCynr3RKTnrbquiVRKTUd+zgerGNCyU84pp6Sq?=
 =?us-ascii?Q?cD9YB5BnoF6VH9Y1Zc+LViv4XmvjTYHNYAtLRfEgjRKoRAcyhDjMMw7FAl05?=
 =?us-ascii?Q?ZNZB7khznOsT6/CvjQ+2hJLS7W9sdssE9Y8p6jGVkHHaKDBdZO1UuLRkaE37?=
 =?us-ascii?Q?jp3Bkqd05HItvJJfrZF4H2z5oSrkEjRMSbMGH3nL4ZSi2JTIiBEYznSImd4y?=
 =?us-ascii?Q?7ltxZLV5K7n6aZexLklig+37loPEHlCykzE1kmnyDQnzxbFWSHeadA82FZQr?=
 =?us-ascii?Q?1bU1QJCtWam0VznO1h28Bz3eGPWUsZ1s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gTeqiAv/i5NxKoqQzubfJyBSl/7erIHOvyHNG5GLOkP97YCzOpUVrykbD+7H?=
 =?us-ascii?Q?v7SH/+U6CPMTBx795ZzaGLWOKlapRboQZjQOXsbxplwHZrwwz27eHgGnOlDV?=
 =?us-ascii?Q?UaLG6b6V5Xtst+3hGoBqMzKmq/i+8rUp6dNvS5CN/UCKhTY9B3x5QMRUFTqh?=
 =?us-ascii?Q?hk3zbKBt5qKkx97I6OdeGXhWGGa0+JGpNGCBBkL/GFWOfpL27hsUQZRxQGtE?=
 =?us-ascii?Q?g61lVQbFiNUbr3s3Ea2PGEU6Dq2BtdIeoPDSycznAaAeyUe4aAwUeBRTp7on?=
 =?us-ascii?Q?oLS1nu1/whoINfnIgrJNeUgXzIHExDZ5BcwZPwSjllzByK+yZ3FZP53kNYdw?=
 =?us-ascii?Q?XvakYP6meVygOAjzV6MCUTiNJEg9fPT4vT6lfU7CGubTeZwWo+/ShY1J0kV1?=
 =?us-ascii?Q?epKmsMMz1mbHKPD9WRb88oEgPtBA18pRf1Lqbnjk4+6nOe6TFz5nhQQU7b/P?=
 =?us-ascii?Q?frnX7N/KUh87YiCydtog6MsQ0shlRyr7mCKThngwYbGBvl8SRATKCNVesvQr?=
 =?us-ascii?Q?HR5O67th7T9TO2L0uE3AvmqSsLYxuaV73GzwE3hKi1c5t9C6PonwutXOovsz?=
 =?us-ascii?Q?axMSwPTHcPehAkFk4lapZGe7XwZj5i8IyPiFUl7tQDy97XGg5leGKlZ4B7lC?=
 =?us-ascii?Q?29ss3pI3wEF4piGgLugQDCPnBk2hpYzWkHwW6U/91+vHZrh4Dph/VQtXwkYz?=
 =?us-ascii?Q?GSg4zfqhyOZ9SXZ++QtI2iRDjc7aPhj9nC90+680IA8S577ZxCznMqpbs6Fa?=
 =?us-ascii?Q?R6j61h1r29+oBtT+aYG3W9pHORdR4ISBwVGXXxm+itkZ260oRKUOU/GJ9rB6?=
 =?us-ascii?Q?8izdGK4x5ouJAi3NBB874kInFPp5V1SiLm+PbhnVABUU2rdwWnrSF+8pYUp3?=
 =?us-ascii?Q?XE02y5famG/WFA6tVqv01hjoKt+kyT0+2UMp0FgSL3K8wa8M7iYRdNdQt0/o?=
 =?us-ascii?Q?wcr/DxJzTbVKqpE1KWhkqLBSaeaI6RTgmK2c2uFetl/tK3XDGpxzib3U/SM7?=
 =?us-ascii?Q?P8p28qS3qE9JtgjeoAFkxsmrUwC06mkje6esYdQBbBSwK0gkplO9Ozyo1U98?=
 =?us-ascii?Q?ozyqYCriRAm14/fdBP4XeW/VM3v3l9JO1QXlhBO60Rg0gHJLmDYgIq0PYbQs?=
 =?us-ascii?Q?jyh/d3Z1In+Z5PDjYHnAiye80MO67KoiOhWgKCT3oGE/JMzvCKzFC2mLEzvD?=
 =?us-ascii?Q?jbL8XmqLKtG7VVUUMokikdP3PrdwEyvB2T6R/nhY8Pp5XxkzuUpUGiHnE4Dn?=
 =?us-ascii?Q?2WRZ4uJuEjtTeOAuYTa48cRi74Jbw5I4HtlZ/0AtTSBzvNEM0WBLxUWcfqtt?=
 =?us-ascii?Q?qW0OO4oGpl71UzWiNJzba9GLuFRnEJLjpOKuUmi3A5ij3nhJQM/rHpz+qYh+?=
 =?us-ascii?Q?EuaG8Z1p/lIbkYhpAdVymTWaisOBJCpfuhPLxD1YXSOa426PxvAbfC6bMPUd?=
 =?us-ascii?Q?/ZUuRptbqGTwyLIzyfzvKdBes7zr6n/vQYFqQmHGrrCnfD4Q7AFOqlGjDuCr?=
 =?us-ascii?Q?/SfRJhnvvY5t+LsocVCpy8cCxtp9Z6WDbmPnEynPuOgUVuJpnMI0Mqfkdelq?=
 =?us-ascii?Q?eyVpEiIezeQrQiMSsMwhAShGFsU6QqVrpr+gBb37?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 48935234-c2f2-42c2-c2ff-08dd51b726fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 14:02:03.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7I7d9kUC1v+s5ZtW2lQetCQk05iubbRJqq6G92ws60Vk0Z5Fsu09ETNM8eaGH5wfIGzELjmSDGvZJztIVvrNW65bbrxN/nY+tCtGSlCJYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1767

Dear Maintainers,

I would like to bring to your attention the need for a backport of several =
patches to the 5.10.X kernel to address issues with self-tests for rsa-caam=
. In kernel version 5.10.231-rt123, the introduction of commit dead96e1c748=
ff84ecac83ea3c5a4d7a2e57e051 (crypto: caam - add error check to caam_rsa_se=
t_priv_key_form), which added checks for memory allocation errors, has caus=
ed the self-test for rsa-caam to fail in FIPS mode, resulting in the follow=
ing error message:

alg: akcipher: test 1 failed for rsa-caam, err=3D-12
Kernel panic - not syncing:
alg: self-tests for rsa-caam (rsa) failed in fips mode!

The following patches should be backported to resolve this issue:

8aaa4044999863199124991dfa489fd248d73789 (crypto: testmgr - some more fixes=
 to RSA test vectors)
d824c61df41758f8c045e9522e850b615ee0ca1c (crypto: testmgr - populate RSA CR=
T parameters in RSA test vectors)
ceb31f1c4c6894c4f9e65f4381781917a7a4c898 (crypto: testmgr - fix version num=
ber of RSA tests)
88c2d62e7920edb50661656c85932b5cd100069b (crypto: testmgr - Fix wrong test =
case of RSA)
1040cf9c9e7518600e7fcc24764d1c4b8a1b62f5 (crypto: testmgr - fix wrong key l=
ength for pkcs1pad)

Thank you for your attention to this matter.

Regards,
Kamila Sionek

General Business

