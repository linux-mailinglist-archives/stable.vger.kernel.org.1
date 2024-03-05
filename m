Return-Path: <stable+bounces-26716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA168715EA
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 07:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB56B1F228E4
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FE1EB2A;
	Tue,  5 Mar 2024 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XTOsaRe5"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1F2595
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620679; cv=fail; b=QwcuPjYvwi82/Ph2LGH5somwxyZ8/0vHQEf4Y5RZrp1vr1myn+fKXxNRLYFsrd9YICl5fgP7Hsn4anJQKaXXHZGICf7N3baGNsiMAQRih2rsPRUziBEdA4V4rfohVHFSm3MmfVlI5YgTxbaVADKqxalnfJxA9Z6hmYJyuUh4Vq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620679; c=relaxed/simple;
	bh=CAI6XYQwa8aZwKdrKKsS4iiYlMyfUe/g15RwwrwER+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V66s9Pp8nWYFXRq8lLmglDVX9f6+xpJh0XwiKje640YZlkxZD08QCTa1IdHus5Kf6gOEHb4QGtMoYDImRDD5g+jMsjsUO+mXZ3EG0oP9RvpXorI1E1a2EVVBO1oha9kYCTe0EjNBwpmepawsbMOPyHMW3WsC4Q47azvD5w3+gqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XTOsaRe5; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbQUjfhy43vfvOA5+3y0zE8Lp7MmOFKx44eiEUUpSc+kThiVJ++oy9/C/TslB1deLRHLt+aO9ivjuq1qrG4JIyt3yOgR8FoqQwfTGZScko+zG36gLf8onWIMxOTefJ9rFLEaiVpe9Kn3hL5MKR8Wk7sgxvrPrEYBLk7H5KPs25PYN9wnrUPFGUSA5ujgM63RO2EqXxi34vEAYwX8KAefd1w1v7zmtFej9NDF8SEaqWlToDknT98CsZZvXku5GdDw/CjiqFTZ9LsitIrh7UNBVXVlhuWnibA1KkTgqgPPqlZx+KnmMiCe/nPTHw9/FEH3o7y3G13CcQ0qYzk1Paj59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fN63VLYhjHL4oZmBjAmnkgPDiR+8ishVO/HUaZx0kc=;
 b=nSM83Iq+/0SVLBNq3svaVvzVnKf/nphx0/Xr4u2lgvGBoCzWRKMWts5eD0VfxylNyNlQkKDVUbK6Qpe9snCeNYD+BTqwIGRvGBkM7NWoiCUCwNXL4ZWh5ARDDeFm6KO346Qu3SraQN3hXQEYjMmi6Qj5Ljuas9RZbv27Hojh9srxzknRUUuYvZ6SycMo6dPnX7FKJ9I8JE7gGkGUpUfkDju68RwW++o9I/UwZc31rH6c82bLoCkdfk/a6XCWr2VPcIOIDhYpoWhZuGc2as5VMQMVox7+bAwFCs4wzIt5h8FrqHuZn4ydwH+KUXbc4OoU32XjrKrsFHqsOGm2khHk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fN63VLYhjHL4oZmBjAmnkgPDiR+8ishVO/HUaZx0kc=;
 b=XTOsaRe5Hjnb56AoGxCqp+grq66D8jZjHMgpFU6hrysNefLn3+DjT1hcDm0hoPTVlXPzBy1oI3ULJQPSLs2Yrh+5cVX3/Ox7uJJeYd1S4wql9pCBR+smihuT8idX0d8s77lIXmWCOTlCcNYiBpZ1V7FIA07bCKwqqZrp8ayYlcyyGKZAFwvI3PBjpi3t2dP20tk4m2zg15K823uRfCkL1trNonp2mCw/S12XHJRDv/XrAzTbIWgdBr1vzFL3RoLTCtu7qpbcyuvHTKzdGadV8HjAK2MXLl7pz4qmB9yCKe2+XmCvBsJ9cwuuRPHnAUzcm08PN5/POo8U487Fz+R46w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 06:37:55 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:37:55 +0000
From: Parav Pandit <parav@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "NBU-Contact-Li
 Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: RE: [PATCH 3/5] virtio_blk: Fix device surprise removal
Thread-Topic: [PATCH 3/5] virtio_blk: Fix device surprise removal
Thread-Index: AQHabsdnKfJWOC74m0KoOQ1+JVkJVbEosXnA
Date: Tue, 5 Mar 2024 06:37:55 +0000
Message-ID:
 <PH0PR12MB5481CA9464832EED45B2FD59DC222@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240305063538.2511-1-parav@nvidia.com>
 <20240305063538.2511-3-parav@nvidia.com>
