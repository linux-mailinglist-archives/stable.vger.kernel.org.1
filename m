Return-Path: <stable+bounces-41345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC6A8B052F
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 11:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F23B21048
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90432158A37;
	Wed, 24 Apr 2024 09:00:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1A158A06
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949201; cv=none; b=SEaM4N8qwL/kHhuWEMzp23VFhQh2fo0RhRwKq3UHXMzBKtpMpd21Y+8ZwukXGjmCC/F2G0c4yk7/ouz3FPY5YQp5ShewTIzd0mp2qH+dVxj1Y4LGNweKai9cMIVnsRjvGr7PhUjeGal3D18r4BMXB+jlLMjvdXxGtnqFVE+/8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949201; c=relaxed/simple;
	bh=t5i8g9w59FHasVrZ4M0dhNpqO7P9HI8ZpIHC/OCwIeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UYdT7SMXVIn55H+yeiZFtTTDZDTAoTquDXKSYHpIQ66YTgBpRCNVQPTzELkhAldpRLSn/SKTo8YAqrmwpGvaPHdjI8d3Kjbnxs/Tu5QW5T9FM4Qgrak8jiv9Pooh5BzyxKfzAvzdQoZ0hjZZ4JHkp7J5X4F3HlGYeECZu5AZIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-n8V0b3sIM-m6LidnFQndyQ-1; Wed, 24 Apr 2024 04:59:51 -0400
X-MC-Unique: n8V0b3sIM-m6LidnFQndyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07120834FF4;
	Wed, 24 Apr 2024 08:59:48 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 232F9C7FCEF;
	Wed, 24 Apr 2024 08:59:41 +0000 (UTC)
Date: Wed, 24 Apr 2024 10:59:40 +0200
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
Subject: Re: [PATCH net v3 0/4] Fix isolation of broadcast traffic and
 unmatched unicast traffic with MACsec offload
Message-ID: <ZijJ_GfrzfbCEWzT@hog>
References: <20240423181319.115860-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240423181319.115860-1-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-23, 11:13:01 -0700, Rahul Rameshbabu wrote:
> Rahul Rameshbabu (4):
>   macsec: Enable devices to advertise whether they update sk_buff md_dst
>     during offloads
>   ethernet: Add helper for assigning packet type when dest address does
>     not match device address
>   macsec: Detect if Rx skb is macsec-related for offloading devices that
>     update md_dst
>   net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for
>     MACsec
>=20
>  .../mellanox/mlx5/core/en_accel/macsec.c      |  1 +
>  drivers/net/macsec.c                          | 46 +++++++++++++++----
>  include/linux/etherdevice.h                   | 25 ++++++++++
>  include/net/macsec.h                          |  2 +
>  net/ethernet/eth.c                            | 12 +----
>  5 files changed, 65 insertions(+), 21 deletions(-)

Thanks Rahul.

Series:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


