Return-Path: <stable+bounces-225718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HaoLFaUuGnTgAEAu9opvQ
	(envelope-from <stable+bounces-225718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:37:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE02A205F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2A8B30616D5
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105937186C;
	Mon, 16 Mar 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgxOcbYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1034B434;
	Mon, 16 Mar 2026 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704241; cv=none; b=tlEvcdSypxrfgyKxvCjsOY+RQT2UfmWsBKAPE3avk1zO2BMpbhNWPNH6jQqlw/YMAsmkViJ1XbFvRvkIorii8ns0v1fzXDqP34kohdW/oRdZ+pZ67OlAwICQbOl8B3c+zX9xXvl33F3ImScRu75FxQEEFrBD8Zx1jwUjD5tU5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704241; c=relaxed/simple;
	bh=S+lf83P352ONiWt5Oxfez1dYw+llENHgLdCSYdGltzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=meJLguyZFpijHIOp4PC1jiKkONGP3Uk5qA2w8AeyYRmkIi5xmNeBIyquWaDvLfRQDDHPdY0/rbVRLRvbbIOXn+HXKKinVTW4xjK+WkAKDU1nh91WyAW+7kcizW2YXWZGKxwxWs8dgXWze2dEtktKmDCs6ArfhsrRi1Yimla5bg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgxOcbYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD5EC4AF0C;
	Mon, 16 Mar 2026 23:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773704240;
	bh=S+lf83P352ONiWt5Oxfez1dYw+llENHgLdCSYdGltzw=;
	h=Date:From:To:Cc:Subject:From;
	b=KgxOcbYdV505UOsLjaZ7P4Qmg0qu3Hz3EO4NxCNS/k61ra5gatuYtw0ZB1SWH2PRq
	 RiSpbvyvLezGfH0VGkxEU7VkDD+G6Fq3xb0mvkuS7pyXgkaoEYFInKijwbjfra3Afe
	 EdANAeNrUsgcwSGS8AGMKNmChpNBgTqDCxeGdsg/yWQ3emjGHMbHNzfRWZlB9RmNip
	 JsmYLy2BPs9l0PhfG2kyxyehS8IavRs8y4/yL8gwYGVL0ApLd2OitP2wYGqt5LWZTx
	 LUHJqFzyjEmjyn7vNK2ebMPgTOvx0L1SghbzRAiH03VXNBuON5tUPJHeMBd+XW+Ba7
	 8nGODklXrL4MQ==
Date: Mon, 16 Mar 2026 16:37:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Apply e2ffa15b9baa and fde0ab43b9a3 to 6.12
Message-ID: <20260316233716.GA758717@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225718-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58BE02A205F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg and Sasha,

Please apply

  e2ffa15b9baa ("kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17")

and its follow up fix

  fde0ab43b9a3 ("Fix CC_HAS_ASM_GOTO_OUTPUT on non-x86 architectures")

to 6.12, as it helps avoid bogus errors around cleanup variables.

If there are any issues, please let me know.

Cheers,
Nathan

