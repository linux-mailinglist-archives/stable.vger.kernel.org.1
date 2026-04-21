Return-Path: <stable+bounces-240084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNw8FGA452no5QEAu9opvQ
	(envelope-from <stable+bounces-240084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:42:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62DB4384C5
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F20E7300D0D5
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297039EF2A;
	Tue, 21 Apr 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUAmSEIM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E321BD9CE
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760922; cv=none; b=CRM1IvJ3L58BI6Y6KQS/wFJRdC7NmS6oAKiAN8RIhXNGUA4q2vIZP6b/92RxfimSpQ6ckKYwDl1w4RsYtUkXdI20/Y04zC9Lk6Btk43F7CwJyXTNzY435o+tzBO5nGhwQLSNjVY5iPDrLcK/7K9lDswQEoi8G+zC5Q2y/GMVP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760922; c=relaxed/simple;
	bh=jZ5lz8/uZRKsTXv/mUPmQRlRmDWApz84x/Zjh1FsXio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx0jFkyoqZdIooeYoxldSmG8T/eEuW9b5ZHGFUvmHruUgHNIJMK4sSXpXt4W7Hje5pOkXiDzhq1CS3cxJsQT3QNpC9jniYaExq8BQvZeqAxydsczOdtlchdlAOfuMxSDRgMqReTWkQH0QDLKQCiLIrKT56q0KswoJmUPThSM8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUAmSEIM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso39498265e9.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776760920; x=1777365720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBMY1466HCKMAYG0Hg/+wwmeaNUqKqMxSIOQdf9oTsE=;
        b=WUAmSEIMnHHf+XiS90mxtYEvSVn7Tuo28VFojt2yugqIZrnwi7Sl2Rxx+sAFSq9IoP
         PyhfrCvmwP+M9Yn4u0AR6UYsxXvx4aHWQAHDV4crqz/K1ELei7L0UjGQYRS5wRBArDhn
         Wsm+W6U+5Eo3h3PXVaNp1YUA1A05LPYZO4frTEfD1Mdi6ZZMeiPdTzeQCYS+HjvuY4UL
         pgXcFUx/bkLimscyq4bMJLC0yWfsnmlMQgbknHWbpD2NjbaRmjdScZOTACBbZc00yari
         r9SPXYB24zSypGbJlqhvcIEpp+lW841w0MtxFQCIz/1IKoqzuKDLMxBe+BlpZMVpWBM+
         NX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776760920; x=1777365720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBMY1466HCKMAYG0Hg/+wwmeaNUqKqMxSIOQdf9oTsE=;
        b=CgDdrvxCEWFIkDxkP8qXtGEmfmEhieaDyr9t9URbBYDBVuQyRBGDIUIQz9uX8X2EZN
         JAawEJOv8HrbqYTLnBVzNvXIrHliYHIZ7X3T0IISCTXRn0XCntvcw9insV6ZZFQJzzkM
         Tc8R2obXrZH0vSi5EJXjV0cNFmgXdhGnYqtoi+pU5oOEnZB0zKXiZeWhOW1dBqCdYUCQ
         9Pz7m9zjRRzGoYyhFMRW4L1q9g/FcxaYF+oQTYCs74sY+IDxz/lSd70J4nmOAVRrUx2j
         HPvM95kek96gNYuZk1SFi15bjGiMwWyO++ACFcMlWlUs95X3p9FVt+tWBNygH84QDu7j
         POzw==
X-Forwarded-Encrypted: i=1; AFNElJ9f/MNC6wcYThjP2JWYBbJ2/uklZ0S54zxVbPRe6FVmPfaMgWE+KzKLmx2c+bqR+ogS/RjhIfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJD5aJ/3cczvEE5SZSQIPckJRGd/5dSBW8rTq1t/gILnT9Pczb
	77b0v2k2I4EO7fMBXWFg1hfocF5i24k+d6EwcrQ+SmeBVA/gV+zVRV2j
X-Gm-Gg: AeBDiet3ppM4YmObkYJ/euWNmi932VisYThVoyob3H06D/WKTE/ZfwukNpKDHgsuj5r
	xGQEOkQqW4TvP2OXGBaSWkfdE89OIXGYi1mcsVdcDjM/Hu2WQgQdDFzMlD/NIAKtnKBZ5tyL4oY
	nPF00s8s9ivoq33H5HPXTUmlCwMk6saYQSZ2iCcjcfUWREBfKxPcQV/BODZYwYeg64VcGIpgcyw
	bZr4ZdrnVu+v7N3oNSK8gXFZ7Pnz01lv8K7dsRiasrLEZ0lcjJGwRt5iw8VAUJcaTeEMibtE9nL
	5FuO7ABQUJxS47eyh5GV9/pIzd0vgIqCZnMF68otp3wX3IyOvoKfWZUonxvtfkASWrx40wV/0PX
	YUlxkrTt5LycZ+i/uy+qnr7dekueAuILYZMn8+jBiAwHzPAtMCnE9b5hCU5dVNEoia2Iac7FgXL
	9g8Bwqkq55Qv+QBDj94oJ0ywmYTk7bPV473QcBTUeN+0AOEvmI806lp9KCVOFLokqVSBgQhOYIa
	ts=
X-Received: by 2002:a05:600c:c0c8:b0:471:700:f281 with SMTP id 5b1f17b1804b1-488fb78b8c5mr189038665e9.25.1776760919528;
        Tue, 21 Apr 2026 01:41:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm372071945e9.2.2026.04.21.01.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:41:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:41:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 net] ax25: fix OOB read after address header strip in
 ax25_rcv()
