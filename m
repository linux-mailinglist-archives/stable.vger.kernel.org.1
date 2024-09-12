Return-Path: <stable+bounces-75977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF4976693
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 12:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387AA284562
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06494199EB8;
	Thu, 12 Sep 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW0yoWa3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64418BBB5;
	Thu, 12 Sep 2024 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136163; cv=none; b=uFOoUQRll2wPMIs/cRJEiOtzz3TA5U4KswLPwhujj3BHJSspY0EwAoK+48T4cf8zCgwST/M7YJec8PyJ32UC13IODkUTQ2SqP1n9QYv1+iK52SWu7+K3ZG+x5DzrTSRPzSWZJQWuPlDiT7WO0kHFxrDy5fqfd8l5mrbyEd7gQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136163; c=relaxed/simple;
	bh=7ia31fMR0A+vpsMyeoe7wrNQzSw6DnAzPia3mDtQi/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubZ81z/zOE8HT3JNTCxpgZpmzS5td3SqWt43M0XvHj1gZgtk8T08VKeeyepQxZwxX6w9+w7eRf2kVnH2numvGNuHm2BNcyiuewfvA0PC22cDia3Kao7CV1Y3YdSnb9o0ejRAv/c8s92LFeJcqCo3vZiO0L6+7zFsvLM3PiuBRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW0yoWa3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb1866c00so1206605e9.0;
        Thu, 12 Sep 2024 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726136160; x=1726740960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTJzWfY3+cDmojDWu6bJjQ67EkjBtjV1XQmN5oPZvkc=;
        b=QW0yoWa3f94dJAHiTt3hLEu+fi6uRBEDt5OnlI5aTnBsukxrGlBDk3ioLFGqrdGMwk
         YsyDB/+KNdtXrTb8uesC5VghqBnJXLPqtLGxIWpQLAqkUIS/Qs9I7Zp2KhwGKm+1P3cK
         Lmh33jEobIuBPbpJnpv67luD6Fnupuppf/imXXzCrT7k3r3cceEnYbyUC/pSDPu9TvYg
         vy1x1ncoAVO8EA3F68gcTqGxaI2RKtRUBDfrMKLRZiYlqPjIblt1Kq9EGL2LIKH4vvbr
         gx6DZ49NRiloIncmH/VkpvX78DlRyIZD/5YgScKpsxlXMT9+73D9LufyFb16kP7JuK6v
         RcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136160; x=1726740960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTJzWfY3+cDmojDWu6bJjQ67EkjBtjV1XQmN5oPZvkc=;
        b=kpOfrtAp5TpJOVt3pOVfO99B30i5WayMdTLew+Ss2FsBKIldrfxCMHhyD2SJEKvpeL
         GmOS3XIzbXX+//YN4nYFuQrUEjPv3eg2qJe855hRmixTueZUCt6GEP33Ya6gyNxhq6e+
         0BcDPhIziH0QXg5MH1rjH+02Hzh4c41IgFL61MKg2ciwqzerZ3PtsXq8hICjIXyry2gA
         EGFFDZdggurCvpmxwn5UQ0kZXRMMqS0U4GRzPz1RMg0hHh4ZiHzjQnanpVhx7nJdYnc6
         dOdh2dw8qxkiT/nvTxXJmEW92r0aSjgfvpOiiP1zYAP4oHUqOHbtDQ3idbtmPrliIbOL
         Be6A==
X-Forwarded-Encrypted: i=1; AJvYcCXRDUYFfmjM7f9u8svhb4KoKf66LPB1Ub9c+e+OcqTQJDB3E751doWM/upYeDTDuCCtS/dgqv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpMYClVw6KsXBwl8YU64PFsqzJNEiyNTZrLyYVu1FwkM1CIcV
	CWPAL/I5zmYlsSWGfcUpZDbeg4Mxd5hmKfY5knhQwaIc3QqPz3z2
X-Google-Smtp-Source: AGHT+IEeOvVRKEI4bIc7kzwTYEoIGJdm4NNzlKJj2a9L7BY+kHh9FKcq1j69r5aUBglVk/DeoUadGw==
X-Received: by 2002:a05:600c:35ca:b0:42c:c082:fafb with SMTP id 5b1f17b1804b1-42cdb576f91mr9368685e9.6.1726136159499;
        Thu, 12 Sep 2024 03:15:59 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8162dsm168541255e9.29.2024.09.12.03.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:15:58 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:15:56 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Message-ID: <20240912101556.tvlvf2rq5nmxz7ui@skbuf>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="klwebu7hkzbri3lw"
Content-Disposition: inline
In-Reply-To: <20240911144006.48481-1-alexander.sverdlin@siemens.com>


