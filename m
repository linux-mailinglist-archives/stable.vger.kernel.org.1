Return-Path: <stable+bounces-237997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPOOHpzi3mklMAAAu9opvQ
	(envelope-from <stable+bounces-237997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:58:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06D3FF68D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3435230A5D73
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 00:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035C29DB6C;
	Wed, 15 Apr 2026 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFeY94F7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0B23D7FF
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214551; cv=none; b=qdw5KL+rG5tiHZGbSSOpK6fsCFk60PQcAC+MpdHuT0QIY4gRL/3RUNkhffIawLaEgNxBDnhl+VAAVsdFhQcRrvKe2XEUdMyiJAOgCfYJrt8GNkQCptuubf/Vc5bnp8NK5IJLpkHby9gO3R3PG3iPFtWHEYktuaQFhJ7qMYPrXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214551; c=relaxed/simple;
	bh=Ws9DH4zeXfQM2TvRZ8nDJP+PhP3DPaCAEzYxuNpL5Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmD0zw8UOaI6smN8V9vcZdhL9eDN524sRY79e5pflFegnIXKbPHMVN8P6rpPvrpHMir4P94fM5BqwBmNfHJN1lI/8PpI6FoTfjHbPEdvf9k6eylRSDQcGIzxQ410Zn0wL7RorGnFzlq6ArOtPr6CqLiLuYexe/BGWgh5fpFCUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFeY94F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAA7C2BCB5;
	Wed, 15 Apr 2026 00:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776214551;
	bh=Ws9DH4zeXfQM2TvRZ8nDJP+PhP3DPaCAEzYxuNpL5Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFeY94F7hbyotqBv8B14xZgHO6t6v8Vr5ZtEqCNRooxeApjchBJpW4K6RnyZ8k/td
	 Ao/5f3OJIsLSRrtkYevoApOJFS+vMBBeV3B5PcNM4vcViJhiynBM87FW58/D4/0csl
	 8v7IUv0dcsLa8ikdUZUNDfPcLE9NFXrOZc09RINYNZRRd66p9xsU2Z1mGTDRD2mZVx
	 J4ty+PIRvl7RxtjNxZZc+nwy6peBGibmsrQHWz4xcMYiCpAB7XoycEBUi/SilYagRS
	 UAVfMj9CoYxF5G1H7YzYG7OV6xaAU/GjYhuHm5RbBd0qTqDGoloXPt591Ok6CPYpeB
	 21iY56kmnPLOg==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10 070/491] ASoC: core: Exit all links before removing their components
Date: Tue, 14 Apr 2026 20:55:49 -0400
Message-ID: <20260414205017.rc-reply-asoc@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5006a2a4e34e7fbbb89fc8969facc6b80c7d00de.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155821.667271642@linuxfoundation.org> <5006a2a4e34e7fbbb89fc8969facc6b80c7d00de.camel@decadent.org.uk>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237997-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B06D3FF68D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 00:15:56 +0200, Ben Hutchings wrote:
> snd_soc_remove_pcm_runtime() is called from remove_link() in
> soc-topology.c.  I might be misunderstanding it, but it seems to free
> the structure that snd_soc_link_exit() accesses immediately after
> snd_soc_remove_pcm_runtime() returns.

I looked into this: In soc_cleanup_card_resources() the link_exit loop
runs before soc_remove_link_components(), so by the time remove_link()
does kfree(link) the exit callback has already completed. All teardown
paths go through soc_cleanup_card_resources() so the ordering seems to
make sense.


