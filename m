Return-Path: <stable+bounces-217634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGPyJK1/mWndUQMAu9opvQ
	(envelope-from <stable+bounces-217634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 10:49:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFA16C8B8
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 10:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B32A3016ED8
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA32F691D;
	Sat, 21 Feb 2026 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7ZanuUs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3F194C98;
	Sat, 21 Feb 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667368; cv=none; b=Z6OzenHSXkookETDjHFJJTzyDXRMkOoQFKmQv6oaIi33cepfnlpwnH2BJuxb8YRbPv3xxdApv4TUeBkA8Ak48+EPJUMa4ngI9AJ5mENnzpDbKFJKBrRI31VDf1EmeMvg3a/v0Z2dS/xlc9wwtf/G+oizcseucFb7YMPAZPSd+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667368; c=relaxed/simple;
	bh=8uvYswvKOfNwH761bMg3GBmIj7cJN1gCDPCanL7CGjY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CamtfTJ3uJooyH92ZGKR/YEvVPYcB+y3nt8Y6Z3jzTCOMB33wLfaNKNs3B5ADGAVNzgqgYSERLYTvhetuKn25kksLxQ/SfbZWXUF+G+I29sAr2sJ2b8tUhWY8+OmYFHaYZv9fVl4fTwy+4+I5taS4whtVO1k5beJ8l1GDIkJ2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7ZanuUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F74C4CEF7;
	Sat, 21 Feb 2026 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771667368;
	bh=8uvYswvKOfNwH761bMg3GBmIj7cJN1gCDPCanL7CGjY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=F7ZanuUsrm9/JCuQu/QLWYAWrtej6c84QCoR7lhn99wjr4cDbyJZBRoiAKhQbatPy
	 GMsdks+AZ1H19+o+MqkQx5tsThk/E88SO2dT/+VQtzaSla4IePrjL7RoPo7ZwyWBq0
	 jQPthyyoDe/VJ2Wp6lANOXkQPiJrGQJCOTk6HM3VxhkWZR7O/OxgReXZryJ7QsIMWS
	 VkFq7yVzcPQezikmVCI4sNUsEf2K9D0gGYZt8BIFOxocS/Asr2qSqCE520fM/hHpUC
	 uytZu31eW0wlAQiCLWQk7C5UQYxw3z+2aGN9XNzKDzi8l07p0JWRil0xq0PZwfNORp
	 GUIap+CObZofQ==
Date: Sat, 21 Feb 2026 10:49:25 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: David Rheinsberg <david@readahead.eu>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
In-Reply-To: <20260211164025.171242-1-lee@kernel.org>
Message-ID: <31o4712s-q1rp-4pp6-880o-s50pq3p5p909@xreary.bet>
References: <20260211164025.171242-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217634-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xreary.bet:mid]
X-Rspamd-Queue-Id: 62DFA16C8B8
X-Rspamd-Action: no action

On Wed, 11 Feb 2026, Lee Jones wrote:

> Since the report ID is located within the data buffer, overwriting it
> would mean that any subsequent matching could cause a disparity in
> assumed allocated buffer size.  This in turn could trivially result in
> an out-of-bounds condition.  To mitigate this issue, let's refuse to
> overwrite a given report's data area if the ID in get_report_reply
> doesn't match.

Applied to hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs


