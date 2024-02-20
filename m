Return-Path: <stable+bounces-23242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BF85E944
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 21:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA251F243E7
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFE8664F;
	Wed, 21 Feb 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTjkhKHt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9C85639
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548756; cv=none; b=CUnJJ584OhCy/yecuwBA5L+ZuK24sPEt8QuJARY6EpNl5TzrLhVz7nCbsNx3Rze7SIbl+2IkU4+PMDGia/0FS9WLObPoqPb1I9dvA7qoug4s49MwqCaQj/AklEjI2s4fWcrF96ysccqh6RDNczmiO8rjXMVv3AAFiIA6TjtzFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548756; c=relaxed/simple;
	bh=xgfDMafDUcmEBN6Xo15ORL3SUF/WL2NkQNR5tvM/WDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXeo1x/fWge29/Yf1Idy5HI590QWOlsQAYSz5ZJb6aNGtyTGblHQWuJUOSu160Wnfm+8gdGN1I3k93MEh3N9Dr/DxjlBqJO5i3ianE0MGMg44y9wfySJc2gL9GUq2p/ITgINveJZXC0uROHKS6jIhOc62v9rO/c204m6eVc0qKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTjkhKHt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708548753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j71ZkCWNeOZ8wnhrOdzBq48RrBBlOjjlQIEtqH+HmBA=;
	b=JTjkhKHteEwdl8D0cxhUA5r3oUW0k6YW6TgaXztExULZyErllo1rtnEkwwvFPm0NJGyuHb
	SYcaWa/xGgQLuvvtraahI//eW/bXQPN10+6D+YaTH9JF2FSbqhYvo8zw9WkVxuBMpBwt6J
	h1qOeICaoF32/9VEvqcWv32OD0Ib9vY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Hfy4fv_pOVGT2Sf18fPwYQ-1; Wed, 21 Feb 2024 15:52:30 -0500
X-MC-Unique: Hfy4fv_pOVGT2Sf18fPwYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF37185A58E;
	Wed, 21 Feb 2024 20:52:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 603602BE;
	Wed, 21 Feb 2024 20:52:28 +0000 (UTC)
Date: Tue, 20 Feb 2024 17:05:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org, lirongqing@baidu.com,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] virtio_blk: Fix device surprise removal
Message-ID: <20240220220501.GA1515311@fedora>
References: <20240217180848.241068-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+EsB9gUsZRuxclQv"
Content-Disposition: inline
In-Reply-To: <20240217180848.241068-1-parav@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


--+EsB9gUsZRuxclQv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> When the PCI device is surprise removed, requests won't complete from
> the device. These IOs are never completed and disk deletion hangs
> indefinitely.
>=20
> Fix it by aborting the IOs which the device will never complete
> when the VQ is broken.
>=20
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however
> when the driver knows about unresponsive block device, swiftly clearing
> them enables users and upper layers to react quickly.
>=20
> Verified with multiple device unplug cycles with pending IOs in virtio
> used ring and some pending with device.
>=20
> In future instead of VQ broken, a more elegant method can be used. At the
> moment the patch is kept to its minimal changes given its urgency to fix
> broken kernels.
>=20
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci =
device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca=
9b4741@baidu.com/
> Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 54 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2bf14a0e2815..59b49899b229 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device *vd=
ev)
>  	return err;
>  }
> =20
> +static bool virtblk_cancel_request(struct request *rq, void *data)
> +{
> +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> +
> +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	return true;
> +}
> +
> +static void virtblk_cleanup_reqs(struct virtio_blk *vblk)
> +{
> +	struct virtio_blk_vq *blk_vq;
> +	struct request_queue *q;
> +	struct virtqueue *vq;
> +	unsigned long flags;
> +	int i;
> +
> +	vq =3D vblk->vqs[0].vq;
> +	if (!virtqueue_is_broken(vq))
> +		return;
> +
> +	q =3D vblk->disk->queue;
> +	/* Block upper layer to not get any new requests */
> +	blk_mq_quiesce_queue(q);
> +
> +	for (i =3D 0; i < vblk->num_vqs; i++) {
> +		blk_vq =3D &vblk->vqs[i];
> +
> +		/* Synchronize with any ongoing virtblk_poll() which may be
> +		 * completing the requests to uppper layer which has already
> +		 * crossed the broken vq check.
> +		 */
> +		spin_lock_irqsave(&blk_vq->lock, flags);
> +		spin_unlock_irqrestore(&blk_vq->lock, flags);
> +	}
> +
> +	blk_sync_queue(q);
> +
> +	/* Complete remaining pending requests with error */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request, vblk);

Interrupts can still occur here. What prevents the race between
virtblk_cancel_request() and virtblk_request_done()?

> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/*
> +	 * Unblock any pending dispatch I/Os before we destroy device. From
> +	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD flag,
> +	 * that will make sure any new I/O from bio_queue_enter() to fail.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk =3D vdev->priv;
> =20
> +	virtblk_cleanup_reqs(vblk);
> +
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> =20
> --=20
> 2.34.1
>=20

--+EsB9gUsZRuxclQv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXVIg0ACgkQnKSrs4Gr
c8gbcAgAgsyhOzrXjnJK+mvJY7ajiqTKGi8aBCVwdk4Xcjj7ctqtgP8KmGiz7otl
hjf5i+SxIyeAJ6/F4n0osHVEZ0ZSpKjge9xvyInFn/dnEc0PNBnQIA8NUcuGPjBG
EDbK3R5lz8Ew3GViJdNSEbGD1ie1JpYPldJkKOGLECGo3F5HEiRHUdS89IoavyZT
XPrfkIiHOUVDYJl7Yxp8SdPRzOZ/IUNIvSBISpjYCg84tW8lZPPkccC/ME2WcSxf
oHnPD+r0L3JplBUDLZ+CLHO2bfDRlEbnfoIIZ5HdxjKxxbWd6mdOhtmibF1S3JkR
+qbM9oB3ynjledSslS8vMh5DkWXAaw==
=gNYy
-----END PGP SIGNATURE-----

--+EsB9gUsZRuxclQv--


