Return-Path: <stable+bounces-245226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOtzIbXiAWoEmAEAu9opvQ
	(envelope-from <stable+bounces-245226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:07:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B250FB6B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE723095568
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9A36D500;
	Mon, 11 May 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NByaMFMO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A503F7A89;
	Mon, 11 May 2026 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507934; cv=fail; b=Bj1LWZJjml32aNDgQhglgXUBtu8BlWO+Sp3rYvnTyQwL+eyXEvnONBoGWa/XuMYa1QXZH2lcHpkNHn42LuF61p01nNQgoFhVRnYJJDIpPB7nT77e/oiwy5pOu8yx5m3c95BGnKSxkeoJCQyVLchz2L1te9pBc5AivG9JKFeoqRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507934; c=relaxed/simple;
	bh=HONoLXP8uOTNwEmsWw1Gu81t1JSEXktIufIxawK1e7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mNBqz7CQ6J5szVjjKJ9WVl0yeil2e0XXGlS+bDiW1VwSZiz7WU+QsvKGDrDL4xbKOih4wNmbtek2VtvNimlTQGCo2o2qWpVrxXmTlkWyUoZDa7xlMAwUzRcgZXVhNLvF0GxmLC9h1TnrxAIPUAcFtWvZHFx0AhHV4zlZSOYh59g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NByaMFMO; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BDbJGJ2604937;
	Mon, 11 May 2026 06:53:43 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021081.outbound.protection.outlook.com [40.107.208.81])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e24ejc7xy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 06:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPmqFRBdVYHEYL88qtC+T5n0Ryqo6JsFLrU+DjoRHep47DZmngHAxN3SnfKAXa7yAL5VG9P5iGQVHJT9YEIjktF0MTwXQgmS5x2Yw1tvjhB4+6o/F537hcq+aaU82lyJeNGROHuUZuY61T4CBPC6OaimpFS+K3k9eaBpY1TW5enCSrpvPiioNCJ0MjQagZm8w6OAM77h2bNNdm30Deudcl3g2xMCH+Dnu0dgerXIZgmAuWg2ukhNxrlnCI2m4h31+xIpoNR0YhUFuPQ9ZWpm00R8rdHuSeVXKGEqVRfH3mTmAyUYTo3Aoxk+myMGf97KUWp7FVfl1aySIRo4qVfIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HONoLXP8uOTNwEmsWw1Gu81t1JSEXktIufIxawK1e7Q=;
 b=w+PIQgJ8ghMIVEHpdF3kU3DyyDSFJYnxYVY/uWrTpgtzXh3kQNmXNWI6AYo88pqN0QLKcH+4tq9yx4JWxTFRjYjP0UvBVozSnBJTn5HtVElSE+ErnqOcpGvvzC4XAw1Dyv3w1IptXEaiz2fyVuleMV2pIOj9q/4g5ZFIWfYWSypCbK4j9/Bb8Y5NN3dKPKHcwZqDE6o0XstugWj6ipNIcxlE5gQm1gxUQN+k8CZ5jK2rYsqck8mmunN+nFI7SEfIgWuEuAWupXmJm/uZ95YYM97O/t9WeVJ487Ss/4nvWxXJRl4FD26yDAIlamLtmt2d6KDa4uNf53wtnX6KFvFBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HONoLXP8uOTNwEmsWw1Gu81t1JSEXktIufIxawK1e7Q=;
 b=NByaMFMODvQC5eWjK/H4GVGwrzaKhkpxdzQZGuDbzvhi9kZbs/uDiKLts5ctJjLkUFcZ995ZG6QtVKdU7dZHFHApQDeIbPWU8hBA51uhPhh3IPOcePHSDaH8c84hRvt3d5w23vdghT9Djqi0vhxk7hKasVoOufu3ARV1Meu8Dr4=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by DS4PPF05465846B.namprd18.prod.outlook.com (2603:10b6:f:fc00::a85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 11 May
 2026 13:53:39 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%5]) with mapi id 15.20.9891.016; Mon, 11 May 2026
 13:53:39 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>, Rex Bytes <goodboy@rexbytes.com>,
        Igor
 Russkikh <irusskikh@marvell.com>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] net: atlantic: preserve PCI
 wake-from-D3 on shutdown when WOL enabled
Thread-Topic: [EXTERNAL] Re: [PATCH net] net: atlantic: preserve PCI
 wake-from-D3 on shutdown when WOL enabled
