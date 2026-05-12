Return-Path: <stable+bounces-246676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMOvD4yUA2q37gEAu9opvQ
	(envelope-from <stable+bounces-246676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92452529BE2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9843830EA895
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BEA21D00A;
	Tue, 12 May 2026 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BFX2f/G7"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3A3C457D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619233; cv=fail; b=NHwf6w2aCkAUXPHQqt6ThZTpcmhrA/APpRP5aWOMno0zOS+NWTUmhHp4gQwUu26nqj6h3K6qy3pG9Bht/6ltqgTwVGekhOGnJq6o6SlsIEsoOCHkeECuG8HBWjuNa2V4UhBA7soU9kQznP0czKddEBFP5T/bPBbDrNYbfmehzDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619233; c=relaxed/simple;
	bh=MQTZCbDTeRMuy5KVQfFfh5uuyBgJJe+hHtBpitApCuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+m32PiK3qycZsWTdCXm3+swkZLkm48hsCMlDTlI37s8tObuQRKQIHwpdX/uOkY/tANCsRnXPv+L6oBmlDkwWaRnbtgmiz1aeRQnn8MPrLxq6M5Z2KgXh49Yc8AxbK5dbjyJ9QgeXuTzQgN2BWrnKLMwc2Zk1b0A+WhQugkI92Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BFX2f/G7; arc=fail smtp.client-ip=52.101.57.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6VnADVf4ywwG8SUI8XiKwz7EQaIEtD77dNJLG/f/hpD6ObcXochDfm9Y/ZtS1rKKzmIGDE0s5HdDffkGPypIoyxAAhj8/s9k1Y5syemnI+00Mw3DxQJXW9iQZ3ygBt5+jZ959ljn5gjLDjD3JJs+H2qKw3dd6Kb9AB0yRDcb09EKx/Ao3kBRyPPrHvghMR8PuX8PRBG+XRcOQ/WC/zLxwph42S+4VjhxGtgQP57IvBZlLPQEQYSYWSfDWSVRAvIzxVNBg2GZ1rXIv0sGIFyEg4Bun4pPSFIqX167lt/JwFLGLadzzZNnszMMXwBQ3A0lAy2IF1d3Z1WpAcbZrZltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K76jos5rFjx3nbbwO5hJT4unz3GgnT+ul6bP5andw1A=;
 b=oyahYU17K44gJyxkTzAwRfTnG8MvPcPNhsrHyk+wCbj97gczO/j+mdCMkJB61Rrp5bzmwoVcp74UxDbcpywJrfqwSTzLClQMkve967bXo44vKt7KihqyWNZtl8P87CeDefLkk5XwXGWT/CG7Iw5UaCOLZH0bt3UgoHU/4G+KCXKHUSX2irQ2sZSgGp60vVJo28Vjw9uYPHT64YASupfa+U9UNiHoh2em0qXTPYA7tR2XaPP6xyA4GQxvelEEmxBXWkodgrtz+ZGzfCUiQpXJF03c3f4Sb6ccCl2PlVjRfbfRJFQpSdr/yo1OQWdtnghichipcd11U56OzupEWUhFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K76jos5rFjx3nbbwO5hJT4unz3GgnT+ul6bP5andw1A=;
 b=BFX2f/G7Lc2z3mnX4pC/Ar/2cDbfSv16pi9QZI6DBlWES+7HEvZhRiidhHgpnv2q6ZHoo/AWB5u536eZ5KPK/2r51RMy02ghGgORaKyc50zv8tTqZNlVZekcVwYFAACQLSZfpn+ZLxclrGOa25SNliZ7Bn0Blbd0+Ngx9lPdxTM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 20:53:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:53:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "mjanes@netflix.com" <mjanes@netflix.com>
Subject: RE: [6.18.y] Missing TLB fix for 6.18.y
Thread-Topic: [6.18.y] Missing TLB fix for 6.18.y
Thread-Index: AQHc2/47DE2tGklf4U+NVI9FtwY907X+ROQQgAxqw4CAADDdoA==
Date: Tue, 12 May 2026 20:53:47 +0000
Message-ID:
 <BL1PR12MB51440378065158CC8EE2E267F7392@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
 <BL1PR12MB51443EB4D300A93B30F97AE9F7312@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2026051233-street-thieving-ddb9@gregkh>
In-Reply-To: <2026051233-street-thieving-ddb9@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-12T20:51:35.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4449:EE_
x-ms-office365-filtering-correlation-id: 2c088b3b-ed64-43a3-97fc-08deb068900c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 dZe8Fd0aOPmBFawJtOpyvRqCYeFUyru4SzQgxOlxTMMdU1aL8t9qkGH01TVnYzOlJXmu1lmTHjiDdM7JGs8pxl/yJTSKp2LcYkDK2vHPR2iUqlNBDoGprKbozlPk+LwsH+hdoRxZf1mfi0KtfkdeCArKasoueHyGDG2VXtzVP300PXroy4Usvq+fNQN+j8ztXU66dCP+iafLcy3zp9lGuSk5zHaq4ZfuvfBim0bK/r7bIj/8nAyH8dONH7kiOs66uXrW2SoIoSTKSZvoJKEugpdpYlb/JR3qEGKPB0n6W1TvcB0RTRnB945FiOVPT1eEzW/SjBEGzuiAhcGt7UIXay1moD7blX6w4CJsOAR/6KfjDM970BdI1D90QwUdEFf3vT4kZ13lNUh9ewvDE4FoSJeSZL6a91Lbt2qmAhY5xD65wgkq3FhGRT1Deny5aBpMigtegiEps1+w70iVMpH6/7gMK7yCa73aiESuBYSFyc4LQ7WVgXj76iwG7NEI/4F6mtNBFEHU7Nl9oYGFB4iHVWMcTJyje5Oe+rm9YVxJkc7R7+7yFWXM79mz+OpddTBKrUsqtU/JNMxb8UEIsinNgmuE12WTWz83dM6QXblLRWTZXRvcgB5QlnFMLulK2+GVz/qYcxD8wwoDMFKRt7PD+Y/ymM3TDuwdUM8wzHVF5JeKQC2eW1oOTjsaQyaRLi18Sg0BxLgqSufXG3GkaZLc3PxD50WtVyg79Gy6xHHi7E86SX+Qke0k7AJHTvX0AbjU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3zj8XD7dfOvnty/c8cGQvQpxjGPUY1yAuUk89Js/5hM2iCH4cRnRASB0pmXE?=
 =?us-ascii?Q?Zy/YkTazAXMszE7/fdDV0vGmOCFG2XepSiRanG8Unbmq+SP7+6YxJJtHdjPf?=
 =?us-ascii?Q?Nxa/CHbTHRuBE9Cj5T6S6KYqll+4cvLMHPPwutOjaA+xxPAWraIcbj+w5VWJ?=
 =?us-ascii?Q?g/DnG5WZHFI0sQnmmR9cCb+4mITYGw03sgYWSbXDn0XxrlV2Vm9JQLvlkKRD?=
 =?us-ascii?Q?jfi9XUlBxLwxXE7tK/tu6tbkXqZehxSpBXqWcVqSol0gRmmxodTwsWjkpJJx?=
 =?us-ascii?Q?qV/8aZ++SqqpQ035YxXp5tkA9eefZsZlGkZ2/BimxXvugeLHVnp0nY9Qczh7?=
 =?us-ascii?Q?UR++AZ+HLyr0YGadzK5PMfzVBtrIWMZ4GBWqcAj9pjX69y15ZpraR428BsRl?=
 =?us-ascii?Q?XkrniuGjNcMRAa6sCsIIUxaKz+WibY3DdLHyEq/vT0NG0xZrXDur53/zNpx4?=
 =?us-ascii?Q?8un5kkzzBOe2OtwI8kg2Y9taCSVmfUJWoT0Ocsuw+OrFjMiQ6LUaitMyuQPe?=
 =?us-ascii?Q?tEW8oVL8ZrJ/2kSc2F4aCvQpzWooza1dEbduITzVwvN4Qba8e8EWhtqRKvuI?=
 =?us-ascii?Q?tfT4/2XrmNfXPhr6skEUElTuCDYq7ylTql/Fah/QHGDtlFQwOkJGJE5lLoNX?=
 =?us-ascii?Q?Kdv03BRfBmV6isM9GtJMrBU9hfP6NY5G7xGPum/4FVIIyDY7mYeu6+6UFp7v?=
 =?us-ascii?Q?8NfliSDu+39Be6Fp/6qHBqAS7z7dYnGGGUXAiYbMbBzL7sGohnMZf1mYhKqI?=
 =?us-ascii?Q?i5MM4jOz846+QjBzgWG5ziZ1cX2nvm7VSLmZhbLtjBtNdmUUDssSguzSVsau?=
 =?us-ascii?Q?OPcUcYVCsdRIHDZEmzGGn4yziKaJepQnUSnN6XyMzKlb7zbe27Ra0e0X4XCy?=
 =?us-ascii?Q?DrBP/IaQPw388SYJyh19E2mbE0dn0KYFEltRipQfluxcnhrwLM80O+RoWMVv?=
 =?us-ascii?Q?sTOYZPiUM3dtpnAGMG7B2Lh5uQC6OKs+E7NUzm1Gs8Is2jZ2gos2sFMzxu+l?=
 =?us-ascii?Q?au4llcyU1oDyymXBAhVHR/kXOFs8XHbRRlTNQYHOyIWH9cI69DYc3xY5RrEH?=
 =?us-ascii?Q?ANGzeAwuxn/GYR7DljXaeYjmImYNgsa2VHIdpNwqevKT7mP1FzD/kDoiSA7S?=
 =?us-ascii?Q?ql+d3pe5Tkct0+HaFBdvyQnHGseO8A2e3S/DrN866q0b4dnWUjk498YBKNQF?=
 =?us-ascii?Q?j5Fp5tiZC4BwBAAcNzIAzSY/qYRbquWXtxuJ8em8GKhH+NypsBg3aS0CpLZf?=
 =?us-ascii?Q?/XnG7sH7Yl7BM+oJgg4ekoMcZpSS+hy8lhCTHYGEazf8JUCsoqp7SPa3cUrT?=
 =?us-ascii?Q?5jQu1ifPO7ddWvebfxdHCOvmOF6NnOdu5xocHelkYgHiPKevpyhRmaEhbp2v?=
 =?us-ascii?Q?PYq0yfk4es+XgQfy1pGEfZxoGfBIBHfKVuK1BSx94Oh89vyEPIbrmxIXZ3wf?=
 =?us-ascii?Q?IbYgq+lSEh8gNgKNJgPmzJKd777hBqw9L2oGJ48gR8rJOVw32Pe2asrtUoBm?=
 =?us-ascii?Q?Pbwic4dvLNND4d15BhzHCtjq0w0UDOOrqq7RSK1TSqKC8JxSvuQVwXfe0Laf?=
 =?us-ascii?Q?D1U2dylh1yfyXxNxQj2AUC0QxbcM7Sj9ti6PfRbLHILqW74SSRxSzp8ffoXB?=
 =?us-ascii?Q?T6ClmcxzU4Ic65hd2olB8r/daPl8l94no6I0anK4XE91M6sqBkAZuxIrhmlp?=
 =?us-ascii?Q?3xJYdjbPtdkLaRxTY3IndLRcrRHbmvvWgYk0vPkIQ7GRYU8V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c088b3b-ed64-43a3-97fc-08deb068900c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 20:53:47.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClEDbq1yUME8Y185DK/BJ6gN71M1LyXRi11P1XSCGmmAi3I1J9weQvg9ITJNAwffk7amJevqRc4M69vCCjw11g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
X-Rspamd-Queue-Id: 92452529BE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246676-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Deucher@amd.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,linuxfoundation.org:email]
X-Rspamd-Action: no action

