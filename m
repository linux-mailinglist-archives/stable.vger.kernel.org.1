Return-Path: <stable+bounces-230645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BZ1J1hxxmmkJwUAu9opvQ
	(envelope-from <stable+bounces-230645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:00:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B59343E67
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9B3A3020EC6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471938F64C;
	Fri, 27 Mar 2026 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yLGafDWd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BhYEaIlp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yLGafDWd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BhYEaIlp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E906390200
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612793; cv=none; b=iEM/TYqpVsTEwXJoo5dyg//FwVeXerSd2hV5g28Oxc2vMRGFbixcMsjshL3rBvaV7/ws+Ro+sgNMCvCN3aAvuedtdzsaOEEiGlBycFuEXAPsLQT3Ynf5FA177WRU6AQOJHBDsag+Uzw47UFuJAlxgOEmYe6PLbjfjDPxdwtP5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612793; c=relaxed/simple;
	bh=1XSOviq9gBZc9z4jhWUIu8rDYcgPKKQvmUU8GBhP3pY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpVAXJp4nvHRlQU5one/17cyLXNR/cAdNqcXbtonJ3676/1yYmpRf/xRXEGOEMUUJuJfG/PSOj+2YiWQ2yDOPQ80Bfam/IBkwQyvc+tMPxInIyWBrlqk0I+8UgZnqIvmhVpyj1UqPGRkrgu0BFZ9gkYX82hvRJQpfi0k5b9LWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yLGafDWd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BhYEaIlp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yLGafDWd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BhYEaIlp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BD705BDD3;
	Fri, 27 Mar 2026 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774612789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPcbTpFwdwSKg8bHPU4YgjTCJbfodhUoXmqfi0xtXJg=;
	b=yLGafDWdq6UwnPqyZvIljxOqL06tEUTY62DIQPpmUpDroU19lH7nG8I5bUJiuUoE7y5CsA
	GXbvMKCicdGwx2MLsCiLEZnJpXikTn9TVyPF54FC07LU79RHozvKkN+ZJCyv4mpABS52Gn
	bwMk9LWH6jiOgGFilEkFVh072uDdOtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPcbTpFwdwSKg8bHPU4YgjTCJbfodhUoXmqfi0xtXJg=;
	b=BhYEaIlpvF2B/OX6DUwuxD/4RqRIP+R6XP3K83h9T41EY+ZscmglonnI75WPUIPizPvqf2
	JjrmrQwolXaAkuAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yLGafDWd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BhYEaIlp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774612789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPcbTpFwdwSKg8bHPU4YgjTCJbfodhUoXmqfi0xtXJg=;
	b=yLGafDWdq6UwnPqyZvIljxOqL06tEUTY62DIQPpmUpDroU19lH7nG8I5bUJiuUoE7y5CsA
	GXbvMKCicdGwx2MLsCiLEZnJpXikTn9TVyPF54FC07LU79RHozvKkN+ZJCyv4mpABS52Gn
	bwMk9LWH6jiOgGFilEkFVh072uDdOtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774612789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPcbTpFwdwSKg8bHPU4YgjTCJbfodhUoXmqfi0xtXJg=;
	b=BhYEaIlpvF2B/OX6DUwuxD/4RqRIP+R6XP3K83h9T41EY+ZscmglonnI75WPUIPizPvqf2
	JjrmrQwolXaAkuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A294A0A2;
	Fri, 27 Mar 2026 11:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7jzHCDVxxmkHOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 11:59:49 +0000
Date: Fri, 27 Mar 2026 12:59:48 +0100
Message-ID: <87ldfdqy8b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: seq_oss: return full count for successful SEQ_FULLSIZE writes
In-Reply-To: <20260324-alsa-seq-oss-fullsize-write-return-v1-1-66d448510538@gmail.com>
References: <20260324-alsa-seq-oss-fullsize-write-return-v1-1-66d448510538@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230645-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 35B59343E67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 20:59:41 +0100,
Cássio Gabriel wrote:
> 
> snd_seq_oss_write() currently returns the raw load_patch() callback
> result for SEQ_FULLSIZE events.
> 
> That callback is documented as returning 0 on success and -errno on
> failure, but snd_seq_oss_write() is the file write path and should
> report the number of user bytes consumed on success. Some in-tree
> backends also return backend-specific positive values, which can still
> be shorter than the original write size.
> 
> Return the full byte count for successful SEQ_FULLSIZE writes.
> Preserve negative errors and convert any nonnegative completion to the
> original count.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi

