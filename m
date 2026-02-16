Return-Path: <stable+bounces-216747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIsbKQhlk2k44QEAu9opvQ
	(envelope-from <stable+bounces-216747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 19:42:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED21470A1
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 19:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E113023DE5
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9452E0B6E;
	Mon, 16 Feb 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEupHhnd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500C2857C7
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267333; cv=pass; b=uRxL6+ikJeOj/hYvGy0SN7aHT3y6y+D5B+VO7F9oEF5eO8vP7kXYJoO64hS+yNlfmZ2DLSUCv5zgI9lOj5IHT+MFNUswrhJzqaf1Hd9jo6ghonFbljbzhVmDAQmCvamCW1Cg0Lp9XT9AYQ+bhGvsCJ9rMirDklRSq7gOE7ko5TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267333; c=relaxed/simple;
	bh=sW3gn4yQPlaPoWjm2CuZYRqLjL1+PUt5QbFFx+MeBC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsLI6tiynLQp1iashGqDQUAf/BVBMEtvL8MEwRwyUcMDkI3rbGiST5l4pJUrjOYFK64yUxDr7skHdeI77GH+OOHcsc4B75E6witWYXboyFnScaLBDi1RCHQp5TkuyrhGoZ2FQXag+JBcjFhQh2IdX+X9Wm/4dSW9vMVrTUGHSy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEupHhnd; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385d9fb297dso30493421fa.2
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 10:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771267330; cv=none;
        d=google.com; s=arc-20240605;
        b=W0ztUopyDQrZNSAICf+LtS7DUt3N21dddDwyYUOhrYOqGJrUazAJcLgBuQNiYz4uKM
         WcdswkQJG0rzVFlW8OutXj1CL941tH/hXzoAc9Gi0XqcfkD2JKuVTmzP0rwdSFHX8eH6
         WqGctlI9QS0sdFgvMncWY/V78nBBGursRLgAWhFd9v0GoPLBeP91ExtA5W7FY7e2gxQk
         0LCByp2G7W5u/8W4wD3ZI7cYLHYWUtOfU1OBbPQXEgYmF8aq2pYT6B7oQg4BbWyhDIGq
         3TH5Q6uadJFTCzGPK8It5MjznOCJq0vWA9XIU1/w4h++7tnYn2GKCC8omBRKgGzz0jnX
         d1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sYcdHAZE7bf18F9pcjPcdAYAYt70z23K4XKrnhjTE7c=;
        fh=KERlnmb7EOJsQuObaCb3VoyPJxDtZsX1KX9DYH+Qa+A=;
        b=Uza48+A3Y45FFvXGibbjbuz/1OFCluzgpM7ashoAY/dW/4AaXcLO7uDQfEdKPI04Ta
         iXBm7blwAEMrmfpCORIKJxFN87c19IZrXaTThJRX+2mRJ2p6hbhFvIYm4JcXxOaGEUnk
         Z/iZVw1q9qY9KJGSh9oISrBQYfDhwsrRSPB62HWJZ0tn4XyeKHvAFy2PabtKzY5TtH/h
         B2nkLyAEWwhfTFz5mw5ivl0AEHAHLJbsvEMSrCFcIYA6ceNzEjEbjxUGflcae4Zybqgv
         JI7xvkCgenWQzZNvdUtCCmPmYpn/ZDtHLVaOZuWLtk3lD88+c+HHzDiKrlf7cseckJo0
         co7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771267330; x=1771872130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYcdHAZE7bf18F9pcjPcdAYAYt70z23K4XKrnhjTE7c=;
        b=OEupHhndZ8lARs/qsNj3d4PywpSQqcW2Ejlr1giFiWQfDWapYn+6SLZCkVltq4WLLs
         Ypu+S0wUWd7gR1YJamnILoJxgPcGmUDiWm0AZLR7Z+qcMK17pXagrQsNKr3UXQw0UI2e
         lUupQAQmZmcqBP3ayNaeYqsHY1oPTIW+Ikd8p5tHjplPQ2soJq5tpqysraRPDycyhRRT
         PUGC1KM2x4aPtfjPajCe/DC/Ps7Jlx+pRkX2m8CSCer2n6d/7/EXBXPFH0fp3BEYtSW0
         1WpNylYd7znfqvgqOoDXY3GcFHgZ9a2otIlXyHswrddL5f9ECrc2PQBbYWM1ao9nyMh8
         /fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267330; x=1771872130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYcdHAZE7bf18F9pcjPcdAYAYt70z23K4XKrnhjTE7c=;
        b=iCAMxrja6I6PyTaT2iadg34/WOOI434G/H1nCDuRrCTKfgR61B+M0zh7q2xM7Vgz7P
         MoOnqbTbJYhCq3c4Jvg9W7bSalMLJCn5fh6E1LrSQbuR3w4nu3yDX2iYYQLBrkENn813
         mZWA1NCjJSXVGX3/YJ2/Mgw4FjYOTgDcLovJbeGJSLj74B4rLQPMdNu4Fy7FicIoQvhQ
         5jem5ZD8l5IDrnzYjEeutANQmAft9Ax/tWXkd6+12lRZmO4Davl2CgN+S/mzeHvA6M/S
         RD9pbUUk1E3yn4fDKKy8Su0ikg/i0QcbmQmUXEApW/a4j66hUSeLnRa9DkccLCBi1cbG
         dvGA==
X-Gm-Message-State: AOJu0YwC0wyygdFBdJkVp74Hiq5xizmUx7Q2N0QcpN9kRafw0hDoxuiu
	rWgyrRk3t0omZuUXdzpEWw5LaKMnXmRXfmOKNxGNKn16Ck83U9VIcgICGgs7corQ6pEQGKi43c6
	CKpqsASR9xtu7oq3IxeAbRgSDvDrrf/cZ4Snot6PR
X-Gm-Gg: AZuq6aKf9sSA7Y3kWImKS8i6cb5U8QbkqeBi2OSK0uECsbQncC8WM03gHtJx1d3iq4R
	njWgNMj8j2jNoFS+Rwzl+co5WpekZ/2hkwtrJZ2BcHA2l3JBF9bGumshZ243v0wFHF30sFewYDT
	iEVTnTXyYCzjWJNoeRaBxBlDS2G4Gbi57gP/UBrYaSbBMVDQxk5+FY/3wm/CUWlXgu4CirWLrB8
	/jlA2sefrXF8RumfSvm/0ZXG5Etd1McUx6RyEiIcIWtIrOb66OZo9CQcAW0CIVzBiCU5eR5++Kw
	pAE2INUMBjh2Abbg
X-Received: by 2002:a2e:a54c:0:b0:37b:b140:e512 with SMTP id
 38308e7fff4ca-3881051537dmr33113841fa.10.1771267329954; Mon, 16 Feb 2026
 10:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213211702.447894-1-joshwash@google.com> <20260213211702.447894-4-joshwash@google.com>
 <2026021654-catsup-occupier-6753@gregkh>
In-Reply-To: <2026021654-catsup-occupier-6753@gregkh>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 16 Feb 2026 10:41:56 -0800
X-Gm-Features: AaiRm50LqqBjUkgEFWRz9HWiX3WxtRa7-81Y5xhCxWaHQ7o2fWC1MwJTaUkuLts
Message-ID: <CALuQH+UsbSxrOwkdUba=AFO7dDOrdtLmM5NOpQ__ASNW0GF5pg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] gve: defer interrupt enabling until NAPI registration
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ankit Garg <nktgrg@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216747-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 04ED21470A1
X-Rspamd-Action: no action

