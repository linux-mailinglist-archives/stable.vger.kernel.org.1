Return-Path: <stable+bounces-240208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFnvBWis52kM/AEAu9opvQ
	(envelope-from <stable+bounces-240208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:57:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D7143DA8F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80A133054300
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336237FF4C;
	Tue, 21 Apr 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="av7pZ+jG"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380D37B3F9;
	Tue, 21 Apr 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790533; cv=none; b=GtgNAAnL+sPavvQM0hnXr+e5pxRifyUEE9M1PYB0l2OYyidYRDlpc/krt3XHPP9fKPhp3ivZRRd88lrie/5Ho04U1h5dtaygTS+cdFgcOA//215XZTIAY1EvsUbJ8L5Mi7+RgAECcBdq6Qz7C4iOL77ikHXMflozIx0mCBgc2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790533; c=relaxed/simple;
	bh=gjuZluvpw+zBAD56+gFLtA8+P/7zqIHPwb0KXpkleZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvcIKnJESEr8/J4cCsRrOJpyLNPiM7c/2SAKfGyRO2U/1ZqvSng2eqnyjQJP77ouixRibw2/bMKwysJ3kqwkM5s+FEoAMnvBTCfLl8EKo5VPMaBl6pdOCuEJrjVg8HnFk/SrwQvcVYu8SsxaeFIfJB3rbSnKd4oCRDxxjNz3kP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=av7pZ+jG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gBn5+LLN+vxfLalK657BQGf9x912QjniYBsJjgYBqMw=; b=av7pZ+jGGZW4c5eDeDayGhMklv
	jRzQZDVZh+ZiDZCk1QCXewEoZyAnMl4g8EZoOta92RJ/K3NK87RLF0QJ0IjUY8us8Bis0dklXFWWP
	Ao09BF5VaEhWkwydYYgfM36CZ+O70mO2DawrZ6PlKM7NVae2NdusgDoVdWLa4HUSstpG7UYMKr2qZ
	57R1Ruod3zIB+wyNkrRn2l7wNVcTk/SWDyKb31u54FlycnWLvMLN6rnmPaDr+GeNer9M6tkdCMghv
	2K9NrAZpOqmUFu6wYDpqh2HLfiA6Ytmi5o2jjL/osdAHi/L9jQS1Izr13S5zZyoXsIn82YRGmF9yW
	4phKylMg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wFENc-000zuc-0Q;
	Tue, 21 Apr 2026 16:55:20 +0000
Date: Tue, 21 Apr 2026 09:55:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthew Wood <thepacketgeek@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] netconsole: avoid out-of-bounds access on empty
 string in trim_newline()
Message-ID: <aeerktYmyrYtv6Sw@gmail.com>
References: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
 <20260421162219.GF651125@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421162219.GF651125@horms.kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240208-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 68D7143DA8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 05:22:19PM +0100, Simon Horman wrote:
> On Mon, Apr 20, 2026 at 03:18:36AM -0700, Breno Leitao wrote:
> > trim_newline() unconditionally dereferences s[len - 1] after computing
> > len = strnlen(s, maxlen). When the string is empty, len is 0 and the
> > expression underflows to s[(size_t)-1], reading (and potentially
> > writing) one byte before the buffer.
> > 
> > The two callers feed trim_newline() with the result of strscpy() from
> > configfs store callbacks (dev_name_store, userdatum_value_store).
> > configfs guarantees count >= 1 reaches the callback, but the byte
> > itself can be NUL: a userspace write(fd, "\0", 1) leaves the
> > destination empty after strscpy() and triggers the underflow. The OOB
> > write only fires if the adjacent byte happens to be '\n', so this is
> > not a security issue, but the access is undefined behaviour either way.
> > 
> > This pattern is commonly flagged by LLM-based code reviewers. While it
> > is not a security fix, the underlying access is undefined behaviour and
> > the change is small and self-contained, so it is a reasonable candidate
> > for the stable trees.
> > 
> > Guard the dereference on a non-zero length.
> > 
> > Fixes: ae001dc67907 ("net: netconsole: move newline trimming to function")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Sashiko has provided some feedback on this patch.
> I do not believe that should hold up progress of this patch.
> But I'd appreciate it if you could look over that feedback
> and see if any follow-up is warranted.

Thanks for the review, I've had a quick look, and it is complaining
about problems are not regressions, but some other issues in the code,
which I will need to check more carefully tomorrow.

https://sashiko.dev/#/patchset/20260420-netcons_trim_newline-v1-1-dc35889aeedf%40debian.org

Thanks,
--breno

