Return-Path: <stable+bounces-237648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIFcMThN3WmacAkAu9opvQ
	(envelope-from <stable+bounces-237648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB203F302C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 096083013850
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF70391E79;
	Mon, 13 Apr 2026 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="GsmngRAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZbhrWQb"
X-Original-To: stable@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F838BF67;
	Mon, 13 Apr 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110901; cv=none; b=i72R2TgUK6rmIBMSZhtRz2l2LMGGc6Gx4I5zFxuivAbI7HQ34LALbQiqoV0iZGb6lkdqF9ZbiQDYn0TU4EbNon66NKfbLdCqd+5zMT2ojrGzBvWTMKXFXSsCB5WBey+wMM/X1cu6ONst1BDwfKjrL42jM+FcwkuDPdrHE3bWy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110901; c=relaxed/simple;
	bh=UZtF34Vd2lYkDQz9Tj53ng6mbr0aZ5lncjPWUtOhKhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqtqZCwkupIbduNdA1wptfsVQlByCg8kquUrb7I72tDpR/qYGy3wgiHAWA+n7HG5HTtZadbwz3ICCugr9qVM9R58z2q5yiauDhA1Fr3GmCG32Cirlwz6LvWzP3ypCnR31+WMj4Tf4RcX8W7aqhi9DY3b3amIKvbxVm1JrFARMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=GsmngRAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZbhrWQb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AA1BEC0434;
	Mon, 13 Apr 2026 16:08:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 16:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776110898;
	 x=1776197298; bh=j9hwhFGrKakk1ZNtRUR/kYRE8yWC3+RviEbKeWqEAJw=; b=
	GsmngRAMsOVggUG3jTpsViF5qPFayFXZarYjLOjOjbWd/pNSaUD6r1Q3aZrBJiKG
	80DmVnJXGC1Hs2vehCqpqoL+YiXYxKvJhyIdGS7yTeTb3sD72+VKmvWxTmw/h0We
	FILa1Rvv0s8iNYTtmkxSANdVJJssWOwiVm5tWk78jsw88jJcbb93dxQqK6VjbwGC
	a60HvJYivqsgLnqJgfsoFd29a65a/zhTvC9V3ixqSIgkleY3N5Yniv5p/PzSjq4D
	kbuHIQXoCOVqnpknTCQ6g5MMZVtGVReUaVFtlVt4Ve/qk/hExn/oj9Zv2Pk988Td
	FybUnpcP2V1gjId6Fc1npw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776110898; x=
	1776197298; bh=j9hwhFGrKakk1ZNtRUR/kYRE8yWC3+RviEbKeWqEAJw=; b=j
	ZbhrWQbKW3ACdEmXTLIxXQ9/Lm5nNEQlgrYx8XxKPhqfP873QRE9rwzOhh/mjZo3
	xrqUN1Ghh3knJ4WBZEPrQDgCwk439KS4yoWBwAJ7gV2Etdha+w8qxoI1NUZp1JVx
	pvz459ZxAUaLJ8c6J50rC4u4J/I0ffavaP2S2huavTefDTFqJwf5a56W7D9sxKnu
	Joe4hwb9h1I87g41Vp95D0ULyJ+rueNJzzwk2eMwdofeRg9+e/Um2t/gg4jMU1z1
	oemnnItkuL11rrnMsPBfYeUGdVPpctqTr5C1o5WVda0EQHeLxVfuB/3GO6HCe4JR
	Sp5VFFxQordo1xAlb8lDg==
X-ME-Sender: <xms:MU3daVp_2LPGOKvQKOHkYpVhiMdOTssV5yolN_P_ZAwIQXgKrne3Eg>
    <xme:MU3daf0lA0t5N1tkCGUVlbjMt5qVrRuT_U833x7MAYD6xZqd1rtlH2sy5EC6XQ4DF
    UZ67k51TDzfXjD3EX3tqhUTwrUYOEze1cV3ibaERI5PdC3ff1tR>
X-ME-Received: <xmr:MU3dadw8L7nVKYTaMV-faiaIT7f6H9i0UBWPPquWrt90jL6SUDyxD_h5Wko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhuohhjihhnhhhuihdrlhhirghmsegshihtvggurg
    hntggvrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohep
    hihishhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumh
    hthhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehkvghvihhnrdhtihgrnhesihhn
    thgvlhdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvhhirhhtuhgrlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MU3dabgXE49HNPo2dy5vp2JaPcYRO8idKBsPpHR3DmXXZqdux_zw6Q>
    <xmx:MU3daQqtXnfntuJrDXAcMKerdaIFgLZ2zNfdPdA2R5aV2IRWk1RFvw>
    <xmx:MU3daSh84wrFl8_IKyJpQdfVqMSTEyEJtCeYUfp-qOfzFZiEFmhplA>
    <xmx:MU3daSPoEvmf2UBDQU4Uuw_1jVw-QjQ00vyL-9hrue0gh9M7iY1P7A>
    <xmx:Mk3daZiUkt65xzOqKUBqUTqkC5v-ldC05Oy0a0R_sA4hORyrfcpaXyag>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 16:08:16 -0400 (EDT)
Date: Mon, 13 Apr 2026 14:08:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>, "Yishai Hadas"
 <yishaih@nvidia.com>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Shameer Kolothum"
 <skolothumtho@nvidia.com>, "Kevin Tian" <kevin.tian@intel.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, alex@shazbot.org
Subject: Re: [RESEND PATCH] vfio/virtio: Fix lock/unlock mismatch in
 virtiovf_read_device_context_chunk()
Message-ID: <20260413140815.3ada32eb@shazbot.org>
In-Reply-To: <20260413073603.30538-1-guojinhui.liam@bytedance.com>
References: <20260413073603.30538-1-guojinhui.liam@bytedance.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237648-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0AB203F302C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 15:36:03 +0800
"Jinhui Guo" <guojinhui.liam@bytedance.com> wrote:

> virtiovf_read_device_context_chunk() takes migf->list_lock with
> spin_lock() but releases it with spin_unlock_irq().  This mismatch
> can incorrectly enable interrupts if they were already disabled
> when the lock was acquired, leading to unbalanced IRQ state.
> 
> Fix by using spin_lock_irq() to match spin_unlock_irq().
> 
> Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/vfio/pci/virtio/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> index 35fa2d6ed611..9fc24788fc04 100644
> --- a/drivers/vfio/pci/virtio/migrate.c
> +++ b/drivers/vfio/pci/virtio/migrate.c
> @@ -621,7 +621,7 @@ virtiovf_read_device_context_chunk(struct virtiovf_migration_file *migf,
>  
>  	buf->start_pos = buf->migf->max_pos;
>  	migf->max_pos += buf->length;
> -	spin_lock(&migf->list_lock);
> +	spin_lock_irq(&migf->list_lock);
>  	list_add_tail(&buf->buf_elm, &migf->buf_list);
>  	spin_unlock_irq(&migf->list_lock);
>  	return 0;

Yes, that fixes the bug, but why are we using a spinlock-irq here in
the first place?  I think this just copied the mlx5 vfio-pci variant
driver, which does make use of their list_lock under hardirq context,
but no such use case exists in this virtio driver.

A more complete fix would be to to convert list_lock to a mutex.
Thanks,

Alex

