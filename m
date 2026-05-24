Return-Path: <stable+bounces-254011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O4pBH3qEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:09:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C35C2496
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD08B30039B3
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18EC352C52;
	Sun, 24 May 2026 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R76DGRXS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A173803D2;
	Sun, 24 May 2026 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624569; cv=none; b=RknqrIEkduKyv05Bl6Jgl9Ba+A/qysKfsGpg70B+pwDHaeBFDI2LHlLlLMoitatYG4EezraQn934+IBQSz9jlipkZ78h/sLKpvRmj83agKi/T6CAOxBu0t2DrIbwS4R9hGNn+io6zTgiQRm7PkeHhez7tSHjxjy8lD9IHU7VKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624569; c=relaxed/simple;
	bh=gDeZDTG0fupv7Rzi82OryBSlQlqJcFSYoLVKKjsXY34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrMrIEHUXtDlsUwDplv/I6UrjK5dNY/lI3CM/DNUzCE+L+cTSUFQO6iUceG5O+Lx5E6h2V7+/ZMkpkN8XCTaRUxVFdr/YETRcIePRxpcmI3OSSgbq2ZyTtuvscQmE9kMgpWgdtTUhk2Ngbo3pzixNoLsB8aG36qQS/I9cGJx/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R76DGRXS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2167C1F000E9;
	Sun, 24 May 2026 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624568;
	bh=R5jFYvrQUPdT+lO0lkzQwxojDdVNx6Rg87LNp684XSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R76DGRXSYLzpBYXfY9ylRJtFg7c1c9FkgvkIsbnknVWGa5S3Zizs8pFvC32eHKlh5
	 jXTnb3e3YDco5hrlJfZEo9f4z8vAdfA3MBKbYltrNvRqVjXQlHEoXt2vOnN5UtEtfG
	 0Onrdmr0zqKWZ/OH1oZS38EWlZq9TQcqfTd3BpbVB4JuTJUBwLPXtfeDDWd6HONxPb
	 LEtUvtELqvQmKNv8UiMZrJlVf8S8MZA+VUSDhdc0zrHsuIyUCdA5DPAnNLQ64qgGlm
	 /+WuTu+fdVlR+pZQqvaSUJwP/W2Euz5JaZ6KrdIHQeU3GEdOsr6dUThv5GpmbZw/zV
	 XmZBZndkDhp5w==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y 0/1] ksmbd: validate owner of durable handle on reconnect
Date: Sun, 24 May 2026 08:09:23 -0400
Message-ID: <20260524-stable-item007-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_DE479764A6B5230E038C7F4315AD4C0DC606@qq.com>
References: <tencent_DE479764A6B5230E038C7F4315AD4C0DC606@qq.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254011-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 958C35C2496
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This patch backports upstream commit 49110a8ce654 ("ksmbd: validate owner
> of durable handle on reconnect") to the 6.6.y stable branch to address
> CVE-2026-31717.
> [...]
> An additional adaptation was needed for 6.6.y: in ksmbd_free_global_file_table(),
> the call to ksmbd_destroy_file_table(&global_ft) was replaced with
> idr_destroy/kfree, since the function changed to take a
> struct ksmbd_session *. This matches the approach in upstream commit
> d484d621d40f ("ksmbd: add durable scavenger timer").

Thanks for the backport. The 6.12.y version has been queued.

For 6.6.y, the diff isn't a straight cherry-pick and the rewritten
ksmbd_free_global_file_table() path in particular is a non-trivial
stable-only adaptation. Before I queue this for 6.6.y, could you get
Acks from the ksmbd maintainers on the 6.6.y diff specifically? In
particular:

  Namjae Jeon <linkinjeon@kernel.org>
  Steve French <stfrench@microsoft.com>

Once one of them has Ack'd the 6.6 adaptation I'll pick it up.

-- 
Thanks,
Sasha

