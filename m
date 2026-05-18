Return-Path: <stable+bounces-249378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMx9KOFmC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4BB572D19
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D53A5302E433
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80938A726;
	Mon, 18 May 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgiOHrJN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA42380FD4;
	Mon, 18 May 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132065; cv=none; b=M0G/BlYljzAfjdhU4p2ZU6YdPKEuepT0o59DAyDxCwfAGVP17GwGNokX62XpgfwSNU8g3una9Rno+3JaU4tzIIiYG/td6Fre6FrCyESogliIRVUZVtsxcKtbUqraMaC3yHvskx3ZCG24/ZRafID8N+1dJNqjDap06teT9/sgm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132065; c=relaxed/simple;
	bh=ciSdeKCzLdxyYARH7TYEGoLvETwf+T+4txP93ZYtwUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDzS7JUGJsraXqI23G5kLZLWjdemHWqQkYJBb/FZIFjq1zQ91wBlaBNd5+jGFseIxyiMP0H9iaSwTGyh856FIIeN/heIhg/QNBEJcITW+ymk74R1qF5+pLbxCMX9dPbQWJQajsLbXe9w/iGQ14CplOAj+a+c369IuispE3bf5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgiOHrJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44067C2BCC6;
	Mon, 18 May 2026 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132065;
	bh=ciSdeKCzLdxyYARH7TYEGoLvETwf+T+4txP93ZYtwUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgiOHrJN98Tm48F67rAlwOjs+jgjvh2FjhagoHPhZN912HRKgclE3FLdtX60xo0f8
	 762Z2RcWq5nlME4k7qq5xsh1d1TyTeNb8TfjcjlMyQQ+MfnElIdkZ38rnyQE0W/EoX
	 q6sFUyTiAbCOWtn2SrSrdAjq5yUZXXDIIVcOWxy5C4TM8y/JqLJYkptGrpgzmC4uKH
	 AzNS0WA+EFQ9cDddYrvKhq8QmTnW4qaDjJM7zEcriilFZbK4EZCunf16LuDNZqoxq+
	 9qtFPTCn/JoxW9IPw7USfgBn+8Ahfs2mGBYEg7aWe3i8RKElbZRYuiw74KUnLQ8/BG
	 oHaXqUa6L/j8Q==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	kernel@gentoo.org,
	dist-kernel@gentoo.org,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH 6.18 160/188] papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()
Date: Mon, 18 May 2026 15:20:51 -0400
Message-ID: <20260518155236.reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87cxyuq6oa.fsf@gentoo.org>
References: <87cxyuq6oa.fsf@gentoo.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249378-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B4BB572D19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026, Sam James wrote:
> FD_PREPARE doesn't exist in 6.18, it's from:
>
> commit 011703a9acd76edc7c85d80dbccb6e50dba53aad
> Author:     Christian Brauner <brauner@kernel.org>
>     file: add FD_{ADD,PREPARE}()

Thanks Sam. Backporting the FD_PREPARE/fd_publish primitives to 6.18 is
too invasive for stable, so I've reverted both papr-hvpipe commits from
pending-6.18:

  - 09c15bbbed533 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle()
    to FD_PREPARE()")
  - 6542e180fa6e1 ("pseries/papr-hvpipe: Fix race with interrupt handler")

The race fix can be reworked later without depending on FD_PREPARE if
the maintainers want it in 6.18.

--
Thanks,
Sasha

