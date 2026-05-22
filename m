Return-Path: <stable+bounces-253669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGvaLdK3D2qCPAYAu9opvQ
	(envelope-from <stable+bounces-253669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:56:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158D5ADC98
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C9633007942
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F882C08DC;
	Fri, 22 May 2026 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBtC87G2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9C1E5B9A;
	Fri, 22 May 2026 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414992; cv=none; b=Vco5EYycAZT87p6hCbwvPb0sZso1A+C/7c6MrVjHzjNozMFcHKyMY01BTOwU/pDig0m0ApiCy96P3ELAJIo6tkGQ4XGasgcHqlBMl+RzotrBlrAPrikqv1Oxs3JuZhSpY2RCshCN3d1eZ6PNtrtFFzVkmfC021gxaAxF7hiZHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414992; c=relaxed/simple;
	bh=q/KiR4RR47JP9QYj152u8KjvLk7gE/qqEnOgQlIKBbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8F7/5Oht9mbf98l7jp9ujwcdw/ZKkuS7iOAyQswsNG+ruFvI08nds1p9Ma0zgfd1QPPglHbVrd7ZIBMg9vMpW54mucseJz6WmADYVpnA0srqr8qYF53Kk4K2tGs5PLrwKgO4z/e3ZaE14eFaIugtxbpuUJuPQ0doaaqrWIIIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBtC87G2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE4A1F000E9;
	Fri, 22 May 2026 01:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779414990;
	bh=6HtJuUDJtmhs8hd5ldkYZOOhfjw4YQoyAH7cd+rYzic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBtC87G2WaMgXzEHN5jJmForY/ZXvOfLrPHsC0xnWHIS+vkcsCK2kGBc0be7o/BT6
	 KPgrOyAPnZGEMVcdKIJbqgFvLWiO+hsXpqC+4QsZu8+KeAwjrnL5z8gxN+tTuyEYmR
	 9SN0WMR1/UhOrZgnadJooogMQQtuGAqsniTGVM+pq+fOXUv20pWy6KNQmc/RRzO5VE
	 MGJ2dfQuW5Kd96JA7JYW9FVU5c52e7OpHNglDk78q4fU1YnV/1CiwuueFZ7kr/z+dE
	 z/49fVJ3hY+xXcNLt9PaB+NkvQU2Q08wdhwiuy4D5Nq0a+Zonm8XFMQHZhqAxyMAes
	 kQv7QHQHFmVaA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: trace esz at first setup
Date: Thu, 21 May 2026 18:56:20 -0700
Message-ID: <20260522015621.86403-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521162834.d119e280e3f9c20cd596d197@linux-foundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253669-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:email]
X-Rspamd-Queue-Id: 5158D5ADC98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 16:28:34 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 20 May 2026 08:03:10 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON traces effective size quota from the second update, only if a
> > change has been made by the update.  Tracing only changed updates was an
> > intentional decision to avoid unnecessary same value tracing.  Always
> > skipping the first value is just an unintended mistake.
> > 
> > The mistake makes the tracepoint based investigation incomplete, because
> > the first effective size quota is never traced.  It is not a big issue
> > when the 'consist' quota tuner is used, because it keeps changing the
> > quota in the usual setup.
> > 
> > However, when the 'temporal' tuner is used, the quota value is not
> > changed before the goal achievement status is completely changed.  For
> > example, if the DAMOS scheme is started with an under-achieved goal, the
> > quota is set to the maximum value, and kept the same value until the
> > goal is achieved.  Because DAMON skips the first value, the user cannot
> > know what effective quota the current scheme is using.  Only after the
> > goal is achieved, the effective quota is changed to zero, and traced.
> > 
> > Unconditionally trace the initial quota value to fix this problem.
> > 
> > Note that the 'temporal' quota tuner was introduced by commit
> > af738a6a00c1 ("mm/damon/core: introduce
> > DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was added to 7.1-rc1.  But even
> > with the 'consist' quota tuner, the tracing is unintentionally
> > incomplete. Hence this commit marks the introduction of the trace event
> > as the broken commit.
> 
> OK, but...
> 
> > Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
> > Cc: <stable@vger.kernel.org> # 6.17.x
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> The patch is marked for backporting but it assumes the presence of
> "mm/damon/core: make charge_addr_from aware of end-address
> exclusivity", which is queued for 7.2-rc1.
> 
> We can either redo this against current -linus and fix up mm.git's
> "mm/damon/core: make charge_addr_from aware of end-address exclusivity"
> or we can queue this for 7.2-rc1 and you get to deal with fallout when
> -stable maintainers hit issues backporting this.
> 
> Preferences?

Either is ok.  Because this fix is not urgent to my perspective, I'd pick the
second option.  Let me know if you need anything from my side.


Thanks,
SJ

[...]

