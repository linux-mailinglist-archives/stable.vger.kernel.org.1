Return-Path: <stable+bounces-118412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030FA3D68A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9AC7AB72C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC41F151C;
	Thu, 20 Feb 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="p2i0geLE"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870031F12FC
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047172; cv=fail; b=HOhKG8IimVvrCRAWh+HczjZbEmz3j+f6lesNEmR9WOB/wWkQNsEqi69VIBLTc1TkS6DFpJnMNmDagimojopPOpGYg+lF/+coodErskNMiHzAzzN9lk4OPUcK7A9sGs7E4ObrgubXqjd8s2+sA5hlIOq7sbuEQsXz5Uo9au0OV3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047172; c=relaxed/simple;
	bh=S8ByUdZ4j8i9G6bSz6xBycl0kLMUnwtqQMQIlSFI8nI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DeDTSqgD1t0hSWvScQ4tCDVYyfE6Dy0rrYrOl0Ly6fgbWxQ77x4ggVDYcLDtf4+qWo7QMngAxaWVdh9N71B6GrKT/rZ/gRZb7VrFt2ReXPOU/9iAXPbWK//3JVswIXkvK8xT5uoCgdjAFwvSzHv47MqIH4ishxgHrYkJEwGv8W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=p2i0geLE; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwYfdyk0Ible/hrj+d5VRN/Ghf2BHQTn3zKw9kcwW0BAvDzfSgtG1vn3WZj98h9hx9eol+ynCfI8W4nH+rLi9TYAzKjh3ZshvTMZCxb7boTh75TlIUH9ai15ZvRljw/KYLpHqEVQZ+Z6gatXWAi/EJmklJEwKM1Aoqbo4b3bpokIEeOnJqq1mhwHlSE/0zHRgjrGUHC36ueU+vKpmhkBB50QZTQkhV+7k/TkKiJhSYihMhvIHCHGrvVpuPMHQKCR1cvhWrAhf5uhzw5ONqNbwYMdBOY/t89SgCJxrKcYoImAJ4UgKtOacHN8hfAaO/OymHJZf/MX5Ao+hqBk9DXJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8ByUdZ4j8i9G6bSz6xBycl0kLMUnwtqQMQIlSFI8nI=;
 b=Wh9tpG0nIzvcCYl2Nu3V3bP7I6r6J0AxonfRY9gv6/HzG7TGi1MV+/+J4hhaixgoajgKyqeMrHx5a5LjNJanvGwP2bd1ExJyRGDB6pIBekEcfUFnVoxIC+Y0Y+72pNAgQBUZEuYpT+mpkdtvCG+D/1Qvr4FYNwki3pDqc36jmxz25Sl6T6zIfUICWcZkEMMoXZfnhnG71VYmEREphHXitwjXDfNNPtdT8JkYP1XH98LdXbljb9nH+hULREgxW93coSoOR8t279ruFpba+YPf/23O11FHUx1a3E98mpvdNjV0ph83LrvLE/9ACwoQgUj6sDJqq8Rd7k7Jy0+QnjjKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8ByUdZ4j8i9G6bSz6xBycl0kLMUnwtqQMQIlSFI8nI=;
 b=p2i0geLEghpOVD95t0fij+Qm/g2tH616IeCMo1W1XvzYfUIVaMD/HUJJPX/iyVIYYuA7yTdXRfxiYsUp2QU+1Hxo2EJ8b+8YglSRBcY8nNoY/mwaiTgM+6IEkt/JZPjV8fIGxRy34JFGgtFAtZgzV0mEwqk8rDjls/zKCUvk0KRFnflWOmWPHYTAF2nfZLFxfWKsjQR6bRFU2PKPQ3VdqGkW2kGmXt0lcIzoORmgg53m9Z+yT0kUZrcTH3gdTHwPIOMZKHfHFsIYsljxf3Fywq/LEs2/cN4cxrpiFAOoAFSbiqvt1ZEnR/o5lkMB5seiiLrYGWo379QlzESch614cw==
