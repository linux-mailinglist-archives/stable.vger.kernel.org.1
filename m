Return-Path: <stable+bounces-262196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ut66BG3BJ2p41gIAu9opvQ
	(envelope-from <stable+bounces-262196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 09:31:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B583865D3B7
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 09:31:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gx5rz+50;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262196-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262196-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B7CE308AD77
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01EC3D565E;
	Tue,  9 Jun 2026 07:26:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7D231832;
	Tue,  9 Jun 2026 07:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989966; cv=none; b=rqngLCKj4/SA1E9Zwh3Oqn323721HNwWxFIZsI+96BtYZnMmOd20bNwJPX6ReqjTL1ttxwnO27G4hAxQ2S/7/tiuNGER5zXixF5pNbj9B/EbghqCryTXqmjN1HpOCs1AE/+nlOCNNo2BrzleSyRSFAYRgorV1+btoUxofrgrvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989966; c=relaxed/simple;
	bh=dDnylOM/XcJtWCyDBF5mdy8WoN8XOvZXlk9cMUk25dE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uBlcUhj7sBNFKH3mBBN1Z+EqD1t6UMCRGYh1HEGegPVa4lBh4eUkQ3HTppl8MAzy9AdVJ42YNZ2CI6FIhTjOjc8QPtNDO2IgUWY3k+/7TLeSp2rT68w2vIKKv1KXRaIicLo4soz3dGYhgkfoEBPqEbAZW/r2wzblwL9ZfxgH4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx5rz+50; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6097C1F00893;
	Tue,  9 Jun 2026 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989965;
	bh=CGwtmMLf4nCaY7DBB9s9IoDZ+kmcB1jT00rlHNgFpLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gx5rz+50Y5jr9CURvsI5iqg4VRqZgkhX6RcAE/Ur8IIb+wlcB/Xjv7U0jjQ6OEatz
	 tV6TWQoVWfXVkTwxYIFcyvTbgWXK1r7zP5qkVKzC6hikL80HxP27ZIgjeS/Qle7TK5
	 67jc+SqJQ2WIx1Nif3O9h2P8T2FsbgAmfLX1X/U/V627RPgp2H3sn3AXQ1Lsn2hSMu
	 QInL9OReu5qHG4I5BNtz7qiD/FBPgQO2vKvxrp0sIiPrqjuDzEe5UQsy99gWPgA5hY
	 dJygf1bMggW6O+mJb/kBUuW1baVgVlqJEKvIqr8gfJ72Dn8nvw6mgBTmtOHqmQcB0Z
	 pB7Z4vxSF1/bw==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, Yingjie Gao <gaoyingjie@uniontech.com>
Cc: djwong@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260604120317.930273-2-gaoyingjie@uniontech.com>
References: <20260604120317.930273-2-gaoyingjie@uniontech.com>
Subject: Re: [PATCH 1/1] xfs: fix exchmaps reservation limit check
Message-Id: <178098996409.72840.14573836054642073297.b4-ty@b4>
Date: Tue, 09 Jun 2026 09:26:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262196-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-xfs@vger.kernel.org,m:gaoyingjie@uniontech.com,m:djwong@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B583865D3B7

On Thu, 04 Jun 2026 20:03:17 +0800, Yingjie Gao wrote:
> xfs_exchmaps_estimate_overhead() adds the bmbt and rmapbt
> overhead to a local resblks variable, but the final UINT_MAX
> check still tests req->resblks.  That is the reservation value
> from before the overhead was added.
> 
> The computed value is stored back in req->resblks and later passed
> to xfs_trans_alloc(), whose block reservation argument is unsigned
> int.  Check the computed reservation so the existing limit applies
> to the value that will be used.
> 
> [...]

Applied to for-next, thanks!

[1/1] xfs: fix exchmaps reservation limit check
      commit: 0a5213bbff62b51c7d4999ac8c7e11ea57d00d45

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


