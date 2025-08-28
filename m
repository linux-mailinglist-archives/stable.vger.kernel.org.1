Return-Path: <stable+bounces-176566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66872B39478
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703C41C232A3
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311162BE7C3;
	Thu, 28 Aug 2025 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vpeq7rri"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672051E0E08
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364371; cv=fail; b=i9atRIrRTksJsMAlNCud2Rh4haCD1tcZUk42silZFBTAxiVlJ16tFfiUSJFejQXSgLT9J2y2Bh9V6XJv8FSEHBTPJfSksykrxFaKwL0it4KngSlu4JhLjFF5vGkxDR4+ZRQ22NETFr07+z+K5lh93hAJOUQ4717MxH4MDMQ9NhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364371; c=relaxed/simple;
	bh=yRobw9hi0pn4TbxQ7CNwqg7kPRheC9awJsqZaBwFBRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tALvIdPHpGk77az3/w4JUZ0m84iDW4ibAj7buCOxZLpXqaZYipR8FiUawsJKVrZuH6olj1FXE0g2bwCB36Mh/4ke26bMQ2hF3iVPcNN4NZBg+hHBskOaxI5PubeX3pjsH3tT7b2Ji/RIvWfDXDALDK2UjyPv+PuKKnh9mybYIF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vpeq7rri; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsFkn76q/jixTmlsJovdPu8U77txR00sVkh+ct2aDJRvJBQnSpZayMIwcEPlEmNf0u4VA06QboO7If4GQJWHxxJwUV9wJgFBwiO339DHDIQUxoQ6La5b86jeYKFkC0coA0nTlbp3ktJVKKX2b0bJENc4FxcDDORxaUI8MrHlv1TFyiRRCFguPOKSu+/Cn8RhZhaFOcYpPxsYEJ3tI/WMG7nDnzTa7abJYFtEKw+CwPwQiKOxVwSv4TSOAJWAmMifbObeDAcx9q+KYI5O/BtBiPjR53HnuhhoJpu0U4ozfn8PCG2xZ5OoTf973iUWC55naPWgXY1gQyvBmksfBW6rQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y47kv9ln6zd7fTfzJWp+XGDj+A3ha9x13frMjymD4cM=;
 b=tDBPLWX7dwIAjyWdHZrbaHnze3wtNZkNDHLZjOa6YpmE9DwOOqCnZpsYmYLi5Ue1xFtiJHtbIr2YD22k3Btm3RNfL8UZr3KCE4A2STeO2VYl3KL2XeK+GLjzX74j/9NMb50tu5Wf/h3nPzMektyyQSF1CI0kYfUetKcXUbggacq8fzZ1Fwphj24UeWh7i+NRXUuKI/3ZAuD4cGigMutcDZ79kBQb1gyq246Kt0sN1Y/ccNIc1VfTWUtCJ6KLOPKhpd2AHm/4hOt0g/S6cJWaECfufRjCL3p3yso0CeJc9IDca/Lwxu6iQwso9f38oArgz9Vm0J0phRem40C8d71DoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y47kv9ln6zd7fTfzJWp+XGDj+A3ha9x13frMjymD4cM=;
 b=Vpeq7rrijOEo2lUu6BhVyuhhh+J8SDC7SI7CdnkY1SZCTRA65D+1lcuvIgLpniugLciOqkd4Xsfnm6697p4XQuSCHDxgR/G4kM9nijK9sxB8gSd0o2qGTSRPrvhprAz/np9n8YirzuUH7ZPfIsjMiCDCXNifAF/aqt72u1SFgtUDZ55ckRplq+FBIziS6A3+I6K/V/UPmbIQLqkCsYGd8fiHwBm1CQPD4eS9G4MNFGAyP1iwz1PM24bWqF5qcP2CIwvZiqp27//wF+9+Lh5PVqRttHM+tBGd9GDsJk3EUWr7j7vVd2ar2mkDM8cr4vuzxyI3VU1LmQqyGriwxW7+7A==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 06:59:26 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 06:59:26 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: RE: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index:
 AdwTTxd+YdVEFNqzQBWcarw+isQ7dgAEGgsAAAF2L4AAAZBEYAAAb+MAAEx3t3AAGRJRgABs+xOwACE6ZgAAAPkmAAAm38wQAAKB44AAAC6g0A==
Date: Thu, 28 Aug 2025 06:59:26 +0000
Message-ID:
 <CY8PR12MB71956D1AB42BFA9BF19AE134DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
 <20250827064404-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250828022502-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250828022502-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ0PR12MB8091:EE_
