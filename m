Return-Path: <stable+bounces-233042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEQDBB6LzmlMoQYAu9opvQ
	(envelope-from <stable+bounces-233042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:28:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6512538B434
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 621C030557FD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8434DCE6;
	Thu,  2 Apr 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvw5F5tP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17B345CAE;
	Thu,  2 Apr 2026 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143637; cv=none; b=FBTgBDIDk7v4apQQGZK6/2VOnGiflkboUU2l5faiC79vs+oQEjVNpfAoKal7ceY5QSjygz6gGpJhiTXjF1hxPzmL+a3PwYviK2k58os3QXBudCrht7X0GX5r4DsWiOuTl5u4A4x8OX0CHWp8RfaGeD1wzPFPzhE6xs0fYt2mNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143637; c=relaxed/simple;
	bh=wYa71MaduBNZb0rWMPKbI5WgvqyTuGbCnrO9JdEsbek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO5Em/iBrYHi14+r8N5X3UTxw4c38jfHK7vdV8mCz1sQEJ2exUlOzpbdneBHQ5LV/7o3sCPGLtWTt42GwWMddNBS62GpBJKENLprycTDAvGmmvuCBmIhWPNLx0vVRXjbhqdPkYZLa7FMA3qfi5kb3hIl5zi4ibG5V2u6PZaiMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvw5F5tP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D96C116C6;
	Thu,  2 Apr 2026 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143637;
	bh=wYa71MaduBNZb0rWMPKbI5WgvqyTuGbCnrO9JdEsbek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xvw5F5tP1fw4iN14lQQ2Nt3VdLPMhT6KyQZLrvk3kESsKR2+6uixcAKkA6gINcgVA
	 stW1h0g6/KM//E0BZS8FyBKPSpsOhmL7ztuNbB4G3wl5MZWDyXh3NDQbIHEuzvHK3p
	 Lfr/M8R4dLbBs9y1InjELI/TgB1QoNoqlOdbK92C1zTRdWV1V0cSmYVCrovjmF0c9x
	 F6byvPURDYE1PwpUspAynEkzjhRZIc+bmolhvmolE0Mcw4juHtc74ff31w1jDxVQNp
	 B47r+5ecFAVTyAlDX51q1d4gDa2zP08Mby8Dv1UeYjnGPJvGswHS55yX40YD0WsCZi
	 kYoZ9QpDp2euA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Thu,  2 Apr 2026 08:27:15 -0700
Message-ID: <20260402152716.75168-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402133952.73301-1-sj@kernel.org>
References: 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233042-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6512538B434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 06:39:51 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR: sashiko didn't find a real issue here.  I will post non-RFC patch soon.

Posted it: https://lore.kernel.org/20260402134418.74121-1-sj@kernel.org

[...]
> 
> Forwarding Sashiko review in a usual reply format, with my inline comment for
> doing discussions via mails.
> 
> > # review url: https://sashiko.dev/#/patchset/20260402045928.71170-1-sj@kernel.org
> > # start of sashiko.dev inline review
> > commit 8adb3c95d68d8448c8f57865d9874a5277cc1540
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
> > 
> > This commit attempts to fix a memory leak of the damon_ctx object when
> > damon_call() fails, by deferring deallocation to a subsequent start call
> > to avoid a use-after-free with the terminating kdamond thread.
> > 
> > Link: https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > > --- a/mm/damon/stat.c
> > > +++ b/mm/damon/stat.c
> > > @@ -245,6 +245,12 @@ static int damon_stat_start(void)
> > >  {
> > >  	int err;
> > >  
> > > +	if (damon_stat_context) {
> > > +		if (damon_is_running(damon_stat_context))
> > > +			return -EAGAIN;
> > 
> > If the user retries while the background thread is still terminating, this
> > will return -EAGAIN. Does this break standard sysfs boolean expectations,
> > forcing userspace scripts to implement arbitrary retry loops?
> 
> I don't think that's a problem.
> 
> > 
> > Also, if the user never writes "Y" to the "enabled" sysfs parameter again,
> > does the memory remain permanently leaked?
> 
> In a sense someone can argue so.  Someone else may also argue it as "cached".
> Anyway the total amount of "leaked" or "cached" memory is just single damon_ctx
> object.  No problem in my opinion.

Because the reference is still there, I think it cannot technically be called
"leaked".


Thanks,
SJ

[...]

