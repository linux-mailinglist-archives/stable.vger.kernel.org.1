Return-Path: <stable+bounces-255016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGt+N9xNGGomiwgAu9opvQ
	(envelope-from <stable+bounces-255016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:14:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591635F37FB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F197230237E1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877D30E0F8;
	Thu, 28 May 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HvD5Jujz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JvDJIGH9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HvD5Jujz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JvDJIGH9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC872E2852
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977235; cv=none; b=KKUo6hoAUar181OpQu/JgOVjgGeOOTYSH4G1cmg5/d255OaknEXNkcepmro/ZPY9G2YptP0Vw4xf3pDrUe0mY7lvv7sKaAGdJaMYDCRfXO3L+fNLSlqWrv0ruw/74oJ+5kB3D4XYqAVDV1qY7tCmySA1L69RF+/3dVLBb8JmtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977235; c=relaxed/simple;
	bh=n2WdvAPcdZd4yLc3jYAe2NxPJItV6wi6rRMEAh4k6EA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5XKDi35bdDuP+CtMHUCbAh65EkBvRb57F84m/O/UJftCBfaFEMu+dWZubltME4kZCzEtkX6ljBO4byhPNzrIw6xtZ9omds6gYUmRTuxK/wkHiwpiUbvUJ9YmOwckFHspNMewMfb06T5C5ytpzrGAR7Pq7cZ9vz9RuFGptKVSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HvD5Jujz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JvDJIGH9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HvD5Jujz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JvDJIGH9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8558866D80;
	Thu, 28 May 2026 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779977226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGLPnrTk2dzEJyjbhcrnNRQDJSJlvCwppUYrkYHfuTM=;
	b=HvD5JujzyOdsedJct/vw/t6dO4/3Tn1WCOL11vqJxpxYXQHUonM3PUm9hrBaw/OkV3rUIN
	DQEARg0up35gFUvcExlfVoVSGoP5qif3NER21YzpAabnoR213U3OehcF134OP8J5eQOUaE
	lrxrouUbHxTNDH9/a5mgTPqQqpr5GRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779977226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGLPnrTk2dzEJyjbhcrnNRQDJSJlvCwppUYrkYHfuTM=;
	b=JvDJIGH9O8fF+B6sfC0zpM0jWlzPwefU3YGWJfJZONbDH+7tagzuqxdYbmAa27qRz8oede
	5CzduOCOGyByJJCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HvD5Jujz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JvDJIGH9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779977226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGLPnrTk2dzEJyjbhcrnNRQDJSJlvCwppUYrkYHfuTM=;
	b=HvD5JujzyOdsedJct/vw/t6dO4/3Tn1WCOL11vqJxpxYXQHUonM3PUm9hrBaw/OkV3rUIN
	DQEARg0up35gFUvcExlfVoVSGoP5qif3NER21YzpAabnoR213U3OehcF134OP8J5eQOUaE
	lrxrouUbHxTNDH9/a5mgTPqQqpr5GRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779977226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGLPnrTk2dzEJyjbhcrnNRQDJSJlvCwppUYrkYHfuTM=;
	b=JvDJIGH9O8fF+B6sfC0zpM0jWlzPwefU3YGWJfJZONbDH+7tagzuqxdYbmAa27qRz8oede
	5CzduOCOGyByJJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E8A55AE0E;
	Thu, 28 May 2026 14:07:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E+LNEQpMGGrUZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 May 2026 14:07:06 +0000
Date: Thu, 28 May 2026 16:07:05 +0200
Message-ID: <87mrxjsk52.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mike Karcic <mikekarcic@protonmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
In-Reply-To: <RfzfjlzeaeMgNNWNST_Zzx1v49rYjM63MvAV6O5_fFIoZJ73GcN69FDLJcwhJ3s6fl9TVD2l45YBh2n3hy95LM7rhLhoVt8dU9stMkuVJvE=@protonmail.com>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
	<CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
	<wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
	<87eciwukvy.wl-tiwai@suse.de>
	<RfzfjlzeaeMgNNWNST_Zzx1v49rYjM63MvAV6O5_fFIoZJ73GcN69FDLJcwhJ3s6fl9TVD2l45YBh2n3hy95LM7rhLhoVt8dU9stMkuVJvE=@protonmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255016-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 591635F37FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 15:38:54 +0200,
Mike Karcic wrote:
> 
> I did test 46c862f5419e on 6.12.90. Chirp still present.
> 
> I'm also on a ThinkPad X1 Carbon Gen 12 with ALC287 (17aa:231e),
> same as the original reporter. The fix resolved it for them but
> not for me.
> 
> Only a full revert of 630fbc6e870e resolves the issue.
> 
> Verification on the running kernel:
> 
>   $ grep -c "dis_coefs" sound/pci/hda/patch_realtek.c
>   2
> 
>   $ grep -c "en_coefs" sound/pci/hda/patch_realtek.c
>   0
> 
>   $ sed -n '/alc287_alc1318_playback_pcm_hook/,/^}/p' sound/pci/hda/patch_realtek.c
>   static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_stream *hinfo,
>                                      struct hda_codec *codec,
>                                      struct snd_pcm_substream *substream,
>                                      int action)
>   {
>           switch (action) {
>           case HDA_GEN_PCM_ACT_OPEN:
>                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f);
>                   break;
>           case HDA_GEN_PCM_ACT_CLOSE:
>                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f);
>                   break;
>           }
>   }
> 
> Happy to test further patches.

Just to be sure, could you verify that you've tested really the
patched kernel, e.g. by adding a debug print, etc?
If yes and the problem is seen even with the patch, try to comment out
  alc_process_coef_fw(codec, dis_coefs);
and confirm that this fixes the problem.


Takashi

