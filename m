Return-Path: <stable+bounces-269759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TtgUAwx0Qmo57gkAu9opvQ
	(envelope-from <stable+bounces-269759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:33:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB62E6DB3FA
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:32:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hyOkg9Oc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269759-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269759-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E05FA3070CF5
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CA404888;
	Mon, 29 Jun 2026 13:26:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3265380FDD;
	Mon, 29 Jun 2026 13:26:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739605; cv=none; b=D0h8+BkpyJQ2eX7KfmDb2ZpxbSKpASZzLjiZe5KuM6waFRkcn0nENiQeVoz8PO6Y2ND1GAKdIdsUUVpa3PKhSI9YrvmeyU/Crq4W0DJYnhqFUYKsiCTzwrYmhZvXgCeJyyNTRRIDAiT0e/1TV6zFIFRQfrj4vgiyPMDt+ieFbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739605; c=relaxed/simple;
	bh=Myjk9FpNVvgWWkpk4VdH7knsD/hljr/GXMBrJx9wqq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZBqHHQG4CJGbWt1IhWLzHaX22WyOOvpepV0ZujwyjNQNZ3VpspfvcaSDvWgdAUoYUDxCXB7MVz6JxEMInXBes0OGAMf+mRlFXUTV6P+SptuWJbLjnnF5TYOEK96VfcR3op1kvY+YYuxhy2y5XmQAro0bAzoq3BUA8dR7+UuiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyOkg9Oc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C7C1F00A3A;
	Mon, 29 Jun 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739604;
	bh=u8ULakCzLsWXbut5dk0qJu4BUbPuCQCs0oXe/SzVkos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyOkg9OcJ2pdQbr3lKDnJd3n10vcR5hkZ12R70W40Tp+M69i1hJFYPRp/7+K27rj0
	 fm+4ODdXl/T2Aw1QEy+xihsoycDNcycYmv/RcxbSY0u2Nzp+i72Vj0j2GoLeCGypb+
	 H/CJqlp78ubNiCpI9a8RPFINrH0M7Gk9YIY33+wvocGDXcQoyGZVSYlDjuVWCZ4PTG
	 tEX3XQlU+iXk72Q+i/rVNPXSVYbw4gZsXD0yBm7fKGzMwYMG4aZ/1CwW4k1RuCgBS8
	 uWbmr0B66Phk3fM/sBsFQQeBKWbpOZXSQfbuX0SXzU3Emg2kMzVYGEHYrL7Jv136gi
	 tNVWvCFiMYR5g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] samples/damon: handle damon_{start,stop}() failures
Date: Mon, 29 Jun 2026 06:26:40 -0700
Message-ID: <20260629132641.159851-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628214900.243ae17b910c18a4434036d7@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269759-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:sj@kernel.org,m:stable@vger.kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB62E6DB3FA

On Sun, 28 Jun 2026 21:49:00 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 28 Jun 2026 14:54:39 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > All DAMON sample modules are not correctly handling failures from
> > damon_start().  Among those, mtier also has an additional problem for
> > handling of damon_stop() failures.  wsse and prcl also have a problem in
> > their damon_call() failure handling.  As a result, memory leaks, next
> > DAMON operation disruptions, and use-after-free can happen.  Fix those.
> > 
> > Note that only the damon_start() failure caused issues can reliably be
> > reproduced.  Reproducing those issues require the admin permission,
> > though.
> 
> So it doesn't seem that we need to fast-track all this into 7.2-rcX?

Yes, I think it is fine as long as they can be merged into necessary stable
kernels in reasonable time.  And 7.3 also sounds reasonable to me.


Thanks,
SJ

