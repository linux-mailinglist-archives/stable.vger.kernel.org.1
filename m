Return-Path: <stable+bounces-3129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642C7FD0C4
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C928281F
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF94211CBD;
	Wed, 29 Nov 2023 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lineo.co.jp header.i=@lineo.co.jp header.b="BwlwBNr4"
X-Original-To: stable@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2111.outbound.protection.outlook.com [40.107.114.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E519B2
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 00:29:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9xa03WE97EGRyy/NOHjQ8FTMhtskoexjRSRYxMTUAqdht6AOBQSOIGYesnUSnKtWXWGWLo/CE8JEW7uvHqwaTbbPBundeMlMBBZeh7Hhbh/EjusJEa2/r6X4wi1XezYXbfGM7oHMSpAySGcIZSilY8rvvOFykjXPp7Ef5V90csrN8DDCiTxtoMASerHeDgoDjdTkoTWMx4ibYLR4d0An9inXIuS3Az4aQiYflKTI4cEO6R3VC5AbNVujdea3y4oMjOv1FA+NqsSL7WQ8eDSRDSw5Z2EH3D3pwQk8aZz72zaLPVTGs+tdp0I2pRMhjFAIx0IDoilEzSFLEwZJc8H9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ko/Y2Y3NWCyGXd9WQ10Uw7R+JNVp7Xo5kL6lTbfIqE=;
 b=R9s10hE86Ss7LEE640DYn5tUG+x/25O8f2YryUGDjfp2VPQPPcS5b6iUl0Ff0Z8r1m+qTfgjeAnXFSP1qe43UCVgMETRm8oxZJqC3HGk0WZjtOMz0a8sW20V0jpow9KbKohc9gkkbgyaEgy6SJQ1GGxEcAG34bnvMZopf42W+BLIWxMRmZcqLi2BPpeqN669TjixhTURHxz0HVX/+EMwwS5YdYGZATxf7MD6IERFVG+3tLZ5qq4mfbBkTEQ09hQwCuSxV3a5EvE23d71WYukQW7RChCijFXcevJtsr1Gl7F/nYgK2NYzKWU52c9wXIVNPf9T5lVUVlYlEvXXCdj/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lineo.co.jp; dmarc=pass action=none header.from=lineo.co.jp;
 dkim=pass header.d=lineo.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lineo.co.jp;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ko/Y2Y3NWCyGXd9WQ10Uw7R+JNVp7Xo5kL6lTbfIqE=;
 b=BwlwBNr4G1nVU+YC+oDayuPKjuKK180PGyUqYMWffZSOCF6+GVB12ETdgxGKENPtGMcIydqsxgBthsfXzlgKQxiiz3mMiofiL3c4WiOf08EN7ITUShg8FBsgaWcrFBdGnp33tAhr5fzk9EnJ5HxkMetvswi8Y1X6RX+x1KquzTvSX5S5VzQok3VAq0gEZ6aq9tpVlzvQSr9zxpqH9GyJXfqtEO5h5KXzSU+YMdC2ke18DOqAp9KGDChvlfGeNpkB8Gz3WFBTpHqwD1bGWTIb6A1iiJgoI0pi/XWIOa+bcEHxQEItICnODo6I3EjasmN9bJD4LuLX2KlCaPsor9v/kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lineo.co.jp;
Received: from OS3PR01MB8115.jpnprd01.prod.outlook.com (2603:1096:604:171::9)
 by TY3PR01MB11722.jpnprd01.prod.outlook.com (2603:1096:400:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 08:29:14 +0000
Received: from OS3PR01MB8115.jpnprd01.prod.outlook.com
 ([fe80::9538:79a:d7:b2a8]) by OS3PR01MB8115.jpnprd01.prod.outlook.com
 ([fe80::9538:79a:d7:b2a8%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 08:29:14 +0000
Message-ID: <1dfa7e7f-233b-43da-b0ea-0ad3b1f69a37@lineo.co.jp>
Date: Wed, 29 Nov 2023 17:29:13 +0900
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Yuta Hayama <hayama@lineo.co.jp>
Subject: [PATCH 4.14] mtd: rawnand: brcmnand: Fix ecc chunk calculation for
 erased page bitfips
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: Claire Lin <claire.lin@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 Yuta Hayama <hayama@lineo.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::18) To OS3PR01MB8115.jpnprd01.prod.outlook.com
 (2603:1096:604:171::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8115:EE_|TY3PR01MB11722:EE_
X-MS-Office365-Filtering-Correlation-Id: 177b105e-1f09-47d8-88b5-08dbf0b544f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s4+o0ADvjXm9OP1FSv3umFIB+FDrHrPFgQtySKpwp5H0hZiFH+5jm79xRNh+6x21FCEqr/aLoAknmu8n0hP9/T1dejP4vQAOWCweYHH4wTAOMNb0lSTiecZEPEROY8Ve8y4yi3eEhpf0xEx82D71k1R5Jo1iJNfirvTPLBkyLkxdWk118ckMKvwl5Z2tFw8PflhEo5zKD0Xn6weLnTDgBUUu6qIqnho8s6LL9/g8FgTNXBKTlYsrXoZGQyOpKFeGJ6yFIy3jhQboWugwisrDl1yz8jxjpZnYenn8DhYMrDMGwkPyKrNW7oYzbl/poDoQ+UIkXa8WRdbCL0TMsUUjqJP3b+5O21qUqEhbX55Dci2hI2P1e61JmCpbOciFG5qHefTGEBWOZiJv75o0aL39Ux6pnyREiVR38yBtpsueerpeW/ZQzN/A1y5U5tvDcHmqKK9LYlms5kjZCWcN7wDjATUw8odKfs+mW+qUgiphPbqMiAEiRaCBKpNn8kcp4LuX2y12MDgxdzNPwDLAlYA4Gp6bqzvv06k1tnCCiqqNT4UImhlnjyKNytRwvKvqkpTeY0JVJ/SoHSLN0heQjm1XbKzZXpYJtS+sPxEfSvX0T91p8hr4o+gLPmerMjsQh/G+2GYhpNjuLVHaA7jRldHfQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8115.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39840400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(478600001)(26005)(2616005)(6506007)(6512007)(38100700002)(31696002)(36756003)(66556008)(83380400001)(2906002)(4326008)(54906003)(41300700001)(86362001)(5660300002)(107886003)(110136005)(8676002)(316002)(66946007)(66476007)(6486002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEczZG8xekFXRlRsMnFqV1RMZTFNeWFQajBnMThsdmpyR2R1eG9xNU50dElW?=
 =?utf-8?B?NXpNeTF4aEE3djl6ZTNpM3ZKWElpZEd3Uzd2NDVDQzdXMjJXbHRjSmNOTFFa?=
 =?utf-8?B?enlZbXR0Q3kzbEd1NjBxcXZneVpEdHNkVVhBRDBrZEF3OVBnK1V1VzhETzNB?=
 =?utf-8?B?cXp5R1NWWTloeGVZN1FEanQvcEhpc3pUaVJrRzZrcVIvRGxQSVFUT2VmWmtT?=
 =?utf-8?B?ZXgxY2M0djRZd3ljbmZXbVJZOE1kNnoxRm1PajFsSHlDWWpLdW93YXJTWVNn?=
 =?utf-8?B?WUVmWXlTaDRaeXlSUzlqaGtZYnE5MDk5WGtKTzlrTnJaWHYzNDRwT2tLMWJy?=
 =?utf-8?B?NkVxc0d2d0hHSHQ2TkcwbXhDQkRVdTV3RjY0LzlmOG1aZHZBWEw5blI5Q1E1?=
 =?utf-8?B?MGxNSTcvZDlRaDNpYk9aRGp4MVlKOXJUZnpmNjYyVXhBM3I1Ri9rRlA5MUVQ?=
 =?utf-8?B?MWdkUFJTaU9HWjk3eHN6NGZLNThWdmdDZjQ4TWp1NVI4cEIzUHNZVXp2SXhQ?=
 =?utf-8?B?eHBGeTRFYTlZOFBFWXp3VjFnMXQ1RU0rdEJhNThFYzZYUjNCa0VmYkFUK3Iw?=
 =?utf-8?B?Rm1YMEdPaE8zM0FUN09xM3ByMXh2VEpmdlRxVDJOVFhhY0pPaHJ3YWh2UUpy?=
 =?utf-8?B?am10SEZmWnhFaER4cVF6b21oYnA4Tnd6cTROa2ZkRlEyaUpqd1Fhb3FNQ1hZ?=
 =?utf-8?B?VVo3Q2NMV3NyNVd5VWR5R1A0Z0ttM1BkbTZvU3FOTmRMaGpBVkpXdmVTSFUw?=
 =?utf-8?B?R3grSVYwenBtMU5FNVY5dkZMeVRvY3JXeXFUVU9ueWNJTENobTNUbXViSTMw?=
 =?utf-8?B?NmFCSWROK1BjWTJsUndocnJtTEgxL1Q3bVJBbmNpVGhFUmw2dnZTcGlIdHZF?=
 =?utf-8?B?SzE2czlPd0gwWTlwQ0J3RHJwcHJhdzJ5U2lQTVNtN2VNTVJwQ29hc2pJdU53?=
 =?utf-8?B?VlpIeHg5NmxueTJUdEhnVFV0TzdtVGVicGRjSjJtQ04zTGwzLzZhOHZ1bmRk?=
 =?utf-8?B?czRyZlhFM0pCa1hLWURxMEVheFBtUXBJdStnTzlhc2tUd3Y0S0VDTWZya3hP?=
 =?utf-8?B?V1Q5bHovSlY0TmRsK1Y2WE5Qck9HOTJnNnpNWmJwWTlZb0V5aXVBVWN0SGJX?=
 =?utf-8?B?N0tlMThnMFJYU3FHcC9KV3g0T1JadVJIVStrcFdKS0ZLUjhPM1Q0czQySlgv?=
 =?utf-8?B?UTJycmxZcnYyTzIyaFNaRkMwdXJXaFg1SmYzMWFOclpBQXVOckl3dkIvbTZD?=
 =?utf-8?B?OWVEUXRmTHczSCtzZWFZN2U4V04rL2wyUjVmSlRHd0dxZ1lyRUFRWHhrZEk5?=
 =?utf-8?B?WTVaRmdmRWFTdGNMa1kreFF1bUFHQmhOUkxIc08rNG1od2tWYVVWcFFxN3lW?=
 =?utf-8?B?UE5lYkh4RW5OOXhxbSs3MUxlbmpqY25WMElzeHRzTkVROXVySVZsSzA5TE1k?=
 =?utf-8?B?ZHd3RUFMRzhFYTU4Mncvc01qQ09QeWpJRER2N2xGUUgyYUNBclIrR2duSmlk?=
 =?utf-8?B?SDRGWGFBRTdCWjd0dlFVdTQyVDhoaEJVVWErT29jNG0ybzNCbTN4dVFOaFJ1?=
 =?utf-8?B?d1NoM0tBdkJpYWpTYU1sbzltayt6RFRlNGFGZFJld3hkZk5EZHcraCs4bnc1?=
 =?utf-8?B?MFlVRGFzYTBxejNRVGlkRnE2MExkVXdMdWhPTm5abFNRZ0dRTFdjZldiSURR?=
 =?utf-8?B?TjlwejZQNERmQnF0UUdZNVVCRjIxbVN0Z3RPTzVZWWhzRVNvYU02UnplYnRr?=
 =?utf-8?B?cFIxQ2s0Qk1tR2xwUUJCSy9Sc0ptZUo0OVEwakdyQ2NWNU11WGhLTUJCcTVy?=
 =?utf-8?B?YkgxSEg2TXVKWTdaVHcxTDdXL2lEcUxacDYvN1dHV1hzY2JrQ1Y3UlcvcXgx?=
 =?utf-8?B?TDJGTk91MFpGL3YxbWhLbkdobDVGWHRaTTFlN0txd0lkWHVjbElCaWR0NUJ6?=
 =?utf-8?B?WWdGQ2hoT25Na1hHYmFGelNYUFhwMmtEUmpRdTh0dXVLSlE4YWJvM3JObnNw?=
 =?utf-8?B?Qm9uRXVGZWJaM2xER1dCVDdnTWx1L0ZPTmttV2lpaFJuRzYxQUFWN3ZndVQz?=
 =?utf-8?B?UVNicGJtTWhGNjNFcWVVMG9wbUY4YThUK0RmOVo5a2V5TzdtKzVkUFdiVy85?=
 =?utf-8?Q?N/OSk+K4Ll3ScXFfdSMjmM1cK?=
X-OriginatorOrg: lineo.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 177b105e-1f09-47d8-88b5-08dbf0b544f1
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8115.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 08:29:14.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 850e1ad4-d43d-42a8-82ab-c68675f36887
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kQ55jlScHLFsoee6G/mKcgW94gYAv/jU/sblW/NtqWQaKGvS70fEsNC4EkXoB555B79StmaOJUC2hAlmWxahg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11722

From: Claire Lin <claire.lin@broadcom.com>

commit 7f852cc1579297fd763789f8cd370639d0c654b6 upstream.

In brcmstb_nand_verify_erased_page(), the ECC chunk pointer calculation
while correcting erased page bitflips is wrong, fix it.

Fixes: 02b88eea9f9c ("mtd: brcmnand: Add check for erased page bitflips")
Signed-off-by: Claire Lin <claire.lin@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Yuta Hayama <hayama@lineo.co.jp>
---
After applying e44b9a9c1357 ("mtd: nand: brcmnand: Zero bitflip is not an
error"), the return value 0 of brcmstb_nand_verify_erased_page() is
*correctly* interpreted as "no bit flips, no errors". However, that
function still has the issue that it may incorrectly return 0 for a page
that contains bitflips. Without this patch, the data buffer of the erased
page could be passed to a upper layer (e.g. UBIFS) without bitflips being
detected and corrected.

In active stable, 4.14.y and 4.19.y seem to have a same issue.

 drivers/mtd/nand/brcmnand/brcmnand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index fa66663df6e8..267bbba09afb 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1753,6 +1753,7 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	int bitflips = 0;
 	int page = addr >> chip->page_shift;
 	int ret;
+	void *ecc_chunk;
 
 	if (!buf) {
 		buf = chip->buffers->databuf;
@@ -1769,7 +1770,9 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 		return ret;
 
 	for (i = 0; i < chip->ecc.steps; i++, oob += sas) {
-		ret = nand_check_erased_ecc_chunk(buf, chip->ecc.size,
+		ecc_chunk = buf + chip->ecc.size * i;
+		ret = nand_check_erased_ecc_chunk(ecc_chunk,
+						  chip->ecc.size,
 						  oob, sas, NULL, 0,
 						  chip->ecc.strength);
 		if (ret < 0)
-- 
2.25.1

