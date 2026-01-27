Return-Path: <stable+bounces-211755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D1uGC2ceGlurQEAu9opvQ
	(envelope-from <stable+bounces-211755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 12:06:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409793590
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 12:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 572083004422
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A430BB96;
	Tue, 27 Jan 2026 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj7oeArn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828430BB81
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511966; cv=none; b=SgU8YSQcWpMHjzv2Q8vBFzXFkSNST0PBcgvZxcNb4CzpmgGGlXDQ6H3UGSynaLjc7sRfnMsetR0F4St2Mub8JVgfK6XYS/fP3dLFnJsvdH1hikQq1I6sYNANG046aWFWV1gHhEQ/Rs1+QbxP9Mr6EsBto9OHiPmwmBsXJYcIxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511966; c=relaxed/simple;
	bh=TePssgYEtPi76BYNmDzpaXmvRve8iDSFjQdTB9Sn22w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6sLOnfrwF5CUcimw1ZsslhCq5f9QtDQrhJSkspx5HvQsr/Fgyn4iesujIpwTAplSsoiqq9Wp9CM2ayy8GQv1FVE1Md+VpO2giocQSLmove7Ud/sE5pTMXl4zPYooRTHKpBMyezQnUhuFApHffMkQX1bsmZElnniIVZjTVpF/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj7oeArn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69A5C116C6;
	Tue, 27 Jan 2026 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769511966;
	bh=TePssgYEtPi76BYNmDzpaXmvRve8iDSFjQdTB9Sn22w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zj7oeArnxNX3nGrSyWVdnHWOOKe6Nn+UGP0Y0McJJzV4UscdncCAMcWkhj+tn0gBy
	 mt8o7FSqVMdnDRk6TnO19jPjVYH9BjAkhh4l4BYKgX1nuyzXThb+xPMRV81/qb2DAD
	 u1wt+Ar8d4afA7QDlQ+PAB0VOZpGLcqIKwd2EqS5XyqJ9rga00eConEtc0Cn24hdWU
	 M1uHoYwR1jdXuXdyo4niIliiM67fzmLguCoEEWuoaIUnDZTVhgC0eqaC8zRzUWv2um
	 /ixv8GPXXLQxCJEL/kr8KsAHaUYD72N6JamashgYOi4iJGoOefxw9a7q5dIDibkg0I
	 ezlff608xrB8Q==
Date: Tue, 27 Jan 2026 11:05:59 +0000
From: Will Deacon <will@kernel.org>
To: Heitor Alves de Siqueira <halves@igalia.com>
Cc: stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kernel-dev@igalia.com,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.12 0/8] vsock: Backport nonlinear SKB allocation from
 mainline
Message-ID: <aXicF1hKPWn6bSUY@willie-the-truck>
References: <20260126-backport-vsock-nonlinear-skb-6-12-v1-0-ad5c34853a60@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-backport-vsock-nonlinear-skb-6-12-v1-0-ad5c34853a60@igalia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211755-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,b4d960daf7a3c7c2b7b1];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9409793590
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:16:51PM -0300, Heitor Alves de Siqueira wrote:
> Hi stable maintainers,
> 
> This series backports vsock nonlinear SKB allocation support to 6.12.
> We've uncovered significant memory allocation failures on ChromiumOS
> kernels for workloads that rely on ARCVM or crostini containers; e.g.
> when running Android apps, games or other intensive graphical
> applications.
> 
> The memory allocation issues can be reproduced by stressing host/guest
> communication via vsock, and seems to have a bigger impact on low-memory
> devices (we've seen it mostly on devices with 4GB of total RAM), or when
> the system is under heavy memory pressure. A straightforward reproducer
> for ChromiumOS uses iperf3-vsock [0] running between the host and a
> Linux container setup via ChromiumOS' "Linux Developer environment",
> where the client will quickly fail with the following message:
> iperf3: error - unable to write to stream socket: Cannot allocate memory
> 
> Patches 0001 through 0004 are required for the main nonlinear SKB
> allocation patches. Patches 0005 and 0006 introduce nonlinear SKB
> allocation support for the receive and transmit paths, respectively.
> Patches 0007 and 0008 fix a syzbot reported WARNING that was introduced
> by these patches in the transmit path. Patches 0001-0007 apply cleanly,
> and 0008 needed minor changes to one of the function signatures. All
> patches are already present in mainline and future stable kernels (v6.18
> at this time).
> 
> [0] https://github.com/stefano-garzarella/iperf-vsock
> 
> Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
> ---
> Will Deacon (8):
>       vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
>       vsock/virtio: Rename virtio_vsock_alloc_skb()
>       vsock/virtio: Move SKB allocation lower-bound check to callers
>       vsock/virtio: Rename virtio_vsock_skb_rx_put()
>       vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
>       vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
>       net: Introduce skb_copy_datagram_from_iter_full()
>       vsock/virtio: Fix message iterator handling on transmit path

I was worried that you'd missed 03a92f036a04 ("vsock/virtio: Resize
receive buffers so that each SKB fits in a 4K page") but it looks like
that's already in -stable for some reason. So I think you've got
everything here.

fwiw, I did a 6.6 backport for Android so if you end up needing that
just let me know...

Will

