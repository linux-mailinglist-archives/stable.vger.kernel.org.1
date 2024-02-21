Return-Path: <stable+bounces-23218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C36D85E536
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505881C22C48
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C085290;
	Wed, 21 Feb 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dw9QOaVX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yvPLzN+C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dw9QOaVX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yvPLzN+C"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A81584FD8
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539006; cv=none; b=cNSFSlECzlesze8E2+JDQQliIc1JGtwzQ3JfM0PsRJqLRp0JdVIC4wWXS6F+mwbhTLByrDKB1XbWTd+TV5o/0q5GNi6wEJqY3zY0MOPJ7U7Vy2awoHxBKs2K2pJUuyhtPusc/lkkQwAfyMzMA+0+xWqmUch5ZCAE047TW5qzmPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539006; c=relaxed/simple;
	bh=2+kVNHAHsIuxSBXeGhtXwbU0TOuPFPt4KOWV4NGD5HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk2YKAwmSk4TV6tr5jfkUT/IMu+Y4hODXPi/4pK8wbCIcOSSWv8vFcQg9oYvRxqZxmd7zsB/QGKrXw+94OIyQk+v83dCnvL93qZGIWNFa+cj3+hPtwHTqxI6ZI3fuqO+aAAhudvi4YeVfAU1xW/aPBS+Tctc9zIE6iiDHpYVyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dw9QOaVX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yvPLzN+C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dw9QOaVX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yvPLzN+C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F156E1FB70;
	Wed, 21 Feb 2024 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708539003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzzjj3gl49W5O8rI1lFVyAcgwqmiKgTRuLT+x3R/84g=;
	b=dw9QOaVXOQPZ1UAef0HZTeqBGfQQ+n8M4yF7q4RnhhzsRymlfpC0n1WzkpFEmlCx2piL8I
	fndlyNXI9Ef0hzRMzceOYR8gmiLi+9x473F2EtW2jGJ6kXLDg/N1SkadQ2QlYi+rkvy6n3
	AzgQxHX+YPUngTJvETYmQn/YHFzYsmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708539003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzzjj3gl49W5O8rI1lFVyAcgwqmiKgTRuLT+x3R/84g=;
	b=yvPLzN+C5vfwSG+v7Xo7DxBlUjPimwi7dSk1dfLKdmPb+FulUzQJca4jja6cYQ0CKQKG7l
	a+Q28GEyBzWQPQAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708539003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzzjj3gl49W5O8rI1lFVyAcgwqmiKgTRuLT+x3R/84g=;
	b=dw9QOaVXOQPZ1UAef0HZTeqBGfQQ+n8M4yF7q4RnhhzsRymlfpC0n1WzkpFEmlCx2piL8I
	fndlyNXI9Ef0hzRMzceOYR8gmiLi+9x473F2EtW2jGJ6kXLDg/N1SkadQ2QlYi+rkvy6n3
	AzgQxHX+YPUngTJvETYmQn/YHFzYsmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708539003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzzjj3gl49W5O8rI1lFVyAcgwqmiKgTRuLT+x3R/84g=;
	b=yvPLzN+C5vfwSG+v7Xo7DxBlUjPimwi7dSk1dfLKdmPb+FulUzQJca4jja6cYQ0CKQKG7l
	a+Q28GEyBzWQPQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB05113A69;
	Wed, 21 Feb 2024 18:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PtzZNHo81mU8NwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Feb 2024 18:10:02 +0000
Message-ID: <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
Date: Wed, 21 Feb 2024 19:10:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/bcachefs/
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Jiri Benc
 <jbenc@redhat.com>, Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh> <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2024022155-reformat-scorer-98ae@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dw9QOaVX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yvPLzN+C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.84%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: F156E1FB70
X-Spam-Flag: NO

On 2/21/24 18:57, Greg KH wrote:
> On Wed, Feb 21, 2024 at 05:00:05PM +0100, Oleksandr Natalenko wrote:
>> On středa 21. února 2024 15:53:11 CET Greg KH wrote:
>> > 	Given the huge patch volume that the stable tree manages (30-40 changes
>> > 	accepted a day, 7 days a week), any one kernel subsystem that wishes to
>> > 	do something different only slows down everyone else.
>> 
>> Lower down the volume then? Raise the bar for what gets backported?
>> Stable kernel releases got unnecessarily big [1] (Jiří is in Cc).
>> Those 40 changes a day cannot get a proper review. Each stable release
>> tries to mimic -rc except -rc is in consistent state while "stable" is
>> just a bunch of changes picked here and there.
> 
> If you can point out any specific commits that we should not be taking,
> please let us know.
> 
> Personally I think we are not taking enough, and are still missing real
> fixes.  Overall, this is only a very small % of what goes into Linus's
> tree every day, so by that measure alone, we know we are missing things.

What % of what goes into Linus's tree do you think fits within the rules
stated in Documentation/process/stable-kernel-rules.rst ? I don't know but
"very small" would be my guess, so we should be fine as it is?

Or are the rules actually still being observed? I doubt e.g. many of the
AUTOSEL backports fit them? Should we rename the file to
stable-rules-nonsense.rst?

> thanks,
> 
> greg k-h


