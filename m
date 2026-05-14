Return-Path: <stable+bounces-247254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEh7KEoHBmrFdwIAu9opvQ
	(envelope-from <stable+bounces-247254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:32:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6A545595
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C35BD300678C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E11390987;
	Thu, 14 May 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Qs1ebn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D03321BD;
	Thu, 14 May 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779806; cv=none; b=Vy4AdofXbQbntoEZRMMjCGb6BZsh4LOvqZFmjkyP8F/JxFDWLJZP+BYjW+f8vUqELwvwhk0Q6IJWH7x0D1lKafRLOpDPHAfQleW1HxMezwhckOnsdBnn5BR1PkngWlWgZJV6JNOm0gHUScLdrfMTXGTVHrCiMUBV5OV0jzDLGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779806; c=relaxed/simple;
	bh=MFQILT0u9XWoTRgH8VpTaoh6jLLK5ospPUm4XmguTHM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VkUWt2vt0bqYqIsCNbrevd4CH7TyqFe92XM1HhgWuHk4q18fpZ6taA+9FdRgJVy+43mkExU9ohs3xuB6/6nENNI8FjO6nLgjYJySWT+JLA/Y+cX+1V16cpXJUJQo2p7OXrgIw9OEkVJjFP17fOfad01TsnXNDs6aXE4mbVnrUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Qs1ebn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D535C2BCB3;
	Thu, 14 May 2026 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778779805;
	bh=MFQILT0u9XWoTRgH8VpTaoh6jLLK5ospPUm4XmguTHM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=M7Qs1ebn4+VPixZeqQYJfApnsv5BfXHMEGMHqOA4DuUT7kpcE2HJHhnkxRySrKDFN
	 /PzVisPPWg2JF3buHkv0F59taCIC6EBMuEs/rpaJrC/45K5Dcd9gc7fVY8fLmHkNQ2
	 1RAzBHfM70or8iq+TJEIHOu4e1EVk2ils3yTkk13EYaCxE3FNSSP6EiJdjbJR5MX2J
	 eqx7Hb9eEQSVbWspOxQot7V+J6xDfueZlSm/Nuxb+l0oWX+857RfcqpDQmeU3DKX8d
	 vuoEuWMI5IFMlwOUfyp6tMJdZtucxxhZQE75H6GVhUlzCV63+xmdf508EjcPr4wk9O
	 vBC3bn+A/r6kQ==
Date: Thu, 14 May 2026 20:29:22 +0300
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org
Message-ID: <d9bcbb76-a046-4223-b106-ddd1ab106614@kernel.org>
In-Reply-To: <20260512182925.4b4b9082@kernel.org>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org> <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-5-5ee57cb2b7eb@kernel.org> <03ad4927-6bde-45c4-a90c-92ecfa0a680f@kernel.org> <20260512182611.7bfbebe5@kernel.org> <20260512182925.4b4b9082@kernel.org>
Subject: Re: [PATCH net 5/5] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d9bcbb76-a046-4223-b106-ddd1ab106614@kernel.org>
X-Rspamd-Queue-Id: ECD6A545595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247254-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Jakub,

13 May 2026 04:29:26 Jakub Kicinski <kuba@kernel.org>:

> On Tue, 12 May 2026 18:26:11 -0700 Jakub Kicinski wrote:
>> On Tue, 12 May 2026 15:02:20 +0200 Matthieu Baerts wrote:
>>> Arf, I missed that when reviewing this patch: the 'inline' keyword
>>> should be dropped here.=C2=A0
>>
>> I'll drop when applying
>
> Let me take that back, IDK why the Fixes tag points to the commit that
> fixes the issue for TCP. I don't think that commit broke MPTCP did it?

Indeed, it doesn't break MPTCP, but it fixes TCP without fixing MPTCP :-P

More seriously, this patch needs to be applied everywhere the TCP fix is.
In the v2, I can add the same Fixes tag as the fix for TCP.

> Also there's a review in netdev's patchwork for patch 2.

Thank you, I missed that one. Nothing to change there, but I can add a
note in the commit message in the v2.

Cheers,
Matt

