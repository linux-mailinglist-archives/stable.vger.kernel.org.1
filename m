Return-Path: <stable+bounces-109276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44928A13C26
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D28216515F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B422ACE7;
	Thu, 16 Jan 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J4mq97ox";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OpEikvnd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J4mq97ox";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OpEikvnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCB22A7F2;
	Thu, 16 Jan 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037600; cv=none; b=beNqbsPYpWJnZPoOpi2OnopvYg7Xp0mAUsQNjEjA1dLYJ+tqZQyyh4FP+WAR1MaevW0adnkJQ+W9d6TulwDyxp3/ANCkO4PFiDy94vpfyZD8MKtRRE1YH1C/6/Zi2JaMTmJjSK/237HDuwN4RqbaJgOx52HoCYLPb2hIMEetFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037600; c=relaxed/simple;
	bh=VKtNrWvWk+iN/uKZ4Unnp197D6rui9M2yZka5smhU88=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XptZOd/tjr+jj6qCwQCqgsQF85XvgFOMYfCSqeFUofF13lFGYbD1Py9CrFNNO9SFgl3BpFK0axY0f1rNsIgp16h1MBfttG+xB2bvxDDs/02VPrtZfwYbS8lbzcUAWtoaCuOrID0p10Q5vjdGdjHb9q1FDZJBB3Cw6rdsvEq5Y9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J4mq97ox; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OpEikvnd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J4mq97ox; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OpEikvnd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3EDD211CA;
	Thu, 16 Jan 2025 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737037597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3benVHZIe6d7ABJ0Gv3HWlD5LOOVZSFAyIgJZe2mWE=;
	b=J4mq97oxfDOnCDBH/8CrAVMLNwN5WRJn+O8l6EgS88A/vr7bYJQgWmWIlp54zdNBu9Qhh5
	jxE5oegrd6Cz3jRBaSfblLrncykQbFfdgxAXshZNuevUaQYkaLYZ5t7k8bsJPO75qJkxyl
	oe+79sTH+qr/VeqO8W6LahEgTieo06A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737037597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3benVHZIe6d7ABJ0Gv3HWlD5LOOVZSFAyIgJZe2mWE=;
	b=OpEikvndlDcnOZitBBOqWsA/iB+0IZFo8Qjystd7RBO5i9FOU17u7yvTJwXsoGUJZqr2AZ
	Zvnkfg4ARHCbc3Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737037597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3benVHZIe6d7ABJ0Gv3HWlD5LOOVZSFAyIgJZe2mWE=;
	b=J4mq97oxfDOnCDBH/8CrAVMLNwN5WRJn+O8l6EgS88A/vr7bYJQgWmWIlp54zdNBu9Qhh5
	jxE5oegrd6Cz3jRBaSfblLrncykQbFfdgxAXshZNuevUaQYkaLYZ5t7k8bsJPO75qJkxyl
	oe+79sTH+qr/VeqO8W6LahEgTieo06A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737037597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3benVHZIe6d7ABJ0Gv3HWlD5LOOVZSFAyIgJZe2mWE=;
	b=OpEikvndlDcnOZitBBOqWsA/iB+0IZFo8Qjystd7RBO5i9FOU17u7yvTJwXsoGUJZqr2AZ
	Zvnkfg4ARHCbc3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDE7113A57;
	Thu, 16 Jan 2025 14:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S4/RLBwXiWfXUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Jan 2025 14:26:36 +0000
Date: Thu, 16 Jan 2025 15:26:36 +0100
Message-ID: <87a5bqj0mb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgeny Kapun <abacabadabacaba@gmail.com>
Cc: Kailang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions Mailing List <regressions@lists.linux.dev>,
	Linux Stable Mailing List <stable@vger.kernel.org>
Subject: Re: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
In-Reply-To: <0494014b-3aa2-4102-8b5b-7625d8c864e2@gmail.com>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
	<8734ijwru5.wl-tiwai@suse.de>
	<57883f2e-49cd-4aa4-9879-7dcdf7fec6df@gmail.com>
	<87ldw89l7e.wl-tiwai@suse.de>
	<fc506097-9d04-442c-9efd-c9e7ce0f3ace@gmail.com>
	<58300a2a06e34f3e89bf7a097b3cd4ca@realtek.com>
	<0494014b-3aa2-4102-8b5b-7625d8c864e2@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 11 Jan 2025 16:00:33 +0100,
Evgeny Kapun wrote:
> 
> On 12/24/24 04:54, Kailang wrote:
> > Please test attach patch.
> 
> This patch, when applied to kernel version 6.12.8, appears to fix the
> issue. There are no distortions, and the left and the right channel
> can be controlled independently.

Good to hear.

Kailang, care to submit a proper patch for merging?


thanks,

Takashi

