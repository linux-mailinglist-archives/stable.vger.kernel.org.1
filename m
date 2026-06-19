Return-Path: <stable+bounces-267315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HTzdF0PBNGoZgQYAu9opvQ
	(envelope-from <stable+bounces-267315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:10:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC716A3C17
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:10:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bBwUE5hD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267315-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267315-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36AA730E532B
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB665330B01;
	Fri, 19 Jun 2026 04:07:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A2331A41;
	Fri, 19 Jun 2026 04:07:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842043; cv=none; b=d38TuiqyDZeEZ0Rnru8rrD/T96MWRJofB1nuaYLKJx8QyRXt0ny0Qmv8aAtymSeeQ7vdHLw4Vh0mFH6X3nLrB3EqcTpkjXsSV/QVtcCc3TKMAqMFM49GC0R7Y3SWadslZDfhjbrlKcoF0U24dfYzloPG5My4XAqNfLFQBUQGwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842043; c=relaxed/simple;
	bh=Qq6/scxRH8LN4ENqxLqr50HO3tiN0w3lM9YMfEYvpQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5rKvkFbme1xsW7N3u6yElnIvzNYG2KiAuQC4A79XgwsOcD8CJYFkvLZu8kQofIhCVrq07BOIfmYV/UAayWoBjn49j4DgfwBeqnxk9ktHukjzAcvQPn7h+2i6xBDntMNqNvUJBNfxoGB7d1kF1LNOEaM8ooEEg23UuwUmtxQ26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBwUE5hD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457E61F00A3D;
	Fri, 19 Jun 2026 04:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842042;
	bh=rdcTqmfCuKfPjCcRjSCpSo2Uk21zVEBX7IDtO8K5gAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bBwUE5hD6n7mrfLMrLGCt6t6LsbXow8OlBGRygHEIJ0KqEDDQGMqgFWXG9sHk7mVO
	 SxgiVns2luxUDKe0Ydply6g/1fBTyauycv+MtRLXK8Ti1eq1RqeafP3AkGtSrkGN+i
	 SxiUyWYsl0qG2FzXov94YnCxuGYGsvDlP7bawqa+VBygGRfNyBB2tyw+6XY1GxKwED
	 IAwhJZjRcrEprIAFhBdZLfz84Og8I0OFnFgA92ZAx/bn2bxlFRCQ3Ri5o8ArAZnq+O
	 0vJVmq3qlXwV5419W6R+QOqyzPYzIRE8hm2Rg+fygPMnhqGHsvRPs6KldDcn0bsf8Y
	 IrYFh5wRPA7wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: Re: [PATCH 6.1.y] KVM: VMX: Make vmread_error_trampoline() uncallable from C code
Date: Fri, 19 Jun 2026 00:07:04 -0400
Message-ID: <20260618-reply-item034-kvm-vmx@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617105100.22094-1-hannelotta@gmail.com>
References: <20260617105100.22094-1-hannelotta@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267315-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:kvm@vger.kernel.org,m:ubizjak@gmail.com,m:hannelotta@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FC716A3C17

>  [PATCH 6.1.y] KVM: VMX: Make vmread_error_trampoline() uncallable from
>  C code

Queued for 6.1, thanks.

--
Thanks,
Sasha

