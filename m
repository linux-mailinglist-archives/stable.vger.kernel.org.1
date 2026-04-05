Return-Path: <stable+bounces-233327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCDKAgZA0mnOUgcAu9opvQ
	(envelope-from <stable+bounces-233327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 12:57:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4739E15E
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 12:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A903300878E
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535D33D512;
	Sun,  5 Apr 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo6Vclwo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C152EAD15
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775386596; cv=none; b=Uf4lfk/FRDmV+Fbb3ebiw9qhbfRFvcz46RNMojIlGURumbaFfip+ceY0SW4Qnj08j5WRJB+VJm52cUX/sY5PTy+EGMOoRqMi8yhAMsU3safrb6DTsw+pYcbl/CccAt8UXAFch8VfvlYXA/QXTT3dcCj+/fLKjsUZSPUzYDqxDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775386596; c=relaxed/simple;
	bh=05uSpfdjNcNfBkQHZmt7dqnOo9uvV1vc8jxq8OBzXDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUD7rlcA060iD8jJsE8S80BZIagsrOBFc4+6r25jU3l0TfzXVbkRm+iavqKhpKQBpy2w/vEKxny9xxmR3O3p4NanByRIGt+K0nClEi1AAvWl3GVNfcE9q4rwSvlpPg051H2HLvfmS1g3v/u+wJ7L8ezCAQX1lnU9XKGCJns16QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo6Vclwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DEDC116C6;
	Sun,  5 Apr 2026 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775386596;
	bh=05uSpfdjNcNfBkQHZmt7dqnOo9uvV1vc8jxq8OBzXDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eo6VclwobhhVCBCTFzbjgr0+y3OdABlc+UF1k+bwkDjZ3TLlOz1FjzxYGWKk2dK9j
	 /HImGHEXOt7JTK41tWrEp+05vn8Wc6ki8z8UXJSBNVuZDzRd9KpsW7dx5I4DhiUD54
	 JYCnmyv1I9RdK4M7dcy/alyRDYqdYeuSjrioGtpg2bypNGTRvorAPeidbyuNVNVv2i
	 ZDnsBUSkiUWtPK7eLA4oVZdcMH3gukPgXrgsxQhpIhVLAdT463My4jzwHH08z43vgI
	 eQiMi4Vwd+lLvL6taR2KW/MPjzcfpzRK6FdSfJLX73PlROKRorq4Uxcoy6WM1UMQLj
	 CXhHsAb6vIVlQ==
Date: Sun, 5 Apr 2026 06:56:34 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: stable-queue: missing files
Message-ID: <adI_4l0MPqTH8thg@laps>
References: <ae558319-0e42-4efa-a071-158ab3fbb1b2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae558319-0e42-4efa-a071-158ab3fbb1b2@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-233327-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7C4739E15E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 11:18:18AM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>Thank you for having queued a bunch of new patches recently, but
>your last commit only modified the "series" files without adding any
>new files, see:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=a56bded6cb98e350b628c2cd1a2e82937871132f
>
>Do you mind adding these new files, please?

Yup, my scripts barfed on some noise in the kernel dir. I've reverted that for
now and will re-do that batch later today. Thanks for the report!

>(Reported by the MPTCP CI validating stable patches.)
>
>Happy Easter!

Happy Easter!

-- 
Thanks,
Sasha

