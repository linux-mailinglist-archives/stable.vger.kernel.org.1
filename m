Return-Path: <stable+bounces-230227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLgfNC/xwmkdnQQAu9opvQ
	(envelope-from <stable+bounces-230227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:16:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF831C350
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421BF303CEA9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619CF3358C2;
	Tue, 24 Mar 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="SUHZL4aY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19233509B
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383272; cv=none; b=C6ezWfavCwWUZCfBXSQV9uu91AiJ5s5ZZa8i2dxcphVUOKKk0csCCzaw20H7nouu/kQc8y+oY1jDh3hWzL144+GgxuGE+z5jcqJHAeFjdBHhP4Rf+1g9y+ZzG2Eed5khvjWm2Hjs36nUc0pHU35i5kzLMosWRJFjKzaUVLcUvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383272; c=relaxed/simple;
	bh=ejJ8WBiiXzLknFE5MeSm9cbu5Y9/2HuvAnkw91kSo4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4m5kCVr2UcrM637eLb9Y1JDx8IucKEqQ71mq/qZ4fpeVMAoXRqFZJpbKXVyQ85GtlB89iijh0rO7Uqosl4Bp6vAh+mgLspSNUgjEwoBpIjNLoJBelY6fgSs8GoRiKP/OYnp0gkvie4awk46bFq5JYf8tKcMfIpauTE2+bCcjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=SUHZL4aY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79853c0f5b9so38154947b3.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1774383270; x=1774988070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pj8+8/JJ7h3b7BpKS3uF06MRnM+qUNB5Mr/NDCOtqmY=;
        b=SUHZL4aYJFiBUJUj7K6RCNTlv+WZw8POOK8dcPVDU1Kooy9aPzUgdActFg/2EmGEv5
         88ZuUG4/wN34VJ9uAGBPO/JB3ZRnrAM4qIAnDZLMRkQkCuH9JiwAzTeAAIwLCzrrn01O
         gUtDgRqXRqAsDpOTgZ5EV13HCJdrFShFJ63pV3DvFi2rmo37UF08LAn7YkOvDJWtC/PS
         kzjYv2HNtRRH6NaiCEZGsejHgw1s9aWr4IOV1NeUcbf3KE8jLhkvlXJRMH9D9uJ1wGJ/
         2rIgmmT55NJS6eHDrvBuepPo60DgaOZ1ZOGYtL/gkYXJY6zxw918CIHsuD64LwPvrutO
         s+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383270; x=1774988070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj8+8/JJ7h3b7BpKS3uF06MRnM+qUNB5Mr/NDCOtqmY=;
        b=lZeYiGOYjKB2eLFFaAqhtjuQXJ+KNKoC8rPSziVz0SdDpMiARCKn2zBHJp4R4n6nAz
         e0fo4SjzeumxMh9hsbmuSy12lFTfsGyM2h7lDD/+veCg+QR6vxRObc4gauPFOLuuzFiY
         sELhT08Ere5JAgn9DK2yN3ZLiW/BFKezfvUlha52H4k7b2tVYSN0haawR6pFLnnxu7U/
         deNApnG/lPvHQ3aau9Ir3FKxOXKRwgmcm46i9DMCnSdI02boFtt/ZkMggCv28K4X87mS
         ql2T1jHXMzv7lUSGK0j18agGEUF26mj1sfkV+Pcw1dLHLck4AnNygf7tRKiY3i8NQtT2
         b/1A==
X-Gm-Message-State: AOJu0YyxrzjhVEzFrKJErRU+9qx0gciaanPAoI14gsrLhdIjEZO6MpYx
	0tMHerKnht9YdIzsR593nAO+mcFDwoALSuPo6+7+/iRM1PccK/6S+JXptpDGo3GEANw=
X-Gm-Gg: ATEYQzxiZJALmnihX6cUnXpgoFyWTiYS3v0zTNDR8hmCNzcqjvrryiMms+Zrkq3W2FL
	GHeZ5hb8HiQlhs4wxcvalyKnhsCKjGh5+9ilfUHPvliGhV32tbLOKvxrOD2i9Q9wQYOPZh9Ey/y
	sKkCZpDW/h60NwB2E3AgrvqRzx/G6uePQCqdJh6cBPLO5DumbxJCbD+Yei00hTJB2zoiJorI5ha
	gKF3kmIyLissBymWqabiOKE7ls5rzmnixb9TuoZdB1sFOugLPuEXQmD72o6OKr98tlY0gSf8c43
	IbPSkMZewKZnoOB7w4/7vZR9qv5pgcnjVRbprR0TcegGHRn7DMnhsY4Eak5mlji+86Np9fW4Smk
	kx2dJgLVpVABfHP6hmwrQgVtULG8qIS37P2baz8GXrWpTTXr5blnC7WAliH9xMSTgP7CvKFBIFi
	tosRnfrQTGaKpvlHdFLsGEpsse
X-Received: by 2002:a05:690c:d89:b0:798:6042:12b9 with SMTP id 00721157ae682-79acf397948mr12408687b3.19.1774383269665;
        Tue, 24 Mar 2026 13:14:29 -0700 (PDT)
Received: from localhost ([2603:6080:7702:ce00:dabb:c1ff:fe4f:43a2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79aca5fef49sm9513597b3.30.2026.03.24.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:14:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 16:14:28 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260324201428.GA3698093@perftesting>
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[toxicpanda.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230227-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[toxicpanda.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[toxicpanda.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josef@toxicpanda.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 62AF831C350
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> We are hitting the following soft lockup in production on v6.6 and
> v6.12, but the bug exists in all versions
> 

Can I get this reviewed/merged? I'm hitting this softlockup hundreds of times a
day in production and I need it in stable so I can have it backported to our
kernels. Thanks,

Josef

