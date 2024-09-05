Return-Path: <stable+bounces-73138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3596D068
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE11C20315
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13221193411;
	Thu,  5 Sep 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PKqwZ4ag";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="5gL0vC4R"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8011925A5;
	Thu,  5 Sep 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521478; cv=fail; b=kUJyCnlYlcn9P6N1TqB4e+nIRphi1A02M9/H2pUjWQa5v4h8P8/KPGIKjyNz8pbidMCCjdJKapSLqag7HeRfjkIjgJ0AnAv38TIAAQweN3N/mppvYazot/zXDU41LmVFD64sgJArNNnmNiPfxg71u39X3zLal0vSnNQ5DfeB+hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521478; c=relaxed/simple;
	bh=KGxYw1/4Kj8BQzb+3HTCwwB4vHppMyrex+rDwGB8At4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCIaeFIn8vxoS4ljl6tE9xjmtgX1QL2ougBe2UB4U+1bx7L4hy9CWbJUOaHYa3WcaqnuipG5Oga7CmgkZMyA+VIV7JYIcMmu3Azyma6xxiIs9LiSqr+ykdNCgZqNMXeEx5USJKVqY1A7M5VOavjkBrZe+FJQy3sG9Aps3lgwbpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=PKqwZ4ag; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=5gL0vC4R; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484MDSn5005326;
	Thu, 5 Sep 2024 00:31:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=19olQak3XeQKFqRkYX4l3gC+SdJIiZSCyieT+5QO8GQ=; b=PKqwZ4agqHGk
	ZN4IQKkXH1BsmLRlQsv+ATswQ8KDenxmcWOa0H6zj/L4AxF6H8GbrNyxI2auiQoQ
	OOWC2DLrw0e7QV2zKVBjxechWh518cqauj7XpDqlPsdWI3EnfRpO6LxpQXQoi2wp
	7qAgFVrOLunvbPQZtTyKyjsqwR/jXyfUEVgDN9/J8yB7Gvl3BI0sFalpGxzx8EKT
	NmBQ1A6FXrRdUYNyZVMTYVnbTEG9txnE1fZwPS2TFB00ctIzR4b7e+x+CMtHapTz
	6tZCBMBSx4NUqmupSnG8HzFN4CElACR4FG6en/bpQ9BLPLMfm09MxYNM0N+tvWXj
	NIZGYXssFw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 41byqtgxm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 00:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCyJPKVIrf/iGIDGqz86/3pp2M1kGWa9d/BoYYKkZCt50tXS/lzXju9MtE8VaOsBPdnxTsht1GYkjqDiUD0e7P8P+nFzTIvBdyQ+nqAHeURwRz3TJx4600mSZ4Vm7GpALploDU/xCwH1GRRdSxSAAF/i3ydWV86vrgb46xK2dtI973VjTj2R75H+tPGgznqnqcen3LXom3lzd/OdKGXmIdrsTfN9noEmDnb0sYkBUOVu46x6EncPTONWiJ/hMuVANIUMGo9M9SOVrWWIVSuiHbRP70cGczuv4vnmTf9owiK1Yr69w30O8n8K0/djG/VDlGGPxY2JJUpoY7abtcNC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19olQak3XeQKFqRkYX4l3gC+SdJIiZSCyieT+5QO8GQ=;
 b=n8CE9uwTH0Mm1MoZdLW+ePZIQXTQVp/LrtPuDk7Jn/gnzQi5D346cCgAqWchznoYdI2PWNkCJssoholPSU2DR/Inz0iiDB3pzip+0wWP6bTJ/neCtEYTNj/GqZZngC7BXWTuwjTqyXJ1v7X9tVdQdGssTB/mO4J2aJZh5arAW/Bnp7Cj0FFKnVJgT7wexhNJxqLUMNZf2XwKbe84c8tOAhIfwucOZVV6HgU2nrLF+nMaHHpcUkTB7XKrO4k28PKVfRDFoHFI2+XXEJ0mzAZIt+I1HXPFAd2w44TaHCZy2zVRZsBiNxNfreB8GpdVGCjM9goFlpAQuTUHItoAUwyEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19olQak3XeQKFqRkYX4l3gC+SdJIiZSCyieT+5QO8GQ=;
 b=5gL0vC4R+Afi4cLv5CKy6IuY9XHxgptFhJ8hsm+g+9VRub0CMO3jBavP3A4MlXSMDhhSs0N2gJQPDugwmfe/wD86e8J/+yAO+W9djnTGbAnBXqmuHa/om0KDCkdrH+1eztKGW+RMwhBGt+2JvB5va+TY1QVYwpYmfS6yRJbPCcw=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by PH0PR07MB9175.namprd07.prod.outlook.com (2603:10b6:510:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:31:11 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:31:10 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: Fix incorrect usb_request status
Thread-Topic: [PATCH] usb: cdnsp: Fix incorrect usb_request status
Thread-Index: AQHa/2Tn03ME/LN6AkWudh1fxcnHPLJIy8/A
Date: Thu, 5 Sep 2024 07:31:10 +0000
Message-ID:
 <PH7PR07MB95382F640BC61712E986895BDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240905072541.332095-1-pawell@cadence.com>
In-Reply-To: <20240905072541.332095-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWQxNDE4MDE4LTZiNTgtMTFlZi1hOGI1LTYwYTVlMjViOTZhM1xhbWUtdGVzdFxkMTQxODAxYS02YjU4LTExZWYtYThiNS02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjMzMTAiIHQ9IjEzMzY5OTk1MDY5NDAxNjEwOSIgaD0iQU5uYkphQW4ydHVFVzJIaWd2SmxIdjFyTDYwPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|PH0PR07MB9175:EE_
x-ms-office365-filtering-correlation-id: f9b530f1-3ff3-46b8-2455-08dccd7cb6e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QUvXdnrwqrLHR28Y7vyTX94NQ0liTai1Bhiy/JmQXoZb3mOIG1h/1J1ncX9u?=
 =?us-ascii?Q?M4m6KU7Mn56pS7GYzgJn0oozSCkpbh8oECVN/U9Z33RshOEbZ5cFuSDx9ck+?=
 =?us-ascii?Q?IXigWANV3FZvau81wFsBP2Sdr0cWwio6f4Ln8JndpCHlVlE0l1hf9Xyq18xH?=
 =?us-ascii?Q?gQGDnxXo2oBxSCYlIZBlYAG8bSESsADMiazzcRqbk0KgEn4wt1uMGr6ukw2E?=
 =?us-ascii?Q?NRGlVHwF5iQqeGYCfCz2pCg2YxpRfbCV61HAVFe2cBJDfwYro5X943o0+8EZ?=
 =?us-ascii?Q?VDSx7EP+YDrcEQsnQp7vQgumnPRI65b9tGof5oZAuh01FoDgcNj8JXBGALIv?=
 =?us-ascii?Q?r08ddwAYFsTsxApfyCSiMCvP/vY5+HSWUExuAWuoyrh/PPVDxGjd88oHyL15?=
 =?us-ascii?Q?hW6dyXhQ+Kbd2jUVnn16ZCAzJbZSUuq1rQqz6YgJyyuihJYrABTSmpoeljcr?=
 =?us-ascii?Q?f8DmXiII8TZeNDEyB30aynE8XnYGebOSKMarTZZCX8/5r6DjsDfYxObsTfWI?=
 =?us-ascii?Q?ujf82M+whv6URy2ynztemw2uDAIAfJvH6JOaLii+MXQYiYXnlzsiVvQUutfK?=
 =?us-ascii?Q?eJJePxA9i0pZgDV3hnDPU3uqHvdsFFPcbxTg4dXbaiHTy2mAoxZcKOSnyvQr?=
 =?us-ascii?Q?qxfh4k80lYLFtOauwIKS0wdMdM/DNdT9CgC18DVcbCdHo7ZboOSZG5B3Rzln?=
 =?us-ascii?Q?5HrjLlaGhChpEDk0STrSY8Y5qHnapT4C9sGfV5YH0bHKgWTqKHQu/ACInoHs?=
 =?us-ascii?Q?FJLdQd+o8dJssu1hjq7pS5ZJMi2f/N8NwJ0HWGgVlNyjVHSwfVdzANpWaYb1?=
 =?us-ascii?Q?Wbscm3TFeWNvrkovTl6M+JBy86eWKIe8k3JWVZd9rsuwSo8TVFySGG/IhDuU?=
 =?us-ascii?Q?Dn0SP1b/lsLMDn7ReavdbyqN8Vm1acC1JyAuu0VZTPpDg3MtcDTu3Xx1Cupd?=
 =?us-ascii?Q?PQinEoYjy5alQlDVQQzW53e9SxWkvdS2jpGQaEvUZzV9oPsVUnTipLI/9+V8?=
 =?us-ascii?Q?2jJPC7tvhdkWqpYfaTbMVDvH3E2rko3qjRZvdp2JMCKHV9BceEvjbEAfDsf6?=
 =?us-ascii?Q?/38QU2sZh9sYOSG1TjFptUZK8HhBOyBqrFyrVjZ9GlyeIL99tIJYeLWhXx4B?=
 =?us-ascii?Q?r959dLvqQ0JNVQlGj+5vY6OowHO5/0hP+lfz4rSWo0fgK4fkKVcT71bD5xjk?=
 =?us-ascii?Q?wqbAS6OZw27J1rGaf8b6gdUA75OSmuxqg+OaWuQX/mHd6Z/iLsbyoqSnyjsh?=
 =?us-ascii?Q?cRlnh3VU4vnvsrz9Wut3l6R4jxsKwfeeXxuYVWu1yCouuhvYCYx4mMrtatUM?=
 =?us-ascii?Q?a0uY2B0HpR87PciC+x2jHkWP+XAdSR9hKZQN4LCfD8/xfKmrGOwiAylvYcO0?=
 =?us-ascii?Q?+1Ik6YODvh5UF2drwApqS5vgFU31PdzR2sXahUyPjNkbBaRGrw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ToKTWdnozN6HWUC1XvfSYoxssoj2UPvaoFVY4rTeZOyzsLN8yW81uaZmDQi2?=
 =?us-ascii?Q?/CUOXgkhBbeLzG4eLuqiyg6yEexO4WgSxoIL3PH80XT5sUvP57SOyRPq2uHp?=
 =?us-ascii?Q?Yz00rPYmNfSh3a0XfKbJG+FVjTiY4Bz/h0w/v+TyWNeABry91ma3DIO9f1SL?=
 =?us-ascii?Q?9d1kryPQDafJPvvOcVXtfqaZQlLJ4jYfpbzOM0QFSyC/Xmndaaj+b3c7rF51?=
 =?us-ascii?Q?K727mpPF8c5qpio9T9IYlRL2AgCrFcPl5qFG3s/Tsvk1Mv/8rMv4KGuXzvW8?=
 =?us-ascii?Q?xDI024hYYGmFwXB6u2p+LXFBbf6646gDliOu0zImz2X3K4SM4DhzJnJMLA/U?=
 =?us-ascii?Q?1KD11H9Upr8+PTzYRmIkGPt+svylDVkMtlX+ed4kYWOtkKgeWd+qL49NszxL?=
 =?us-ascii?Q?I8lezW1Yd5zO4XzweHbsecZ7USksvwHrBR5tU2iYn5ozI6wPXqc5E9HwEgmj?=
 =?us-ascii?Q?NlQlUbnrUgtv/bJfBzuJfqCivPX8no6AGOqjMEYUdu7MbfcBVHvSzttV4AeQ?=
 =?us-ascii?Q?vBihvB7gWp8QwdrUC7EcvYSy+O/d/vbtahZ/M0nt17oOv8YspOfAEbv3+gmJ?=
 =?us-ascii?Q?fVrwGL09dQTFChJ7sAHWTjyBct7THuwy0FNpDQynpb9lfhcvnrqh+6RVQkzq?=
 =?us-ascii?Q?FSkY9cWKTPxJN94YiDKbNGqbO3LMq3tJulFVpGSkKZsbNDw4VbA5tSTCSzbM?=
 =?us-ascii?Q?2ljUE4E0CJYHgpd9cEHhyOmb78Sm590D9Rk2R8Dtk4autO5jaFVeVZuN/24Y?=
 =?us-ascii?Q?1fSFE7HWW3Q9zLUlwDeR7m3urSwTZ0te9ZjB1HiCxfq/WgJ3IhfIuBjLhsZF?=
 =?us-ascii?Q?Z1QjkPIUwJRz8ikewdsVAN5/QSBYQrRkOtd6hhar+6J0FlP+KduPlq7UJhcP?=
 =?us-ascii?Q?mEllLQArStBNiPvxTuI9BSIBId1ExP4G8HkKjwqxRl7TWeAFP3H9aFCKDLkb?=
 =?us-ascii?Q?xNjFAKWl1Qv+LHROPQQYRKm0W/kGiNMFSuwb0W4Kxo+WEAkvnShA7sm3n8Dm?=
 =?us-ascii?Q?/54+IS+JeMMmn7AsXyqN13bzH82as3r9axjN6/BqMKPFNQMv2Z97IIYCiCVx?=
 =?us-ascii?Q?CkSNsXtFFlb9Di1O2Fc5RKiu7eEYfRU42f68bl/zWD/D/XW6DD7nqlqGCP/j?=
 =?us-ascii?Q?nVcDp6ojSyc8gfZRv/IX+x9D2TEq3MrHMNxe+Y0IcBUQaH0FKN/5dfChpUUb?=
 =?us-ascii?Q?Ykv71HD8x3eer7YSHBp80XqL6ob9AVZyXlEAqk0D/Fqg68gXm2YBcrANesT3?=
 =?us-ascii?Q?LWzlH1VxIQT0fIOlu8FSOAd/0H27PUpEWbxJS4NtBft9Lk1/8xqffMzrRG/5?=
 =?us-ascii?Q?uF1HvNT70iZi1i+nil+6gCN08MnrJy3a1NO1IToZF1PFYelrKuzZcCotxkfd?=
 =?us-ascii?Q?/c2rCKb1AGXLBipR/KkpUR18mzHftltJ1pPnp+0NqiXbS6iivtq7oGL8ORVt?=
 =?us-ascii?Q?gT6Djibz8+3OdcxngewJIsmVEbfq4wzUtz/eS1gh37AGaKiHBOR9IxCkVY2p?=
 =?us-ascii?Q?45XpT1AGx5ju6dwEK+HaMTUyraOV1HuAFh6a1EU0Aw2/gnZ3eWpI84MNF0Qb?=
 =?us-ascii?Q?3eodH4zwqiolFTuaErOUc8OHov+ms1Ffy9Ki1vZF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b530f1-3ff3-46b8-2455-08dccd7cb6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 07:31:10.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWV4jYbjXe1bw3uSbqE/a9WGE2aqa6otlblol/BrOqMgQoTlEKwBVcw67zD/wzTLR6Z3CJgQO/SVQ3PBl2dcuN/obNlJCTXBNBBIjM1bqeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB9175
X-Proofpoint-GUID: Kl9ILiZPNHHBZwZPuU2xkPVLmqSU1sZ9
X-Proofpoint-ORIG-GUID: Kl9ILiZPNHHBZwZPuU2xkPVLmqSU1sZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=696
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050054

Fix changes incorrect usb_request->status returned during disabling
endpoints. Before fix the status returned during dequeuing requests
while disabling endpoint was ECONNRESET.
Patch changes it to ESHUTDOWN.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index 1e011560e3ae..bccc8fc143d0 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -718,7 +718,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 	seg =3D cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
 			      cur_td->last_trb, hw_deq);
=20
-	if (seg && (pep->ep_state & EP_ENABLED))
+	if (seg && (pep->ep_state & EP_ENABLED) &&
+	    !(pep->ep_state & EP_DIS_IN_RROGRESS))
 		cdnsp_find_new_dequeue_state(pdev, pep, preq->request.stream_id,
 					     cur_td, &deq_state);
 	else
@@ -736,7 +737,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
 	 * During disconnecting all endpoint will be disabled so we don't
 	 * have to worry about updating dequeue pointer.
 	 */
-	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
+	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING ||
+	    pep->ep_state & EP_DIS_IN_RROGRESS) {
 		status =3D -ESHUTDOWN;
 		ret =3D cdnsp_cmd_set_deq(pdev, pep, &deq_state);
 	}
--=20
2.43.0