In-Reply-To: <20240305063538.2511-3-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4203:EE_
x-ms-office365-filtering-correlation-id: e20b7ecc-b5c0-47cf-7abc-08dc3cdeca1e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oqZB2/gFxwxKzYbJa1+jwEhVLRzfIHX3UAqvGgc4BWGyB+Ehj1ASeCY4XObMIvGZx+OBBERDXxn18kD+0hXWiYM19B1QhAasYASU2Nyf7aQvu/KAzXONOFDayDfCKzY4O8sgya/+CdrAedmK+zCa+z7U99KgDcXEHn3A7dtNkkbVPWddZT2D+xYpitUYi64TFiFozdL309nUMg0w88mRdb/q0hJ/1m8LFxd66TDUQ//EFkl+PcXmbB8gBPswVaMqA2FrzjtoqFV/QvGNLxFnanMZOZThci8cTkbBxvXPc34ocRAg1wv75+iB/lyonAa6vrCSJk23t8pbWBZ6MGe7OX6uxuaAc66o/9KGTegK3XPe/KbFQlHztdDvsJiPH1U025MjdAhCGcF1e6yThDB+84GorORcHb+SUj+1aDg9IYeZFhcXwAkBWvJ4fnOMIZ+YYFBhlFy4WlhZgeyOafW2W82BgMOm81pdL0ZRLp4uuOquVEL5cxEMdgagMGYvNFxvou9UUnzBH5j/kmp3OY5cMP7fSLFS1LccrUKxdaNetERwNeElVHO338ZfbxScP3yqHmfW5Fm6Vi1A8m9OkwXj1EsL5Jw4QBG673706zNL1ODhCQbaOC4MpIJOpBkUXokZ4Bz1cdzuJTDlTD7R88rtD3jeY6t29icfXblz9O+h0q7tjbbhT5OwuUXyX2JTLqcvw5sh9GtU1ItAhvV1DXczJzPPUJDwTfMHAkqEOxmPD2s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BAoR4mPVUcfTD5cRAR8vxPFnYZ6TTioYp4CPm5sAl1q3EJ6EvdNE34zmqhfZ?=
 =?us-ascii?Q?bCL0ugY/weRS8sWDlWbnOS8eF56mPrxaoA2MosdbigsvFyVUhoQ0N9WiUYRk?=
 =?us-ascii?Q?jL9QWUgQwMPmQnXwLZeEa9OqWAAxQC5fFb3H+gbiUV9BuVMh5cFbYpNfONb1?=
 =?us-ascii?Q?ZJftHbDonPg0U3uevZsIS2ECPePvMa/tDtm1CucKJwbdJG4aA/ZWddZiRD6F?=
 =?us-ascii?Q?lWKh7Jc68AyT9R0MVkHqZeaSPUXX3YkSZqr05pFGFonUr3R9chkyiJfH+Zd0?=
 =?us-ascii?Q?d9JVv+p9mxFbkGlcRv1XxgGFz8YvZWFG7QEaujlnR7R9WlkfHSDhx2zKfZGr?=
 =?us-ascii?Q?y874BfR2TMkSOdW4efkroMaqP4pl9MdKluIrLicHZyajDj/UImMr8SnGjlji?=
 =?us-ascii?Q?YUoOrlVqVslvhzSwFwdTcbMxsMRt7S2ZMveVdNj+QygEbWvLtuDyJiMi4Ppk?=
 =?us-ascii?Q?xTyhhfiwbv0vw7hU7cZNnSToKt0aKVb37Dq5yRzoqnoGu2yoN2MHKrypCVlw?=
 =?us-ascii?Q?VRBxKQ87D4yZY7KqG/xJY7qTYv5dffUeA9e+xYCMbCTA2xLVnp+kpAZJrLsP?=
 =?us-ascii?Q?D5miLkt+OAtJ90lImXw8wpBlpOtdW7jJs2l8KmI95OtoDO1NFB/lcqxy0kp8?=
 =?us-ascii?Q?5gjPmw4QHAecAPr0Cj0h8v0+K3UmXOqHQs2soHyrsyEunii1aWo+e/Z7XVcB?=
 =?us-ascii?Q?7fV9JzFve0IMSumlMr05/ktZRQvv1mG9zCZgfvuYcSVRzEnn7TEuANqnEWIR?=
 =?us-ascii?Q?Q4MsIeBh2r+QVNs2mOvNe90NiMOFtIh8IS9A44s8rq+y68Dnag5ig7ys1szH?=
 =?us-ascii?Q?0YppJprFqtvr5vWzncgY3WS4yX8V1mmgiP63WJthHr1+5jeEmXYflaNmJFaV?=
 =?us-ascii?Q?U0l5CBGweAtiq6vNqn/G8OVGUAC+XsHUwk9XgKGiebYX5pH6qsNJHdFTzncC?=
 =?us-ascii?Q?h0+d0ggkMwlRKR+a8vnHJyu+frzSOz1NXfl6Qun174WBQmDmIO/06XRGkcel?=
 =?us-ascii?Q?sTHChWIZ0thGN9URWBdUpVZF8hazQH4maNX8tWGyrSG9xwAyK7HLcJwL4hPx?=
 =?us-ascii?Q?+dqgGBmMvr4IaS/GOLsbquL9F348RxNRTtj15wg8MNeC9Ex4FT1z9RRDGmZl?=
 =?us-ascii?Q?NHejY9F4deBD4v8E2Pd85IgNPY8R6Cc9CAdrksJpmP0oVx1EkyIs5J2MRe9K?=
 =?us-ascii?Q?PflWo0enu1BDzCPUF2hjgYKJz45lLMjniltVXine0gpwhQ3Kp+uMqXPllUBx?=
 =?us-ascii?Q?fjXstOCcL0Jju4ejbpqNGlbS3RMhC6WWL0wCbcAwJDj40wU9rAi/EWEafgRE?=
 =?us-ascii?Q?Ks+TphTQQ6egQSNgFt2VQ8rBQyZBk6Wk+B/y5vF5eeGdks08MrCcQocYkITi?=
 =?us-ascii?Q?cw22d/CBE5BUZXi1h9VglGOfRyEttsRkOAxr1v+BJh5OZkx9tMDQFx9aCRsY?=
 =?us-ascii?Q?hPeASbzsRHxA6w8SzcOd2FaqEcCZPjmPSMINfhoolelUNo60x2RWQh35mgFt?=
 =?us-ascii?Q?4SDodVYenCdqfoEkeszq+IP9xUomyOrvBFdRUaV/JgcB2NF9ufR++oHy10r7?=
 =?us-ascii?Q?A8qhYCzmW+3rA5MPJwU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20b7ecc-b5c0-47cf-7abc-08dc3cdeca1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 06:37:55.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUy+P9le547AP/1I4Ytjrrk/Afd7Px+1oQUwfBOv6ZnCMrCpy8bHxce106zpyiHDf837FW/Tw7ucnU3PvZ5AzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203