x-ms-office365-filtering-correlation-id: edcdeeac-3336-47da-3f41-08dde6006d80
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y4/fNK31aSqqj+/SY5T/3TWEI2vcBu/wu2/qqHqBMwDA/olsQtGLuGQimc7Z?=
 =?us-ascii?Q?xqeXIhB343C3PDWOLJuB4emlrup2NGLYUoLrX3TYZuZa5NzTvXMnErvxOID2?=
 =?us-ascii?Q?d27qNbRc764yM9cMYKtu0ioH33N3/Yoh1I4OGgDwGXZSfBD47k6xJ6830olC?=
 =?us-ascii?Q?NoigP35t02x9qzqxt6oZVTzOg69Y3fQuquhy1LVGuaZUw/VC3kn9WPlsNEet?=
 =?us-ascii?Q?Yc74Yi/wAYrCuoObmj4CUSD3PEKaWL5AQYnQHVZv51BgaFXYZy/EMxci/cpD?=
 =?us-ascii?Q?OMZvFcLdJZbkDsV7DHoTdB8lF0EAKibh+fAl1b0usJq5fsPp6SyTHSVFyiyi?=
 =?us-ascii?Q?fvJRr2KZ6DcToehDVs4LIgK0wLu0BuOWAEzdvaiJTdWiizmdbVW90b2MUesP?=
 =?us-ascii?Q?kHxEQ9pk+bbiDarRIxSmBQa/ejLl8A/eqHIg4b6kbfz/smYprwi6p3LeaTXG?=
 =?us-ascii?Q?j4RdXsN5Vd7UV6SQ4wsrofRJmW0hmIDZPaZF9kl6M+Sp35BoYc+cL68EvpmJ?=
 =?us-ascii?Q?N52CK67rvJMKZz7rUMQHSSrwrOwwKrlcY9Idh80wgLrPpZm+E4UCePmyGiaG?=
 =?us-ascii?Q?6LHyOdvpPelBPnMsQvU7FyUCgBImv4P+yfwTvaYzZN5gOnEKs24sM8X53XId?=
 =?us-ascii?Q?Lcp8YoffqBj/+a/oBkWOK2WYHBYZyWSYA94S3Da0VAcWUQrzd9+kI4O8/4OC?=
 =?us-ascii?Q?jxjnkJFBPJOv4826RNBi0Q0/tzjDduuPAHVLob39YOMfycXRADz3WxvETeqZ?=
 =?us-ascii?Q?NtAeqJPxNFBPZ+bk/pCFmS6++38YLRnNHWkuU4fSehn3BhGIJ63wh93YxOkR?=
 =?us-ascii?Q?RnCdN9IItJA1DtGKqihzGLfiSAZOVj8MJkWRGpT0yngKMp1fJRAdFPAh6cSq?=
 =?us-ascii?Q?wpMk1otEl0D9+4fx5BLIbvWVgta6kkKV78ISS+Qp37/om1sC80C83fDSZ8Pu?=
 =?us-ascii?Q?bMuqZ+my4WYerk07iySCtfAVgSN0TeL/mSgtlu7OybA3q0W0nWkTaHji4nh4?=
 =?us-ascii?Q?l28nKaD/bKgQKuhznk1omZSp1aOAoM4Y2FWkvFh0FvEib1c9zdqrBfAHM1ib?=
 =?us-ascii?Q?W4ClcIlDYAHKh04CjDmDGZtdehgVKuDm3aC+OHQ4XlaEEVLLPe75teYBYRbq?=
 =?us-ascii?Q?tSJAv2Ly+SgPGqX7QBxS9lXudwnuy808ALQXOzW4CM85XNd3kOMjU1do5AYj?=
 =?us-ascii?Q?u837yMUyrafw2fMrpsfgyp4Zv2TsoD9Pbc8nHIZGJV56d4ywp+b2z7olMgHA?=
 =?us-ascii?Q?gKkiOafh/H9PEUjQFYpPJvrRkkwLePQKTvQQCXG5onW2SUSq22rN3fye7+Wg?=
 =?us-ascii?Q?HIR/rNKFnZr2+T6wixAWXy2sn0qfpe5SyAFRnQ8uXZrV+zjEqMNLaonQeMVt?=
 =?us-ascii?Q?5goK7v9iQajO8QyPm7EufSPccWIox1EKjZRrArLalPFXYT0YWUhmWWYQYchC?=
 =?us-ascii?Q?4Y+nHvjNmzElrQtqKbt3od/GeHtnfRD9mSLjPsa09i9drlzIqIPvAQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D0seege/hNXoBpobk+Nt4UT+H26O3AXQI98k3kISyp0H8IN0sVDx/IcGTP2S?=
 =?us-ascii?Q?v4JwfPldUqg5oWRUzoIjej0Gd/Upd5zZfTmTblq4lz/orq/19cabPetq5Npa?=
 =?us-ascii?Q?YgtN99CFKILpC8UWED5TO6sbQ5e/wgfnVF2KKQU7/SyabUAdVGXr2E9vApT7?=
 =?us-ascii?Q?0xc2zns8E8UDnf1Zkgwb0ko0TQyxDEjgLepu566g5+pUSC6fZLYbOIOLFsX+?=
 =?us-ascii?Q?pj22l/RRlHX1fAOt/Kl4luj/EOQtyY9zH8lRN6p9F98ZlxqsBnDnYA9zcJ0f?=
 =?us-ascii?Q?pOn30L5gmBdQSNIGCvazI2IAN+z6cs19M51n0B1nZgbuPvuEwYmGFI744AFO?=
 =?us-ascii?Q?ncZXQE1EZqGiHO4Hlc1BN34HTvBJ40u4B5ZiQpe4WiaM5ez28FyqDnkdb1ue?=
 =?us-ascii?Q?+m+TLL3rOI4S2IXf/aQ+nVfZRya1x0wrl87yG4XNqf9Z0d7QG2D4/VU+2Odc?=
 =?us-ascii?Q?8VFI+6HjMS4ACR4Sxz6CUTuG4XoX83sUWX/oo0aAnWDXNdajVExavHosbonP?=
 =?us-ascii?Q?D9NckWHn05A3O6LBriF9MCh1cuALLClAeTzIapS660OpOgYja9uV6W/edBWn?=
 =?us-ascii?Q?N6qQbP5QBnqhld3fxkjLXurqmI4JhCP36jPfwY5KkiK1+piJ2m2tUTeTOESp?=
 =?us-ascii?Q?ktkNFlyC3OyVNSb6yXvrXy+3bTN6kr2/DaKPeio/2nHYglqVxEA32l/D/OV/?=
 =?us-ascii?Q?bbAKwlaFoCQdxo2yoCVnIub3U5wkRPSwWMU42wP/bpx7kbxWxf6YUyucyWNr?=
 =?us-ascii?Q?G8bGOuYtrTUpgBn3pBuHqkZUlCwUeBupQTvuxENSfGvFpwYDedT4PYL+uHR1?=
 =?us-ascii?Q?rsTIvg0ESiNpRlSi0PRLr3zVK9Y+cQLgpEKogQ2MI/V2AaHYU0oxTGsMT2kY?=
 =?us-ascii?Q?XtLjn8/u+77IxpCFfL9OsXqw8vzF1z3eHIsZfTJpa8HcPbEdkw5GqTOsT/UQ?=
 =?us-ascii?Q?zUQZU2hQ0nuKuLavgoMcxR7ewwYFpC5xPsVqNZpGTeS4xAfKi19LkWDnJhpa?=
 =?us-ascii?Q?ndNjWbU30uPl2nIwP4UCjaCVlvNYuw0/cDQy8VfZd0f/P8m8HWS+pmtky10G?=
 =?us-ascii?Q?DFy+IZ9mPD05uqxxngpFm5W1zWO4Sf27GJwwLKKdgW86419la27UJ+p00VZ5?=
 =?us-ascii?Q?p19SJkriM7RCI+J2oCWmjKJ9BGOBanYBY7j5LnkW0L5CYfIUwEggrSD+lcT9?=
 =?us-ascii?Q?N2laqNTaes2h8xZvo6x+WDxMbJKW+4CGACJvvSY3Ba6kyCTCO3nJBDmUdEZ7?=
 =?us-ascii?Q?OF+ZhQREEDuBmsRIJb5v1eONgOBf/SCzQQLD82xC9bWrS1CP6npq5WaRkk2E?=
 =?us-ascii?Q?8Q9qflwbtQdwZMjB9/p6rD5214vCNUqvE+EJffDxBVNk8Nh7b5sNElbHFwlR?=
 =?us-ascii?Q?TpdDUlTBTexJdTzL7IqC7WOOPEJ90nh3LPZvoIIqxSIcOG0/yqxBnwKfG/OR?=
 =?us-ascii?Q?7n9OLV1plrBTBoKe8ksX4z9AmeuHLlylCV2lhqC0nTV6IVjGXuuxlYRMYXXk?=
 =?us-ascii?Q?a4HWF2lyNVz3kv+dnDwxyUCW3rWqj7HddaueEM/mF3UHw+akun/mqm1lfld3?=
 =?us-ascii?Q?A6kTtQbopb9ZgTD6sI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcdeeac-3336-47da-3f41-08dde6006d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 06:59:26.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iNza+pLzQ9IEg8LgYk4NOGNWuXgOAQeTMSfOBNMYgcwCBlZPZb5Ez5xoONcQTkzXH8ktLXnH8u/DzReibrnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 28 August 2025 12:04 PM