Hi,

The original fixes tag was unfortunately attached to a commit that was
introduced as part of the 6.9 kernel. This mistake was made because
there was a significant driver refactor made to resource allocation at
around that time:
https://lore.kernel.org/netdev/20240122182632.1102721-1-shailend@google.com=
/.
I did not realize until later that the logic being fixed should have
been backported much further back, to the initial commit of the
driver.

I will send a V2 with the suggested changes, thanks.

Josh

On Mon, Feb 16, 2026 at 1:58=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 13, 2026 at 01:17:02PM -0800, Joshua Washington wrote:
> > From: Ankit Garg <nktgrg@google.com>
> >
> > [ Upstream commit 3d970eda003441f66551a91fda16478ac0711617 ]
> >
> > Currently, interrupts are automatically enabled immediately upon
> > request. This allows interrupt to fire before the associated NAPI
> > context is fully initialized and cause failures like below:
> >
> > [    0.946369] Call Trace:
> > [    0.946369]  <IRQ>
> > [    0.946369]  __napi_poll+0x2a/0x1e0
> > [    0.946369]  net_rx_action+0x2f9/0x3f0
> > [    0.946369]  handle_softirqs+0xd6/0x2c0
> > [    0.946369]  ? handle_edge_irq+0xc1/0x1b0
> > [    0.946369]  __irq_exit_rcu+0xc3/0xe0
> > [    0.946369]  common_interrupt+0x81/0xa0
> > [    0.946369]  </IRQ>
> > [    0.946369]  <TASK>
> > [    0.946369]  asm_common_interrupt+0x22/0x40
> > [    0.946369] RIP: 0010:pv_native_safe_halt+0xb/0x10
> >
> > Use the `IRQF_NO_AUTOEN` flag when requesting interrupts to prevent aut=
o
> > enablement and explicitly enable the interrupt in NAPI initialization
> > path (and disable it during NAPI teardown).
> >
> > This ensures that interrupt lifecycle is strictly coupled with
> > readiness of NAPI context.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engin=
e Virtual NIC")
>
> Why did you change the Fixes line here?  Did the original commit lie
> about it?  If so, that's fine, but this is really going to cause tools a
> mess to keep track of...
>
>
> > Signed-off-by: Ankit Garg <nktgrg@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Link: https://patch.msgid.link/20251219102945.2193617-1-hramamurthy@goo=
gle.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > ---
> >
> > Note: This patch has been modified form the original to re-introduce th=
e
> > irq member to struct gve_notify_block, which was introuduced in commit
> > 9a5e0776d11f ("gve: Avoid rescheduling napi if on wrong cpu").
>
> Can you put this in a "comment" above your signed off like:
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [ modified to re-introduce the irq member to struct gve_notify_block,
>   which was introuduced in commit 9a5e0776d11f ("gve: Avoid rescheduling
>   napi if on wrong cpu"). ]
> Signed-off-by: Joshua Washington <joshwash@google.com>
>
> Also, it's "from", not "form" :)
>
> Same for all of the other backports here, can you fix them all up
> please and send a v2?
>
> thanks,
>
> greg k-h



--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

