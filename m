Return-Path: <stable+bounces-216077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECy6Dt0gj2mvJgEAu9opvQ
	(envelope-from <stable+bounces-216077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:02:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDB51362F5
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C068E306E3F2
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D51E35FF72;
	Fri, 13 Feb 2026 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="feBSC/zS"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD335F8B2;
	Fri, 13 Feb 2026 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770987709; cv=fail; b=fbboafYssmBHzVMmm2oQb9fbvnGhBZFZ5nc8t99IRq0Op8A/JpviwNNhDAumkrchW4gBV2jNFijoQbjMfg97zNiC0w2xSWe5F8y3S/6m9/U0i3yVhHcBSE2kpHhg5FZKMZTES1aGAILiSa8tDnurS2SpTX/lFsgLAYaUQuydhsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770987709; c=relaxed/simple;
	bh=JS90BzMUiwzk0mRg20h8+g6Qx9nl+i0ZxytRAulWiLM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I1JnstOoW1ksVyG+bQtRXoeM8HKgUEWhQmf6aGC1Cq0+rabTAIVuVF89htDAtP0ZaoOZAjInC5F2a8564076q7fvFKIs8L+YawmPihwhqcXt0/uLSoEvKIZMaz9ZDPVPCzcDZSllByNUwzwJdhgVMpq/9OkLYSlwSKyJ0d3y+Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=feBSC/zS; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCGF8XQx32xHDTEkdXv4aM9r2dXVjiKPijv5iLZdCW/Iztwwo+u7oWQ/Gdrv3IrmhoVkhoEaS2OVr3AuI4eiY6s4/Sme/WMqV7Dcj30ITKPSAH2Xemr1u/zYLKDejhgikRNO5nV+9p7YVnIinbc/zSt2pd4S6c5O9J+ptxDdhrKVDadSimNDrKTe/dzmPizeYvUbCPYHMqaGqbLxSMUTykxvg35LDyROqaK8FRsLKmjHSd7yTNGsZiOWZTV0MYY1qKw3qMb9sgl6OK+mIuCFKsvjUwvIwf3DIK3yqsK7TFt+3qo7ossZFbFHMm/YSrI1izbQjZRO3j35kzqlqRfAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOQRKSF2GvN5eCjEAzFh1DxUEqewAYg7niJjvWQ7gPo=;
 b=BAoeuTfS/hwDa9SjRQaBfSzmwJ4+CgVBVKm9g/sVJvRQ/zkNsFayDv1Dqo/W4G1uTOSoVpp1tqWfPs8eaB3Q0TqJyYE+o4jyBhZqLtmZatFVGUYUBTt4GgkJ/JAQGzYvwUYmcw8Awzx3U7RWd4VjwJm9Q+ej/NYdSylt5JIxvzJ0JVBf143/Kq+IUjlcw+HfBk0ofMQJ8kmzaAUk2aQ8Jk61OTCmECjVDvjfej8yZZTGiNZHmKNWgxVJR2fuJWU2g1WMnKc624BP0YjXH/9XR7F7cMDXNXFkWbaIyZtF1KvcJ8Za3rEYRlnh/YXbQBYcia4fP7t5nvlURhyuGSADpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOQRKSF2GvN5eCjEAzFh1DxUEqewAYg7niJjvWQ7gPo=;
 b=feBSC/zSmow9qN3w/TKc0fJjPP5SOqTz1UQ8PQCwhHvVmB8FtHAgbXLo1aU5oIxoyDfOjvvi+umWuTzDFGUS7ylLSJX1L9p7OgtNFqJJriZFbgEi4JNIq8JmugpiAF0QXyfyj5rEJCINPoV4+2mSpM6mns4NV494omQCQ3CpKufFjQ3EYTzKXZAH8YVxbvGOyrjti8bEDaorZhVOHs69etRpomBCg/elvHAiqrFfteEuLAQd190JtnmU1B+AQ+1aNDmybgXNh8jAouKPaUcacRsgvl19Bmkr3vvp3ZzV/ORn9Ci07ahNQWhU58jx+0JKK/r5YB0RIXRjldJf3UfiaQ==
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com (2603:10a6:20b:2cb::15)
 by PAXPR07MB7936.eurprd07.prod.outlook.com (2603:10a6:102:139::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 13:01:45 +0000
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef]) by AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 13:01:45 +0000
From: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: [RESEND PATCH] uio: fix uio_unregister_device
Thread-Topic: [RESEND PATCH] uio: fix uio_unregister_device
Thread-Index: Adyc595sKoOU5JtMQGyj/t5+IixG2g==
Date: Fri, 13 Feb 2026 13:01:45 +0000
Message-ID:
 <AM9PR07MB7204666518940F3C74372D7A8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7204:EE_|PAXPR07MB7936:EE_
