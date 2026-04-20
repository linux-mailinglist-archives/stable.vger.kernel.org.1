Return-Path: <stable+bounces-238872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QONaMb8t5mliswEAu9opvQ
	(envelope-from <stable+bounces-238872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B7A42C35D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F95730D9AEB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9773A3E7C;
	Mon, 20 Apr 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smf2Wske"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEF3AA50B;
	Mon, 20 Apr 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691285; cv=none; b=mOQ9S0lyUUevMCzd2k5fXrFn5Mogpp6+Mrc3OCaNnW5Av97Z6VYwx9FHQNxV4BCDJlnCXQMlEXN+q9auh74OhG6sbJCCKeaKpm2RqLqiLmpNVahFkI+DJA1+mQGpKSG1i84xCrzb0LVFmra4ezXicYfO6/nxe3IVjELDTdtr8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691285; c=relaxed/simple;
	bh=irXKbDxR4R/RMQ/RUVRgmZ3YZbGAdzFMXqwKXU6V2qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq0hQ4Bwrtu+2sMQyeY62BvFcEAyGevsZf0+44a7XIdIxHLFEamvdY/B+005nvYTPMuYbchtiWwyd5RviC3XoSaUvs/eAy2vLA+JqiLbSDj3ZgcFlD90HLGhUZFjzZsefp2UuYp/1gA9oFd7rZQ3sip2Vi8DSODP276jlFyNT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smf2Wske; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E6FC2BCB7;
	Mon, 20 Apr 2026 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691285;
	bh=irXKbDxR4R/RMQ/RUVRgmZ3YZbGAdzFMXqwKXU6V2qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smf2WskeroHlzBQKKrIbCMEeVafgAVANKuPMUPxCEglnLaweCuTLHVcU/d1/3IGLT
	 aLUPh4Piy7x1RJNvTLNtgl9TsrY80Cls4R1/s9IwsWk08vm9QHbGna+3WRMiUKFLCI
	 Luvf+J7Mi8KLO6yC7KIsHMlNRRAAHjZhYA/mHrTGlHt0tOuFcMfdZEz9wFE65TNwTw
	 eXEkI65khwGXjJ6Jwj/2ExoMPmE3BXroSpwd7eWwfcDuGXmV214ERcb78N05QGOsVf
	 6QnK2MZvUkzDXFXYYdLkYItIQHjckzja05Jc9zHLVQk+fImYLrdmP0xE26YHIm5lJy
	 0NceNGQ4/obXQ==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.6] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
Date: Mon, 20 Apr 2026 09:21:06 -0400
Message-ID: <20260420-stable-reply-kvm-nvmx-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202346.3026288-1-seanjc@google.com>
References: <20260415202346.3026288-1-seanjc@google.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238872-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51B7A42C35D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026, Sean Christopherson wrote:
> Backport of 321ef62b0c5f ("KVM: nVMX: Fold requested virtual interrupt
> check into has_nested_events()") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha

