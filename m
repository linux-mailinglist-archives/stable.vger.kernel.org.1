Return-Path: <stable+bounces-245364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IqeJAJyAmowtAEAu9opvQ
	(envelope-from <stable+bounces-245364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:19:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A765517D18
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73D53035AA3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5111F151C;
	Tue, 12 May 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS4wVtqD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED61347C7
	for <stable@vger.kernel.org>; Tue, 12 May 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545109; cv=none; b=kGuMD2lt9MWDRMvufMz1zic82UQnh6EnS2koxS3kNgsv80Qva7FXrt6TKagTkgstle42FgjAc+IULRohoPm/Qzjmk2iUjz9W3dblii+MysZZjVQ62I/Jix632iI1Oq5+gfHBq+s/Qi0SoVsKgGGfBuQr3qtOUstN6KeMc6nkAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545109; c=relaxed/simple;
	bh=6e6FiPH+7LWOdksE77H5mDWwUefqVHNNwpBESfdtfWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtox6tJQau0m/0ytB+mODwS62okV4lArw8hpfEtt545k9Aywu0ODDGF+Xxed8RzgA8u+juYCzIvPlNbggMO13ZupCW7Kix7LWFlh3Xc3mD9t2qUwgXMR8B2NBEmDBBBjZgyBmxc9RljX49GRSjELvpOgAqncQpmNj+zWuCcgoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS4wVtqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94105C2BCB0;
	Tue, 12 May 2026 00:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545109;
	bh=6e6FiPH+7LWOdksE77H5mDWwUefqVHNNwpBESfdtfWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fS4wVtqDfQBIOQ4fSxHeBHaEzyAYAbIbVIkjguEHwIiPk0QsQ+JfgszPPaGTowlrR
	 T+DFdAP5Tzs5uIfSCAG0SiGk2N/mcn9YcJbYJqH1D4MME+LLwW/UBPs88qTi+VymYo
	 cwn827OPM2/cVOsCCSFRH9pbZeaB+gV+0O2elZU5KErRYuoQGn0ziZZBemZ8bRj+jH
	 cK4T4TWgPLRBGO+Zk6syhTmaCnJ2tPSdBpZsRIwD8mOXSXlUBoMNtVvwPBE3QPsFy6
	 yOF3L4J6fp3ZMmeKxzIYfOvfKU84u/8rxHeKeiK0YhgdAz5xY6yDEDftVjusRKyTQ6
	 DT20cWXGgvCQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH 5.15.y v3 0/4] Fix error in IPMI SSIF shutdown
Date: Mon, 11 May 2026 20:17:55 -0400
Message-ID: <20260511220000.stable-reply-item006-515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511131100.1772190-1-corey@minyard.net>
References: <20260511131100.1772190-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A765517D18
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
	TAGGED_FROM(0.00)[bounces-245364-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 08:09:22AM -0500, Corey Minyard wrote:
> This is a backport of 75c486cb1bca ("ipmi:ssif: Clean up kthread on
> errors") and other necessary patches with it.
>
> Version 3: Include a8aebe93a493 ("ipmi:ssif: NULL thread on error")
> in the patch set.

Queued all four for 5.15, thanks.

-- 
Thanks,
Sasha

