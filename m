Return-Path: <stable+bounces-254456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AqZJgY6FmoEjgcAu9opvQ
	(envelope-from <stable+bounces-254456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:25:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA35DDEFA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 774F33004D0C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA59217F33;
	Wed, 27 May 2026 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ll1INjnc"
X-Original-To: stable@vger.kernel.org
Received: from iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.216.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B540225413;
	Wed, 27 May 2026 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.216.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841536; cv=fail; b=tdYDoH0H7xzAvMladNY9192civHp9yWAWPCIFrqUD+95ATkTYdubOpPLa2FbMaBwQoMLaMMuYp5FGVsFv+Ec+kbEtL6NR+CXa/SycytRZlxfXICHxkEqm4Pqll42QEWrha+DV4+aIe+k+23/P52VW8rIBi4T8bbnIAYRFHghG40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841536; c=relaxed/simple;
	bh=YoSQfZChB9Aij/5AkmBDxEds29y4JKbMZaIcMVjwvvQ=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jpH/j/091gO/xwShAsHuBYeUHxubZJdAonIjOP4CUpL79Xdly0fwSsLtwwzwOU4SE8wxwkr1CsiE115e/DI/oDoBhTG0E6U4s4VJdpo1MtTNSXfSaFNfz9CKCZA+c6E7LIf8rTAb7pReQ6U+/f8yggRydSeHuR5aRUT9IvFiQf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ll1INjnc; arc=fail smtp.client-ip=3.216.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779841534; x=1811377534;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=YoSQfZChB9Aij/5AkmBDxEds29y4JKbMZaIcMVjwvvQ=;
  b=Ll1INjncM5Ncna+jFEm/Z5ajiSI8rBVyGlQ0UJQTFBruaxMhaa9sP+Rm
   +3dZou4d4rQfQfbvX+eE/0rq22lZoaxJFKbow1cOSVCtSaIjbR4azZg7X
   JJP0YDSMUaUNYQ6wYAunMvqE6Xl60FTGkQRWm7cm+cFGWH7ObdyJDzwgr
   KkHi80YlD5XXnhKBoh1YRCWRJd2pY1V96qXvkBoq7c7BxZGE/r5SpB89p
   zZxoU5wDykXq8IBdjEEjwyZC7VtRkDVmxHvw4agaC8rUfCOm7P2arahPE
   DMYmiSnC0styTe36PZTUIOxkRpsXdVW98QEeE+cGVhm4UEhu9wVbzMLu6
   Q==;
X-CSE-ConnectionGUID: MJR/vd6mTS2hQKA3UQpTPw==
X-CSE-MsgGUID: h1AgKDr0StSfHKy9JHlzag==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="19589548"
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing
 sockets with pending send data
Thread-Topic: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing sockets
 with pending send data
Received: from ip-10-4-22-235.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.22.235])
  by internal-iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:25:31 +0000
Received: from EX19MTAUEA001.ant.amazon.com [72.21.196.67:5555]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.23.96:2525] with esmtp (Farcaster)
 id 717729ed-78af-44c7-b27a-cbbf2fff41ee; Wed, 27 May 2026 00:25:31 +0000 (UTC)
