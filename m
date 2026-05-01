Return-Path: <stable+bounces-242223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKlwA3f582lo9QEAu9opvQ
	(envelope-from <stable+bounces-242223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:53:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 133074A961F
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20487300AD6F
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 00:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97723F40D;
	Fri,  1 May 2026 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW/TSQN6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0601D88B4
	for <stable@vger.kernel.org>; Fri,  1 May 2026 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596782; cv=none; b=Sh238T9cvw3sS6je14g8jXLOKiFAp+J9ata+nbkITmr1eTTaChQxYjjnRzPv+55NVn0J684aHRQSYVImzWanTJSLefzrktAWjlyH9MlhUZFYv2V1jbdc//UokvH9pLRhO66DQxO5KcfWwfKkQCpEvJbC11epSAktAC1Zk3oBPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596782; c=relaxed/simple;
	bh=Kht56Lwt76c6tiGkFtnie6z/FC7OhKrJSWMFHuK4ov8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg2PKqz0F+XR50viePRnB2rzo0YxJOdou9wLwh6A3NgYgqBA4FZUew+yEb3F1TH3qZIkitVdMsSQY361OuLmT+VvSGJiyNZh1bo69VgT8Udp7YNmI/2gQIRM1TCD6MZbeqiAX3c4FiUqzdcch/BBY6tDfFEv0WNoiBzRSw2n62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW/TSQN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86767C2BCB3;
	Fri,  1 May 2026 00:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596782;
	bh=Kht56Lwt76c6tiGkFtnie6z/FC7OhKrJSWMFHuK4ov8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VW/TSQN60KOhYlOGfGWROC8/GFoFLhIlIzASQ3NhEF7U1rYXoZyS8ZOrUe63PPIyE
	 a9DBdu+fMKZbOU6frwKOn11OnZvB941RkjB46uD/b6LQzX6BQVI9stHPKbg4Wh0Er/
	 DSpLeKqN1Yy5KU+oOnMOmN50deAYAL3a3/Trqd/k3FIBlhxrSlm9Hl5gRm81Gv5qMr
	 CfEGNwRoxYPO6C+quSMrKea1cSAjqqA8pJCkPJSahuuG0+8aLa8fyzotD0kd4rdx+y
	 xKG6N79Jes5CkXSI9eVB6JP6fi+sWKXkBLeKypQxzjEgAtDLftBQyxKy1eEUTKNkS5
	 HZhFZkqm/pOow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm: call ->free_folio() directly in folio_unmap_invalidate()
Date: Thu, 30 Apr 2026 20:53:00 -0400
Message-ID: <20260430160000.item002-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429172222.1401701-1-willy@infradead.org>
References: <20260429172222.1401701-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 133074A961F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242223-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 06:22:22PM +0100, Matthew Wilcox (Oracle) wrote:
> We can only call filemap_free_folio() if we have a reference to (or hold a
> lock on) the mapping.  Otherwise, we've already removed the folio from the
> mapping so it no longer pins the mapping and the mapping can be removed,
> causing a use-after-free when accessing mapping->a_ops.
>
> Follow the same pattern as __remove_mapping() and load the free_folio
> function pointer before dropping the lock on the mapping.  That lets us
> make filemap_free_folio() static as this was the only caller outside
> filemap.c.

Thanks, queued for 6.18.y.

--
Thanks,
Sasha