>=20
> On Thu, Aug 28, 2025 at 06:23:02AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 27 August 2025 04:19 PM
> > >
> > > On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > > > > If it does not, and a user pull out the working device,
> > > > > > > > how does your patch help?
> > > > > > > >
> > > > > > > A driver must tell that it will not follow broken ancient
> > > > > > > behaviour and at that
> > > > > > point device would stop its ancient backward compatibility mode=
.
> > > > > >
> > > > > >
> > > > > >
> > > > > > I don't know what is "ancient backward compatibility mode".
> > > > > >
> > > > > Let me explain.
> > > > > Sadly, CSPs virtio pci device implementation is done such a way
> > > > > that, it
> > > works with ancient Linux kernel which does not have commit
> > > 43bb40c5b9265.
> > > >
> > > >
> > > > OK we are getting new information here.
> > > >
> > > > So let me summarize. There's a virtual system that pretends, to
> > > > the guest, that device was removed by surprise removal, but
> > > > actually device is there and is still doing DMA.
> > > > Is that a fair summary?
> > >
> > Yes.
> >
> > > If that is the case, the thing to do would be to try and detect the
> > > fake removal and then work with device as usual - device not doing
> > > DMA after removal is pretty fundamental, after all.
> > >
> > The issue is: one can build the device to stop the DMA.
> > There is no predictable combination for the driver and device that can =
work
> for the user.
> > For example,
> > Device that stops the dma will not work before the commit 43bb40c5b9265=
.
> > Device that continues the dma will not work with whatever new
> implementation done in future kernels.
> >
> > Hence the capability negotiation would be needed so that device can sto=
p the
> DMA, config interrupts etc.
>=20
> So this is a broken implementation at the pci level. We really can't fix =
removal
> for this device at all, except by fixing the device.=20
The device to be told how to behave with/without commit 43bb40c5b9265.
Not sure what you mean by 'fix the device'.

