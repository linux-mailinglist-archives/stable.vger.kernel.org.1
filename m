Return-Path: <stable+bounces-208341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822DD1DBE9
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2200E301118F
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 09:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C33806C3;
	Wed, 14 Jan 2026 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hd4lnGQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJ0FIoZH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hd4lnGQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJ0FIoZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0C37F730
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384549; cv=none; b=BSHVCEa0wMUrYudFjQKZEu5l3Xth+/V8c++Z1A1Eu25L8XYIPO1RlmRyGSHBHTqxa3ryOlXXxktcx1mjPjZ9aCIvZWKNjkJZtuZSXn/UJ0orhaHlhYD6QLu86EnHbuklfDtjZHnD1/kvPcroFZFju5pELu2/93Gre6EifAImHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384549; c=relaxed/simple;
	bh=p86KPxCGubkTIxSq0hwqFa1y+kPFYMO8AfoUvy4TeCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKP9zRkyeYAVnnChQ+JexeoTQccQOrh8kXhyVIi1p+cdbl+EzL7RQ6eQoSTwzHs0gHK7qb11cw8EyS1QqKwSh0HyshVWms0kmF09p02nIc4AKfQurkcK6lw+Y0HpLXNDsa1rVIcSAsYMFMDk76BnDmWpGMNfmKehQ4mCPFMGBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hd4lnGQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BJ0FIoZH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hd4lnGQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BJ0FIoZH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F41545C0F7;
	Wed, 14 Jan 2026 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768384545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=Hd4lnGQ3SYgdaCllYs/l7WBgqef4eoUcuS728s0lwrWpQDKIdBOEbCeB+MNs6BXx/xE+d7
	1HWEDY468V9NkdNSerkR/90o9U+6IbRoL+kiGxuj4Aet1PH1LPo5OPEHrxdhVFmkZrmdCz
	WZQRllusxepr5z1jGrIyWfa8yz7xfz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768384545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=BJ0FIoZH++RncmU8rfpt41vegt8jXn+4Qg/8FFNR6S6aA/vzeeU4g+40oJrBY9lL0WOS2M
	WlqWPEnUyEIgVAAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768384545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=Hd4lnGQ3SYgdaCllYs/l7WBgqef4eoUcuS728s0lwrWpQDKIdBOEbCeB+MNs6BXx/xE+d7
	1HWEDY468V9NkdNSerkR/90o9U+6IbRoL+kiGxuj4Aet1PH1LPo5OPEHrxdhVFmkZrmdCz
	WZQRllusxepr5z1jGrIyWfa8yz7xfz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768384545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=BJ0FIoZH++RncmU8rfpt41vegt8jXn+4Qg/8FFNR6S6aA/vzeeU4g+40oJrBY9lL0WOS2M
	WlqWPEnUyEIgVAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12743EA63;
	Wed, 14 Jan 2026 09:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dnQJNiBoZ2l+KQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Jan 2026 09:55:44 +0000
Date: Wed, 14 Jan 2026 10:55:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, jmeneghi@redhat.com, wagi@kernel.org, 
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	james.smart@broadcom.com, hare@suse.de, shinichiro.kawasaki@wdc.com, 
	wenxiong@linux.ibm.com, nnmlinux@linux.ibm.com, emilne@redhat.com, mlombard@redhat.com, 
	gjoyce@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix PCIe subsystem reset controller state
 transition
Message-ID: <f0a74e06-9e96-4149-a8e5-16f09e15346b@flourine.local>
References: <20260114072416.1901394-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114072416.1901394-1-nilay@linux.ibm.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Jan 14, 2026 at 12:54:13PM +0530, Nilay Shroff wrote:
> The commit d2fe192348f9 (“nvme: only allow entering LIVE from CONNECTING
> state”) disallows controller state transitions directly from RESETTING
> to LIVE. However, the NVMe PCIe subsystem reset path relies on this
> transition to recover the controller on PowerPC (PPC) systems.
> 
> On PPC systems, issuing a subsystem reset causes a temporary loss of
> communication with the NVMe adapter. A subsequent PCIe MMIO read then
> triggers EEH recovery, which restores the PCIe link and brings the
> controller back online. For EEH recovery to proceed correctly, the
> controller must transition back to the LIVE state.
> 
> Due to the changes introduced by commit d2fe192348f9 (“nvme: only allow
> entering LIVE from CONNECTING state”), the controller can no longer
> transition directly from RESETTING to LIVE. As a result, EEH recovery
> exits prematurely, leaving the controller stuck in the RESETTING state.
> 
> Fix this by explicitly transitioning the controller state from RESETTING
> to CONNECTING and then to LIVE. This satisfies the updated state
> transition rules and allows the controller to be successfully recovered
> on PPC systems following a PCIe subsystem reset.
> 
> Cc: stable@vger.kernel.org
> Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks for fixing this.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

