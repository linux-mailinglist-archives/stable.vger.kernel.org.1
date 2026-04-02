Return-Path: <stable+bounces-232919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHDDLcoGzmnpkQYAu9opvQ
	(envelope-from <stable+bounces-232919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 08:03:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 617FE384422
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A54DC30E6C46
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDC37C917;
	Thu,  2 Apr 2026 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AiiyRIoP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099F359A66;
	Thu,  2 Apr 2026 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109700; cv=none; b=QRDj41eg4qQYTbMhrvlHZid9zyH1IeevTv/J+YuCQHocH947OCOSX35CpQuzTRUT/jQiTdRbuNXlr/UEmZKdPvtuLjfYKGnwxZlnTF65aX0c0OEvbDNtZ2gewtbaRps2cf3tDbzwyLHe6ZN7Wq+ZrtHwlGibVw4xZMgI9R5Zh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109700; c=relaxed/simple;
	bh=9iKDwLBnLpVlDY+q2+q2E8iMIhFsJRxsw6x7j9KzIA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4fR/lGN/Pf70Ut92JlV6abcBzXLf3fzHSzWLvnMrJHdVvEqGRaEGynBzeBZCtpD+998dEj6lHehKm/ksy0g3Jn36sz9VfBSdEsvhUnIHNl2wkxFCWGT1TA6oyy/YF/dit3Uug8i/QFVjJfZroyI1I+q1nm/W3In2Lp78Y7f4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AiiyRIoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F304BC19423;
	Thu,  2 Apr 2026 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775109699;
	bh=9iKDwLBnLpVlDY+q2+q2E8iMIhFsJRxsw6x7j9KzIA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiiyRIoPbDvNWYLmSUA/tu/cuVxbhueWnCt+Wt1ld4ZVihIQJWnlpnMysZ3EysOq4
	 qMrQBv47HmwwoBJnExjEgDxqjVB32+xuvysboYhTQm4nCL10UH4sQfUSOpPGYbJyyg
	 KD8jBqHrjNtxA8l+Pr8bKqywdB00h0Xh7zKAq1EI=
Date: Thu, 2 Apr 2026 08:01:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	georgia.garcia@canonical.com, cengiz.can@canonical.com,
	sashal@kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH v6.1] apparmor: fix unprivileged local user can do
 privileged policy management
Message-ID: <2026040249-fable-sasquatch-4864@gregkh>
References: <20260402054700.2798707-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402054700.2798707-1-keerthana.kalyanasundaram@broadcom.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232919-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:email]
X-Rspamd-Queue-Id: 617FE384422
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 05:47:00AM +0000, Keerthana K wrote:
> From: John Johansen <john.johansen@canonical.com>
> 
> commit 6601e13e82841879406bf9f369032656f441a425 upstream.

<snip>

Does your group/company/whatever actually use apparmor?  If so, this
isn't the only commit that needs to be backported.  I'm waiting on a
"correct" set of 6.1.y patches from John before applying all of them to
6.1.y and then I can take the patch series that he gave me for 5.10.y
and 5.15.y and will queue them up.

So thanks for this backport, but it's not going to help resolve all of
the recent fixes that went in as part of this series by just applying
one of them.

thanks,

greg k-h

