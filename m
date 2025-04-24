Return-Path: <stable+bounces-136612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0FFA9B475
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF77A1BA3C9C
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F416B28B4E3;
	Thu, 24 Apr 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwxB+nrq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzWdM6IN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwxB+nrq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzWdM6IN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910927BF7F
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513330; cv=none; b=baGQbvlQkVkXesefQijlqi//dN9MyczHxus/rqQji5oAA+Qhc1m5KyCH5idWp0zvARn6WN0UF9Du6eBZfHouloTgZGZ8kmmSMM7TdSSdjJWi5HZDmkSY9gWpgyxvIp9Z8J7KVHAe6kjlcYXqYmLBj/8QSCF6/RZGezsstjGCpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513330; c=relaxed/simple;
	bh=WEAmWmTyadq4tZy79KRqoMe5OHW2oj3tasUdeA9eBhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwILZULLOhK/lLxy5aBVuYtOA54yd4nevFI0WrJOAkydHN799/qNLiDOMn9l9dEepFid5NbfqaXSWNaSSS72LllCBa7G4iROSW0tf7bKXu6jq9IlNF8Z0vvjihpfCaXj2iO/yFGJAZaFQg/vEqMl7lo9vueB+lq1ZEoooD6qOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwxB+nrq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzWdM6IN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwxB+nrq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzWdM6IN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B53351F443;
	Thu, 24 Apr 2025 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745513326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZ3/IkNkXWt3JF1YRfJFrc9hUTOhCPhBfi9idPBI0hc=;
	b=hwxB+nrqgFLbt/mPUj8I3mD48TymDWR55/i/kYwf4N34sJP0zwFkt6XanIlxrQh3WWZxaG
	o1WcjfIQVtnKNvpcbtHamURYGMhxvAFDP2JCQLsFSHfWFEUN5UVkEV2/svil4dXxzpPppa
	fcNUWoRMt+RMWui6Qk9p1YyjJZImZJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745513326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZ3/IkNkXWt3JF1YRfJFrc9hUTOhCPhBfi9idPBI0hc=;
	b=gzWdM6INLMsdZzL3ucZSkuxBh/8Uzzu0XO7KfSYzhZejEoFrtAAnDgpIWUyPuSfCrmaCNl
	gmK0J0vtoC2w7hCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hwxB+nrq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gzWdM6IN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745513326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZ3/IkNkXWt3JF1YRfJFrc9hUTOhCPhBfi9idPBI0hc=;
	b=hwxB+nrqgFLbt/mPUj8I3mD48TymDWR55/i/kYwf4N34sJP0zwFkt6XanIlxrQh3WWZxaG
	o1WcjfIQVtnKNvpcbtHamURYGMhxvAFDP2JCQLsFSHfWFEUN5UVkEV2/svil4dXxzpPppa
	fcNUWoRMt+RMWui6Qk9p1YyjJZImZJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745513326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZ3/IkNkXWt3JF1YRfJFrc9hUTOhCPhBfi9idPBI0hc=;
	b=gzWdM6INLMsdZzL3ucZSkuxBh/8Uzzu0XO7KfSYzhZejEoFrtAAnDgpIWUyPuSfCrmaCNl
	gmK0J0vtoC2w7hCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A01139D0;
	Thu, 24 Apr 2025 16:48:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bjg5JG5rCmjFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Apr 2025 16:48:46 +0000
Message-ID: <da89dcd6-9369-4a87-9794-a0bf5772509b@suse.cz>
Date: Thu, 24 Apr 2025 18:48:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, slab: clean up slab->obj_exts always
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: cl@linux.com, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, surenb@google.com, pasha.tatashin@soleen.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 quic_tingweiz@quicinc.com, stable@vger.kernel.org
References: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
 <aApoFXmDE-k2KFFV@black.fi.intel.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aApoFXmDE-k2KFFV@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B53351F443
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/24/25 18:34, Andy Shevchenko wrote:
> On Mon, Apr 21, 2025 at 03:52:32PM +0800, Zhenhua Huang wrote:
>> When memory allocation profiling is disabled at runtime or due to an
>> error, shutdown_mem_profiling() is called: slab->obj_exts which
>> previously allocated remains.
>> It won't be cleared by unaccount_slab() because of
>> mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
>> should always be cleaned up in unaccount_slab() to avoid following error:
>> 
>> [...]BUG: Bad page state in process...
>> ..
>> [...]page dumped because: page still charged to cgroup
> 
> Please, always compile test with `make W=1`. Since CONFIG_WERROR=y this
> effectively breaks the build with Clang.

I don't see why, nor observe any W=1 warnings, can you be more specific? Thanks.

