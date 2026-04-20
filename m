Return-Path: <stable+bounces-238871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFr0HI4t5mliswEAu9opvQ
	(envelope-from <stable+bounces-238871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:43:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B5B42C2ED
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FC80309D8E2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169E43AA4F6;
	Mon, 20 Apr 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAu0hTTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C63A380B;
	Mon, 20 Apr 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691284; cv=none; b=OwWPUV2nWj16oWT89Z+vcBj2aHpiS/yThgkcD+Z1C9/qAhBO5raJYgkNTMx/iP0SesHQbJafsSa9VUONMfAoH0Vsc2T5c1mbGEa+A2lTyxUSnwFkd6Gx8j0D4eItN5tmJRtnv5z5uiixWOmpg7vfWYMwGPjMlN0s/jAG0wjlB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691284; c=relaxed/simple;
	bh=cJAqQnfgPXa28vqoxI/T0p+NIPE7QoumqsMgAEtT2cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFjoXVARHflfaSh0XT8l0AUpT5oJsTS2PYUq8phTwUQ7OX6VDcPVlbKzOxYntRiyQpexQyMNTGEzyRiYsEEr1aUfK3A+Ety8pfxzf6zjlxE5+qTJ8v2XRuhc9QfHcOGqBWB7XTT4pE05tGXjlOZFN+p3JvyMiHV9g+YWqYq685Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAu0hTTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11249C2BCB4;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691284;
	bh=cJAqQnfgPXa28vqoxI/T0p+NIPE7QoumqsMgAEtT2cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAu0hTTsSWm9a96ekDPLeqXY7Iw2/rYkZ+Tx+Qd2/xcNf5nqQxJ3UqKbe3BoIXJTn
	 VFxFtQvdONvHrnbqhYjv/GetWNaolVdcgtpjsS3kR46zAa2sORAsdSQR6HqXG6XzuK
	 uz+s1bu1TrqtQTiDNcb32x5nMRe50bwBvsxGBFWrYAa85fUsgzExTYosGd/PbB5ktO
	 Dfd2ZtGe9SkMOFQrRXR4QwgALYWCUnHCcg/aS7D3AkNlve1I/zwD8lEr9xC0dbHKqO
	 PzmL+vM4SHlPavNjiQY/z+5jYktrGTDwSoqQdx3yPkAbhWUn1k1WAEcWMEnqB/c+Uf
	 mwe1MdQE3KY+w==
From: Sasha Levin <sashal@kernel.org>
To: XiaoHua Wang <561399680@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y/6.1.y] net: add proper RCU protection to /proc/net/ptype
Date: Mon, 20 Apr 2026 09:21:05 -0400
Message-ID: <20260420-stable-reply-net-ptype-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414121118.4227-1-561399680@139.com>
References: <20260414121118.4227-1-561399680@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238871-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64B5B42C2ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026, XiaoHua Wang wrote:
> Backport of f613e8b4afea ("net: add proper RCU protection to
> /proc/net/ptype") to 6.6.y and 6.1.y.

Queued for 6.6 and 6.1, thanks.

--
Thanks,
Sasha