X-Farcaster-Flow-ID: 717729ed-78af-44c7-b27a-cbbf2fff41ee
Received: from EX19EXOUEB002.ant.amazon.com (10.252.135.74) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 27 May 2026 00:25:30 +0000
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19EXOUEB002.ant.amazon.com (10.252.135.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 27 May 2026 00:25:30 +0000
Received: from DM2PR0701CU001.outbound.protection.outlook.com (10.252.134.239)
 by EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Wed, 27 May 2026 00:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHhoa+i7qQFJ3KNG+OhM9SVCqK82ShpMxayvqNWLhxhvMUm+wRQjZQkElF2xHL90EYZUar5HlKYO8hHCTvu39qhmftdZuVk4qu/yJT/OudgX3z8lPVvTmex1hjVU5RfNDT6LJnAngtnCw4HXCktMQv3mtkDyXNWg8pSSTf2dxNmjyj8sKWZ6VL0LOMe05ugk3A91ShYDdSBkLOJf6MmiPgXQRZ+rEKHMbuUAZfoWNNSIKO1fZ6e0kHTRK2T+CxHrwZEEs/xPcqFs7kPB27u8VlBlrn6iO3KiwJL0hLikvLzsFzXeWnp2HS5AOIs/cwfMp73quM4iWn/UbGF4jTJPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoSQfZChB9Aij/5AkmBDxEds29y4JKbMZaIcMVjwvvQ=;
 b=Ovnv4HUWmeEw+ExKyaZUMsWanGZAjJh017gTGd2tbML9JsAAePD7+jpjC/oXry1cRYTDODs969yHZAjAaVwezys/aXwcXM9etk0e53KuBVArD46NC5k6NI9iMeBbr/wOId2dCtSdtCXKZTbhy72DiunbqWSwy2jw1A0DPUE20ccrSPOb8/R9oBEXyz5G35dHKxlh1UzeKfJyjMld94fEVf/FFhZ6Smf7O5edVu8lmca9gmTVRvcWAZ4O7ldDlhwQ/vATmjSZihRtHj3U1azASQW+2D+l8c7AmNOtVkIV/P2IjKQewdza2kCK/UU2lxDhcU7A/8kjyrwK9zpkL4M2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by MW3PR18MB3657.namprd18.prod.outlook.com (2603:10b6:303:52::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 27 May
 2026 00:25:28 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:25:28 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "edumazet@google.com" <edumazet@google.com>,
	aws-binance-tam <aws-binance-tam@amazon.com>
Thread-Index: AQHczskVAbHrfsqWm0ylDOIzc6Zy8LXj+36AgA8bggCAAJPFgIAtIPKA
Date: Wed, 27 May 2026 00:25:28 +0000
Message-ID: <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
 <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
In-Reply-To: <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-05-27T00:22:04Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=10d8ff61-d9ea-4589-9a9e-d40d310336bd;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
user-agent: Microsoft-MacOutlook/16.108.26042616
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|MW3PR18MB3657:EE_
x-ms-office365-filtering-correlation-id: 0240b192-82da-4d7c-b14b-08debb867448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|4143699003|11063799006|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: n7UNsHRNWE4MtpNIKO/E3iQXThETmAI8pG/64C66hoKZXqeg2hwwolQngxe8BZWnngn4uSwDIfIf0pVU/kTn2F/XLltjB4yqMS3rYQEPvWR5D2ZlTb5uu/bdttODh63K5K2HCyW7W1BhBTHq6EcZVUSapJKnY/b36WPSEIvgQ1Qe5EA97i+xJi4Q1WlOCUvESvgshJWvEy1PauO1tLNUO/wneRF8QoBIC8zOJuts+Thwir+r9NHvfLfoTxiA+4uBEIfrxfhLTafD81PB1U1TaRYYWBlMnvrHRYH6nidoySd6WbPpTy4+aY4BK9j6Nq6FPnDo+XsC+iuLp82zGC4mkUcBZo5zrCaPNPlly6aDdIlslFDZdbi+ya/G7Sh0RtZz+qAHB7wDX3Wqt80m3/OKlvsqKK2s5P5L6SNNT1S+yhNrJfPe9ACvOnjOR86SwdB5HLro4lirv2z5V5Y3Jzg9sspq/D2CkOWrlaljBQFYvQoW9HWL6SdtpdPzF6Un4q9wGAq+niHO/o9Ek5gp6soyc/w+Qa8Hylw3PkLVs4xF3ewkhkYubOl6xdVi1lvUCoqpv30m4nk4jKINV6pSgJbfnYVkB3HWi2jbtFfGWcq3Ol3nmJrS0FZJfPM2UUx+R13RD+LZzHyQyrTQP7gkSTOnJJslyinM3/cJWEj4tvK6++kza6LBj6jUu1XCcVJt5pCOrscofHG8fN1UkW+buAdJontMlRQ1KiAq5q8lpjuLNGBO2TWiLKdNYXCuQeKFsCdz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGlzMXNjMDZST1RkNTRhMmRFNFBYeEJpRkFCSFk3bHUrR2YzQktXRUNnNlZL?=
 =?utf-8?B?OEU5cmY4QWdac1M1OXZmRExsMnd1MVh5QlJXSENrMWxQRmdGMEtNM2g2T0Zq?=
 =?utf-8?B?STZoNmwxMWhKVy8rVGRBa1FQaHdWeTh2K0dYc2djQ2FLNnFFRWpjMm1OWjM1?=
 =?utf-8?B?T0Q0Z1pBbXRkMHRacHpxNk52clZwTWU0aGtyVEQ2MkUwMFFiRkxxYkIyc1l3?=
 =?utf-8?B?K3lkQk1UOEJMdWpxdTlPejBWNWhLZ29BUHBOV21aS2lONDI0bllsTXZ6dXQ0?=
 =?utf-8?B?ekViVmRQRnRJcDZXWktjVFRSekZiT2lGbStYZVRGaldKTGRBM1RqaGxxRER5?=
 =?utf-8?B?a2hkMTk5em4wY0c4SXQ2MUJjUHRLU3VGcGJTMlJxeTFxeis3b2I1S2hTWjhY?=
 =?utf-8?B?ZGV5NkJXWUtST0NudFQ0NmhPR3VtakZWZU9BZlRZL2dZaHNiSjIzaDM4MC9I?=
 =?utf-8?B?d2xGa3I0VWpvWENCcFNTTFN3bGlvZ0h2QTAyYUt4VzVQNEdMUG45d21qNVJi?=
 =?utf-8?B?SzVJNkJRMStLQ01uU0Jhb1ZMNUJtazh6VEMxcURhWVoyNG90eEFheXJqbXBU?=
 =?utf-8?B?UEJnZ1cwdkZxcS9sZDlSSm04QzRaN2t5VkhnN09EZ0lpdnA2RjBUaUgzRi84?=
 =?utf-8?B?bGpHVkpQSWRLRHYwU1l6UmRZdjJ2QVUzMGpSSUhSSXJTc09FQVZRWGFGTDBy?=
 =?utf-8?B?VU1PR2RmS2puOW9xbk1TWXFKVlhPK09NQ1JVMGUyL0ZFSEJMQTBIWUVlVXdU?=
 =?utf-8?B?VGlBVHE2L2VZdkVQcHhneU00Sy8vSENvMDlhNUlrVCtjOEsyclhncmFhRVV3?=
 =?utf-8?B?SGYyVWZxRnBrZE5teVc2Qm9xQWgxSCtjd2U5QzVYY0Z3ajEydEtKeEJpVFAx?=
 =?utf-8?B?KzljbHZ5cjBHdVNSMVlwY21DUDJDTXpxQkRFa29EZ0l4d0F5WVVrM0x6S1k3?=
 =?utf-8?B?bllsdVBHcXo2ZTF6aVZQeXA0UENua0FuTjVWVmhNbDBkUUxFSC9laE9sQnFs?=
 =?utf-8?B?ZHp6NUlQRkkwV1M5OHdCbDk1c0NSLzlvR0hDaFpTaXpmKzQwVDFXRFpFYlBh?=
 =?utf-8?B?OU9STG5NYVFRWk90ZXBKbitDSGtjTmE2TjdDeW9xb2xrQXBUVkg3QmVvTnMr?=
 =?utf-8?B?QmhnaExnelNFTk5CNU0zUU1CRnhTcEhQKzJkY3ZvL2daK215ajFqeUVPdHp2?=
 =?utf-8?B?M0ZIL2VXdnhINlh0RmRRVFpTZUxPa1BhOWV5SFRlY1hJL1V5bDFPeXFVYjBP?=
 =?utf-8?B?MDVnL3JxUXcwN0oyekdIMXNsUnNzbktBSWlJS3pQQk0xNldOOXhaZUlZZWww?=
 =?utf-8?B?SlNvN3FoSmdwRytnSFFDeFNxR0I1MDgrRnppRzNId1VPSlpGVnVuZlBnMUo3?=
 =?utf-8?B?N2tCL3d1cHRVaDMzY2hRZ3pIZzZnaklTQ0JzUGY0OHhqeXFaTmFNTm4zSXI1?=
 =?utf-8?B?Z01ZM0Y4cHRNNzZhS2dCcXFncXdNWG5xQUpkcUFWRyt5WSs4RzJrU2hENjgw?=
 =?utf-8?B?emJubHh1bWR0TVF6Q2RnYmpOUGJaR2RXeVFlR2doaXZyY1c0cTNaOHAyK2JZ?=
 =?utf-8?B?VFhVVnF1UGtYYzl3MDNmYVk4TGl1Rk84cGIzYWVRNjRUVWNCa2pFejVwNlhO?=
 =?utf-8?B?MW9UTFROb0hlcS9IM0p0TVJsM1JKMXQ1aFZXaEdmeEV0VkVDUlJCOGU4Z050?=
 =?utf-8?B?eVRRaHcrNXZETU1JKzBXUXdCeEtVSzVLMTBidWZNNE54WjY3OXJ1RUw4amRn?=
 =?utf-8?B?ZFJtMjBObzgwd0lxU0N0TmdjMEtDOGtSeWpGbldvY3FWVDBGTUdncng5VXZG?=
 =?utf-8?B?bVo4L21IL3FBOVY3MjF0WDlybFpiVFJ4aFdIN25HRmtSdHZhUDFvKzR1Y2I5?=
 =?utf-8?B?amt6bDE1NkV1dHlTajUxZmltZjBDUzlWYjJqVmRKeXBhcHVCUDhVckFqRnNO?=
 =?utf-8?B?MnVHT2ZKdzFOdDlDVWE5NVJndEpJYzN5S2hoM0ZTckZ2OEJ0b2w2OWIzdXdC?=
 =?utf-8?B?U3l0YzdSZldDVi9JcVVxMmdNaHo1azB2UDNjYmRCUi9LczhXeXlNaHloRUpl?=
 =?utf-8?B?bDFHeTB0ZmtWZHpzS1BId2w4TXlnU1I1M3NQaEZVMi9XL2p4VThXd1NZV3VG?=
 =?utf-8?B?bnk1QkFUSkZYMHJoRUFQaTM1VTFwSjZERzRxQXVCS2NiSFlXYU5aTXFJVnJJ?=
 =?utf-8?B?dUlqN0hXM1NnaHhrQzZyZHVqUVluRXBFeDk5cHhIbFVYNFdUK1lQbldiZTR0?=
 =?utf-8?B?Mk9aWUVxc3MvelVobWljYStlUEJFNkZGa0hueUhKRFpyalFqUWNqV0lqUEox?=
 =?utf-8?B?Y205UWdLU21RREpsQ2h1YjJPVU9reHAxcFZ6eWVneC9USzhBUGhsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E372023367C73B46836EA4030C69DA8C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DXopWwc8VX47/hSmmo/kwSKexmBZ8hUU2IQWSd9ObbsOEWgBTF8Mr1MnIRYa8BNVsygc+0XE+EleDBWmojMRlMK2iqC7fdcmDHhS/UOIu6B7JNBfGyls0eG9rmIJ/Zz2WmBdh2251+HOItAa/nRjxfwAbEHiOdDPPiKxmiRLvlnq8f4DeSQZXDSAx81q8eakhBYa5ZaVmdVe3Rxag/MCnbRKwQqFWo0zNHhe0W6jrQJR2T8ykYMX30TmLwM+AvUchIES5y906hsMKx3eEtAOpIEOva6B/WwHZM8QyZsnIHeZ+CHNUqEKyu96m9fqQY/KQArgdZpcdb3ur87LFjJlOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0240b192-82da-4d7c-b14b-08debb867448
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:25:28.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtmAcKI1BGF9J0d/JR+WdxOM4xsE3JyxksZ/udtXT5HQOdsbhs+KgGfYe6PgF7aoukSU8AidtwiXAr3qGUdovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3657
X-OriginatorOrg: amazon.com
X-Spamd-Result: default: False [-6.06 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254456-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aarnahmd@amazon.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A1DA35DDEFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ICBIaSBLdW5peXVraSwNCiAgDQogIEp1c3QgZm9sbG93aW5nIHVwLCB3ZXJlIHlvdSBhYmxlIHRv
IHRyeSB0aGUgcmVwcm9kdWNlciBJIGxpbmtlZD8NCiAgSGFwcHkgdG8gaGVscCBpZiB0aGVyZSdz
IGFueXRoaW5nIGVsc2UgbmVlZGVkIG9uIG15IGVuZC4NCiAgDQogIFRoYW5rcywNCiAgQWFyb24N
Cg0K