> From: Parav Pandit <parav@nvidia.com>
> Sent: Tuesday, March 5, 2024 12:06 PM
>=20
> When the PCI device is surprise removed, requests won't complete from the
> device. These IOs are never completed and disk deletion hangs indefinitel=
y.
>=20
> Fix it by aborting the IOs which the device will never complete when the =
VQ is
> broken.
>=20
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however timeout can tak=
e
> very long time. For unresponsive device, quickly completing the request w=
ith
> error enables users and upper layer to react quickly.
>=20
> Verified with multiple device unplug cycles with pending IOs in virtio us=
ed ring
> and some pending with device.
>=20
> Also verified without surprise removal.
>=20
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes:
> https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741
> @baidu.com/
> Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---

Please ignore this patch, I am still debugging and verifying it.
Incorrectly it got CCed to stable.
I am sorry for the noise.

> changelog:
> v0->v1:
> - addressed comments from Ming and Michael
> - changed the flow to not depend on broken vq anymore to avoid
>   the race of missing the detection
> - flow updated to quiesce request queue and device, followed by
>   syncing with any ongoing interrupt handler or callbacks,
>   finally finishing the requests which are not completed by device
>   with error.
> ---
>  drivers/block/virtio_blk.c | 46 +++++++++++++++++++++++++++++++++++-
> --
>  1 file changed, 43 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c inde=
x
> 2bf14a0e2815..1956172b4b1a 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1562,9 +1562,52 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  	return err;
>  }
>=20
> +static bool virtblk_cancel_request(struct request *rq, void *data) {
> +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> +
> +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	return true;
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)  {
>  	struct virtio_blk *vblk =3D vdev->priv;
> +	int i;
> +
> +	/* Block upper layer to not get any new requests */
> +	blk_mq_quiesce_queue(vblk->disk->queue);
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +
> +	/* Stop all the virtqueues and configuration change notification and
> also
> +	 * synchronize with pending interrupt handlers.
> +	 */
> +	virtio_reset_device(vdev);
> +
> +	mutex_unlock(&vblk->vdev_mutex);
> +
> +	/* Syncronize with any callback handlers for request completion */
> +	for (i =3D 0; i < vblk->num_vqs; i++)
> +		virtblk_done(vblk->vqs[i].vq);
> +
> +	blk_sync_queue(vblk->disk->queue);
> +
> +	/* At this point block layer and device/transport are quiet;
> +	 * hence, safely complete all the pending requests with error.
> +	 */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request,
> vblk);
> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/*
> +	 * Unblock any pending dispatch I/Os before we destroy device. From
> +	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD flag,
> +	 * that will make sure any new I/O from bio_queue_enter() to fail.
> +	 */
> +	blk_mq_unquiesce_queue(vblk->disk->queue);
>=20
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> @@ -1574,9 +1617,6 @@ static void virtblk_remove(struct virtio_device
> *vdev)
>=20
>  	mutex_lock(&vblk->vdev_mutex);
>=20
> -	/* Stop all the virtqueues. */
> -	virtio_reset_device(vdev);
> -
>  	/* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
>  	vblk->vdev =3D NULL;
>=20
> --
> 2.34.1


