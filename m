Return-Path: <stable+bounces-225456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGEBB9L6tWkI8AAAu9opvQ
	(envelope-from <stable+bounces-225456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:18:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4E28FA28
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42F223029463
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 00:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E01D61B7;
	Sun, 15 Mar 2026 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1mfvhIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E841D130E;
	Sun, 15 Mar 2026 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533897; cv=none; b=IYrm5guJOqnkn/5AgDwKBMG1Y0nuPOdBiS8wGG7ozNS3A6GtG0wJ4TwVvykI2LazxBJG8txtg6RCbN8RCPGfcUxEVDiBVFTQ42tFe5cMgAxOFpphjNsenkV/LjmEb1rOgX9SKMwr8CYtMuVnrMYxqheUFBhM2cPpyYgfOK0XVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533897; c=relaxed/simple;
	bh=3KrYYqBFao9HexZl8dVIaZI1Ujoz1XwPkmSGsgT1YxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq4wHCMMnlKSpYuEYBbRVFVmL5sSznXImHdtumZASxdWLFLQoJ0qIzoVf1S6/LtGeRMBvzgKGjLJXjdRwchUrLaSmG7RzuSR/oB7UINUV7xlrA1Ujd7l+ZZ+KWTi5mz09ANoJdUB6DZN8P09PdO4At3JRXsxpwaDQq8Fr+zlYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1mfvhIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27428C116C6;
	Sun, 15 Mar 2026 00:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773533897;
	bh=3KrYYqBFao9HexZl8dVIaZI1Ujoz1XwPkmSGsgT1YxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1mfvhIr63lebUuyx+nRSgcVy5qyzJYvVEWDc7rnoUHJrE4d7wp2F2HMTKW8ct2Gw
	 LmfuCbxL7JewypYtCy9HPjlvDT7hUzsbsZfkAr9tQk+2dVAj0Ztkl760OWSGAEaVDi
	 zqTIUQ/j/vbQPrVmmqiqVGEFwSH69MQlmKzOrDysJVK4T7a/HGBREMYEG17zD7Xipp
	 eQZEhFC2efcF5ktTFvH7wgOYWaZYv6nlpbkw8OKxxCQEkqGJPLYjdtKvZeRWjnWLr4
	 QoJKE0ttdNLOQH/VnBNNJHXhdhPIKBMqCJXAX4uIxTy9xZEjKI+M2x3hca2u60Ldo4
	 rh7f4+9g8ct+A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/damon/stat: monitor all System RAM resources
Date: Sat, 14 Mar 2026 17:18:08 -0700
Message-ID: <20260315001809.77161-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314155109.5e37efaea8ef72f169434d35@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225456-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 1CF4E28FA28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 15:51:09 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 13 Mar 2026 16:40:22 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > FYI, I found this issue from an AI code review result [1] that published on the
> > internet.  The review also added two more comments, but those seem irrelevant
> > to me, so ignoring.  I don't know who made the web site.  I only got the url
> > from a social.kernel.org post [2].  Whoever made the web site,
> 
> Sashiko is being led by Roman at Google.

Thank you for letting me know this, Anderw!

> 
> > thanks for the review.
> 
> yop, it's good.

I'm now a big fan of it.  It is really good, except the lack of the dark mode
;)  I therefore added features [1] for showing the AI reviews on the terminal to my
mailing tool (hkml).

Anyway, this is really awesome and helpful.  Thank you for developing this,
Roman and the team!

> 
> > 
> > [1] https://sashiko.dev/#/patchset/20260313044449.4038-1-sj%40kernel.org
> > [2] https://social.kernel.org/notice/B4E8DdeZY07PseemfI

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#reading-sashikodev-ai-review


Thanks,
SJ

