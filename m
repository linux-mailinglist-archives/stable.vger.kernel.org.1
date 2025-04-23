Return-Path: <stable+bounces-135256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF5A98725
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF97617EF2B
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DC242D69;
	Wed, 23 Apr 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="pGd2QvEh"
X-Original-To: stable@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022121.outbound.protection.outlook.com [40.107.168.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C332CCC9;
	Wed, 23 Apr 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403412; cv=fail; b=RYISHa81+eDyxVukyPnBC6FyEy2iy8xFxb9Pw6DVapooPzO42sbkss6E5UNvPeSNQnsegY4DFey8a6nQqYOhdLTdsikpJwl7VHd3cdjR1jBluKYz6sFegojOCAjegd2yiJDNXmL30eX8LqhhUCIYLLgyasLyrsW6hnOQKwu+kpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403412; c=relaxed/simple;
	bh=nseFZjuD3Zo/oeOcaVqXU/4dEYVuJJ3VyVH0pA0poQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAUmnOwV1qZlAn/BmxEd5TKvX6pTXFoJvwUnYOKZ2et+NlF4hWwiC/oXHoCYPrpSaM7sNheWhLfZzzOPG/pqIb8VfbX5E/NAls8tSlDlR5lZnqw6WfICvrgZsTvEcbMgHuqCN8mfQPGrzLPSqlPrMKkaIW5VGxd1LH+jW1U3RsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=pGd2QvEh; arc=fail smtp.client-ip=40.107.168.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/SfRlDjny47T4+NSNq1giLdcjCzSwutaa1CoX4rR56N49j8pHCRFttBdRf1w3Qi0qGdEotduRMWk0XX1RIiZo2FrOIzWg8qiumIrbxUAGSqY+cxnXsQLdXRcdjF0jxvut7GE9VLMP5p56+N/Vpp7M51Bkk8y0Rh/07JoJoxwMGdoXQSTt5KspGq0UMbBnp56GfpgyEJwgPxWPGO1/lqrbS+lG/V3eA4voomVTRXG5kQc0DuoC9q71nbkI/A94+ElEy12rH3uFSBlYu3tqSMlq8WFeo+XMeGB3SWzSxdriv0rVZy6oMwYex3a9YdkCe7kJcsUQFV38Z0Tmzsf6rgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nseFZjuD3Zo/oeOcaVqXU/4dEYVuJJ3VyVH0pA0poQQ=;
 b=IpYGcl9KChdLqdUi2rFkQCoAwcuxz1jGhwZdUuPq6CwZWmOArlr9T3u3d1pFqID8GS6fsuCMxkpmxlhPc1RN8E8MZxMLCGXppcz67zyRsy6J6P/GESTD69gfGamTD+JIM8SYJ9GaP4yOiYaqevvmng8yti3Bq6T/fF7iOqv0Fq7QtRMjfUIYSICU+n98+uW84lKAOojHRiPECtlLWfQs6XUSzIErWuO4XgyF4azC7/lnmfEz1jAQvhf7wtJqIirDJ5JY8UKHdNH+PNhl6KAnpqZ3CwDQdka3tEI94qVRnAwIEehGPCcJFXrbhc13topKsLX9unUY3eCNnEgp4W7W+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nseFZjuD3Zo/oeOcaVqXU/4dEYVuJJ3VyVH0pA0poQQ=;
 b=pGd2QvEhJls48zZBE4KeoWgo0AGpvrFtoQQ1cybnCEPQ8IkONMN/KRl4nhOLll4jGZ3v47rsdCRW2w5E6cE4yQ9p53ZbuLZ5vaHcG5A1v/oMLRcWIP8cMOoWpxAHz3ug2BwwSiBy9v2zXm3ck1akh/xkayCp1wec7QeMZevE5eAaF/1xwWIj8zkb34o2U7F74OeWHRqQvw97YYujCAB0IbJMj7xEUCa72kxG1hNqzD5soPbmJA52xI8KPVTf9CpVz34mhz5Y6Pyhd4T3CkISXJUa81NPtpWpDV85THZx6VlPqyuSrGI/zZDx12KBy6mOyXxN0LShaq/IUXdFx6sd2g==
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::6) by
 ZR1P278MB1199.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Wed, 23 Apr 2025 10:16:45 +0000
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819]) by ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 10:16:44 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: Francesco Dolcini <francesco@dolcini.it>, Wojciech Dubowik
	<Wojciech.Dubowik@mt.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Thread-Topic: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Thread-Index: AQHbs48w0QwgOvbFxkuKoITcJDMRw7OxA+uAgAAGkgA=
Date: Wed, 23 Apr 2025 10:16:43 +0000
Message-ID: <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
	 <20250423095309.GA93156@francesco-nb>
In-Reply-To: <20250423095309.GA93156@francesco-nb>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR3P278MB1353:EE_|ZR1P278MB1199:EE_
x-ms-office365-filtering-correlation-id: b4fc94e3-011b-407f-456c-08dd824ff28f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUoyZUNKT2dRVlFoQVFMK0U0emQzcWhqUDF2R2RmbUZTYWR6S3o1YnJhZXg4?=
 =?utf-8?B?UWxlRTZRRlk1aVhmNGhLSDA4US9jRlQ2OGpVTlp5MENxSkJoYjJ5RTRla0pR?=
 =?utf-8?B?VHc0MlhlNHMydWxUNHVVMVUvVTVGL2gxa3BQNnd6dzlaeE44TkxoMkpkMUJt?=
 =?utf-8?B?aXBqbTNDeTAzdC8yQ2Jlb2NIMVhRa1R4NTFqS0xJVm85VnZzYVlaQzBVMWlp?=
 =?utf-8?B?Z0lGcHBFKzBkeFphdFJGVDZqYlRDc2Q4MkdBUzVxam1MSy9MSmNkQWcrdUFu?=
 =?utf-8?B?cU5CUUdoRTMvNlNTcGtWZ081RUhvM2xBSWJaN0hUSnVvZXJGYy9IRVBlK21G?=
 =?utf-8?B?TDQ1dUREeC90aWRJVitCZHF5RG80emUwWkhrbExobXFzejhEY3ArdTJBblhN?=
 =?utf-8?B?R0NKdlFWeElzM0Q3L0VuSGNDamdHdnhIdm1IZ25ZbE1PS0oyU1JHZkU5eklM?=
 =?utf-8?B?R1hUdDYvOWV3bEJaaGZMZUtqeTBSN25nWDhNOElJaGFhZmlia3VWcjRVT2w4?=
 =?utf-8?B?bno3djlsQU1wVmkzQVhUblhMTTh2cEFHVHZyMXo0ZnNOUmVTeXNsVXVqTlFK?=
 =?utf-8?B?djVHVW8xcGtsdUVGUjZrWHBBZXIwd3dWVGNjYWRSb2hjdy9xQ01qT1pWZDMy?=
 =?utf-8?B?YjQzckpHMmc3OVhJV0N5ci85ZmVWOUtQUm5iWHRDUWxvSFhPRmdEb3FLbWNi?=
 =?utf-8?B?UjVJVTJhLzJLUE1KbEsxMkFTZ2R5YTFhNm1CM3laeUlTRkVWdFU4d1JYa0Qy?=
 =?utf-8?B?TVhnQzcxOStzOU1pTHpiVzBjZkRVMWE0Y1JQbTY4N2Y0Z0cyNUR2NkR0SGZD?=
 =?utf-8?B?QTVIYWVYU3J6NGxqNEQzb3lRckxLQVJkazM2TzN2b3JDS2xJeDhTVG9JZkgx?=
 =?utf-8?B?OUdIRDIveUhqMXhhY05jZkU3Zm5XOHpBVkhCY3JLUmtwR1JRSGJmZzdQZmVx?=
 =?utf-8?B?bXMzU2VrWTVaYXNuMEUwaENOMUFmQ3JHK0xreU5odnlGT3YrRFFtaityR3h0?=
 =?utf-8?B?ZmJqeWFzRkxSZXIxREZBTTYyUVY2eUpqVFowbnM4ajM5a3pRaENqeVR3YzJG?=
 =?utf-8?B?THdMZkl1WG4vTFJWek0veDAyVzZhYXJLd2FZbW9BVXRKYlZ4ekJOcXY4czlx?=
 =?utf-8?B?U3EwZjNNNGYzbVlnbjA5ZFdxVS9Gc1RBUkg5OFZ6SGI0dEU5R3p2Wk02Z2ds?=
 =?utf-8?B?L2ZvMUpkK21ZZzQxTjVWd29JeklpUDJkZEpJNE15aHBRTnhMQkthbndFajU0?=
 =?utf-8?B?TlI1ZDlYelpKYWVORWNNOCtTbWt1UkM3MFhrTyt6eThCWGQ0V3NkMC9HU2o4?=
 =?utf-8?B?MVIrU2pGWExqakFCUnZQNVVTOGtSdU1xZC9YT05nQ0NYWGpjNWxiUjREandR?=
 =?utf-8?B?L3NxWFRjWTc5bzN2OXBkdUxKWHhxN3B0YisvcFRDWXd6bmlWOFlGY3hnNW96?=
 =?utf-8?B?elRJY3ZEWDFhdjdaUDY2c0J0UFlyYVI3VGt1eUJKOW1ncE9MMlA0MkhMby9o?=
 =?utf-8?B?QURhT1RWUXR3eUQyazRWTVhSZksrUjVvblpnckU0QnRFTnZURVRad1pXUTJ4?=
 =?utf-8?B?UFpVK0VKSEFxZzlFODB5MjhXdm4xQitSSGVmUnIxTW4vakhxTjN3L3JTdGRq?=
 =?utf-8?B?N3Y1WlV6bjN6SldXblFlQ0pzVnJQQnY1TGgzRStWajI4bE56dENIdkxjWHZo?=
 =?utf-8?B?N0E0clpLamFheDhvbFNncDQ1ZXVtM3dqTTE1Y3E4SW1qbjRFLzFrbGYxVVBJ?=
 =?utf-8?B?ZVB0QjM1a3M1THg0M0szUlhnM01CQ1Rna1NhODRETkdNcWZWTkJRSVNvc201?=
 =?utf-8?B?dEFvak14L0JwaWdGbEhuVlNibFB4QzJNSjE0TFNBbENtdjhYenNOMnlFT0tU?=
 =?utf-8?B?VEhuWXpqajJnV0JIMkozZS9hMjNvWWcvdzlQdGV4bVIzb2s4WDZKOENZSjhp?=
 =?utf-8?B?KzN0YUErU3p5Zmg0SFlPYnA5eHBXTWRaRkVrMzFPRjNnTEd1S3RkM3c4Skho?=
 =?utf-8?Q?9A1MvdknSqCoOUY2fajv0YTd+uYoio=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUcvVlRUVm1URHh1OThKbklyWnA3SmJQSWRuYko3b0JwaHdRNG85NURnc2pJ?=
 =?utf-8?B?WXZ6ZnU5RjJZaGNHSlNpZnMrSXVlZXp6QUVKLzNGTU9UWml3alhrQTZxbExG?=
 =?utf-8?B?SlRwNkxEemZVWTBCcENiZ25sMm01UFFWZXhJcVlYWDRkLzBDYWFyODdjbDNM?=
 =?utf-8?B?MStya3pZY0lpRmdIbGFEdGdIbWdIMkRQLzUrRjVkeVN1TjE3Rm1SeitVVlh1?=
 =?utf-8?B?bzJ5Wks2TUtGYkg3aGJtVlpzNzhJYTJ3WmZaY0ltNGFxUGUwK2YwUDc1NWw0?=
 =?utf-8?B?VFMzdWpBNkNGaVBLQ1ZFQ3BwL0xwWFlNS0xoWDRkdy90UEVyMVZGQWJnNitZ?=
 =?utf-8?B?akp6b2NFS25zZnNSUEYydGtTWW9HRUR3ZWIrL01RM1U5dlRWYmUwaVVrcThY?=
 =?utf-8?B?L3djT1pXdDhhY2dMRjVrdXBXSVFFT2RTRWo2MCsxNGsweC9KZS9YOVRwSkdZ?=
 =?utf-8?B?bHBVK2dTM2R4Rml1WTJPUnhlcTRnd1B3QlNoak81YXdQdzVJSTk5SjZNQ0Rr?=
 =?utf-8?B?Nm1KOEh5cnpjeHZLak5EOE8rMDBmdTZRZWwwWjEwazE1azJrcUtXeDdYMGZM?=
 =?utf-8?B?K2UyMjAwMlJsVnhvcTNJS0FmZS9IKzBlNjhYalFDMU9RNzFpZG9DaGRuLzd2?=
 =?utf-8?B?QlF1eGtZNlc0amhJRUxQYWhDRitNK1c0S0JId0Nwbmo3ZlJRMGRUbGlkT3Ux?=
 =?utf-8?B?a2xZbEpDRmg2ZFBMRjUzcXlzR1M0OEtaTUhRaVZqeEd5bG56SlJDU3FkWVNx?=
 =?utf-8?B?dHdPdmMydlVEbzlqSnJGTlo4UGlIMmp1cXlyRnh4THcyMDNsMUs3ckl3YVg1?=
 =?utf-8?B?ZkhyVXhNK3BmSG5Cd2NtWTJxZzRESS9DUnRzOW5CRXY3NEgycjh2b1JxQlox?=
 =?utf-8?B?a0dGOWNyak9SWnY5UE5kVWF4U3hBVGJtWk1OK3JKVFZzMFY3aFI3MVZWVzRZ?=
 =?utf-8?B?d2ZFbXVSd1dxVnB2aGJqRW5XQ1RHemxwaHZyTldKZGxQVjQ5cm11dUNabEc3?=
 =?utf-8?B?NUhDTlRDd2paY1FJVG1CQ0VjaTM0WVRzUTZDME9qMWl3Q3lUU01UU3JWNEJM?=
 =?utf-8?B?dm1wbVE4TFZLUk9zN0JNN0JKUHlRL29RaWJSTUUrSHJ4ZUUySDdRbzc5RGpU?=
 =?utf-8?B?aGdpd3E1RGtxeThSc0V1SlNWRmZNR040MEtaUGQzdnV3NnVSL2RTSWpKd3M4?=
 =?utf-8?B?SUJJOSszWWQ4UUpVUW9HZng0Z2h1Z1BLWWJKNzBtMHRWbTRaV1YyRm1BR2hI?=
 =?utf-8?B?V2dOTTl1d216QksyVkpvS01LaTFUOVZvZUNHeE9acGltR2NROU9mU0ZHR1cw?=
 =?utf-8?B?QndzWHVtWFdGUFh3dUlNU0ZaZjVZNFNSeXhRSTgvbUJXOUdrUi8rZ1YvbkRI?=
 =?utf-8?B?TVJrUVlYNWhYUkRGV2MvNkN4VTBxUFdzc0R6TC9HeFA5VTJmVzIyZnNMY3h6?=
 =?utf-8?B?ak5Rd1lrMDFtL0l2aTE2SUF2U1M2aUxoVWlCWVlsWmo3RHVTWElsT3lVakl6?=
 =?utf-8?B?WXNDcGJCLzhMUUs0cEdzd3ZNcnNVeUdIeUU4NFBnUW4zYXd5eXlMOFBWblUr?=
 =?utf-8?B?M2hkUlJZRW1RUi84UkNjdWJGTnlLdlovYmtzQ1dXdWk1WWlrNGs3NTNFRXRt?=
 =?utf-8?B?LzVxSFUvNzFNZ2I2V0QwSnVVdTlFWDNmWTd3ZDhWRnhncTcyT3NqWlVmRW9O?=
 =?utf-8?B?SkxXWU9ycHVjYlhUQ1FsRE5VWm1MQmVkWmlGbHU4QjhDNjJDa2syTUh4bTBM?=
 =?utf-8?B?WEE4MWUwNUxUVDNWTWQrbkxlNFZiOVY5NVdpK2kweFJBSlNJUkZ3MzBXeitT?=
 =?utf-8?B?QWRES2dYaGZGcXZLdng3S3U4dWxkSHZTcFgrM25TODBReGpwcEsvK0NHbzVH?=
 =?utf-8?B?algzazFnUXdLb0FOdzJ1SFNMYjdHOW8wZXhsNFUrUm1BRjkvWmZWYmpua0Jj?=
 =?utf-8?B?cTdjV0Y3SlpWMzZlNjh0Q0w4ZEpjTHlWaUt0ZVZCSzdOQXFiM2Q2RkxLek9Y?=
 =?utf-8?B?cTVmNE5wenA1Mm9IcER2VUlLdUd4RnZLTmtWWHNnN2sveGxiOVp3S0psS3Nv?=
 =?utf-8?B?QlVYMUZsNlQwc3AzSXRBYzJ1VG10YlZTMGJWeFBtNTJVcDVBazRSaHZkTE9C?=
 =?utf-8?B?cFhhdHU5NkgvMENIVHJ3OGhzVG1LL1llNDQ5NFEzUHdYUk81aWxTY0FsNExM?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="=-oY88heJAWehmeC5MxMM4"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fc94e3-011b-407f-456c-08dd824ff28f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 10:16:43.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2DYxzOcwzQudhKkFpzrr/J1DWOYYo/MB1KhgeSasr61rk6eyOJN//L56L7NBKweMAyq4gLcLxzS/w/xhlR2RIYaW1pGZku0KmuIubWnv3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1199

