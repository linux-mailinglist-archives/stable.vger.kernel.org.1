Return-Path: <stable+bounces-223427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLjqC5Y/rGkinwEAu9opvQ
	(envelope-from <stable+bounces-223427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:09:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34222C525
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EEA830293F5
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6C3A2555;
	Sat,  7 Mar 2026 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="tWbuLXLw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529628C874
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896145; cv=none; b=aJbxUvxbhNEH5K7f0F+xrO85V8WlEHkblIJNwCp/lLCVBHtQ3cafpTGNPe6GZOAwvmVdhRsPecROAwBs5kl93yjVHSD5p/h5IcXBfOeI7iBozMNS3joh8i2l6iq/Qxhc7MxykhQNU1rvr54CPl5S00Db9wLxveXsLJXUfVkre6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896145; c=relaxed/simple;
	bh=Kf20q3KKi+xM3qNss1cCgTlfjVY+Zi/cdmEhEb/OiyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvPw5suhaBfaC+7lZ/dF20gab7HVAnnf9oxuHzLuFIiPmv3L6wrE/H9QQpzEjdRjW6xhDY0K7F8jOn4pEAtilEHJ5kZtJw0ZoelPQTisRLIBynSyVuiBjoggNiKTejH3Su8cMgZTsrw8y6Y8E7KTiaFX2tc1JgdOtq5crq5B1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=tWbuLXLw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae46fc8ec1so46733675ad.3
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1772896144; x=1773500944; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7B+3R/eVcF0a4VFyKy9Mj+9RSgZdL4bns+9ocGpr2c=;
        b=tWbuLXLwgkd9q2RaAt/EUrPS6FS+oWLn3rYIqLMl71DyKAeAAsnW001HrIGVyZdtNp
         9ZI4OcrQGxkySHuey1cPMDU4hqiaVQqsUSp48N0AZzXUuTCJySDgX1GjKfpQY628S/i+
         x3UJNNqOGKWoPlns70GH5eQyISEv2FVL6Q29A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772896144; x=1773500944;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u7B+3R/eVcF0a4VFyKy9Mj+9RSgZdL4bns+9ocGpr2c=;
        b=ALnPgLVLpyP13TGHMJ0F/1+lYFmdZa7z+7w1Bfnux3vn0HcYc1jOiO/qQU1nrtfm0U
         Ueg/bY2YBhF6+wCfs3YIlYq19A9VJKcl+xrjhKzhLZewwXL9FPKwZmCKSOY6u4A+eNli
         9bc8CfU2sru6fk+K8R1aYHZbSgYHbnv+YXDI9cHEwM8z2SXINatxRoXpHED+lfdV69WE
         /nUs1ZpmYoTogaNRb0dYDmWN2ajQNNIYvj5VH895V9fBm9k9eQ6VWTEK5SFvqjGHwbdm
         utYkGyoJL8+6BG5erVvTOEihiQ68sRg0BmuF8kFlDECvoomGBq4qiIjKSr91Zdn/C8zt
         UTEw==
X-Forwarded-Encrypted: i=1; AJvYcCWyXTGABdAADTtWR8McaEJEiH5BTKdVQUIKOD/W6vo+/RCWZFHNBOe5KqWuctmFcwYx/zyLhyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNkG8RhgZ+24/Zaygo5VR7IqvshduLhhdIha3VqQ9j0fFiNlS
	yvWARo1COGoIuZYJxDhjd+SjlAKSl0tutZcZd1OMMnKwTI72MGRj4gn3ngdUfAfPKxoJsuecPnE
	YQGAGOXFfDw==
X-Gm-Gg: ATEYQzz6t+XK6BxJw9+88Qq3lHEmptQXknFgJXXl/t8PTg9mXDWeOJEfD0FNtBJOGvh
	kIBzLTnytr5dFVe6mM+MY8/fCeU6XTv+AsjXsQywBIN51tWwOLPCqExck3sr15qsEGGiJAn8c3o
	zV14Kso8GGsveGzhMv6DCFQ23RwFaUA5pitEbRXYX7tBqbpRCReVPMVMt8SMlw/U/rV6qZiwleS
	LUHWrEPFw9Hr5V35XijMbQjKmgRoMLzQ19ZBMwAo0v4teZ6jwJ5xqI5SK8pssaDfkyo7DOV5MWD
	5VTIDSBgWC4jLbt+RfsidhlB9eB+v5l86SP+J2b1stlXcfPR0NSXkdQc62iy+LOsn7xc0RpbCGP
	IqRvDpPeetS+yRnJQkae5WtV19wiqij6u78ffNFRaR7xFb/xxeE0HMBiTR6MMNDWm7JzCkcA3AA
	ErMXgCl/jHX8nYrWDHDqE=
X-Received: by 2002:a17:902:ef46:b0:2ae:3b36:23e7 with SMTP id d9443c01a7336-2ae82398d80mr56455605ad.16.1772896144073;
        Sat, 07 Mar 2026 07:09:04 -0800 (PST)
Received: from localhost ([149.28.151.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8baa3sm58418835ad.65.2026.03.07.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 07:09:03 -0800 (PST)
Date: Sat, 7 Mar 2026 23:08:57 +0800
From: Chris Down <chris@chrisdown.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/huge_memory: Prevent huge zeropage refcount
 corruption in PMD move
Message-ID: <aaw_iU38qvIrNGAA@chrisdown.name>
References: <aaBVz7eb6-VBCvaz@chrisdown.name>
 <6147cf80-9d02-4c5c-ab81-8cb9b00044f0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6147cf80-9d02-4c5c-ab81-8cb9b00044f0@kernel.org>
User-Agent: Mutt/2.2.15 (2b349c5e) (2025-10-02)
X-Rspamd-Queue-Id: 7D34222C525
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chrisdown.name,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-223427-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chrisdown.name:dkim,chrisdown.name:mid]
X-Rspamd-Action: no action

David Hildenbrand (Arm) writes:
>Please squash that patch directly in #1.
>
>It doesn't make sense to leave something partially fixed in #1. It's
>been completely broken from the start. folio_mk_pmd() should never have
>been used.

The reason was to make sure that in theory the correct trees can be updated 
based on Fixes: for each. But I agree that it probably doesn't really matter.

>
>Apart from that, the end results LGTM, thanks

