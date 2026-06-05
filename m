Return-Path: <stable+bounces-260641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nLXHHrF5ImpUYAEAu9opvQ
	(envelope-from <stable+bounces-260641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 09:24:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F2645EE6
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 09:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onurozkan.dev header.s=protonmail header.b="L88vBS0/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260641-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260641-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=onurozkan.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 819C33152AA3
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 07:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C4F3D25DC;
	Fri,  5 Jun 2026 07:11:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D346AEDD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 07:11:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643482; cv=none; b=BJNrjx2mn7BN/O8F4C3Zz92FD4xD64LJ8RzDRbi/yVFS7i4sICRj0qGp3l6SGQvIAXgBvl0LQBFn7fgrx5LdHp9FLluCUKd7R9sPd3aRkBhpZtBAvhk2VapkhmSxL4ozcqb2UPngN4+zWdXYWax1xywcqQQAi1chlrS0WbnIBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643482; c=relaxed/simple;
	bh=MkpAuI2e1V0LrUw0T+NyS+K//sMJyhCdoUUgU9DpQZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dryA/G013CMXz7POLv3u0ITq32l+/DZWhAsVBLOtMhtDx6u7wTOpO+eJTMqP0PuGHsjzCE4Cwxj066J2mC73SZungML068hh4Bv36TNdGapEVHry1vT+DYQ9yNa+9pH8O1edqyDsjD4Dm9qPv+PppTU0dZJLKiIYJh3Dyo+Iunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=L88vBS0/; arc=none smtp.client-ip=79.135.106.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780643469; x=1780902669;
	bh=HRxhzyxOHY3JBnWyUgtazruryDamO6m96XNGDJqD/1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L88vBS0/A2etLt7bm5lIyWM6ctWnI/wqiz4/+5pjnlDKEY8X3nEcGVWVeCCM7Z8uz
	 zaIPh5lhn/4LtJtRF5qojLJ8wcWYJnzJUe1asiVX3mF3z/oQzsYPdxgNzbtmUuKFxk
	 q+B+YER7weIhR+wzARYFhQK2Okq8p/YyCaM+uem4/rZsqJj753e2AHwHQ6fXO+zyBi
	 6mD7Y+yVqWf++C8FYNErrCzVEi0QLTuG3cPU909wLDCN+ixEAYTB0AAM19tJ9wtt8j
	 /kpHhen3hzGLytnrtXIfjAPbnnKe+9eTO6LRx9mJJ0pRyimkU24/MCJqKocpCl8jv1
	 p1a0vkUieWBBg==
X-Pm-Submission-Id: 4gWszY0tVJz1DF6h
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Yuan Tan <ytan089@ucr.edu>
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: firmware: return empty slice for zero-size firmware
Date: Fri,  5 Jun 2026 10:10:42 +0300
Message-ID: <20260605071104.135675-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260605041134.38290-1-ytan089@ucr.edu>
References: <20260605041134.38290-1-ytan089@ucr.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onurozkan.dev,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[onurozkan.dev:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[work@onurozkan.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ytan089@ucr.edu,m:ojeda@kernel.org,m:boqun@kernel.org,m:rust-for-linux@vger.kernel.org,m:zhiyunq@cs.ucr.edu,m:ardalan@uci.edu,m:pgovind2@uci.edu,m:dzueck@uci.edu,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[work@onurozkan.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[onurozkan.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,uci.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C95F2645EE6

On Thu, 04 Jun 2026 21:11:34 -0700=0D
Yuan Tan <ytan089@ucr.edu> wrote:=0D
=0D
> Firmware::data() builds a Rust slice with core::slice::from_raw_parts().=
=0D
> Unlike many C APIs, from_raw_parts() requires its pointer argument to be=
=0D
> non-NULL even when the length is zero.=0D
> =0D
> The firmware loader can represent an empty firmware image with size =3D=
=3D 0=0D
=0D
=0D
I haven't checked in detail yet but "empty firmware image with size =3D=3D =
0"=0D
sounds like an invalid image. Can such an image actually make it all the wa=
y=0D
to Firmware::data()? I would be surprised if the loader accepted it.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> and data =3D=3D NULL. Passing that pointer to from_raw_parts() would be=0D
> undefined behavior.=0D
> =0D
> Return an empty slice before constructing the raw slice. For non-zero=0D
> firmware sizes, the existing firmware API guarantee that data has size=0D
> bytes also means that the pointer is non-NULL.=0D
> =0D
> Fixes: de6582833db0 ("rust: add firmware abstractions")=0D
> Cc: stable@vger.kernel.org=0D
> Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>=0D
> Reported-by: Dylan Zueck <dzueck@uci.edu>=0D
> Signed-off-by: Yuan Tan <ytan089@ucr.edu>=0D
> ---=0D
>  rust/kernel/firmware.rs | 9 ++++++++-=0D
>  1 file changed, 8 insertions(+), 1 deletion(-)=0D
> =0D
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs=0D
> index 71168d8004e2..5e22a574a91e 100644=0D
> --- a/rust/kernel/firmware.rs=0D
> +++ b/rust/kernel/firmware.rs=0D
> @@ -106,10 +106,17 @@ pub fn size(&self) -> usize {=0D
>  =0D
>      /// Returns the requested firmware as `&[u8]`.=0D
>      pub fn data(&self) -> &[u8] {=0D
> +        let size =3D self.size();=0D
> +=0D
> +        if size =3D=3D 0 {=0D
> +            return &[];=0D
> +        }=0D
> +=0D
>          // SAFETY: `self.as_raw()` is valid by the type invariant. Addit=
ionally,=0D
>          // `bindings::firmware` guarantees, if successfully requested, t=
hat=0D
>          // `bindings::firmware::data` has a size of `bindings::firmware:=
:size` bytes.=0D
> -        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self=
.size()) }=0D
> +        // For non-zero `size`, this also means `bindings::firmware::dat=
a` is not NULL.=0D
> +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, size=
) }=0D
>      }=0D
>  }=0D
>  =0D
> -- =0D
> 2.43.2=0D
> =0D

