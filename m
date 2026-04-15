Return-Path: <stable+bounces-237996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC6EIivi3mklMAAAu9opvQ
	(envelope-from <stable+bounces-237996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:56:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 182873FF675
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E57003032F58
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 00:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32B29D288;
	Wed, 15 Apr 2026 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5a8IkbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8A23D7FF
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214549; cv=none; b=sXIWM6NimEmWfJvANBkKX5lb7zPNho0O1tG26SPhkAUjX1DFzW7iI64Au64DNI6rlmAEeKPfTI6r/PhUUgY63v9kXxFxx3af6pXG8QWM6q7/B02lQ9S1m413qeSX47a0bWrdYyykze2xbYfE75xIBkDWbctzSAjp9xqGbIWF2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214549; c=relaxed/simple;
	bh=vCE0OGUnKVMtOycoevoxxXkb/0UlsnlvhF8QkLwvo2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4P1hyorj55ssZlcf3G2nJUq5ujcFasE9gld5ClD5BhKfGguRuPveXLa/i5g3y4FYMKxQDURNvODLh4CwwEYR1mb3+RjVoCF6KAbMzoNcjczADKDL4PT6bE7vNMox6EssXl5ytZpeLFFQsZGZJb3h4u/9wcq6jPuISf7YtMry6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5a8IkbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3080C19425;
	Wed, 15 Apr 2026 00:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776214549;
	bh=vCE0OGUnKVMtOycoevoxxXkb/0UlsnlvhF8QkLwvo2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5a8IkbPXf7qUKvoCbVZ3voyJlA7trPs41IoAKdLNlh1GNnSwjvEAyhF74i1gOSxc
	 OsHeJeIbv6NI4X2LcECZo5w25uxNAMfzk4n8am9qP82orxj23PkYr9vOzKMZVsxwbg
	 Rabn+GFo1Q6bkmG+SBUJMK/TuU0ng++oTEATDNjiQNGRD15fEG8L0ttasikPtcHHeM
	 e3zXU22o0oK85EVBLssNTWZgNTxC904TxI75Jb0MW1+AiCE0kRPxRZpF/UIVAxLfq/
	 L9r+Jp4lcOB2NEYqWNcDB8365Fl1ToCnW/O3+m4ZSk75PX1I4o29f3H3izbXYLUngH
	 eXto7PrUj7lqQ==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10 040/491] wifi: cw1200: Fix locking in error paths
Date: Tue, 14 Apr 2026 20:55:47 -0400
Message-ID: <20260414205017.rc-reply-cw1200@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <408661f69f263266b028713e1412ba36d457e63d.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155820.553917826@linuxfoundation.org> <408661f69f263266b028713e1412ba36d457e63d.camel@decadent.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237996-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 182873FF675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 22:48:34 +0200, Ben Hutchings wrote:
> These error paths already call cw1200_wow_resume() which unlocks
> conf_mutex.  So this is introducing and not fixing a locking bug.
> Please drop this from all stable queues and revert it upstream.

Dropped from the 5.15 and 5.10 queues, thanks.

