Return-Path: <stable+bounces-267279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cS9CDxhwNGqEYAYAu9opvQ
	(envelope-from <stable+bounces-267279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 00:24:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957BA6A2EE6
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 00:24:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UncOQtti;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267279-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267279-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 225A3303E104
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8763438BB;
	Thu, 18 Jun 2026 22:24:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7125B0B0;
	Thu, 18 Jun 2026 22:24:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821458; cv=none; b=D/uY1XR00+EOZhSWYdpeZZ74Ma5Agc0uGkzfH/JRwcm3A3yfnluq4/DB0aXlg5OfSseSeTJDTxHhKfbbIvpAbTpLtKsGSr8WsOQONKrFIvIBqhM7UwmyFIbFOArHsPjps48f11c5jqgpn9Ggnm0w+MblLBbm9rXxDvghGFcgkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821458; c=relaxed/simple;
	bh=cJ0HzjDlYWl6JRx1YugQQEaxjrUc7D/skMZiuxd6u+k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Rp90vsoBTyNfXjggaE6iYkqBWvmb23JqhfVhS+7XV/x3ao6aKMt1lmVqtUN/a/g9yJdIxrRqsukJqkjfC24XMBVNaNbbanLrjN4/iljVN8VSWiHUUB1t+qGS57y2/JoCES+24AqBlVqoCo6R4KCfpK8cO89FowqDwIhqtswDP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UncOQtti; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF5A1F000E9;
	Thu, 18 Jun 2026 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781821457;
	bh=cJ0HzjDlYWl6JRx1YugQQEaxjrUc7D/skMZiuxd6u+k=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=UncOQttibZ4dVrhIZX7iNuw7CIznQV3tM5hQkWo7zpxJZT8H8PrOtdOXyGVASiY5V
	 t3oBMFTR5RB1O7RaYb4ogz8KbnPWoRGfX2arFuHbuHrva3CYLJOjdchsPJr79BhT/u
	 jLFNyVDPzlpbNsSfBcMtLpMckwVnNdPcm4PUIxL65kaftCTnXafdRnZWaLzYi2LQvX
	 9cCE+jmKyL8NsH9CZizy6zvU752uHf5MqfTGtJLg+WuIdhsO31nzsh53zE06nKELrv
	 GuugIaTBRC2MsKVo/9gF0UJA4fZx7VCRzPQNv2MFJhDaBliQJ5RpH5J9oifh1FSYQi
	 6yU5R4Rov0S0A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 00:24:12 +0200
Message-Id: <DJCIZMUFKMTK.BO46M40UO3XY@kernel.org>
Cc: <lossin@kernel.org>, <gary@garyguo.net>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <lyude@redhat.com>, <deborah.brouwer@collabora.com>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
To: "Boqun Feng" <boqun@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: revocable: fix race between concurrent
 revokers
References: <20260618193951.601239-1-dakr@kernel.org>
 <20260618193951.601239-3-dakr@kernel.org> <ajRknQIsXaHtDzzJ@MacBook-0RXW5>
In-Reply-To: <ajRknQIsXaHtDzzJ@MacBook-0RXW5>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267279-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:lossin@kernel.org,m:gary@garyguo.net,m:ojeda@kernel.org,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:deborah.brouwer@collabora.com,m:rust-for-linux@vger.kernel.org,m:driver-core@lists.linux.dev,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:boqun@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 957BA6A2EE6

On Thu Jun 18, 2026 at 11:35 PM CEST, Boqun Feng wrote:
> This issue happens particularly when we want to save the extra refcount
> (and indirect reference), and I think this is the issue that `Foo`
> should handle instead of `Revocable`. So maybe we should move the fix
> into `Devres` layer? Thoughts?
>
> (I'm still hoping there could be some lightweight usage of Revocable
> other than Devres, hence the ask.)

I agree that a "lightweight" usage of Revocable is reasonable, and we can s=
till
have that; nothing prevents that (see below).

We could also turn it around and have revoke_wait() and make no wait the
default, but I think it is a bit of a footgun.

Another alternative would be a new type over Revocable, which may be a bit
cleaner. (Although in that case I can also just move it into Devres for now=
, as
it is the sole user of Revocable anyway.)

>> If needed, a revoke_no_wait() variant that does not wait for concurrent
>> revocations to complete can be added in the future.

