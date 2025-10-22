Return-Path: <stable+bounces-188863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B80BF98FE
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 03:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D990D19A64B7
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6701DC997;
	Wed, 22 Oct 2025 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="MVjX+kcW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JS0q5mk0"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6B208AD;
	Wed, 22 Oct 2025 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095293; cv=none; b=os9PbAGZyYEKBuqN8cngPBgx/vYJZAo9GeNTxYrWzoKqCO6Ra5q3gyRFtQJ//WZL0NSvtEDcMDwdNez7eHKHNumJmDFLyfGYE2udO6T0sl6dpTiWsDM9KRYwjJEh3Rc4VMQR9aymJ8/bXIJx7S7Kh4ri8H7V8vzxlI5eaetZw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095293; c=relaxed/simple;
	bh=wf3eeZM7mj1ejiDynEQH/nZW39k5CL2pQdDuhNlkqUo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Zzb1zSoWFgW76us3OdroLHtB89OesWHWQJrPfKgruFUt2MSX0+WJBXMrlYW3UIcfwP+VWR2FNbJP9hy4yehLlEpPQXFpbUxinxiRhARTQtaH0i40a3UGYJmjVCE/t7gU1ht6ab4Ey5yvWvNbWQe+PrA+mNEghWD5SVSACp3VlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=MVjX+kcW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JS0q5mk0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 839401400186;
	Tue, 21 Oct 2025 21:08:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 21:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1761095288; x=1761181688; bh=ZMxT5iUoaULJnUvpJx0j9
	sC7E0gpCkSzQso8i0x1z30=; b=MVjX+kcWGI//T3AHipu+gj+coPGH0MMxsbzuh
	9veygfwQynG4KlBnTzoE/YbJli5GUCYvOQRv3Npf8or0csSQg6h/GpW459uc32ex
	zLYgxdibPpd+t8TTuukS/KzQtffDFCUFguQrrAstZFrBdPAYb05GSsFL2EHd6BTP
	Oj4yurfYVZELfsYO2kbrOH3BtHvw4JMSzdBbyWeSJ19gSdhC2anL3BMXSuZKCe+C
	fqOLIShC6WgtIbNDXBeCATUDYWRtDZ3W3fjRWl96EhMAtR85Nj0MJrVz6cmk9agt
	nI40tpjJFby3LjNmOsjeviAL/tgd+HV+zx2F4RLBNS17doyPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761095288; x=1761181688; bh=ZMxT5iUoaULJnUvpJx0j9sC7E0gpCkSzQso
	8i0x1z30=; b=JS0q5mk0dbGJaIiw4wLK9AR3Ek1ffTf6cPI0USeDPGckUjLNzQy
	a/+fjcZsG5di8EU1Lm04ZvpLzBEG+37846K9SwnQxvkjmlxFAr/Y3t7tnMsgkGFr
	GehGgXQNG7MDr5K/8uF4AmGOYGcNoTlX1YoTeGeriuBzN6ffFhSUkQXDuiukMkcX
	xJUJygyU8y0OE6p/gyPFpQbCgtIMrxLuMqyKHpoTymioM/d28iTyRZT5yQdHNFxc
	4L9q4VF9otjmlgnabpqqetSPaInIKP7HQJFd3fB0o8Xg+5ntbFIA59vk2F428GNw
	L1rgINmvce00bx4MZtsaY9yeZOEYQ3oPSxA==
X-ME-Sender: <xms:di74aBSuLD_gV6kYoon0owjhQrdVfY7CoJQUE7zbGUM4r7p8PS55HA>
    <xme:di74aN0XUQ3t7a-TpkbRMmYtSw0jYl8bdD-2pIKdJKR-2z1kGQuepSEcdetC5NjyG
    ckITdB_jgNt9ztH9sHoiHKXV0h3ccfd6KMaYqtk5PM25KJ11C0fs7Q>
X-ME-Received: <xmr:di74aBeP0YgivKkyPUFcHyB14D2gh_1tuh-W5_eesNx-7xIBcEImkyn7-Tsa1f8tc2mKxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhonhhghhgrohessggrmhgrihgtlhhouhgurdgtohhmpd
    hrtghpthhtohepvhhinhgtvghnthessggvrhhnrghtrdgthhdprhgtphhtthhopehrrgii
    ohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtoheplhhiuhhhrghnghgsihhnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnug
    hrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehprggsvghnihesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:dy74aFMO_zu46M1f02C9SiD3ziJaD6O4fXN7Wgar0iBWfsUM-V2wew>
    <xmx:dy74aFUUvHTKEU_kEzR0NOQDqv9Y0M707abTaJcBPfPI5qVbo-GUIQ>
    <xmx:dy74aNwWJ-WPZZ8LOmutxWvC_U48I8b4CTd3zCYyKcf1e337KdWV4A>
    <xmx:dy74aM8leRTXFKVahjtWmgtnGtZz61xHxPIb5BBO0b5WdcIrraWTAQ>
    <xmx:eC74aH8SDBmq2zymZkESYOnZ3o1zvqE4OLn9TTvNxUuUSoJyqJ3_0VaL>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 21:08:06 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B240D9FD51; Tue, 21 Oct 2025 18:08:05 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B157F9FD50;
	Tue, 21 Oct 2025 18:08:05 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Vincent Bernat <vincent@bernat.ch>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: bonding: fix possible peer notify event loss or
 dup issue
