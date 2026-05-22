Return-Path: <stable+bounces-253768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J9BNMNEEGpqVgYAu9opvQ
	(envelope-from <stable+bounces-253768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:57:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8005B35AC
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 174FD304554F
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0173EDAA2;
	Fri, 22 May 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD1hruH/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434303ED3BE;
	Fri, 22 May 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450466; cv=none; b=eK/jjxd/BaRGlsQQFAj4sIocEh1qHpU4SJXLFgX/TYZI0gf10FYMKFoXpjA2hrdP7cRrmB762GtJgr8Q1s2w+JALHYVY63UDmbtz5Xa7HJNJbkGThrNJbLEhg/C09CgEngmuVtGWQmZEUy/bn3S6pxGSLrC6qiACIGhxFNfuYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450466; c=relaxed/simple;
	bh=LCiQtFsq830moWFz71Ju8TmAiMfKY7/ZuV9tNFhCwXE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lv4/IJs4EOM+G82d5WTR5Zjq1frr+p438wwkahuw/7brieT93EY8Zt6nz8BCx1IBFfa4GfBE+InzYSwQBMjStPiJdCTnuNmStX8/+5Vhb14M0YPrcO4WCkz2pvvB2d/XOLIHUUidsCNa2UUfBGdM7PrARPLC1/Qkq23NfYZrsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD1hruH/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAC71F000E9;
	Fri, 22 May 2026 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779450462;
	bh=mzVF0vs8iiYIeaThyf1CmLIQ1h8alW1VxekVPuhjlwo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QD1hruH/0jz+/CunTYJaRVA284mGdAHPG+xwSjT+SQEanXrCSccGSULZjn6+w84f6
	 CJJ2/vbBPJj4kRE8MCjgAue9oL7dVouyccoD3APLXjyxYq/EXiRe4ONwYCbzjttt4K
	 XM+Gb8YLiEy4zCKzvOykuJOYXkVtzSCu5TGMHl3XjbPBXv/jZ4r3AOH8s42ejEZ4iB
	 X5FZGMHS7XbcTL/jGCXL4AGtuwQrDERPvMZPpCDxip0EtQMCLzRgGebJa/Lx796iy0
	 9R+VOu9X7OQpnRxK+RQu6zq9pcMWL34OQcHUeURD3naUjG4uyC0EzKrYzk10JwvK49
	 DnSwSY/WuyEvQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arjan van de Ven <arjan@linux.intel.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
Date: Fri, 22 May 2026 13:47:35 +0200
Message-Id: <20260522-herzrasen-beflissen-geachtet-80b74e882307@brauner>
X-Mailer: b4 0.16-dev-05c9c
X-Developer-Signature: v=1; a=openpgp-sha256; l=609; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LCiQtFsq830moWFz71Ju8TmAiMfKY7/ZuV9tNFhCwXE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJOEVX981knDfBvuf8oq7O297f9xfd0jm0zMApPc/9o
 dYWlr2xHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpADc5keGf8he3594yxu/kmi/9
 cYv12GV354FPWYy12oKbzGsOqx/9yciwYt2KGRvqeg1MF6zWab/Bd/nxQv7/wjvk9839Jdse3V/
 NCgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253768-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED8005B35AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 18:35:14 +0200, Jann Horn <jannh@google.com> wrote:
> [...]
> 
> (checkpatch complains about missing argument names in
> proc_op::proc_get_link, but that was already the case before my patch.)
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Hm, not super nice as this may cause performance regressions but I think
you're right otherwise. While mostly info leaks - as you mentioned
elsewhere - it would still be nice to try and fix them. So if we can do
it without anyone noticing perf regressions it's probably worth it.

-- 
Christian Brauner <brauner@kernel.org>

