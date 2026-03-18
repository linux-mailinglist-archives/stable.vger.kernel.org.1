Return-Path: <stable+bounces-227081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBeCFAG6umk4bQIAu9opvQ
	(envelope-from <stable+bounces-227081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:43:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0578C2BD668
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F15830832E6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870603DC4AD;
	Wed, 18 Mar 2026 14:34:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02083DA7CC
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844442; cv=none; b=YLWtd3+0sgfBPxEBmiFv0ppKNJm1TsWcfQdxlIgXix5Z/C36iTkOoIR5pVmfgeeIeBlMNGxDA6LbuTdpKyey84fMyyVyNio6dQGLEOqc19iDGgd7yAzq393R6oDori3YLzygdT0+RTvWczcpg7mj9R8ZoXRVllbgw20k0ZrIiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844442; c=relaxed/simple;
	bh=cLufbcSTF3ZXxO63NfD5IE+LSmoBumdAAbnjhXQdd9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUBcz1BTQjsFgVKMeiK8gCsyYLcMOBGPSgFCRQrFhxcBkkfgQYp0OUt+osjYltM7Jkwd90t4O5y/Rw4IYQ+kPj79sxC1ToFQSl2dumnjYB2eJvRlQcWA8ELkbNQt+ERwJqfs9blIZS37FuRYMz5PUBgUtGTK5Ka7K4OUEhJAdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1w2rxz-0001iL-6S; Wed, 18 Mar 2026 15:33:47 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1w2rxy-000vHs-1T;
	Wed, 18 Mar 2026 15:33:46 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1w2rxy-00000009Ar4-1S7v;
	Wed, 18 Mar 2026 15:33:46 +0100
Date: Wed, 18 Mar 2026 15:33:46 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	linux_oss@crudebyte.com, gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abq3yqrsQJGI71jz@pengutronix.de>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slHqKoTqpWZ+T6zB"
Content-Disposition: inline
In-Reply-To: <20260313171659.1225180-1-jhj140711@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227081-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.568];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 0578C2BD668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--slHqKoTqpWZ+T6zB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

I have some review feedback.

On Sat, Mar 14, 2026 at 02:16:59AM +0900, Hyungjung Joo wrote:
>p9_usbg_close() tears down the client transport, but usb9pfs keeps
>using usb9pfs->client from asynchronous TX and RX completion handlers.
>A late completion can therefore dereference a client that has already
>been freed during mount teardown.
>
>Clear usb9pfs->client under usb9pfs->lock when closing the transport,
>detach any pending TX request from in_req->context, and make the TX/RX
>completion handlers bail out once the transport has been detached. This
>keeps late completions from touching a freed or rebound p9_client.
>
>Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
>Cc: stable@vger.kernel.org
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
>---
> net/9p/trans_usbg.c | 63 +++++++++++++++++++++++++++++++++------------
> 1 file changed, 47 insertions(+), 16 deletions(-)
>
>diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
>index 1ce70338999c..3c2aa1943f93 100644
>--- a/net/9p/trans_usbg.c
>+++ b/net/9p/trans_usbg.c
>@@ -149,7 +149,8 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, str=
uct usb_request *req)
> {
> 	struct f_usb9pfs *usb9pfs =3D ep->driver_data;
> 	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>-	struct p9_req_t *p9_tx_req =3D req->context;
>+	struct p9_client *client;
>+	struct p9_req_t *p9_tx_req;
> 	unsigned long flags;
>
> 	/* reset zero packages */
>@@ -165,18 +166,27 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, s=
truct usb_request *req)
> 		ep->name, req->status, req->actual, req->length);
>
> 	spin_lock_irqsave(&usb9pfs->lock, flags);
>-	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
>+	client =3D usb9pfs->client;
>+	p9_tx_req =3D req->context;
>+	req->context =3D NULL;
>
>-	p9_req_put(usb9pfs->client, p9_tx_req);
>+	if (!client || !p9_tx_req) {

Just goto unlock_complete;

>+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
>+		complete(&usb9pfs->send);
>+		return;
>+	}
>
>-	req->context =3D NULL;
>+	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
>+
>+	p9_req_put(client, p9_tx_req);
>

unlock_complete:
> 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
>
> 	complete(&usb9pfs->send);
> }
>
>-static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void=
 *buf)
>+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
>+					  struct p9_client *client, void *buf)

I like this change but not in this patch. Since with your patch,
rx_header will be called under locking context, this is not
really a necessary change.

I would keep it in another patch, though and move it before your change.

