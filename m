Return-Path: <stable+bounces-269262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6FljHMq9PmoeLAkAu9opvQ
	(envelope-from <stable+bounces-269262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:58:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65E6CF89E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:58:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nln8U2kM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269262-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269262-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478C0310BC4D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F323AA1B5;
	Fri, 26 Jun 2026 17:55:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA103A7F6E;
	Fri, 26 Jun 2026 17:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496503; cv=none; b=OLD7akWfC8M0iXMv4SuKlss2lAHeT6EERaGmosl1R77hfBfFlAIOEPyJO7I/Yq/39JDL+/vFG3SimzryrbS2tM9tBuabnp1d+B/Q1CuQ67G3LeWKAd5ukZAvt2Nr1g5yF/a8+t+Pxi3PIJxqIUpuDpeI2K3fp1E43B5YMVxQNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496503; c=relaxed/simple;
	bh=Jg2TlGtVz0m+rZvTPiVKfKC14M/U4mgFBygVo76eHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efvo5g4HLhzuaxLlYw/6Oz8UGZx82oUobkmhLkwsrBDjzwoBecqzLxY80GPk1rGJbaEXhnND5nSuYgJRSGZ14XAiFwneikX8yKDoeBXd0HgoysElHauVcPJQSReMsEdzHg3ie9lS/DbKcmaGN+i3OJNAwMQwCb2kjcR6Qu9NqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nln8U2kM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ED01F00A3F;
	Fri, 26 Jun 2026 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496496;
	bh=4VIulwJUfa0xQa9hP/IddMMtjm75/S8X5O+aEMj+3zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nln8U2kMFfugG2XE3t1ypfc8V3inpQU5HK1aJlDDcjWJ4XNNaneZFwU/Z5Zm03/a8
	 NJhK9QX5HP2q8cXUnH8ccI0fNWiW8Xdd+n5Im7GcG73PKe6VMF6Xt3mnauJhowv4l/
	 iRAImJQFFxp+icVX3/OO9fA2VRc74lYIuxV6DZFnOHQsKAHTJho5aEmZeD5hMqKwbU
	 zKpSh3ZvcOWis51xL6waTLH8wiNnzpQMSPiwTavBJvfzbYL7Uxx2zhg0G0gud3GOXt
	 xiuU3NYOTaAjdvaLytD8rAmE9SXjrCnLeRvGF1o959RQ1zxLmq9Ri2zKXEOX9I99j7
	 KEAWrETTU2nUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.6.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:26 -0400
Message-ID: <stable-reply-item007-hugepage-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112425.1777712-2-pbonzini@redhat.com>
References: <20260626112425.1777712-2-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269262-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:imv4bel@gmail.com,m:seanjc@google.com,m:dmatlack@google.com,m:jthoughton@google.com,m:bkov@amazon.com,m:fgriffo@amazon.co.uk,m:graf@amazon.de,m:dwmw@amazon.co.uk,m:sironi@amazon.de,m:iorlov@amazon.co.uk,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,amazon.com,amazon.co.uk,amazon.de,redhat.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A65E6CF89E

> KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

