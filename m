Return-Path: <stable+bounces-219598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHNSMTrtnmk/XwQAu9opvQ
	(envelope-from <stable+bounces-219598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:38:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF2E197787
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8671301FCB0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706DD3B5301;
	Wed, 25 Feb 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="soUrT5NB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314A38E13F;
	Wed, 25 Feb 2026 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022890; cv=fail; b=PxifKTjIIyHu4MfDfkrAQ33UGaBFNUuHXr+6FSKEPO/N52WNjMIzuaj074M27Qfv+XuwDAgG+TFyMGSmIfJalqZmdf21Nfg8c/eOKZx8bijRMiB612eyv+omthqerB/lPLHiHy8grARin7mPbXB2QJ9G1StV87aNLISh6VDgNQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022890; c=relaxed/simple;
	bh=sDM7RwVOQdNOlkFHl0dA6GdXkafWnKeez3FVSeuUhkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTkFtJDNgZ+VwssT+CMYdHpI7UiGtOGZCfXVebW3L46P/Tsp0NHjOlTfmeS941WPVp6W7KgDx34jSyG0ld6LBFpk1ksIUXbSdj6nuQPnffEdrMVWuM1eUihwZ66nnQzVrBDshN4opz13I3WfS7CvyjScztu2PtIeRj/vH65YNno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=soUrT5NB; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P1OgV33894994;
	Wed, 25 Feb 2026 04:34:31 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021116.outbound.protection.outlook.com [52.101.62.116])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcys7uf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 04:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9MZ8Y7Sb9or7W+RR4TEeTxqKkchAtF2XytroTtfpKITYtNpIO38nYMql7Qd2tgZLGbrJx6MUrQBsOPJ/U6LSlyW6b9PxKROvIABmCVMqDkYzBmoroteFohk1OgUjzwVlLKSXbTTf3U/7T4Tn7VfW1YudxpRA+TyM8SDRJSIJ1wwXh4V91POFKgTkr2Ta7DL3eyNDj+eIaljGt98nBUxvf1UHWMG530DOk7kspdufcLcyCw7t+Lnu5yOxfqrrPjVNWajIO7X903TS44uTHWQWH7uo20Xt0dASPLbXztcNIPH0RZmqvaRrj2Xvoy7X5paP2Lg3+k8+wvtzXeaZA/uEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDM7RwVOQdNOlkFHl0dA6GdXkafWnKeez3FVSeuUhkI=;
 b=b4Cra7Bn00cO2dXf/zSY9m6aQvsqfVVSup8KISHY+yIebfDnBUKEhBPlQZ4AiL/0O+03igiN71SpNFBEa3emB2ck2EOrGVVUYl3nhvUXIz+KP5DV2qOrt3NgnVsNM1LhV98xPD7Bg9GRKimCgIJgIGPdwgjKQcLRT9Ya4EtIOKpYjH/yrXqjNproVnbjwf5jL2fig24R7jbrORzZPLbSZIRd623Pc9sajRyvMsJCZBTiOh3is38bPmY43XJN9162oSAQAaUv4AasAY53D+V+oabfgfB5FMYvt0dkycSxVnSQno7mpHxoWYvf4ryj7qOvqr/kcQM4kCHmiLTasFx7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDM7RwVOQdNOlkFHl0dA6GdXkafWnKeez3FVSeuUhkI=;
 b=soUrT5NBdiiBwEKelaxGAvABpuIMxajeSfjCqZgGx0TdXil1Ou4+RG4ofpLgdDosYIeQP/+OkkX2Wv6CixgFfzah/u/IUrG22AtMSJzd7bHyIPL2dXLXEx0xJJ9bNMeRhOfXHpcVByannlMiVLSzrO9sgA/vNTI/kkQ5e0+iWac=