Thread-Index: AQHc30OpbQLDNcls8ESLKlucDjwsB7YI2uyQ
Date: Mon, 11 May 2026 13:53:38 +0000
Message-ID:
 <SA1PR18MB46005421B4A0D353B1749AC6BA382@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506104211.2442-1-goodboy@rexbytes.com>
 <20260508163732.6d04adb9@kernel.org>
In-Reply-To: <20260508163732.6d04adb9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|DS4PPF05465846B:EE_
x-ms-office365-filtering-correlation-id: 03aaa87f-c5f8-4366-7553-08deaf64b406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|11063799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 d8Kl+BeUQNJyfENhlCgxdXJ8ukeRujmm3jFNfEe+LfUiBA7tA8kv3yAdKKyK17Gc8lZi5Rs24u9XoaOJkpsn14t3E4cTZQWc/qX006DEXcjxOFSIdkP3L73uu9+/6yh1EYtuKNCI2EfY25kC5sAkiL7f7pcOKJollrWMAL7vKGfI5QkDYZ23orU08GwHjFmQqiN8T+ZHHghlxj0Kjw8j3/lcHe0MDWqRW3Gm68Z/2KSKDn2CjdZGOGh5RVD8wT01FGRaTTX/qWSQOAmzEjApScccszTl0xxyvZ0qGeeQDYsy5QmpQhSEqPWjBvgMO1awtYnfRaCvFktiBecCVF8LeBAoby5xIdEkoAE7a7k432xCDRYB9E1SmxqxxfD58PVWz/iddvgvn5MZEeS0Reqdf1Z7L9/z/XfCRaEI53Zp+5ymFuNZAgvF96vUSf8i4urlne4bsvosahjkYQ/0h/NFJF5uXCv710RlXgznIq0DEn9a9o/qAsHXSHYZ7dFxAoGgln+EFO7mHSEjJj7ni7SBhpTBNYuH88iuHZrL4+Col7XH/oQfEo6rPhaGfdn25EA+Wzo+r8zXv+Tiiz1vqMAmYRxfWeTnFLmkH9Kiiht3g+Ksu/5Aoe6kAEPaL2nYhp3ResXtMJSDb/A3QG0/GiFdfRbF7UN/VtqDZvBnLqI1iVP6QnYYQefS/wdB9q8i1Kw3n8OScl/e7ENqJ9QxsbF1cfnlajfKPXkLGL6Qo1Wt63yEDWD0SrcD4xhvB0huNVpv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(11063799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTIzLzZNVTduZ2tkeG56ZHUxdzM4WnhNbEZVbE1IYmw3bVp3Y0gwbkUyM2tv?=
 =?utf-8?B?WGN0TEExaEhJcjNRY0h0R1RnK3psWU4rK2FzSWhGRUFsQTJJVDBHMXZ5eERX?=
 =?utf-8?B?NEVNM1VmNkJHVzR3anQzT2tDaFQ1ZXkxK3R6ajZUTERpZS9WWnV1YVN6L0lT?=
 =?utf-8?B?emVUdG1YVU9zSmNKRnFPZzJzWjJnUnlFaW9OeVdnb3ZvUzRhZzdndVNIRkcx?=
 =?utf-8?B?TXpabnl5RkpZeWUxL1lyUGw0aWhYOWRSMDl3R0tjamdyajQ0Z3A3OEdUdThw?=
 =?utf-8?B?aEp4WDZaTjFZcldqREE5SEhJQlRSYUpNUkZCV0VnQm5VMTREeXhPa2hxUG5U?=
 =?utf-8?B?dXJNQUZPQW9NVkxHc0FHclFZR0dRS0JVcVF2MWZEaFNWd1Axd2w4bmkzL0Nt?=
 =?utf-8?B?YUs2VUUvbXpKdm5PcUFEOU1vNXNnc0xUZjVDYjRlWHRUaUZzRlI1S0FNRVB4?=
 =?utf-8?B?cFkvQUd0T1ZvWXFYL0hFSmpGa2gwNllSc040bXd5cENpTkhseExrYXlmWW9j?=
 =?utf-8?B?NTZtalRTWTlpaFJOQ05PdW5YL3pOcXJtVHUrZitHakZCVGw1L1VudVRDcmpq?=
 =?utf-8?B?SGxUMnFrTHNoNU1Oa0NPYm5qbGZ5WlR2VHB5THZDaEJBdWVGK21BdnJoZ09k?=
 =?utf-8?B?M3Z3QTBaTWRDMDhJMFducVgyalN0WklBMlpPdzBISUtuYnhlbG5nNjBFUVNV?=
 =?utf-8?B?akdQNUpORitJY1dUMlNvSUdaVGxqRW50V2M0QlBqa2h4alIwMnF3S2FqRGNB?=
 =?utf-8?B?bEI4V2hvcnpEbzlhRzJIZ2NwdCtVdk1KU1hoTk1za2hTdHR5QzczZWRYdDk2?=
 =?utf-8?B?cU5Ua3gvbXFXVEhib0hDVVhaQ3dDcldFWnNiVGZCNkh5RElJSHNvbHVJcDhD?=
 =?utf-8?B?OUVCTVVEVWVqSTNabDZHZTVWL2FRY1M0ZkRBVUcvZ3RFWjdXMUpYQVhIM0I3?=
 =?utf-8?B?Nyt0cmEwcHlrc0J0aHdoc0Jzd1o1b0x2dWN5N1pEWXlNR0s4VjE3bnhQczRu?=
 =?utf-8?B?dS80V2hvcmx4dlNXS0hmMVpVSzBjdmlkY1NrMTBWeUxJcmNvSVhGNkJCOS92?=
 =?utf-8?B?RWFBR1M0c2JxWUtoOVh6SjRueHo4MDdZWERSOEJTOUUwZkZmOFd6aXhSU253?=
 =?utf-8?B?L3hHaWZ3NDVaS25oYU82aC9MMmdBdk1kbE5lY1FmZlpwYXRtc1ZhL245MEwz?=
 =?utf-8?B?WmV3ejFqUlZ0YVNidkFETUYvRUFSVUh6WXlvVzFicEd3MXZjY0NSQUlONU10?=
 =?utf-8?B?QnVDWjFZZEJKampIREtoRWFicldqMTBTaXpMWFJuNy80K254ZmEvMjFia09C?=
 =?utf-8?B?amd2UnFIdVRUbEdwNjVwNGdINlkrY1pnMytrTjM2eE5JdXZ2NzNPaXJDWEZV?=
 =?utf-8?B?bEJmek1TVXg0UkQ2djlycGx5QktwTWVTQjRsKzJVRldtaXRmNE9EV0NHaGc5?=
 =?utf-8?B?bUxyd3AzZHg2RlR1ZTRTcmJnQnhWRGNKM1lJb3lFYVNSVlE3TGFhK3N3bkdk?=
 =?utf-8?B?eENlckQ2ejhPKzgyZ2ZuSElycHYvSS9FclBFRWFHSUlzbWNOa1hMLzNPZ1I0?=
 =?utf-8?B?MW1QYyszREZGWDVMVE42aG12SHhPZGRnTDV3cEdJL2ZsTmpseWNSVzZ2Y2FD?=
 =?utf-8?B?dGVKZ0JWeEh2ZThRT1RSdGMwcVhzTUR4Y1pEZURiRTV0aG9GWjl4OThIMlZT?=
 =?utf-8?B?WER4NDRHRSt5Zk9JVlAwU2FveGtTdWxtWGNEVDRQNjdIVkdMOW1lekpHdGVo?=
 =?utf-8?B?S01uRzRYdVVuVGdwdUZWN0xmNUNCV3lLYVdBOVRicGhCQW9ocG16amRxTHRU?=
 =?utf-8?B?OXB1WStFY25sYUk3anU5dEZOV0pKdlBRSW1zOGR5ZGNkLzhJQnN4WE91YXNH?=
 =?utf-8?B?WTJJeHZ0eHNlQWt2bWd4d2NVRkp3Yitjd3l4RGhIckRTaHdQVEhZVHFjbjB4?=
 =?utf-8?B?bTZaNnJsTk1hanorWU4rellJSDBHaGhlUS80R2ZsbVdEb1BKeTFXMVdKYU9a?=
 =?utf-8?B?MnZKV1lnRktSTEpGM2xZbjZVeFlmQTBJM2hHeXVNQnhxQysvd3RBQ1Nwblpx?=
 =?utf-8?B?NGE0Z2orQnFHNURDZHRyWG4zNGFtbkRzaGFGTzNBMkpMWGlPTHlKdnNwZ2lC?=
 =?utf-8?B?LzNKcThUME45Y0orOU01aFdBdVZxbzJaUEJ0alBrekxwNzltT3NpMHhIQ2kx?=
 =?utf-8?B?SGhmNnNWb2tiTjlHR1N3Nm1MVy9MeUpmc0FhN1RjaU44bHlaaUd0aFJzTG9H?=
 =?utf-8?B?b09JM1U2RnNHK3pzaDU1VGdNUE41RVBJTC9HczlDWjZpdjVSR29iZUJla0xr?=
 =?utf-8?B?UWhTZTNRRG5Ea3RWejhLalAxWDZhMWwxcGx4YjM4TmpRdlhTTkN2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cEMYd97KG/17ihH4jljw8ozApE2IUpbrVDMnUzQSzANglHxlhSlmwIOCO7bp7IJyzQpGzlshyIcIHpSyQJv67XKduVroJH9k/bDF4avhNoZRqr2c1C1Z14hgy/4gTe6sum8ajONLPRMmXw4304iW2TqQbEjHwSjt41HKFfYeDgYrZkDPbdZSTRNY5XxaTBq8K+nFyYmk/yNAkRVHX0bJoIxBVug8Ik7bGzm1LOO4bI4zQy0WVZFYY4+vKvyja1AwlVvElSjByD21rpsDNiXMKhA1J2RQ5wrSmN0YOBwjJpeVHCclcOsRjinZdoSfgWtCW2v1+3M0RsNzwLhMkOtFOg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aaa87f-c5f8-4366-7553-08deaf64b406
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 13:53:38.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVrehkrAJIXMNCkXZpKz2WoCdjxacJpQldEelcFgFhicCeA9oJwUWwOpJrkp86CmhGb9ztR3CPtbznJZPhvjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF05465846B
X-Authority-Analysis: v=2.4 cv=c5qbhx9l c=1 sm=1 tr=0 ts=6a01df67 cx=c_pps
 a=HzPr6oCfsVO1Dm+K1Iow0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=SeQO5qGTAAAA:8 a=M5GUcnROAAAA:8 a=cZ8uzQfhwNy6kRRTQKQA:9 a=QEXdDO2ut3YA:10
 a=5Bj3vqhxTesA:10 a=OFXuLDbMZiE44rrpe7xs:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lk6wxw1jRFIBq4feaTGJBu2plN3aExqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NCBTYWx0ZWRfXwohQiMefmU4V
 Rnead7YPCH3TKQJuyN1doQTEOcmCCqDwrLjFlN5h+rLpxfyPdBqt8Bv3+Q8tVRINnxobC3thP/3
 ZTW38taoG2fXyeh2iF5Q6U/evOw9ECfm9z+1bf+FQ/LDTsMY1cXfvGCNx+KMnybJiETJkgq7x+U
 xsuChLnLQ2QQI6AjfkTK+bAO5RbpO3JsysqSe+D8h76ce6XAD/y8H/9ydabcl8/OCywjnolvPMb
 qSacpuEkCWZRR7ka3BQqd/VO8QzQXZlYCy99TtiKHhFtk4bVduxGbvNqrMLcSyCKDedxeozq6Nm
 0+UZCjCtjO/0PcPZ5MGGL7f5o/Y4jwmF77Nt25aNQ7nCRCWBDyvSaL3eTjnav4yHsvmeGQyDeFA
 skepa5VI45gpGXra7xyHeEE88ZT8HlgAvHsPdlESDVvmsFsFrYuHgoAfu0bxO5xqai28eyZdjD1
 F9BL712Fkrloixt9j+A==
X-Proofpoint-GUID: lk6wxw1jRFIBq4feaTGJBu2plN3aExqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: E39B250FB6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245226-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTWF5IDgsIDIwMjYsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBhbiBhdGxhbnRpYyBwYXRj
aCB0aGF0IG5lZWRzIHJldmlldyBvbiB0aGUgbGlzdCBfcmlnaHRfbm93XyENCj4gUGxlYXNlIHRh
a2UgYSBsb29rIEFTQVAuIExpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2
MDUwNjEwNDIxMS4yNDQyLTEtZ29vZGJveUByZXhieXRlcy5jb20vDQoNCkJ1ZyBhbmFseXNpcyBh
bmQgZml4IGFyZSBjb3JyZWN0Lg0KDQpSZXZpZXdlZC1ieTogU3VraGRlZXAgU2luZ2ggPHN1a2hk
ZWVwc0BtYXJ2ZWxsLmNvbT4NCg==

