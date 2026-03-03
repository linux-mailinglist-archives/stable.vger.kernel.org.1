Return-Path: <stable+bounces-222800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBXFDjqBpmmIQgAAu9opvQ
	(envelope-from <stable+bounces-222800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:35:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDA1E9AAC
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1C09300E48A
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015830DEB5;
	Tue,  3 Mar 2026 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YGFpOupD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B991E230E
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519730; cv=none; b=dV9VyZ7YozYHL4km1uUQv3KuV0GBw2n9jwgdf1VkwmvgPdV+q14lYv4Kp7VKKjJV5Vu4ATxZNgXiEek1W4HFkVnzUIOLJ4a7eZKOjrszfAvZNSxAzYK7wm2MxVT5fO2MPnVyy3WvJQVbfSM6oGoZ5s4urf/53mcMZsrlHvO2yoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519730; c=relaxed/simple;
	bh=/Pb6lNGmSMtcS6Of5xQklO7j7IiBptoBwPkvBadinsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgrADW1KVRCUyEwVT6S68NwHlUEJHqK7VykRcMWOkc49Jreha+ixbQIDDnlaPVZrph4ljQzOOXEcc7Xgj7fNuL9ojNQjveJQNrSzz4rZtyn5dNjCxswPQMfcRUBtn8ElgFufWYG1AN0b1eBxyxMd6+5d0CGghxNs+yT3Ag6mxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YGFpOupD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so34873435e9.3
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 22:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772519727; x=1773124527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUSkuPvY82k3KLm+9/QEOe33rPGxe020jA9cRJz38mo=;
        b=YGFpOupDiJPS91C2aAjCKSEWOqpv4kmbtV1lDADhvXttpE6//wAJ9W7k2qgBuY8ey2
         f3OdUKjdc0Kh1ZmZ/qC9H9t0qEbkq90NvmQvVSt+BoBujE1XBHoZZArSc6wdWy4tUhwK
         fiDkz/+gh62QMjcXZMzsPaB//bK0kL2lRa6HY26+jV+asedpPaO16GWQzy+AlPJcafXP
         /lQ9Hw2itw6oArivfexBn2kD8ZXL44wTbvmI1xj69631Gdt96Ht7R4HzrJWfMWckzAY0
         sEkSKBQ6Vr7cTndi1cnSNI0Q+tfvXqqGIfka8a0YWC3+o6EmIB9ycUeU9dLn4SwuFCYP
         RQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772519727; x=1773124527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUSkuPvY82k3KLm+9/QEOe33rPGxe020jA9cRJz38mo=;
        b=g/0A2JROZ5XIMRu7sff+qZs2YLfLOkJgg/MyeX16v0ew6bRdxS+zQJN7ESrCQ1v81z
         BTDwwBHg5RyuK82HJW347+E9rPm5n+999XXdoiO/Hw9pcgAtZKcGidnX28KJJvraXYGt
         w4CBn1xFyi63PwV+c9lhKWGyRLj4qIwK6PVRjDJ1xgknBo9TFp2FEgztHj6rQfru7VtA
         SX14eI3fu1D/Ugjq0wJmKhMfOWcmpP0Rh/SKMg7CRtt/U1O/ysSV2aWpHwswI8GJB6Ux
         VJ3YDLjxBABILj4mght4AdR7LGwX2apa1C3PVg1pmrWaiBFUSfJI2mExdSso4Cx4pJ9W
         dWuw==
X-Gm-Message-State: AOJu0YxpZ4pwKw/dyhITXQ77k2Pm55LrXtTWzDJn/7QH1TXNEahtakaC
	PPFEsvHKXaL2BTNaiMMy4csZbPFp2VHRL+qz9vh/x4i6w5G63ri3hL5me6e6WzfAR7FigNFESIH
	QyYmv
X-Gm-Gg: ATEYQzxj4tDYtbx8/SXkS6ueBj9k3aWI++9BPjjnAe5hSpEzPSjGvCQ+xim3s6eRM3o
	yi4/0+srYBDIjvZjt9cJF7wzGDOK/qnThrh+BV9Tb+y44gvwdq2tz+pLSlRp5kY3qXGxFeivEwb
	flcZMXNpGsbfUQWPiHPYgrFcJ3O+NlqTOxPgrvGbEsybdmnvLxXMlbR1WUMbn79VBeyN0F/5teh
	1APMQp8FmgJIz+VIkeDY4ui1WSGxSWVIVxUo9+aTdZUF0XHAw7fOxxVBoi0JmvkskVM5YxfVPsN
	kqLPOV61miwwg6gz9XxbUS4dpTrt7lZl8i3/YKw4xGMaPgr+oNiz3yC8XgrjMtKHb3tOx6J3XFo
	HzaajMcFdI1H02nfNz+h+gS3QBIb8CIahgl1J+gcuI2akrj4IZHQ4gso5ZHHh9yFJnu/wDUCcrV
	65b/w3ha4cY7+ax0WL578=
X-Received: by 2002:a05:600c:4715:b0:47e:e7e5:ff32 with SMTP id 5b1f17b1804b1-483c9bfaf59mr224122465e9.34.1772519727503;
        Mon, 02 Mar 2026 22:35:27 -0800 (PST)
Received: from u94a ([2401:e180:88b0:32b4:4c71:af95:b813:9623])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm5134267eec.14.2026.03.02.22.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:35:27 -0800 (PST)
Date: Tue, 3 Mar 2026 14:35:21 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6 6.1 5.15 5.10] bpf: Forget ranges when
 refining tnum after JSET
Message-ID: <s37ibmgu7j3whdmfsujm2n4xh74353ynaoohqbnnrycu4el4v4@fhzhuv7viajz>
References: <20260303055716.25158-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303055716.25158-1-shung-hsi.yu@suse.com>
X-Rspamd-Queue-Id: 3ACDA1E9AAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222800-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,linux.dev,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c711ce17dd78e5d4fdcf];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:57:14PM +0800, Shung-Hsi Yu wrote:
> From: Paul Chaignon <paul.chaignon@gmail.com>
> 
> commit 6279846b9b2532e1b04559ef8bd0dec049f29383 upstream.
> 
> Syzbot reported a kernel warning due to a range invariant violation on
> the following BPF program.
> 
>   0: call bpf_get_netns_cookie
>   1: if r0 == 0 goto <exit>
>   2: if r0 & Oxffffffff goto <exit>
[...]
> [shung-hsi.yu: no detection or kernel warning for invariant violation before
> 6.8, but the same umin=1,umax=0 state can occur when jset is preceed by r0 < 1.
> Changes were made to adapt to older range refinement logic before commit
> 67420501e868 ("bpf: generalize reg_set_min_max() to handle non-const register
> comparisons").]
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
[...]

Verified that BPF selftests still passes[1] on stable 6.6 when this
patch is applied.

1: https://github.com/shunghsiyu/libbpf/actions/runs/22610140079/job/65510741498

