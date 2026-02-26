Return-Path: <stable+bounces-219854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIniNniloGk9lQQAu9opvQ
	(envelope-from <stable+bounces-219854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:56:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED851AEC52
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28D3F3010495
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAC451069;
	Thu, 26 Feb 2026 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzKRGkER"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A69320CCC;
	Thu, 26 Feb 2026 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135723; cv=fail; b=FoiofIx6lo+w4xrt/sIhBwJEdoaldWSRrN3FyW8aE9MTs+yO877/evAYq8t7vcb1fQwxCogVbfixRiyGFI+0vBjPUuGWRwtJ/XFHddMNjGR+guSNsjmm3+Ccc62hD3Z2Wg4Al8zevNdXNaQBe6UaWXTsAwExe7kqoGgib8wwDD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135723; c=relaxed/simple;
	bh=voz3DQn40Kb8Yc/vNERuOpCEe8lnePDC61Vp5fDNgBE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=THXHhEN6cG9Nl6tJ8+LUzGNtKOzC8uA7qvcbKUHCxTo78CzLFE+ZNxIVno65sxBo5SihHKHGM7JbzWOwNLScIkw6Mvvp4fLtiKIOMmtKnhxKpmM1ZmZo/wFwlbshKjJ5jzOF8T0tg7DvQQXnXzskiLElqA9RqzREB97cTuf3nt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzKRGkER; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QD59kL2523183;
	Thu, 26 Feb 2026 19:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=voz3DQn40Kb8Yc/vNERuOpCEe8lnePDC61Vp5fDNgBE=; b=pzKRGkER
	Hwn3L7Gji2JIa/UQVIkHs3neUm5AXQzTix3mshopCy7YiZ9I6+2e2Mq8CgN3yPkL
	GZxAtnGafIhAJ3rY513W8iripXW/nGmzAUfjrMqX8GK1C39EmNrfzCX7Ul5JU+sI
	d1q+W3gLUsAX8HVoDF0ZNCosXb+4C/Bzfb9hwjoBdjRGPhZLXRL1LSkxrqUXJ9l9
	FhcLDDzFnFTOrDOWYQMha5jXCCMs2ewepK4eQORfylyeVpMVjApIBwcHL/BjKrYq
	yxDRTP394tYFaastLYaHt7HVpTcvw6LdjK8elO+sewhR/8xmt+kh8IkCkSv0wH9G
	4MD+oHE7J7M6Ww==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gr1qk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:55:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHQefIsFuQC0b7qzRxgsc2ymZomQl9l5fZNcRFQXmjLdoXm7bZm+t8XNnviEpM1AC1Gb8ybZLK6WlbznMLgmAb9a5vFgl0syVwFAresDXvvioRYlP8m9qcm+ujc8aRda9H8DyUUVkc5y2pFzOGoMEBhB8fm8jE59rl7qyPmKdODe+xSIxuUonc2kENNjMO1e0TsTOMuJ276BYv3ywUSj3eCEw8x6d5cB1xiHbz88/HMRSukEsAEDbQ2llkFvoTAN/z2Ti21Nd9LSyNY6Pz/dXrYnGmkSQo5Pimec9vfm1ZMj7ZawwLnTZoyyG8Ok9kv48eQYg4xfX7dNGv9nm+CfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voz3DQn40Kb8Yc/vNERuOpCEe8lnePDC61Vp5fDNgBE=;
 b=vSAV8oAF3wk1R4yMbr56BC6BBiODOmIyQXAtVl5AcFHpwQQ56owabXAfYdBPLfMa4lI0eA1YpU5j3QsxyU91qxe5EaDUIGfgnUc8L/TzrfyirhRhGNbpsH6QMdmc7jQ4xq9eCB7oNwAxGoGybTM2tk6kVlpgEii5rDqvLIxzWJ/Yn1cJKgCYWt+B2L7o0FcYboTuTjxAHqF1cZdQBVZ+F+maFTJyZ8u1pD1NZveKkmb4LPAYjhOuccUziNzDGXyAuidJyKpq8036oZBoj37yacvoGqOPGefgd63iAmm+AYBPFObYuBQgCrKA2is/EgV4jMFa6tn5A5cIj2Hntt3rUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPF6D7B23F3F.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 19:55:12 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:55:12 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hristo@venev.name" <hristo@venev.name>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH] ceph: Do not skip the first folio of the
 next object in writeback
Thread-Index: AQHcppgDS668W704B0iRyTKXxOujMrWT6I8AgAF3MwCAAAMxgIAAA36A
Date: Thu, 26 Feb 2026 19:55:12 +0000
Message-ID: <c1c033c44edf8d20b0a9dd8944a2f21bec942c1e.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
					 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
				 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
			 <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
		 <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
	 <b7c3c502da0d135fe1d57014f9f1074f8a2d4ceb.camel@venev.name>
In-Reply-To: <b7c3c502da0d135fe1d57014f9f1074f8a2d4ceb.camel@venev.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPF6D7B23F3F:EE_
x-ms-office365-filtering-correlation-id: 33b4d16e-3e0f-421c-ed59-08de7570f3d1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 M65Vw01sGjdd/3nFzIz1Hb680wxe0gljMZEYkAqFg8iOGkp900n1s6Usb2H7o35euUl/JnqL8z/3sNqlHpgtU58UCiRdn1bj0MhObsrhUESXDymhPaxEy7/58ehhaWyCG7L/xoNfGELXhR+dZcInbh/nf5pKfh7RvGPqY/xM3khkm0ZVdVGNgszJyAwbhTET2DQWP2KBzq9hvQ9vdZOYI7rKZu07OpVQXrDuKfNq0Fynf7CavQKo+TPMBZzSQLWTV/io3Te+N55LBB8KNGWJzTOA/jeyX1Qzp9A+Br4OOcjk2j8e5GVQ7UQZ/GzfBeR3TOVciwvOh42MsuW9f5eN9V3fLTd6k4lC9oQdNpMiaUR52/9eFdUNSlvMhd4lL/7e1R8enbOrvuvWXnZR1LEJJ87qYuYTDh+jFeR05+WLF/T+VFBu/uBF1ujx/1dvEDpjD1Kx7D0m75MEhGCt1kidfNuUpa0p/2yxfHtg+Q2iY6eC2K+z83QCP1eQOOP824R8hvt7urw4tZzZzgS+6nAN4/3JDqzlNLw6OWaVu6M3F3naozteeUVsege/wG1UiOEzYZKC9du5DHRGzGq1Clz/Zqj8+ucGhT1SMCiakyIWHlTaTvKA7HbZF4pgUQnMuswdNmfzeRTr/39ivzfPcvbPRCEAUJV4VFD7ZTjoefu3h+Y3emQEG/cELd0+gfktKO3PoRSkAG6PPDkaDBPJ3s4ind6811jyfSiiIPW/Z/NUmvI7WLVr5rQ5f/h6OcP4vLoT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a28ydUExM05FN3RWZGtkQzE5WVJzcU5CNjVSRkVYc2ptZm1rZDc5d3ZxK3Q4?=
 =?utf-8?B?Uk9kZzFURWNLM2kxbytDNXR2b05CMFEzSDN2VGZKS095TU9Zdm53dEdVeEVz?=
 =?utf-8?B?TkF0MEt5S29YQUhIUExGM0J3cE9OSTdWdGFjRzI5MnFTYjVqVEZ4SEFOVWVm?=
 =?utf-8?B?eUtrVHFBaDJFWkNqZm5ZV2g4V1R3aXZhQlNmdE9xU1E4RGFtYmErTjlZVElS?=
 =?utf-8?B?MGZHMXdkdThmc0xoWEFZYTY1QnJqN1E0RWpYajV3M3M1VlJzdlRSOWRhU1VK?=
 =?utf-8?B?aFhkTTN5U29DQnR3ZlZoR0UycU9LSnl2U1laSTh1em1vdk1QKzFmZDUzNi94?=
 =?utf-8?B?VUpoTnhRbDVmRW5Sb3dlTTB0MEhTaTNpalFQOUdmRjh4dkMxbVVqSTlLQWdF?=
 =?utf-8?B?cUxCS21OVmV0VUVOM09kSEpGU3VUMC8zRHNZQ1hPaldON0EwNU9QMkE3M01C?=
 =?utf-8?B?S01EMnNONDN5U1RnYk52M2tPV3BPMWFUL3dSQXcrUmNvZy9sVExCZjZsM1Nw?=
 =?utf-8?B?a2hFMVptMVJpRFVhSGcrWDk0VlE2czY4TmVHb1BTbUNIempFKzNBRWg5SWVY?=
 =?utf-8?B?VHd1WnJQZWVxTU9XcittRk8zNUxEL1laVjhxdXIxcmtadS8xQTkrRzl4dXg1?=
 =?utf-8?B?L0MvdkxhV0NTUlhlWjlCK3VBeFhoZ0h0eWw2RGMyTS9HWUdQb0pNQjRPaXRN?=
 =?utf-8?B?Y05KOVZCSmJhYTVUM2FEUDZwbk1DdjBWaU9aM2o4R2JNenBZVnVZSUFIUk43?=
 =?utf-8?B?RWFWZWVnMFkxSUIrbDQ0Y0QxdkptWW14ZHdxcHJvS285YmZJOGZHODV1cnUy?=
 =?utf-8?B?dmFzWTVST1Y4anJTejJOYmNldEpneVFSMUlHQ3NLRENFVEN3WjlzaWphUE5X?=
 =?utf-8?B?dFFVR0hKVFRMcnFSdms5YnQxRGY1WUNSWFNpam4vdGpWK2lJTlBPNEZNR3BG?=
 =?utf-8?B?WkNlbUdoeTNjbVdTL2xqUG1BVTN4SmQweHBGYWZxdlk5dTNBTzdKREgyL1N6?=
 =?utf-8?B?aDdJZDB4SEZ0c3pTS0Y3WUdsY0xTWXJZSnpMN2hCcTIxV0ZKaVlzcGNEcUVz?=
 =?utf-8?B?cWwwdlJuNVYydWFVU0FQY2gyOTdhWmxzVDk1ejlpSC9DdjZ4c1hrVDNEUXYv?=
 =?utf-8?B?WmJBa0t2ZkoyNmlGM3M3NURPc2JoNkxtZU1TNmxNWmVGK0xicllLb1hYek1h?=
 =?utf-8?B?S0k0RUtTcFg3dERwdkJRNzZ1Y2h5TFNvTFlUV2V1RWIwYmxuc1NkcTJGMlRm?=
 =?utf-8?B?bHRzTElnMU5iVmdmOFZOOC9WN2ZBa1E4RHFWYmxEdUZOcVVJTFMwQmNIbEVN?=
 =?utf-8?B?WGpQa0ZyU3FvSzNSTU9wR0NWYkFDRjlwVjhqSUNtcGhCQjJGVUltSWJwN3ph?=
 =?utf-8?B?V2xjbmp2WVVsR2RFL3duYnM0TlU3OTZpelhRS3NtRnNLOWowSWI4bStpVWYy?=
 =?utf-8?B?MDVZelRBV0xFNW5BajhMT0U5SGlFeDVXMnNRT0RtLzgxVVo3dENwWHlrSWJC?=
 =?utf-8?B?d0RBZ2FiTDZ6WWRCN3F5UXlJTjdJNkhCNVZQdXNzaWEvUkszQUJHQldwNVFy?=
 =?utf-8?B?QVA4Mkd2MVJTVUwrSXNVejg5dWVaR1FyTEJrR1E2d3FpZXEzWDRKVmw4NGFp?=
 =?utf-8?B?Titzb3JaK2pMeitiSTVzWWVpN24vR3dkR2g1a3l4TmtKdnNha25wKzV4Z3lU?=
 =?utf-8?B?RTE4dFVFMTVHVnRRMmpYZHUrQncxSWFmVnFFNGxISW53a3dKL2NQQnZMMVVk?=
 =?utf-8?B?ZzRxRjU2OHIyQjAydExtbCtqMWlnUmVTRjF6bzBvbEJLUDJrTGc4ck1iVnFz?=
 =?utf-8?B?ZE9JLzNvTHdFK3VxK2dXOENXNjRPSFFIMGtlYkJpcVdGYXVvckRubWlSOW1F?=
 =?utf-8?B?YmdPTjVZR0h1YVN6TDBMRjhudGZWdUx0N014VEFRcnE3VElzWmNsL01waUVW?=
 =?utf-8?B?amNKYmg1bkF4czcxbk5NUGYvRm90MjBNcExnWW9KR0UxRjZlcVRpUWE0K1pj?=
 =?utf-8?B?MWJqNGt6UjNrNlZzQ3NJYW9OQWN0R0Raa3dLR0pVWjVGd2g0U3Z5QkFHR0RZ?=
 =?utf-8?B?TnM1UEFENjNIZkFwRTBxMzYvU1lrenEvcnZvNEpIVGdBc2hXM2pibXNiKzRK?=
 =?utf-8?B?Z0VvWXNYOWdBaTNQQnZMRnBpMm9VSGpTWjNvenkwYXpudk10U1ZhY2I5MTM1?=
 =?utf-8?B?bzYvQ1JHT2FhNVVRVVhQRFNHU2Q4ejdIc2N5N0pRSTM1ZE03dHU2SEY1aXBk?=
 =?utf-8?B?Y1BKam9scDE0VkZxVG5DeTRkck1UQmNyR1Z5dkY4Ry9wSThGYU5SU1o3a2J2?=
 =?utf-8?B?a0Y4SlJxV2ZDZGZuSURnN0FuaURURGZrQ1hkRjI0dllUM08wRlFPOFJNcU44?=
 =?utf-8?Q?sBlv+SrPdD3oY9hbTt36nSHAkiKY5q24krLwP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F153A7990BCF15489BCDDB014A480E3F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b4d16e-3e0f-421c-ed59-08de7570f3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:55:12.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyU0JBMwy96oJW2KxL8l8fgLOjWcbFH43zRTeg9NHHnNxs6/tVg32FKXvRMzki+uMQeVXp4xRvSJKpWp1M06gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF6D7B23F3F
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a0a523 cx=c_pps
 a=S/uo/C2bPHUhgLefKkPNaQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=GVT9W4Wiak6UpZ1B:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=u9lmIOSemw-4eJ9u6GEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jhbPdR_baHVuGiOGKPV-UoQms6AkJ8G-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4MCBTYWx0ZWRfX5uKpjSssXTMX
 nzU1qV1ZzepFZSaSp/EQU/vJL8XZ2SIoy2bEv5Va9kxG87+3V51t/6eVx7IE8UKUoYEilpJE8Zq
 JxV18zcOZlI6kwzPbAhQX0gSDBerk3ffW/vr99ff8JC+0UHrGMDv/20pJsjoGe0IuQzEPmFXZfP
 KJJr93As/PS4FlYoSMY5UnmTzc9MMy/SUlW8yIVwEeIt6Qp+4kezhQ71QAFYfkQHOlGwg2dWTjC
 E+p0gNgvV3Tm8MHnHokzdthY30HVQm9QtJaekNz2vx/UuVK6DWvOT0eYUy0LzX2PXCYxmyQn4kB
 UCuYVEgdVPFVmL9Y50u9jd1ZTF9LJ0GV1Fsq7gak6dq4UxlJgHpsc1H0OeXPGsjs/ro9IRapQ2z
 DEnzxlI0N3GefRkREfrrkJiQw4eYC+qA8EdmrFlXLQRy/mswzOj+X0bKa/GSh5Ch1m4rhmGAQW/
 dt6K3C+c3jzr1xR3laQ==
X-Proofpoint-ORIG-GUID: xljlEfM72pEjOArBtIYmqTRYgBwkv56h
Subject: RE:  [PATCH] ceph: Do not skip the first folio of the next object in
 writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219854-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,dubeyko.com,gmail.com];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8ED851AEC52
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDIxOjQyICswMjAwLCBIcmlzdG8gVmVuZXYgd3JvdGU6DQo+
IE9uIFRodSwgMjAyNi0wMi0yNiBhdCAxOTozMSArMDAwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdy
b3RlOg0KPiA+IEZyYW5rbHkgc3BlYWtpbmcsIEkgaGF2ZSB0cm91YmxlcyB0byBhcHBseSB5b3Vy
IHBhdGNoIG9uIDYuMTkga2VybmVsDQo+ID4gdmVyc2lvbjoNCj4gPiANCj4gPiBnaXQgYW0NCj4g
PiAyMDI2MDIyNV9ocmlzdG9fY2VwaF9kb19ub3Rfc2tpcF90aGVfZmlyc3RfZm9saW9fb2ZfdGhl
X25leHRfb2JqZWN0X2kNCj4gPiBuX3dyaXRlYmFjaw0KPiA+IC5tYngNCj4gPiBBcHBseWluZzog
Y2VwaDogRG8gbm90IHNraXAgdGhlIGZpcnN0IGZvbGlvIG9mIHRoZSBuZXh0IG9iamVjdCBpbg0K
PiA+IHdyaXRlYmFjaw0KPiA+IGVycm9yOiBwYXRjaCBmYWlsZWQ6IGZzL2NlcGgvYWRkci5jOjEz
MjYNCj4gPiBlcnJvcjogZnMvY2VwaC9hZGRyLmM6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+ID4g
UGF0Y2ggZmFpbGVkIGF0IDAwMDEgY2VwaDogRG8gbm90IHNraXAgdGhlIGZpcnN0IGZvbGlvIG9m
IHRoZSBuZXh0DQo+ID4gb2JqZWN0IGluDQo+ID4gd3JpdGViYWNrDQo+ID4gaGludDogVXNlICdn
aXQgYW0gLS1zaG93LWN1cnJlbnQtcGF0Y2g9ZGlmZicgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gN
Cj4gPiBoaW50OiBXaGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSwgcnVuICJnaXQg
YW0gLS1jb250aW51ZSIuDQo+ID4gaGludDogSWYgeW91IHByZWZlciB0byBza2lwIHRoaXMgcGF0
Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIgaW5zdGVhZC4NCj4gPiBoaW50OiBUbyByZXN0b3JlIHRo
ZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0Y2hpbmcsIHJ1biAiZ2l0IGFtIC0NCj4gPiAt
YWJvcnQiLg0KPiA+IGhpbnQ6IERpc2FibGUgdGhpcyBtZXNzYWdlIHdpdGggImdpdCBjb25maWcg
c2V0IGFkdmljZS5tZXJnZUNvbmZsaWN0DQo+ID4gZmFsc2UiDQo+ID4gDQo+ID4gV2hpY2gga2Vy
bmVsIHZlcnNpb24gZG8geW91IGhhdmUgb24geW91ciBzaWRlPyBBcmUgeW91IGNhcGFibGUgdG8N
Cj4gPiBhcHBseSB5b3VyDQo+ID4gcGF0Y2ggZnJvbSB0aGUgZW1haWw/DQo+IA0KPiBUaGlzIHBh
dGNoIGlzIGJhc2VkIG9uIDdkZmY5OWIzNTQ2MCwgd2hpY2ggd2FzIG1hc3RlciBhdCB0aGUgdGlt
ZS4gRm9yDQo+IG1lIGl0IGFsc28gYXBwbGllcyBjbGVhbmx5IG9uIHY3LjAtcmMxLCBhcyB3ZWxs
IGFzIG9uIGNlcGgtZm9yLTcuMC1yYzEuDQo+IA0KPiBUaGUgcGF0Y2ggSSB1cGxvYWRlZCB0byB0
aGUgaXNzdWUgdHJhY2tlciBpcyBiYXNlZCBvbiA2LjE4LiBJdCBzaG91bGQNCj4gYWxzbyBhcHBs
eSBjbGVhbmx5IG9uIDYuMTkuIFRoZSBjb25mbGljdCBzZWVtcyB0byBiZSBjYXVzZWQgYnkgY29t
bWl0DQo+IGZhNTg5YWNhYWMwOC4NCj4gDQo+ID4gDQoNCkRvIHlvdSBtZWFuIHRoYXQgeW91IGNh
biBhcHBseSB0aGUgcGF0Y2ggYWZ0ZXIgJ2dpdCBmb3JtYXQtcGF0Y2gnIGNvbW1hbmQ/DQoNCkFy
ZSB5b3UgY2FwYWJsZSB0byBleGVjdXRlIHN1Y2Nlc3NmdWxseSB0aGlzIHNlcXVlbmNlPw0KDQpi
NCBhbQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvY2VwaC1kZXZlbC8yMDI2MDIyNTE3MDc1OC4y
MDE0MTcyLTEtaHJpc3RvQHZlbmV2Lm5hbWUvVC8jdQ0KZ2l0IGFtDQoyMDI2MDIyNV9ocmlzdG9f
Y2VwaF9kb19ub3Rfc2tpcF90aGVfZmlyc3RfZm9saW9fb2ZfdGhlX25leHRfb2JqZWN0X2luX3dy
aXRlYmFjaw0KLm1ieA0KDQpQb3RlbnRpYWxseSwgSSBjb3VsZCBoYXZlIHNvbWUgaXNzdWUgb24g
bXkgc2lkZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