Users are running stable kernel that has commit 43bb40c5b9265 and its broke=
n setup for them.

> Whatever works, works by
> chance.  Feature negotiation in spec is not the way to fix that, but some=
 work
> arounds in the driver to skip the device are acceptable, mostly to not bo=
ther
> with it.
>
Why not?
It sounds like we need feature bit like VERSION_1 or ORDER_PLATFORM.

To _fix_ a stable kernel, if you have a suggestion, please suggest.

> Pls document exactly how this pci looks. Does it have an id we can use to=
 detect
> it?
>
CSPs have different device and vendor id for vnet, blk vfs.
Is that what you mean by id?
=20
> > > For example, how about reading device control+status?
> > >
> > Most platforms read 0xffff on non-existing device, but not sure if this=
 the
> standard or well defined.
>=20
> IIRC it's in the pci spec as a note.
>=20
Checking.

> > > If we get all ones device has been removed If we get 0 in bus
> > > master: device has been removed but re-inserted Anything else is a
> > > fake removal
> > >
> > Bus master check may pass, right returning all 1s, even if the device i=
s
> removed, isn't it?
>=20
>=20
> So we check all ones 1st, only check bus master if not all ones?
>
Pci subsystem typically checks the vendor and device ids, and if its not al=
l 1s, its safe enough check.

How about a fix something like this:

--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -746,12 +746,16 @@ static void virtio_pci_remove(struct pci_dev *pci_dev=
)
 {
        struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
        struct device *dev =3D get_device(&vp_dev->vdev.dev);
+       u32 v;

        /*
         * Device is marked broken on surprise removal so that virtio upper
         * layers can abort any ongoing operation.
+        * Make sure that device is truly removed by directly interacting
+        * with the device (and not just depend on the slot registers).
         */
-       if (!pci_device_is_present(pci_dev))
+       if (!pci_device_is_present(pci_dev) &&
+           !pci_bus_read_dev_vendor_id(pci_dev->bus, pci_dev->devfn, &v, 0=
))
                virtio_break_device(&vp_dev->vdev);

So if the device is still there, it let it go through its usual cleanup flo=
w.
And post this fix, a proper implementation with callback etc that you descr=
ibed can be implemented.