x-ms-office365-filtering-correlation-id: fa756bd6-d988-4621-2870-08de6b000a6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9OTFFFGA+v89md8haya8OHsr0sIv8wrE9CZyR0gm9szDSmi1uvwpg9BuHli7?=
 =?us-ascii?Q?1xmOiCUWryebNNzkXPeqLvr1iGygXvQ+jrXp9j3MEbC0QWOi/g1QO1zV74nC?=
 =?us-ascii?Q?sBoDgAd+hsuFI7K2LHbya/064yhEQcD5qwVdphZuL1Of5oHayfIO87ia/YbT?=
 =?us-ascii?Q?VrhSLH9ig50nbaaQtFnWNYX7xjYoFAW43uDx5UPuJcueMR0Uq6R6LBJhG0dE?=
 =?us-ascii?Q?huka//jmpxabUT7CpKW6CKtxPxRfoCL8PSCTa1/pW0VvV4s+TpR3sbDOAxbu?=
 =?us-ascii?Q?/eqmpf8tOzg4j1G93x7G54tb5c31Wnm7lZvN6Sysa9/HfXwi/kqESee907Cl?=
 =?us-ascii?Q?Ux6rS05tlONslbNGlDIixhay7cbnmzj9iQJf1Ec2ZrJZrPK+dXy9NpKAn0Nj?=
 =?us-ascii?Q?tMHvy9hIr9MM6zfv6Z5F8I1JGa01S+VPBi39CzQ8isP7HfpbLqtMUuZysw9T?=
 =?us-ascii?Q?Utm/8nUKfyTLsqAAE4BBiMt9AEqktnEKr584rHf+F9izZgH/1zYaWCzoFW6n?=
 =?us-ascii?Q?CVBJRpxev3LR5TGYLukx/PxG9kkk3+oIfK/bASXnRub5OtkwzGemj+nycuvF?=
 =?us-ascii?Q?vRyzUfDdhSHyWQVSvBUaoEtvQ3xrEGPbptTNX/SiOMPummjgkOz73MDO8BjN?=
 =?us-ascii?Q?gRWxNAbEXRukbyZjIgSPB6A8HdY2FdkZvzFqxYQpGmeS3RuJDTfSjrrQiB8S?=
 =?us-ascii?Q?J9WratmkPVO9Eij/Ha7xVxTUWgHbU4Z/5tIEMlrkxMeFFIHqFXgHxpnlKxC9?=
 =?us-ascii?Q?DSn8HPXT1JUSSgv5sJys449mvtmmREco+5zxi+WKsB5I1bOfbR7LysdDLh57?=
 =?us-ascii?Q?LnrMrPSh8lEv3vBXdjXwB5osFIyfbgCnde9rJZ8t0fwH8/RNbaMQN34LKKTa?=
 =?us-ascii?Q?c6QAod1xxdAET3wM0IZgDdRtvJwObqRiLTk1+xf2Y7Xqcml4Yb1UywAoNgD4?=
 =?us-ascii?Q?KqA1PKtyP6OrB6XZFSPxrNbVJzYoHoW3ssyVmKnFhbEAYDkZ3Xkbg+mvGHKU?=
 =?us-ascii?Q?fTwCYd7TYBKh/66t9MoHpylKnIwAW0GnG96JuiagsxZNXnsJCCc318JEvdlW?=
 =?us-ascii?Q?jf6x5UFJ6ToXL9W6HhuSOZscN5b4JwkxP5dDlQNRAzidpqWdFof6S9MZ06AJ?=
 =?us-ascii?Q?AJuxrv1/r39FS/R39d/R2gjsDIS5W+9YQgJ+nD1XiRlRMf+CF1qez4pK3PsL?=
 =?us-ascii?Q?tXHPARX0Ns3Tgxtlkw6bknqK3g5oGpykTpC1JjF6IdSeE5M/ahO/QnhALofy?=
 =?us-ascii?Q?jSosIOPGORJ6QCVAklxkSifWp4S6uDXAf/OKwCCukNkHFCTYNvuWyituXm89?=
 =?us-ascii?Q?5ZWAp2pwC8qgM5RideNT+M2D1Yyig+iMwMvHC0pcyFYZVTGT3H9XbErSJBHA?=
 =?us-ascii?Q?UDee+xWVrhTovenpLuKRwV+E6N53F4EhFvVp6aBWDIblDkIgnuCuG7X1W7cC?=
 =?us-ascii?Q?VvtZJnD/69HwtnY3sofjOpzkEs7yxdSi5GfvB7CKpshPH+1E4ASMKLNXaLYr?=
 =?us-ascii?Q?KN1PdxN/FFKCHsgQ0EUO9q9p+h9YDYY+P/UIpiQYJEScvQj8j/9bKZLHaa6H?=
 =?us-ascii?Q?RRYUGCvhzCDXM0l4zknlJr9K/gjdeGtw8AG98wnpOdw7JCa0b29oPKwP6Kw1?=
 =?us-ascii?Q?LtaQhj/vi8UnAVQXimFZdyA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7204.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cs5pQ2P2DMWML6RP5GjBT8gBvWAGNN+sy2Q7vPZALBQHrB1n1gu80ij+vRIa?=
 =?us-ascii?Q?DJznkJRqXIK/TmlboPVyQdWgsPGYxmkd8o7llQxMRuzg0PFdWqBAX2VCsEkF?=
 =?us-ascii?Q?eLnWkyQuUE2aGbHvAX3HxoRYN6WXXY3qa3TdzPe1jcUdlECkM2JQe4vm4Lbm?=
 =?us-ascii?Q?FtPCgoQiZJqWZB4tP9vMlkUlmF5vIa9AmS278XZ1xcBSSuXvrhW4n0vVQqsb?=
 =?us-ascii?Q?IDKzKSmmBjwOu6OEEr91pUapnGB4h9UudZgvZBiuWJGRp2nhsI5B/Bw10WFP?=
 =?us-ascii?Q?mymeTt5fm6BXhZPt4ocHKs5rliDr9WsZyBdB/ZpLKIbb8+Xmr/zDetpSdJ7s?=
 =?us-ascii?Q?2EmpOlPdDSY5QRI/jJyTS8RSYjIX47obgfO9rVyxVnzMhST0h3ZXJTFW7o2m?=
 =?us-ascii?Q?CbsI1tq2wwZFt/2ZbJQ5g48G9n7kxJ3mtqqCGVUHbD5w/XBTTQlT7hunxDqJ?=
 =?us-ascii?Q?ck1sy7tXdr7Yw8mdC7zy2blQ3a532XGkWcxdZfLmjVQHcmX/lcceSPuwfo/5?=
 =?us-ascii?Q?3QB7l17eetcPcLqKH6Ijcn4nvtrlTr3YzE4Vgo7AF8B0dWqx6K993J/Dd5RS?=
 =?us-ascii?Q?eD1iZcGKEKXEGan2dT1nzuN4xthr8l6WwABZQBO9BTb4kpIbguOU+lOyplS0?=
 =?us-ascii?Q?GACajmzrA0N4blzZBP/tpjpksiznj0vI3805C9UWTpDJqYHf/4ucZsgeSBT3?=
 =?us-ascii?Q?AHBS9XCN8NpMBjPyyqlotd6qNCcs+F4kxMnJVQjIvFcBVY8L8W+Ww0lUs9x2?=
 =?us-ascii?Q?IJVeL6Nw4pYz0/pTDdZ8eJirSUIELloLLO07JJuuwnrH9irPwGpnONX3n+Sl?=
 =?us-ascii?Q?+jhitW+J6+caCiJiDEfceWDCF7Fvpe2YSbjSeyQlpwbEBJMfDiwOICa4B5Pa?=
 =?us-ascii?Q?VwIx0NZqdUlGIZs4W3UuVdiIqOG6eKDx/GugSfIxP8QwLE0k4cqIpNw0jBEJ?=
 =?us-ascii?Q?YJb12pL7/zWRYfARS+LfiUKuVuDHVsTcEDtlQ3zoWmDyVPcoPwcJBQZKSmzy?=
 =?us-ascii?Q?sgvhKcD9wc79VQdvhj5PFh/7m+P8IKuSd0c0WMygzH8yJJqcxEheIkjOUkdv?=
 =?us-ascii?Q?zmew22osGxQeyNXxur1VQJCcpHk5spnfoz/XSWJRzcw8hEKqBJBdM277POKS?=
 =?us-ascii?Q?kQrOu12BN3cx3LvbzNHr6T3p4GpJHDKYOFT46aBc55lb/YeM50x7k3366ml/?=
 =?us-ascii?Q?VSX1lgctXl+8qFy3yDFwakt9/CDWGjMP/3wdxpbfPDqN35k94jBQ35yaIUD5?=
 =?us-ascii?Q?Kqe96+Hx20ue+o6Zr+JdFujCvesrmTtkmksSRrNAuefMBeEDOsn6p5UIKSft?=
 =?us-ascii?Q?SfLXR29H8boJfJrBcHVKWsGuPwBIUY0tuwyR+mgN7NH5BhbjHtZ15i9WUQgx?=
 =?us-ascii?Q?SiufJ3eaViId5wYttORX4pu8+4D0QMV/FbHYCPblAjiraz7/oqCDPoS+PDGq?=
 =?us-ascii?Q?+C8VXfm3FZfgRL5Syo9ljhqCymlHmkygdYLAxwviU0/UQX8Zjz0mKa/o4ZBg?=
 =?us-ascii?Q?u+xKA1rH9qB8L35yqSB8xwN2s9OqF04Fn8Pz+eky9CpAwSLP+AYPXONPL3uT?=
 =?us-ascii?Q?nUhTO/4Pp/G0t0T74QowtszYTi7rr0jbrgyUDZEPukVczngk4Vfk52/pvft7?=
 =?us-ascii?Q?w5oDDLMfBRioe8yJWRfR6VO5fmXVajEP4Qnkzqkgq0pspClmkKoU4c7ike9C?=
 =?us-ascii?Q?7ryWDlVyNwtzOn2uhHcxEfeW26yK4k6xSaOpfjsyTvigis5bOkv5CjZqJCaN?=
 =?us-ascii?Q?N9S2ONE8iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7204.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa756bd6-d988-4621-2870-08de6b000a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 13:01:45.2223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hx8aiNWNQIK2x8N/JgJZkwbripFAbJHy9KjvfU9YM+d8tQEacDJKFZfNxNz0Xh1LWvRTwzt5csane9eqYef2Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7936
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216077-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nokia.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor.klochko@nokia.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia.com:email,nokia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,AM9PR07MB7204.eurprd07.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4BDB51362F5
X-Rspamd-Action: no action

