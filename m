Return-Path: <stable+bounces-232935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDQuF8YqzmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA583861EC
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 065093131486
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743C036657D;
	Thu,  2 Apr 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I6Ital5G"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012067.outbound.protection.outlook.com [52.103.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF82365A00;
	Thu,  2 Apr 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118584; cv=fail; b=gAxkcDcLfvYD8AsUUri+DLmIrY4np12ihF0sp1rebcRHuG6HAH6Ek2w3W/aBLAvwSjq7Kezu6ofmcgzvI/IoaUKyd4EL13r2tj7o8Lq45V8WZvah1vW+G1CIKsJmt/D4HI/Vn3AJ5UKEt8/UBwfETltTeO9MNFWiLoimhx1hMp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118584; c=relaxed/simple;
	bh=K94OkDjeB6Pn0OKB64NtIlee90tLZIg19z6+AWDZfr4=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=kWiRvIJDHRhixplqthJWSmspaSbJn3t0rrsoJFMJ3HRyVmPaICzFlEZitv2ZGFJWy6/1BDHHVWJWXnLqKMi4cy18iAUfr+y8o1uDqAl6H1dNWorHTPdcUrH5h66yMr+ZmvOHSdtjo1/Qo5TcMYW66UbSB0Yi24y13l4nKGCnx40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I6Ital5G; arc=fail smtp.client-ip=52.103.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0d7W1aARjVb4jQKULSJwsQaAv/3TT5OmUZiJbsX19EQrQp05BVpIVEGIIdfHAyIH7TF+dUifxPSbU4qJLPDHVwef4Z14HB1wnnfDtN4t1t5+vJH8qNUnDdWi6/O+k16AdMmfoSm/yqD+cVYsvlLhgzf4Wq9GtC24ibZ9oLWnsvY/lRibnrFF1mUdqCRSU1bhjkhtH6fM0KkDRFt0l5+upCqPrtZb4+zkRZ9UkGLUYI7juEDFkJSijeOwQ3YsSqDqi34I6yqjoguHMm2U26emWMWkZzusmlrDsG7SQEv29nJm8TIIbGFzUpxTyCmWqs3VViLv/y9wsSBBGw7qzZi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAxiBxvnWBpVRIxL815D7vbgP5AnlVcI2p0D18/Zmyc=;
 b=IYWF3I8jat+p1SOnggUrcIyN82sikJmf5EsjSrTUp8HLjcuRfz5ToU2zAFxsiTRfzKaSBXX0xeW7Fo583FN1wC2NbidI7mAXtLxGYpTF+ancc81di/RDi8RW9+nm1h/HoT1lEk56ZjCwsOvkl3lF/F3gBrlE7Q8ELCioIAn1aJ7vX0QKIAHJrLi0NFzsRul/1RPnevdeBHmhsWPgPeAFSgetYgia8WH+qIdiPJZFaMXoLO+8R9xlDFaei6ERY0SwUTtnWpwVMwbEH3hV/blxOiB4mfDTavRJOOUR3rYPIbSQQbDrfHcb3ZiqpKat7lE1eQqycb+i7e9F+iw01HCgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAxiBxvnWBpVRIxL815D7vbgP5AnlVcI2p0D18/Zmyc=;
 b=I6Ital5GhdCUJ4fQ6vk181NA2bojnuSztIHE/tUiKgcytPRbpRwvjyz915aJGCm8Lgatn0xX29HWC3yj1kb378wws+VE6hKquhX1kfdK+YcoPL0P625014x2NSryTGcZnUwPTCB3nZPvDGy55ctOQG8vjHBN+6twUgPZyJW8QXZzJZALNwD+FYnDSFHEBai8KhaKSAChtOeuQQhig/S1RGBHGkgRzm5Pq8EMv3R8HkpbXVSnZwFLMrpWgV2pzR9tYy1dihm5GIGfDOkItlGrna/TWf/0Vn5qxHBdUX0jt3Kb6vYPOfU3shfIOe5Gi0o2AvxO3wy7TFklfp4jW1ZZUQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB8364.ausprd01.prod.outlook.com (2603:10c6:10:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 08:29:37 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 08:29:37 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 02 Apr 2026 16:28:28 +0800
Subject: [PATCH v2] Bluetooth: btintel_pcie: validate RX packet length
 against buffer size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78812A5517C2CED45F5BD315AF51A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAKsozmkC/x3KQQqAIBBA0avIrBN0iGS6SrSIGms2Fg5IIN49a
 fn4v4JyFlaYTYXMRVTu1OEHA/u1pZOtHN2ADic3OrRRXlZLgThgYKLoob9P5j/0dYGCsLb2AVn
 BlB9bAAAA
X-Change-ID: 20260402-fixes-979e727e99f1
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>, 
 Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Paul Menzel <pmenzel@molgen.mpg.de>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=K94OkDjeB6Pn0OKB64NtIlee90tLZIg19z6+AWDZfr4=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzHMaq2P6KtljxLTDF0yYcOvCBCcXXkHznOBA5hCxS
 7KT/N1+l3aUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARFweMTLM+iCbrNYzXVfP
 euu/q1efO4pv7fvKIJmvHb7VZs8Fkzu6jAw/nv1qS7U7wFmnsag29c2sL2Wqca0n/x/zmdnOJ1F
 Vc4sVAPTkSIY=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::12) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260402-fixes-v1-1-27ea5d9666dc@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f839f8-b6c7-40c6-93ec-08de9091f907
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|23021999003|19110799012|5062599005|6090799003|8060799015|5072599009|51005399006|22091999003|12121999013|24121999003|10035399007|440099028|4302099013|3412199025|26121999003|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHFJZ2VBTFdWS0czL096ZnY5RmZDNU1EaUo5b3BhRWRFZFdCR0pVRjkxcHEy?=
 =?utf-8?B?RjNkVmZHckJWMnZqQXhWZTZ6SEJTRnRpTEdGNXJWWHRkUEJmeTFBb0hZRHNS?=
 =?utf-8?B?WElCMFRKb1pYL0NIemZEVEVNL3lreEUyRGZvSkJjWkFXTWltS0NHcHI5V25z?=
 =?utf-8?B?Z1o4Y2FnNTNRTjFGd2o4Z0FYbm9pMnIzZE5MRjZ2YzJFSnRoV2xUYWdnazBh?=
 =?utf-8?B?dVdkNitBVVBhNWNiNzc1NFFtU2k1cGswZno2ZzJ4S25xZTVxMGNoZ2ZUb0o0?=
 =?utf-8?B?SllyYlNHUTlKSHNFQmhaQzM1ekRTUVVUMHdMQWVWd1VvL3ZHS2VGTlVvTXhW?=
 =?utf-8?B?YmZKOERJakEvSTFtTEZhdExnM2JzdFRia3BZUVJoUWw2WDd0aG5UNjF6eU1l?=
 =?utf-8?B?aEZ3eVRTVlZOaFR5UW1pZEtUZmF2ZVh6bGRTZ1NHZXVoc3JaWEJEWTJyOEp2?=
 =?utf-8?B?MUh6a0toaC9KVXBtWWRrRUFxN0xlM2NJU2xVZFc1SHFOdk81VEswREN6L0Fh?=
 =?utf-8?B?cFlYMFEyU05XcVNFMGtPdFQrQVFCWGk1YmJ0NlI2UjEybzVod3JzNjRXekY1?=
 =?utf-8?B?Uk9HWWVQZmRaZCtjVnQ5Tno1RFF4YUFwcVBOVXdORlpYN1FrSnVZUTI1dEtq?=
 =?utf-8?B?c3MvNFRPREtCKzRwUGtiZ0FiTUdPaXJmRUdCbmt0Q012MXlaeU9sNU4rdXFh?=
 =?utf-8?B?M3psaC9HSEtpbXRpaHN3NVB6NnFiUlErTHBjNC9FUTYzR2dacE5odzBmbzcz?=
 =?utf-8?B?OEpVTmVzTHd2VCtnblc1Nmw1anlDb2dVTzVTelE4VzVWWndTWGFmTHQ1UGlZ?=
 =?utf-8?B?OWdtREF2c3VuVDBsTjBjYWJzV3AwTDczZFRCQkZ5SFNxaGhKRm8zenRyS2pm?=
 =?utf-8?B?VEhvdFNQeC9qOFhiS2RWcWdtVk93cGdLYnpqbDlDM3pQM3UwMkpqaXRsb0lR?=
 =?utf-8?B?U0h5blpWdk5jUDdUSTlrMHY1TGJNaFQ0OHRRSVM0TllXMUJPeVpaOG5lTjht?=
 =?utf-8?B?aVhGOEUwVmFHdHVqMy9seEZlQjNHdDFsN0hPSjRZZWpDeE9qMFNuTjlaTldn?=
 =?utf-8?B?UTNWZjgvcGUrVWFUcFdJNmxrS2pBQW1KeDBtMlBZV0NNSzY4SkNOc0xMcURG?=
 =?utf-8?B?WjNZcVZlWXdQeTV0dFp5bWN1MU11dytVYzZQTGswMG5IMzdaU2NiVWtINk5Z?=
 =?utf-8?B?YVpjMEVHRnQ5ZERWUHlzMndqZ0lxdGJ1YTdpOFFtQnRHblE5R3cvcDdTZ0Nw?=
 =?utf-8?B?Wm5Ub3JEdGVya0xBSVpkZVNpdkE5ZkhOSEplaFQ4N1ZIK0IyRUFFZFZnVGRD?=
 =?utf-8?B?dkEwblBjNittSXZ0amo4akMwTzdvb1kycVRhMmtQN1MvU245SlhPd2VyeFRa?=
 =?utf-8?B?UlpVNDZQV0tBK3E3ZXdTY25qMnZLby9rZkxkd25pZ1dlS3VjRndJWXlUclJH?=
 =?utf-8?B?M2twNHpsYTNGdWxjakNPYSt4UzhSbE1Jb1RjeVpEVHl6bWdBRTRZQlBycFdS?=
 =?utf-8?B?TXFkRVZRTWFTSldVUFVpME90SjBPTVJYMEprZFZ5Q0FWMkRSYkN3RjhZUy96?=
 =?utf-8?B?NG92aHVQbW1EUDZMRU4yN3BlTGhXKzEwOUZTN2ZpR3hQUGFEOUw5U1hobVdm?=
 =?utf-8?B?M05zRDFZWHNobFYycTZqZ3h5aUlqRUc0TU55enNyRHdwVUFtZlozVDNXdmhW?=
 =?utf-8?Q?ZKMQ/NErL42jbmmJPGJa?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDVXdTZmNFdMcG42ajI4ZDljZFpMUy85ZXloUEMxYUluZTM1Q2JzNnIvdXhq?=
 =?utf-8?B?TnRzUFE5OWR6SmFkalYvUEhyVjRiVkJvT016dmRwY1pqVGFXUHA0VThHUmp3?=
 =?utf-8?B?UWZTeW9UTGtqTXVLYWJ3NDRSd2pZbmJZWWJ1SjhacFBrK2pSSG1QUVBQUUpX?=
 =?utf-8?B?K3BDN25oRVo2b0NFRmlVK3RYWVNhY3hRYUIxR3I1YUxVVXJhZWU2OEhmNDEx?=
 =?utf-8?B?L0lkUVVEeFhCaWUvaUgzTUFDWmlWUm5seVdmMWtTdXRuRytFTGJESzNvL2VM?=
 =?utf-8?B?WGozUVZUT21ocWVORDV1eXVETzl3d1VjOU5sVlYvVjlFVzErTDRuQm9lSE9T?=
 =?utf-8?B?OGI0K0ZESXIvM1hJN0V3TllFby8rQ2ZXdFFWSzVjMFhTMnFyNWpXcjl5N2li?=
 =?utf-8?B?SkRlblRPcTVDcHk4S1F5SnVISGM3ZmFBQXd4L3p1blVkV0dCMnJSQWg3bGVh?=
 =?utf-8?B?MUdDb09QaTN0QktPK014TDgyWTMyaU1ZZno2eHdWaVE5V0ZmVG11KzZyRzJj?=
 =?utf-8?B?WVBnRHY4ZkNOZVZ6cUUyNXV5SUwxbTh4WVNEMml4cEFnZXRqai9lZHV2YjhK?=
 =?utf-8?B?alI3Umd2Rzd6b2lRNXJTd21DS29qVEJNRzV1MkYva1BiQkswM3VGMzZ2WUxV?=
 =?utf-8?B?VlVyM0RCOWtuajZjdFVTclp0Umxtc3ZCSkhENlhmNW1ZS2hBcFAzb05PS2FB?=
 =?utf-8?B?TktkVXhFOTBOMngwa2g0cFMzRWpLWERqSFlETXJnRlpNR2dwcWtKTTFZSFlF?=
 =?utf-8?B?VE4yclRTajFDbWNWenRFTTM2Zi9XY0tJUG85TUg1TUR6S0tDOWFuS0RUQ0Zj?=
 =?utf-8?B?QlBKNmpiZW9yZS9zOGpEYU9GdWlDalFVR0lMV0lmSlRyTXJKNjJld0NBVkdV?=
 =?utf-8?B?TCtNM1pib3NFRTEzQ2ZpUWxBSE9EKy9ONkx2cXJMWXJ6a2tkU3ZJRTZiZnRr?=
 =?utf-8?B?OXNoNGYzalNoSlBtUERhRUtGRzZMT2YzR3BCakZlWkVHd09Jbi93dU5jOW9n?=
 =?utf-8?B?UklSQUU4Rm1MVloycW5ZV3c1SlJpQkhuTkp4SGtHcWNKcSs0YktRYlBBVkc3?=
 =?utf-8?B?Qy82V1FTTlphZjNtQzNIYTVodFp5Rm4vbWpRUHFXQVNmMnlwNno0TTJJaFBE?=
 =?utf-8?B?M1gzOU9LZkExUTltenVveHZRT1JuYU1LVXNkb2x2ckZ2Wjg5NmpmbU9JTi9Q?=
 =?utf-8?B?YzZKbUcwTFZIbUxPcW80M09Ib05SU2dRTmtOWEs2bTBIa2VHUStqZDFYN1ND?=
 =?utf-8?B?K0x6a045TUZQRks3MlluVGhxSlRzVU5iT2lYb0dUcU1jTDZlMThtSHNJeGN4?=
 =?utf-8?B?OHlsaEpYMUQwVm1tc1J5Lzk3RzJmUlI2Z09CWTVodXY1dzlMZkxtNC9EWEEx?=
 =?utf-8?B?ekc2aWU0dmtndGJKWG1acmR3TW5CWiszeWFyM2dVTk9hNk5udTZQL1RRZkdl?=
 =?utf-8?B?RkZRVXI3NEpkSFl0RmhjZTVaaWpEY3YvZVVlZUY3L0dyMUVubFFuK0NGMEdW?=
 =?utf-8?B?bHpyRU1ldTlTWDdmdkgyQjRVbGoxREFuQXh6U3c4bkdQZWlTV202eFdLNDJj?=
 =?utf-8?B?N2F2aitPU2hSTENoZHhpSzlmcW5HbFpwL01XU2VpeGROUmw4T1dFa2ZFVWla?=
 =?utf-8?B?SENXRE4xczlmQ0dRTEpOa2EzUVRlNCtGMVBvM3lhVDY4WE5vV3lPS0xwakFG?=
 =?utf-8?B?cC9KNUFLcG1qbnRobUVYTDVNWktvdTB0Wi9yRlhDU1M2Q0RpcVd4K3lQSWlB?=
 =?utf-8?B?M254ZkkrTXFhVkdlekZndGdrMW0rcklpSXp2T2REd3dVdjFhaTBsNDNlcE5K?=
 =?utf-8?B?cUs4VnVnK3lGcENnYmZWMjB3R2pEWU9UL1NIUUtRVVZTYk5vTnpCc0puMlpH?=
 =?utf-8?B?RHd2SXptZ08rNFMrZHVBdXZtU0x1a0RGLzNGTTlpT0xnZEE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f839f8-b6c7-40c6-93ec-08de9091f907
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:29:36.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB8364
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,molgen.mpg.de,outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: CBA583861EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

btintel_pcie_submit_rx_work() reads packet_len from an rfh_hdr in
DMA-coherent memory and uses it as the length for skb_put_data() without
upper bound validation. Since packet_len is a 16-bit field (0-65535) but
each RX DMA buffer is only BTINTEL_PCIE_BUFFER_SIZE (4096) bytes, a
malicious or malfunctioning firmware could set a large packet_len,
causing an out-of-bounds read beyond the buffer into adjacent kernel
heap memory.

Add a check that packet_len does not exceed the available payload space
alongside the existing zero-length check.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Add bt_dev_warn() to log error suggested by Paul Menzel
- Link to v1: https://lore.kernel.org/all/SYBPR01MB7881DD95CE054BC53AED4A21AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com/
---
 drivers/bluetooth/btintel_pcie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37b744e35bc4..e60487e73749 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1360,7 +1360,9 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 	rfh_hdr = buf;
 
 	len = rfh_hdr->packet_len;
-	if (len <= 0) {
+	if (len <= 0 ||
+	    len > BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr)) {
+		bt_dev_warn(data->hdev, "Invalid RX packet length: %d", len);
 		ret = -EINVAL;
 		goto resubmit;
 	}

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260402-fixes-979e727e99f1

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