Received: from BY1PR18MB6374.namprd18.prod.outlook.com (2603:10b6:a03:5aa::19)
 by SA1PR18MB4776.namprd18.prod.outlook.com (2603:10b6:806:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Wed, 25 Feb
 2026 12:34:28 +0000
Received: from BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374]) by BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 12:34:28 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index: AQHcpVsOKxOBWB2/y0CrIf5i5ji46rWTMV0AgAAk+ICAAAJzgIAAAelw
Date: Wed, 25 Feb 2026 12:34:28 +0000
Message-ID:
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225072355-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6374:EE_|SA1PR18MB4776:EE_
x-ms-office365-filtering-correlation-id: f1adb7e4-f6cd-419a-2803-08de746a3802
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 qJMbsj2BPuyyCvCWB7T9yNj7ph0wbI8KrddLNvRROimFeWCOMcWYdWHsEwHPk0gHZQflsMYhgw0co66H5D5bHIGxtWJKUM1TZLQHszHC2EGvGkg6icykAXWncBBuIwrpEWuXNJfXfpYnt5PaXQ+y3lB3VV3pGlZkCbRW7uaJ71VEaM6HDpiWKhfv8OZdD3ahETlE3XzfTzDxSXx5PtDm5SxpvzHW8xjZLxH6fm8yUHwjHHmkH5uMTfWOKbKvfbcPm4yNZj5NjCuStUcJ/5+1C3I8an5AGCe8brGgzfUBnrQ20cfAcPQS8X3WqGfA3nhhVHDt4PIg8kozJHv/C6HdJ42HIWFvxkSdyIPvymRp8wJxCw5NUJ8aW6+uvC0zphzJqsfwaRSCedUHkVXj9If8qL7OPqC+6hQBxMNJmrQvet3APfiUZWVIV1HgECgW0ShiRocz5QVr7VHnycYmVjIN3tXnYZLJOeDG9QabKCNv7cPgIZ3pqvfRvkHGRod8SanfLw7GWaD9xYzudO2hs5R4+w6zreYOXpwwS6jVZdue8UTV3XN4p8RSZ2X7Nx9sJPzFbTANlBjVkw1MwjNyTLKTSui3lxQWaOCCNqEyF62KcDnWDTTpeNAyjHdLRFHXjQA6RucLUBMygxMYYS5skMOI1ACAbA2hR/JxVy3fhpSQHcugaxY9pbj+lFMjXsJBIjcKOIpkB6FdSVLrXfCyBhWzxSWMl4atTiKlF0g7hAUnTnkaesiUMxC/1KF9mvIhtrCwhQeaGVqCSjKY/KtQuA3IehSeaHb4VmAAf4JJNqRzhJQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR18MB6374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEp1UHkyL1djR1RCdXdhWXFUR1A3elkyUEJOeEt3eU42MjJkNjdCVEhlYUVl?=
 =?utf-8?B?dVBlYmVNTWlLSVBhQ3NXeGtvNHB4ZW5HRmxzNGRmZjU0bFJsem43cGxNdDha?=
 =?utf-8?B?blh1NlhqWGYzeDY0R0s2SFRRWFRzZmdwQWVlNk9qZDRac2xNa0RCemZ2b2xU?=
 =?utf-8?B?Zm1VNnRaYzVkdldZSlF0dm1kNzJVYzJCanhNd1ZoYW9tczFWS292ek9KZzB5?=
 =?utf-8?B?RlRFbDFONzZ0S2w4NzZnUjhNNDhsMk9qdytZUHFkcVY1eXVDTmFEZjZLdjIy?=
 =?utf-8?B?T1o4QTZiUDZpZFFQSVhUMzNubFRQYjAwQ2pLbmgrb3c3MEtxN0tFTkRIS0JM?=
 =?utf-8?B?NWdGTVNHaVNIVFI4NDNGYXFVQlpvSlZrQ2RkQWh4a0pZRkpHYlFyM2MvUzQy?=
 =?utf-8?B?TjZMQXZVRzExYnFhcHptNzFtVXRmMnozV1FXSVk4VTJtRDUzSTNiVDAvTGlP?=
 =?utf-8?B?bHlNQUtWUWdDL0JqdFZSR0VSL2hic3BINVVlVVp6UmMxZzE4NEJsdnVSdURG?=
 =?utf-8?B?akhqY0xua0hkRjM1d3lSTVVXUkhPNlFPMEhEM3hQSExBMjZzSGlvWXFabjhw?=
 =?utf-8?B?VjI0dWRsVDhVaG9NOUR6NE11NjQ4M3RCaEszVFhrVFB2WVlzYkFPK09GUzhX?=
 =?utf-8?B?Z3RqWUNnWW4vUEFpQksxUXhaZ2VhVERMMUhMWXM5WUZ0UDM4RWlRdlJpazJ3?=
 =?utf-8?B?SlZRem5Zb2ttSVplUEtNQmRmR3dDOTRnZ1Y4LzlLWjRYU3EyNnRNb1JqWGJ3?=
 =?utf-8?B?RDFZUnQzUElpdmdWakdLODFhZGFUNTRiV2hyUm5IdERsc2ZWaWZrN1NZczlS?=
 =?utf-8?B?SnNhR3VMT2grL0doY3FScFArc0NiYjQrSjhLUE56UkJya2NzV1VXRzRZV090?=
 =?utf-8?B?TzAxNDZINVpNd3Bnc3E0RFBVcCt3T3RaYW1qNDVZWXZseUNvYytnOERJZ1FK?=
 =?utf-8?B?UWVZNldwQVQ3Y3V1Mno4NVpUN3pONFFpWDMvRUFWeHRGVStGblRtenlCQXVE?=
 =?utf-8?B?ZElxUGNxRzUvRHdSd2JGa1pxdWxSMFp6aU1EaHZQUWpKTlhHVEQvelpuaVpO?=
 =?utf-8?B?RVN2bFBDczFPNnE0bUR0dlA1VGk4M1B0NGVFVlB4c2NDcktwWkhsR1BSUTda?=
 =?utf-8?B?NkNYRUgyeGNodStla1M2dzhxOHVaUVlNWG4rbHMrdmZkdS9nVlhhNFQ5Mlk5?=
 =?utf-8?B?VFRrYlZHcFJsSHRxcVB2enFlMHJuZnBoT3lmcDMzRlduSU5pSE8reUxtZ1JI?=
 =?utf-8?B?L09IaCtqejYrUjdqZ1FYUTJON1lrWnR6NkdNQXFDZjN3MkJqYmZQaFA0cWpY?=
 =?utf-8?B?VGo0RUpoU3J1THFOL0VVUHB2S0VzcndFcHRVdExGcTFFTHB2Z2t2TDV1VXpo?=
 =?utf-8?B?TmZGTWs4QWlBeVBKVHNVbldmS05kb1gxUWZSU2plekpCMFpCNDJGZXUrUjFt?=
 =?utf-8?B?UVNlZGpTMnk2SnE1TG9laXBUamg1aUlvQnBFQ2ZzTytIdWFvSlhKVTduSXBM?=
 =?utf-8?B?L1MrbjhPMysyYlNWZVpFazlhZWtBQkM2ckdNWDB0L2tVSXpyNjhWb2JoSUpk?=
 =?utf-8?B?MnhQWkZtT3NncFUxdEd2S2dzUXJVeHl1OVAyaS84bFErQnJBTlIyNU5TT0Jx?=
 =?utf-8?B?dmdtOXdMRGF1Q1l4V0RKbmcvYzVST2tibDBBQUcxTlhWZlkvMW92MGRYZnkv?=
 =?utf-8?B?eHJIcU1waTZnSkVTTytLS3dmYXZXdW1YRlRha1R2YzZBQXo4UTlrcHBTblJq?=
 =?utf-8?B?SFFodVJBSE8vcEFpNFQvYUVpMnVncUtPaEtlUk9MVktjdW9IY1cvdHY4RGVh?=
 =?utf-8?B?VFFWUk5SS3EyL0phaS8rN2hMSnJnRTJ5N2NGRUVsMC9ES2J6azJ3Y0l2WWxM?=
 =?utf-8?B?YnhnZXYvcnRteDFIWk9OeWF0Q2JRanBhTW9WN2ZnZzlqYys1bzFsdzBwTmlr?=
 =?utf-8?B?Zjh3VzB5dzFaYUxOV0NsMldVM3JjdENFT2poMEtETmI3ZTgycllPc21QN00r?=
 =?utf-8?B?aXVyMUhya29nZCt0UUZPZ0JTUS9mUDNWREVYNzdkWU1jbmxyVDllOHpMYjh2?=
 =?utf-8?B?Yll5anJyRXVLam1ya2JidUtOcCs4MUlSbW5UZzBRRVgvRVRSNXAyeFpYbjlN?=
 =?utf-8?B?TkRkSWRnYXJRODhhd3dnWGM1TStuZ2JlaWlsLzI5VGw1N2o5OWw2eUJxb3dO?=
 =?utf-8?B?V3hQdzJJeXIyRjVwY3RiTHNMc05yVGVOeUpRMmhsVHdzU0grd0pYMjFlRXBm?=
 =?utf-8?B?UjhDTC9SQ2FmZ09xdmdxejRQVEgrY2poNXpnWEl1dk5mTGRlRlNNQ21MZ2tH?=
 =?utf-8?Q?eFFQ3HY2r7PuT/BnLn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1adb7e4-f6cd-419a-2803-08de746a3802
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 12:34:28.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl3J/Gz2ql92DS0g832sWtNuga3rfpeA4HjLK+Hj6wDGvhQ7GzaNmNlENMArcAXI1PZ5H4TdkzggOHbQlq2TKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4776
X-Proofpoint-GUID: JSg9nvF0-XCzrCAd2tA_TORooMzXd7Hq
X-Proofpoint-ORIG-GUID: JSg9nvF0-XCzrCAd2tA_TORooMzXd7Hq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMiBTYWx0ZWRfX2DfjsMP2T5cR
 RF09NKjOfP6aUSI1Y590MvrIHCo6B/+Hc2xX6yK6KRY6y/6aA1iq33M52I1TTSg3xdWipPa1Elu
 /nE3/gnFzX+VOqBgMH/WBR1+FCe1+wkEGCfyBqMGqo55Y0t8jikm0VOg7PPS3cl4h4fssudTlZP
 cPPGZ7FYcvRgbD3OpTR+u3S60IzrmEidx0UWxboQVN46cXkKzTxh0w78EaM6WC80JBW9mJSi8aS
 oXAlshBv3SfSnQh81rs4zSv38d42UGEjhD/1YH2nbsTzeepo10C60+AI3HA4LsEsklrUUMuOIaq
 /HXWedg54naomgYypqTL4e467sp8PMlKTkmzzShRVEK7q4ES++U2/ONhASQkkAlQO4HD5HZYkU3
 9dwrHpXAlvaFp/zeb4IDL4ktVGgTiV6e9lWb3EIR2DQVjjfyrUDui/4Sq3/HErlFxvLQF9AYDVK
 0NOGJDXD/A8cRkfr2iw==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=699eec57 cx=c_pps
 a=9Rg/qTnvelsXqi2P0wmk1A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=cUgW7scuS1H_IRUmP_gA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219598-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,BY1PR18MB6374.namprd18.prod.outlook.com:mid,marvell.com:email,marvell.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2DF2E197787
X-Rspamd-Action: no action

PiA+ID4gT24gVHVlLCBGZWIgMjQsIDIwMjYgYXQgMTI6Mjg6NDlQTSArMDUzMCwgU3J1amFuYSBD
aGFsbGEgd3JvdGU6DQo+ID4gPiA+IFJlcGxhY2UgaGFyZGNvZGVkIFJTUyBtYXgga2V5IHNpemUg
bGltaXQgd2l0aCBORVRERVZfUlNTX0tFWV9MRU4NCj4gPiA+ID4gdG8gYWxpZ24gd2l0aCBrZXJu
ZWwncyBzdGFuZGFyZCBSU1Mga2V5IGxlbmd0aC4gQWRkIHZhbGlkYXRpb24gZm9yDQo+ID4gPiA+
IFJTUyBrZXkgc2l6ZSBhZ2FpbnN0IHNwZWMgbWluaW11bSAoNDAgYnl0ZXMpIGFuZCBkcml2ZXIg
bWF4aW11bS4NCj4gPiA+ID4gV2hlbiB2YWxpZGF0aW9uIGZhaWxzLCBncmFjZWZ1bGx5IGRpc2Fi
bGUgUlNTIGZlYXR1cmVzIGFuZA0KPiA+ID4gPiBjb250aW51ZSBpbml0aWFsaXphdGlvbiByYXRo
ZXIgdGhhbiBmYWlsaW5nIGNvbXBsZXRlbHkuDQo+ID4gPiA+DQo+ID4gPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gPiA+IEZpeGVzOiAzZjdkOWMxOTY0ZmMgKCJ2aXJ0aW9fbmV0
OiBBZGQgaGFzaF9rZXlfbGVuZ3RoIGNoZWNrIikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3J1
amFuYSBDaGFsbGEgPHNjaGFsbGFAbWFydmVsbC5jb20+DQo+ID4gPg0KPiA+ID4gLS0tIHNob3Vs
ZCBjb21lIGhlcmUgYmVmb3JlIGNoYW5nZWxvZy4NCj4gPiA+DQo+ID4gPiA+IHYzOg0KPiA+ID4g
PiAtIE1vdmVkIFJTUyBrZXkgdmFsaWRhdGlvbiBjaGVja3MgdG8gdmlydG5ldF92YWxpZGF0ZS4N
Cj4gPiA+ID4gLSBBZGQgZml4ZXM6IHRhZyBhbmQgQ0MgLXN0YWJsZQ0KPiA+ID4gPiB2NDoNCj4g
PiA+ID4gLSBVc2UgTkVUREVWX1JTU19LRVlfTEVOIGluc3RlYWQgb2YgdHlwZV9tYXggZm9yIHRo
ZSBtYXhpbXVtIHJzcw0KPiA+ID4gPiBrZXkNCj4gPiA+IHNpemUuDQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyks
IDEwIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gPiA+IGluZGV4
DQo+ID4gPiA+IGRiODhkY2FlZmIyMC4uZWVlZmU4YWJjMTIyIDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jDQo+ID4gPiA+IEBAIC0zODEsOCArMzgxLDYgQEAgc3RydWN0IHJlY2VpdmVfcXVl
dWUgew0KPiA+ID4gPiAgCXN0cnVjdCB4ZHBfYnVmZiAqKnhza19idWZmczsNCj4gPiA+ID4gIH07
DQo+ID4gPiA+DQo+ID4gPiA+IC0jZGVmaW5lIFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSAg
ICAgNDANCj4gPiA+ID4gLQ0KPiA+ID4gPiAgLyogQ29udHJvbCBWUSBidWZmZXJzOiBwcm90ZWN0
ZWQgYnkgdGhlIHJ0bmwgbG9jayAqLyAgc3RydWN0DQo+ID4gPiA+IGNvbnRyb2xfYnVmIHsNCj4g
PiA+ID4gIAlzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX2hkciBoZHI7DQo+ID4gPiA+IEBAIC00ODYs
NyArNDg0LDcgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7DQo+ID4gPiA+DQo+ID4gPiA+ICAJLyog
TXVzdCBiZSBsYXN0IGFzIGl0IGVuZHMgaW4gYSBmbGV4aWJsZS1hcnJheSBtZW1iZXIuICovDQo+
ID4gPiA+ICAJVFJBSUxJTkdfT1ZFUkxBUChzdHJ1Y3QgdmlydGlvX25ldF9yc3NfY29uZmlnX3Ry
YWlsZXIsDQo+ID4gPiA+IHJzc190cmFpbGVyLA0KPiA+ID4gaGFzaF9rZXlfZGF0YSwNCj4gPiA+
ID4gLQkJdTggcnNzX2hhc2hfa2V5X2RhdGFbVklSVElPX05FVF9SU1NfTUFYX0tFWV9TSVpFXTsN
Cj4gPiA+ID4gKwkJdTggcnNzX2hhc2hfa2V5X2RhdGFbTkVUREVWX1JTU19LRVlfTEVOXTsNCj4g
PiA+ID4gIAkpOw0KPiA+ID4gPiAgfTsNCj4gPiA+ID4gIHN0YXRpY19hc3NlcnQob2Zmc2V0b2Yo
c3RydWN0IHZpcnRuZXRfaW5mbywNCj4gPiA+ID4gcnNzX3RyYWlsZXIuaGFzaF9rZXlfZGF0YSkg
PT0gQEAgLTY2MjcsNiArNjYyNSwyOSBAQCBzdGF0aWMgaW50DQo+ID4gPiB2aXJ0bmV0X3ZhbGlk
YXRlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiA+ID4gPiAgCQlfX3ZpcnRpb19jbGVh
cl9iaXQodmRldiwgVklSVElPX05FVF9GX1NUQU5EQlkpOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4N
Cj4gPiA+ID4gKwlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9SU1Mp
IHx8DQo+ID4gPiA+ICsJICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0Zf
SEFTSF9SRVBPUlQpKSB7DQo+ID4gPiA+ICsJCXU4IGtleV9zeiA9IHZpcnRpb19jcmVhZDgodmRl
diwNCj4gPiA+ID4gKwkJCQkJICBvZmZzZXRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsDQo+
ID4gPiA+ICsJCQkJCQkgICByc3NfbWF4X2tleV9zaXplKSk7DQo+ID4gPiA+ICsJCS8qIFNwZWMg
cmVxdWlyZXMgYXQgbGVhc3QgNDAgYnl0ZXMgKi8gI2RlZmluZQ0KPiA+ID4gPiArVklSVElPX05F
VF9SU1NfTUlOX0tFWV9TSVpFIDQwDQo+ID4gPiA+ICsJCWlmIChrZXlfc3ogPCBWSVJUSU9fTkVU
X1JTU19NSU5fS0VZX1NJWkUpIHsNCj4gPiA+ID4gKwkJCWRldl93YXJuKCZ2ZGV2LT5kZXYsDQo+
ID4gPiA+ICsJCQkJICJyc3NfbWF4X2tleV9zaXplPSV1IGlzIGxlc3MgdGhhbiBzcGVjDQo+ID4g
PiBtaW5pbXVtICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+ID4gPiArCQkJCSBrZXlfc3osIFZJ
UlRJT19ORVRfUlNTX01JTl9LRVlfU0laRSk7DQo+ID4gPiA+ICsJCQlfX3ZpcnRpb19jbGVhcl9i
aXQodmRldiwgVklSVElPX05FVF9GX1JTUyk7DQo+ID4gPiA+ICsJCQlfX3ZpcnRpb19jbGVhcl9i
aXQodmRldiwNCj4gPiA+IFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCk7DQo+ID4gPiA+ICsJCX0N
Cj4gPiA+ID4gKwkJaWYgKGtleV9zeiA+IE5FVERFVl9SU1NfS0VZX0xFTikgew0KPiA+ID4gPiAr
CQkJZGV2X3dhcm4oJnZkZXYtPmRldiwNCj4gPiA+ID4gKwkJCQkgInJzc19tYXhfa2V5X3NpemU9
JXUgZXhjZWVkcyBkcml2ZXIgbGltaXQNCj4gPiA+ICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+
ID4gPiArCQkJCSBrZXlfc3osIE5FVERFVl9SU1NfS0VZX0xFTik7DQo+ID4gPiA+ICsJCQlfX3Zp
cnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05FVF9GX1JTUyk7DQo+ID4gPiA+ICsJCQlfX3Zp
cnRpb19jbGVhcl9iaXQodmRldiwNCj4gPiA+IFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCk7DQo+
ID4gPg0KPiA+ID4geW91IGZsaXBwZWQgdGhlIGxvZ2ljIGhlcmUgYW5kIGl0IG1ha2VzIG5vIHNl
bnNlIG5vdy4NCj4gPiA+DQo+ID4gPiBEaWQgeW91IHRlc3QgdGhpcyBwYXRoPw0KPiA+IFllcywg
dGVzdGVkIHdpdGggTWFydmVsbCdzIE9jdGVvbiBkZXZpY2UuDQo+ID4gPg0KPiA+ID4NCj4gPiA+
IFNvIGlmIGRldmljZSBpcyBwb3dlcmZ1bCBhbmQgc3VwcG9ydHMgYSB2ZXJ5IGJpZyBrZXkgc2l6
ZSB0aGVuLi4uDQo+ID4gPiB3ZSBkaXNhYmxlIHRoZSBmZWF0dXJlPyBob3cgZG9lcyB0aGlzIG1h
a2Ugc2Vuc2U/DQo+ID4gVGhlIGludGVudCBpc27igJl0IHRvIGRpc2FibGUgdGhlIGZlYXR1cmUg
b24gY2FwYWJsZSBkZXZpY2VzLCBidXQgdG8NCj4gPiBlbnN1cmUgdGhlIGRyaXZlciBuZXZlciBh
ZHZlcnRpc2VzIHN1cHBvcnQgZm9yIFJTUyBrZXkgc2l6ZXMgbGFyZ2VyDQo+ID4gdGhhbiB3aGF0
IHRoZSBuZXQgZGV2aWNlIGNhbiBhY3R1YWxseSBoYW5kbGUuIEV2ZW4gaWYgYSBkZXZpY2UgcmVw
b3J0cyBhIHZlcnkNCj4gbGFyZ2Uga2V5IHNpemUsIHRoZSBkcml2ZXIgaXMgY29uc3RyYWluZWQg
YnkgTkVUREVWX1JTU19LRVlfTEVOLCBzaW5jZQ0KPiBuZXRkZXZfcnNzX2tleV9maWxsKCkgZW5m
b3JjZXM6DQo+ID4gQlVHX09OKGxlbiA+IHNpemVvZihuZXRkZXZfcnNzX2tleSkpOw0KPiANCj4g
c28gY2FwIGl0IHRvIE5FVERFVl9SU1NfS0VZX0xFTi4gV2h5IGlzIHRoYXQgYSByZWFzb24gdG8g
Y2xlYXIgdGhlIGZlYXR1cmU/DQpPdXIgZGV2aWNlIG1hbmRhdGVzIHRoYXQgaGFzaF9rZXlfbGVu
Z3RoIG11c3QgYmUgaWRlbnRpY2FsIHRvIHJzc19tYXhfa2V5X3NpemUNCnRvIGd1YXJhbnRlZSBz
eW1tZXRyaWMgYmlkaXJlY3Rpb25hbCBmbG93IGhhc2hpbmcuIElmIHJzc19tYXhfa2V5X3NpemUg
aXMgbGFyZ2VyIHRoYW4NClZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSwgY2xhbXBpbmcgdGhl
IHZhbHVlIGlzIG5vdCBmZWFzaWJsZS4NCj4gDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gKwkJfQ0K
PiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gPiAgfQ0K
PiA+ID4gPg0KPiA+ID4gPiBAQCAtNjgzOSwxMyArNjg2MCw2IEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9wcm9iZShzdHJ1Y3QNCj4gPiA+ID4gdmlydGlvX2RldmljZQ0KPiA+ID4gKnZkZXYpDQo+ID4g
PiA+ICAJaWYgKHZpLT5oYXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hhc2hfcmVwb3J0KSB7DQo+ID4g
PiA+ICAJCXZpLT5yc3Nfa2V5X3NpemUgPQ0KPiA+ID4gPiAgCQkJdmlydGlvX2NyZWFkOCh2ZGV2
LCBvZmZzZXRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsDQo+ID4gPiByc3NfbWF4X2tleV9z
aXplKSk7DQo+ID4gPiA+IC0JCWlmICh2aS0+cnNzX2tleV9zaXplID4gVklSVElPX05FVF9SU1Nf
TUFYX0tFWV9TSVpFKSB7DQo+ID4gPiA+IC0JCQlkZXZfZXJyKCZ2ZGV2LT5kZXYsICJyc3NfbWF4
X2tleV9zaXplPSV1IGV4Y2VlZHMNCj4gPiA+IHRoZSBsaW1pdCAldS5cbiIsDQo+ID4gPiA+IC0J
CQkJdmktPnJzc19rZXlfc2l6ZSwNCj4gPiA+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSk7
DQo+ID4gPiA+IC0JCQllcnIgPSAtRUlOVkFMOw0KPiA+ID4gPiAtCQkJZ290byBmcmVlOw0KPiA+
ID4gPiAtCQl9DQo+ID4gPiA+IC0NCj4gPiA+ID4gIAkJdmktPnJzc19oYXNoX3R5cGVzX3N1cHBv
cnRlZCA9DQo+ID4gPiA+ICAJCSAgICB2aXJ0aW9fY3JlYWQzMih2ZGV2LCBvZmZzZXRvZihzdHJ1
Y3QgdmlydGlvX25ldF9jb25maWcsDQo+ID4gPiBzdXBwb3J0ZWRfaGFzaF90eXBlcykpOw0KPiA+
ID4gPiAgCQl2aS0+cnNzX2hhc2hfdHlwZXNfc3VwcG9ydGVkICY9DQo+ID4gPiA+IC0tDQo+ID4g
PiA+IDIuMjUuMQ0KPiA+DQoNCg==

