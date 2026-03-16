Return-Path: <stable+bounces-225643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAZrDmxCuGnSawEAu9opvQ
	(envelope-from <stable+bounces-225643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:48:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73429E839
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B92F3033271
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2290290DBB;
	Mon, 16 Mar 2026 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="unVqs60J"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415D1C862D;
	Mon, 16 Mar 2026 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682983; cv=fail; b=qMWsI9r2yk+7qL6do2StCcBiygcXwI15V+aiV+HN6Uj/WMOjK9hrakhk6UznWuPi0bYDZxKo6e5o1NcKFRd6qtoMrdaj0bzVmfvtYYfBQryVvvmhM104sb1FNBv5Z94uowCndYnl/jlECwRBksIrqOiDke6NgKhmWar7iEOp4fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682983; c=relaxed/simple;
	bh=16iuWcYbbsP/IjMOjkv5sgzEs9ZFcszHV0BgtxC6y8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzZ6fLB1m1dqsY+1HtZeRhwvssVxdS340ET+0TjqMvq8CBD5UqRhOVvWSRYtEu5tjQuwZCsXTZvUDThE/uLdYclqWRVXvVSaLyyTd+jOWXcwInBV1scOoXsnNQcMXD3D1OV2uILy8Hfy7aCEWJmCPDODhVpXla8LDpBsWmpLe3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=unVqs60J; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMsyaf1T8hjAuVB+e4INMDDbuACor0lwUS44Zv0Txm/rZFL9+UlHzj7ylR+iKNStQxeB6VvBtvmjgWE6dfqt7CD/Dq5Dlq5tyccjIw/xxxZZwbphxD+CcquYk60lWohZyjGptzc+rTJbCMw3L4lU1M4lqX/uDIRux5KfkLEjcrI+zhcJ9ICD1i6qiLX32MO59V7e3IM2koXckV3NJEi2MmDyIEpFoGTzMhDT9SMEXAVxH1JO20zF1PMOHBv4djhq9/tqXxYOlWILQnmXEA9SeEds1Gp0+9MSWxWIMQWSZ1ULdkPSFQAKp+DMKjRnJof8R9IVlPLF1vj9f5sT/sjQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16iuWcYbbsP/IjMOjkv5sgzEs9ZFcszHV0BgtxC6y8g=;
 b=TG5m93mkl301I+qIby1houCJZVe3dBxw9w102L2rzb6ILxsvwhCIbv3JyJep6EE4Y729PR7lnYH6dcg4kqw14jfN2Sk6lkIqI2P8v6DKE263PIbzuiPALj+/yCX4AcTz7lAISQF2i2QBIwEf5P+ExBhgHMFWG4qgqUSScAz4xEqV0EK9zPW9EbSY0eoseszI9XS19EkLBli0+VO+HBfRS+RoccuUtjEZjx4zZOx89ksvBKo5GKlQut7ju7fO4BkxTHdGpLmz4VNiB8zAeC2qkt04rDmsUL80/jDxEuyjmzc8Qn4CM9FmFPWLbIO6a3bVJJ0GK6ocUAvHrgWm2pdnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16iuWcYbbsP/IjMOjkv5sgzEs9ZFcszHV0BgtxC6y8g=;
 b=unVqs60JPF408LT7xMHp0u/gEUNBZRYTlYoLEIBX/iaiekoujaHAzPO9yXwcxLME3VzzdYWuiFqPGNs+b/4OcwBmteerYXQ6UTAIPOTJ4I7PkTmgT7cnj9ElhwGSh0CKWhzHGB4fvVbsAgPlGRui8eaj+8Od7kgAYu4RgreECxK9wsBs2KcozxIHJkzmhEuXf6hjpMPQfA7IdL00Jho3REMeYUBOu2cTcX5oxMiGWWlDQjXw7WMFqK0+y1zwivr/s0xe693zVo0DtL3VmFvRDmq+v5S5bGDraJDtjUwtB0Ve2JPRYMzz6N0iVmo6SNLg1cyHPlhH6ebwVGhHc99Lug==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:42:57 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 17:42:57 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "sdl@nppct.ru" <sdl@nppct.ru>, "lyude@redhat.com" <lyude@redhat.com>
CC: "bskeggs@redhat.com" <bskeggs@redhat.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"mripard@kernel.org" <mripard@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/nouveau/disp: Fix potential NULL pointer dereference
 in nouveau_dp_irq
Thread-Topic: [PATCH] drm/nouveau/disp: Fix potential NULL pointer dereference
 in nouveau_dp_irq
Thread-Index: AQHctWt7u0x4fYncpkuCpyWLDhh4RrWxbc4A
Date: Mon, 16 Mar 2026 17:42:57 +0000
Message-ID: <ac4867a4c6da6aef61b189960c0142a660b2122b.camel@nvidia.com>
References: <20260316172631.82304-1-sdl@nppct.ru>
In-Reply-To: <20260316172631.82304-1-sdl@nppct.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|SA3PR12MB9228:EE_
x-ms-office365-filtering-correlation-id: 6bb06eae-e4e9-4c27-8544-08de838375e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 +/unYsUBAXD8tFOeZlB9/DSL707DW7wIEt6ACXLKCWbJJmCLa19FzQ1EqWixXHoDB6O2Di6D80pj+d3LO6dNp3Gm5iB1ml9bi0R0+xsLTsMXTuZzcotsvpmg54Sg/YFDdAV2cGFEiA9QfExnaVBfsDn0WV0qKE4qAlUrbkkG6YrJquzBxn4iGoLoIeQJDFcIuGCYZxeMCIpfPhOZYHUBFE04hw8tOaappdmogkPKshEL1mCBLTXuAYbcpL9oQjDBcGkkhpBFliY4bQCn1nAfehhsAK89POyyXpKFKIYXYj/UmJr0CqtuMmfDpj1lfBXd/6eXP9y5RIZkmxh5h62ECKnqjLrxxJVVUAU9N2wAagFKXg/+UcsIFRKitroV5OTLyC0Gb54B1Jx9TjEthpJEizdWaRZOHYVLWTeh5Q6lSiWBWPJhnu3weHo8kUDbUyEmx8AhlOO8gkVt7/InzMIMpnAvPiWz/3IJ1+De63tED8fU21BmflQu4GTKrGRMFUghBc9FlU5fsPAW8CDozkTgl1bjqNncEjx3TqM/aUlWS1FnZbfSZFmSMtbJrWg3S00c+1I+YN9BunL1DkiiE67V7Nu1rvJ4b15Y8+08OehyvRrCk9WVUQ1ayakaEZ8yvjKAA3zhS4vy5Za2Rw8NTxvAqZ7dDpMeJvPLw4CEV5s/yVhEuwHUacsQ2fN1tVLObWPpF3Ki7d1vpDR2VPKfacKTpc7rNu1pQn8D0KcMDON1iAylhfKgMgpW4R7xJxCPooETNYhdd4QuSgXHQFzKWZUWTt2zaCPTK4lPx7r/dpvcCBM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blh2SGd0YnVrQ29SSmRzb3ZhQ0p6eEZHaHY2QWcwWUVlVTVBRVhaVXpKMFph?=
 =?utf-8?B?QzZzZDBta1BYSERkZStHaHdkdnRRbGFKQnRvcVBWWFBicUNvcXJsOFVXWWdw?=
 =?utf-8?B?d3hBaTNQUlcrNExSWHZXRDhJYitmanlyZEtTcC9pc1Z0TG5FUDdBRm95Qmtw?=
 =?utf-8?B?OGVUUUhMb3Jkb283VVY2S1JjNnVPZUhtQjVvSDF5QWMrTmMrTXFWV2FaWE84?=
 =?utf-8?B?VytTYUtOUGZVR1BMdGsxcVhRN3k2UTR1NWpmYk9OZnFOZlNQOEJFOFlVbDk2?=
 =?utf-8?B?ZmQ4TW1pakp4d2dmL0JrVFVuVmJMZktwR1llREV2QzNiejEzNjVURERvUUJr?=
 =?utf-8?B?NkRORXkvNUtRRVZoNkZBeWxtTlcwdGl5TXJyeGMvRnZ2YVpJQ3JVNnFqL2Jo?=
 =?utf-8?B?SytiQ3JSMWRyaVA0NGVZTytWYmlyamhwOHAwUitRaGkvRnI5RUFsclMxSUE2?=
 =?utf-8?B?QUNUcmhkT3JiWXVsVk03Mng5QjNwOUZCRm9FMHNNZmVWc2Y2akZYeUlFZ2xP?=
 =?utf-8?B?bDBSRGsyQWJUNWhVVVlBOVdKTDd2SmErajVTaGhLeHVpb01uUXlsYlVWdWNu?=
 =?utf-8?B?SGZtbUlzOFZKcjNNc25hV05RRmp0NjFKVklpNGlLcTd2WlVGT3BDMUJxQUJ1?=
 =?utf-8?B?ZzFRZHlZQXhGcTI2VUxNRjlSQ2c4TXhCR3I2WHI2MGUyV3FNdEkyT1VRaDZ1?=
 =?utf-8?B?UXgxUnRYNHA1YzhjV0o4WTI1VzExRU9leVdtSm5UN3hQYS9jSzBZd3dKZld0?=
 =?utf-8?B?Rm5lRHJGTENnYkRCS3oxNVFJZ3VyUDFTQmZhSVhnTHZNeFVtUGxHbGxIaGtj?=
 =?utf-8?B?WDFWZDhaWWhhbDVKUk8vYi91RENOd0xXZm8xazcwRDFvVGIyRDR5LzJkTTgz?=
 =?utf-8?B?TmtrM0hJVDB0eU9EUUx3NlBQTHg2UTZkdytLQUNDZ2s4OXBzWjU0Y0treUxy?=
 =?utf-8?B?S213Ky9GajhVdlZ6b2N3dEJQRGdna2FpaGU4aVV0UUpqQ3ZuSE9NZU1GcmhH?=
 =?utf-8?B?NW5uQkE0UmlwaExIZWtiNVFCNW1oeldEMUlSNklHdDgyOWR1cWU0Z0svNUNB?=
 =?utf-8?B?d2JlRlVlZU5PcndnME1SclBvc1FlVEdHKzdTdHBWOHQ2Umlpb1hnRU5HMDNw?=
 =?utf-8?B?M1RvNGVXNkxGN1VoSDVKaDNZS0JMcXdQZks2R01rU0RiREVSbmxZTE9sdUk4?=
 =?utf-8?B?M0gzWlloQ2ltNkxQcDRKSGpKUTJPYWtvdGN4blZMMmJBK1huK0UvS1k0UWFN?=
 =?utf-8?B?SERramdYQ28wRTJGT1dCUFN0Y2lxQXB4ZGYydldvMEVaV2Vub0kzUnRmcVRw?=
 =?utf-8?B?TWIxUVl4elZVRDFpalo2dHBsRG9nZ01CZDZ1MnlYS0UyV3dSQ0tnYnk4RkxT?=
 =?utf-8?B?V2hWTXlJZ0VBMENCczhYd0c3WVZzc1oydnJaRlVCRk96c2J3S0dDZDluWVVB?=
 =?utf-8?B?dGhpYWwySXZkT0FtNWlBekZRNW40UVIrS05IdldFSElWdnloZmpnNk53di9i?=
 =?utf-8?B?SWgrRitjOU43dEYxS3NpemtoMXRkTDd2RzJLL1FYQTgyaWZOb2RSa3Bla2M2?=
 =?utf-8?B?eTRlRnFuNFBVakl1Z0JSUkx6aDBjL3pkanh1dHNvMlE5N09KdzJjbDNQVlVj?=
 =?utf-8?B?R0dsQTZHNENPZi9UcTlJbkU1SlRmYWRLcEpCY29qWDZQaVNiYVYvbElXZ0hz?=
 =?utf-8?B?WUpOcmhFUVBqdnVrV0hrMk5GdEJwWGcxcmRwYVg3a0puYnRua2FXUlhrb1l2?=
 =?utf-8?B?dElJWHVCUVVoT0tud1hNdlZOdjV3dXVPMWU4Q1JBNDlhd0YwU21YWWhPdXJa?=
 =?utf-8?B?ZTRwM20ydlA4dWdEUGE0cEpJWVBkeXF4NXExa0x1VWZsemRuS3lmZmw4elZN?=
 =?utf-8?B?T2NnZkVHQzhJUFBGZ1AvRlc1WFRjNEhiM2dER0FURWUrM3E2eDdzSUovNytF?=
 =?utf-8?B?NnBpSHZvT1FGNVlaRlhOQVRzd3habkkralZTTVNFN3dOWksvSEJUemNmRzJx?=
 =?utf-8?B?N1FmQWhxTklKS1VnMUdrbGJsazhnVkRMNDg0cXh3U2ZBcTBvY2xFTTA5N0pK?=
 =?utf-8?B?cmt1UTdXeENCdXY3MFlscW5sVEZwbXY2RlA3aWJjSmoyT0RoRnBYSldIcVBP?=
 =?utf-8?B?VGhURW5kcWdXUDVKZlRGd0tOVmsxZk02eERkQXJRa0tzdExtTGcrRmY5RWNK?=
 =?utf-8?B?cXdZTnlHdVB0RHpGMnJ0Z21mQzRNelNNSUx4bjF2cW1VSzdJenMwcTRVU2o1?=
 =?utf-8?B?cHVVQkhzb3Q4Y0dZMHljVnllZG51UmNrRkdwZ24rUTlXUUF0aXdHWlV1QTli?=
 =?utf-8?B?K0VBWlFiOGZUNExNMlRoclR1bEt4djBVN3BIZUlGakJPS2kveXJrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9233A786AF6E81449E8F1DEF097B13AD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb06eae-e4e9-4c27-8544-08de838375e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 17:42:57.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RK0cGW1IDl0azltKQqNaiRak09ltp41u+8nl5vShDCsU/7P6EwWXh7rO1gFvDdTAxXp7E3ay0OhOY7nXi1jccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225643-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttabi@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: AF73429E839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTE2IGF0IDE3OjI2ICswMDAwLCBBbGV4ZXkgTmVwb21ueWFzaGloIHdy
b3RlOg0KPiBub3V2ZWF1X2RwX2lycSgpIGRlcmVmZXJlbmNlcyB0aGUgZW5jb2RlciBwb2ludGVy
IGJlZm9yZSB2ZXJpZnlpbmcNCj4gdGhhdCBpdCBpcyB2YWxpZC4gVGhlIGRybSBwb2ludGVyIGlz
IGluaXRpYWxpemVkIHVzaW5nDQo+IG91dHAtPmJhc2UuYmFzZS5kZXYgcHJpb3IgdG8gdGhlIE5V
TEwgY2hlY2s6DQo+IA0KPiDCoCBzdHJ1Y3Qgbm91dmVhdV9kcm0gKmRybSA9IG5vdXZlYXVfZHJt
KG91dHAtPmJhc2UuYmFzZS5kZXYpOw0KPiANCj4gSWYgbm8gZW5jb2RlciBpcyBhc3NvY2lhdGVk
IHdpdGggdGhlIGNvbm5lY3RvciwgdGhpcyBsZWFkcyB0byBhDQo+IE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZS4NCg0KQ2FuIHlvdSBwcm92aWRlIGFuIGV4YW1wbGUgb2YgaG93L3doZW4gdGhpcyB3
b3VsZCBiZSB0aGUgY2FzZT8NCg==

