Return-Path: <stable+bounces-224842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K78CtKdsmndOAAAu9opvQ
	(envelope-from <stable+bounces-224842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:04:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FFE270933
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3738B3034A2A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3B399346;
	Thu, 12 Mar 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="RLn+OgRU"
X-Original-To: stable@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A9397E95;
	Thu, 12 Mar 2026 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313481; cv=none; b=NzvZPTNccKv1RFJkDtmYpxCEz7iBNm5JUFW5RY6GcPbouHCkEoA0Zz5RWqxTvQElo5xQ9NMl5XmdBAqNJ5Oae4hKKECIAc2x4FEAhvmIo7XnLFKGmmTW0XQFpXR52RYy8vfZIDONxvI55TAM/n8vFaNycHSo1fxf/pD+p4ASxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313481; c=relaxed/simple;
	bh=MqeszDfuq9bQ4r4H0RqQ1uAwADtJfHI/Gu6WbwrYUhg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qt16+Z4IymCUEB1JGMw2qVy77EFZp70Mon37VijGP56SnrAzelVdNfdSG+eszxH6bcX9HFfvChVQgYkbatg+glvWw+VNtfJy1NiJT08dCk8+jQq1kQyd/tWywQMHUp3RYvyRxwPv9ALSl2NJH6n3OZgcdRVPDSW4xF78zi5RBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=RLn+OgRU; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773313474; x=1773572674;
	bh=s+Antuh39Wb/N9YleDGbuOG6fpiM4Qo9/izRY/oAKDU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RLn+OgRUzi9pj9vXa8Py5uHNX1g8cE5nB1iU21AamF/y9n9O/d7Q2lV0JROPf1On9
	 G5i7YtEiDuLLIgXneMiFqmZCMcxYEWx4uQq84T7vlEfpg1hEZNMO5/MTCyROiOneKl
	 UMe/gfjHI9XFUhoxYFmadO3rT4MMQm+pc4cjbITnUib/JmQGCK8FoAV9kjy9MiFXUb
	 apiny4vPdPBzZyIrPvbvafYvm4hBol465BED8oEAFQ/u+tY0Ax0hJwGUTnxIfdfdV7
	 MFBc+V6aVNckSidwK0xO1HJ64GR/mlxIV5k4Fr3779cifti94BgMCMtRsaxaSGnAG/
	 rFfziLMRcM66A==
Date: Thu, 12 Mar 2026 11:04:30 +0000
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>
From: Paul Moses <p@1g4.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH] vdpa: don't free reply skb after genlmsg_reply()
Message-ID: <20260312110421.2880401-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8849733408bb9a6616770c322a36293e03cdac8d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224842-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:dkim,1g4.org:email,1g4.org:mid]
X-Rspamd-Queue-Id: 99FFE270933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

genlmsg_reply() hands the reply skb to netlink, and
netlink_unicast() consumes it on all return paths, whether the
skb is queued successfully or freed on an error path.

vdpa_nl_cmd_dev_config_get_doit() currently jumps to nlmsg_free(msg)
after genlmsg_reply() fails, which can hit the same skb twice.

Return the genlmsg_reply() error directly and keep nlmsg_free()
only for pre-reply failures.

Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/vdpa/vdpa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 34874beb0152e..702d3a7772219 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1352,15 +1352,19 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct s=
k_buff *skb, struct genl_info
 =09}
 =09err =3D vdpa_dev_config_fill(vdev, msg, info->snd_portid, info->snd_seq=
,
 =09=09=09=09   0, info->extack);
-=09if (!err)
-=09=09err =3D genlmsg_reply(msg, info);
+=09if (err)
+=09=09goto mdev_err;
+
+=09put_device(dev);
+=09up_read(&vdpa_dev_lock);
+
+=09return genlmsg_reply(msg, info);
=20
 mdev_err:
 =09put_device(dev);
 dev_err:
 =09up_read(&vdpa_dev_lock);
-=09if (err)
-=09=09nlmsg_free(msg);
+=09nlmsg_free(msg);
 =09return err;
 }
=20
--=20
2.53.GIT



