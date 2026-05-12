Return-Path: <stable+bounces-245405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UISzGPzSAmpJxwEAu9opvQ
	(envelope-from <stable+bounces-245405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:13:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C9E51B8D7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A0630861D7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BBA379C42;
	Tue, 12 May 2026 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJMwEO8t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pKU8V+Bd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E40379C30
	for <stable@vger.kernel.org>; Tue, 12 May 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569625; cv=none; b=jU4/UuaBEep3h/Vm9A+F48+DkKL7xK7J6i7tgJA1sl8JPxDMvvti+QroM9+0iuNyER2HfW1Kow4WQNfxwdIWvZwTzf+F/AJ4Jr+x6CZQohc0806TQLRfuAYyX3A8oxF+fe24zNmR9RKE5l8u8kkaCRHSA9qsCwS27yiagjNVOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569625; c=relaxed/simple;
	bh=vS9bD3PJ6QBZRXfBeufUTv14f2N0oWCBZ2zQWoQYBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyqnCfgSl95++8h8k0rQ5FRbdo9688JLeSWw84vkNMh3LhRjXhDT7Ab7GqRfF9Mgt3ZtZTSOQm3gpZs9ykj6Q6OsvpD3kjy+zFIDI7rhQIuL6Y1XVWw21ETOx43+hXomrICi60cuNAtGMAhuNNB4eWMn+jNxTF2qts5Vi3nSNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJMwEO8t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pKU8V+Bd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778569617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
	b=GJMwEO8tv6QtR6qDflyt0mCGRnsiVChuyroUbQYLzhc/3v/oqUeeq5K39rcP7XPyQY8lyK
	w/Pv+rwgo2T41bqh+FJ+ZyKZ39Sb4r1/7w1wGoAFAxX+eucBhguyXF0cD0fQvZlcWjMRG4
	pBcPhmYvlqMKjbTQcVGev0hlrg4Mw9c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Tbp69cS-MDmvr4Vs6gIF3Q-1; Tue, 12 May 2026 03:06:56 -0400
X-MC-Unique: Tbp69cS-MDmvr4Vs6gIF3Q-1
X-Mimecast-MFC-AGG-ID: Tbp69cS-MDmvr4Vs6gIF3Q_1778569615
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a3aee3813so2643437f8f.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778569615; x=1779174415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
        b=pKU8V+BdcYL2C2ens4Jnikn9y71oQ8Wz7BcQUa1MpgaxYfdSrv4qCLHxCz71FBy038
         cjWNbSLk/uVD0K1jzgHyk87ZMKMPTuaHg4rTrKTxbUy8O8zeKloAOi52JqauQiVDe0tT
         LjjZM/AD+IpSAgcplCR94NvZgI20PKw+461tCW7FZL53LnhLX1KOPcrDhE9nyftIyFsQ
         1vAPYID8Nr4PGgdMBh2/Vj/dm9yJlbcQ3Q+9Q0u4gB4RBWgsai7aPjamHSrNn6cjG8Rv
         7dob7I3NhsmJnaG/MR49CtkkGL+JSfQ9+JIBQ/zn+0k60D24j09QTsiUjq6xL8KssnV/
         CxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569615; x=1779174415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
        b=ERMYjL+80/RRT5hVPibASdIakcNfoZv62rr02OTbv/v7hgkRFCotRGHPedqIX2x6V4
         n0Lc+jPwLpnwpe0nBvk9xhJvSAbb0pzZFKu/U4LPYbSw3ZElsoslUibA/q4WvfaMhU2I
         n/ZAkzSb1vRR6XT9jDaZJQptpMuM468f+BNRP4+TOMIOsZXC5SNbHNt8i/OuUrIO0LZU
         jy0dOer9cQppvneAMgfj2ru/wzJtwT7K0TPlqX58uJ5iK0RdgOmsE178rz+jnXe3p2pg
         FKR3HDaWo9Tb1cCj/P3cITcimPh0OCEdNzZ0mvx5smNLMwgax9Fc8YvGG7lhi7GrpaHt
         JIMA==
X-Forwarded-Encrypted: i=1; AFNElJ9XuSWIpMfwtbkridoAqIQ6WN5owlBKkDsjHT7anuViwn8GGlnjJnT3dWgvIpmExRC+QrYdOdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwutmBpb8v2vhJJ5W9mnzHzI58zgmVkjzs11fMv9zanCx9RK3hY
	2Swd80mDynkxHLncpZOnu/eHF6mm2UhG7NPowHh5gV3UIBzmIUC/hqNTLshW2SpVGXp2pDyCg0X
	por2U98vhPJiT2gibnu479FWHdfy9w9KwJz+4HoogoaDUbqaXGt69tFIp1A==
X-Gm-Gg: Acq92OGY+LX3vL1AS1s111ZQejQ80SUBm+gNZkv2ekt4SaKj1zXrkgn/Bua0z8C7Iyu
	756uBHiFKnxu4M7RQfppaNyeLQaGvLRR36ZfFXGqp4H0+Xysc5g7Kp7raZJ28xR1/6FKzy1knxT
	IMzRijj3IUN4Qbx+6X+fKcHvz+N1nC4cCt5Qbo8ycHlEZM4abmOcOtTi5ZVzT9dRx96HjK+MFID
	PWC13w04qU2ZO70ECDRLOYh6UWAe/AvH3MVrfzeTPEFvVp4E4CcMsyFHt8yPgkwgeO5vieaGdRK
	aAE0Lm0yU1M9nqdu6AmTrREEEnFDzARmlfKoFNBvJis8mazlsMRKJAvx08UA6kwWUPSDD8TJmSI
	1y+l4qVd6oduyofGhkhGh3YZpTcc5lVtuVtgZYxrucHhUldO7wmAmHbE543U=
X-Received: by 2002:a05:600c:3b08:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e8fe80569mr22966015e9.28.1778569614941;
        Tue, 12 May 2026 00:06:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3b08:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e8fe80569mr22965345e9.28.1778569614432;
        Tue, 12 May 2026 00:06:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052cd24sm24611725e9.3.2026.05.12.00.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:06:53 -0700 (PDT)
Date: Tue, 12 May 2026 09:06:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
Message-ID: <agLRfHBHJ2990NJo@sgarzare-redhat>
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
X-Rspamd-Queue-Id: E8C9E51B8D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245405-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 09:58:51AM +0700, Minh Nguyen wrote:
>vmci_transport_recv_connecting_server() jumps to its destroy: label
>and performs an unconditional sock_put(pending) to release the
>explicit sock_hold() taken by vmci_transport_recv_listen() before
>schedule_delayed_work().  The existing comment claimed this was safe
>because the listen handler removes pending from the pending list on
>the way out, which would prevent vsock_pending_work() from dropping
>the same reference later.
>
>That assumption breaks for a peer RST.  The default arm of the packet
>switch sets:
>
>	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
>
>and vmci_transport_recv_listen() only calls vsock_remove_pending()
>when err < 0:
>
>	if (err < 0)
>		vsock_remove_pending(sk, pending);
>
>For RST (err == 0) the socket stays on the pending list, so when
>vsock_pending_work() fires it takes the is_pending=true path and
>drops all three references itself: the pending-list reference via
>vsock_remove_pending(), then the two trailing sock_put(sk) calls.
>The unconditional sock_put() in destroy: had already dropped the
>explicit sock_hold() reference, so the second trailing sock_put(sk)
>in vsock_pending_work() is a write into the freed AF_VSOCK slab
>object.  KASAN reports a slab-use-after-free write of 4 bytes from
>refcount_warn_saturate() on the workqueue path:
>
>  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>  Write of size 4 at addr ffff88800b1cac80 by task kworker
>  Workqueue: events vsock_pending_work
>  Call Trace:
>   refcount_warn_saturate
>   vsock_pending_work
>   process_one_work
>   worker_thread
>
>Triggering the bug requires only the ability to open a VSOCK
>connection to the target and send a RST before the listener accepts.
>
>Skip the sock_put() in destroy: when err == 0 so it only compensates
>the cases where vmci_transport_recv_listen() actually calls
>vsock_remove_pending().  RST is the only path that reaches destroy:
>with err == 0; every other path produces a negative value, so their
>behaviour is unchanged.
>
>Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=y,
>kasan_multi_shot): same trigger binary, same VM, 100 iterations:
>without this patch 52 KASAN slab-use-after-free reports fire; with
>this patch applied, 0 reports.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Cc: stable@vger.kernel.org
>Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
>Assisted-by: Claude:claude-opus-4-7
>---
>v2:
>  - Resubmit to netdev per Stefano Garzarella's request after v1 review.
>  - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
>    enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
>    same VM, 100 iterations); test summary captured in the commit
>    message.
>  - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
>    bug is no longer embargoed.
>  - Rebased onto net/main (no functional change to the diff).
>
>v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
>no public link available).  v1 review summary, for reference:
>  - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
>    vmware guys on this that know this code better."  Asked for retest
>    and resubmission via the net tree workflow.
>  - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
>    me."  Also noted that no modern VMware product allows guest-to-guest
>    VMCI communication, so the practical attack surface is host -> guest.
>
> net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 4296ca1..88d7128 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock *listener,
> destroy:
> 	pending->sk_err = skerr;
> 	pending->sk_state = TCP_CLOSE;
>-	/* As long as we drop our reference, all necessary cleanup will handle
>-	 * when the cleanup function drops its reference and our destruct
>-	 * implementation is called.  Note that since the listen handler will
>-	 * remove pending from the pending list upon our failure, the cleanup
>-	 * function won't drop the additional reference, which is why we do it
>-	 * here.
>+	/* Drop the reference taken by vmci_transport_recv_listen() before
>+	 * schedule_delayed_work() only on real errors.  For a peer RST
>+	 * (err == 0) the listener leaves pending on the pending list, and
>+	 * vsock_pending_work() will drop that reference itself when it
>+	 * later cleans the socket up.  Calling sock_put() here in that
>+	 * case would be a double-put and free the socket while
>+	 * vsock_pending_work() still holds it.
> 	 */
>-	sock_put(pending);
>+	if (err < 0)
>+		sock_put(pending);
>
> 	return err;
> }
>
>base-commit: be48e5fe51a5864566307998286a699d6b986934
>-- 
>2.54.0
>


