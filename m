Return-Path: <stable+bounces-249718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKU1BqUGDWpQsQUAu9opvQ
	(envelope-from <stable+bounces-249718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:56:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54B5866B7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBD9B3074C61
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5812D0C89;
	Wed, 20 May 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FteeT4dn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB62C15AB;
	Wed, 20 May 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238470; cv=none; b=MV7MHH/W59IRICVmgUa5V2BT68OSW8mCzIM4QylIetNE+/V3av7Z1SW9Co1ovZMhYC4lZPIRnqm76Ta3M2OJhj/kLItk5jxBlRU+lTqYI4Q/8b4Fv38rOBQGf89PmqSYEU0xJozLN2o7un3L37tUnsIh9sRwGOuy8bAc22vBe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238470; c=relaxed/simple;
	bh=FBqxazzWQqaalrtGYtYtsegcmYC6KYG1STstqiWM94Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6+pY5tHU+x/Y0/jreCejpEgTQ+B5UHgtiVZM/YJUyPcG14fP4kIwSpGNkoF4z/ycOgfBolStRMBsNjcKDNsVyzyywzdc19Cbfx2+HWemxlLLj1HJQhGkW+yzS2/Rbljs80rygCCwUT3xgaw+wLJjaGtfdK9fz3ke4ClVGh/kR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FteeT4dn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF71E1F00894;
	Wed, 20 May 2026 00:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238469;
	bh=FBqxazzWQqaalrtGYtYtsegcmYC6KYG1STstqiWM94Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FteeT4dnR50bM/aMOXObonsHu3ytruZVQtxv3p3SGdENkaUHmqp5kMsa1QB7iay0c
	 ka0at6PEPOZsGJriHKjFPbqn4nzoBVbcGd2MecSiSRJHWi7/lvykxYVQY5pIw7znMJ
	 8eM0scEaFzsILpQmjIvK2WxuLqK6oICGo2x6ALdUtLVUUdbnhJGr3DLbOaOL6CwBMq
	 Oown+kN4ST895dNlTUE//Y7F+QqDfvYw5xzJcfjzPNp0RSdKewSd+AsOSNOo/nJM+u
	 KoMDdp9YnW0tiWKi4ZxQzs/j6MqLl7hZrbGhKZw1HKnyaJyZolOShGX9Q8pI7JEIjH
	 +AXJiqHwUaVEQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	ipylypiv@google.com,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Wiese <charon56@proton.me>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: stable backport request: [PATCH v2] ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands
Date: Tue, 19 May 2026 20:54:18 -0400
Message-ID: <20260519220508.reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <agyRrnU_Oyh79_d8@ryzen>
References: <-LfISXRga4ryMCYwCMNrhBwgNW6mZ9xx8AWX-Y7B0WwEyZr_8BHlTEgNarxj36MY0Yu-79B93UH7ISr1OmMrRqAbO_LYmZjUgtkE0MoxB5M=@proton.me> <agyRrnU_Oyh79_d8@ryzen>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249718-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA54B5866B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:37:02PM +0200, Niklas Cassel wrote:
> Dear stable maintainers,
>
> Could you please help with backporting commit 8ebf408e7d46 ("ata:
> libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands")
>
> to the relevant stable kernels?
>
> It gets a conflict when cherry-picking, so I have attached a version
> that can be applied without conflicts.

Queued for 7.0, 6.18 and 6.12, thanks.

--
Thanks,
Sasha

