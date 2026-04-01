Return-Path: <stable+bounces-232750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK9bInzyzGknYAYAu9opvQ
	(envelope-from <stable+bounces-232750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A53786F0
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8104E3042D32
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A13E928B;
	Wed,  1 Apr 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="W3jC4i8w"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021108.outbound.protection.outlook.com [52.101.65.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7A3C5DC9;
	Wed,  1 Apr 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039089; cv=fail; b=HZgZ6DQv7l5CjQoTFvovAtiZawg5y263SeoBI+89Xrkt7rLfnrCUOyrI1gTvpf4L31rQSChVnNWEcu85M32d2R4GuAU52IOBlEiywhy80PuAvWoMml/kX5M7vH+nVjp+KcBvZSX6boOBxfFdYlZlcmu1bM1ON8UpRXwzyFAuLYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039089; c=relaxed/simple;
	bh=Uqmqer3e5sCD41H2KmkElaMn7BPnp5ntj/XxI9+YB/M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MhAj8FPfT34W+E+HUXZ4FEAYgb6QhwGNcIHWqd7P3fac0nyEbkrvXvGiorV4oKaPJnjv3mvTNaX/tJBke6PwNYJc3i3m0a9E5QJB7SbIjx9B3SdeWmfUNehsFgjWhrLVDj2GIzYemD7A8EPVTYHxBCsP2mtzA2x1nd7CD/gA20c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=W3jC4i8w; arc=fail smtp.client-ip=52.101.65.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHq45YHW5lAUMYSzclhYSbIHNd99fRkUqtrCciN+eHcWDz1dyoP1d7LnyeONW3sTi7IzOP6CjrRJAD93fuDH4fdhaPDBNJfVqoxvJZ8jhoXBeI8xFlCm3DJ9iqMV+sqzIhawt/5c0o1s+sUZNr88Bzf8DtTQFWUZCuigXo31aswNQbYlhLWHGnjKNAmlCpIDMt7GTTTmoMSMj92XpGmtJvVvLuOtDbURerkOFjU4/KuZB4GTtViM/iVK7QLJNHVTbSyLafwa4S0uBx1smJzVxcF05cAAgBxfo7s0mdyTaLULmSbXyARfcEf0RsCbBRkjL4dGI5ko86VRxEGlMOO7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqmqer3e5sCD41H2KmkElaMn7BPnp5ntj/XxI9+YB/M=;
 b=YGR7jUfFLvhbTSbJC9tYogn2TM+rY1SFRpdlvUYABmZ+ZaEZKhlvBnpVLTk54fnK4G7/oVdQnrLjjG1DYSzjgnLWoUOuY4622egdboiSx7LjrBeQ6mDzbAB28nlTF+Fs5J/9uA+GNGD9UVZgl62XflorsoQnCmnP98rH6riLexYrAHS+DeVYI5d4UXt6rVl207I3YFqn9qsIBY4aKGjBnyhikucDEEQLAwSNsijaBeD/j3bC57YNQOmsw7syPUdWmYqMKrsyYWG5zO7nhJe4ksCETc197nSDeg1/ZOIlpOKYdT0AKRfc4t07H8GtCaUyiu1vn6Z8M/nuoc9T9Cj6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqmqer3e5sCD41H2KmkElaMn7BPnp5ntj/XxI9+YB/M=;
 b=W3jC4i8w30jEHhACQOGpsWmfmgI908W2d0lHaSm2OQew3WoQFEufr/eKyss+zw9SqgfCo5s9172yptzQJoIV6uMNyMlrtvGqzkfP+r697PXCTjA1LX6e6c1kSaMsEWN2hUBeLAAd4TttRTGiS3z+imqzyzo8u/gCi/LsnxB3MByK6RQJs+G647J7HiRcGe0oQyPlT4Mq5QWMRjzJH4CGaeKCYaHDEvbxng1b7R059tnB+q962RIXLFsMWVGusBbw4Qmd+XpUHGZne9H+OhUajophe4GdyEmJmmNm42PD5Ph5RggLSrGM8TgzaCVwZYbeZ9C8sIoIq4PBIgyXyQ3xqA==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by GV2PR04MB11884.eurprd04.prod.outlook.com (2603:10a6:150:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 10:24:45 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 10:24:45 +0000
From: Oleh Konko <security@1seal.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net v2] tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
Thread-Topic: [PATCH net v2] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Index: AQHcwcHCiiIqwNnoGkeCzkPBRQ3jNg==
Date: Wed, 1 Apr 2026 10:24:45 +0000
Message-ID: <d72c0ff783db4c78ad862e6e27f3a807.security@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|GV2PR04MB11884:EE_
x-ms-office365-filtering-correlation-id: 1f14239e-ee6a-4f53-ae6f-08de8fd8e51d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|56012099003|7055299006;
x-microsoft-antispam-message-info:
 PZ3RQmvdrNADwRl6wwkb5dIvghf9GFMP/cbFPXGzvPeS3Ht0zFxhBHWE7UT6tGDKt9hZ9La7s/HVnjOk1F9AxrDFKKbAiKuApuJ5iAx8hANlMjZ3Tx2e4Xf1gFE6Y8IJm2dzz1y5ZJdJn3PMtAtHYWeljppx6qSNV6qi5zFBUg/U6VyuujRTxA2ZVsbxCstHG7N9MjSJv4dWCL4lPD4gwVuR6u9URABKmBSK57MFcjSsMmvyCQ6CNpmvTPx0whPH3UHz2yq2+GonZ7LIMMm8DJdBEqqR9sCX/xnSR24lZJnZJgld9TVuyVs0QEnFXK+YbyF3nRLyBZ2MGVQp/TET3JZZd0m/wTUUj9vQAPXs7WmvPtA1zei2z8Ty1EJb1/a864TAM/JNgyWkcqYPD7i2UR2hismwKcox683GbaU9DZ5iTkYUOWLHp1uRBMHxabXSYIAWV0m+eJauYUC1TFoGpthNFvEufrOBywxsjd4y0ctFz32Pbkm9wpSTwUfeKbXhuRrZ78XdPz++F+46n4cIpD7i+yR4hgo50XdTerQWuGKX7QXZrnaW83zmt+1Bms+fthqCiLW+GvDVJj1+9kAN+XcMk0yfhgo5VH7bJ+hVECKAwJAWNuj1rrvgarrRkpbZiUASl7a6nGOr7y8+KiMwC+/wKMkwl3eB8ZN84irZ4MkGRFlLk8kpO9WspFlPayK6AYMdcV+gehtCqcB5DOiHMEb1beDL9aiWIEPw5KUuhNHxj2fIrWyRfFo09oU4tva8OQGiCu/e8bfCjSFuSYb87PZo5LbT/il24xOwCGl4wLYz1ABSIqXR6Yb9mfQWLI4y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(56012099003)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUY4aWJoYU52L0Y4K2xaQ1U1aUw3cFQxaWh6TFZGYlZ2Qm5GNktWOXZoRUFI?=
 =?utf-8?B?YVlFMGVHM3hhVjZhNVZDR0VxOVJDZWZRZFJycjdTeTRBbGs3VGgwQXQxUmUy?=
 =?utf-8?B?SzNMZmEzRGp4eU1FOERLTXZqcmdZOTVHZzJSSVdCamdNVUtuQkxrU1JCODQ1?=
 =?utf-8?B?eFBJNjVSMjdXek8wZkV2QTFaa0MyeU1uV1FxRXhYbjBmYno4VWZ4clErQW40?=
 =?utf-8?B?OFRCVklKYWc1ZzRkT3d2bGE0czNwdGpKazhjQjBmY0tlNGwxWFN2aTN6L1VC?=
 =?utf-8?B?eWVtZU9BeHhUQjdhS1ViaHFqMjR4U3J3RHIrU0F1cVk2cjVieWJ3NXh0dGNo?=
 =?utf-8?B?cGN5RjhsbVZ3U0FXSzYvNlRCRmt6Vk9Sc0RGajdrRUswOGtSMzBneWYxbGpL?=
 =?utf-8?B?MHpISDA0dFc2d3RNVUR2M25RZE5UWlJjSWt3amJVK0ZwS2ZUOWx4czV5aFFQ?=
 =?utf-8?B?a21jSEtGUkdaUDEyRzFmMUZMTWVwVEZYazUxQUd1Z0RyaHhtOW0zME5CRFdl?=
 =?utf-8?B?TTVodWYyL2phQ25nUFNNa3FQU0xZTmhFZWdqd1ZYMUUyS2FsQ2ZNTUlncVZF?=
 =?utf-8?B?VnBPWHk2ZzRRbGZVU1IveHUyZ3JjaDNuajMwQVlySDJJWm5yV2xFMDFyczds?=
 =?utf-8?B?Tk1lbHB6N3RGNmE0NzU5dHRqTDRFbTU5UTdsYWc0VTZpZjk3aVkvdVRKKzRJ?=
 =?utf-8?B?Z0dCNkFXeGE2aW9aYkNWMGpSMy9NMnZ6WVZ6ME1TMHA4eFQ4NW5rclpWQWZL?=
 =?utf-8?B?TWJmTk5Lc29nTzhzcTYwc21EeTdFLy9kNkFYMUlicjJrTFEzK0RZak9UMFBz?=
 =?utf-8?B?VFhmelhrT2NRT0s3cXhUMVVQRi9tUUpqaEY4d28yYVhmclRnQ1ZJN3daZ1F0?=
 =?utf-8?B?UGJnellrN1h1Zyt1VzNNNFJnR3RnS0YwVUhTL0N4QU1qRCtpWWR2djVtQnBW?=
 =?utf-8?B?WDZtRVZQTkY2UzQ3TTdpRW5MWGFMT0Z0N1ZkMHBJb1dPR0dYYVdrUG0vZGdC?=
 =?utf-8?B?ZDVTTkl3cVA5TVJEdll1V2NTU3NFRmJXYnRSOHZ1RE01R2ZpaCt4MVRpQTNo?=
 =?utf-8?B?Z21xOUdJRUZMbWpoekNXcnJrVzJqazlIRzJlZ2prREwzbVpIYjE0TlpPTWNL?=
 =?utf-8?B?dnkwU1Yvck5Xd2Z6bnYrSVhTOUU4S1NSM0NZSkQydVZhbUoyOVVRZm9NQjJI?=
 =?utf-8?B?bVozTTk4RjRBZDg3SUtrZUZqelRzMXJ4R0VDWEpaNVh1ZmI4TGNJRzREK3hL?=
 =?utf-8?B?SWFuU1laQ0xGbmR4dDZMa2c4eGp4WG1QZkVsaEhHdlZkaDNtN2VIcndZendX?=
 =?utf-8?B?OFlPamlrV0FLRlFZTWRNMzV1WmRWZmxDZzVWaEtqZ0ZRZ2hESWluenpLaE8v?=
 =?utf-8?B?VmtLcmVRQmlSRis2allOaXByaWFpU1lLSzlMQnp5NlJuSy9Uc2VKeU9yNG1C?=
 =?utf-8?B?bDEwTkdXMFJFcmR1SG1PbGIrK1kvNGZiYXZ4S0pWakFtK2k2S2lZVmR2UDUz?=
 =?utf-8?B?bnliMExPbEZYcTRpQUZpNXE5QzQ5L3FhZ29KUlcxenAxcit1YTkxZDlaMzk1?=
 =?utf-8?B?TnhRODlsOEpZcmN3dzgvQnJPalV3dEVsTHVPdyt3NzBqc3g5bFFtOUhoSXZy?=
 =?utf-8?B?clpoSnIyWUdCZFpxbVdXM0dndnRVL1JvRllkMVhIV3k0TmRrakc0cHY0M1B2?=
 =?utf-8?B?MnFkb3Rsc2NOUVRlMWRaclQxVndmNklhKzdZVDl0K0dXMUZ1QWZqK2xyM2hv?=
 =?utf-8?B?Y2MybXpMbU52K3lKR3pJTWVKc1hoSWZrRTJ1QXBzVE1ZOURCZ1JhK3loUitV?=
 =?utf-8?B?TWI5WU5ra2FGb2JibGlXRkRPNGR2T0I3RDVMZ0VVVlF6Y1lzWGpVY1FMRnEw?=
 =?utf-8?B?cE42Qk1GZjFjcjVGRTBCK1dCNmt2dUlmTHlWcjl4S0srS3RUNUFReXFCZmZl?=
 =?utf-8?B?eUc1bXJVYis5ZHRKMUdaMzF0SVBHYXo3d0FoLzdyYlNIUUpKSWZoVmQ5Rjha?=
 =?utf-8?B?RGRKcGJkY2grU3BzNkR6VklNdXVaOC9OeWh0a0k2Uys4SmpxekhmQjIyd3VJ?=
 =?utf-8?B?WTdScDFIaE5tVmFYVFo4QURWc0p4dUZlc0JuSVQ0SkFVK3lPaFJ2UzFlQ0RV?=
 =?utf-8?B?QjdEYVNhSXRqRWxNMStyNEdLT1JaaFRFM3NUUit1TFdnUkl0RHdmY3hQSWhv?=
 =?utf-8?B?UFl6S1QwanRBbEdNWml4c01IVlBtOE9KOHN0TzgzY1RaZzJoOUtnbHEzNGpj?=
 =?utf-8?B?enpVWm0zS2ZDckg2RGRCajJ2RFlxMUlXeDhhb0ppWWRkeWhJS3p2Tk93a1c1?=
 =?utf-8?Q?/eutod34eRHISyq6lI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <463D7CE700D0C2489707958CCFD5B09A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f14239e-ee6a-4f53-ae6f-08de8fd8e51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 10:24:45.2413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2Gvxf5bDtkNJ7vLAhD7HN+CZhEKe21asYKhw68P7OGgM93VZt+zie9fNnZmFQi0IaoY4LiUxCcyBY1p+xhJZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11884
X-Spamd-Result: default: False [1.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1seal.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1seal.org:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232750-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@1seal.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1seal.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1seal.org:dkim,1seal.org:email,1seal.org:mid]
X-Rspamd-Queue-Id: 2B1A53786F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIEdSUF9BQ0tfTVNHIGhhbmRsZXIgaW4gdGlwY19ncm91cF9wcm90b19yY3YoKSBjdXJyZW50
bHkgZGVjcmVtZW50cw0KYmNfYWNrZXJzIG9uIGV2ZXJ5IGluYm91bmQgZ3JvdXAgQUNLLCBldmVu
IHdoZW4gdGhlIHNhbWUgbWVtYmVyIGhhcw0KYWxyZWFkeSBhY2tub3dsZWRnZWQgdGhlIGN1cnJl
bnQgYnJvYWRjYXN0IHJvdW5kLg0KDQpCZWNhdXNlIGJjX2Fja2VycyBpcyBhIHUxNiwgYSBkdXBs
aWNhdGUgQUNLIHJlY2VpdmVkIGFmdGVyIHRoZSBsYXN0DQpsZWdpdGltYXRlIEFDSyB3cmFwcyB0
aGUgY291bnRlciB0byA2NTUzNS4gT25jZSB3cmFwcGVkLA0KdGlwY19ncm91cF9iY19jb25nKCkg
a2VlcHMgcmVwb3J0aW5nIGNvbmdlc3Rpb24gYW5kIGxhdGVyIGdyb3VwDQpicm9hZGNhc3RzIG9u
IHRoZSBhZmZlY3RlZCBzb2NrZXQgc3RheSBibG9ja2VkIHVudGlsIHRoZSBncm91cCBpcw0KcmVj
cmVhdGVkLg0KDQpGaXggdGhpcyBieSBpZ25vcmluZyBkdXBsaWNhdGUgb3Igc3RhbGUgQUNLcyBi
ZWZvcmUgdG91Y2hpbmcgYmNfYWNrZWQgb3INCmJjX2Fja2Vycy4gVGhpcyBtYWtlcyByZXBlYXRl
ZCBHUlBfQUNLX01TRyBoYW5kbGluZyBpZGVtcG90ZW50IGFuZA0KcHJldmVudHMgdGhlIHVuZGVy
ZmxvdyBwYXRoLg0KDQpGaXhlczogNzVkYTIxNjNkYmI2ICgidGlwYzogaW50cm9kdWNlIGNvbW11
bmljYXRpb24gZ3JvdXBzIikNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpTaWduZWQtb2Zm
LWJ5OiBPbGVoIEtvbmtvIDxzZWN1cml0eUAxc2VhbC5vcmc+DQotLS0NCnYyOg0KLSBtYWtlIGR1
cGxpY2F0ZSBvciBzdGFsZSBHUlBfQUNLX01TRyBhIGZ1bGwgbm8tb3AgdmlhIGVhcmx5IHJldHVy
bg0KLSBwbGFjZSBhY2tlZCBpbiByZXZlcnNlIHhtYXMgdHJlZSBzdHlsZQ0KDQogbmV0L3RpcGMv
Z3JvdXAuYyB8IDYgKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L3RpcGMvZ3JvdXAuYyBiL25ldC90aXBjL2dy
b3VwLmMNCmluZGV4IGUwZTYyMjdiNDMzLi4xNGU2NzMyNjI0ZSAxMDA2NDQNCi0tLSBhL25ldC90
aXBjL2dyb3VwLmMNCisrKyBiL25ldC90aXBjL2dyb3VwLmMNCkBAIC03NDYsNiArNzQ2LDcgQEAg
dm9pZCB0aXBjX2dyb3VwX3Byb3RvX3JjdihzdHJ1Y3QgdGlwY19ncm91cCAqZ3JwLCBib29sICp1
c3Jfd2FrZXVwLA0KIAl1MzIgcG9ydCA9IG1zZ19vcmlncG9ydChoZHIpOw0KIAlzdHJ1Y3QgdGlw
Y19tZW1iZXIgKm0sICpwbTsNCiAJdTE2IHJlbWl0dGVkLCBpbl9mbGlnaHQ7DQorCXUxNiBhY2tl
ZDsNCiANCiAJaWYgKCFncnApDQogCQlyZXR1cm47DQpAQCAtNzk4LDcgKzc5OSwxMCBAQCB2b2lk
IHRpcGNfZ3JvdXBfcHJvdG9fcmN2KHN0cnVjdCB0aXBjX2dyb3VwICpncnAsIGJvb2wgKnVzcl93
YWtldXAsDQogCWNhc2UgR1JQX0FDS19NU0c6DQogCQlpZiAoIW0pDQogCQkJcmV0dXJuOw0KLQkJ
bS0+YmNfYWNrZWQgPSBtc2dfZ3JwX2JjX2Fja2VkKGhkcik7DQorCQlhY2tlZCA9IG1zZ19ncnBf
YmNfYWNrZWQoaGRyKTsNCisJCWlmIChsZXNzX2VxKGFja2VkLCBtLT5iY19hY2tlZCkpDQorCQkJ
cmV0dXJuOw0KKwkJbS0+YmNfYWNrZWQgPSBhY2tlZDsNCiAJCWlmICgtLWdycC0+YmNfYWNrZXJz
KQ0KIAkJCXJldHVybjsNCiAJCWxpc3RfZGVsX2luaXQoJm0tPnNtYWxsX3dpbik7DQotLSANCjIu
NTAuMA0KDQo=

