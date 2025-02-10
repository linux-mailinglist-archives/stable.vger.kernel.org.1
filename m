Return-Path: <stable+bounces-114730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317EFA2FBE7
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA213A217A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBA81C07D9;
	Mon, 10 Feb 2025 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4ie3r4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SH1JdfDf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o4ie3r4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SH1JdfDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3626462C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222488; cv=none; b=K9v4/U1IlS50YGhJkV6WyUkSM8lWHDf7IroLgXypYc79f5s2XL8unk5w7tHl8pDjTT/W4mPErEOkQPZQDbVjCL7gV+35qmK4rxonDDi4xqutpEr1wGVJSquPL0t7IXdshZUIuUNyM9CAPace28N3+woYUr+kI6LJ1fTATlvOZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222488; c=relaxed/simple;
	bh=u+q630rGM0hq0xtK+jIq7PM3K0NWpzLV/nCimPGEOgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PrIJXN1WfY1bjeoFkmBEUFnVIvziNO4tJO/EcXWXt3luMEY9yZ/MGuN/XNBIA0BqULRtRd2M1sr36VQ/2+2yuU4UF3DlD//mP1/bu/kLPQNIm7Vrej73is0cm965/+ZCrg/QZ6deK9JZmLNgI47uTbC3PawCoY2Poz1rjFhAwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4ie3r4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SH1JdfDf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o4ie3r4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SH1JdfDf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21CF51F387;
	Mon, 10 Feb 2025 21:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739222484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPnTMULYz2QKTxsTH6MKcOChxc1uI7LSyU7ezVi0xpU=;
	b=o4ie3r4XADo3m/xdWdcfa72tBhZISpmv224m41s96SZD4LC+n22lB9HPlA+f7mrt21Ub3u
	0NrjvpC38HPXzuSKLj6n3yROUV9bFLXCX5/6dN6qtGXNs/z2C+xLUIbSLnUe3ynV+YJDCW
	qU0UapuyGj8HacaVG49z7Om1l/+wKMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739222484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPnTMULYz2QKTxsTH6MKcOChxc1uI7LSyU7ezVi0xpU=;
	b=SH1JdfDf+Hhedyb3uVW6+cWslip0WvcMzbAFGCxRcyhpdgmxwWlp3v+KBodcHuyVhQKGmo
	5FKVZlaSAPac1oDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o4ie3r4X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SH1JdfDf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739222484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPnTMULYz2QKTxsTH6MKcOChxc1uI7LSyU7ezVi0xpU=;
	b=o4ie3r4XADo3m/xdWdcfa72tBhZISpmv224m41s96SZD4LC+n22lB9HPlA+f7mrt21Ub3u
	0NrjvpC38HPXzuSKLj6n3yROUV9bFLXCX5/6dN6qtGXNs/z2C+xLUIbSLnUe3ynV+YJDCW
	qU0UapuyGj8HacaVG49z7Om1l/+wKMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739222484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPnTMULYz2QKTxsTH6MKcOChxc1uI7LSyU7ezVi0xpU=;
	b=SH1JdfDf+Hhedyb3uVW6+cWslip0WvcMzbAFGCxRcyhpdgmxwWlp3v+KBodcHuyVhQKGmo
	5FKVZlaSAPac1oDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE8EA13707;
	Mon, 10 Feb 2025 21:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KhxaBdNtqmciIgAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 10 Feb 2025 21:21:23 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Daniel Rosenberg <drosen@google.com>,  Todd Kjos <tkjos@google.com>,
  Greg KH <gregkh@linuxfoundation.org>,  stable <stable@vger.kernel.org>,
  Android Kernel Team <kernel-team@android.com>
Subject: Re: f2fs: Introduce linear search for dentries
In-Reply-To: <20250208053011.GK1130956@mit.edu> (Theodore Ts'o's message of
	"Sat, 8 Feb 2025 00:30:11 -0500")
Organization: SUSE
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
	<2025020118-flap-sandblast-6a48@gregkh>
	<CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
	<CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>
	<20250208053011.GK1130956@mit.edu>
Date: Mon, 10 Feb 2025 16:21:16 -0500
Message-ID: <87pljpxzqr.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 21CF51F387
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

"Theodore Ts'o" <tytso@mit.edu> writes:

> Now, I'm not sure how much it's important to bring back the reverted
> patch.  Yes, I know it's claimed that it fixes a "security issue", but
> in my opinion, it's pretty bullshit worry.  First, almost no one uses
> the case folded feature other than Android, and second, do you
> *really* think someone will really be trying to run git under Termux
> on their Pixel 9 Pro Fold?  I mean.... I guess; I do have Termux
> installed on my P9PF, but even I'm not crazy enough to try install
> git, emacs, gcc, etc., on an Android phone and expect to get aything
> useful done.  Using ssh, or mosh, with Termux, sure.  But git?  Not
> convinced....
>
> Anyway, if we *do* want bring back the reverted patch, it would need
> to be reworked so that there is a bit in the encoding flags which
> indicates how we are treating Unicode "ignorable" characters, so that
> e2fsprogs and f2fs-tools can do the right thing.  Once the kernel can
> handle things with and without ignorable characters, on a switchable
> basis based on a bit in the superblock, then we wouldn't need to use
> the linear fallback hack, with the attendant performance penalty.
>
> But honestly, I'm not sure it worth it.  But if someone sends me a
> patch which handles the switchable unicode casefold, I'm willing to
> spend time to get this integrated into e2fsprogs.

What I think would be a correct approach for commit 5c26d2f1d3f5
("unicode: Don't special case ignorable code points") is to fold *some*
code points: zero-length characters like ZWSP are folded as they should
be, but we limit the list to not normalize those characters that make
some sense, like the Variant Selectors.  This would be similar to what
APFS seems to do.  This would be complex, but the user-visible semantics
would be slightly more sane. It should be done with caution, with a bit
marking this change and preserving the current unicode database, to
prevent further breakage.  But given the damage this apparent simple
patch has caused already, I myself won't pursue that without a real
security motivation.

Thanks for the linear search patches.  Not great, but it solves the
current situation. For your ext4 patch:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

-- 
Gabriel Krisman Bertazi

