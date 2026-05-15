Return-Path: <stable+bounces-247808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NGjIKQ1B2rftQIAu9opvQ
	(envelope-from <stable+bounces-247808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:03:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B197551D51
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36BE330065C5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDF48123C;
	Fri, 15 May 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFX1rRLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11E3E51E2
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857321; cv=none; b=hwRtPCuTMOUH9kp3MTC4+vNlKrtQD7lt5GzGkdVOR75he1sMxigFZiZT49mLk56eEQNqgJM41qm5vPgRKPYoPhiRE3oLGHnLrjfwYsAdN3MyNaSs8ThzmDmNxxCclcX2qZlvk6LsunxvtWVvvYBMfIqP96F0rka1n3uzqvIxPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857321; c=relaxed/simple;
	bh=kdWTNbEeTAbaSV0AbO31dj391NUkPV4POiouHjptoBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3IXouWBu2Iw05hpx+u3ohDvbb3gckW7S2psOM19UDWeyMgB/BsUlK+ToUZVaS9iRehW9FHKP1caN+PsM98GA7aGPXOhvb9WHP7JrFJzpS0YCHA8AxCgBEahoZJuDOPvVZmWbmELWH9BJPFQZm9kxS7lw4QO4fY6KXziejIFVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFX1rRLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B823C2BCB0;
	Fri, 15 May 2026 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778857320;
	bh=kdWTNbEeTAbaSV0AbO31dj391NUkPV4POiouHjptoBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFX1rRLNkD8qpr2GUjlquXEwEpsuUjqZ6vJ2g1tOEGynceVwndV18mOshFusGDaj0
	 i+XKfveOtBTn7g12hZLuDZf8MTCKbVLBgcu4mAaWCxtQRdhP3a6EngwO2PgvnZEFoD
	 f9OqX2x+gwvwVJnJaKM4Qkk5BQu7LMfbOmVn0zk0=
Date: Fri, 15 May 2026 17:02:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: viorel.suman@oss.nxp.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] pwm: imx-tpm: Count the number of enabled
 channels in probe" failed to apply to 6.1-stable tree
Message-ID: <2026051535-dynasty-boxing-69a0@gregkh>
References: <2026050332-washer-legislate-ef0e@gregkh>
 <af5CI1ZrJIAoUnf5@monoceros>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af5CI1ZrJIAoUnf5@monoceros>
X-Rspamd-Queue-Id: 0B197551D51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247808-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 10:14:19PM +0200, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Sun, May 03, 2026 at 01:46:32PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3962c24f2d14e8a7f8a23f56b7ce320523947342
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050332-washer-legislate-ef0e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > 
> 
> You wrote already on 2026-05-03 about this patch that failed to apply to
> 6.6, 6.1, 5.15 and 5.10. I replied to the 6.6 one with the exact patch
> that Sasha now recreated in reply to this new 6.1 failure. I would have
> expected that the 6.6 backport is tried to be applied to 6.1 and the
> other older versions given the mainline original doesn't apply cleanly.
> 
> :-( that this resulted in duplicate work being done

I've now taken your backport for both, but we have no idea that a commit
you send for 6.6.y and says "backport for 6.6.y" should be applied to
6.1.y :)

thanks,

greg k-h


