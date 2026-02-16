Return-Path: <stable+bounces-216678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMX+NFbnkmlSzwEAu9opvQ
	(envelope-from <stable+bounces-216678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:45:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8AC1420CF
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70C4A301A505
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A092EFD9C;
	Mon, 16 Feb 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNL5Ln/G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852491DDC2B;
	Mon, 16 Feb 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235128; cv=none; b=AXGKKgq5qp27ZASQZrRnTHHOLIKt3VMZJJAoreLwtkPHTGXtRqU9q85vpxer/+i28JHoUJVeI35Ozh3AuZLb7m8Dv/BOyA8CAmICztyNI6zcMjdHgzzXhQ42xxJBo2UQX5Xu3VRBuB4FKQTD8ImyZ14eq/yj4eopTA8M1LW5xCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235128; c=relaxed/simple;
	bh=7NunW6RQ2SBImUQczKO4pkXAhCVgbYmwdk+s/Y6+W4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9cMKuDmrPvxcy47VcSEc9xvOyLzkcw2s1K49fjqZf/Qy0VWT2DFObH0I4pZ7bnLJWx1PwBVA4qyqpa88ER7XhMGkdmIzFSpVwjK9Vxt1KboTXOwMNIoU2twzR9ME6o36d+5nIqFaSYwMTXtSe6Hrwv9+XNMek92UXLiaPXvThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNL5Ln/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8543C116C6;
	Mon, 16 Feb 2026 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771235128;
	bh=7NunW6RQ2SBImUQczKO4pkXAhCVgbYmwdk+s/Y6+W4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xNL5Ln/GHbKcYxO9OK9TGyqNcd/W3Shk6BTBuL2YDjBV27c6Vz4DDyLGjzv+io9hQ
	 PdOiDxodlXjS4AQt6gi27iSLT1dCqRXkcJQqVxWZzKI70+VtmhSilMxCY2wh/9oCBZ
	 WKCQU1RzcPAKLDryNuS/m9oJEqItky7rfCgukamY=
Date: Mon, 16 Feb 2026 10:45:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, David Gow <davidgow@google.com>,
	stable@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: Consider backporting rustdoc fixes for 6.18.y
Message-ID: <2026021612-hazy-stank-831c@gregkh>
References: <CANiq72n3qPsoy2u1KxfyV4ZCjJyDZLkK-54i7EesTH=TE9h1jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n3qPsoy2u1KxfyV4ZCjJyDZLkK-54i7EesTH=TE9h1jw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216678-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,arm.com,collabora.com,lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6B8AC1420CF
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 03:11:31PM +0100, Miguel Ojeda wrote:
> Hi Greg, Sasha, David,
> 
> I have been seeing these warnings (errors with `WERROR=y`) in stable
> 6.18 UML + Rust on the `rustdoc` target [1].
> 
> Unless David (who works around UML + Rust) or the different
> maintainers (Cc'd) have a concern, please consider backporting:
> 
>   a9a42f0754b6 ("rust: device: fix broken intra-doc links")
>   32cb3840386f ("rust: dma: fix broken intra-doc links")
>   4c9f6a782f60 ("rust: driver: fix broken intra-doc links to example
> driver types")
> 
> They had Fixes tags, but not Cc: stable tags.

All now queued up, thanks.

greg k-h