--=-oY88heJAWehmeC5MxMM4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-04-23 at 11:53 +0200, Francesco Dolcini wrote:
> On Tue, Apr 22, 2025 at 04:01:57PM +0200, Wojciech Dubowik wrote:
> > Define vqmmc regulator-gpio for usdhc2 with vin-supply
> > coming from LDO5.
> >=20
> > Without this definition LDO5 will be powered down, disabling
> > SD card after bootup. This has been introduced in commit
> > f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> >=20
> > Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for
> > LDO5")
> >=20
> no empty lines in between commit message tags, not sure if Shawn can
> fix
> this up or you need to send a v4.
>=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
>=20
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> I would backport this to also older kernel, so to me
>=20
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for
> verdin imx8m mini")

NACK for the proposed Fixes, this introduces a new Kconfig which could
have side-effects in users of current stable kernels.
>=20
> Francesco

--=-oY88heJAWehmeC5MxMM4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----=0A=
=0A=
iQHTBAABCAA9FiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmgIvggfHHBoaWxpcHBl=0A=
LnNjaGVua2VyQGltcHVsc2luZy5jaAAKCRCNEONHaGhfGp9ADACRAiiAEjFNMVu2=0A=
IMo3rf+rI6FLuzHAeCDc4TS0VpnYvLWhwZPD/ou68Jx7uVTLi+3Yt8YMxs2QwILC=0A=
anFBygQRWH7hHttAfFvi5DfuBMugn0GObznQuKtilHfk0CZcTp+pTKKSZLfGM7Dc=0A=
EigIuhPT1aYop4X7JXi1TTbYCbp+NTpXD3JjKArrMRJw6+UUZCXOotKoxHencsPL=0A=
sxLeP0PPPQIpZ9TVU9EeWMGa46TJoDH/GGmwUIEITBmi2XAe8yzMwOxG/HO1jD/9=0A=
ZdP/9VxsuOSthHcAyWCNeDJEvqNvsAHe6yKoqMvT8se6yA0Kx9FOB3TvyG2GnJuO=0A=
h9UFmX7M6vr7U6Q/WTfIKjcksFKojXvcIq1Myi07EeNGx0/HVUVsTy4rkP0lMz7H=0A=
LcOlynr3QZboV1J9rryDk12ElfN7mipdCBBjXlDQrqFV/5QthZLz8lC0uZw+YT0s=0A=
usWlDYXC9vmPuTXelpOOhBm19XSk7KyNdWtJD+/pISC8EV+Cnow=3D=0A=
=3Dd9ht=0A=
-----END PGP SIGNATURE-----=0A=

--=-oY88heJAWehmeC5MxMM4--

