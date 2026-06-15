Return-Path: <stable+bounces-263167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvgLJ2THL2owGQUAu9opvQ
	(envelope-from <stable+bounces-263167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:35:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E0685184
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:35:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LjEH6Qhh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pt1yfHlk;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A0wm2e9c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VQtO9FdC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263167-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263167-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B72BF3022ABE
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B53D9DCE;
	Mon, 15 Jun 2026 09:35:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE93D6CC5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 09:35:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516130; cv=none; b=EXMbWNXhjtQFcnEE0EtlmJNDxKdK+LiipAnxICpupEx899wFBqXHm93C/Rq+W2elApuLoC9iFpnyQBwzKAymhYdgl+fI/JOnMP/DFO+YZUiMncb6wdUS8E+RTKiqoOqQ+fYwX5I5mQ4Gdq2JNy0nPVPP8F3c+CzHvaSpnw7iKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516130; c=relaxed/simple;
	bh=TObyHCrog0J37zOBX+KTGoi74gpbHRQn8XN9jcDMGEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN6SWIatgo9oBe3AK2knnDbBwIZYpTgg/BE3h2wPct9Tit61KTJJlDS2ISq0MERY8rvApugoXV7pFuRSZ2FEtjZgH1sRRTf7J5ZcjO4bcy/FQA5AJeF/J1Ei/mKByA9iGSjobGnZeLgvYdGta1jaoVSg83eF7VTejLDECzfy2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LjEH6Qhh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pt1yfHlk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A0wm2e9c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VQtO9FdC; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C40D46AC95;
	Mon, 15 Jun 2026 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781516127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afhcBrMHwtuNpl6EOyz1Ve+TLR1X1Oc6pxCJDnx1z1w=;
	b=LjEH6QhheCbXn2yYPxvbrQS4POOD1+xCC+LO3SkvS9XwqOGQegNJetZOCT4begs2XLaB9J
	2h9aIEuCZvmyn/UuI2zWP4GX84GOGHRbAgh/rUEvfj0/D+nvYNAxwWZMIz8ctCyBduGet7
	0S/z0OyZJNnyU/3lUIEQQnfWF0NGB/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781516127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afhcBrMHwtuNpl6EOyz1Ve+TLR1X1Oc6pxCJDnx1z1w=;
	b=Pt1yfHlktWylvTPkHQFn+SL7QASL8d9bAifpFbwv1SSVHNKU59GDIYbOX9vsWqe1JyoSyT
	F65YD0EcejhkunAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781516126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afhcBrMHwtuNpl6EOyz1Ve+TLR1X1Oc6pxCJDnx1z1w=;
	b=A0wm2e9cm42qj6Nt6QFoHr1xCPbseD1yIj4YlRvk43PHySHrjrH5ewdfM1Olyx8hU8iSQ3
	GRuql8ut/sAK6Zwm/zYmWkILVhPVh21xP/+WBQFnp6M/SXNt8/h4o/m8LRASOp8gjWX3DZ
	YOWy+CzvrK4xB/kUSypZ0RXNMdThJLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781516126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afhcBrMHwtuNpl6EOyz1Ve+TLR1X1Oc6pxCJDnx1z1w=;
	b=VQtO9FdC4JV39U9SaPNzDuOosxdZ2fjfbcabW45ia/MaienRPG4n1qi1Ubkn42EwpAr0Ne
	0sFDJefdiMtxwlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB1E0779A7;
	Mon, 15 Jun 2026 09:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xk9TKF7HL2qVRgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Jun 2026 09:35:26 +0000
Date: Mon, 15 Jun 2026 11:35:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Ram Vegesna <ram.vegesna@broadcom.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, Kees Cook <kees@kernel.org>, James Smart <jsmart2021@gmail.com>, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: elx: efct: fix refcount leak in efct_hw_io_abort()
Message-ID: <b601d4e2-8b10-417d-8d4d-1c09e556e94a@flourine.local>
References: <20260611053037.63756-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611053037.63756-1-vulab@iscas.ac.cn>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,hansenpartnership.com,oracle.com,mt-integration.ru,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263167-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:ram.vegesna@broadcom.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:v.shevtsov@mt-integration.ru,m:kees@kernel.org,m:jsmart2021@gmail.com,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dwagner@suse.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwagner@suse.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E51E0685184

On Thu, Jun 11, 2026 at 01:30:37PM +0800, WenTao Liang wrote:
> When efct_hw_reqtag_alloc() fails in efct_hw_io_abort(), the error
> path returns -ENOSPC without releasing the reference obtained via
> kref_get_unless_zero() earlier in the function. All other error
> paths correctly drop the reference. This causes a permanent
> reference leak on the io_to_abort object.
> 
> Additionally, the abort_in_progress flag is left set to true on
> this path, which means future abort attempts for the same I/O will
> immediately return -EINPROGRESS even though the abort was never
> submitted, effectively blocking recovery.
> 
> Fix this by adding the missing kref_put() call and reset
> abort_in_progress to false, matching the cleanup done in the
> efct_hw_wq_write() failure path below.
> 
> Cc: stable@vger.kernel.org
> Fixes: 63de51327a64 ("scsi: elx: efct: Hardware I/O and SGL initialization")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

