Return-Path: <stable+bounces-240506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jd6Ozgt6mncwAIAu9opvQ
	(envelope-from <stable+bounces-240506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:31:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D309F453BC6
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B650307C23F
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71BA3446AD;
	Thu, 23 Apr 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knHylu9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1C3321D4;
	Thu, 23 Apr 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954511; cv=none; b=S+ukjzcNWX9ol6umTXXmeuLIuMxSJT3g2OdPSWQCOcBeJ0j9MN1S6fjq854ICl7hi570qZOA7znkgsm7M4eN7V6lg7zWGZaJM1MEt/crV7PvdVlwyDvWvi3UF8CHpyuSf6xtE6vNLsU7EVHe8fYHTs9ZYhFikPgI8ZNDE1vKplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954511; c=relaxed/simple;
	bh=m3WdUh1eTSxaCkjBxdgf/EsAHUPINflLtxnbUyDiIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdkW4FgrTOsKBAizjo3VEmz4GEwH0gpBllZAEKPu3fl5y+p+oVi+xHIOCOukBIh5oSGs14TT3pUxf9jmXfc/zDDCTzCt9G1LNkyYQL3Jhyjql4yiIHW9q3clwGg72rD+iJ6zjdb9/wFdXnVUBDPhkLHJMJV0ROoSMMRfPo/XQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knHylu9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99405C2BCAF;
	Thu, 23 Apr 2026 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776954511;
	bh=m3WdUh1eTSxaCkjBxdgf/EsAHUPINflLtxnbUyDiIXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knHylu9ER7yCBMJtyA2d82Fp63C36emKfNtvRDSoC+565P4yf/XAkCiCRjzZJ9FuS
	 aDdqlTGvOl1PBgMOs0LCRcvqO28Mt+xmlpqMUfDq3Ye+oIBNrjS5Y6sbs522HY5alz
	 ax1M0M3oFgVH4RUEKWIjDWGAtu05IuDxxi0DcTJpHHb8B4DR4lj9IJsfX4X6KR94Qn
	 ubTQYXNteY7R8E8y+aJg2KX1FqJO3B3YirNf0lvWP1oFZG2r2fEJfH1RfiBd421NME
	 nDh8zgZkmyiDOaLUGgH5evVFaJHpnSsjaU8f3GUbP9CFrdx2fNQUfRdPeUQQ/KBMy3
	 U8NzQz5ft6LvA==
From: Sasha Levin <sashal@kernel.org>
To: Jay Wang <wanjay@amazon.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 5.10.y] rxrpc: Fix recvmsg() unconditional requeue
Date: Thu, 23 Apr 2026 10:28:23 -0400
Message-ID: <20260423143001.item002-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422222432.7236-1-wanjay@amazon.com>
References: <20260422222432.7236-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240506-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D309F453BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:24:32PM +0000, Jay Wang wrote:
> From: David Howells <dhowells@redhat.com>
>
> [ Upstream commit 2c28769a51deb6022d7fbd499987e237a01dd63a ]
>
> If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the
> call at the front of the recvmsg queue already has its mutex locked,
> it requeues the call - whether or not the call is already queued.

Queued for 5.10, thanks.

--
Thanks,
Sasha

