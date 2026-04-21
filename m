Return-Path: <stable+bounces-240200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACrUGkuk52nX+gEAu9opvQ
	(envelope-from <stable+bounces-240200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:22:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA643D477
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECA74303D37D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00643374E7A;
	Tue, 21 Apr 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZjMlnIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B18292B44;
	Tue, 21 Apr 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788544; cv=none; b=aNRzO8+s6G7kFr1SJceLeb9CWObDnwjqpJqb4K6CmpyOMDT000yRba/iarACrleH38T5+HNzOqBLk9A+HCVX6J5cogqcwLilh+zxK3hddJCF8jbhvEZLokEz/Ae7n1njQqXQTVEJ6nTWdlPIbZ0pSaoVlH9bmAgzQsomTpD/4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788544; c=relaxed/simple;
	bh=gHsASOzXsEnqn/QnRRYJ8wPU43DiCZy7Il0YtQlOeXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRiikyK7cl0e7/XMKtvwSj2OQPbJxOkZpudCLW02PzBrVkSn7HAgZPohoCJvIAFuW1T3r5zWG6sEkolLPw8AZllHDF6FsvnodawqDfan05H9MHAbnXBifdKMTXpAh0tuMMb3aTNQ0EsxPOPpukc2kFlLkoRDAYi+aEo6bCmKXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZjMlnIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F68FC2BCB3;
	Tue, 21 Apr 2026 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776788544;
	bh=gHsASOzXsEnqn/QnRRYJ8wPU43DiCZy7Il0YtQlOeXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZjMlnIJ+uLakBqR6xQhCF0xSWL5z8DoQg7YYlYMFLjWqUNFq1uss0a4Voi1KI/Av
	 OTW6qjbjiCx/VR/qN33KfV/HJz9rnfm/rN9KsaTAEcaVkjmU7rdrONmei7C2csGCfx
	 a/cznI8IIe92qBd3SpigKuU3IlFc4cs39HHke94B6stxDcStl3vfL7lrrn617uJwJN
	 s8I76Mfjcf7x2Fp2P604SwhuK+2HHQZxMvTT9YulJQFwkx7t5gZ0pAm78urEO+Pv5u
	 uzzz7WOOujUwnyjd6gLKVbQlou9F3Ger/94ixOPDpfxs5dCrGThSnDKjG7qB5Tpbck
	 rgoPyff8ZLl7Q==
Date: Tue, 21 Apr 2026 17:22:19 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthew Wood <thepacketgeek@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netconsole: avoid out-of-bounds access on empty
 string in trim_newline()
Message-ID: <20260421162219.GF651125@horms.kernel.org>
References: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-240200-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23BA643D477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 03:18:36AM -0700, Breno Leitao wrote:
> trim_newline() unconditionally dereferences s[len - 1] after computing
> len = strnlen(s, maxlen). When the string is empty, len is 0 and the
> expression underflows to s[(size_t)-1], reading (and potentially
> writing) one byte before the buffer.
> 
> The two callers feed trim_newline() with the result of strscpy() from
> configfs store callbacks (dev_name_store, userdatum_value_store).
> configfs guarantees count >= 1 reaches the callback, but the byte
> itself can be NUL: a userspace write(fd, "\0", 1) leaves the
> destination empty after strscpy() and triggers the underflow. The OOB
> write only fires if the adjacent byte happens to be '\n', so this is
> not a security issue, but the access is undefined behaviour either way.
> 
> This pattern is commonly flagged by LLM-based code reviewers. While it
> is not a security fix, the underlying access is undefined behaviour and
> the change is small and self-contained, so it is a reasonable candidate
> for the stable trees.
> 
> Guard the dereference on a non-zero length.
> 
> Fixes: ae001dc67907 ("net: netconsole: move newline trimming to function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has provided some feedback on this patch.
I do not believe that should hold up progress of this patch.
But I'd appreciate it if you could look over that feedback
and see if any follow-up is warranted.

Thanks!

