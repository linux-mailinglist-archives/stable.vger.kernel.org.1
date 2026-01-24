Return-Path: <stable+bounces-211469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGxAN0AZdWlVAwEAu9opvQ
	(envelope-from <stable+bounces-211469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 20:10:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3345C7E943
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 20:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DE93013AA0
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EAE26561E;
	Sat, 24 Jan 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6YNR1dP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212421773F
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769281840; cv=none; b=dDbbMziDXYvoRmzFBXeCw1qCQhmSNPZnq/6uwxeWKlj2KHw2vyUUPfS4pxjHICD31pfT6PNV4lufNcm8nTbmY6SwGDY4edAXQ5bioOXABry6NEr3sUE9DxXHRbknyVvaUOsZ6QQrgUWiW6Zij2qE5P8enArp/vpZosxSMqHqoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769281840; c=relaxed/simple;
	bh=WYmylhlnxg++jo/vtjrtnmoqDXDhbH0F9J+5FRINfp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNf25LnYaTPlvHx1CVTwvssiYpUPDuiEXrlgVMGk5yJfRAs6DKyaEFM0cgqZfm7zlNeDwIywS9A2JI/YnxbN8dw/1/DxkHX7UOqMvBCLcKzuzypwADNgi6/JkZ+QxA4AVmxFdd9XzjPiLqB3jvXoMU9uYFBjJCr95pz/p11O688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6YNR1dP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so3371722f8f.2
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769281836; x=1769886636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zvjiNMXqNXn3CIGev2BIjc6WsB/YpEeQXxxmz/nUT8E=;
        b=b6YNR1dPT39/r7NQ251mxnzU4G3fLQoRWUbeLAIn30jLe6KQ+72pr494xXDWsTGJ/V
         TX0XD3n5c/W0yoNbjdVrZSoert8eflZpIRB9tl/yG9BfGoBgM6tJjIYv5YqQ4pJG9UbP
         scuBRoHgRNUbakpgN7D9I1W+hPbMgXMJPQEeDXCjvnlz+V/l6nsokdG9aK3pqO9Og/dw
         s62jst3Q94xmkJ4/huwqSnQSekR5qlggyDx2AoRYvch4wnn+xujDd0jhmPBFWlKvhu63
         I+NZ8QDhT+A4mnhKzd0jRYCAuX4lV9ZZ+m1c6OghVfjddKLd2EWwRBQNMLam6q2LmoyJ
         qTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769281836; x=1769886636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvjiNMXqNXn3CIGev2BIjc6WsB/YpEeQXxxmz/nUT8E=;
        b=i2aYe0BrNkn/eTJxXGxYT6Ax9LzZODA8+OhAdaEoQZbAo65Ux1Mmgt2+5kLj4t6cf7
         aj3zRb/vgHNDrBID4xEMvNxQ1PgKbOLErlEUDLZHJIpxE39C7tozVzXtUicMaUs6qEET
         IgIgPV4ERGYGOqeETPnKG9S9KCUPR/uFLATL+yZ9c1l+Nm6Lm0BBEoAkRFPQSrvsxizk
         9LuMqs0q2OH/1GfSwMwBO3551N3PNMZkdh0hvKTxplsA3yYjPqk+skBg7MeEk7unxdDE
         Mxy6iu7WZANqW0c1RajFZUL1TZA4e2IxBEBw3iejhEV/KbEoJnaP40zOWuu4qlKwOD9y
         e6cA==
X-Forwarded-Encrypted: i=1; AJvYcCVWmCFio2+/00cnkWRUH3phMPehWHFDj1QqIs35pBOhT+GY+m0rNZ61WD5P6+evy5dfESDqoqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfzTFsKuGyuiSAvnmfIyjen8b8Onsa6bJn2tj+n6b1hpH9oUX2
	yZJwCB6wuekXbs/FIZxB4Y470LogU334ig3zdOirI1UPQl10bi+q87uY
X-Gm-Gg: AZuq6aJk0ufk2W8bA36bUF/5YchTnPv8y0Fr/+l79VmjbWTbFedx/PI9Vr7US3bXwTN
	vjdpxKBZjPrcfpwNzNH5Os1QP8ulyYzmkGmhh1Av63rRIeunqSQk1zINKgukIscsM6YxrJdS+JH
	NeV3fzYnl6qWo+E+rZ93wG5pBS8/45qfWLTrWz0hzQwDBXlArfPAyiMWga8mkOqXtGQwbmncFen
	N5+eLSjaHHEbkTAyerRJS3b/RxV19O+NJnkrXoTct2vvEiS/pQO9Vy9+v3J0loWmGiBSSuJxRRj
	5EwhQXMk23LdalzXU3eCO+jpnTZEL3IdDLsTordGj5Vyfxm8ry6Hg3JDHIko/QsFhdIFjkjNQmo
	Ly+psaOsaQzSvYecISj52UVhd9+MT/tP6ves4DpnqTVdiHkjpY7nVlXjltHqcib8vdEivPIQi1f
	ZVGGyapMgrGQmlW0ggIpB2wWZwkbNG0kzc6Zm1Lgr2Yts=
X-Received: by 2002:adf:e845:0:b0:435:bd00:cb4 with SMTP id ffacd0b85a97d-435bd000cd7mr4623096f8f.23.1769281836162;
        Sat, 24 Jan 2026 11:10:36 -0800 (PST)
Received: from osama ([156.223.77.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24b54sm16642950f8f.15.2026.01.24.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:10:35 -0800 (PST)
Date: Sat, 24 Jan 2026 20:10:31 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: caif: fix memory leak in ldisc_receive
Message-ID: <aXUZJ_xO2hGAvV6-@osama>
References: <20260118174422.10257-1-osama.abdelkader@gmail.com>
 <9a7c53ac-d208-457f-9940-ca821b08df1e@kernel.org>
 <ed294369-e463-4d4b-83c8-43df0e24c014@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed294369-e463-4d4b-83c8-43df0e24c014@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211469-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,f9d847b2b84164fa69f3];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3345C7E943
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 08:00:37AM +0100, Jiri Slaby wrote:
> On 19. 01. 26, 7:58, Jiri Slaby wrote:
> > On 18. 01. 26, 18:44, Osama Abdelkader wrote:
> > > Add NULL pointer checks for ser and ser->dev in ldisc_receive() to
> > > prevent memory leaks when the function is called during device close
> > > or in race conditions where tty->disc_data or ser->dev may be NULL.
> > > 
> > > The memory leak occurred because ser->dev was accessed before checking
> > > if ser or ser->dev was NULL, which could cause a NULL pointer
> > > dereference or use of freed memory. Additionally, set tty->disc_data
> > > to NULL in ldisc_close() to prevent receive_buf() from using a freed
> > > ser pointer after the line discipline is closed.
> > > 
> > > Reported-by: syzbot+f9d847b2b84164fa69f3@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=f9d847b2b84164fa69f3
> > > Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > > ---
> > > v2:
> > > 1.Combine NULL pointer checks for ser and ser->dev in ldisc_receive()
> > > 2.Set tty->disc_data = NULL in ldisc_close() to prevent receive_buf()
> > > from using a freed ser pointer after close.
> > > 3.Add NULL pointer check for ser in ldisc_close()
> > > ---
> > >   drivers/net/caif/caif_serial.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/
> > > caif_serial.c
> > > index c398ac42eae9..970237a3ccca 100644
> > > --- a/drivers/net/caif/caif_serial.c
> > > +++ b/drivers/net/caif/caif_serial.c
> > > @@ -152,6 +152,8 @@ static void ldisc_receive(struct tty_struct
> > > *tty, const u8 *data,
> > >       int ret;
> > >       ser = tty->disc_data;
> > > +    if (!ser || !ser->dev)
> > > +        return;
> > >       /*
> > >        * NOTE: flags may contain information about break or overrun.
> > > @@ -170,8 +172,6 @@ static void ldisc_receive(struct tty_struct
> > > *tty, const u8 *data,
> > >           return;
> > >       }
> > > -    BUG_ON(ser->dev == NULL);
> > > -
> > >       /* Get a suitable caif packet and copy in data. */
> > >       skb = netdev_alloc_skb(ser->dev, count+1);
> > 
> > Wait, the reported error is memory leak of mem allocated here. So both
> > ser and ser->dev appear to be valid?
> > 
> > So instead, does netif_rx() return an error few lines below for some
> > reason? So should skb just be freed in that path?
> > 
> >          if (skb == NULL)
> >                  return;
> >          skb_put_data(skb, data, count);
> > 
> >          skb->protocol = htons(ETH_P_CAIF);
> >          skb_reset_mac_header(skb);
> >          debugfs_rx(ser, data, count);
> >          /* Push received packet up the stack. */
> >          ret = netif_rx(skb);
> >          if (!ret) {
> >                  ser->dev->stats.rx_packets++;
> >                  ser->dev->stats.rx_bytes += count;
> >          } else
> >                  ++ser->dev->stats.rx_dropped;
> > 
> > Not calling skb_free() in this else path _is_ a BUG™ in any case IMO.
> 
> No, it's not: netif_rx() always eats the buffer. So care to elaborate why
> the socket buffer is actually leaked?
> 
> > thanks,
> -- 
> js
> suse labs
> 

Hi Jiri, Greg

Following up on v2 feedback regarding the CAIF close-receive race,
I'm thinking of (similar to PPP driver):

- Add proper lifetime management using a refcount (`rx_ref`) to track
  in-flight receive callbacks.
- Introduce a `closing` flag to prevent new receive callbacks after ldisc_close()
  starts.
- Use a completion (`rx_done`) to wait for in-flight callbacks to finish before 
  freeing resources.

I plan to verify the patch using the ReproC program and kmemleak locally, but I
would appreciate feedback on this approach before testing.

proposal is written below.

Thanks for your review!

Best regards,
Osama 

--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ struct ser_device {
     /* existing fields */
+    refcount_t rx_ref;             /* track in-flight receive callbacks */
+    bool closing;                  /* indicates ldisc_close in progress */
+    spinlock_t lock;               /* protects closing flag */
+    struct completion rx_done;     /* signals all RX finished */
 };
 
@@ static void ldisc_receive(struct tty_struct *tty,
     struct ser_device *ser = tty->disc_data;
 
-    if (!ser)
-        return;
+    if (!ser)
+        return; /* safety check, usually handled by TTY core */
+
+    /* Acquire lock to check closing */
+    spin_lock(&ser->lock);
+    if (ser->closing) {
+        spin_unlock(&ser->lock);
+        return;
+    }
+    refcount_inc(&ser->rx_ref);
+    spin_unlock(&ser->lock);
+
+    /* existing RX processing code */
+
+    /* RX done */
+    if (refcount_dec_and_test(&ser->rx_ref))
+        complete(&ser->rx_done);
 }
 
@@ static void ldisc_close(struct tty_struct *tty)
     struct ser_device *ser = tty->disc_data;
 
     if (!ser)
         return;
+
+    /* mark closing and prevent new receive callbacks */
+    spin_lock(&ser->lock);
+    ser->closing = true;
+    spin_unlock(&ser->lock);
+
+    /* wait for in-flight RX to finish */
+    wait_for_completion(&ser->rx_done);
+
+    /* safe to free ser and associated resources now */
+
+    /* optional: re-init completion for future opens */
+    init_completion(&ser->rx_done);

