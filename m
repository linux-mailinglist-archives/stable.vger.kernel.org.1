Return-Path: <stable+bounces-267546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RacLNbXrN2qhVgcAu9opvQ
	(envelope-from <stable+bounces-267546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:48:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 554996AAF72
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DXrJACOy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267546-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267546-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6044D301C14E
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6BC367F25;
	Sun, 21 Jun 2026 13:47:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2590184540;
	Sun, 21 Jun 2026 13:47:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049675; cv=none; b=hpj6kZvLeCqEZ5Vlvok0gK0q2qMNUFP79NrKrlqd/CsiDlO/EiX80w+BPHwBa1Wfa/G0U33CBUuiDXfig0ZkwYGvBgKPTw+eqgOZhagbqAglTXUwh+FeXMgMWAApewp2CWFTjC/58g0eY6RV910zDf/xDuuViURu3xGHyeImgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049675; c=relaxed/simple;
	bh=2bYUY4z5FOHm6jVp6AJgQDWZjpwmNfPFoX7kbxFp2Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFwa+5ejrNRs2MNGrfpUTZDrhjTMK1/Er4kkCusnLHQuSQObp+Vb11t8/oD9cHa3Tx2SOOaL4HmBKM5qLUXbzqoW39Nf8YMxvN/wTEt0AhdWVQfUIqyD36Nw1T/25P9IAkRqHBA3On+DLDEACB0X2NPDFwEo6+x8KepqpqAkIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXrJACOy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E91F000E9;
	Sun, 21 Jun 2026 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049674;
	bh=/GqOw75AVOZJedE0B+pdnEgrqK9BJ1jbeHdjPtzwYPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXrJACOy4IvzlKvzKXWZt4IYSap9i6KBIeGEp5SEp/st92saZUVXraxtoTqEZrpFD
	 S1I9kp5QxV8qzgkXGjkT8O8SCti3e1Mc/6YNrbJLxlLxHhHd4iChlCOfV3dR5H2Qic
	 Rn1sdq5PaPfYPTuuEESZ9N4nwJ/KrZDV+dwhVJZANHrKFSwp86W60/Eb3IW7IsOX0z
	 4La1TT9zMFxe1IRwRel9OjVfXtcLqKSOdJXr576rkouofcneJ6NF62ZAomHDa5bVqv
	 af2CRW9uEUhd2KIftMj4XyvkdQBtV+/s1++hJ1tD334FNElqdpzeVzHFUtDmKqkNci
	 Jy3+hymhTmFDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	gregkh@linuxfoundation.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	0wn@theori.io,
	mlevitsk@redhat.com,
	jmattson@google.com,
	Nicholas Dudar <main.kalliope@gmail.com>
Subject: Re: [PATCH v2 6.1.y 0/3] KVM: nVMX: backport virtual-APIC host NULL-deref fix
Date: Sun, 21 Jun 2026 09:47:41 -0400
Message-ID: <20260621133722.0003.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619203107.2752678-1-main.kalliope@gmail.com>
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267546-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:gregkh@linuxfoundation.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:0wn@theori.io,m:mlevitsk@redhat.com,m:jmattson@google.com,m:main.kalliope@gmail.com,m:mainkalliope@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,linuxfoundation.org,vger.kernel.org,theori.io,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 554996AAF72

> This series backports the fix for a guest-triggerable host NULL pointer
> dereference in nested-VMX virtual-APIC handling. The bug is present in
> 6.1.y and fixed in 6.6.y and later.

Queued the 3-patch series for 6.1, thanks.

-- 
Thanks,
Sasha

