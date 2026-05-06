Return-Path: <stable+bounces-244365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO5+B54i+2lvWwMAu9opvQ
	(envelope-from <stable+bounces-244365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:14:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D784D9A22
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48EE1300BD5E
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8868421EFD;
	Wed,  6 May 2026 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KBCjgcHf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QMwy4HWM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KBCjgcHf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QMwy4HWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FBE3FE36A
	for <stable@vger.kernel.org>; Wed,  6 May 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066068; cv=none; b=AtR6s1BpLTH0EFY0GL01A9v8DV1MScANf8LLJV5iEttuVftI7eaDGBU3cYZh1GqMWWxilUeXhpzIRo1w0OiMOS4X0VAPARzBTgXdx+1oJCe/B9SQZmjidevvGLQkhi2AqTO1E0bKGs4+ENQxcQ2QIQvGAqIh3M4ENCdsbQmu4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066068; c=relaxed/simple;
	bh=LvFxCHbOGRjJ7dpu5UsC9gpZu0+Ci2F3B15Uv+62HLA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ix4iAL/VHLgeWuvAygLErGKhjdKYVVZO9oIgQ2WYooWLxVokhemVS/9Bvm45xjPnRILnHIHkcRm2sVQAfl7q9JlEHpQY0krHCcjsjCic06ELs2lY83qUhe046B8tBsZ9iigqfqe9loFZ0VH76WJl4GbZ2hv1nh6hC1uEVjq8cfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KBCjgcHf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QMwy4HWM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KBCjgcHf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QMwy4HWM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0BE96B7F1;
	Wed,  6 May 2026 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778066065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4XhxgKG4AAWZH0Z2axsmkZ4iCzPZcug/kEaSYRSO4Q=;
	b=KBCjgcHfWRJnxq27EAiOMtwRXoeO23PQD9SgDVW/ARDQtivDaR9AHIXbVL6qWxNm9EFSwU
	5057MeXrqnpVgeSy5ri+xIkpk3leWmYgW3WYeDOji+bCI8FSf91pjSrZDhI86xPv0ltrDV
	UYOxbqg8mOt3no08+v7wmPCORYKXBzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778066065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4XhxgKG4AAWZH0Z2axsmkZ4iCzPZcug/kEaSYRSO4Q=;
	b=QMwy4HWMzI3eMSM7m4snJFPuEgBOxX1t1ISMIqDquiDJmW0UgDmgErB1iljDuIcoEdabyp
	DZ2HkdpOxAPZdtDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778066065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4XhxgKG4AAWZH0Z2axsmkZ4iCzPZcug/kEaSYRSO4Q=;
	b=KBCjgcHfWRJnxq27EAiOMtwRXoeO23PQD9SgDVW/ARDQtivDaR9AHIXbVL6qWxNm9EFSwU
	5057MeXrqnpVgeSy5ri+xIkpk3leWmYgW3WYeDOji+bCI8FSf91pjSrZDhI86xPv0ltrDV
	UYOxbqg8mOt3no08+v7wmPCORYKXBzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778066065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4XhxgKG4AAWZH0Z2axsmkZ4iCzPZcug/kEaSYRSO4Q=;
	b=QMwy4HWMzI3eMSM7m4snJFPuEgBOxX1t1ISMIqDquiDJmW0UgDmgErB1iljDuIcoEdabyp
	DZ2HkdpOxAPZdtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69B78593A3;
	Wed,  6 May 2026 11:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2tYGJEi+2k7ZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 06 May 2026 11:14:25 +0000
Date: Wed, 06 May 2026 13:14:25 +0200
Message-ID: <87ik90ssby.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Takashi Iwai" <tiwai@suse.de>,	=?ISO-8859-1?Q?C=E1ssio?= Gabriel
 <cassiogabrielcontato@gmail.com>,	"Luis Chamberlain" <mcgrof@kernel.org>,
	"Russ Weight" <russ.weight@linux.dev>,	"Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Takashi Iwai" <tiwai@suse.com>,	"Shenghao Ding" <shenghao-ding@ti.com>,
	"Kevin Lu" <kevin-lu@ti.com>,	"Baojun Xu" <baojun.xu@ti.com>,
	"Jaroslav Kysela" <perex@perex.cz>,<driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>,<linux-sound@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] firmware_loader/ALSA: Fix TAS2781 async firmware teardown
In-Reply-To: <DIBHP03H2703.3GVN744LMKNQ1@kernel.org>
References: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-0-e7c4bf930dc8@gmail.com>
	<874iklt12t.wl-tiwai@suse.de>
	<DIBHP03H2703.3GVN744LMKNQ1@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Rspamd-Queue-Id: 22D784D9A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,kernel.org,linux.dev,linuxfoundation.org,suse.com,ti.com,perex.cz,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244365-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, 06 May 2026 11:34:39 +0200,
Danilo Krummrich wrote:
> 
> On Wed May 6, 2026 at 10:05 AM CEST, Takashi Iwai wrote:
> > On Tue, 05 May 2026 13:18:15 +0200,
> > Cássio Gabriel wrote:
> >> Cássio Gabriel (2):
> >>       firmware_loader: Add cancel helper for async requests
> >>       ALSA: hda/tas2781: Cancel async firmware request at unbind
> 
> Looks good to me now.
> 
> > I guess this could go via driver tree?  Or I can take both if I get an
> > ack, too.
> 
> Sure, I can pick it up via the driver-core tree, but please also feel free to
> take it through the sounds tree.
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks, then I'm going to take this to sound git tree, as it's the
only user so far.


Takashi