> {
> 	struct p9_req_t *p9_rx_req;
> 	struct p9_fcall	rc;
>@@ -202,7 +212,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb=
9pfs *usb9pfs, void *buf)
> 		 "mux %p pkt: size: %d bytes tag: %d\n",
> 		 usb9pfs, rc.size, rc.tag);
>
>-	p9_rx_req =3D p9_tag_lookup(usb9pfs->client, rc.tag);
>+	p9_rx_req =3D p9_tag_lookup(client, rc.tag);
> 	if (!p9_rx_req || p9_rx_req->status !=3D REQ_STATUS_SENT) {
> 		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
> 		return NULL;
>@@ -212,7 +222,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb=
9pfs *usb9pfs, void *buf)
> 		p9_debug(P9_DEBUG_ERROR,
> 			 "requested packet size too big: %d for tag %d with capacity %zd\n",
> 			 rc.size, rc.tag, p9_rx_req->rc.capacity);
>-		p9_req_put(usb9pfs->client, p9_rx_req);
>+		p9_req_put(client, p9_rx_req);
> 		return NULL;
> 	}
>
>@@ -220,7 +230,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb=
9pfs *usb9pfs, void *buf)
> 		p9_debug(P9_DEBUG_ERROR,
> 			 "No recv fcall for tag %d (req %p), disconnecting!\n",
> 			 rc.tag, p9_rx_req);
>-		p9_req_put(usb9pfs->client, p9_rx_req);
>+		p9_req_put(client, p9_rx_req);
> 		return NULL;
> 	}
>
>@@ -231,8 +241,10 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, st=
ruct usb_request *req)
> {
> 	struct f_usb9pfs *usb9pfs =3D ep->driver_data;
> 	struct usb_composite_dev *cdev =3D usb9pfs->function.config->cdev;
>+	struct p9_client *client;
> 	struct p9_req_t *p9_rx_req;
> 	unsigned int req_size =3D req->actual;
>+	unsigned long flags;
> 	int status =3D REQ_STATUS_RCVD;
>
> 	if (req->status) {
>@@ -241,9 +253,16 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, st=
ruct usb_request *req)
> 		return;
> 	}
>
>-	p9_rx_req =3D usb9pfs_rx_header(usb9pfs, req->buf);
>-	if (!p9_rx_req)
>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>+	client =3D usb9pfs->client;
>+	if (!client) {
>+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
> 		return;
>+	}
>+
>+	p9_rx_req =3D usb9pfs_rx_header(usb9pfs, client, req->buf);
>+	if (!p9_rx_req)
>+		goto out_unlock;
>
> 	if (req_size > p9_rx_req->rc.capacity) {
> 		dev_err(&cdev->gadget->dev,
>@@ -257,8 +276,11 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, st=
ruct usb_request *req)
>
> 	p9_rx_req->rc.size =3D req_size;
>
>-	p9_client_cb(usb9pfs->client, p9_rx_req, status);
>-	p9_req_put(usb9pfs->client, p9_rx_req);
>+	p9_client_cb(client, p9_rx_req, status);
>+	p9_req_put(client, p9_rx_req);
>+
>+out_unlock:
>+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
>
> 	complete(&usb9pfs->received);
> }
>@@ -416,7 +438,9 @@ static int p9_usbg_create(struct p9_client *client, st=
ruct fs_context *fc)
> 		client->status =3D Disconnected;
> 	else
> 		client->status =3D Connected;
>+	spin_lock_irq(&usb9pfs->lock);
> 	usb9pfs->client =3D client;
>+	spin_unlock_irq(&usb9pfs->lock);
>
> 	client->trans_mod->maxsize =3D usb9pfs->buflen;
>
>@@ -427,18 +451,25 @@ static int p9_usbg_create(struct p9_client *client, =
struct fs_context *fc)
>
> static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
> {
>+	struct p9_client *client;
> 	struct p9_req_t *req;
>+	unsigned long flags;
>
>-	guard(spinlock_irqsave)(&usb9pfs->lock);
>+	spin_lock_irqsave(&usb9pfs->lock, flags);
>+	client =3D usb9pfs->client;
>+	usb9pfs->client =3D NULL;
>+	req =3D usb9pfs->in_req ? usb9pfs->in_req->context : NULL;
>+	if (usb9pfs->in_req)
>+		usb9pfs->in_req->context =3D NULL;
>+	spin_unlock_irqrestore(&usb9pfs->lock, flags);

Same applies here, it would be nice to seperate the changes of
using the extra variable to a second patch.
>
>-	req =3D usb9pfs->in_req->context;
>-	if (!req)
>+	if (!req || !client)
> 		return;
>
> 	if (!req->t_err)
> 		req->t_err =3D -ECONNRESET;
>
>-	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
>+	p9_client_cb(client, req, REQ_STATUS_ERROR);
> }
>
> static void p9_usbg_close(struct p9_client *client)
>--=20
>2.34.1

I tested your patch and like the changes, however I have some extra
patches on top. Would you mind if I take your changes and include my
suggestions. I would still keep you as author though. These changes would
then be included in my series I will send today.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--slHqKoTqpWZ+T6zB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmm6t8cACgkQC+njFXoe
LGR96xAAuLktJ1iOoveDgtn+MCY/pzKT+sHU0HgPMEpYA+hFu9hdt7kSH5pZwXhz
sqGm4PH1j+F3mL5a55Tv2h5gjqafBLcN9HTMe9gUpjKuCPBo8NjIRZTgt2ozp60c
7XyRqjNh2ButuN4aYLSJjfLhsSrVDlo4MuhmDltjXSjaHiuzi5iCdGnsvJY6zMF5
4L9MhJU9HZT/xtjephHq9KYysaUwRK07ygYNDMTJJSaB5M7MRAFDp4a6m5oLH9G4
odKKxavan2sfg/UkCSQKbahDsVlNDxNXn9TC6B/c2uweC76yNdTtzSiQ0v8PPDBU
N5uK0EB47iDIPA6H51f9fTMsnJEgpn+X/QZEsXnUe514ShEsmwA5aU+A/A20LoRM
VL4DpmuQMiC2AUC2OjSGeYVaZM8puh9BrY+HaD0ajMIT37fOjz5DUTx8GzJRfS5V
9JuzJKE1/yhO7AHkjDQhRfrsHhmi+si7yqvqeMZDBm04kQEVApOIGnI1tlR7/iw5
XD5Jqwn4mJyg2aX3Zwmw6nbNI+/i+3XE9EaUh7ywXpeNm9bswbhuNUytkeZnmQ9e
gJEN1U/6dm+HNpTc+nczOlQ6JQ6cdugoxxICjQOSDh9czTarCZM/a+yw2z7Enh28
eeAwYWN6UXSIMUscx23tNCn0S9gUjik/ZX6ZKFuoW4xGo41CcxU=
=gES0
-----END PGP SIGNATURE-----

--slHqKoTqpWZ+T6zB--