Public

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, May 12, 2026 1:22 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> stable@vger.kernel.org; mjanes@netflix.com
> Subject: Re: [6.18.y] Missing TLB fix for 6.18.y
>
> On Mon, May 04, 2026 at 07:52:21PM +0000, Deucher, Alexander wrote:
> > Public
> >
> > > -----Original Message-----
> > > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Sent: Monday, May 4, 2026 3:43 PM
> > > To: stable@vger.kernel.org
> > > Cc: mjanes@netflix.com; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>
> > > Subject: [6.18.y] Missing TLB fix for 6.18.y
> > >
> > > Hi,
> > >
> > > Mark Janes noticed that commit e9f58ff991dd4 ("drm/amdgpu: rework
> > > how we handle TLB fences") was missing from 6.18.y.
> > >
> > > This went into 7.0-rc5 and was backported to 6.19.y but not 6.18.y.
> > >
> > > This is because this was one of those cases that the "Fixed" commit
> > > was in both 6.18 and 6.19.y as different hashes:
> > >
> > > b4a7f4e7ad2b120a94f3111f92a11520052c762d
> > > f3854e04b708d73276c4488231a8bd66d30b4671
> > >
> > > So can you please backport e9f58ff991dd4 to 6.18.y?
> >
> > There are missing dependencies.  Please cherry pick all of the followin=
g:
> >
> > f4db9913e4d3 ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
> > e3a6eff92bbd ("drm/amdgpu: Fix validating flush_gpu_tlb_pasid()")
> > 9163fe4d790f ("Revert "drm/amdgpu: don't attach the tlb fence for
> > SI"") 69c5fbd2b93b ("drm/amdgpu: rework how we handle TLB fences")
>
> In what order please?  Can someone provide a list of the full set?


That is the full set.  Please apply the following in descending order:
commit f4db9913e4d3 ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
commit e3a6eff92bbd ("drm/amdgpu: Fix validating flush_gpu_tlb_pasid()")
commit 9163fe4d790f ("Revert "drm/amdgpu: don't attach the tlb fence for SI=
"")
commit 69c5fbd2b93b ("drm/amdgpu: rework how we handle TLB fences")


Thanks!

Alex

>
> confused,
>
> greg k-h

