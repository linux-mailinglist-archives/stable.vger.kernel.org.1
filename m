Return-Path: <stable+bounces-244945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJMDKLgt/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E6F4FFAC8
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F0B3062950
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5B3876BF;
	Sat,  9 May 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY82Ii0h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8E388375
	for <stable@vger.kernel.org>; Sat,  9 May 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330851; cv=none; b=dszdQZmltbIUAlenQpqsydYl1MXTiiW19L17KBZjYTZfZ8rDHjqAQoF8olIE/BdBiwE1afR+h/fcMFsZKy++xq/zZ/xqIEwInnf5J96iSoz9Ex0hmbq6tmqdl5+sgnm2zMuMstVjMoZ7S0KrU1gK3thiHNgcqq7aKy7X/Q8VvvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330851; c=relaxed/simple;
	bh=rHCoIRBKK2iXANJUI5uUF+TFZxg8TVScwEug1kLVRAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHNK9sT4PAbjz+QxUvZ0E4ifxBM4R6LssRHLlyJ5DJ1lISK0f4z29sPNKXKndTXb69qsQR/zO1l0KyflgFqoW9keHdXm2G8muFUsH3mVqbtZXDg8zEajTijdbwJA/bgWsJVrQ6M9BlYGZ5d4dhZ2dNhkSK7RJuKEvO1HUYfkVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY82Ii0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65354C2BCF6;
	Sat,  9 May 2026 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330851;
	bh=rHCoIRBKK2iXANJUI5uUF+TFZxg8TVScwEug1kLVRAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AY82Ii0hnyLbiUq3LUSYKP2W2mx4LhvwZbWDKnPukV6DUx2eaRmjioAc37KteA4z6
	 B7j/4NizEk+uYWRDs07wGwUYWbyAvYpTab+BGHLU0wUNWNFJfycvDpRxcsibNJ55M5
	 JA9r/iqL9TYSLhfXXFvdpt2NlFE00EBRfEO+1exnhPVpNQ0tuNJWT3tQzPsstlkFak
	 MpuLnlPaqAZupdY92/1nnDJCGUO6LFKQuqTMoao6/tKrWwcmBY+nT1M1xscUH2cXR5
	 3Syq5HzPY4KHHoEDZ5+OPV4/IoZXPMqxGsyqxQ9Ma/ngMRGPI+4RE39/MZ9eqrGF1T
	 7hISkqDp7jZ/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 6.18.y] ceph: fix num_ops off-by-one when crypto allocation fails
Date: Sat,  9 May 2026 08:46:54 -0400
Message-ID: <20260509122858.9a9302c639f3.re-ceph-num-ops-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506014302.4261-2-CFSworks@gmail.com>
References: <2026050453-gesture-wrinkle-173c@gregkh> <20260506014302.4261-2-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54E6F4FFAC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244945-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ibm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.18.y] ceph: fix num_ops off-by-one when crypto allocation fails

Queued for 6.18.y, thanks.

--
Sasha

