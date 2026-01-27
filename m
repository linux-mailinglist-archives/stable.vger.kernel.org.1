Return-Path: <stable+bounces-211879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEjnGsgCeWkdugEAu9opvQ
	(envelope-from <stable+bounces-211879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:24:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1918F98F72
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69AC0302B810
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E06326949;
	Tue, 27 Jan 2026 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FZTt+uLm"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99522D7B9
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538236; cv=none; b=UwvLykFLYyinDYDxifrLqy+G9HPsMwfIvHH5Z2OcWjW34TnT82HZSfyiIXsEFNn0ih3Btm0XbL+R37WOkDfUCoCPL2wODRjf9ewkv6Sh0qihXh5YaiTrlTKDQW02MNtRoRC2uurGBtlELTz7QvoL6Cg/BMdDrpR/qBRyzeJajVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538236; c=relaxed/simple;
	bh=tnZH3DBz7X9SjPZ0b7wT3oy6Lmm7Evgc748KfBngWoQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=fbbhYxk5JuHwhG9RjwAYf4Ifa4yoysXi5gOccbgCfLBaubLlg0pl4ky+uNji0BOOYmFsbN695p0NEnc9UHc5vThXof8doR5pcNhQy2/IOmeoqRadCLjZUOlCh7zTtbe5TFNkk6umfTJyt4RTNtjQZPXvHPkOxXUtJOSxplEiWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FZTt+uLm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:References:Subject:Cc:To:From:Message-Id:Date:
	Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tnZH3DBz7X9SjPZ0b7wT3oy6Lmm7Evgc748KfBngWoQ=; b=FZTt+uLmb5KAM8tdgSeJdLwoMe
	VtJq5vzBx1FFe3zI1v2bWAgsVIj+9rLihes4Ouh+QEyOE51yWMyq/Ix0Jm9+QpfqrWAYP9WNZai3h
	6JPMQi6IZTppOIrcLdaUispwNsvlFvp3bo/I39orZzj7DbEL4tQp2qtK2TmBcIKC1ruFSa7eaBYb0
	vUkw+B2+bx72EE+RTBvBZe/h+cxFLYRchrCLNrRLkqOI1o+TgZNe04g6icu6nRhvKXDNG/8NByb0O
	uj/PO/mblinv4gpWS1lb5193oH+GrWrg2ZYAFjIojOh37fxkoRRAatd4nbtymnwPxzgf+Yfi1klO9
	1vRhEKYQ==;
Received: from 189-14-88-37.vmaxnet.com.br ([189.14.88.37] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vknj7-00Aa2H-MS; Tue, 27 Jan 2026 19:23:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 15:23:25 -0300
Message-Id: <DFZKXX7T2W9E.2HLVK9GPTCYJJ@igalia.com>
From: "Heitor Alves de Siqueira" <halves@igalia.com>
To: "Will Deacon" <will@kernel.org>
Cc: <stable@vger.kernel.org>, "Stefan Hajnoczi" <stefanha@redhat.com>,
 "Stefano Garzarella" <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, "Xuan Zhuo"
 <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <kernel-dev@igalia.com>, "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
Subject: Re: [PATCH 6.12 0/8] vsock: Backport nonlinear SKB allocation from
 mainline
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260126-backport-vsock-nonlinear-skb-6-12-v1-0-ad5c34853a60@igalia.com> <aXicF1hKPWn6bSUY@willie-the-truck>
In-Reply-To: <aXicF1hKPWn6bSUY@willie-the-truck>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211879-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,b4d960daf7a3c7c2b7b1];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlesource.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:mid]
X-Rspamd-Queue-Id: 1918F98F72
X-Rspamd-Action: no action

On Tue Jan 27, 2026 at 8:05 AM -03, Will Deacon wrote:
>
> I was worried that you'd missed 03a92f036a04 ("vsock/virtio: Resize
> receive buffers so that each SKB fits in a 4K page") but it looks like
> that's already in -stable for some reason. So I think you've got
> everything here.
>

I think some of the patches from the original series were CC'ed to the stab=
le
list, so I picked up the others during the backport. Thanks for
confirming these should be the required ones!

> fwiw, I did a 6.6 backport for Android so if you end up needing that
> just let me know...
>

Sure, I'd be happy to give these patches a try on a 6.6 kernel. Are they
available in AOSP kernel sources? I did take a brief look into the
common kernel repo [0], but didn't find anything related to this change
there.

Thanks,
Heitor

[0] https://android.googlesource.com/kernel/common/

