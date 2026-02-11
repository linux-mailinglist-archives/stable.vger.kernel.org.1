Return-Path: <stable+bounces-215860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P8OAECkjGlhrwAAu9opvQ
	(envelope-from <stable+bounces-215860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 16:46:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD37125D31
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAA83019503
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BB318B93;
	Wed, 11 Feb 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QuFUBTPF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E757319843
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824764; cv=none; b=bhDCm6hHZGn80m8DYp3mlRujT+WL7H/eZ/VPdEURKuYTZeBxPN0snFoFea3ag4kue7wuk2K/eqV1fpnb5M1Nf2vHpz0ZKws8D/pr67w5ys/CSA1JQ+eEPRyBC7o5ys6FIIPc/RlO8B3xBAW+Mahs9fbe1dUwXP3vm1E/oF05EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824764; c=relaxed/simple;
	bh=XrwKN175hff0plPZmnLVi7V45tlCeXlbQzwGtKr28VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHy2iBH6Rs4sn4OY5DF94k9vgAliq1NImHukpOlrUNtuqQwhRHGDFH1I9wvygFwPnKDg5P/yDZYUFuP9P6GYJ2imVvTxHVu9nPETiQqIm8rTzo0TEkUydwVw0jG5k8ZlaeSfKRhDyQhvNVy9dFR1REhTIwKjuWN17DmPWCyUVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QuFUBTPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A58C4CEF7;
	Wed, 11 Feb 2026 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770824763;
	bh=XrwKN175hff0plPZmnLVi7V45tlCeXlbQzwGtKr28VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuFUBTPFLATFHUIKdlVZRiJWVKKbrEXM+Zcyfw/g2NsPGtcE2p7z/ZTJDaiDONfsZ
	 Z+ynbQwe2h2BLhKabGU7JHAFJiu102QsxY0tDCZ4uJ/YyafWVLTqdy1dVD2XAotT0u
	 NfGbS+Hrb2tn64JI8ek6kAgy5UbHAlEvHvyAOiAk=
Date: Wed, 11 Feb 2026 16:45:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stable@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	niranjan.hy@ti.com, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: ops: fix snd_soc_get_volsw for sx controls
Message-ID: <2026021111-lecturer-heap-aab2@gregkh>
References: <20260211152032.1075568-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211152032.1075568-1-ckeepax@opensource.cirrus.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215860-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,ti.com,opensource.cirrus.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,cirrus.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4FD37125D31
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 03:20:32PM +0000, Charles Keepax wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> [ Upstream commit 095d621141826a2841dae85b52c784c147ea99d3 ]
> 
> SX controls are currently broken, since the clamp introduced in
> commit a0ce874cfaaa ("ASoC: ops: improve snd_soc_get_volsw") does not
> handle SX controls, for example where the min value in the clamp is
> greater than the max value in the clamp.
> 
> Add clamp parameter to prevent clamping in SX controls.
> The nature of SX controls mean that it wraps around 0, with a variable
> number of bits, therefore clamping the value becomes complicated and
> prone to error.
> 
> Fixes 35 kunit tests for soc_ops_test_access.
> 
> Fixes: a0ce874cfaaa ("ASoC: ops: improve snd_soc_get_volsw")
> 
> CC: stable@vger.kernel.org # 6.17
> Co-developed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Link: https://patch.msgid.link/20251216134938.788625-1-sbinding@opensource.cirrus.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> This is a necessary fix to an earlier change that broke SX ALSA controls
> (see fixes tag), this causes volumes to get set incorrectly on several
> production laptops. It has already been backported to 6.18 stable, however
> seems to have been missed on 6.17. I suspect it was missed due to a
> minor conflict that I have resolved here.

6.17.y is long end-of-life, there is nothing we can do there anymore,
please do not use that kernel tree at this time.  Always look at the
front page of kernel.org for the information about what branches are
still under development, and what ones are not.

thanks,

greg k-h