In-reply-to: <20251021050933.46412-1-tonghao@bamaicloud.com>
References: <20251021050933.46412-1-tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Tue, 21 Oct 2025 13:09:33 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <953399.1761095285.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Oct 2025 18:08:05 -0700
Message-ID: <953400.1761095285@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>If the send_peer_notif counter and the peer event notify are not synchron=
ized.
>It may cause problems such as the loss or dup of peer notify event.
>
>Before this patch:
>- If should_notify_peers is true and the lock for send_peer_notif-- fails=
, peer
>  event may be sent again in next mii_monitor loop, because should_notify=
_peers
>  is still true.
>- If should_notify_peers is true and the lock for send_peer_notif-- succe=
eded,
>  but the lock for peer event fails, the peer event will be lost.
>
>This patch locks the RTNL for send_peer_notif, events, and commit simulta=
neously.
>
>Fixes: 07a4ddec3ce9 ("bonding: add an option to specify a delay between p=
eer notifications")
>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Hangbin Liu <liuhangbin@gmail.com>
>Cc: Nikolay Aleksandrov <razor@blackwall.org>
>Cc: Vincent Bernat <vincent@bernat.ch>
>Cc: <stable@vger.kernel.org>
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>

	I'll note that this appears to preserve the ordering of the
various events (commit, link state, notify peers).

	-J

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
> drivers/net/bonding/bond_main.c | 40 +++++++++++++++------------------
> 1 file changed, 18 insertions(+), 22 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 5791c3e39baa..52b7ac8ddfbc 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2971,7 +2971,7 @@ static void bond_mii_monitor(struct work_struct *wo=
rk)
> {
> 	struct bonding *bond =3D container_of(work, struct bonding,
> 					    mii_work.work);
>-	bool should_notify_peers =3D false;
>+	bool should_notify_peers;
> 	bool commit;
> 	unsigned long delay;
> 	struct slave *slave;
>@@ -2983,30 +2983,33 @@ static void bond_mii_monitor(struct work_struct *=
work)
> 		goto re_arm;
> =

> 	rcu_read_lock();
>+
> 	should_notify_peers =3D bond_should_notify_peers(bond);
> 	commit =3D !!bond_miimon_inspect(bond);
>-	if (bond->send_peer_notif) {
>-		rcu_read_unlock();
>-		if (rtnl_trylock()) {
>-			bond->send_peer_notif--;
>-			rtnl_unlock();
>-		}
>-	} else {
>-		rcu_read_unlock();
>-	}
> =

>-	if (commit) {
>+	rcu_read_unlock();
>+
>+	if (commit || bond->send_peer_notif) {
> 		/* Race avoidance with bond_close cancel of workqueue */
> 		if (!rtnl_trylock()) {
> 			delay =3D 1;
>-			should_notify_peers =3D false;
> 			goto re_arm;
> 		}
> =

>-		bond_for_each_slave(bond, slave, iter) {
>-			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
>+		if (commit) {
>+			bond_for_each_slave(bond, slave, iter) {
>+				bond_commit_link_state(slave,
>+						       BOND_SLAVE_NOTIFY_LATER);
>+			}
>+			bond_miimon_commit(bond);
>+		}
>+
>+		if (bond->send_peer_notif) {
>+			bond->send_peer_notif--;
>+			if (should_notify_peers)
>+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
>+							 bond->dev);
> 		}
>-		bond_miimon_commit(bond);
> =

> 		rtnl_unlock();	/* might sleep, hold no other locks */
> 	}
>@@ -3014,13 +3017,6 @@ static void bond_mii_monitor(struct work_struct *w=
ork)
> re_arm:
> 	if (bond->params.miimon)
> 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
>-
>-	if (should_notify_peers) {
>-		if (!rtnl_trylock())
>-			return;
>-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>-		rtnl_unlock();
>-	}
> }
> =

> static int bond_upper_dev_walk(struct net_device *upper,
>-- =

>2.34.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

