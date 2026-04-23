Return-Path: <stable+bounces-240528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODd7Lh9s6mmhzAIAu9opvQ
	(envelope-from <stable+bounces-240528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:59:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA48456469
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD492300C9A0
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237693B19DA;
	Thu, 23 Apr 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6P9ju65"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46F3A783E;
	Thu, 23 Apr 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970778; cv=none; b=J9931SGt/fxGJ7ARla32Qc6tYQzy88BlxdwyfXMF8pGYsn7Ovb8XgZh7eQLEyfd0q6Ig0kZI8TCdP+YthsYkP20PSqLytuXyI+ZGdJ+exzdju+0pTI9s0BJNyCoBy0jA1lklY4zphsGr+HV+CwnjFH3zGOwwYXlLK2np93ZlP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970778; c=relaxed/simple;
	bh=89CpwZWpqz6tMu+rKPycm3pbZSmQA7XFPfnmi/2V8ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqZ3BP/LtxxgEDMp9nyb4KQBPLQ32L/MO1XbHN3ji0m8wCBhUCpnEZ18pKyxGlavSITN6Kqy6z2oducNV5MvbyuqO+iDfzNPjTToMGmPkIvDlbJ0CP5J5FCe0slUM8HsTJJEHbpJfJjA5b5yGQRaMUZH+B93qnWPHaGHOxMFVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6P9ju65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B91CC2BCAF;
	Thu, 23 Apr 2026 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970778;
	bh=89CpwZWpqz6tMu+rKPycm3pbZSmQA7XFPfnmi/2V8ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6P9ju65CgdS/TxjbyJsj5gr8mme0lUX2y5Sue+pRjrxTW5DjJ2rqmWRZP0g4a6TK
	 b3W4utHhvZ+x3hLk9RVPtyuVGjSq/BtzDsG4LmqEyraqODBfHHYXMaRJBApnpUaCH2
	 7vYbLsSEghXq5PUryVx70tBbfQrlNI2JS2JvE9ddVbs8XoWJRl2vQHdFoqR9QuRGP9
	 /eHTfAqx/06VcKdeIHJ0KH8KZ2VBLZ/FW2FxNoUfyzi4aboFhPLwGOUaQZ3SmKrhpb
	 FtJiivRQx+obea2vsDIgcMVCQY1xvBziOlWmpEYBEjUn5eeHvcMBZoII1nAAYJNWjJ
	 ZGCwwG5Xa8ltw==
From: Sasha Levin <sashal@kernel.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 5.10.y] cifs: Fix connections leak when tlink setup failed
Date: Thu, 23 Apr 2026 14:59:36 -0400
Message-ID: <20260423185936.1060816-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <83e432c2-8749-aca3-b5c8-ea89edc75ae9@basealt.ru>
References: <20260423140245.195039-1-kovalev@altlinux.org> <83e432c2-8749-aca3-b5c8-ea89edc75ae9@basealt.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240528-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EA48456469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 05:41:12PM +0300, Vasiliy Kovalev wrote:
> v1 of "cifs: Fix connections leak when tlink setup failed"
> (CVE-2022-49822) is currently in queue-5.10:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.10&id=685f89e4d2b45768ca796eb22ec1a553fecbdf05
>
> Please drop it and apply v2 instead. v1 introduces a double-free for
> mntdata on the new goto error path from mount_setup_tlink() failure:
> after a successful dfs_cache_add_vol() the pointer is owned by vol_list
> (vi->mntdata), but the error: label still calls kfree(mntdata). v2 NULLs
> out mntdata after the ownership transfer.

I've dropped v1 from pending-5.10 and queued v2 in its place.

--
Thanks,
Sasha

