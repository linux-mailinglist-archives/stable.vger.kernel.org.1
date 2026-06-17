Return-Path: <stable+bounces-266761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DjxIEhWgMmq92wUAu9opvQ
	(envelope-from <stable+bounces-266761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:24:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FB69A10E
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:24:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CO2Sv6j3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266761-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266761-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00F1930AE10F
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4B405C43;
	Wed, 17 Jun 2026 13:22:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046143BCD31;
	Wed, 17 Jun 2026 13:22:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702549; cv=none; b=BgZHxi1J/2MYsrxPKsTF8QCJS+qqgW+0ap0OI5fhgxNMYxMMhge1iu3Upr2alE5SfzzVNWPRa+RsD716VvyLo+kQSgNaiJ6UDLh5PN8CWD6e1autTa+3hnBQlkD1NHI3ZlaS0TOPoJtK7lxvXLTDt8sDikZ3R8uRBQHH1WWwWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702549; c=relaxed/simple;
	bh=2l+Wx1vgZnMvuLLZF695Kf9yHqIqlLEZVIyAT0+TDPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hqDSbCPMCW5m1gZMUjk3PaVbB1J57gIxnObff/i/tHw0dntSkjkgVxN9u8Hl5yLwwAcOr896SBb30UCq81gvV/UUS+rEtgoB8WKA79wiK6961mTwi/DqGD2eNmWUbb0OAO4xfVi9ozkqbadkZbw1ZA1YP1jsoXsue8FTt+dNXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO2Sv6j3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011E91F000E9;
	Wed, 17 Jun 2026 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781702548;
	bh=jjE1ZgEQ7JK8ooIDdfvIp9yidTMTkSuCid79afKW4HA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CO2Sv6j3D1MvkjY+AfuWFS/W0s2AxAFVNZXibTGHyLViBO2kHoDIOCLB20Fm/7AiG
	 gr4wr8Fee4yWuKlpV+X/vEE+cT9lFSOn2lInt/vGAVzQrHjKX1H5C1DXVsmVkkcbYz
	 oaRQfn1yCCA/Z4OTS0VhZnJKia4yytKDsl7lcc/VXe660cHNBY4gWRNtwG7yDYd6Hn
	 SfPDJDOihKHgKizKEvkwVpFarcsGlQXEImYph2z8EwWbRgqkqEbWTcZCJ7ZYiukoZ9
	 Ec9mmznt+9SC0IgDNzBCFW935dyfq+hdTgr95wrhNt6P282awuYrsjOyvICz3c3NDx
	 0SDW96A97CSmw==
From: Christian Brauner <brauner@kernel.org>
To: miklos@szeredi.hu, amir73il@gmail.com, 
 Souvik Banerjee <souvik@amlalabs.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260501232735.2610824-1-souvik@amlalabs.com>
References: <20260501232735.2610824-1-souvik@amlalabs.com>
Subject: Re: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
Message-Id: <178170254157.660235.877558308523952750.b4-ty@b4>
Date: Wed, 17 Jun 2026 15:22:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2l+Wx1vgZnMvuLLZF695Kf9yHqIqlLEZVIyAT0+TDPQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZzZ/EabtpGTdDsjXTwt0sLPe/Nt4+y5yqdZlZZuKly
 +szLnzk6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIARMjw5t7BxWyriidjch1
 vNPH6bLGfFnKnldTLixh2nLZOtrTKYmR4cmipQ4ndxRP/v3rYsiab28FHWaqu9zLcz6QYhbKvfD
 OPx4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:amir73il@gmail.com,m:souvik@amlalabs.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,amlalabs.com];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266761-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA4FB69A10E

On Fri, 01 May 2026 23:27:35 +0000, Souvik Banerjee wrote:
> ovl: use linked upper dentry in copy-up tmpfile

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] ovl: use linked upper dentry in copy-up tmpfile
      https://git.kernel.org/vfs/vfs/c/8726161b595e


