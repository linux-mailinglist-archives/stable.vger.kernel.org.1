Return-Path: <stable+bounces-241924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ7aA/pE8mlnpQEAu9opvQ
	(envelope-from <stable+bounces-241924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:50:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E44984CE
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7887A300AD57
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D500383C83;
	Wed, 29 Apr 2026 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5SYUFtg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F2349B15
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485042; cv=none; b=Ozhm8PIE6DAooCv+kwr8Hca+NzU7pE0Vv0UywWt2ppgAlgt+S83t+a87eoyXGdKtxiOTKP0M0iEe6poepxS7vkrXBlaJsMI9eS/nr7YDtJQ2PIq8EotOISxKczWTUKLnrlssrCtDF3+FLk25Gfys+9oRljR5uQ2YV1qeXtFJfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485042; c=relaxed/simple;
	bh=PViq9J/NzX6wIHs+vw63klec3/IuQrCe3CTrigJOQk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IslFjVPLo7G4Gw6nsdZoiAt3qUaGVU1TeVzTDC6wJ+KYxW3jknJNPO9Z4VkohEd4OQ+/rbN6Scx9YRixSIUxaCQGfr/OYMDYpOCK1tPYtPMCrklKvhW1rl6aUtA4BGQ6RrtraR1q1JVRYFBgeBwihOOI303Kjy5ZKnXCUhH9/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5SYUFtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A6C2BCC4;
	Wed, 29 Apr 2026 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777485041;
	bh=PViq9J/NzX6wIHs+vw63klec3/IuQrCe3CTrigJOQk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5SYUFtgD974Z9twX5nQ4BYXk9NJ8W61NgTs2H7cQtYgWaqQVqfwXcUegC7LTzzI9
	 wceYPZ1Ean27HLNdCUjs0q+2w6GegUvjiJlL4T2X8ZO7wwj0x198OWB84oiX16xJjT
	 3+9zEW5awyFA8ueOIAlifRNqsMxMVb3ro5M1iLem3s9sj76+/r01P+AyjXoHkiN+qE
	 03NDlakNdzrg4IJdoYRjhHjEPGT95RdFMwChBetgqAEN+r0BAbFAH9jggGw+j56Bb3
	 X9XihNDH97XRunVhRnbJ/cuVuIRIQP+2X+j3bU4Ylh1pwZ0knem+1+pPuuv0FjkG5u
	 9QXkvuf6yvv+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 6.6.y v1 0/6] SRSO handling for Zen5 CPUs
Date: Wed, 29 Apr 2026 13:50:36 -0400
Message-ID: <20260429171550.srso-zen5-6.6.y@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428214610.2138600-1-d-tatianin@yandex-team.ru>
References: <20260428214610.2138600-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED6E44984CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241924-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 12:46:04AM +0300, Daniil Tatianin wrote:
> This series backports a few SRSO handling features for Zen5 CPUs from the
> mainline kernel. The only important ones are
> "x86/bugs: KVM: Add support for SRSO_MSR_FIX" and
> "x86/bugs: Add SRSO_USER_KERNEL_NO support". The rest are added to avoid
> conflicts when applying the aforementioned patches.
>
> Changes since v0:
> - Add e3417ab75ab2 ("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions")
>   to fix a performance regression introduced by 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX")
>   (Suggested by Sean Christopherson)

Sean, are you OK with this 6.6.y backport as it stands?

--
Thanks,
Sasha