When uio devices are created end removed in parallel, then we sometimes
encounter kernel traces along the following lines:

  sysfs: cannot create duplicate filename '/class/uio/uio899'

which stem from:

  sysfs_create_link+0x24/0x50
  device_add+0x2f0/0x780
  __uio_register_device+0x18c/0x550

The sysfs directory creation is performed synchronously as part of the
device_add call. The high level sequence for uio registration is:

  1. uio_get_minor (idr call, in critical section)
  2. device_add (leads to sysfs directory)
  3. manage attributes (popuplates part of the sysfs directory)

For unregistration we have by default the following flow:

  1. clean-up attributes
  2. uio_free_minor (idr call, in critical section)
  3. device_unregister (cleans up sysfs directory)

This creates a racing problem when we are in parallel creating and removing=
 uio
devices. The uio-minor that is freed when calling uio_free_minor can be cla=
imed
by a subsequent uio_get_minor call. The problem is that the device_addi flo=
w
can end up triggered, leading to a sysfs directory creation; while the
device_unregister flow has not yet cleaned up the sysfs directory.

This patch cleans up this problem by mirroring the registration and
unregistration flow correctly.
After this patch, the unregistration flow becomes:

  1. clean-up attributes
  2. device_unregister
  3. uio_free_minor

Fixes: 0c9ae0b86050 ("uio: Fix use-after-free in uio_open")
Cc: stable@vger.kernel.org
Signed-off-by: Philippe Belet <philippe.belet@nokia.com>
Reviewed-by: Igor Klochko <igor.klochko@nokia.com>

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fa0d4e6aee16..5dd137a85576 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -1125,8 +1125,8 @@ void uio_unregister_device(struct uio_info *info)
        wake_up_interruptible(&idev->wait);
        kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);

-       uio_free_minor(minor);
        device_unregister(&idev->dev);
+       uio_free_minor(minor);

        return;
 }

