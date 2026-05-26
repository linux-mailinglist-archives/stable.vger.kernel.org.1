Return-Path: <stable+bounces-254269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIVfLj9VFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:09:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 361AD5D23B9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0020301EB6A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D33B774A;
	Tue, 26 May 2026 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/6YcQ6X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28B3988FA;
	Tue, 26 May 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782972; cv=none; b=Nb0W/B8rO1HC+HPAWCkjZoZqxTbRsCUp0dSS0RMSb2ZXa0I+Ca9quE60ngVxlTBjpRu35uToavwEUYsSeHwmw0z//FiYdZ1Pm1B5xkOUhSgAnRHEv3OGxuKQruHc1c9WxobzrunkOlqr9cHLVbulS/8FLYd5wrKQlJrFFYB15/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782972; c=relaxed/simple;
	bh=EXKddH1zpLtrtQGh3eZuh5rMOAnnal8x6Yzh9BUL/Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd+D1cs70aM6gMy0i/6oshgcdN0Cm7DVSIkMhBL724JpT+9DocEawOvHJndWsWNKA1GL6DTk7FC7JSXp7EQEMGc53QxNlCSMLhxTfb15S6Hoz7TWanjs5SRf8nWRpaFY+hdbgAv5v8saPKjQgMEcIUBTUHogdWn5Hb1G6U+B/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/6YcQ6X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7BF1F000E9;
	Tue, 26 May 2026 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779782971;
	bh=7lLqjxWsNK3wG5hsFQx4HuXM9R/Kp26iiy3YmlseoLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/6YcQ6XnmblmspJprDGRngxPal5gJoClYl7PDFFq5a2oMRNWKEIOtskete9OwCY5
	 CPLKv5J0hMV5FVxgczIomlhiys609xrC+a5AoXQOsMUv8exdeSoglz3MUrHXHo5dQD
	 cUJUSIGKKlVL2Kl+RAYVm01RYAll2jlK+xZdqNlPXEtGpsUBwmw49gkRPQyG7B9+wk
	 tyo02RQM2N4ZPvl6RKCLCc1dUfne7SJzi3FZMI0eCNYZXu88nGQay4UmvstHipDoXT
	 CePL9iyiIlYRePZz3IVPpZxTXWNClOFQPA7i+QGjB/NVHT4wVZKMorgp6S/ZLdL/CH
	 qlwDrdvlFuNLA==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing operation
Date: Tue, 26 May 2026 11:09:24 +0300
Message-ID: <177978294141.4088010.16047486364171482805.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519122428.2378446-1-pratyush@kernel.org>
References: <20260519122428.2378446-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254269-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 361AD5D23B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 19 May 2026 14:24:26 +0200, Pratyush Yadav wrote:
> The sessions ioctls are not applicable to all session types. PRESERVE_FD
> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
> valid for incoming session. Calling a incoming ioctl on an outgoing
> session is invalid and can cause file handlers to run into unexpected
> errors.
> 
> For example, a user can create a (outgoing) session, preserve a memfd,
> and then immediately do a retrieve without doing a kexec in between.
> This would result in memfd's retrieve handler to run. The handlers
> expects to be called from a post-kexec context, and will try to do a
> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
> 
> [...]

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: validate session type before performing operation
      commit: da7f658ccc8da60d836051a7af1c53e643f4bd11

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.


