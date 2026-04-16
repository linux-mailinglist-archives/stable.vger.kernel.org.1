Return-Path: <stable+bounces-238348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDBjFfYl4WkBpgAAu9opvQ
	(envelope-from <stable+bounces-238348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:09:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F941399B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 438EC3044EC9
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F5330D3B;
	Thu, 16 Apr 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1kW9BuV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64772F9D85
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362994; cv=none; b=ENhNY8wgjG/icvL/6jV/rqpO/WEsYoh3t0Dnam0gnI06CZIpVVV4c6K+V4E0nzSOxAAPqf/5ck+RvcEa7XxyrHWwdpGd7LEhqlreP751GckSB6/L/wNCz+pbOq84YdJqJma7DXqHyGZpe608pX8hGJAoW+o3P/CTOqpvgoUVRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362994; c=relaxed/simple;
	bh=mmULvUuKrPnKvWEZawRe8RX1kO2oep14pfV0IVrHAo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBUeInPv8Q9qXMno+vl+B66xV6dYr4yDWurDr/xCZdSmKvi+oIqn+NGy0UWnSgBGJPwCyfgYNeiCIk6hnrqC1bWjFjGGGTXGepkTDiyeEIaG6uPKoUgl0PUUKxRLlMS/7XBg0bOPSCJc0fwzSxvn6Es515l6vFUYlBcf2/dsvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1kW9BuV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad21f437eeso6690825ad.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776362992; x=1776967792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6OK03PX0h3tG83iks1r+wGD2/ZrEzb1T+pdJSDsB8lA=;
        b=c1kW9BuVUOLVnVuqeSbqpI2/zS0EJGugOPwvNZ91VcZnrmPKqmhUWlO6PZMEzJyHXP
         zzVLZqVyJcjVepUcjUxRbgoYePHOwYgXXhpq208tFSylno/LdM6wTRpAzfqaqYCl0eHk
         cpu+9IjuZXfA4bUXfaV9N/KwINxkh1k2rR6eFgTVqgxt0wKNS3o/7fS8d16xODv1MoMj
         v8fSRhX/rj8Siqc2j1gtlnojzr2+OtW2smmad+iFU5C4nEQdoCMuWOLenfsXFqjDEzDu
         8Rmg4CJFt1IEFk2Ztpw9/ee15YEPki+0PwxjMjiFiUDV77yF6WHvMPl9QSMpf5nXEtFm
         BIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362992; x=1776967792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OK03PX0h3tG83iks1r+wGD2/ZrEzb1T+pdJSDsB8lA=;
        b=CQwMn2j0/qE3+5yJD11RyxSwgxr4YtATlLA2dxF/sqwlJrkVv9CwesXD72CYGBlLFC
         oCWOzF2P4y2DYDfRIpeWmdiiz61/pe5/LDF0YCAYemI88I+MW8XhqAjm9Ta7LCNv9mdB
         ohQG3ShcaNahqSDgvF/um9ZPhSMAyPHUJ0if3oanVk4TkOhwWX/+Cti8pi8pFnAKpzem
         laQ7mXUDr4vNumdqsUE1sAQpQt9SfFIKHO2oaj+PjQGaBjFdN26FXoGhw16sRnGiK/rN
         4+4uduW46IlDwbOwrHxpOVWRiopU09dnZy8bPCnJ+KV1tZXdcPU3lbhR1IoQDUH9YJgv
         MoHA==
X-Forwarded-Encrypted: i=1; AFNElJ8KYAIgH+a5lJZ2c6rUxZVQYgmMV9Qt+Jmvc8eohesCDmAWdaXlspO1z/pgwT1ugXUPpj7eEUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWVC2V77khvdFoARnIwdEwgknElnttyo27kfgadX83v74nZ4p
	zk9Oz3n9xGg/H3buykdn9q3fHqunhkNgHKoE4kSeC/yZGJ54NP5SRAhDMZUjaF3r
X-Gm-Gg: AeBDieunVU4OmwsTbXuBWzgEk794tRIBSbCQz72w7vuZ7xMdb4aVAsai+SxgLgH/z5p
	65jRX8mTumAho9ikduXBw6hwjb8vXBKJi1zSMPi2FKQYMEcKwJqipgBvZgsBLqpyjxEf7pHsoZp
	lcXSH0MdUUCUyNBXD2NW92ssl9D8tUsB/MKI6oBoU/+tLtG5hgDL1wXyjrPj+0q4qOBQeZATkhl
	dToV5xxZBFMJLSRJ3OUUlyU+KVRRwAwPFS58Mk74HOUVexOk7XHEUlibiy8JJJDkoRn8H97vhQL
	sLI18HvmQDEOPLdGuU5YQLJlbBT03jp5ufB0+938grjaW5LaI0PEt8Z0zUGv7sFSE7ClzFJU26V
	ocG89U9oqu03gc4NyVZamcvxEjXHJGX4FFXfLjY3htDoDoO3sUo5VjhoedrURaR7DwLbqD3ubcd
	8rAc70oYGj0WH8rLvJbkZ+fbAQ1rBXrD2bfHX1oyo9S3ozw1DlIkgFGIlnP8C4eF2tGQZHkv5nb
	hYw9JS2Ld7V
X-Received: by 2002:a17:902:d2ca:b0:2b0:506b:e6f8 with SMTP id d9443c01a7336-2b5f83b6fb8mr2735475ad.5.1776362992179;
        Thu, 16 Apr 2026 11:09:52 -0700 (PDT)
Received: from eric-acer (36-225-123-187.dynamic-ip.hinet.net. [36.225.123.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478291498sm61927705ad.57.2026.04.16.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:09:51 -0700 (PDT)
Date: Fri, 17 Apr 2026 02:09:49 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
Message-ID: <eil4aqkypndb3baws375muahkrpjkax3r4xzrb3fc7mavlsghy@nhq77wmdnz7r>
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
 <aeEi0X4Fn70bUgva@slm.duckdns.org>
 <aeEjvvOdQBNPdHA4@gpd4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeEjvvOdQBNPdHA4@gpd4>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238348-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,manifault.com,igalia.com,ccns.ncku.edu.tw,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB8F941399B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tejun, Andrea,

On Thu, Apr 16, 2026 at 08:00:30PM +0200, Andrea Righi wrote:
> On Thu, Apr 16, 2026 at 07:56:33AM -1000, Tejun Heo wrote:
> > On Thu, Apr 16, 2026 at 03:32:44AM +0800, Cheng-Yang Chou wrote:
> > > scx_bpf_task_set_dsq_vtime() allows modifying a task's dsq_vtime without
> > > checking if it is already enqueued on SCX_DSQ_PRIQ. Since dsq_vtime is
> > > the rb-tree sorting key, mutating it in-place violates the BST invariant
> > > and corrupts the tree structure.
> > > 
> > > In ops.dispatch():
> > > 	p = scx_bpf_dsq_peek(PRIO_DSQ); // Get a task already in the DSQ
> > > 	if (p) {
> > > 		// This illegally returns %true
> > > 		scx_bpf_task_set_dsq_vtime(p, 0xFFFFFFFFFFFFFFFF);
> > > 	}
> > > 
> > > Fix this by adding a check for the SCX_TASK_DSQ_ON_PRIQ flag. Disallow
> > > vtime modification and trigger scx_error() if the task is already queued
> > > on a priority DSQ.
> > 
> > If the user updates the vtime after inserting, the tree looks wrong but it
> > won't cause crashes or anything. Later insertions might get confused in
> > terms of ordering but it's a rather obvious user-shotting-their-own-foot, so
> > I'm more inclined to leave it as-is.
> 
> I agree. This looks like intentionally breaking the tree. If users do so, they
> can keep the pieces. :)

Ah, I see. I was just experimenting with some scheduler API combinations.
Indeed, users shouldn't do this if they want their scheduler to work
correctly.

Thanks for the explanation!

-- 
Thanks,
Cheng-Yang

