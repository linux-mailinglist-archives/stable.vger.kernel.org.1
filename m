Return-Path: <stable+bounces-89172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200AA9B445E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 09:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FAB2831AD
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 08:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A26C2038B3;
	Tue, 29 Oct 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1lXDa2CN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6iVb3bVf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cOyPBm7O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uxiF/qI+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E991F7565;
	Tue, 29 Oct 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191226; cv=none; b=bKzEhFKg9lbPzVKLNYMEpquE8PPZSFVQp/DW3Ji8+vAmXvjAFSSweEmQKxUUPSSG7OKnkp5ue1UIgWBbLjXvq46e+nxIzx+wgYD57z50RrO1JeKyrOOotPvJZLpPt3ROXl0hOezBjGO3eWLxW08mrQO0KUoG3xFqBEw5EZT3RIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191226; c=relaxed/simple;
	bh=iQF6UHSnxYEAFWJcF9g9ztCFSYRIm/DH5lDUEHaJTjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwyF7vp1oeNwXipRveipTHySO8fDs8ckHbN9+pYLqVmOBK8H0k4zfu2+I0+N/UPlJz8nSYv8IshFQF71yZeLG1J415J4O5GPru4HoJNE1FsHp5/9NbWX8zAUwz5ScFD/bVd95ADIeTqdpwtTczdNpt0xAH+JFv/PQmCmLZcNezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1lXDa2CN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6iVb3bVf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cOyPBm7O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uxiF/qI+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C799B1FE51;
	Tue, 29 Oct 2024 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730191222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCg1WmOg+9L9fFSl0MlZWrJ2jBdmUs1LhMYZ0qlGhCw=;
	b=1lXDa2CNNif6hUEn2YLWNWiJqL3EGFANk/D7gV6WmvsmIQVPI/jDOKAnoiyXnbnyIjt8T+
	nZ4aRenp2ZslmnTYort9SJV8a3hQDv3REaeshGtNgM7lmNkFT5Ij6xHo3alyOCFUywu/hs
	rU2jr2oOHowX87VdYZc6X5DbHHOMgJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730191222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCg1WmOg+9L9fFSl0MlZWrJ2jBdmUs1LhMYZ0qlGhCw=;
	b=6iVb3bVfpaBi8g0TMAfSKWs8WX4qmPcP29c+QOWtstg1W//5nehNGVx2rUa52MeoQBEbte
	2a/74cQsmtukO4Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cOyPBm7O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="uxiF/qI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730191221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCg1WmOg+9L9fFSl0MlZWrJ2jBdmUs1LhMYZ0qlGhCw=;
	b=cOyPBm7OuB/PYanwyDPVFEc7DxnzHAtfvNY0TG5vq7ciIA9IF9JQBBIMD9sywQdx5gOlbC
	MQg9UHuop5iMQY9OGImR/IwGnNxBLDQOJSUrRr1qxeaoisWb8Us/yHUwvSNf4y3wxuwlvd
	+udCqtNWA75Fmpceax+c3BnmrVkWpWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730191221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCg1WmOg+9L9fFSl0MlZWrJ2jBdmUs1LhMYZ0qlGhCw=;
	b=uxiF/qI+vlbLJfdgszhnbcItaNxi3i3aUGurLrc8TshRv2p+1AmJGLBwddaGZERUHRJRV5
	qakLKM+nz5Zuz9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C155139A2;
	Tue, 29 Oct 2024 08:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Me59A3WfIGd0DQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 29 Oct 2024 08:40:21 +0000
Date: Tue, 29 Oct 2024 09:40:04 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
	akpm@linux-foundation.org, ying.huang@intel.com, weixugc@google.com,
	dave.hansen@linux.intel.com, shy828301@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
Message-ID: <ZyCfZHU3B4PBNR0A@localhost.localdomain>
References: <20241025141724.17927-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025141724.17927-1-gourry@gourry.net>
X-Rspamd-Queue-Id: C799B1FE51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,meta.com,linux-foundation.org,intel.com,google.com,linux.intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, Oct 25, 2024 at 10:17:24AM -0400, Gregory Price wrote:
> When numa balancing is enabled with demotion, vmscan will call
> migrate_pages when shrinking LRUs.  Successful demotions will
> cause node vmstat numbers to double-decrement, leading to an
> imbalanced page count.  The result is dmesg output like such:
> 
> $ cat /proc/sys/vm/stat_refresh
> 
> [77383.088417] vmstat_refresh: nr_isolated_anon -103212
> [77383.088417] vmstat_refresh: nr_isolated_file -899642
> 
> This negative value may impact compaction and reclaim throttling.
> 
> The double-decrement occurs in the migrate_pages path:
> 
> caller to shrink_folio_list decrements the count
>   shrink_folio_list
>     demote_folio_list
>       migrate_pages
>         migrate_pages_batch
>           migrate_folio_move
>             migrate_folio_done
>               mod_node_page_state(-ve) <- second decrement
> 
> This path happens for SUCCESSFUL migrations, not failures. Typically
> callers to migrate_pages are required to handle putback/accounting for
> failures, but this is already handled in the shrink code.
> 
> When accounting for migrations, instead do not decrement the count
> when the migration reason is MR_DEMOTION. As of v6.11, this demotion
> logic is the only source of MR_DEMOTION.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
> Cc: stable@vger.kernel.org

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

