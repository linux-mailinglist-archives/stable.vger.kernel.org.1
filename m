Return-Path: <stable+bounces-254195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM3mL+ioFGrJPAcAu9opvQ
	(envelope-from <stable+bounces-254195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:54:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7185CE28C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08E22301C59D
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60353290DBB;
	Mon, 25 May 2026 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up64OrAl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D403305662;
	Mon, 25 May 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738851; cv=none; b=YJJXTsv8mpA6UJ6IfRZyDzIChS6jbFYhvYpVuby44eE3yq4zF132s+7MGV60wUNT6bidhs1I21bF4TJ/KiKt73+nLOt6txzmzoXZSwVe7E1fEOXFwdXAZAUef9HTFYoOOVlmTuHQj7N+zY07zHeSzfNefyOsc4f9t2Z0+UMd+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738851; c=relaxed/simple;
	bh=2k3AE1mzYKo2VLqs1H6p6nftFTgaNfLOOKs1IM6hEno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nr+tCa2DNP+8JCujxGhkxOxz494erKQetuCxnKxhpcCENVklTwxjB/+cNooYqSmwXsxCtbhHWQ5GGWEGBXQeSDAYCk8B1BC/V4NNleIWQMP1RYwb4Aj6NlX89+gUXpTdYiDwOxUvSy2cdExJbbjvFsqXkbqDojTJgxAgybiZBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up64OrAl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6C01F000E9;
	Mon, 25 May 2026 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779738849;
	bh=6ujskBrG/gHKaz4WK20rRsEM2SWUBZg80vLNqAyMT6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Up64OrAl+FhMfoYUVcxkwebNIEz4/wqZAy0jlPxt1rS92un9WD6YL/C42+UfzwtY+
	 yHE+WURgo7TWBaj20LsatrXxhfFO1myn1FiZ1JxoYMYucrggwPkFwLR+RVAgtArqK7
	 PJzMOH/RjA76KAn834CF1rwRMbQmqpc7KL3Ghovg+LsqywMiCeYZiKzniIZC0UUWUx
	 yoITAan7xdsq5ILDTS6OYAESXLTpWly2CKlYWhlyte0GDErlggOirqiJNNDIo5Y1qE
	 p+8eVz7PW/+bJD6qpwoU7YRexQce08oDvxliQk8WnqL+aT8dxSoF91WvL9JDX+dghh
	 +bB3C4lYj8f0A==
Date: Mon, 25 May 2026 12:54:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: lazyming <minhnguyen.080505@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, w@1wt.eu, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
Message-ID: <20260525125408.2bb8783c@kernel.org>
In-Reply-To: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254195-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8E7185CE28C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 19:16:28 +0700 lazyming wrote:
> From: lazyming <minhnguyen.080505@gmail.com>

Your email address seems to indicate that your real name is not "lazy.."
Please repost with the From / Author and Signed-off-by lines containing
your real (some approximation of "legal") name. Unicode characters are
accepted.
-- 
pw-bot: cr

