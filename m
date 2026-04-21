Return-Path: <stable+bounces-240077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDM2JM0w52kD5QEAu9opvQ
	(envelope-from <stable+bounces-240077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:09:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F2437FB4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD623012247
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACA38552F;
	Tue, 21 Apr 2026 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XH1sR9yr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4KHo0RLN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XH1sR9yr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4KHo0RLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB6382F09
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758964; cv=none; b=dojdk3cqOt7jn+/wZ7pHc+ZKRQdOqJ7NnkRZ4ePXGG0Kqj7zZn8RQ99W+BoKDpcd1AKTm2pk/r8KNcSkpAeuxxkTWDvrR2QRaMzzI2lDseKVXSnjM6HZ+O7qwRC+hW/rBEaPVf3u7VLrq0cDIjPhTd9zQxEPBuLC8tl1Ks6p3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758964; c=relaxed/simple;
	bh=IbKds+GZDvWZ1AMSqig2o/oa1o308PhZF1M5v30NV2Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etm9Nu/aDzVv8ubxkE5jDNNQ7Pj9nsBIAyw+O4rOTuWU5rSPTU/XNB7Naaxmspp9IA76DcjxpznEpW0lFr9TN3yaaj3Blc287Ln9ojtLRPp6c10N8h97cTRO8vScsofbawjFnKB/r42iAS7Ra93cnR2ZUEE/048+JONf3Kh7+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XH1sR9yr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4KHo0RLN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XH1sR9yr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4KHo0RLN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C6C15BCC5;
	Tue, 21 Apr 2026 08:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776758961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGQBy7VmFKHqQxY/IS+vriLoY0jK3Gw8R6wRaSP0418=;
	b=XH1sR9yrvixmr26qj1Wb2HdW+JKf/WUcS1Y6OrgY5rx6uPsGjLfVpU6bl1zGEZ09YmvBkV
	3VNwfhJcA/F062RYj0dWsO4yNEjNtg1RWuBSfEI0X3TVoomN/xqnzCkM97QXIQxVQRjb85
	BSGov9U2cmVCy6024v0NlRJbXBWuXrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776758961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGQBy7VmFKHqQxY/IS+vriLoY0jK3Gw8R6wRaSP0418=;
	b=4KHo0RLN2Zd+mITkFRx13XolsabDuMShGN2ihooQEnbUOYhoitU62eflDNxuDdmU0b2NH1
	0+UbF6kR8rscKjCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XH1sR9yr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4KHo0RLN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776758961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGQBy7VmFKHqQxY/IS+vriLoY0jK3Gw8R6wRaSP0418=;
	b=XH1sR9yrvixmr26qj1Wb2HdW+JKf/WUcS1Y6OrgY5rx6uPsGjLfVpU6bl1zGEZ09YmvBkV
	3VNwfhJcA/F062RYj0dWsO4yNEjNtg1RWuBSfEI0X3TVoomN/xqnzCkM97QXIQxVQRjb85
	BSGov9U2cmVCy6024v0NlRJbXBWuXrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776758961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGQBy7VmFKHqQxY/IS+vriLoY0jK3Gw8R6wRaSP0418=;
	b=4KHo0RLN2Zd+mITkFRx13XolsabDuMShGN2ihooQEnbUOYhoitU62eflDNxuDdmU0b2NH1
	0+UbF6kR8rscKjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0158C593AF;
	Tue, 21 Apr 2026 08:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3iqMOrAw52kyUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 21 Apr 2026 08:09:20 +0000
Date: Tue, 21 Apr 2026 10:09:20 +0200
Message-ID: <87v7dkag5r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Chris J Arges <chris.j.arges@canonical.com>,
	Detlef Urban <onkel@paraair.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/4] usb-audio: fix mixer write failure handling
In-Reply-To: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
References: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-240077-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: E35F2437FB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 19 Apr 2026 22:30:28 +0200,
Cássio Gabriel wrote:
> 
> This series fixes usb-audio mixer put() paths that currently report
> success even when the underlying device write fails.
> 
> The issue exists in the generic mixer core callbacks, the Scarlett
> Gen1 enum path, and several Tascam US-16x08 put() callbacks.
> 
> The US-16x08 EQ and compressor callbacks have an additional bug: they
> update their software shadow state before sending the USB write, so a
> failed transfer can leave later get() results out of sync with the
> hardware state.
> 
> The series is split into four patches:
> - propagate write failures in the generic mixer core callbacks
> - fix the Scarlett Gen1 enum callback
> - propagate write failures in the simple US-16x08 put() callbacks
> - commit the US-16x08 EQ and compressor shadow state only after a
> successful write
> 
> Successful writes are unchanged. Failed writes are now reported
> correctly, and the US-16x08 shadow state remains coherent with the
> hardware after write errors.
> 
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

As this might influence on the actual device behavior significantly,
and it's in a merge window, I postpone the series for 7.2.


thanks,

Takashi

