Return-Path: <stable+bounces-247817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKt3C3M3B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:10:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C454B551EC4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B56AE3008D40
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDAF3C455B;
	Fri, 15 May 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AP1EM1Zj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4337A49D;
	Fri, 15 May 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857837; cv=none; b=vDcvVJajgRFwXuT7IlnALZoiTTQn47jiBfhqSDnEdngOXoCn8EFAS4fzuvfvqU3W3O+llU3VO8AHqVpacQMOU6+x0kkCHXkYjleixeEyhjZkSgD7eLFM7KlVN5hWfYbDZKUt+odR1M/J8/dLdymyt2ju0VKLpBWPudBokH85mfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857837; c=relaxed/simple;
	bh=Dsf6phcb+zRcA85aKpQ+SG9cPWCyfxmdHuj1wxAAhMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ48cTwLuAzUF3qGK0WcGzFUEwG57bTZoiEeJDqyNe+mGvqY/3itNuVYhtcKMOguqIllNsOk18mwVF3j+PIs/ZswQmjxJwzmDgKQmMw+kWbTZHOMXRKSWMnhgDd6UKAtlWxLjWzwAf5IIMa6xdKF0Mtyobp/NvMeXmvYKDgO/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AP1EM1Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D0CC2BCB7;
	Fri, 15 May 2026 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778857837;
	bh=Dsf6phcb+zRcA85aKpQ+SG9cPWCyfxmdHuj1wxAAhMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AP1EM1ZjzLH1GV4U1Y+wNLcVjRG3SRAYqImJsByGi5+cUl5WcGNtZwY+KVXyC7TsS
	 SpH3BnBoLI+CEPAhBklFkda1iLzL9CWo6u8qQUD0BpE/w1WOyd6zI/8xXS1LTkqAFk
	 gH6O0C/ToHSlBw0veVph1Zr1t0xpEtx3zMuSA3Vs=
Date: Fri, 15 May 2026 17:10:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vsock/virtio: fix potential unbounded skb queue
Message-ID: <2026051519-shale-scallion-aab7@gregkh>
References: <20260515-dumazet-v1-1-73468c902889@redhat.com>
 <agcsQ4LlG9ZsvBGR@leonardi-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agcsQ4LlG9ZsvBGR@leonardi-redhat>
X-Rspamd-Queue-Id: C454B551EC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247817-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linux.dev:email,alibaba.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:23:53PM +0200, Luigi Leonardi wrote:
> On Fri, May 15, 2026 at 04:22:12PM +0200, Luigi Leonardi wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > 
> > Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5
> > 
> > virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > 
> > virtio_transport_recv_enqueue() skips coalescing for packets
> > with VIRTIO_VSOCK_SEQ_EOM.
> > 
> > If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > a very large number of packets can be queued
> > because vvs->rx_bytes stays at 0.
> > 
> > Fix this by estimating the skb metadata size:
> > 
> > 	(Number of skbs in the queue) * SKB_TRUESIZE(0)
> > 
> > Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: Eugenio Pérez <eperezma@redhat.com>
> > Cc: virtualization@lists.linux.dev
> > Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > [LL: Fixed conflict since this tree does not use buf_used added by commit
> > 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
> > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 4c374c36c29d..86e3051d000e 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > 					u32 len)
> > {
> > -	if (vvs->rx_bytes + len > vvs->buf_alloc)
> > +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > +
> > +	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
> > 		return false;
> > 
> > 	vvs->rx_bytes += len;
> > 
> > ---
> > base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
> > change-id: 20260515-dumazet-07c0c855a9e2
> > 
> > Best regards,
> > --
> > Luigi Leonardi <leonardi@redhat.com>
> > 
> 
> Forgot to add this is material for 6.6.y stable tree.

What about all of the newer stable trees?  You can't just apply a patch
to an old branch :(

thanks,

greg k-h

