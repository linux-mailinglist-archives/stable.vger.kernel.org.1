Return-Path: <stable+bounces-242811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ8kG7WR92lhjAIAu9opvQ
	(envelope-from <stable+bounces-242811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 20:19:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7E4B6F6A
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 20:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60604300D946
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97B3D0930;
	Sun,  3 May 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvZAmaKT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9F3D091E;
	Sun,  3 May 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832272; cv=none; b=Rf/lraHVlO8FmuCzS4y12hrq5UZtVqAE3KxZj+MdYtNidWq5c4tLuTT4PBQqMg/gOp0dAENFfyok3JuECeMaQL0bVCqg2h5dvHuoK0TU04+0xrI/XsF30e4tUXuiUrn8qrvMnU/wnXJ3exhfOnFRONCKXh+rKapzAHK2tfMzgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832272; c=relaxed/simple;
	bh=K2ZsK7aHnkiscMKQuW5eEQeMVLWjvtX361I1jQXLeYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wwcm7J+97JVquNZiKW0NQKByPNH/B6NPg3+WWViC8smGqt1NUkIqWujMRd+wSIVdIYB3wr5aEHQvANnNfZY9N53RL5M/k9BdJAkZVm/chYWs8VTKO/Q50Gl5FDLU71N3vRI7VQtw9PWRfitO+Xl9MJ1DQgUNkfLQ3YH/DYluunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvZAmaKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E34C2BCB4;
	Sun,  3 May 2026 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777832272;
	bh=K2ZsK7aHnkiscMKQuW5eEQeMVLWjvtX361I1jQXLeYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvZAmaKTMW+BFgsE/O93gul4+5v696+j0jt41AU7VzK5jdHc4weXI7vRotpD6NCT9
	 OvrO+SdL+WDqK10eCX2uymjpnGVDREw3JF4fqVRtGUOpvJsH5Fxf13EDJDFyonLbMO
	 jiOkDwfgZkvtPC/WbBRVnOyHqy7W4Yvo9H/vHsVU1kmKeKldpe0cWVwuyR//gJgtEK
	 cJjah13Qy9z39aDYklwtsqxOI3rGfjqmO30mVGCGyO8Kjp4zW77ZLFZDuFFoxdGOD7
	 GZXXCAC4BAZdurGpgCzmLTZxnA5avrhgnYBGBvP45nc8JDyITgyaVoT4sojMj+8Rb5
	 a/MjxKTIF6neA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Kai Aizen <kai.aizen.dev@gmail.com>
Subject: Re: [PATCH 6.6.y] ksmbd: add chann_lock to protect ksmbd_chann_list xarray
Date: Sun,  3 May 2026 14:17:48 -0400
Message-ID: <20260503143410.item002-ksmbd-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501225152.90136-1-kai.aizen.dev@gmail.com>
References: <20260501225152.90136-1-kai.aizen.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04F7E4B6F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242811-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,lists.samba.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 01:51:50AM +0300, Kai Aizen wrote:
> From: Namjae Jeon <linkinjeon@kernel.org>
>
> [ Upstream commit 4f3a06cc57976cafa8c6f716646be6c79a99e485 ]
>
> ksmbd_chann_list xarray lacks synchronization, allowing use-after-free in
> multi-channel sessions (between lookup_chann_list() and ksmbd_chann_del).
>
> Adds rw_semaphore chann_lock to struct ksmbd_session and protects
> all xa_load/xa_store/xa_erase accesses.

Thanks for the backport. Unfortunately I'm holding off on queuing this
(and the 6.1.y / 5.15.y siblings) for now.

The backport is faithful to upstream, but on closer review the upstream
commit 4f3a06cc5797 itself does not fully cover the race: there are
xa_for_each() / xa_empty() / xa_load() call sites that remain unprotected
after the patch. Shipping just this commit to the LTS trees would leave
the same UAF window open.

--
Thanks,
Sasha

