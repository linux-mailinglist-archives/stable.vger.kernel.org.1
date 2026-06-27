Return-Path: <stable+bounces-269418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sbd/Orc1QGqFdQkAu9opvQ
	(envelope-from <stable+bounces-269418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 22:42:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4876D29C2
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 22:42:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=NHaOIZ59;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269418-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269418-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8AB9300AB02
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2B348C66;
	Sat, 27 Jun 2026 20:42:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D62EEE7E
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 20:42:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782592944; cv=none; b=T0MI1lkb+ARKzivX1NvBMGFRrs9i6kscnbxI/sSQ9j7oG5/ZuFTbkPvXWuUNIOpUFFTf4IneQjYO8G5zYC62GDrdDNiIsTliEaHeImiAIvm9LSX+p7HBESbNpX9xaPclE22yjlzRXXB0i2b8tbZnDrN9khrufXeLnAHFLQVLQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782592944; c=relaxed/simple;
	bh=7vb4snxpMOpyUr0gr4AhCLWmvUzZ8GqvNt/munNwM6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z03lA61+0VZvkoUjMZ5wSsgVtsKP/dk9FK1whb4FMHjNcJNrM4VKD8ORvLIOZsXev6r57D/rnlbqOpPevPobtqRmuyi9alZVhUj76UZtIFP/W9DgLFe9L2Kg0ax2egbL4v+T3Er+V6yYH6ER3zCRrYF6Nmf00Yld011CsR+L7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NHaOIZ59; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92c7a0a7059so66798185a.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782592941; x=1783197741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvBTXqN1MAazPmYZrbZsf15Ac2BOg/NxzUUoaLCPN5k=;
        b=NHaOIZ59u8gKxw7npgJ6bR4dLFwGJYTa+D2IEvUChuZhhRbtlxjFVaihWazirK8tqB
         h0e2mZHv3rb4GABo7X4d3muhLOPW+4bCmgqYzinavKkC0t8mDSHPYeZfW5yUftcGxNoA
         e9KvQXhqzNgpWFYypJHlqUT9p7d0+18DERE/e2w6Ds95+pZTYAjpSlxfomUR5IQcZ7tY
         WOai7NFh1FZROUmTLeFrCdvTYILzrsfCL+/wEOwUzNLXm7bD3LQ+1K0jC/B0w/rRRQKZ
         3BgJUdk72ayOSAQsAo50s4MqJj4IzrwX6IRjB3QB/cJSTmlP25+7+CGgKW0ftyltfmdH
         /30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782592941; x=1783197741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvBTXqN1MAazPmYZrbZsf15Ac2BOg/NxzUUoaLCPN5k=;
        b=QnTTCuJg9jVjR9WkjPXNnIg5Jp0t+dxvI45Ikz3ocIuGijLGXwxFGPrtSgyIWMdWww
         Lv0yAEc7f+cCD1irzqSnbQSLk5+6YnrVLr628W/joXTGcit/8euRJi0M+75cMUH0ljZ3
         uC2NSKtN/I0/28nUfFTfL/kzBR2LbbYzvIc56P6zFBveWyvj1ZLr0JVofjaEu5nqJv4d
         TdZltBLkhsYviL3dUCPQNvtBWG8jnGH6mNPDhWXy+0qbi+hRlmc20QZEeEl3zLvWmtcy
         7zsCO62nLgPjtHWs8dvSh1Tah5ivSN/aAjS5VzCtmdGAlpO0a83Qv7BMOMOvwVPxvQZA
         Hjbg==
X-Forwarded-Encrypted: i=1; AFNElJ81qFtRjNH1cOVyK10nbsDmRCOh7H/wJqMTardKVBH4bIvTW7T5Ix8IQIZq+rgxBPCBoUwnfdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSL4mgRo9RS/UCiXvYePPoO3f4CB3xF1de7Ii14AxZcppidbj
	C+ufxzRJTiyqA9l0N0GoQf7a+GJritxWhCg21dQ4EDkWsASZIhK8AOP2RCuQXStKy5M=
X-Gm-Gg: AfdE7cmuYzZWzW1b8tZiUheDBFJE5mWecs1OVvg6OX5CVEnqEoa7+Wu6/9iqzaej0li
	fRidrcIdi4+2jSdKEtapJxiWa0iGfDVDAkqUxZOtQSyJHbQDo4dQB2vAqsBiT7Woj7suykZy6A3
	bWEETV2toDdRjoLkD+lPiPQUqDlWE+tsqaW7Clt1P1TeCmXuOyhzc0OvGBO0ET8X0Wn3q0Ei7Hm
	6YxqEJCDJl5/m/FddZTUCoa3xsjWuaCAppxP35htCH0+oU7hPIdmWS58pAUP6LYBH/STOZ8fVm1
	q7W+lCceJZDEDIo+Hu97sO68VqY7aCzS67JCeg7dhuY9kAytpS2JJQoKYwyaG61+V+WTxkgV2xN
	2sDXVK6uALYS3Uy5YaBBwKb95DJQ/pVUe8B2GYnjFz3KbbExJX5prLryFxlYGDfSpFC5bzTlH6C
	/W6mBGVWtOtekpWvgOWJPP1YpgKjwYOsSAMQfdbRQOvDXLOy2f/0XOJOhUnAyyMfinZwJCn8KM4
	Nf1fBw=
X-Received: by 2002:a05:620a:2915:b0:922:2baf:d757 with SMTP id af79cd13be357-9293d4a105fmr1727191785a.58.1782592940972;
        Sat, 27 Jun 2026 13:42:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda626b9sm1585236085a.14.2026.06.27.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 13:42:20 -0700 (PDT)
Date: Sat, 27 Jun 2026 16:42:15 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, hannes@cmpxchg.org, mgorman@techsingularity.net,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: flush per-cpu node stats when a node goes
 offline
Message-ID: <akA1p_scgVk5FTmA@gourry-fedora-PF4VCD3F>
References: <20260627073107.523499-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627073107.523499-1-gourry@gourry.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269418-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:kernel-team@meta.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:hannes@cmpxchg.org,m:mgorman@techsingularity.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry-fedora-PF4VCD3F:mid,gourry.net:dkim,gourry.net:email,gourry.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E4876D29C2

On Sat, Jun 27, 2026 at 03:31:07AM -0400, Gregory Price wrote:
> A per-node vmstat counter is pgdat->vm_stat[] plus per-cpu deltas.
> A balanced counter can sit split as global=+N / per-cpu=-N.
> 
> The folds reconciling the split only walk online nodes, so when
> try_offline_node() marks a node offline - per-cpu deltas are stranded.
> 
> A subsequent online zeroes the per-cpu area but not pgdat->vm_stat[],
> orphaning the +N permanently. All NR_VM_NODE_STAT_ITEMS are affected.
> 
> Flush the deltas before the node leaves the online set.  A remote
> fold races the periodic per-cpu fold, so do it as per-cpu work.
> 
> Discovered when a node/compact call hung for a nearly empty node, as
> the math to determine throttling broke. Reproduced by repeated memory
> hotplug/unplug cycles on a node under pressure. NR_ISOLATED_ANON
> ratchets up and never returns to zero.
> 
> Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price <gourry@gourry.net>

Realized I changed the title on v2:
https://lore.kernel.org/linux-mm/20260627073107.523499-1-gourry@gourry.net/

Core issue was the zeroing at online time causing the skew, just have to
do the fold there instead.  disregard this version please