--klwebu7hkzbri3lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexander,

On Wed, Sep 11, 2024 at 04:40:03PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> dsa_switch_shutdown() doesn't bring down any ports, but only disconnects
> slaves from master. Packets still come afterwards into master port and the
> ports are being polled for link status. This leads to crashes:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> CPU: 0 PID: 442 Comm: kworker/0:3 Tainted: G O 6.1.99+ #1
> Workqueue: events_power_efficient phy_state_machine
> pc : lan9303_mdio_phy_read
> lr : lan9303_phy_read
> Call trace:
>  lan9303_mdio_phy_read
>  lan9303_phy_read
>  dsa_slave_phy_read
>  __mdiobus_read
>  mdiobus_read
>  genphy_update_link
>  genphy_read_status
>  phy_check_link_status
>  phy_state_machine
>  process_one_work
>  worker_thread
> 
> Call lan9303_remove() instead to really unregister all ports before zeroing
> drvdata and dsa_ptr.
> 
> Fixes: 0650bf52b31f ("net: dsa: be compatible with masters which unregister on shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---

Could you please test this alternative solution (patch attached) for both reported problems?

Thanks.

--klwebu7hkzbri3lw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-improve-shutdown-sequence.patch"

From e9ffae9325d1bf683e455f78ac1804b3612a4fd7 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 12 Sep 2024 01:14:19 +0300
Subject: [PATCH] net: dsa: improve shutdown sequence

Alexander Sverdlin presents 2 problems during shutdown with the
lan9303 driver. One is specific to lan9303 and the other just happens
to reproduce there.

The first problem is that lan9303 is unique among DSA drivers in that it
calls dev_get_drvdata() at "arbitrary runtime" (not probe, not shutdown,
not remove):

phy_state_machine()
-> ...
   -> dsa_user_phy_read()
      -> ds->ops->phy_read()
         -> lan9303_phy_read()
            -> chip->ops->phy_read()
               -> lan9303_mdio_phy_read()
                  -> dev_get_drvdata()

But we never stop the phy_state_machine(), so it may continue to run
after dsa_switch_shutdown(). Our common pattern in all DSA drivers is
to set drvdata to NULL to suppress the remove() method that may come
afterwards. But in this case it will result in an NPD.

The second problem is that the way in which we set
dp->conduit->dsa_ptr = NULL; is concurrent with receive packet
processing. dsa_switch_rcv() checks once whether dev->dsa_ptr is NULL,
but afterwards, rather than continuing to use that non-NULL value,
dev->dsa_ptr is dereferenced again and again without NULL checks:
dsa_conduit_find_user() and many other places. In between dereferences,
there is no locking to ensure that what was valid once continues to be
valid.

Both problems have the common aspect that closing the conduit interface
solves them.

In the first case, dev_close(conduit) triggers the NETDEV_GOING_DOWN
event in dsa_user_netdevice_event() which closes user ports as well.
dsa_port_disable_rt() calls phylink_stop(), which synchronously stops
the phylink state machine, and ds->ops->phy_read() will thus no longer
call into the driver after this point.

In the second case, dev_close(conduit) should do this, as per
Documentation/networking/driver.rst:

| Quiescence
| ----------
|
| After the ndo_stop routine has been called, the hardware must
| not receive or transmit any data.  All in flight packets must
| be aborted. If necessary, poll or wait for completion of
| any reset commands.

So it should be sufficient to ensure that later, when we zeroize
conduit->dsa_ptr, there will be no concurrent dsa_switch_rcv() call
on this conduit.

The addition of the netif_device_detach() function is to ensure that
ioctls, rtnetlinks and ethtool requests on the user ports no longer
propagate down to the driver - we're no longer prepared to handle them.

Link: https://lore.kernel.org/netdev/2d2e3bba17203c14a5ffdabc174e3b6bbb9ad438.camel@siemens.com/
Link: https://lore.kernel.org/netdev/c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..1664547deffd 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1577,6 +1577,7 @@ EXPORT_SYMBOL_GPL(dsa_unregister_switch);
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
 	struct net_device *conduit, *user_dev;
+	LIST_HEAD(close_list);
 	struct dsa_port *dp;
 
 	mutex_lock(&dsa2_mutex);
@@ -1586,10 +1587,16 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 
 	rtnl_lock();
 
+	dsa_switch_for_each_cpu_port(dp, ds)
+		list_add(&dp->conduit->close_list, &close_list);
+
+	dev_close_many(&close_list, true);
+
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
 		user_dev = dp->user;
 
+		netif_device_detach(user_dev);
 		netdev_upper_dev_unlink(conduit, user_dev);
 	}
 
-- 
2.34.1


--klwebu7hkzbri3lw--

