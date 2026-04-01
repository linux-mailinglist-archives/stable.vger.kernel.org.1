Return-Path: <stable+bounces-232854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGSGB3l+zWnqeAYAu9opvQ
	(envelope-from <stable+bounces-232854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 22:22:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E23801B4
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 22:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7347E302173A
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F06347FD7;
	Wed,  1 Apr 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTR1wdXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628E258CCC;
	Wed,  1 Apr 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074815; cv=none; b=aDdNGUxYbeJXGS9pJHLttTD1vgrhsNcDnRlFTM7QI3ZDVqdz22BWbAeeDWFDHx4/z3C+pX3z7jyfGRqyFJ7eniu5QNsKLedvxZzDNMX30eaxCsu5oO9ifbEFXEmOQkQ+oTWhL+D2W+JTdhehqTw3nRCeX+O6KZKqCqIwtyb057I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074815; c=relaxed/simple;
	bh=fxuj2SQ4zAFgYm8BZkUW2BKIyhMwt2J/siG8mDBm/IA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=c/NRVRHBiEfWIOgyzby67MYK49ct+rncbJy6oCxtWZMpM4+OxaCmwKg1NU+HvCKkAZLJmhfdkBIqI2EVQjQ3TF8LFFWysKQGO0/epHqNp+uwE95+HAEHnBIrKVJRTIFdz9MoyQq0LR3/M5A8AiXZ1d3Hj4Tj7/gnCR5aQ6cmkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTR1wdXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01873C4CEF7;
	Wed,  1 Apr 2026 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775074815;
	bh=fxuj2SQ4zAFgYm8BZkUW2BKIyhMwt2J/siG8mDBm/IA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LTR1wdXuawTnvw8nOp6Xa+rFm153aVYzl4OjjF06Cn1dbV6j2+sSAMMz6WctWeSZw
	 566U1GKU/F+CpngARrwDc4jmS5/pvcrfHmMxcg9tuYHPRZ+SDIvgqoTWSJGhffKnpW
	 RE2SYMFnoFh+tKMNgpB0gIFgnEmBkfJKzJKsF6hX0g0M7wCwmNXueo1kSVWUGbTWKG
	 j51LgIzcrI2xCq2yDzWzjOUWpYypTOrqyErp8rS6DAhIfri0CJ735ZfxTdIqtfDuRQ
	 eoJhIik8gbG8UYDnvhA2ZUoX1WY3/6Iaw1Ntjxp+MdNPWhmRzXMbi0W7ZdueTy4Smu
	 zcLJR3hJa9KSw==
Date: Wed, 01 Apr 2026 10:20:13 -1000
Message-ID: <604e3d6aea8767a245160e8c6d3b4b4c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Waiman Long <longman@redhat.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Carlos Santa <carlos.santa@intel.com>,
 Ryan Neph <ryanneph@google.com>, stable@vger.kernel.org,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list
 when unplugging multiple inactive works
In-Reply-To: <20260401010739.1053192-1-matthew.brost@intel.com>
References: <20260401010739.1053192-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lists.freedesktop.org,vger.kernel.org,intel.com,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-232854-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 994E23801B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Applied to wq/for-7.0-fixes with the comment updated as below.

Thanks.

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1852,12 +1852,11 @@
 		if (pwq_activate_first_inactive(pwq, true)) {
 			/*
-			 * pwq is unbound. Additional inactive work_items need
-			 * to reinsert the pwq into nna->pending_pwqs, which
-			 * was skipped while pwq->plugged was true. See
-			 * pwq_tryinc_nr_active() for additional details.
+			 * While plugged, queueing skips activation which
+			 * includes bumping the nr_active count and adding the
+			 * pwq to nna->pending_pwqs if the count can't be
+			 * obtained. We need to restore both for the pwq being
+			 * unplugged. The first call activates the first
+			 * inactive work item and the second, if there are more
+			 * inactive, puts the pwq on pending_pwqs.
 			 */

-- 
tejun

