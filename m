Return-Path: <stable+bounces-238495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDIkO0864mnA3gAAu9opvQ
	(envelope-from <stable+bounces-238495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:49:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D541BCB3
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E32C3030874
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A8139EF14;
	Fri, 17 Apr 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atu7NfMq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFB26E6F2;
	Fri, 17 Apr 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776433737; cv=none; b=KVxmbZewm73fLWgzhKr3TBFaPoRjaxDAuhnOqWw8xh77LakXvmsOf53G9ELRPoWSqK1GfUeX8+kLDxDD8w1H0SLF2SqUNueCsy4snBbz08FeMB1LOELz/4DV0+jR1FJgijkW7WCs5hxpIiMVG9uDa0N+vauL30U/WM+Jci9PiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776433737; c=relaxed/simple;
	bh=XDDn2fyLEhPpiyxgytFsKVqWoaEe/Rdk0v+FGhCSF9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSpYVawy5WjKzZHsy3Z6m0WyN369N+KCqLT/HqHmUIQXq8syNY5uYkHy7L+P0eyCZnwIG3fCIkFols3UYfa5o1y1Gz8R+R81p+6LdpZkOcOlS97jkVKAmvsNbQrumbUuc9huhC9LS4aO2iKFo0fdi3YSHD8NAGgQ/n3Udqonh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atu7NfMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ADBC19425;
	Fri, 17 Apr 2026 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776433737;
	bh=XDDn2fyLEhPpiyxgytFsKVqWoaEe/Rdk0v+FGhCSF9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Atu7NfMqfchjYEpPxZqsUt+/fus0GZD7i0BlhfDD1XB/WC+5ZUvdSh3wrwgCQHtTR
	 Hi4BbIPnd3fOWrazH0hA1lsnXQXKCZ/Z8Fsa7cUhtwC2lpWjv99w1vSGmL08nBvK0i
	 c5mQOsTWP1xNLi8hYYqjmF1PhSXJvFyvEi/XatFpPc5HcUbGFKyNBSRzU+3lIgKbX2
	 4wZXKYO3gzzQh4v4wLacY4F9mRnQTP6XusE+Ws9rUl3/pDJMTR7OQoTckH8PEObp5n
	 DKZSCl950Ys2T7VnxUomqPnM+m1WxfMIr27gb6OxjYBKlh7swp+puRSdbN/feU1MEy
	 WXdtmyqfcBFog==
From: Simon Horman <horms@kernel.org>
To: snowwlake@icloud.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org,
	framemain@outlook.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 4/4] nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
Date: Fri, 17 Apr 2026 14:48:47 +0100
Message-ID: <20260417134847.197064-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414233534.55973-5-snowwlake@icloud.com>
References: <20260414233534.55973-5-snowwlake@icloud.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,outlook.com,redhat.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-238495-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: AB7D541BCB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm

nfc_llcp_recv_dm() reads skb->data[2] (the DM reason byte) without
first verifying that skb->len is at least LLCP_HEADER_SIZE + 1.  A DM
PDU carrying only the 2-byte LLCP header from a rogue peer therefore
triggers a 1-byte OOB read.

> Fixes: d646960f7986 ("NFC: Add LLCP sockets")

Is this Fixes tag correct? Looking at the git history, the function
nfc_llcp_recv_dm() with the vulnerable skb->data[2] access was actually
introduced by commit 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode
frames"), not by d646960f7986 ("NFC: Add LLCP sockets").

Suggested: Fixes: 5c0560b7a5c6 ("NFC: Handle LLCP Disconnected Mode frames")

