Return-Path: <stable+bounces-241428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOt2LOyz72kYEAEAu9opvQ
	(envelope-from <stable+bounces-241428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:07:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FCA479062
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCFB3059599
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69E3EDAAE;
	Mon, 27 Apr 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXSoUAk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E036074F;
	Mon, 27 Apr 2026 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316654; cv=none; b=rA7Nqcj/dBQazLsmyByR4Rg/Jmu4ihGixanpOZdUzHrgQUqI9JWZHnZBaFw2X4owDBb7lk+f+bUVcOygWragntnQ569IdnCJopBskF/r3Gu75M7CTZMqRipWII11M1/4XoLl96et9R7szIYIQHZRHNew0KKqCUleslO/odj3qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316654; c=relaxed/simple;
	bh=3rtpXS6ACooWEVBmEvbsvFwILe8jr4PG52W8R5y47Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP8HUtRu4DtWtU7J9Zd6bPMwc8ineavs8lxt1BKEQm/o3awV3+sS+34qY/8idpvLWEeTF8jXivYEhTLabt66wenin7AP7TEWWdCKHiZYO6i1gMyS0QTwmxvYjEoFVo4hd+ZW/QjlXg0e3BCBej1GnkEUtuy1pXPCS2v2/qFsv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXSoUAk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2BCC19425;
	Mon, 27 Apr 2026 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316653;
	bh=3rtpXS6ACooWEVBmEvbsvFwILe8jr4PG52W8R5y47Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXSoUAk/dit99jzpjnjoooFvOwrSAN3kpBwaWONsWBBvQfwNbjb8yrDIuq7E/Yr+h
	 4I4V630oE1GoqxK2xSzJBin84rR/FYdQi6GNoMfzJsDDDcJ8ojjr70qYo2IejlTtvD
	 1UfctVR1pK1+nDOkpfsO7IZIpB4RrmkQ2ac8+dXBNOJNlf0spUPMdHfBlVQVPmOQCl
	 43oVsYzAZxcOx+mGk1GJzhJpl1GYcSa+SNfSr8ai3UrNKgxeIOniiISH9O93G/cIKM
	 DpgfBnEM76ERDPFlTUHb4o/l5pCY0gsmWtd13AqLxw+V8f6AjDrOd86UukhLynHW24
	 7NmFvpyAlTlYA==
From: Simon Horman <horms@kernel.org>
To: jhapavitra98@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	w@1wt.eu,
	netdev@vger.kernel.org,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Mon, 27 Apr 2026 20:04:07 +0100
Message-ID: <20260427190407.1248872-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423150733.2025838-1-jhapavitra98@gmail.com>
References: <20260423150733.2025838-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18FCA479062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241428-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler

t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
a loop bound over port_msg->data[] without checking that the message buffer
contains sufficient data. A modem sending port_count=65535 in a 12-byte
buffer triggers a slab-out-of-bounds read of up to 262140 bytes.

Add a struct_size() check after extracting port_count and before the loop.
Pass msg_len to t7xx_port_enum_msg_handler() and use it to validate
the message size before accessing port_msg->data[].
Pass msg_len from both call sites: skb->len at the DPMAIF path after
skb_pull(), and the captured rt_feature->data_len at the handshake path.

> Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")

The Fixes: tag appears to reference the wrong commit. The vulnerable
function t7xx_port_enum_msg_handler() was added in commit da45d2566a1d
("net: wwan: t7xx: Add control port"), not in 39d439047f1d.

The bug being fixed is the missing validation of port_count against
message length before accessing port_msg->data[i] in the loop. This
validation was absent from the initial implementation in da45d2566a1d.

Should the Fixes: tag be:
  Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")

