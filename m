Return-Path: <stable+bounces-40296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF48AB149
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A5F1C2104F
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1B12F39A;
	Fri, 19 Apr 2024 15:06:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44C7D07F
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539162; cv=none; b=YLW59tbIcAHb/pdDtndeH7MBzwTFWRvOPUCh4PgbBnjWi+JOkqj57gzXhsZ6Qt7lYysxmcUIdxedLBrO0o3Pf/khfRkD0386XpD4aG+vI5nfaHC4TVIMHbNxCFU5gD9cqkc+FTO2jvNCVX6nrkqk4DdDWpOjsC4b2Fk321+6svA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539162; c=relaxed/simple;
	bh=SCtTqh76GTTaanZq/azQaTgxCnU5AoDXMye3iDEfSc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Vx5EHFDxwjNecBuZ7SNyC8k7lzqiTD7oDm8rk4q1QnFoebMPX0/V65/Acu+x2bdX9BTyEtzRDBjsSn1GEEyndwuQtiFGSgGAkcr+wvHhVkWzCaYRXbpH0AYFIvTuXCB83k13zuAeZRuk84U9C2SLev0q8/X6hvVFTMWQ1sO+EeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-wfiM61_ZMsS5SR3VQFv4Hg-1; Fri,
 19 Apr 2024 11:05:56 -0400
X-MC-Unique: wfiM61_ZMsS5SR3VQFv4Hg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B085F3816462;
	Fri, 19 Apr 2024 15:05:55 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D042166B34;
	Fri, 19 Apr 2024 15:05:53 +0000 (UTC)
Date: Fri, 19 Apr 2024 17:05:52 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 2/3] macsec: Detect if Rx skb is macsec-related
 for offloading devices that update md_dst
Message-ID: <ZiKIUC6bTCDhlnRw@hog>
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
 <20240419011740.333714-3-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419011740.333714-3-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-18, 18:17:16 -0700, Rahul Rameshbabu wrote:
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 0206b84284ab..679302ef1cd9 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -991,6 +991,19 @@ static struct macsec_rx_sc *find_rx_sc_rtnl(struct m=
acsec_secy *secy, sci_t sci)
>  =09return NULL;
>  }
> =20
> +static __u8 macsec_offload_pkt_type(const u8 *h_dest, const u8 *ndev_bro=
adcast)
> +

nit: empty line shouldn't be here

> +{
> +=09if (is_multicast_ether_addr_64bits(h_dest)) {
> +=09=09if (ether_addr_equal_64bits(h_dest, ndev_broadcast))
> +=09=09=09return PACKET_BROADCAST;
> +=09=09else
> +=09=09=09return PACKET_MULTICAST;
> +=09}
> +
> +=09return PACKET_HOST;
> +}
> +
>  static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
>  {
>  =09/* Deliver to the uncontrolled port by default */
> @@ -999,10 +1012,12 @@ static enum rx_handler_result handle_not_macsec(st=
ruct sk_buff *skb)
>  =09struct metadata_dst *md_dst;
>  =09struct macsec_rxh_data *rxd;
>  =09struct macsec_dev *macsec;
> +=09bool is_macsec_md_dst;
> =20
>  =09rcu_read_lock();
>  =09rxd =3D macsec_data_rcu(skb->dev);
>  =09md_dst =3D skb_metadata_dst(skb);
> +=09is_macsec_md_dst =3D md_dst && md_dst->type =3D=3D METADATA_MACSEC;
> =20
>  =09list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
>  =09=09struct sk_buff *nskb;
> @@ -1014,13 +1029,40 @@ static enum rx_handler_result handle_not_macsec(s=
truct sk_buff *skb)
>  =09=09 */
>  =09=09if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
>  =09=09=09struct macsec_rx_sc *rx_sc =3D NULL;

Please move this into the "if (is_macsec_md_dst)" block below, since
it's no longer used outside.

> +=09=09=09const struct macsec_ops *ops;
> =20
> -=09=09=09if (md_dst && md_dst->type =3D=3D METADATA_MACSEC)
> -=09=09=09=09rx_sc =3D find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sc=
i);
> +=09=09=09ops =3D macsec_get_ops(macsec, NULL);
> =20
> -=09=09=09if (md_dst && md_dst->type =3D=3D METADATA_MACSEC && !rx_sc)
> +=09=09=09if (ops->rx_uses_md_dst && !is_macsec_md_dst)
>  =09=09=09=09continue;
> =20
> +=09=09=09if (is_macsec_md_dst) {
> +=09=09=09=09/* All drivers that implement MACsec offload
> +=09=09=09=09 * support using skb metadata destinations must
> +=09=09=09=09 * indicate that they do so.
> +=09=09=09=09 */
> +=09=09=09=09DEBUG_NET_WARN_ON_ONCE(!ops->rx_uses_md_dst);
> +=09=09=09=09rx_sc =3D find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sc=
i);
> +=09=09=09=09if (!rx_sc)
> +=09=09=09=09=09continue;
> +=09=09=09=09/* device indicated macsec offload occurred */
> +=09=09=09=09skb->dev =3D ndev;
> +=09=09=09=09skb->pkt_type =3D macsec_offload_pkt_type(
> +=09=09=09=09=09hdr->h_dest, ndev->broadcast);
> +=09=09=09=09ret =3D RX_HANDLER_ANOTHER;
> +=09=09=09=09goto out;
> +=09=09=09}
> +
> +=09=09=09/* This datapath is insecure because it is unable to
> +=09=09=09 * enforce isolation of broadcast/multicast traffic and
> +=09=09=09 * unicast traffic with promiscuous mode on the macsec
> +=09=09=09 * netdev. Since the core stack has no mechanism to
> +=09=09=09 * check that the hardware did indeed receive MACsec
> +=09=09=09 * traffic, it is possible that the response handling
> +=09=09=09 * done by the MACsec port was to a plaintext packet.
> +=09=09=09 * This violates the MACsec protocol standard.
> +=09=09=09 */
> +=09=09=09DEBUG_NET_WARN_ON_ONCE(true);

If you insist on this warning (and I'm not convinced it's useful,
since if the HW is already built and cannot inform the driver, there's
nothing the driver implementer can do), I would move it somewhere into
the config path. macsec_update_offload would be a better location for
this kind of warning (maybe with a pr_warn (not limited to debug
configs) saying something like "MACsec offload on devices that don't
support md_dst are insecure: they do not provide proper isolation of
traffic"). The comment can stay here.

>  =09=09=09if (ether_addr_equal_64bits(hdr->h_dest,
>  =09=09=09=09=09=09    ndev->dev_addr)) {
>  =09=09=09=09/* exact match, divert skb to this port */

--=20
Sabrina


