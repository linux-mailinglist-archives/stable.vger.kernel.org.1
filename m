Return-Path: <stable+bounces-223088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACiCBWhkqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:57:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD8204B75
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0644303DD4D
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71436BCE3;
	Wed,  4 Mar 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAyl6lxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE63382E7
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643225; cv=none; b=Dz5U5o/xQxh0RTUmpLpMGPK0mGlG12isK0FFCacToZfHn0jTgehDCfEOH7qzOcMFmvf2FoScB4Kq+O/aqF5E0+/ZgIMTNczaWTLJSCk7d7XIqw0QmquAnmVct/ZvwYlfWEmAM3WLtWIToEaf2QbkSlxGyJiEGx56+UM5QkcPyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643225; c=relaxed/simple;
	bh=3MtoYURzy6ghzdYbj7gE7b4EBlqQ27s1Y1RUZbTLGEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=givYbDtDXL4Ffokz9nKBLTeR+skukkpjdiyvpcyjjn3ojWQICOzFt9NZ9ol+lpKessyNd/0B4vj7qTglPwY7zpIJdDPxz5MOSivsTh05wC5A4g25Ot+EyaciOP6h0STaAzBdippi1ch96RZxc/GW7DmWdpOkKXt+l7CyM+mMSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAyl6lxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642C1C19425;
	Wed,  4 Mar 2026 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772643224;
	bh=3MtoYURzy6ghzdYbj7gE7b4EBlqQ27s1Y1RUZbTLGEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAyl6lxbAPD8M4Hp1LBe4u2deCgABVb85owHVvromfes9wwvK4BnJFE/KuQ+BQPcs
	 LQz2tTa4KVOJBvh6F4EkyIDpV1sEbwUEkgdS8l1xjUcifg433cE+bhVIB2XKpX9jid
	 nt6BqlI/j/+VrhWA4ECLJpNu8iji/FK1Ei2hYzh0KHlOVTfcXKNO/q+2cPjkC+jXDt
	 OdFWvAkYviD/RzNMl5Pgbkco7iw9G8+tcaK1DmGkzgJ+MjJu8ETaKUqRBGiaE9gsgS
	 XMlisjsS1SWstBja4ibJEfNe1rNe5vlY1WpviCM6/F0y9Cchk6GuJx1NgmMosGEheC
	 3Jtztj6ZLjI+A==
Date: Wed, 4 Mar 2026 16:53:38 +0000
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
Message-ID: <aahjkUrZvMAj7M-W@willie-the-truck>
References: <20260126-backport-vsock-nonlinear-skb-6-12-v1-0-ad5c34853a60@igalia.com>
 <aXicF1hKPWn6bSUY@willie-the-truck>
 <DFZKXX7T2W9E.2HLVK9GPTCYJJ@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFZKXX7T2W9E.2HLVK9GPTCYJJ@igalia.com>
X-Rspamd-Queue-Id: 87AD8204B75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223088-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:23:25PM -0300, Heitor Alves de Siqueira wrote:
> On Tue Jan 27, 2026 at 8:05 AM -03, Will Deacon wrote:
> >
> > I was worried that you'd missed 03a92f036a04 ("vsock/virtio: Resize
> > receive buffers so that each SKB fits in a 4K page") but it looks like
> > that's already in -stable for some reason. So I think you've got
> > everything here.
> >
> 
> I think some of the patches from the original series were CC'ed to the stable
> list, so I picked up the others during the backport. Thanks for
> confirming these should be the required ones!
> 
> > fwiw, I did a 6.6 backport for Android so if you end up needing that
> > just let me know...
> >
> 
> Sure, I'd be happy to give these patches a try on a 6.6 kernel. Are they
> available in AOSP kernel sources? I did take a brief look into the
> common kernel repo [0], but didn't find anything related to this change
> there.

Sorry, this fell through the cracks. The Android backports for 6.6 are
here (you need both sets):

https://android-review.googlesource.com/c/kernel/common/+/3666377/4
https://android-review.googlesource.com/c/kernel/common/+/3788577/2

Will

