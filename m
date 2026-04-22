Return-Path: <stable+bounces-240302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIG1G7yY6GkwNQIAu9opvQ
	(envelope-from <stable+bounces-240302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:45:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 871454442C9
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D6823030DCD
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58143C3BFB;
	Wed, 22 Apr 2026 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4PVpMAA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeRRzpV0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12C20B22
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850819; cv=none; b=iw20V2XclqyNLsmfcnIjNpjwOptqJ65V1OwrijmYPhCC1LWWGxnKg6BvnfHFR05nB6kAs6uCmqtyqFr7TBJYBwzDrPhO7zNO/hOmVeMK/jrCwVcS+/B253y99CNxFNJ/Pfd8oDvOyh6PfO3ldsQvAR93R/dJEBdZZEOy8yU1cSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850819; c=relaxed/simple;
	bh=zAkck15aRQTZ1Q05U2YBuMYW04iQrWlQkMLWra0PA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwbMqyC3qaFTA4DnkCDrxXyhWRgkDio+JDaqt2A7nX76ltGwi5oApPcCnjRACPnSto46HwHkL5f1PvjB5/InHNZ3FMjc0soPAf66GWZ1lsD9nbPBeEJm5ngv0QK7BS9SLSClEnSXzZ5I3paFomR5ob75Qj96PVD0ab2Cl1ybeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4PVpMAA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeRRzpV0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776850817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
	b=C4PVpMAAWteYzwyy/Swrt1q83Hel8TZTclJR3+MW4SBSXh2+J7jbhePxrXvLblIMKPUvSk
	44W/QrQEiL52aaULdFlaMRk8HvaGaA2eNEWAuRFrGYQvDuUS3wKT46qKHrHG3YiOIa1qQe
	b90KVG8jTiIvE6UtZ+hgbrdPYfG4iCA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-6ZtDWtq5MUeRaMm1m8xnvg-1; Wed, 22 Apr 2026 05:40:16 -0400
X-MC-Unique: 6ZtDWtq5MUeRaMm1m8xnvg-1
X-Mimecast-MFC-AGG-ID: 6ZtDWtq5MUeRaMm1m8xnvg_1776850815
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a5adc12ffso3471035e9.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776850814; x=1777455614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
        b=VeRRzpV0/dDyqn+Wm3d8CjC0JQG3fHYKdRrDp4KHIo/FdG0A6DAWLvMRp1G9jm/cTF
         RfONIbS2yswWRpm2fNJMrHngtOQpHPCUd9M8hQilOeELw8dfIbTExq9qy+ZEr1hrf8gf
         Fe8MqtTYMFj5iBOLGXK0LKseG4fJVTqHopvQRwiyDR2fMsHJkXtw4cLN4W+rfsg3AT25
         Hxi/DEAtUIFtxTHf0EqUTxAc6CbsKoZSDRUw02y6ejsRgj0sxJcUJ/fuNd6eOnTTPAha
         zgAdgIk0R+dfRFqcKHIV5QE3nbViWfSIjFePx8YFhakmHIwbW36BysSLkv9X6gDFHrAE
         YiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850814; x=1777455614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
        b=mNFL64CSlqmPhJaU6IauV/51Nl9qalZwahm57zIz+LvGxfuSLR3/6Zgx0LUbhkK2YF
         6eV0k3YYk0d3Gj2wvvoeFYvSq9abXBFZjSiZrwawRlyfyd6lDuu5uB6LQjoRMKYGb03C
         ivcqc+Ge76UeMXUECYbqOszJnjJvGOOYiwNLyN5XanVi7ZUGmYp5zaTmYkdclTtwLIN9
         eTKN59Gfg8o36l3HyNs6aEC1VTttWGM+mSbIRJmlcYjCxD7xMoEZkNVRBjTx5DN0XZB1
         i8HFv6BDy1fMo5MONGQVEsCokfw5D0OqKP+/LHXqQ1/plXcW7QKx2xOEQcU6EHV2AMxB
         osgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xPZjm9LTERXuLPbZ8kwSetOc0/AJkx9gsXI+qOBAVj8qdfPJgjPnHlrV4D+qr69+yDnG5pH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKAd5pJoE8oGg1DHKsUDweff+2+Npxyf7dNxp2NEtN5+dgvwc
	b+UxhUerrrTqhtC8CF5PKRfebc9pkIFL4jJzMMMjR1u3AXuaFASyfK9MU9W39/nWQSNM2BU1Bzg
	fErq3Pm8MqAOoMnc0N1Pxv08bZr0AuiRcpLEnQrM8TSjrtRVy/8MKhwE3IpGg5FXK4Q==
X-Gm-Gg: AeBDiesmYGkcoeAMaRteSzAMmPCsqW/UzR6eQNJJw8u72C2hIYqnMRdEKMDB3mzqm9/
	y99MSI1qrfeKAFZjesA2jNjB85NQH0ETx5k1e4O5+klJqQhyrUSJenZYF0lvwTWCPwL44hr92Cx
	2cnORcr2yLV91B8cY26uKUs/7+YGkvAyeCaMU4lZmIFWM1f4VavOgIcVcSDorDg+Kn1bX8K0tFD
	IISERZYLpU8XW1NIsNBQSfHLdYFxADmiz5sZwytCSrjAcXVHswFExHRZRjpTK2otWsyx2Eo92TB
	dOFflTj8IsE3c5w/A1wo/b67z3TDZHNl/oALEk9l+hdvHO8I6zJzPFozMqnstaC7mi2Q1pFN2kg
	/ReeObA5YcG3NdTnWmsFHZoVHKj0H1u4dbfTRvy7pcf+AWjvpHdrnNlqa3EACgSRnBI1Kx1hLxz
	SGLiHNcQ==
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr82211695e9.7.1776850809633;
        Wed, 22 Apr 2026 02:40:09 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr82211215e9.7.1776850809081;
        Wed, 22 Apr 2026 02:40:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm396567715e9.8.2026.04.22.02.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:40:08 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:40:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Return -EIO for malformed/short packets
Message-ID: <aeiEsYqcKumplu5P@sgarzare-redhat>
References: <20260421174931.1152238-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260421174931.1152238-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240302-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 871454442C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:49:31AM -0700, Dexuan Cui wrote:
>Commit f63152958994 fixes a regression, however it fails to report an
>error for malformed/short packets -- normally we should never see such
>packets, but let's report an error for them just in case.
>
>Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Commit f63152958994 is currently only in net.git's master branch.
>
> net/vmw_vsock/hyperv_transport.c | 29 +++++++++++++++++++----------
> 1 file changed, 19 insertions(+), 10 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 76e78c83fdbc..8faaa14bccda 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -704,18 +704,27 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> 		if (hvs->recv_desc) {
> 			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
> 			 * be NULL unless it points to the 0-byte-payload FIN
>-			 * packet: see hvs_update_recv_data().
>+			 * packet or a malformed/short packet: see
>+			 * hvs_update_recv_data().
> 			 *
>-			 * Here all the payload has been dequeued, but
>-			 * hvs_channel_readable_payload() still returns 1,
>-			 * because the VMBus ringbuffer's read_index is not
>-			 * updated for the FIN packet: hvs_stream_dequeue() ->
>-			 * hv_pkt_iter_next() updates the cached priv_read_index
>-			 * but has no opportunity to update the read_index in
>-			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
>-			 * 0 for the FIN packet, so it won't get dequeued.
>+			 * If hvs->recv_desc points to the FIN packet, here all
>+			 * the payload has been dequeued and the peer_shutdown
>+			 * flag is set, but hvs_channel_readable_payload() still
>+			 * returns 1, because the VMBus ringbuffer's read_index
>+			 * is not updated for the FIN packet:
>+			 * hvs_stream_dequeue() -> hv_pkt_iter_next() updates
>+			 * the cached priv_read_index but has no opportunity to
>+			 * update the read_index in hv_pkt_iter_close() as
>+			 * hvs_stream_has_data() returns 0 for the FIN packet,
>+			 * so it won't get dequeued.
>+			 *
>+			 * In case hvs->recv_desc points to a malformed/short
>+			 * packet, return -EIO.
> 			 */
>-			return 0;
>+			if (hvs->vsk->peer_shutdown & SEND_SHUTDOWN)

We can access `vsk` directly, I mean `vsk->peer_shutdown`.

>+				return 0;
>+			else

nit: we usually avoid the `else` if the other branch returns early, and 
maybe have the error returned first, so it's more clear when reading the 
comment on top.  I mean something like this:

			if (!(vsk->peer_shutdown & SEND_SHUTDOWN))
				return -EIO;

			return 0;

BTW, not a strong opinion on that.

The rest, LGTM!

Thanks,
Stefano