Message-ID: <20260421094156.0fb3499a@pumpkin>
In-Reply-To: <20260421054626.732399-1-ashutoshdesai993@gmail.com>
References: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
	<20260421054626.732399-1-ashutoshdesai993@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240084-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E62DB4384C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 05:46:26 +0000
Ashutosh Desai <ashutoshdesai993@gmail.com> wrote:

> A crafted AX.25 frame with a valid address header but no control byte
> causes skb->len to reach zero after skb_pull() strips the header.
> The subsequent reads of skb->data[0] (control) and skb->data[1] (PID)
> are then out of bounds.
> 
> Linearize the skb after confirming the device is an AX.25 interface.
> Guard with skb->len < 1 after the pull - one byte suffices for LAPB
> control frames which have no PID byte. Add a separate skb->len < 2
> check inside the UI branch before accessing the PID byte.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> v5:
> - Move skb_linearize() to after ax25_dev_ax25dev() check; avoids
>   unnecessary allocation for frames on non-AX.25 interfaces

Nitpick: 'on interfaces where AX.25 isn't enabled'
They still have to be AX.25 frames and get discarded.
So they won't really be expected and any allocated memory is
immediately freed.
More relevant would be linearizing before the ax25_addr_parse() call.
In any case I suspect this code never sees non-linear packets.
The packets will all be short, I don't know ax25, but X.25 (which I've
implemented most of in the past) originally had an mtu of 128 bytes
(and real links running at 2400 baud).

	David


> - Lower general guard from skb->len < 2 to skb->len < 1; the stricter
>   limit incorrectly dropped valid 1-byte LAPB control frames (SABM,
>   DISC, UA, DM, RR) which carry no PID byte
> - Add explicit skb->len < 2 check inside UI branch before the PID
>   byte (skb->data[1]) access
> v4:
> - Linearize skb at entry to ax25_rcv(); replace pskb_may_pull() with
>   skb->len < 2 check (per David Laight review)
> v3:
> - Remove incorrect Suggested-by; add Fixes:, Cc: stable@
> v2:
> - Replace skb->len check with pskb_may_pull(skb, 2)
> 
> Link to v4: https://lore.kernel.org/netdev/20260417065407.206499-1-ashutoshdesai993@gmail.com/
> Link to v3: https://lore.kernel.org/netdev/20260415063654.3831353-1-ashutoshdesai993@gmail.com/
> Link to v2: https://lore.kernel.org/netdev/20260409152400.2219716-1-ashutoshdesai993@gmail.com/
> Link to v1: https://lore.kernel.org/netdev/20260409012235.2049389-1-ashutoshdesai993@gmail.com/
> 
>  net/ax25/ax25_in.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
> index d75b3e9ed93d..c81d6830af48 100644
> --- a/net/ax25/ax25_in.c
> +++ b/net/ax25/ax25_in.c
> @@ -199,6 +199,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
>  		goto free;
>  
> +	if (skb_linearize(skb))
> +		goto free;
> +
>  	/*
>  	 *	Parse the address header.
>  	 */
> @@ -217,6 +220,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  	 */
>  	skb_pull(skb, ax25_addr_size(&dp));
>  
> +	if (skb->len < 1)
> +		goto free;
> +
>  	/* For our port addresses ? */
>  	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
>  		mine = 1;
> @@ -227,6 +233,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  
>  	/* UI frame - bypass LAPB processing */
>  	if ((*skb->data & ~0x10) == AX25_UI && dp.lastrepeat + 1 == dp.ndigi) {
> +		if (skb->len < 2)
> +			goto free;
> +
>  		skb_set_transport_header(skb, 2); /* skip control and pid */
>  
>  		ax25_send_to_raw(&dest, skb, skb->data[1]);


