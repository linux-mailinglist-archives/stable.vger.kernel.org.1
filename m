Return-Path: <stable+bounces-233279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG4jLvrn0GmeBwcAu9opvQ
	(envelope-from <stable+bounces-233279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 12:29:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1964739AC45
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 12:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 425503020A7D
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F1C3A9D9B;
	Sat,  4 Apr 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b="kZ3uzqLl"
X-Original-To: stable@vger.kernel.org
Received: from erebus.slow.network (erebus.slow.network [109.74.205.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF136492E;
	Sat,  4 Apr 2026 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.205.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775298458; cv=none; b=jL6G66tgwSHoNmnwt9GZhMhI908OyVGQYeOKJiAUUSke1zxLEWaPjlcsXYWW/B+VDp01l1DVLQzFU0ztTe/cff2kjSUKBJ4v9Jz6/qfm8FaiKT/d3HheoB+N3fzOKX7chZXAuFCJPBIKeR3jSo2iCMPwv8GwGQBXb9SzI9EmoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775298458; c=relaxed/simple;
	bh=fncsnxVbZmAIhowtb8z1XKYlG7bmJ0vxpq4XM/cCIJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tTa3mLbTO07FT9/2G0W4J2JYxQosq0xe26T6xXBozRfwtcwzoHNmoWI3ZRlasQRCHYpFRMHsIbRdY5eKOEjTHFPzL+z/9CmEBwerc+GEGSpq/6L/yhwm+BvHG71VxTwVNa0cp6k6YVV+jG+Iz7v3m+qZy0vuOOdd+EgyJ4lWflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski; spf=pass smtp.mailfrom=kramkow.ski; dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b=kZ3uzqLl; arc=none smtp.client-ip=109.74.205.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kramkow.ski
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20220506; bh=fncsnxVbZmA
	Ihowtb8z1XKYlG7bmJ0vxpq4XM/cCIJ8=; h=in-reply-to:references:to:from:
	subject:cc:date; d=kramkow.ski; b=kZ3uzqLlMcoQ37v1J6JJ9uQ90kKvtG9oAJnb
	G52dTXp3/wXHHuQj1jYjxwp+FajddPSqpexWBuSWMIh7iG8mnJrmCuUC+mxmWrHG4IeJyU
	gLAKAu2NOGpocnaNNj2esIslqep5xqqU9HD9MrVZ0ZLLXmNdRIR5hVqNobxxjOE+hbchUA
	UFIbH35bc2arAOjxaZupWpn9ApSAgeL6N3sXkEgJ0NwK+NP7Z+8bcMaeElUJGeM6pCuleH
	oyCHwqmoDGKK5u3UvuCeEX9ifnS4aLQBFsI0iW93jmaCZx01uS6UYXivbrhIV0JjuTGNMT
	Zz/8Qvt9QooOroWyUw23KpX7+Q==
Received: from localhost (flit-04-b2-v4wan-169180-cust382.vm32.cable.virginm.net [81.96.161.127])
	by erebus.slow.network (OpenSMTPD) with ESMTPSA id 4124dfb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 4 Apr 2026 10:27:29 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 11:27:28 +0100
Message-Id: <DHKAS08JUNOZ.12AB204VQ9MXH@kramkow.ski>
Cc: <stable@vger.kernel.org>, "Alva Lan" <alvalan9@foxmail.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xattr: restore file descriptor checks
From: "Tomasz Kramkowski" <tomasz@kramkow.ski>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
X-Mailer: aerc
References: <20260403230636.344097-1-tomasz@kramkow.ski>
 <2026040419-volumes-femur-731d@gregkh>
In-Reply-To: <2026040419-volumes-femur-731d@gregkh>
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kramkow.ski,quarantine];
	R_DKIM_ALLOW(-0.20)[kramkow.ski:s=20220506];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233279-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foxmail.com,zeniv.linux.org.uk,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz@kramkow.ski,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kramkow.ski:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 1964739AC45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Apr 4, 2026 at 7:23 AM BST, Greg Kroah-Hartman wrote:
> On Sat, Apr 04, 2026 at 12:06:36AM +0100, Tomasz Kramkowski wrote:
>> This patch restores the checks incorrectly removed by commit
>> 5a1e865e5106 ("xattr: switch to CLASS(fd)").
>>=20
>> That commit was an attempt backport an upstream commit which had
>> modified but did not remove the checks to see if the passed file
>> descriptor referred to an open file. This seems to have resulted in the
>> backport removing the checks.
>>=20
>> This leads to a kernel panic when calling `fgetxattr`, `flistxattr`,
>> `fremovexattr`, and `fsetxattr` with a file descriptor which does not
>> refer to an open file.
>>=20
>> Tested in qemu.
>>=20
>> Signed-off-by: Tomasz Kramkowski <tomasz@kramkow.ski>
>
> Ah crap, I should have caught that in the original backport, sorry about
> that.
>
> Should we just revert the original and wait for a "fixed" version to
> show up instead?

I thought about it too. I'm not too familar with working on stable and
the stable-kernel-rules doc doesn't seem to cover this scenario. Sounds
like a cleaner approach overall though.

I'll revert, verify it doesn't break something else, and send it over
shortly.

> thanks,
>
> greg k-h

Thanks,

--=20
Tomasz Kramkowski


