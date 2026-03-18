Return-Path: <stable+bounces-227011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yANwAF92ummTWwIAu9opvQ
	(envelope-from <stable+bounces-227011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:54:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 104192B97ED
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73C073092A05
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D153AE6F8;
	Wed, 18 Mar 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkGv3tpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047233B9616
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826945; cv=none; b=q5x7uU8XXgn1QYOa006O1xjimv5ml3FGSXUqtxIj65WgyRmPi2+vU1flnhnfNPb8eOhcBpgWD6dCCZaSmRk0fLv48Igq8uUnB6XoSt6FcX8Ah4RJDUJu+SwEgR2w/oeiEiFUHsP2clZE/XKwQW17QWh4tMjxAkV/XOQeuenU58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826945; c=relaxed/simple;
	bh=5+5G8anF2tKUQrI5CX0a3+sj5MK0W5XSdB0+boH8ssU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFDbjALuqR07sHxaPAEzFmlr2gI+kyvV+E4IOF6SWzS0U/5lBOCogQop7cbJIQdOmfdHw/XYb5aMnFXgSUDHVNv84scVq23/krr9LzBEml2I4cqUw6LUsgN+GTOSoPp09XjDlgSQ8qIn1T6hFd7GySZVcwFLV1znBjYr/m9o7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkGv3tpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7FEC2BC87;
	Wed, 18 Mar 2026 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826944;
	bh=5+5G8anF2tKUQrI5CX0a3+sj5MK0W5XSdB0+boH8ssU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkGv3tpLJhkubWbYg2kWDOCw0RjE2GPaYo7DmLwMLUyOFNwxPN9j5CccdckuVblRS
	 aEg4brh06pWxWh/xJt32DEkx5ihf6ZTcBJYPM5dm0sf+ME+o0ibAnfmvBIQ6N8oK0U
	 e5SGjqmAdXJdRIAWU+ds0lt7Po9piTbXpIuMw5kJylEjIKMiyPc7ZjZJEUjSoP6wYe
	 bOIPDa9YxbENhTxG6v++lGiO6gDJ2wpScAStK40u84/+7AN1B1uSDFuadD0wqxLnhj
	 4fkrOH7z0lg13Z68fH9W1P6hVUscZ9y2ccFwvHJz8Jxfi4O5XqvHPCeMEWnkgEbpN3
	 gZ7LNvQTJWXAA==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] iomap: fix invalid folio access when i_blkbits differs from I/O granularity
Date: Wed, 18 Mar 2026 10:42:18 +0100
Message-ID: <20260318-tonart-auftakt-0c9d92bd1863@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317203935.830549-1-joannelkoong@gmail.com>
References: <20260317203935.830549-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=brauner@kernel.org; h=from:subject:message-id; bh=5+5G8anF2tKUQrI5CX0a3+sj5MK0W5XSdB0+boH8ssU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTuKq6+sp6vuMHi5Pwr1r+XTw+P3+m5S/yzw5mLWs3nV a0WqH7r6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIVTnDf5eNS+JC5KyyD7Q1 S67vs3rNp2c8p+ywtelWbs5FazrXr2X4X5Wr+bcvWa02fru2Ieuazw5OMlKpf5bsOVCoeNlcSau HHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227011-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 104192B97ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 13:39:35 -0700, Joanne Koong wrote:
> Commit aa35dd5cbc06 ("iomap: fix invalid folio access after
> folio_end_read()") partially addressed invalid folio access for folios
> without an ifs attached, but it did not handle the case where
> 1 << inode->i_blkbits matches the folio size but is different from the
> granularity used for the IO, which means IO can be submitted for less
> than the full folio for the !ifs case.
> 
> [...]

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

[1/1] iomap: fix invalid folio access when i_blkbits differs from I/O granularity
      https://git.kernel.org/vfs/vfs/c/bd71fb3fea99

