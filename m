Return-Path: <stable+bounces-249717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L5MGYAGDWpWsQUAu9opvQ
	(envelope-from <stable+bounces-249717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:55:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A92586696
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4861F3026EE8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBE2C21FE;
	Wed, 20 May 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtv/Hz0d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423B29C328;
	Wed, 20 May 2026 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238469; cv=none; b=jG2fTVLFR5izXnqaHjIH6JDH0AX5jjGRx06BKSJb+fsUiND5DGl+CY+R4Na3+X5cAZBub4++bGr7SQgb52f3N31w+z2wWtqhBUvkRYaNBA2UumWtbPrLyQX0i5NfizIN5c/fN8ds7eh3JakxBRrdJipZnGxx7CzE16lizBCH6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238469; c=relaxed/simple;
	bh=wtr1MGYxvmZx6lIlyMwQcI3r28Ttp6Pqw5OIfriaaIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+uTv46ntnGOlsC0RyXI0M2PfAKrBVef55RsGfZORLQAK5dL0d7hS/PMfM4MgIzRrCVBQBFVgzYUEJgP+tNl9I/CnmLg0i1h+0ZcfmRHxa0QRC8j6rmEBAd1a+PluFaypODAM4F0ji36KlGxjCyECCFKGi/1RWpcy5D0YbIusJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtv/Hz0d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BFB1F000E9;
	Wed, 20 May 2026 00:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238468;
	bh=Kc4bQ0foB5Cii1TppaHU26bKVUYO25JGOtK4mN0+IZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xtv/Hz0dhBBA/6sHbwl9MC2rIl9Dtqrb3s+TPRmqWTHK9chp+HTPC02dBkNDPBLxu
	 4xkmJc56//LgyLVKQwiqKymk5VOR+6opHmkJuvkKOsdibC51YOkz8Vnp7kVhniHNYn
	 YTXHeU0P4ISc2WGAyVoBAxcgU0SxZAPGgGoUzD63QuomHKHKKur1rGX3Vmbk/CPJvO
	 FPZWnfIedZho7PM7SYBCCYHcXsTqKOcIBFiJxvrbiFC6fcU4MepS36xldXSHxwnOmZ
	 YnoKgyqeH5JqH0g+NdAsMtBS6zTLG07WRAVQTyTUQIfZqY6YzVimx+lmASrTb4np5u
	 PeRiTM5CAqjww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org,
	leitao@debian.org,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 6.18.y v2] fuse: avoid 0x10 fault in fuse_readahead when max_pages == 0
Date: Tue, 19 May 2026 20:54:17 -0400
Message-ID: <20260519220508.reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519174816.3983940-1-vlad.wing@gmail.com>
References: <20260519174816.3983940-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249717-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,szeredi.hu,gmail.com,vger.kernel.org,debian.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 70A92586696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:48:16AM -0700, Vlad Poenaru wrote:
> [ Upstream commit 4ea907108a5c ("fuse: use iomap for readahead") ]
>
> The upstream fix is the iomap conversion in commit 4ea907108a5c
> ("fuse: use iomap for readahead"), which rewrote fuse_readahead()
> entirely and removed the buggy loop along with it.  That refactor
> is too invasive to backport to the pre-iomap readahead path still
> used by 6.18.y (and earlier stable branches), so this is a minimal,
> equivalent fix to the same bug on those branches.
[...]
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> Reported-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Queued for 6.18, thanks.

--
Thanks,
Sasha

