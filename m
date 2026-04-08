Return-Path: <stable+bounces-233737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNWaBCmp1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013873B5D12
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 662FF30065FF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D883290C9;
	Wed,  8 Apr 2026 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4ZU/zQp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587532AABF
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610138; cv=none; b=fp8Il2KeBBA6enhHehwYbgEKXXixrD2SVz31ey+SkW8p2AOHRPKQeUJupUPj2OVXcqGIAluPpwl1yAymxjO1cyfxcvJqryfKgNlrXM8/pKPw0BRJHRohWuRlOpIpTGXWZybKo5rvtZANZCn4hB6z8N9cQvccq6NcRgTiQVMI9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610138; c=relaxed/simple;
	bh=IRwFVppceh4XvnwRE0u2NwkTODAqgXlr7iJDu7xs4YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG/vG4TmSRTmP7pbt19bK3tq4Ykss2ZMkis8sZg4ehPFr1btN2M2yajykcjw9l3jEvo8GQoj+5HKfKD7zFotrU0h/4fPJSV9jGJ58WTvRlLWEm3rXdmo/gqM+7znN+Y5irWvTJP7NeSk8a19hV0m0scJ0YaiPnB9luTYVDCe19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4ZU/zQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C223C116C6;
	Wed,  8 Apr 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610137;
	bh=IRwFVppceh4XvnwRE0u2NwkTODAqgXlr7iJDu7xs4YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4ZU/zQpfZpfiW7sYbC+pFlmOtJRKxsaMyfo8KM/InJoo1Q7ohDHP82oJUDlqeEbJ
	 i0rtcmWAVg2Yyw48ScC7OJZYejmiwgfHPAx5LGoOgESZvmq3UXUBub33dpFc7Z2xsG
	 GrwO30jnySZRGp1HxYjgXGvPs1eUtcxddrdzrKEY5+aCYnajjVE5JWvHM3dzK48U/W
	 3lyV14rOeZtPbEE/1oLyIl3u83rs6Y+sPI2VCXNEO82z9OQpNahfHcLz8Vay0C1S9h
	 k+pmLZpWNrhW6XjzEvtm5+rSrGsBJNyUbcWAKOnTvtZZNpauaS49XBhcQ9c8muwF3+
	 ljeiEDmXcGddw==
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: FAILED: patch "[PATCH] io_uring: protect remaining lockless ctx->rings accesses with" failed to apply to 6.19-stable tree
Date: Tue,  7 Apr 2026 21:02:16 -0400
Message-ID: <20260408010216.746289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <da5de9dc-d554-41fc-a8a0-680fa38952cb@kernel.dk>
References: <da5de9dc-d554-41fc-a8a0-680fa38952cb@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233737-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 013873B5D12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 09:55:19AM -0600, Jens Axboe wrote:
> Some code got moved, this one applies to both 6.18-stable and 6.19-stable.

Applied to both 6.19 and 6.18, thanks.

-- Sasha

