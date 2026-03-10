Return-Path: <stable+bounces-224540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF6GDtZhsGloigIAu9opvQ
	(envelope-from <stable+bounces-224540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:24:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4592565B9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 326C13068A3A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122052DAFA5;
	Tue, 10 Mar 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBppPdW3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDD2D8760;
	Tue, 10 Mar 2026 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167056; cv=none; b=UFxgjbWHkzqGq5JsvsP7iBiriQe11OdfQnlscp7RFxAp3ut9mxLwAtcBfQUkh2/J6gK2nlDPACmT343zgho4TgZbHS8AtDetGEGYikRwb+Q+Ta+Wv0FJym6k3Ws72KDwsz6dO0sHdhxGo0i/M7MN0v7Z+eFekh87Z6ygimUntNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167056; c=relaxed/simple;
	bh=60fgkUWv92rLl/BzDoW4SUNLQP2bHEZxw7UrCs7abIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TM4yygKuEc5MAolrPjypIjSKPWSaj0xhBsuSVHCYe0/koAOGULtQbEP+wF1PFIxMmH29O3EpM6himsJjcC4+N97EvCZ8D59LC5Lx7s0RJTxBg9CuBUqyFC4b0ad5jKnLyY+XErsJO2YpNlQ1tSU3sHK8EmE3LhbgOYEU7ffiGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBppPdW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E11C19423;
	Tue, 10 Mar 2026 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773167056;
	bh=60fgkUWv92rLl/BzDoW4SUNLQP2bHEZxw7UrCs7abIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBppPdW33AdnO65LirAuuQCuyc0yAjz8IHfD6Oz5XBSkkHJ4wuk2hYjfgZ3+f0xCw
	 /8RSI8DCAXhS68OOaLJ7lVQ7/LmOS6sIfejXfD133JUwwwOeSZRq0TafcfVCi3uUqX
	 X/nW/eLSQEDtJPxN89fDZ56h9OJf0TMwb3rtmVtpGbYzxFL79IDtSlBoXA/tldrgQJ
	 km/C1+XfbFv00YK3gqf2X3uRB8TxlJaAVj7QoI3dagJt4seqgfTcwpkRvk9K7g3G0O
	 DDnR293hcji+pqLfGbQcKFqu9W92EAok8L75heenXeInVBRvyeUKJpNar1vGwMtXP3
	 4Dw6y+qHWUTvw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: microchip: fail auto-update probe if no flash found
Date: Tue, 10 Mar 2026 18:24:11 +0000
Message-ID: <20260310-gyration-smasher-1eb31125b2b6@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303-emphatic-roundness-8fe5cd8c3159@spud>
References: <20260303-emphatic-roundness-8fe5cd8c3159@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=836; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=hWgL2DzJiZOmEy7GIVpd1Ka6l//mB6IOSxtqxJ4xxNo=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbEs88+LWhQ4RZ7uH3mW/rL5ee0hfQmM4ne/7Fpi2Lr x/Pz93T3VHKwiDGxSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJeAsyMvyttczhfnZpstkb nxIm723tHa+O/hR9teby+gmJKllfoxYy/A8r/c26O3uug/fn2fX2la92TmV45tfVujT8SNG/GaY s57gB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E4592565B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224540-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 03 Mar 2026 11:24:06 +0000, Conor Dooley wrote:
> There's no point letting the driver probe if there is no flash, as
> trying to do a firmware upload will fail. Move the code that attempts
> to get the flash from firmware upload to probe, and let it emit a
> message to users stating why auto-update is not supported.
> The code currently could have a problem if there's a flash in
> devicetree, but the system controller driver fails to get a pointer to
> it from the mtd subsystem, which will cause
> mpfs_sys_controller_get_flash() to return an error. Check for errors and
> null, instead of just null, in the new clause.
> 
> [...]

Applied to riscv-soc-fixes, thanks!

[1/1] firmware: microchip: fail auto-update probe if no flash found
      https://git.kernel.org/conor/c/c30b2509164f

Thanks,
Conor.