Received: from PH0PR03MB7039.namprd03.prod.outlook.com (2603:10b6:510:292::11)
 by DM4PR03MB6189.namprd03.prod.outlook.com (2603:10b6:5:398::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 10:26:06 +0000
Received: from PH0PR03MB7039.namprd03.prod.outlook.com
 ([fe80::b6a8:6482:2dfd:4b55]) by PH0PR03MB7039.namprd03.prod.outlook.com
 ([fe80::b6a8:6482:2dfd:4b55%3]) with mapi id 15.20.8445.015; Thu, 20 Feb 2025
 10:26:06 +0000
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
To: linux-drivers-review <linux-drivers-review@altera.com>
CC: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Chiau Ee Chew
	<chiau.ee.chew@intel.com>
Subject: Recall: [PATCH] fpga: bridge: incorrect set to clear
 freeze_illegal_request register
Thread-Topic: [PATCH] fpga: bridge: incorrect set to clear
 freeze_illegal_request register
Thread-Index: AQHbg4HZrSeAqntaAECYF3WbJ5yICA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 20 Feb 2025 10:26:06 +0000
Message-ID:
 <PH0PR03MB703924674670D3EADB983612F9C42@PH0PR03MB7039.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-traffictypediagnostic:
 PH0PR03MB7039:EE_|DM4PR03MB6189:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17496afe-40e1-411f-b469-08dd5198fbfc
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MHO7+SAdGFlaq+cB9FPYvRUxUzVNeoV+F/ETrja4wbsfGZZFF/1Uxah1mhRi?=
 =?us-ascii?Q?3F1INdQXTWnIOz84L9t46k4AwEiYd7aDbbhoFdTeGoEmWZsFTsaaBwWaxUOk?=
 =?us-ascii?Q?EfxXYT8AP+PrdUdKQF6qd+R308R4frKdfgNpFhAYGCVyDP6QZMleWWXqUXRU?=
 =?us-ascii?Q?xtPF2uXgZHv8Zk+4VjuB2LrKIfWd9rTlbRu3rpuVoP9QjX50BLRJmxHz3ybp?=
 =?us-ascii?Q?bSiLzt59aHMOPitocEL4HWKyrkgBPV1k68IuoLKbwRB+BJc7YBCNkMzfkF6w?=
 =?us-ascii?Q?MIC5EE4FSDAGE07D31//AWJW+qLIfo+LaMMeD+GAA1mFW9Hozs3xFFqT+v8C?=
 =?us-ascii?Q?dXAR3w4T1uYUC7PRSHOFVk5j/wVOxUzcoG8RT2eDqWrvabAcvlTjCUPu3aNi?=
 =?us-ascii?Q?oDPeDn72ig5QouzxoMBgJ2QmAReIYrtlkXvDn2QyjiFF17pgLmxIbPQ8Nu7q?=
 =?us-ascii?Q?BfeYB6BdMq0FeRzo7HCYLeJIm5tEschPCmnkAt3wMHzMz/yN1ItDjauLUY8U?=
 =?us-ascii?Q?lEh/tX7zUpAZQbH5ULDjkfpnUoJIeYpeUlJwNsFzKhDvfFj84WGd6GVw9t5m?=
 =?us-ascii?Q?zN65SVJO8y2A8S6fmir7KDhKcgpv5MlPHVNT9RkiZPC+AYTKTZvfXw2RxyUy?=
 =?us-ascii?Q?0QVqa/jfUIi5T+ZOltgt+4RaDNp4ifMW9kzy5Pha6JWTy/eZ9g6/M90Jfej4?=
 =?us-ascii?Q?O69duZEJK3ES6v07S3oXYXNxqM7uPA/R4bgSrEfnsnIvGVhp9jqobgolgL5M?=
 =?us-ascii?Q?idpriuY4dJCtK8/x/M7lOD8UCV5m+qMv1W5yUGVoZJs5aaG5nmDRI/OyuL2P?=
 =?us-ascii?Q?kED4LzxBru2XUpG7Fp+Q4vdF3/vwWueXalbmJUVNurVrHAVDZVEQ2GzjV84B?=
 =?us-ascii?Q?2ivzxYkH8S96ntejMTW05z83Z8lGJThqT/qkg1B7ABXHNPDIJtCTceg62KXg?=
 =?us-ascii?Q?15y2Tnjxj4hHsJgaxbDVGjlsFsjeRn3u6hwznde8NRQMjMEGxQZNlU4CUyUS?=
 =?us-ascii?Q?px9yQ+o2h8TY2uvgKSX5uhgRfnO5JvpGYnPlDmfT0EYcWBGjFDrVODrnIifF?=
 =?us-ascii?Q?gL2ElkhRgEbAqSuTziDs7QlFdd/i577gTGibi1kJ3Te7FKl58AxexZ14wsbz?=
 =?us-ascii?Q?5xOM7FIKZpgm16CIxAiqHfeaSm8vEeBBMkWMECvCdpBWR6AnMuoXOLwvtmxx?=
 =?us-ascii?Q?WUf3YcJ0uw7rxkEisLjdZ9b6e5Qpr8d1Ucp7rMSoGd+QJKMb0TkLxWyb6PuJ?=
 =?us-ascii?Q?eS6D+xFiRHuB7C1BbxiKTzN7KfJkY4fMpil0Tg70jAAcThuSfjNoJmorErhY?=
 =?us-ascii?Q?xgMP5HC0TW9bUZ2tYqQCXtBTkUf8zmYLqAhzN3HO0ujgP47e6zzTYmL+a9hF?=
 =?us-ascii?Q?wDkiOUmSobCWGKXbShTQToxBPcZMwUXixUOJ5qkDxfne4rtU/4i7yc55W+Fn?=
 =?us-ascii?Q?iJNZsZjwfVU79TJO0bMIsaAPMa4AnmTj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7039.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7r7BBnTVKOmAwa4VHn5VH7fRsJ3exiWSJQHB4sJY6mE45AYcOZG/ONTn+UgV?=
 =?us-ascii?Q?YDTW7UyR0P0RLx+a3tif0f9H5ZajQBWCFMl0S+bkLuRONuM52zULRtFnm1+q?=
 =?us-ascii?Q?w09smXgz+7zoqtR8ef7yI3ia81xSXtriZIZbwH2J93RmgYxfRO+gJM4Mgt7c?=
 =?us-ascii?Q?BVcZxMhKr9kJxRd/qtc4QJObNluT0BjlXvyJ4j2VHb7G8Suq/shz4xDw/KxI?=
 =?us-ascii?Q?l32ex6ejRLndQZ/+v8PZY1Pal/KzFHLw+OsP22M/VJfbg6beH+P5KkdAJ9Nk?=
 =?us-ascii?Q?UnkmCAEKnFdLmh+0lwZLuCIxnDlG1Ymm7fsHgnChbBl4P7zy/BHu5m7gtCFh?=
 =?us-ascii?Q?TOR73+AHMgJy4L89okWEM6mKsackFWQ6ebTbeH7hyny7n6UuR3sA43TInCvQ?=
 =?us-ascii?Q?bem7QA8/rbTYuEKRRFZo/MAiSv4rWlKgmGOi+mBBqVuKbQFUu74D4AAFEdVW?=
 =?us-ascii?Q?+8E+zjtvVA+TRzRaKby4RZ1bsNLNRfVNDeV4JLN3cxmctHVWD5gXdKKsI2Jf?=
 =?us-ascii?Q?VlAm+hswDYSoYldoSfiPc0TiFHV50mLzYNuOYrsyrMcauOx14J038LzlANxr?=
 =?us-ascii?Q?l2wl/jXHVwWCtStSLaT2ziv4KV4h8hFIyXTTe10JFQx9oDYOBn42vGE15YM8?=
 =?us-ascii?Q?YoCgjWn5H16myVtJuCu1X86LabeJiVH/a9fPFaSiGZb1JAeGCXcCuwUJqQdt?=
 =?us-ascii?Q?mZqKPBqSmPle2jZF+FnAF5gqUlnOM8DWd2YYJHMnGah4uerjvotMzq3qxUyD?=
 =?us-ascii?Q?BDix24+wQFqMIf9nxxAXh+CeoB6pEHszDN+ZF5Zf7Kb7o6LypvpsgCLLHRF9?=
 =?us-ascii?Q?ZiyJqPOARMTHY+g7JVxc/ylq4kHoYYr7EtgSFj/jcVsKH9tkTQeVIQCfou+5?=
 =?us-ascii?Q?MWeN65AF5tJhnGYy9oMuep7BBydnWSwnzGyHhOdqlFBqJf7rRGkysyZRBxnT?=
 =?us-ascii?Q?aeXhIVaJzxkVsZtH530jBPOOA0AmrB9TGtnf7spOGw2TLyUFnYK6wy0zb2Iu?=
 =?us-ascii?Q?sXTqpk+5ohG0L4OWSQ1pq6DD/Jm2poi5SqGtygIh1jxjflQofxID4qGQthYL?=
 =?us-ascii?Q?WEEqCnvkjfvzUKf5FtEciy2ATbqTpiNEF3DrJE5PL3emxYGX1/WM80GwZjoJ?=
 =?us-ascii?Q?xTy19VwmhO2xFkfyc2/NZwL8s4BpzU9oNQjvZS806RRIx1Fph1ihK3IjZ+Sj?=
 =?us-ascii?Q?9NI/9QLyG8ejvGRVFPkgAtUGE51T5oL0Rgpo0eFHlG34D5aJ4cSSf2LGgTVY?=
 =?us-ascii?Q?v6VH1WAJdT2FTXXiELpVDqKn2iJWScu8FHSFR7VnTaV1H6+fe50Zn9PfQ/5x?=
 =?us-ascii?Q?YNRqGAdvl5rXNpGm6gNQ1FljCP9QJfWdmlFko0lJL4rZtGa1NvgEikwwcHR0?=
 =?us-ascii?Q?Edkc3O1w2BXT4bBo/TP52iZ4xnzr7ARI0PQbX2AQnw9zF3inGg+dcacj5sfR?=
 =?us-ascii?Q?CxavI8EqqVjcp+hrwySKw5ZEv8sxEh1LtTT5h4lJgcSHoKgksZRifYYB/Xx4?=
 =?us-ascii?Q?75uzXSp6sdRXDSkUnjjLv3+h+F2YWdU1vfNiLwJ/zl3xzUt1UC2mSBup02jd?=
 =?us-ascii?Q?w99lbrjXlhTgE9c3GewjesMKkHSYawUXhMlubQ92MWfyeshnK5T9NxiJJdT4?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7039.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17496afe-40e1-411f-b469-08dd5198fbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 10:26:06.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgTXukiQRoDCWNNdiKgW9Avh42cRJNI14OujmO9vZfg8yTQTScY9xBH6iTThbaLGxnO88sJXHT1wBhvI4ubOi+VhW7bbs7xe/DmzESfrFUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6189

Kathpalia, Tanmay would like to recall the message, "[PATCH] fpga: bridge: =
incorrect set to clear freeze_illegal_request register".=

