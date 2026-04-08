Return-Path: <stable+bounces-233733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG2ZFzep1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FFE3B5D21
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13DFE301A6B8
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3623264F1;
	Wed,  8 Apr 2026 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT8XCWlB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6CA32572D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610130; cv=none; b=AbeAbrsmNIlWEcn2yApBboCdVlzfLngACPCRik1wa/uH6xyW47SIwxjz9kcaZCgO53cKKNuVddo4P9T58VRvoLj/y7njT3RFD0N12UmjnLHxXIZpj0zqsp5qQ3h3gEj+d0WeWxiFiHHr6nKwoah9RRp6LwDl+rOenKn4qaGJ62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610130; c=relaxed/simple;
	bh=CfMU+/px5dBvnvnmG2en0rU5nc1KNK6Z9H4kz0S+luo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0IPPvwVBAq8TUyPwHGm5WwQuwRZXiXDAkvOLBelb5gZMjtdB7NboUN61eRsELtwQgDBUz+1EolB9PaBQz559yrtjPNIjftH+en4X80SnIR+EFOrQtpwFevr6Z0dll696XzX1G/aheEMVOO6w72XqADdr1wDZYqVZ6lw8e3ZxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT8XCWlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFEBC4AF09;
	Wed,  8 Apr 2026 01:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610129;
	bh=CfMU+/px5dBvnvnmG2en0rU5nc1KNK6Z9H4kz0S+luo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iT8XCWlBUAveMugjVFTfNPRAotrlGH2fd+BBz/YWJAM0mKdsKfNNl7UWRsc1TCt5s
	 Iwo1ZZ5H49g+ol9E+Vm3ZkdcX9xHs3EM1xxDRLJs3Nac7urOnDXEH/2nv5PUxHNlCO
	 ugGP7/ICeEWl93y3rcM/sJnFSwprWYc1x6ka9+INukdSB6/KzCDixF647ky7vVGlpj
	 dmtKeMtgTMR3FScW14qIpI/dfcq3yI0dQMnhYhDgNW739fS7cb6B5VAIfr67HHz8aZ
	 1lHCJHbkZwdxa5k1HGkvHyd33dkkhefvGuGtCS4+/hQAu1yMwhcLokGohUUsBX5ozk
	 loch9tOejvbYQ==
From: Sasha Levin <sashal@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
Date: Tue,  7 Apr 2026 21:02:08 -0400
Message-ID: <20260408010208.746177-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407033710.GA12536@macsyma-wired.lan>
References: <20260407033710.GA12536@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233733-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70FFE3B5D21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 11:37:10PM -0400, Theodore Tso wrote:
> I finally got around to doing the bisect, and found the guilty commit:
>
> # first bad commit: [b6a01b66cdaa] ext4: get rid of ppath in ext4_ext_insert_extent()

Thanks for bisecting this. I've reverted the entire ext4 ppath series
plus the four dependent commits from the 6.1 pending queue:

  - ext4: avoid infinite loops caused by residual data
  - ext4: drop extent cache when splitting extent fails
  - ext4: drop extent cache after doing PARTIAL_VALID1 zeroout
  - ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
  - ext4: subdivide EXT4_EXT_DATA_VALID1
  - ext4: get rid of ppath in ext4_split_extent_at()
  - ext4: get rid of ppath in ext4_ext_insert_extent()
  - ext4: get rid of ppath in ext4_ext_create_new_leaf()
  - ext4: get rid of ppath in ext4_find_extent()
  - ext4: make ext4_es_remove_extent() return void

> So if there's someone who is willing to the ext4 LTS 6.1 stable
> maintainer, I wonder if we should just stop trying to backport ext4
> fixes to 6.1 LTS

Noted. We'll be more careful with ext4 backports to 6.1 going forward.

-- Sasha

