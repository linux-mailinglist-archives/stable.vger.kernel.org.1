Return-Path: <stable+bounces-231229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ3gI0GHymn09gUAu9opvQ
	(envelope-from <stable+bounces-231229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:22:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C04E35CBDE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 583AF3031AC0
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68B3D8904;
	Mon, 30 Mar 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnzLTqSW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB403D88F4;
	Mon, 30 Mar 2026 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880186; cv=none; b=MRDX0/2usAiHul21RKnhCMZZ5wieeYjg8nGAb9Dn+7rIp0fokCF6HW3a/bh3S79sUHKC0HnDZNZKVYYmEG3C1vLOG+yDjJFKtXp6AnwfIkH1/OEXtw13Kac2wZczX7n7dsIN1IsYp2quZuyo2RVflyeZhH3ub2Ysqt6+VE6+ZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880186; c=relaxed/simple;
	bh=OZwA9LX64oU0rjcQ/xGojr0ysWNIRLqBgjf2L9V8WS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqCxzIln29ZdVRNdXNCFGHC9Dqlmp45a6mr91DZreIPzxcLyLvob8UnEoRfBP4tpLbyR3xt3Gx6FJFann/ZlGxwiYPr3F6iVbpU/2fjhy0OMurqLD/k7HjRCIVVSgrjEqlPnVgHE8KAON7yUgL9u11Heq5SN0jfaTc+Bsy7vW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnzLTqSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85151C4CEF7;
	Mon, 30 Mar 2026 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880186;
	bh=OZwA9LX64oU0rjcQ/xGojr0ysWNIRLqBgjf2L9V8WS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnzLTqSW3JI4wm0Gcq8Shu/IGh0tUhJLNhnPe/4fMS1BQvFXwLkqaFavjRkMTg+ke
	 35GfCFAZzvJVdPppri8AkN54iXVQybARLeaZU3XtOzFYGGeQcJsFcdKLCWHylHTggF
	 2o9PG2Qe+35r+OzCRD17BB6yZ4zgqp4t7+rZIv2f/1Z88jYu1xxAveqnKYu8pwJBbK
	 KrWMwPXEJ8SLXIe5Da4Wvbozat4m6eZQHT2DSKLXaVq/0AqkESQ6cylwCNQsRV8TXw
	 Qwv7cajU/bVi6RqCmse5cHQDJVFwZI7/D8410l65KmIC9kwa88S/xFl9cRRRTOgY2k
	 drY3J7QcDRXsw==
Date: Mon, 30 Mar 2026 16:16:21 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Remove unused dts_version in dtc-lexer.l
Message-ID: <20260330141621.GB1990358@ax162>
References: <20260327-dtc-drop-dts_version-v1-1-41066690aefd@kernel.org>
 <CAL_Jsq+r6DvXMoJ+qPOLJvosrgbyOVjw8nn453wUi7bXQOZNog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+r6DvXMoJ+qPOLJvosrgbyOVjw8nn453wUi7bXQOZNog@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-231229-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C04E35CBDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:19:16AM -0500, Rob Herring wrote:
> On Fri, Mar 27, 2026 at 4:39 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
> > in clang under a new subwarning, -Wunused-but-set-global, points out an
> > unused static global variable in dtc-lexer.lex.c (compiled from
> > dtc-lexer.l):
> >
> >   scripts/dtc/dtc-lexer.lex.c:641:12: warning: variable 'dts_version' set but not used [-Wunused-but-set-global]
> >     641 | static int dts_version = 1;
> >         |            ^
> >
> > This variable has been unused since commit 658f29a51e98 ("of/flattree:
> > Update dtc to current mainline."). Remove it to clear up the warning.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > This is commit 53373d1 ("dtc: Remove unused dts_version in dtc-lexer.l")
> > in upstream dtc. I sent it separately to make it easier to backport to
> > stable, along with updating the warning and hash to match the kernel's
> > version.
> > ---
> >  scripts/dtc/dtc-lexer.l | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> We don't take changes to dtc as we just sync with the upstream copy. I
> saw you already submitted this upstream, so I will do a sync to pull
> this in.

Fair enough. As I mentioned in the fold, I will need this in stable so I
figured having a separate patch would make that easier while not
impacting a future sync (since it is already there). I can just wait to
send this to stable directly until the sync lands in Linus's tree.

Cheers,
Nathan

