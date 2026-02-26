Return-Path: <stable+bounces-219825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ+vJy1ioGk0jAQAu9opvQ
	(envelope-from <stable+bounces-219825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:09:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 336141A8437
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C64930154A7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC33E8C70;
	Thu, 26 Feb 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugcu1wgr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D63E95AA;
	Thu, 26 Feb 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118377; cv=none; b=j742ljHrzIq36I89WQi+Ts2usFX+u7D6/uqMFaxz/ELS9mJ0vgbPO2LbC5MxyRA2nSnGknWxcfTJ+uFkQnVEAsknrvdsJk/TPPyC2XZnE8H3QZDIpxpI7d0qaDgn/FyAPN1X7AAo4ujm5lMxrfqsmfbxs2YIvvuZdHlNzKrJv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118377; c=relaxed/simple;
	bh=WaAW6mjvV+7xxX1h1FY6Yya5MkFXPEc/Jp083Y94v7E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aCWMCctPruN/I/B1M9/uAnWhA/qAS6AJ3EE9MB3Vw7db5ZU73Yxpsrq4ayN495j/q9tED8YqyPrBMuwklDp9AuRIDkJt9Fffi/Zc20eSSFyLrokFBkJ1zf3dnfVL3/qfmOrSamdbJ8+5fXPyjd2JtDDlFX/WqzxcjR3zNbOBPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugcu1wgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB591C19423;
	Thu, 26 Feb 2026 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118377;
	bh=WaAW6mjvV+7xxX1h1FY6Yya5MkFXPEc/Jp083Y94v7E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Ugcu1wgr5j4IRolOnXKu6ypgOaHBVaTWpC9gGyZEzXvtWkiSrGSp03xczJyc9pMUt
	 lhRN5+jdVzU1RkZUYd6aIz3tbkvRPtumYTvp6Bot9dGTONZcmFz8vUnL5E5CP/l0+w
	 wDp3rAsOIMcIc9i5aJPE2js4foMhizfq+yecKj8i/stc4jcYCqPlz0SqBVPozofE3K
	 GRAZSUSjfK7XYaEO32ixIsCETDch0sLv5UTfRoa3suCSbNuN8R+KGCNq5owLLGBLHl
	 3P/uXi9ozGyXNiN1wGIpsG36uowlfpZ3qF9KwURb8uVrrvVc2p6xgOQ+TWxwAiyLQT
	 oSaaE8KP9mS5Q==
Date: Thu, 26 Feb 2026 16:06:14 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] hid: hid-pl: handle probe errors
In-Reply-To: <20260216134958.260648-2-oneukum@suse.com>
Message-ID: <68513r8q-449s-ps59-3821-9nrs786r9417@xreary.bet>
References: <20260216134958.260648-1-oneukum@suse.com> <20260216134958.260648-2-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219825-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xreary.bet:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 336141A8437
X-Rspamd-Action: no action

On Mon, 16 Feb 2026, Oliver Neukum wrote:

> Errors in init must be reported back or we'll
> follow a NULL pointer the first time FF is used,
> because plff_init() initializes the private member.
> 
> V2: resend full series

This one is in Linus' tree as 3756a272d2cf3 already.

-- 
Jiri Kosina
SUSE Labs


