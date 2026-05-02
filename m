Return-Path: <stable+bounces-242587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 65QxDAu/9WlCOgIAu9opvQ
	(envelope-from <stable+bounces-242587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:08:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E54B17F4
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BA53017034
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15F2F290E;
	Sat,  2 May 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ntlPKz5u"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E92DEA9B
	for <stable@vger.kernel.org>; Sat,  2 May 2026 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777712900; cv=none; b=p6/KiPGBNERkIZz6WLSQwGeWkmFTeoHFo1wX64zeBw0sGWl9fepdn33Z5OKOhCHr3tAciX4K98tN+QWBm8QyBgUCl+fGSJmrvYU5jCxInr+PQrx9/bLJVUizwMbc7whr5/OWQkqFLpjP34s0BJZSVngbyoaBN+GHOKtOGoea+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777712900; c=relaxed/simple;
	bh=7QbyI59Pdb9sb4X+UFRHx2zieFU5IvzFFR1nTLLWQz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYOf7HATHL5djJWnw4EHIddecZf9BPeVWViZfUsPf9nI6BUNYtbI0UkOCV2VqgQMIf7AmO+uTPt8GKAwXbE4s1LUex4dMF+fq24jZAH/pacT8LN5yHlCQv9A8y4ypl+5kMDHqPG+qfOZflUR+gDjCugCINHRq6HRRubfVAFlrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ntlPKz5u; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [95.24.28.48])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9DCC445A1D1D;
	Sat,  2 May 2026 09:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9DCC445A1D1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1777712884;
	bh=UN/fGF5rtznIEbzrab6e8cF2yiO29rw8CfDIHrKPpiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntlPKz5uRinzTGQ3s1+sbxR1rW5fxNC7iFgL908YwJ/kn1omowPI+WTiuz4kPHidn
	 az32c28/gMZykFwZVDJf7aVaX46CZunfjPse3lW/hBvn7n7BO1P4LhIBf5yzFiL7ru
	 Pa0nL3aDlWCXfedqovDHCaHHRJ1NZkQD6zJIA8Gs=
Date: Sat, 2 May 2026 12:08:04 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <ben@decadent.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
Message-ID: <20260502120536-82f73a7f6431526a6d4ebcde-pchelkin@ispras>
References: <20260501111233-b371eac52cd006bfddfbd9e5-pchelkin@ispras>
 <58103791-4c19-441c-9d4f-7ae5f9c6151a@kernel.dk>
 <20260502003658-e04f382bc8ed201a99b573e0-pchelkin@ispras>
 <20260502005417-671675fb5906578c85c3fb4f-pchelkin@ispras>
 <fb26a75a-cb2c-4ee6-92b9-4c488a2c7ba5@kernel.dk>
 <20260502011444-849ff2d3f8fe48b07f48d496-pchelkin@ispras>
 <5794c5cd-ff76-428a-830b-6aaff9d36089@kernel.dk>
 <9b00a03b-ff87-4d09-be2a-5865e555bcd6@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b00a03b-ff87-4d09-be2a-5865e555bcd6@kernel.dk>
X-Rspamd-Queue-Id: 186E54B17F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,ispras.ru:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-242587-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]

On Fri, 01. May 17:27, Jens Axboe wrote:
> OK, here's the new set for both 5.10-stable and 5.15-stable. Ran it through the
> usual testing.
> 
> Let's hope we can put this one to bed now :-)

Hope so as well.  Thank you for the updated patches!

