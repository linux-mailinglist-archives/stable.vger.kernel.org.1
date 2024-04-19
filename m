Return-Path: <stable+bounces-40295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16C8AB144
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9431C212C3
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A412F58C;
	Fri, 19 Apr 2024 15:04:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE781E893
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539064; cv=none; b=I94cwOVUADETFEAjILJjTTmZWGhGW623QC5MRWORTWvYDJp1XUbXvX6wjilOTf+Hm1XYkcwV6Bhivr8eW0qkV8Jy71h/k6fG7lnd3blD7SXN/6YjXy8m+3eKkJvkfAHoozcrg8DIE6aECeeAoLVPVMR7PBbCj6/gAVpVg8A4jnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539064; c=relaxed/simple;
	bh=BfPC7rSyyC8PwFpTcUkxNnMuZ2RpZN5nSwew3yN8V08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ujj7gwQWK5R5dkHE5cnI8TQNSNTNCOLnZcHNOPQ35rQQZW7DacfANmFDS5dDfnC1Vi4jP75+4XR5zSTyX7YHz95TVQnEAZiYmD8kNfjDZK6NTphdPfS/7rRKIht4DfKTkeJiyy0OvTT9SjSTML6Vvh0UNBzr2O1PFB6OJLyWa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-7CD1Fwe2O922ruFHYjUJtg-1; Fri, 19 Apr 2024 11:04:11 -0400
X-MC-Unique: 7CD1Fwe2O922ruFHYjUJtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 364278E9E89;
	Fri, 19 Apr 2024 15:04:10 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 93AC6581D0;
	Fri, 19 Apr 2024 15:04:08 +0000 (UTC)
Date: Fri, 19 Apr 2024 17:04:07 +0200
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
Subject: Re: [PATCH net-next 0/3] Resolve security issue in MACsec offload Rx
 datapath
Message-ID: <ZiKH52u_sjpm2mhf@hog>
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419011740.333714-1-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This should go to net, not net-next. It fixes a serious bug. Also
please change the title to:
  fix isolation of broadcast traffic with MACsec offload

"resolve security issue" is too vague.

2024-04-18, 18:17:14 -0700, Rahul Rameshbabu wrote:
> Some device drivers support devices that enable them to annotate whether =
a
> Rx skb refers to a packet that was processed by the MACsec offloading
> functionality of the device. Logic in the Rx handling for MACsec offload
> does not utilize this information to preemptively avoid forwarding to the
> macsec netdev currently. Because of this, things like multicast messages
> such as ARP requests are forwarded to the macsec netdev whether the messa=
ge
> received was MACsec encrypted or not. The goal of this patch series is to
> improve the Rx handling for MACsec offload for devices capable of
> annotating skbs received that were decrypted by the NIC offload for MACse=
c.
>=20
> Here is a summary of the issue that occurs with the existing logic today.
>=20
>     * The current design of the MACsec offload handling path tries to use
>       "best guess" mechanisms for determining whether a packet associated
>       with the currently handled skb in the datapath was processed via HW
>       offload=E2=80=8B

nit: there's a strange character after "offload" and at the end of a
few other lines in this list

>     * The best guess mechanism uses the following heuristic logic (in ord=
er of
>       precedence)
>       - Check if header destination MAC address matches MACsec netdev MAC
>         address -> forward to MACsec port
>       - Check if packet is multicast traffic -> forward to MACsec port=E2=
=80=8B
                                                                   here ^

>       - MACsec security channel was able to be looked up from skb offload
>         context (mlx5 only) -> forward to MACsec port=E2=80=8B
                                                  here ^

>     * Problem: plaintext traffic can potentially solicit a MACsec encrypt=
ed
>       response from the offload device
>       - Core aspect of MACsec is that it identifies unauthorized LAN conn=
ections
>         and excludes them from communication
>         + This behavior can be seen when not enabling offload for MACsec=
=E2=80=8B
                                                                     here ^

>       - The offload behavior violates this principle in MACsec
>=20

>=20
> Link: https://github.com/Binary-Eater/macsec-rx-offload/blob/trunk/MACsec=
_violation_in_core_stack_offload_rx_handling.pdf
> Link: https://lore.kernel.org/netdev/87r0l25y1c.fsf@nvidia.com/
> Link: https://lore.kernel.org/netdev/20231116182900.46052-1-rrameshbabu@n=
vidia.com/
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

I would put some Fixes tags on this series. Since we can't do anything
about non-md_dst devices, I would say that the main patch fixes
860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path
support"), and the driver patch fixes b7c9400cbc48 ("net/mlx5e:
Implement MACsec Rx data path using MACsec skb_metadata_dst"). Jakub,
Rahul, does that sound ok to both of you?

--=20
Sabrina


