Return-Path: <stable+bounces-235416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCCLNLmx12kORggAu9opvQ
	(envelope-from <stable+bounces-235416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:03:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE53CBBDA
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F6F03010699
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D763DA5B1;
	Thu,  9 Apr 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T2frXNgV"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012066.outbound.protection.outlook.com [52.103.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289383D9025;
	Thu,  9 Apr 2026 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743351; cv=fail; b=i++L7nUk5egVLicT83BxDo7+cJLZxNsXw46MuehWdU9idVALMxBZInEtPsdHbr5+t3evczkm+GbJrz6jXfldlzGPJcIE5Ai/dVtZQOHXyW0So6IRP6wnNE0Wwwl9iM/KwsZq87rLuRrm2QU6BE+yyAZptdAuxQAs69WG4DqM4GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743351; c=relaxed/simple;
	bh=KuqeK1a1CerrjHab+YSagE5vkf263d6aHEI2xAA3cZE=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=WM1XGk5ZBE1yXynB77Hboz7yJu+wBMucGdXRUkJLhvfpGwIHO2ZpD7/3OmY6Kk6ZiO5jfIzcYRxe3sen/tsV/InJutVP9gbgjtBjVdyDXUR9lXs/kFlCXUMJvTuuYQ/yTS2VuHw3tdOVhiDJklbcHhG9iHMO3mvKzfgQrKYEFG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T2frXNgV; arc=fail smtp.client-ip=52.103.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFnwyGHIrk098YJJHKTkRnadXvwIXA2INNNNqoCxtf3GqxtDOhrpPs2nYghblYKyDty86QcJZVCEkKJulFwVaexm7YfpVIdbMvx9Yg4hf1q3C8MrZ+DzeOhUtDdbgfzaqiaaGFy7cXF8vqpviOZsvavr8qgPWKXM98+1wsHm6OpaHJOSHKrpSwVmPEfmriqTsXXnuFU2B3yNbn1wxdntTeUxQp0+M/joI4xJN6kOIJzzm6RineKeUvnDWnHtlRusD+KRT8zyeXYhHXMiFSuw38P4CWVE0FBJNNaOVUJBfFrh1RJYu4wTS4OEY4/1NPfeTJcN+o2hJSq+YmM5Tg4xPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPsfcSR25gE9drHtshtUvGjC4K/f2J/ayx2FowZVqi4=;
 b=ld0oyIj4OvnC+NpsF7bO8G4glvMBv4jpN8Vh9IUeZDDdyNmISqhxGRZPSXDed8K3vTxYj86qC5VRh5RtrV9P9KxrMSYTL7VY2Vuw3GUqyFLllhrazOZ1+KJ/dMQQ0GiH3a5irr/l5mHgCDW6jllxsPoSb6H6+kVtYAfwYPCPa/77ChWXw+xH5gVEhSz3HZunTCsxyMK4AFIEUlAjVmwYQLzY4SLCr8UNgQYJaABYJOCVvZ2H2qzi+zH5V6SKKLxRxCIVxnwf/We/m/HMulLFwanV8Wk9RdahYYfMU03gC4HwytItOpG7E4FNurSloiYTyJZunj4cMzouSUYcAjRYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPsfcSR25gE9drHtshtUvGjC4K/f2J/ayx2FowZVqi4=;
 b=T2frXNgVWe1L3cH+vVJF9E4w51oqL+nrfGf9pB7oU9ULgdQLlfAN4WlJAabvR84b4wK3pzWdJOesl2TgqzbpT8Gun+cMM5oCyq3K67WkIrCFRoe/D2PuYKHyG17U43b9J0hhTzBvUrz0Lq1ZG8LxoaO63NCcNKo7K3Voh0q3OEXdtFlmS1SD4F1dW2JXbretHEg+4ez0WBIaU3QYrtItqGKg27RSFWKbdssSIBKP0Psnobuh5KvVJ0fygS4iFpkfg5hIWQ6rYlWS224OChj98gPxvTfH3WIz64E2R/HsWjK43vPUzycR+gLYtVET4SPJK7c0ayLhpbFcq39LJWONWg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY4PR01MB8263.ausprd01.prod.outlook.com (2603:10c6:10:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:02:13 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:02:13 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 09 Apr 2026 21:59:39 +0800
Subject: [PATCH v2] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB788118F7F3CBCD0B894B5460AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAMqw12kC/x3KQQqAIBBA0avIrBPMMqirRAvRsWZj4YAE4t0bW
 j7+b8BYCBk21aBgJaY7C8ZBQbh8PlFTFIM1djGzWXWiF1mjm1LwGFz0EeR9Cv5B1h2qhaP3Dwo
 kmgRbAAAA
X-Change-ID: 20260409-fixes-e53fcaec5dad
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=KuqeK1a1CerrjHab+YSagE5vkf263d6aHEI2xAA3cZE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzOsbTmWFfrj4KUj34EOduUmVbfpZZ/uMzrF59i3qc
 427PGvH7VcdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMJGl/xgZfntn5u4r5LU/
 3nXthKDyXaFvG6Zm83wT/dOkPD34zwLLU4wMH8y/pVQ1xR7JKb7KsXxljqxU/ifvOczVUfatn9P
 PqUxlBgB0Ak67
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYWP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::17) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260409-fixes-v1-1-2214330fb2ab@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY4PR01MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 68dddd83-070c-490c-8f22-08de964099b2
X-MS-Exchange-SLBlob-MailProps:
	Z68gl6A5j29AnTtbLKjpqQ4tPEUmeMtb43fH1Os6ueFhrgYUUY7Fj934kI6kvxPCWgZ8sDhwVZXpXP2r6KOMne18A8ujdRm5Eqxn851Min92gHvf6DlMVkMAPL64G03D9XGY//42/22JOnSYybhzpZgjjUGcsQOm08NwCxg8HbG0Z+oS9sNZ1l4O29MHUI0iQ3uNyXs1QEP/mPI1oBdP43StCCigTt/mcx/uDMLzWQYIHvngqBQ6Ea+JZle17VnZWYD56u3/jtbZN+dkffglsd7hs73462IZ2FdFwQWWMYYQZCS7TyHyIOkqk3jBvvRC9Pa0gsbt/G4xZnKjg0daOUB1lXXGZdL09epl6v82rDa6l9Nken5IAzDi262iDAZ3BcwPW5kTG4YVuiD5fOKbYtBS/9ri/OzwSZhPt18ejvOykWtsFb2pzjB7xv9QtK28l+0ey7m5uR/TSMNDieKfneEbx+rB1OtOWS3x7ami1lYIlbZizZnSnj+kko+iNTC9DFrqZZGwGzWeXVJVXBQBPSS+l5FG71z+GxMed1YSoIY84aE4nO+PyvtfxUO0FyIUd1tJCq6SLtZtlsyNX5Xdw988SeqqbbpdkkVja86cih7r5b3lspqalDsJ6kI5ebZE4Vmnq86iGFFcQR5vqc2BZ2/PK1I+DmlEAFidJtpg6DkZAt5PEMnLwVpEpflureTsIX5Mo+wFP4i5r0IUrWPw5nFDXysZONwguc/4eZPwjx6GOdTO1u9bfthZoljh6suobeU7UrsrD6SIwgAP7NutBAb1u/g2SjjKha/suLsw3xjBBcmeC0UR8/te7XzDFGGg
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|12121999013|461199028|13031999003|5062599005|15080799012|51005399006|22091999003|24121999003|19110799012|5072599009|8060799015|6090799003|10035399007|40105399003|1602099012|26121999003|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U21mMUtkaTZOeWRGbDNiVjNDU09JWk16Nno0TVRJNm93VWI1VXF5U28zaFRU?=
 =?utf-8?B?MlB6N0E5M3RJTVhRaGQzSGxOZG56T0xjNGlmaW5JNUpNUlVxTmxJeUh5Vnkx?=
 =?utf-8?B?UlllMHlya2lGUkY5aGlkTWRCbDVBemNmUkNJcU9DL2JuRUJSZGg0dUhVVjlZ?=
 =?utf-8?B?WVc2SW53OVZsZU5vNGNkZFhIendXeTBVcXljUGpGS0N1RFVCMjNEVjVOOFcw?=
 =?utf-8?B?cG93NE9hQ2FZMStxZDI4S25yMnNUanlWRnE2OFdZVzRzU3R6UW55MHpUeVRV?=
 =?utf-8?B?ZU14RmVSdTdUYVp0eHM2NWphdFYyNk1PSEswQWVtTWRuY2lOTUl2Rm96Q1Z4?=
 =?utf-8?B?OUc3VjcydVdpV2F2ck5uN3BrdlJBTUtWcUtLeUhMZkU4T3p4OElDOExleDBK?=
 =?utf-8?B?b3VHQzhjUlVPSWhkZGUxVDl3ZzZ6aEtVQWdQOWxOSmxYVndQeXEzQk5oMWJa?=
 =?utf-8?B?aFpVUGNCWGp5TUpMRlErK2NGbkx3d085aFpGV0NzQmxib2NieUtmUWEzYzVW?=
 =?utf-8?B?SkUzSk5wNkVLc0F1RHp4bWZucEF5SWJwMFhERSs3bGhPOVY5RTdBbzRiUFcw?=
 =?utf-8?B?ekpXZStHNWNqVFVMZ09KaHd5UmJSaUtHSTdqamZXMnVoZlhnek5WdE43Vita?=
 =?utf-8?B?cTB6enE4SC9TMFhsQXBYODhoQndtbXR4MDl3U3Q1SVdKTTdWVVFvb2QyRjBi?=
 =?utf-8?B?N21zM00zNGRsdjNmRmR6YjVTbVFDeGxjakFIYUJRZEVJR3JScDBoWlNRZEQw?=
 =?utf-8?B?b1NqWHdOb2J6enV5UXcwdEQzaExPaGJlVko0YzRDYUcvUTVhajBTc2cwaThh?=
 =?utf-8?B?RkdYcVJOc2o5L1BqTzZPU1QybXV1RFlSR1FZK2psQzJpWDhiYmk1emV6SHhv?=
 =?utf-8?B?V0x4QkFXQnlDRGVLSzIvNGlvQ1hwbXpWS0pWNDBUaWlLV3g5QnhaUklFRU41?=
 =?utf-8?B?Z3BSY05sRW1kZWtSVklWbVEwSnZnbzkrUkgyRkloQnVYQzZXNUFRMWVhTkxr?=
 =?utf-8?B?VFhSY3NHYTRVRG9ETm92UUpsRWJ3cDlEV3VLL2VIR1FNbldaRVZ2ai9aaFpG?=
 =?utf-8?B?bERJK1ZYRlYrK3I1VEtEYlFqajhjMTU1Wm8rUklMTk1ueTZMT2NSRDJrdFRH?=
 =?utf-8?B?V1Vqc2c2R2NNWkVHZndGTnU2SnJpZnNJWS9jdU9DNFp4UlZ2NEswK3QvejVx?=
 =?utf-8?B?dGFSTE81N3M3MXpSazU0WGJjL25HcWxOVGxXcS9jV2hlczZPQUhSclQ4VFNi?=
 =?utf-8?B?YnFjZVpreWZ3Rkg5WFoxaUQybTZISEdIdVdUTDFwY0tTRVoyemM2UTk0b1JK?=
 =?utf-8?B?aXRDNmRJVG92clVvWGVFbEN3SkM5d0N6Nk8rc3RGV2txUE1IU0xwR3h2cWQw?=
 =?utf-8?B?NEFtUXRGMUVnVnRJSkJTaHJBRjRNYjRnNUwvN3d5UG02bGNZWEhaOWNEN3RO?=
 =?utf-8?B?VEE5SjRkSU0rbkFkSUZHRUIzaUJXeno2Z0E0ZWNtMjd3NngzMU5vZklXZ0RU?=
 =?utf-8?B?N2lSVzV1S0ZGdDkrNGFTTVJlR3pBVUFzcmlNMktuS0lSUHpUdnV3OUNwR0Ez?=
 =?utf-8?B?YXFmQ3JuZFNsYWNYZUcvOEV2OTBlMnlXVnh1ZzRkVEQ1SmlVWEJqaUFGSjV3?=
 =?utf-8?B?eE11MDA3RXR1Yk5vLzlCcE1KdjFXeEp5OG8zZFp1TnVkcWhGd2pOY1VyU3NJ?=
 =?utf-8?B?N1NibjNaNkVnbUJWWVNXbzNMZm9RVGw0enh5MWRyY1l1eWVxOTF1amtnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJadnlrYXFHRzFGMlhqSXRkZk1wUHlEc0hmUHBPWm14eUhKa25hYXpOWU81?=
 =?utf-8?B?SWJJb2xDcVFUU1M3bWQwVnZqSzEvS3FDZVIzN1lzSmVaZ0xKZEVjbmhLb2ZR?=
 =?utf-8?B?M2VEUkxRejdnRkVqekhtK3FmOU1FZW4zd2JUUWdLS2lKUXdTWnNYd0Nlcmxp?=
 =?utf-8?B?bHFNNzlpa1hqVFBEaUJxOFhxamlrQWtPTVIxRzd3SUxWTTZLQWVNV3dsUFJr?=
 =?utf-8?B?N2gva0ZWNVlybmJhV0Y5U01xb3BkV0ZUYW1LWWIxUUJVdVdaMk03OVNjQlJj?=
 =?utf-8?B?ZlJUWm9QbkZGRU1RcTVOZ1h6VUFlUSs5eEZLdlVXR01saHdyN3Naczkrb2Iy?=
 =?utf-8?B?alNLQ29Fd3hDT1ZuaVFMTTM0cE9KY05SaFdTWjhMRjF2U3BFTG95M1FEbWZH?=
 =?utf-8?B?Njd2cWk4RVlUazcxaXN1R3FnL0JIdXlkQkpwR1J6REdKZDluY2kzS2VlVUo5?=
 =?utf-8?B?RzRXbFVDSE94Y3B1M29RazVvcWQzaGpqd3lIZWUrRkwySDBkSkJmT1NPTzRy?=
 =?utf-8?B?NFV0L05ZUTY1WVpZbU1rWmpDWG1mVnhVQTJRdnRaNVBkUnJoYzIwZ2U5OWNL?=
 =?utf-8?B?NklYT1VKbjg3U3VBZDFpNk5jOHhwa1FNMERKdXdNSkJDY0VzdUE3eGFUSkhm?=
 =?utf-8?B?TEtQSEJwRDl4dHZPTE1lTURreFZaR1FYOVhHNGYyZGVsZmJEY3M0N2gzV3p5?=
 =?utf-8?B?UzBKL2RNNVZmR1FqMnBpZUJ4SDQvLzY0Z1lxbHFMVlZhUmhaL1VUQk9TbHZZ?=
 =?utf-8?B?ZWV0eFhFczM3YWlBem5mcHJxU3JZZkVhRHJHaTBhcFhUV3ZVWnY4Szl2U2Q0?=
 =?utf-8?B?K0RQNldwM2cwb0RudmtQTDNXOVliOE9BdEhrTWlwZmJ1MUdCbExDVzcyV0Fa?=
 =?utf-8?B?N2VGYVV4b214Z3hGanlma29uT1BYQm1tUG8xNUZ0ZkIyRElNNEZNdjR6VE8x?=
 =?utf-8?B?VEVFZlpTVjQ2ZlpZUzlQMVUydm9uL2pGdW1XMnJad05tOEt5Zk42aktGVXZT?=
 =?utf-8?B?SkJpMHFHbGE3WDg1YTViL0hxZmt4clRBQ0QvR3FMdmg2QTFDQUs4WmN3Wm9L?=
 =?utf-8?B?SU0rRWpUdVpEZmN3SEpIZlVWVHg0YmZWWGNkUlZveWVlKzIvS2Ruc2ZDNklO?=
 =?utf-8?B?NUtRK29mWnMySXdBSC9xYzMxWmxKbFIvU21iL1JiZ2VyKzBkeVNjYzlqR3FJ?=
 =?utf-8?B?ZmRMM0tGdHZxbXMzYjc0SVBzWjNDVW1aRUVnNjVNbUJhb2IvVkZxVUVMWUNR?=
 =?utf-8?B?TDUya29aSHM5Mjc0eGhIVUYrZjM4STljWlpYM21uODlCQndOUXJFZW5GN1Zm?=
 =?utf-8?B?Tk9ZZG85aHQ5d1NaaTJqYzhtcVB1dmRqbDFNMG4vbi8vcVZJVFBKUVdIeTNv?=
 =?utf-8?B?M3k1TmxPV294Z2Z5NHVkam5LS0hEVis2ejFLRDVUbTF5T1RiVEFUM0czektk?=
 =?utf-8?B?anlaYVBGTjRxTkduM3V2Rm53U0ROb3U4ZjUxYlBPczBFL3h6Z0ExZmwzWGxu?=
 =?utf-8?B?V0JjOVRZbm1oWXFrYzBZVm5nM1J3SHhnZHQxeDU4ME5mb2Z1TzdKNWtndVJn?=
 =?utf-8?B?N09ZNndBYm1OMW56VlJYMTV0aWJnVjZpTlhLZHJaR1lyMzBFL0xYYkVIMEts?=
 =?utf-8?B?Vkptc2E2OHM1M2NxRUVqaVBma0x3ZkhjbTJmSEhWWWlzVTJDaVVGQXdSd0FE?=
 =?utf-8?B?aXllK2FibDVoK3FIODhKdXZFZDV1akJZQ3Qva1laZm80a2g3Y1dGMDhwbTVn?=
 =?utf-8?B?Wkg2MGJNd0NwTkJnRDRTRWpyZDZWMDVjQld0cFN1a3ZKQVpybk5OUmlaV3kz?=
 =?utf-8?B?TW9HUmZzRXY0cUZONUhwRDQwSTBHWjd0VXVFUE81YTZwS0pvSGNONWVwM2Za?=
 =?utf-8?B?SnplQXFzLzVhRDFDM2Jmc09iV2FRTkY5bDZGZ2Y3YnRPR1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dddd83-070c-490c-8f22-08de964099b2
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:02:13.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB8263
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235416-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,SYBPR01MB7881.ausprd01.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 63CE53CBBDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some crafted images can have illegal (!partial_decoding &&
m_llen < m_plen) extents, and the LZ4 inplace decompression path
can be wrongly hit, but it cannot handle (outpages < inpages)
properly: "outpages - inpages" wraps to a large value and
the subsequent rq->out[] access reads past the decompressed_pages
array.

However, such crafted cases can correctly result in a corruption
report in the normal LZ4 non-inplace path.

Let's add an additional check to fix this for backporting.

Reproducible image (base64-encoded gzipped blob):

H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+g
dilSJo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9i
PNtbjhan04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz
2DF/21+20T/ldgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1w
ywAAAAAAAADwu14ATsEYtgBQAAA=

$ mount -t erofs -o cache_strategy=disabled foo.erofs /mnt
$ dd if=/mnt/data of=/dev/null bs=4096 count=1

Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Change commit message suggested by Gao Xiang
- Link to v1: https://lore.kernel.org/all/SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com/
---
 fs/erofs/decompressor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 3c54e95964c9..2b065f8c3f71 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -145,6 +145,7 @@ static void *z_erofs_lz4_handle_overlap(const struct z_erofs_decompress_req *rq,
 	oend = rq->pageofs_out + rq->outputsize;
 	omargin = PAGE_ALIGN(oend) - oend;
 	if (!rq->partial_decoding && may_inplace &&
+	    rq->outpages >= rq->inpages &&
 	    omargin >= LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize)) {
 		for (i = 0; i < rq->inpages; ++i)
 			if (rq->out[rq->outpages - rq->inpages + i] !=

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260409-fixes-e53fcaec5dad

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


