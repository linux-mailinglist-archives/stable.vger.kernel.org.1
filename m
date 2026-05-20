Return-Path: <stable+bounces-250022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNMVNiroDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112B592B7D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 522CE358BD64
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE5352030;
	Wed, 20 May 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz3fbk9c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F4345CBE
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292820; cv=none; b=PSYvZI59xDxxLHJIdtS+Fg5xKXF3j8gMpfcA1Ib3lufvTCe8mrgkunUPxV2xcE32qXrC56K6+hQeUQ82an++GdArMwKVvhoqDcjjaTnxHVhXWF6W9zi6qZAcFIbb7Egd3Etqf4wreSdXRgO92JX1b3YFcO6afOsSIN10luWIiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292820; c=relaxed/simple;
	bh=0KHnLGELU+7pMiO62FEG+LzHx86K6KaWCewfhA5dFw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQX60kUPqLnRrB1NZZTtUUJyFf6AfCMbVLd3CI9dsBZyuh2Y8a+maN3G8sZQqTQXRGF05QtD6IJsFLGLkQmddyrsLM6dC455vXIqwbM5r7hI80aJXia9Uh4j8u3bZtVfnjIWSb0lJsx5WHl2FjMVajO1aEi4Jq7fdTzCWn6/hts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz3fbk9c; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so4354729a91.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292818; x=1779897618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KHnLGELU+7pMiO62FEG+LzHx86K6KaWCewfhA5dFw4=;
        b=lz3fbk9chOm/0ulyyFUG2MKoiR2XoAJQm6mL85IAcvzRBI4iCi/w7pytZPDqpcYukH
         V98EbYrhQsG1umraKjquJmjmhGLC/2UQwAl2a6d4DvU52y5nNM6alfyb0wmW6rghW74o
         hoYzLCqYn3vX9dmoWxESdbJvvNDmW9Xcd+H9hUe/3DVovZXNmS63zTTw98GdXEMu/m3I
         OgZOVgtNnRVP+mzE4UyFYZCR7EiGzOR18hdeRZchl+7P7nvFzaPrrLzYI/uHfDfZ4SlI
         x1/6kPKUCPEw+flqDz3MWpSCWCElnAwahmg5se+mrgjME/lVqkIjuZXiPyZBK5y9ncg3
         UFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292818; x=1779897618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KHnLGELU+7pMiO62FEG+LzHx86K6KaWCewfhA5dFw4=;
        b=TeJVyINeOdira7mMRRN0byCux64QFE4t238z1XW8nJ/Fljo2zGH96Twow5UsOVT+vk
         dlYtrKcufWY6Vddb9lSOzupdH+h2CIjSi2T8Fci6Kxql5iraKk830Tpk4nerP4FrfcNC
         JBOcK/CXUgWH24WDtIWATCj0w7v0l9RLREmjKDL2ns66GBhIQl3YarZ1cSmv7yySb2nS
         M4IIboA9ldXpBAnXBxKq7yZ6wu7GXPORYvDAmVcUM2Mzdb3n4CriSEiyx9KBvhQL7noU
         GgN+bY6vf9tUU8iKIBN1RPtYYzpqr7wMPxZroyhPaQZtYB5xi8JYP0sGztkMQS8kBjfJ
         gD1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9pTna9eTJHeKy2uL4Du5093TDPOqM8ehJhj4SGrJ742WZAg2o61YQaxuMfoSUjtdzeSOoq3Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WHb3c6C93CQMw80zXQe5L4wPpPHG+w3GwlhTFi2y0HYzlofo
	K3LgDj2AHwV9zDkRMIJQ5yQsfa79+f2oqE8/ukDHUtFvduZ5pAWZyST9
X-Gm-Gg: Acq92OGZHGwu8VjW7n+d1Jz7O3g2MVTTJYKkuJlumrRY033o32BBQkm/kqyv5NUvRkq
	nbEYpKEsdysiIbNYpBXaGMRo16BzQNcYl+PBymYrDmu4g+HJX/ubUwdPJt7OCRwoDBinhptvGWb
	1ps2NLvNR92MCra3FsLunHLiBF3tvBVW80CEgQZvyPWpArdchUVrqaXrLNVoF2YJbJuyKrL/rMS
	ZMW4z8/jC+gZua8G06BL4qcwIxkiOJGlarz46l9QgtW6VBIBBoAmphRkFwsu8LkPpm41LHC8CdR
	VXo6Acx7SehXKX0yEnrvpYVGr+Sy2T7YWXC12LCA49wzAr6/6Rbix2msVXiDx/1J6V+2xTIsLB6
	zr9bNEYBXInsAYL+2gQ68YypKvwHUG5lr4VuZNWg25zoNvjzQ95OrnTS+gSpVcc5h/9nE0vZxNL
	gEmS8RNhVcxZB7MaAndrAb
X-Received: by 2002:a17:90b:5904:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-36951c9f53dmr25356929a91.25.1779292817925;
        Wed, 20 May 2026 09:00:17 -0700 (PDT)
Received: from john-p8 ([98.97.43.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2dcsm223753765ad.13.2026.05.20.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:00:17 -0700 (PDT)
Date: Wed, 20 May 2026 09:00:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 
	2045gemini@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <2bojhuplzmn2cmofwusp72nds54usdcvk6agypz47ooninegye@rydeh4wwhvuq>
References: <20260520102715.3033936-1-rollkingzzc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260520102715.3033936-1-rollkingzzc@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250022-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6112B592B7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:27:15PM +0800, Zhang Cen wrote:
>SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
>with this bit set are copied before data/data_end are exposed to SK_MSG
>BPF programs for direct packet access.
>
>bpf_msg_pull_data(), bpf_msg_push_data(), and bpf_msg_pop_data()
>rewrite the sk_msg scatterlist ring by collapsing, splitting, and
>shifting entries. These operations move msg->sg.data[] entries, but the
>parallel copy bitmap can be left behind on the old slot. A copied entry
>can then return to msg->sg.start with its copy bit clear and be exposed
>as directly writable packet data.
>
>This corruption path requires an attached SK_MSG BPF program that calls
>the mutating helpers; ordinary sockmap/TLS traffic that never runs
>push/pop/pull helper sequences is not affected.
>
>Keep msg->sg.copy synchronized with scatterlist entry moves, preserve
>the copy bit when an entry is split, clear it when a helper replaces an
>entry with a private page, and clear slots vacated by pull-data
>compaction.
>
>Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
>Cc: stable@vger.kernel.org
>Co-developed-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
>---

The bot reports are smaller fixups that we can add on top of this.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

