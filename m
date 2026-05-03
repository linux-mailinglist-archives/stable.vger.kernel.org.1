Return-Path: <stable+bounces-242813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDzAGtOR92lhjAIAu9opvQ
	(envelope-from <stable+bounces-242813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 20:20:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1684B6F90
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A772B3004C09
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C563D0929;
	Sun,  3 May 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIxgHxR6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDE3D091A
	for <stable@vger.kernel.org>; Sun,  3 May 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832400; cv=none; b=n7WWfoZovZji9zus4A2nnVFVViPIcU8p3bi0Oej56Uk8cfv1YOmQyhn/ZnVLBHRkLw8VWW9/vW3k6fXtOxtAXnnygCiPuYsfyTnLhwhNS7c6WBmGwMdoQ1dGb+ngojNgjWSetSz5RbAuzZJNrn5X9aP7khU9rr6giYpYrULc97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832400; c=relaxed/simple;
	bh=aUbjKjOYsFK+CyzjlXAspk3v96xPUmoS5jPGu/6fwOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5C5q7jCjmBjKtiZ5WXEnVU9orTqEU6AG2D8X/x5NvzAlFcjQbMb9Tf+yUiJp/MiCWUEtMBobR8TiXaFd6L8PiKVU8nyiR5JoNpqtDFWR98o9JjBF7C4zj8HVTDHoK6deqsTrf3/sLCEy7Gw6YMoG7fqe85x8WWFxhilTKozVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIxgHxR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE38C2BCB4;
	Sun,  3 May 2026 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777832400;
	bh=aUbjKjOYsFK+CyzjlXAspk3v96xPUmoS5jPGu/6fwOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIxgHxR6CSd2s2TkAHK4h7aW3lTUrJUX+JMEN/zeCccsXhTau2YIS4OcOpMwv6NJv
	 L1v75VwEkiIBsmqZhAhUGMmsUK7U3s/j5DC9v4jFy4HhPBwyiTSoYl/Oeh4xzWq/cE
	 OJV9d5zeofyE8sn0KGnuI6TLFqEIEUT+YHrs/4ECA628lWcN6Snao5w8E9OwRVsXQd
	 gqlypFChmml9dUIA+tgiEnJqEvBtN4zz5HgjrcnOL/FcyjR54kK7qqyBxbAsmw6hoC
	 pPkzQvGKAMqdweE4SLJEY8f2j6lySQUhufDMupehe+3MG6TLMK1H5V78A0Lgtp8UGS
	 rANGWvjjWy+fA==
From: Sasha Levin <sashal@kernel.org>
To: Corey Minyard <corey@minyard.net>
Cc: Corey Minyard <cminyard@mvista.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y/6.6.y/6.1.y/5.15.y/5.10.y 1-2/2] ipmi:ssif: shutdown race + kthread cleanup
Date: Sun,  3 May 2026 14:19:56 -0400
Message-ID: <20260503143410.item009-ipmi-ssif-combined@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501135649.672621-1-corey@minyard.net>
References: <20260501135649.672621-1-corey@minyard.net> <20260501140658.707484-1-corey@minyard.net> <20260501141953.781781-1-corey@minyard.net> <20260501142717.840671-1-corey@minyard.net> <20260501145427.900030-1-corey@minyard.net> <20260501161407.1106914-1-corey@minyard.net> <20260501162131.1165570-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC1684B6F90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-242813-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,minyard.net:email]

Hi Corey,

I queued the 2-patch series across 6.12.y / 6.6.y / 6.1.y / 5.15.y /
5.10.y but had to drop them all again before pushing to stable-queue.

Patch 2/2 (cherry-pick of upstream 75c486cb1bca, "ipmi:ssif: Clean up
kthread on errors") has a real bug in upstream itself: in ssif_probe()'s
out: label,

	if (ssif_info->thread)
		kthread_stop(ssif_info->thread);

runs even when kthread_run() failed, in which case ssif_info->thread is
an ERR_PTR rather than NULL, so kthread_stop() ends up being called on
an error pointer. The check needs to be IS_ERR_OR_NULL(), or
ssif_info->thread needs to be reset to NULL on the kthread_run() error
path before goto out.

The same upstream bug propagates to all five LTS submissions, so I had
to drop them all rather than just the older trees. Could you send a
fixed version (an upstream follow-up that flips through the LTS trees
would be ideal)?

For 5.15 and 5.10 specifically, I'd also like to fold in your standalone
"ipmi:ssif: Fix a thread shutdown issue" follow-up
(<20260501161407.1106914-1-corey@minyard.net> for 5.15,
<20260501162131.1165570-1-corey@minyard.net> for 5.10) when you resend.
Those branches lack the kthread_stop ERESTARTSYS behaviour that 6.1+
has, and your follow-up addresses exactly that. A 3-patch series for
5.15/5.10 (plus the 2-patch series for 6.12/6.6/6.1) with the ERR_PTR
fix folded in would let me requeue the whole set in one pass.

--
Thanks,
Sasha

