Return-Path: <stable+bounces-267802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QPg8IBuTOWr2vAcAu9opvQ
	(envelope-from <stable+bounces-267802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 21:55:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C46B22B2
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 21:55:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lA9p9FO2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267802-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267802-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE87230465FA
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A4348C75;
	Mon, 22 Jun 2026 19:54:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469F33B6CC;
	Mon, 22 Jun 2026 19:54:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158068; cv=none; b=fu9DyVA2S8dKzlOoVcExWJNAeYr/bFlMTIAI97lL/WLn3wyVkSiZj4O3NQRb2B4p1/8ovTJBKck0jm4d0VPid4I2By3PAKkGvsuDjuLInKP6JghgcZgrbr9U/cqLpx+/OEeW6roZEhzRFHPHt/zfIgUHqZSmsJQIHsdcuGNhQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158068; c=relaxed/simple;
	bh=Gq54cYfZjzANFfqKQHm9HT2j6bO61C1Ey8Fce5L/oNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKzG7qKj77cxb/m1L+h8QgLr1tyEpGYexFQGEcjaANdsRTq/MOyBFBzcWOPGL79xVOh9B/bA8JELbbbUv5vPfdgs8y3jH4KjC/jwOlNusswvUxmL9ZVpnuabnAtMrGtcen0RTYQqH6zm9fHs8uKGtvKArmrB+fo1dkw3gJahiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA9p9FO2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00221F00ACA;
	Mon, 22 Jun 2026 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158067;
	bh=MugcRcePTkTCHzE3VIPFTPMg/aw+YMki7rvnvVbaIQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lA9p9FO20UnhYLOvCjvDpBvabEIjGAhOs9GewX4LuUQ50NJxRBtO9AtjrW3cNS/3H
	 UvvSkAd2vNuClb+BeOwkxyRD2UnrQ3OKmIk7hD8X3GGkz39XrdxMnGo/RCILbtEk/t
	 0/txiS28l04bhDkGz9sk06ynZx/etIF6PsJFW3cakM7STEAsQwP1qrv8itH7k7FC1U
	 WvuAJW91ZP4G+WbEGl/2w9OT/FlPX8+metLJqJBImIlC1RvxlSbrkG+MVHFTqnwSTp
	 Qt8Mc9y5ghS5fwifnMvtAa0Rf1PHokb6JUYYy2jyKPF+AW3xsf+LbVaqbJ/Xww+O7Q
	 wfQ/NNtt5rmKA==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Kohler <jon@nutanix.com>,
	"jonmkohler@gmail.com" <jonmkohler@gmail.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Chao Gao <chao.gao@intel.com>,
	Gulshan Gabel <gulshan.gabel@nutanix.com>
Subject: Re: [PATCH 6.6.y] KVM: VMX: Update SVI during runtime APICv activation
Date: Mon, 22 Jun 2026 15:54:18 -0400
Message-ID: <20260622152404.0005.kvmvmxsvi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622100324.65288-1-gulshan.gabel@nutanix.com>
References: <20260622100324.65288-1-gulshan.gabel@nutanix.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-267802-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jon@nutanix.com,m:jonmkohler@gmail.com,m:dongli.zhang@oracle.com,m:chao.gao@intel.com,m:gulshan.gabel@nutanix.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,linutronix.de,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,nutanix.com,gmail.com,oracle.com,intel.com];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 480C46B22B2

On Mon, Jun 22, 2026 at 10:03:43AM +0000, Gulshan Gabel wrote:
> [PATCH 6.6.y] KVM: VMX: Update SVI during runtime APICv activation

Queued for 6.6, thanks!

-- 
Thanks,
Sasha

