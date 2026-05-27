Return-Path: <stable+bounces-254684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LdvAmNeF2qpCggAu9opvQ
	(envelope-from <stable+bounces-254684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 23:13:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538AD5EA5BF
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 23:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85CA930547C6
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126BD3C5837;
	Wed, 27 May 2026 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpaWUEad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68783B9D90;
	Wed, 27 May 2026 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916361; cv=none; b=q7Qe2UyUegzKCHSgcZPzs94K7GQxvcyYqLTrVB1Oqsk3I0B664HvUiH/M7TMTZZhsYrjA8v1v44daMQYskpmRQZLAptP8QL01WoJj2aTAgyq/Cs8cLGc0Gu8RBBJewca6rR+GohIirsdKvIr9U84P/5XQ8FqrqViF3QIPJBap5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916361; c=relaxed/simple;
	bh=nkKhyte+rjfKosy5ia1dttDPtn5N50seXDtahbT5hso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoEBgw9SOacGOtSNUIRHhpqSgFNp6pAhRTNkxkZHSoxJ31IUXSzSWV/u0IdbWBlyrL43vDZb7w9Bbe6YEPYy5Ji2QDtnHtACjzTXI+4Hj9VTPJcu3xgGrnXR9coB0V6GmkzzfzDtLACfWZlM8A9vpChCNYstT/e7hAVmM2aRSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpaWUEad; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A039E1F00A3D;
	Wed, 27 May 2026 21:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779916360;
	bh=dTSLml51aGchSpHiUx1oCupZhroeQlOU6hlvIIGsMA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpaWUEadp1CFnwzij9BhOuSC6V9eaWff9yKV+4fG9yeJujh265wsAgdK9V1eW5FtJ
	 4N8AFGkrnQ0fl8vn9HMnfv0V5cHn3c5be8bv352++6QQvyRfdOYGDRiCdHE6ZSB1CL
	 nSOnvxSWly7FL0xNQz/xx3uCs0nSYcESxsqJiPi9sb7XPqdpMKmBzPJXXiK299Uef8
	 Nj7OHZwDf7s1SJAgECcaagdXZoTSaQM0qGfiXrHZnts3PB+81Spc4ubIo4xP1uzx1J
	 PupB5KJEHYnPPCceJT6DCulft6VTcvTpG3eNGzTd4OoDZC1439vmj95Wg1VlpLJP4z
	 RBiegIQhZ9V7g==
Date: Wed, 27 May 2026 14:12:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, Eric Paris <eparis@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
Message-ID: <20260527211235.GA3191279@ax162>
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
 <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
 <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254684-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 538AD5EA5BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 03:13:06PM -0400, Paul Moore wrote:
> Do either of you mind if I squash these two patches together in the
> audit tree?  I would preserve Nathan's sign-off line and add a comment
> at the end of the commit description about the fix provided by Nathan.

Sure, I have no qualms with this being squashed with a sufficient note
that I only provided a compile fix up.

-- 
Cheers,
Nathan

