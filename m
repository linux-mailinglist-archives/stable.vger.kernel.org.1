Return-Path: <stable+bounces-223168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB3mOL7yqGnDzQAAu9opvQ
	(envelope-from <stable+bounces-223168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 04:04:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B320A698
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 04:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C132301877C
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0E2741A0;
	Thu,  5 Mar 2026 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsY/hhyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC518D658;
	Thu,  5 Mar 2026 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679741; cv=none; b=Y3yMdFIC4EtHx3/VqyrhwlX4c3yLw/2hd7IOubZ66H4Hg1JdwkB6vtJ+Y51SxNp21UnmGIU1qq46mtG0XOy2C2NmPP2CrRI44+c+LN2AUEC8oU6qCSv+ny3go0Q04TxjKhxsqX1O4eo+CMvw3xvQQbudrZJGZ6KMz4ySUpbRdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679741; c=relaxed/simple;
	bh=o5FqVSlrRVvh1J+/KTcKPlXpOZjvXysAtEMwprpmQCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbEkmCRAx5kqw3CfXlqD4/vCdapE5bnSXKVb5a0UkOB2c/EELTxirDyyYPc0U8bdI81RBRKnRLqrhAu11qFS2G2Zu/aKdFNqORAmzvVBkqrHo6IAuuPpRrZJfKKbTutFrxFk/X/AiegI4/8fLSl0tvIBSNL8ElNtacmuQc9ytRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsY/hhyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3C5C4CEF7;
	Thu,  5 Mar 2026 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679740;
	bh=o5FqVSlrRVvh1J+/KTcKPlXpOZjvXysAtEMwprpmQCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsY/hhyN3KGVPQmTd5Xbi6KnKVUuNj1hMU+Q9b9188HUlePzkX1fv83YS5Fc7LWbI
	 izizEAm7dvaScUCcMCd2vdOGLHmrVPp5wMkOUJ+MfBQSy+8iyxpmv8noHMIy8ZZEHq
	 aQKSjaIrt+2STqWmFxkudk88xAGsK8jGTuSxpylOzCqNJTvQ+fLhZOrbKnuT6E0EU0
	 RONF1NBiEXSdAPNm8bApxV3xP5/p/KJqA2K7KsqgtTaF0EYX+QKiGIWj9NOrxXyv2j
	 RGD05MaaaEPk+kgG/tn9e8boV1sW1b0CX2cGvx5e/0ECY/QYnBM+d7yTOESUHtAAwR
	 mglRO6qpAYJpA==
Date: Wed, 4 Mar 2026 19:02:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Frank Lorenz
 <lorenz-frank@web.de>
Subject: Re: [PATCH net 0/5] mptcp: misc fixes for v7.0-rc2
Message-ID: <20260304190219.7aadbab7@kernel.org>
In-Reply-To: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
References: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BC9B320A698
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,web.de];
	TAGGED_FROM(0.00)[bounces-223168-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 11:56:01 +0100 Matthieu Baerts (NGI0) wrote:
> Subject: [PATCH net 0/5] mptcp: misc fixes for v7.0-rc2

rc3 ;)

