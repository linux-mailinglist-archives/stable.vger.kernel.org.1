Return-Path: <stable+bounces-226878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAh0H1mSuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:41:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AFD2AFFE0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4DC3082BEF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473837BE96;
	Tue, 17 Mar 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="in8eHki9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEE3793D4;
	Tue, 17 Mar 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769071; cv=fail; b=Cdj988D33+OUInd38yESwDeRcavMC+cjbDVj3oxrAlTWoM/wxxz1tSOhtwtjkDmvevCdEdwbbbvxXyoj2Mh9Q/HvPi/vkkO9f32di4yp8duMLkYi3W/Ic9wBhTczgMKHbbu8Jfq+SbXo2IvEDloeAOVa6nWrxkVd1n46aIgmt5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769071; c=relaxed/simple;
	bh=6r5vMAmtk7Z9UuwuE8FaOnHV5MWHGQORl8hBgZUB3zM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c8kJnlRRNGXuTBhKFdKbppJQDEyi7+g8APzLI7yYd/n7RKES0NhptRfs3g1uohlwpJsoDQ5ExIdVu26inUy7SFHAnqWw2vnYIgyraAnWQRxqR80PWG3PDCpeBX0HPlmh7l2YFxDk7JGEuestRpB9OvJiwG9P52x9wP2+h5fS9Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=in8eHki9; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HGwbR51765614;
	Tue, 17 Mar 2026 17:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=m5
	OES9GZACXPFTp4AxqZy2807tLe5gSi9GxtZN02DTo=; b=in8eHki9PFSPDleZSg
	Sfq2A0oJDTL2E1pt0zKvDkxhRD0dZpz8VoilVymz3hLzR3ijYACVCn9Tp9WDrane
	nWKmwzxLEOCZMuLVfLx+EPgUg40PU4P1HKLCZjVBUldguOP+FvBuHz9ifUlfgFtF
	qzTU9w8Vr0lv2Gh1jfl1yqTNLtJo+rMZduVD30JG/Kk8R6aErHZHolFYpxhv6ZaB
	vhRUMNJGr5L9wyfNDL5ynGqatDR0sq9LzlcAeq72g+2LYt41jvgDNhqUY85imKe6
	i1FBqOBk6SkbIV4goi38gZjedpe2yEV5NtXa6/9GGLQkON2u95d5qlPlkGqZ75CJ
	PtgQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cy8wxtcv9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:37:25 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 0283BD1EF;
	Tue, 17 Mar 2026 17:37:22 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:36:58 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:36:57 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 17 Mar 2026 05:36:57 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 05:36:56 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8ze0OVA6Tbv1sxArF5TAeHwRlfTD1nvcNGtlt6tR/vZkmjtV/INh0Ns1pSxz3O0Iwd85PRGfSnH0JEIWNiTvbpKxzt1brFUSnNML4UwU7GObWovv/YI+Jn2G2SHfEp+HrGuFfUlb4jAIi49s44VKP/nyuk0Mcc0YgaW+TY6rGGLCavlIp19oO2fJjHpujPcNi3r6dNV4snO70iauyLIcKx60fjZp86Pj6ZeoEzxYzBpd891o6ZMfly/MmYgnMO3cL3aeXYnOri1RCB5HcK1LFfhPw9Jkr+QsgFfMl4DFq2BeGrs6jEmEuV0mqiYvMdh2YwMDYxJEmwAu0zeJLJRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5OES9GZACXPFTp4AxqZy2807tLe5gSi9GxtZN02DTo=;
 b=iIAfWXkstLJ6q+m+wFdn/TqK8k6YrIeb+kSx3W3INIkX75HaHkKUQ59mnVmXFIsf5mylCPJDu2GAbnwNAgdgQYoM/D8tpstXcHL0nBkeDnz+c0uxSivyKL5YFv2nKfct+cCxIOKbTp0nPA4UAj2anCUPSQog8SoIW7a5mHsBQ4mPHKyuyOJFGaPnppSewjv/nzUQV7yBdM/6RxGGjtjb9YmZdKqLZiNDudwEJBowMGTsokS8kEuHl3Fp1Md8MtgNBvaJq6chYI/sntevUWlYbGxVUnQ+mPeEBJ+p/6ul8G1I/Gy2FT62rkMzgNlRIcHgmDzN9BtwtyfS4ldsKnlkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by SJ0PR84MB1579.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 17:36:53 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:36:53 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "vasileios.amoiridis@cern.ch"
	<vasileios.amoiridis@cern.ch>,
        "leo.yang.sy0@gmail.com"
	<leo.yang.sy0@gmail.com>,
        "wensheng@yeah.net" <wensheng@yeah.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/5] hwmon: (pmbus/hac300s) Add error check for
 pmbus_read_word_data() return value
