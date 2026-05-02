Return-Path: <stable+bounces-242614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHj0IjIr9mk+SwIAu9opvQ
	(envelope-from <stable+bounces-242614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD5A4B2E70
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C14A300DA7D
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2F38642A;
	Sat,  2 May 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs2m19hc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38613175A6B;
	Sat,  2 May 2026 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740586; cv=none; b=r+HDAy3FR97+wD8qtu4kRoISqywhjX8LKAyBP6lN6KzK0aANO/9qFvhqD93AE96mOtAkaRnr4ogynny2Slz2Oegnp8GxKkZFEJU7mcfF4N61uTlejb45jlgxTIXBmoQ0JXQNCLWnm55cBsW8fwgIOgg1+B9Pm3/TfCsSDfzkBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740586; c=relaxed/simple;
	bh=bszYzwC1o/Xp6s0BB8DnMIAglKIchkNIyHABgW0+lJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERWJlm4/aykiiRhCoHoi4IzTRAa2SjSDcjNaw/hsysg2EHihbwR9Ue2mcvChbae4jkJmBpFjFSVr1j1r3+560PI8Qp85RVLe6RXAmef0+PazHtd5Dioko/f1WizcJ0UKHLuLO1dpW7OMHvTZnICpD4fa7GKoXaHyZ3eV4dP1YuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs2m19hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1EDC2BCC6;
	Sat,  2 May 2026 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777740585;
	bh=bszYzwC1o/Xp6s0BB8DnMIAglKIchkNIyHABgW0+lJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rs2m19hcs9F1mPNEnlXAQrKimjzpmqazjL5w2VfMM6JkWs2UhXeDSFIEvmcSqPMrA
	 sceD8V17IRrLvlIy6X6JNN5WcEURFWCCFry1+BlvlHJ1RmnQpsiTrU17Bs+ndFkHWp
	 Z6Z2PBxvbws2+aj5hvPO6n0AX3QOGurTkDt3zBTJekTUYfAQMW9H3hALqLHPwXykA3
	 VjUC2KQIwuzuvgkGXV8WUdf5ShvlBAmhzn6g2OPqJtsxUSSpSfdbtBWtdSrcF5+2w+
	 IijEaYqLJ2uKTgggauMnkh9aeInIj7JQR9l+3UsdK6WEhbrnHQHjZEd+I1/Q2KB0TU
	 DKSJaKMSBe1Xw==
Date: Sat, 2 May 2026 09:49:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] nfc: hci: fix out-of-bounds read in HCP header
 parsing
Message-ID: <20260502094944.6aa267c6@kernel.org>
In-Reply-To: <20260502163116.3409687-1-ashutoshdesai993@gmail.com>
References: <20260502163116.3409687-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5DD5A4B2E70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242614-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sat,  2 May 2026 16:31:16 +0000 Ashutosh Desai wrote:
> To: netdev@vger.kernel.org
> Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Ashutosh Desai <ashutoshdesai993@gmail.com>

You are not CCing the (recently added) NFC maintainer.
Please wait until Monday and repost with the CC list corrected.

