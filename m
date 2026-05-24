Return-Path: <stable+bounces-254009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGmRJnbqEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:09:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C11C5C248F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D0AE3003822
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E337352C52;
	Sun, 24 May 2026 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX8kruSM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CE33C1B7
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624560; cv=none; b=M4a+JsI6uKX0yPL5ToSzlDEKloisfkWDgNWtb2J52Lg4V1woWlqUtsgHx3UiBdLltA7ZTHn4lWmyZrWQ37ysdcQ1QO71/D42Ajw/+GIQVfM+JPMj3xctseK39UQYCXllLhDTF9wYj+NpnfFyD1Y6NqWat7ufRKZd6irEbMmV7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624560; c=relaxed/simple;
	bh=Ws2nOWdP7jzeCxrVnFb4+tf9hnvFaBdUKLEp0rtEFZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5wTl6tqqKtC3qh21yNTE4W+mvPiTSGVPL55Bo/CEpj5SFacpnllt4UHytjE9ndyrIIXTj8v+x8tB+QkibmWOVO+KEMI7a/SK1aObxl5JxuvswSU06cfgWPhR97Z86WHnSR1eyt5BahXgx9PDmpyemwLLk319yVQhnkIh31/0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX8kruSM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB45C1F000E9;
	Sun, 24 May 2026 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624559;
	bh=mMnYIw8MjV+d6ZBFXlZyEGs2hAJvRDoY0O1sjv3TS/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JX8kruSMv9kEsS02/imvbYzeOFdLhmHlwxztjcj1JUPEcnFBdJEXRy7NI8oZcHbB/
	 hJxawS6oBhwozvAc/Tw98k31ce7WINGs3i7ByF7AuvnyzqxkKx84vS/9QePYaqI0nn
	 n0l8tggdAFYFbhF1saRBcjUAJ/w32q/dEaHxi+0gVLhYo84YBJtGb8taFoXRSgyVs9
	 /d4y21sQMUauKXBOvZHNmhSYTbXD8PsQ0qD2sIeb9USg+vpj8LpvcgztFFZZkHTY4t
	 E5OACMCZP6MCdBfC9jAwPdFoihPeRTfV3I/XYZHzYYoDDX5CHSDwPWeB4UCbeqxg9n
	 h101f4tGwGedA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	James Lin <pinglei.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.12.y] drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED
Date: Sun, 24 May 2026 08:09:13 -0400
Message-ID: <20260524-stable-item003-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520212725.182308-1-mikhail.v.gavrilov@gmail.com>
References: <2026052010-washbowl-cube-3ce9@gregkh> <20260520212725.182308-1-mikhail.v.gavrilov@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254009-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C11C5C248F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [How]
> Wrap the dc_state_create_phantom_plane() call with the
> DC_RUN_WITH_PREEMPTION_ENABLED() macro to allow preemption during
> this memory allocation.

> +#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
> +#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
> +#endif

Thanks for the backport, but this isn't going to fix the BUG_ON on
6.12.y as-is. DC_RUN_WITH_PREEMPTION_ENABLED() only gained its real
definition in v6.16 (around the dc_fpu_preempt rework); it does not
exist on 6.12 at all. With the "!defined(...) -> identity" fallback
above, the wrap reduces to a plain call to dc_state_create_phantom_plane()
on this tree, which is exactly the pre-patch code path that hits
BUG_ON(in_interrupt()) in the vmalloc path.

So the backport as written is a no-op on 6.12.y and won't address the
DCN32 crash you're seeing. To actually fix it on 6.12.y we need the
underlying preempt-enabled-region mechanism, or a different
6.12-specific fix that allows the ~335 KiB allocation outside the
DC_FP_START()/DC_FP_END() region (for example by hoisting the
allocation, or using a smaller/preallocated buffer).

Could you put together a v2 along those lines?

-- 
Thanks,
Sasha