Thread-Topic: [PATCH 1/5] hwmon: (pmbus/hac300s) Add error check for
 pmbus_read_word_data() return value
Thread-Index: AQHctjSkJxa6SksOJ02N0swdG6kGTg==
Date: Tue, 17 Mar 2026 17:36:53 +0000
Message-ID: <20260317173308.382545-2-sanman.pradhan@hpe.com>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260317173308.382545-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|SJ0PR84MB1579:EE_
x-ms-office365-filtering-correlation-id: 515691a1-0413-4fc3-25b4-08de844bc732
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 97g9B2me7UmHRnLBBii4KXdWmDUEHyjq4eGm0fANtOdZvAx0L8Qhc/bfFcGFiRIYoM8yu0t76McVHcrAs0N7cJoWfVTlMRb3x65+T7msz3FdFgGI6w6+065S6hw8M2WeYilp0Fl5BTDQxhNS19QPWJ15KVndolUZjsRZaKm+Fiayv5B2jpoR2YcHS4IZxQNEfLXWk1876rFGzRq9wcUl4sdBD627G7aj5+ZEa5Uq/+xGg6kZRumRy/KmVAPCpn6JPBczV01z6kNOD1WbqJulqUsPJy51mGrQoimpWR9HMPA0tQzOIOsVpDY3aXEq5cs7HAeV6Egd0AWHRGzMdRiUlbHCEM5Qg41h/wKU+EEv+gN1oy9tL0xv6M87AoaMws603jFwo9OjNNEvt5vbSSthVAshFYwvXSj+bz9LbD981hdKMtX3oDnUGAM69/3L/9ObGEAlTQIhIgVlD7C6h3iO8BcR0TZVtgE1CX5DkTa8Efty1V57M+sIsRFqyr5chY74bEVTdla04XnTds+B35GiIDtdF+DlcQ4ial9G+hgmGmme13++d/MLW1VAgBkzXQeSLB7g2SCpiuHAzTNcQcJ1cdrVJzDMySqyUf9N6KY45z5cRKSitWSjta8c/wxgO644ALsqlJQcckUkQpqNa7I4JKMTlv4EHY61tyxj38gXY5iTT1Lqqupx0ocGrw97lR+0lVL0iezD97njZMZYHdVdJG1lhfflWHDNMcafCNrckzF46HgA3Uxh+un0ijEiwYoIuBn64wfTujcbejo6fCWKvKCR1uY+PKPIaouqltBe1lM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b4+OFN8LJQMKf51woeuW6wT7NhQ0gPKUq9szNdbzM7U5uwG9dWFECsgnq2?=
 =?iso-8859-1?Q?s83KMNstnSPrsjjDEhd5pcl2+8C37lElNxZ7UNpHKIu+i6UfXV5seOaVeW?=
 =?iso-8859-1?Q?5xZvz8riuTxrTUZMYBWDiKX3eHOW50LWCs/qOxZitHl2uzovc73J52PshJ?=
 =?iso-8859-1?Q?YuLAYhoT0w2uQdRqlJvtmSy0tha6JAZtqp/+CMReYWjmwqNeTV33xhMUvH?=
 =?iso-8859-1?Q?UZOJghk0QiNcwO7y0OsKKgs6umd6PEtot7N46FhIgL8KR2jcBgNvyDAsMK?=
 =?iso-8859-1?Q?7/P1Bbk5EC4lWv6pdS1NjBXx0wWdUIWTdDAB2Db8Mu0arCZS4xQe4nvycl?=
 =?iso-8859-1?Q?6fZfZ1g50rPzVblSUK/uGXej5Gi5N8dgubP++BuQgx/XUeoBQdFJa5yVR+?=
 =?iso-8859-1?Q?X63OQuV+Qn8OMEQvZldvYz9FLth2CkSKhVFcNLuqU2szjvkP1jFxdXabzi?=
 =?iso-8859-1?Q?VohEn+gVWDJhyJOlZrW18ozm/1KjnOIk+h84E9bgwxFOOxE6+HaF/z9/q6?=
 =?iso-8859-1?Q?b3SuImcVl/lrWsSbF074Mo0W5K5TGg8RWQxadeRGzXhZ/Yet+cgtHUg3gW?=
 =?iso-8859-1?Q?trAZHSvEKGPP24m13+lv2oSN5K6huaLBFXK4GfFpVhytwqS/bW5Ct/nspy?=
 =?iso-8859-1?Q?nIh0EY1N+2bQjy1vB5A0U00OtA2mdpUAivpc21xFsc73QtRsDXWdbXSzjV?=
 =?iso-8859-1?Q?OMd2rGgdKEXzYnThe6SeoNX0PTvhNpRHsmL0Jd3V39X7fHyE9cxQ8u41Vj?=
 =?iso-8859-1?Q?uuFNJBDVLbJFupv0P2EjVlpDrQej33tphmyUk76Q2ACpO9NoNUFuO95FQw?=
 =?iso-8859-1?Q?ph/mgH+XSc83dntOHSL0I+XSqIQRiP7SJdHyQYM4fIwTtuTBczs4iBKDod?=
 =?iso-8859-1?Q?vX+4GS0yMTn6oBWJ7Rb5JQXZZ5ZnPHZ6QXfeqSFXsZRhR2301yM1w4786m?=
 =?iso-8859-1?Q?WC/XRGJ6Z++9Y2dV1SnbzQmpnsxvjKXn6n2FGh2BoC/lBcALrjtIkLUYkT?=
 =?iso-8859-1?Q?LxMKTJPO7iTzGf9s4JRUedIPg6XFZ5nK6w4s7HsQzehQ5HSnRkLNkKwB8v?=
 =?iso-8859-1?Q?Vh0w8nWbN10dQuzr4PijwJ9Pd2eGehuKBjSJotQUu37q8pPuhqBYYKgxrO?=
 =?iso-8859-1?Q?7vFNR9UEbLqZF511wkGjFQUwBuJCbgIHfO6O9xbvEl3abXNfBtCb5rUq2X?=
 =?iso-8859-1?Q?pR7SZCGA6oTLtO/6rgdBTGxdacNZv3Lkg7S7o47haQpLQzjWJ5Hr4i0ajY?=
 =?iso-8859-1?Q?qogVMO6rp3PsgtnjVQplNYVHoy1CM/p85g+umm7fRTqJXfk27ky971lp3E?=
 =?iso-8859-1?Q?NIyB+MWxBV1JbHJkUDvv59d+vFNwrG6Mt4zzc5Q1y9DTLPuyH7xFA7pz2g?=
 =?iso-8859-1?Q?78QHZCYhHJ92yXPCQvubfYZyCl4U/jVnoBmuw6447UcHCCi/FUHfz4JTF5?=
 =?iso-8859-1?Q?srHGw/MWEoFSsYKWVD5x6JGT2uyvC96PstZm9r+VbMqHv9myyKxEUJ4xbA?=
 =?iso-8859-1?Q?rYyM1nggdSo8FXNGMEHpf74DyUgQN6B4zPw7sBQ+GeIUcBGOQdUU7W2cAj?=
 =?iso-8859-1?Q?dRVOq5xcQb33hC3vLfuHpXETTdfC3xq2maIxD6EGRcFHkQye5RZFsCwCr3?=
 =?iso-8859-1?Q?Q54znyXOyz/Iu40lHlFKolZJSEX+8f8hZwdxTlc1A88egW6m0063GnwrRL?=
 =?iso-8859-1?Q?KAR+CHScLwBQNl3lAsk+aEuw6hCniLilT0UYLCqxx456mrqXhUbo/G2ZCM?=
 =?iso-8859-1?Q?ilGkH0m6HpulRFbFZy9ZmAeR8TL/EZ/67lNuGIydr5Vt6OTyT7hT0vJCjr?=
 =?iso-8859-1?Q?gk5ATSZoCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PIxiLSi7IAsMt5OcUXmHQNXgLcCAR2X+3Xx69C0v/HTg0+H0sEYldh33umGHosqHYKhiRS0IuPDJ/nBPtUD07s6o4z5DyonPYhrt+nxrmyT3hSwJv1NcaKPreWseB3yh6+4EMWo1MmXyPmn/1HwVrDlFyTl1ZqL93vM+U8aa/3NLphqQPtCAv4uVb3bhJJA+4Pc9natBRA+fwPNcOQA5cYrkdGmAYzcgAvlXqudmNryOK3rJycFpC2BHb8nckkMxlw0kAEccqfAy5Vy/VOPs0USAmTt1GS6G/TSmgdGJYhNA4P4KXN4i3PCPiTqS7NxQ2P+XkN6SzYMwUaG1putwLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 515691a1-0413-4fc3-25b4-08de844bc732
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:36:53.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FT6uDkER4Zl4NQn6MWPHWbE0kVRihI4TiByvNiojn5COChsI507HgSCmk49Qrv7uLS03472a7uSJsizua4oTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1579
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 9IRBYVjiJeJFufaHCxwpCBwFMK-FZ9I3
X-Proofpoint-ORIG-GUID: 9IRBYVjiJeJFufaHCxwpCBwFMK-FZ9I3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NSBTYWx0ZWRfX4UiUxRZn9jF4
 qCXt7tiXo7v2QSO2QVC2nCso1E0TCI/U0NvU6AAxe4pn7QT5cJ5hjXuuF5/Aw1oYoe7b6zy63mb
 sibnwphVypbmPB4l+w/CfH8CrceFKWcOSiSp2oBNqjdMl9qJqdjUkQ7ROfBZDFjZ5C3Uw7roz8D
 Lb9nftRwLTifWAFfzQPuvCNbi85aAQzk1QD2WFP3jtMxs1216y58hyCmsqD7boYff9YetcxYQhe
 ww6QMbA0rFCVXb0A7RynSUsU8HacugKEPecCU4ESbw8IWew5tbjl1abAWPOB3hth+eRofBmdqzN
 4VeDBYRBAZdDf7/+G/FbbKO5AvRLItIS+7ImgIuja1BDS31InV7Xg7pnDPj9JoCKLz9ydywOGbc
 2tR2XwE8ZuRK+IreSMq0bMbPD/Esae+9G+bUxuOfRGJrPKzqD42F5jMPPlbVHst04qZHJcvNwcm
 EfAEQq4fQTjFKkfJR0g==
X-Authority-Analysis: v=2.4 cv=X6Bf6WTe c=1 sm=1 tr=0 ts=69b99155 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ZSrvDirOKP4VPF05hnFf:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=COJ2-eEL2OBisENHhsAA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170155
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226878-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[roeck-us.net,cern.ch,gmail.com,yeah.net,vger.kernel.org,juniper.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,juniper.net:email,hpe.com:dkim,hpe.com:mid]
X-Rspamd-Queue-Id: 34AFD2AFFE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
hac300s_read_word_data() passes the return value of pmbus_read_word_data()=
=0A=
directly to FIELD_GET() without checking for errors. If the I2C transaction=
=0A=
fails, a negative error code is sign-extended and passed to FIELD_GET(),=0A=
which silently produces garbage data instead of propagating the error.=0A=
=0A=
Add the missing error check before using the return value in=0A=
the FIELD_GET() macro.=0A=
=0A=
Fixes: 669cf162f7a1 ("hwmon: Add support for HiTRON HAC300S PSU")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/hac300s.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/hac300s.c b/drivers/hwmon/pmbus/hac300s.c=
=0A=
index 0a1d52cae91ed..a073db1cfe2e4 100644=0A=
--- a/drivers/hwmon/pmbus/hac300s.c=0A=
+++ b/drivers/hwmon/pmbus/hac300s.c=0A=
@@ -58,6 +58,8 @@ static int hac300s_read_word_data(struct i2c_client *clie=
nt, int page,=0A=
 	case PMBUS_MFR_VOUT_MIN:=0A=
 	case PMBUS_READ_VOUT:=0A=
 		rv =3D pmbus_read_word_data(client, page, phase, reg);=0A=
+		if (rv < 0)=0A=
+			return rv;=0A=
 		return FIELD_GET(LINEAR11_MANTISSA_MASK, rv);=0A=
 	default:=0A=
 		return -ENODATA;=0A=
-- =0A=
2.34.1=0A=
=0A=

